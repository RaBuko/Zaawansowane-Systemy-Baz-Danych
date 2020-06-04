--Crud_1-7
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_CRUD NUMBER;
EXEC :START_TIME_CRUD := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

--1 
SELECT SUM(OD.PRICEEACH * OD.QUANTITYORDERED) FROM ORDERDETAILS OD 
INNER JOIN ORDERS O ON OD.ORDERNUMBER = O.ORDERNUMBER
WHERE O.ORDERDATE >= to_date('2003-04-01','YYYY-MM-DD') 
AND O.ORDERDATE <to_date('2003-05-01','YYYY-MM-DD'); 

--2
UPDATE ORDERS ORD
SET ORD.STATUS = 'Delivered',
ORD.SHIPPEDDATE = to_date('2005-06-04','YYYY-MM-DD') 
WHERE ORD.STATUS = 'In Process';

--3
SELECT p.PRODUCTCODE, MAX(SHIPPEDDATE - ORDERDATE)
FROM ORDERS o 
JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER 
JOIN PRODUCTS p ON p.PRODUCTCODE = od.PRODUCTCODE 
WHERE o.SHIPPEDDATE IS NOT NULL 
GROUP BY P.PRODUCTCODE
ORDER BY MAX(SHIPPEDDATE - ORDERDATE) DESC;

--4
SELECT od.PRODUCTCODE, COUNT(od.PRODUCTCODE)
FROM OFFICES off
JOIN EMPLOYEES e ON off.OFFICECODE = e.OFFICECODE 
JOIN CUSTOMERS c ON c.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER 
JOIN ORDERS o ON o.CUSTOMERNUMBER = c.CUSTOMERNUMBER 
JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER
WHERE off.OFFICECODE = 4
GROUP BY od.PRODUCTCODE 
ORDER BY COUNT(od.PRODUCTCODE) DESC;


--5
DELETE FROM CUSTOMERS CST1
WHERE CST1.CUSTOMERNUMBER IN
(SELECT CST.CUSTOMERNUMBER FROM CUSTOMERS CST
INNER JOIN EMPLOYEES EMP ON CST.SALESREPEMPLOYEENUMBER = EMP.EMPLOYEENUMBER
INNER JOIN OFFICES OFC ON EMP.OFFICECODE = OFC.OFFICECODE
WHERE OFC.COUNTRY = 'USA');

--6
insert  into orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber)
SELECT
        999999 + CSTN,
        to_date('2020-04-20','YYYY-MM-DD'),
        to_date('2020-04-20','YYYY-MM-DD'),
        NULL,
        'In Process',
        NULL,
        CSTN
FROM (SELECT CST.CUSTOMERNUMBER AS CSTN FROM CUSTOMERS CST
INNER JOIN EMPLOYEES EMP ON CST.SALESREPEMPLOYEENUMBER = EMP.EMPLOYEENUMBER
WHERE EMP.EMPLOYEENUMBER = 1323);

insert  into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
SELECT
ORDN,
'S24_1046',
10,
60,
12
FROM
(SELECT ORD.ORDERNUMBER AS ORDN FROM ORDERS ORD 
WHERE ORD.ORDERNUMBER > 999999);

insert  into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
SELECT
ORDN,
'S12_3148',
10,
60,
12
FROM
(SELECT ORD.ORDERNUMBER AS ORDN FROM ORDERS ORD 
WHERE ORD.ORDERNUMBER > 999999);

insert  into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
SELECT
ORDN,
'S12_4473',
10,
60,
12
FROM
(SELECT ORD.ORDERNUMBER AS ORDN FROM ORDERS ORD 
WHERE ORD.ORDERNUMBER > 999999);

--7
SELECT EMPLOYEENUMBER, SUM(EARNED) AS EARNED FROM CUSTOMERS cu INNER JOIN (
SELECT SUM(EARNED) AS EARNED, CUSTOMERNUMBER FROM ORDERS o INNER JOIN (
SELECT SUM(EARNED) AS EARNED, ORDERNUMBER FROM(
SELECT (PRICEEACH * QUANTITYORDERED) - (BUYPRICE * QUANTITYORDERED) AS EARNED, ORDERNUMBER FROM (
SELECT * FROM PRODUCTS p INNER JOIN ORDERDETAILS od ON od.PRODUCTCODE = p.PRODUCTCODE) a ORDER BY ORDERNUMBER ) b GROUP BY ORDERNUMBER ) c ON o.ORDERNUMBER  = c.ORDERNUMBER GROUP BY CUSTOMERNUMBER ORDER BY CUSTOMERNUMBER) d ON d.CUSTOMERNUMBER = cu.CUSTOMERNUMBER
RIGHT JOIN EMPLOYEES e ON cu.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER WHERE EMPLOYEENUMBER = 1216 GROUP BY EMPLOYEENUMBER ORDER BY EMPLOYEENUMBER ;

VARIABLE  TIME_FOR_CRUD NUMBER;
EXEC :TIME_FOR_CRUD := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_CRUD;
spool etap5_crud.txt append;
PRINT TIME_FOR_CRUD;
spool off;
ROLLBACK;