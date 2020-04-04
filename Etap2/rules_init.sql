/* 1
Zmiana statusu zamówienia (update).
Opis: przy zmianie statusu z  “In Process” na status ”On Road” RequiredDate (wymagana data dostarczenia) zostanie przesunięte w przód o 1 dzień.
Zdarzenia inicjujące: zmiana statusu  z  “In Process” na status ”On Road”.
Warunki uruchomienia: kiedy dochodzi do zmiany statusu.
Działanie: RequiredDate zostanie przesunięte w przód o 1 dzień.
Szacunek złożoności: dla każdego update gdzie status zmienia się z  “In Process” na status ”On Road” .
*/
CREATE OR REPLACE TRIGGER reg1
BEFORE UPDATE OF STATUS ON ORDERS
FOR EACH ROW
WHEN (NEW.STATUS = 'On Road')
BEGIN
	:NEW.REQUIREDDATE := :OLD.REQUIREDDATE+1;
END;


--Test:
SELECT STATUS, REQUIREDDATE FROM ORDERS o WHERE o.ORDERNUMBER = 10420;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10420;





/*
2
Zwiększenie limitu kredytowego konkretnego klienta o 100 po dokonaniu płatności (insert).
Opis: reguła służy do zwiększenia limitu kredytowego klienta po dokonaniu przez niego płatności.
Zdarzenia inicjujące: każde wykonanie nowej płatności przez danego klienta.
Warunki uruchomienia: dokonana została nowa płatność.
Działanie: zwiększenie limitu kredytowego klienta o 100.
Szacunek złożoności: dla każdej dokonanej nowej płatności .
*/
CREATE OR REPLACE TRIGGER reg2
AFTER INSERT ON PAYMENTS
FOR EACH ROW
BEGIN
	UPDATE CUSTOMERS CUST
	SET CUST.CREDITLIMIT = CUST.CREDITLIMIT+100
	WHERE CUST.CUSTOMERNUMBER = :NEW.CUSTOMERNUMBER;
END;

--Test:
SELECT CREDITLIMIT FROM CUSTOMERS c WHERE CUSTOMERNUMBER = 103;

INSERT INTO payments(customerNumber,checkNumber,paymentDate,amount) 
VALUES (103,'NEW236336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);



/*
3
Zmiana stanowiska na “Sales Manager” (update).
Opis: reguła służy do zmiany stanowiska na “Sales Manager” jeżeli osoba po zmianie ilości swoich podwładnych ma co najmniej 5 podwładnych.
Zdarzenia inicjujące: zmiana ilości podwładnych(dodanie nowego pracownika)
Warunki uruchomienia: pracownik musi mieć co najmniej 5 podwładnych.
Działanie: stanowisko pracy zmienia się na “Sales Manager”.
Szacunek złożoności: dla każdego pracownika któremu w danym momencie zmieniła się ilość podwładnych i ma co najmniej 5 podwładnych wykonaj update
*/
CREATE OR REPLACE TRIGGER reg3
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    UPDATE EMPLOYEES EMP
    SET EMP.JOBTITLE = 'Sales Manager'
    WHERE EMPLOYEENUMBER = (
        SELECT CANBEMANAGERNUMBERS FROM (
            SELECT EMP.REPORTSTO AS CANBEMANAGERNUMBERS
            FROM EMPLOYEES EMP
            GROUP BY EMP.REPORTSTO, EMP.JOBTITLE
            HAVING COUNT(EMP.EMPLOYEENUMBER) > 5 
            AND JOBTITLE NOT LIKE 'Sales Manager'
        ) WHERE CANBEMANAGERNUMBERS = :NEW.REPORTSTO
    );
END;
    
    
--Test:
SELECT  * 
FROM (SELECT EMP.REPORTSTO, EMP.JOBTITLE, COUNT(EMP.EMPLOYEENUMBER) AS NUMER FROM EMPLOYEES EMP
GROUP BY EMP.REPORTSTO, EMP.JOBTITLE)
WHERE NUMER > 5 AND JOBTITLE NOT LIKE 'Sales Manager';

INSERT INTO employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) 
VALUES (17002,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','4',2501,'Sales Rep');

SELECT  * 
FROM (SELECT EMP.REPORTSTO, EMP.JOBTITLE, COUNT(EMP.EMPLOYEENUMBER) AS NUMER FROM EMPLOYEES EMP
GROUP BY EMP.REPORTSTO, EMP.JOBTITLE)
WHERE NUMER > 5 AND JOBTITLE LIKE 'Sales Manager';


/*
4
Aktualizacja danych o towarach w magazynie po dokonaniu zamówienia (update).
Opis: reguła służy do zmiany ilości towarów w magazynie po dokonaniu przez klienta zamówienia. 
Zdarzenia inicjujące: złożenie zamówienia przez klienta na dane towary
Warunki uruchomienia: zamówienie jest poprawne (patrz reguła 6)
Działanie: zmniejszenie ilości towaru na magazynie o ilość wskazaną w zamówieniu.
Szacunek złożoności: dla każdego szczegółu należącego do zaakceptowanego zamówienia wykonaj dodatkowy update
*/
CREATE OR REPLACE TRIGGER reg4
	AFTER INSERT ON ORDERDETAILS
FOR EACH ROW
BEGIN
	UPDATE PRODUCTS PRD
	SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - :NEW.QUANTITYORDERED
	WHERE PRD.PRODUCTCODE = :NEW.PRODUCTCODE;
END;

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10586,'S50_1392',1000,94.92,2);

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 1000
WHERE PRD.PRODUCTCODE = 'S50_1392';



-- TEST
SELECT P.QUANTITYINSTOCK FROM PRODUCTS p WHERE P.PRODUCTCODE = 'S50_1392';

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10586,'S50_1392',1000,94.92,2);



/*
5
Wyciąg wszystkich zamówień z całego dnia (reguła czasowa)
Opis: wyciąg wszystkich zamówień dokonanych z całej poprzedniej doby bez detali tych zamówień. 
Zdarzenia inicjujące: wykonanie automatyczne operacji przez system
Warunki uruchomienia: godzina 8:00.
Działanie: wyciąg wszystkich zamówień dokonanych przez poprzednią dobę.
Szacunek złożoności: wszystkie rekordy z tabeli zamówienia dokonane poprzedniego dnia.
*/
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'test_full_job_definition',
        job_type        => 'PLSQL_BLOCK',
        job_action      => '
BEGIN
	FOR ORD IN  (SELECT * FROM ORDERS)                      
	LOOP
		DBMS_OUTPUT.PUT_LINE( '' ORDERNUMBER: ''  ||ORD.ORDERNUMBER || '' orderDate: '' ||ORD.ORDERDATE || '' requiredDate: '' || ORD.REQUIREDDATE || '' shippedDate: '' ||ORD.SHIPPEDDATE || '' status: ''  ||ORD.STATUS || '' comments: '' ||ORD.COMMENTS || '' customerNumber: '' ||ORD.CUSTOMERNUMBER);
	END LOOP;
END;
',
		start_date      => SYSTIMESTAMP,
		repeat_interval => 'FREQ=DAILY; BYHOUR=8; BYMINUTE=00',
		end_date        => NULL,
		enabled         => TRUE,
		comments        => 'Job defined entirely by the CREATE JOB procedure.');
END;




/* 6
Sprawdzenie czy zamówienie może zostać zrealizowane (Check constraint)
Opis: anulowanie zamówienia jeżeli ilość zamówionego towaru jest większa od ilości towaru na magazynie. 
Zdarzenia inicjujące: dokonanie zamówienia.
Warunki uruchomienia: ilość zamówionego towaru jest większa od ilości towaru na magazynie
Działanie: anulowanie zamówienia.
Szacunek złożoności: dla każdego anulowanego zamówienia jeden dodatkowy update
*/
CREATE OR REPLACE TRIGGER reg6
    BEFORE INSERT OR UPDATE  ON ORDERDETAILS
    FOR EACH ROW
DECLARE 
	dostepny_towar NUMBER;   
BEGIN
    SELECT PRD.QUANTITYINSTOCK INTO dostepny_towar FROM PRODUCTS PRD
    WHERE PRD.PRODUCTCODE = :NEW.PRODUCTCODE;    
    IF (dostepny_towar - :NEW.QUANTITYORDERED < 0)
    THEN
        raise_application_error(-20000, 'Ilość zamówionych towarów nie moze przekraczac ilosci dostępnych towarów w magazynie!');
    END IF;
END;


INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10586,'S50_1392',1017,94.92,2);


/* 7
Zapisywanie zmian na bazie przez użytkowników (Trigger)
Opis: Zapisanie usunięcia lub dodania tabeli do bazy danych przez użytkownika bazy do tabeli z logami.
Zdarzenie inicjujące: Usunięcie, utworzenie tabeli przez użytkownika podłączonego do bazy
Warunki uruchomienia: brak
Działanie: Dokonanie wpisu do tabeli z logami dokonanej przez użytkownika akcji 
Szacunek Złożoności: Na kazdą operację dodania lub usunięcia tabeli jeden insert
*/
CREATE TABLE tables_log(
	action_id int GENERATED ALWAYS AS IDENTITY,
	object_name VARCHAR2(30) NOT NULL,
	object_type VARCHAR2(30) NOT NULL,
	action VARCHAR2(30) NOT NULL,
	action_date TIMESTAMP NOT NULL,
	who VARCHAR2(30) NOT NULL
	);
 
 
CREATE OR REPLACE TRIGGER create_table_log
BEFORE CREATE OR DROP ON SCHEMA
BEGIN
    INSERT INTO tables_log(object_name, object_type, action, action_date, who)
VALUES(SYS.DICTIONARY_OBJ_NAME,SYS.DICTIONARY_OBJ_TYPE,SYS.sysevent,systimestamp,USER);
END;

-- Test
CREATE TABLE test(
	action_id int GENERATED ALWAYS AS IDENTITY,
	object_name VARCHAR2(30) NOT NULL,
	object_type VARCHAR2(30) NOT NULL,
	action VARCHAR2(30) NOT NULL,
	action_date TIMESTAMP NOT NULL,
	who VARCHAR2(30) NOT NULL
 );



/* 8
Zapisywanie historii logowania użytkownika (Trigger)
Opis: Zapis do tabeli z logami historii logowania użytkownika
Zdarzenie inicjujące: Logowanie/wylogowanie użytkownika
Warunki uruchomienia: Poprawne zalogowanie użytkownika
Działanie: Zapis do tabeli z logami informacje o zalogowaniu użytkownika.
Szacunek Złożoności: Wstawienie jednego rekordu do tabeli z logami dotyczącymi logowania.
*/
CREATE TABLE users_log (
	logID int GENERATED ALWAYS AS IDENTITY,
	user_name VARCHAR2(30),
	activity VARCHAR2(20),
	event_date TIMESTAMP
);

CREATE OR REPLACE TRIGGER logon_trigger
	AFTER LOGON
	ON DATABASE
BEGIN
	INSERT INTO users_log (user_name, activity, event_date)
	VALUES (USER, 'LOGON', CURRENT_TIMESTAMP);
END;

CREATE OR REPLACE TRIGGER logoff_trigger
	BEFORE LOGOFF
	ON DATABASE
BEGIN
	INSERT INTO users_log (user_name, activity, event_date)
	VALUES (USER, 'LOGOFF', CURRENT_TIMESTAMP);
END;




