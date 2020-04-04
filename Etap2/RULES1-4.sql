--Rule_total
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_RULE_TOTAL NUMBER;
EXEC :START_TIME_RULE_TOTAL := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU
--1
UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10420;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10421;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10422;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10423;


UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road'
WHERE ORD.ORDERNUMBER = 10424;

--2
insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236335',to_date('2020-02-19','YYYY-MM-DD'),6066.78); 

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236336',to_date('2020-02-19','YYYY-MM-DD'),6066.78); 

insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236337',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236338',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
 
 insert  into payments(customerNumber,checkNumber,paymentDate,amount) 
values (103,'NEW236339',to_date('2020-02-19','YYYY-MM-DD'),6066.78);

--3


INSERT INTO employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) 
VALUES (17002,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','4',2501,'Sales Rep');

--4
INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10328,'S50_1392',5,10,2);

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10328,'S18_3278',10,15,2);

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10328,'S18_3482',15,15,2);

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10328,'S18_3685',20,25,2);

INSERT INTO orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
VALUES (10328,'S18_3782',25,30,2);



VARIABLE  TIME_FOR_RULE_TOTAL NUMBER;
EXEC :TIME_FOR_RULE_TOTAL := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_RULE_TOTAL;
spool etap2_results.txt append;
PRINT TIME_FOR_RULE_TOTAL;
spool off;
ROLLBACK;