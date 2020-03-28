-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_ZESTAW_C NUMBER;
EXEC :START_TIME_ZESTAW_C := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

--SELECTY
--1. Zarobek wygenerowany z zamówień przez wybranego pracownika

SELECT EMPLOYEENUMBER, SUM(EARNED) AS EARNED FROM CUSTOMERS cu INNER JOIN (
SELECT SUM(EARNED) AS EARNED, CUSTOMERNUMBER FROM ORDERS o INNER JOIN (
SELECT SUM(EARNED) AS EARNED, ORDERNUMBER FROM(
SELECT (PRICEEACH * QUANTITYORDERED) - (BUYPRICE * QUANTITYORDERED) AS EARNED, ORDERNUMBER FROM (
SELECT * FROM PRODUCTS p INNER JOIN ORDERDETAILS od ON od.PRODUCTCODE = p.PRODUCTCODE) a ORDER BY ORDERNUMBER ) b GROUP BY ORDERNUMBER ) c ON o.ORDERNUMBER  = c.ORDERNUMBER GROUP BY CUSTOMERNUMBER ORDER BY CUSTOMERNUMBER) d ON d.CUSTOMERNUMBER = cu.CUSTOMERNUMBER
RIGHT JOIN EMPLOYEES e ON cu.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER WHERE EMPLOYEENUMBER = 1216 GROUP BY EMPLOYEENUMBER ORDER BY EMPLOYEENUMBER ;

--2. Który pracownik miał największą różnicę pomiędzy najdroższym a najtańszym produktem
SELECT MAX(DIFFERENCE), EMPLOYEENUMBER FROM (
SELECT MAX(BUYPRICE) - MIN(BUYPRICE) AS DIFFERENCE, EMPLOYEENUMBER FROM (
SELECT e.EMPLOYEENUMBER, o.ORDERNUMBER, QUANTITYORDERED, PRICEEACH, p.PRODUCTNAME, p.BUYPRICE FROM EMPLOYEES e INNER JOIN CUSTOMERS c ON c.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER INNER JOIN ORDERS o ON o.CUSTOMERNUMBER  = c.CUSTOMERNUMBER INNER JOIN ORDERDETAILS od ON od.ORDERNUMBER = o.ORDERNUMBER INNER JOIN PRODUCTS p ON p.PRODUCTCODE = od.PRODUCTCODE) a
GROUP BY EMPLOYEENUMBER) b GROUP BY EMPLOYEENUMBER ORDER BY MAX(DIFFERENCE);

--3. Ilu pracowników ma dane stanowisko

SELECT COUNT(*) AS nr, JOBTITLE FROM EMPLOYEES e GROUP BY JOBTITLE ORDER BY nr desc;

--4. Z którego kraju klient zrobił najdroższe zamówienie
SELECT o.ORDERNUMBER, ORDERPRICE, COUNTRY FROM (
(SELECT SUM(ORDERPRICE) AS ORDERPRICE, ORDERNUMBER FROM (
SELECT ORDERNUMBER, PRICEEACH * QUANTITYORDERED AS ORDERPRICE FROM ORDERDETAILS o) GROUP BY ORDERNUMBER)) a INNER JOIN ORDERS o ON o.ORDERNUMBER = a.ORDERNUMBER INNER JOIN CUSTOMERS c ON c.CUSTOMERNUMBER = o.CUSTOMERNUMBER ORDER BY ORDERPRICE desc;

--5. Który pracownik ma najwięcej klientów
SELECT COUNT(*) AS Nr, SALESREPEMPLOYEENUMBER FROM CUSTOMERS c GROUP BY SALESREPEMPLOYEENUMBER ORDER BY NR desc;


--CRUDY
--6. Przeniesienia pracownika do innego biura
SELECT EMPLOYEENUMBER, OFFICECODE FROM EMPLOYEES WHERE EMPLOYEENUMBER  = 1076;
-- 1076 należy do office 1

UPDATE EMPLOYEES SET OFFICECODE = 2 WHERE EMPLOYEENUMBER  = 1076;
-- 1076 należy do office 2

--7. Zmiana pracownika odpowiedzialnego za daną grupę klientów
SELECT COUNT(*) FROM CUSTOMERS c WHERE SALESREPEMPLOYEENUMBER  = 1076;
-- 1076 nie ma żadnych klientów

SELECT COUNT(*) FROM CUSTOMERS c WHERE SALESREPEMPLOYEENUMBER  = 1216;
-- 1216 ma 6 klientów

UPDATE CUSTOMERS SET SALESREPEMPLOYEENUMBER = 1076 WHERE SALESREPEMPLOYEENUMBER = 1216;

--8. Zmniejszenie limitu kredytowego o 10% dla klientów którzy w wybranym miesiącu zrobili zamówienie na kwotę mniej niż 20 000
-- Na razie tylko select z id klientów którym trzeba zmienić kredyt

SELECT customernumber FROM (
SELECT SUM(payment) AS payment, CUSTOMERNUMBER FROM (
SELECT SUM(PRICEEACH * QUANTITYORDERED) AS payment, c.CUSTOMERNUMBER FROM CUSTOMERS c
LEFT JOIN ORDERS o ON o.CUSTOMERNUMBER = c.CUSTOMERNUMBER
LEFT JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER WHERE EXTRACT(MONTH FROM o.ORDERDATE) = 1 AND EXTRACT(YEAR FROM o.ORDERDATE) = 2005 GROUP BY c.CUSTOMERNUMBER, od.ORDERNUMBER, od.PRODUCTCODE) a GROUP BY Customernumber) WHERE payment < 20000;

-- 9 Dodanie 10 pracownikówinsert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3000,'Acosta','Maxwell','x5000','Maxwell.Acosta@pwr.edu.pl','3',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3001,'Ballard','Anna','x5000','Anna.Ballard@pwr.edu.pl','4',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3002,'West','Robert','x5000','Robert.West@pwr.edu.pl','1',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3003,'Wallace','Scott','x5000','Scott.Wallace@pwr.edu.pl','5',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3004,'Cisneros','Kevin','x5000','Kevin.Cisneros@pwr.edu.pl','4',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3005,'Aguilar','Joshua','x5000','Joshua.Aguilar@pwr.edu.pl','2',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3006,'Middleton','Edwin','x5000','Edwin.Middleton@pwr.edu.pl','6',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3007,'Fleming','Sarah','x5000','Sarah.Fleming@pwr.edu.pl','7',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3008,'Valencia','Christine','x5000','Christine.Valencia@pwr.edu.pl','7',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3009,'Bradley','Kimberly','x5000','Kimberly.Bradley@pwr.edu.pl','2',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3010,'Rose','Elizabeth','x5000','Elizabeth.Rose@pwr.edu.pl','5',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3011,'Parker','Margaret','x5000','Margaret.Parker@pwr.edu.pl','2',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3012,'Larson','Fernando','x5000','Fernando.Larson@pwr.edu.pl','3',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3013,'Garcia','Carol','x5000','Carol.Garcia@pwr.edu.pl','3',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3014,'Taylor','Justin','x5000','Justin.Taylor@pwr.edu.pl','1',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3015,'Haas','Justin','x5000','Justin.Haas@pwr.edu.pl','2',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3016,'Ball','David','x5000','David.Ball@pwr.edu.pl','4',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3017,'Weaver','Guy','x5000','Guy.Weaver@pwr.edu.pl','3',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3018,'Walls','Amanda','x5000','Amanda.Walls@pwr.edu.pl','6',1102,'`TEST`');
insert into employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) values (3019,'Murphy','Shannon','x5000','Shannon.Murphy@pwr.edu.pl','1',1102,'`TEST`');


delete from employees where employeenumber = 3000;
delete from employees where employeenumber = 3001;
delete from employees where employeenumber = 3002;
delete from employees where employeenumber = 3003;
delete from employees where employeenumber = 3004;
delete from employees where employeenumber = 3005;
delete from employees where employeenumber = 3006;
delete from employees where employeenumber = 3007;
delete from employees where employeenumber = 3008;
delete from employees where employeenumber = 3009;
delete from employees where employeenumber = 3010;
delete from employees where employeenumber = 3011;
delete from employees where employeenumber = 3012;
delete from employees where employeenumber = 3013;
delete from employees where employeenumber = 3014;
delete from employees where employeenumber = 3015;
delete from employees where employeenumber = 3016;
delete from employees where employeenumber = 3017;
delete from employees where employeenumber = 3018;
delete from employees where employeenumber = 3019;


VARIABLE  TIME_FOR_ZESTAW_C NUMBER;
EXEC :TIME_FOR_ZESTAW_C := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_ZESTAW_C;

spool results.txt append;
PRINT TIME_FOR_ZESTAW_C;
spool off;
