--Crud_4
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;

VARIABLE  START_TIME_CRUD_4 NUMBER;
EXEC :START_TIME_CRUD_4 := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

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

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 5
WHERE PRD.PRODUCTCODE = 'S50_1392';

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 10
WHERE PRD.PRODUCTCODE = 'S18_3278';

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 15
WHERE PRD.PRODUCTCODE = 'S18_3482';

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 20
WHERE PRD.PRODUCTCODE = 'S18_3685';

UPDATE PRODUCTS PRD
SET PRD.QUANTITYINSTOCK = PRD.QUANTITYINSTOCK - 25
WHERE PRD.PRODUCTCODE = 'S18_3782';

VARIABLE  TIME_FOR_CRUD_4 NUMBER;
EXEC :TIME_FOR_CRUD_4 := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_CRUD_4;
spool etap2_results.txt append;
PRINT TIME_FOR_CRUD_4;
spool off;
ROLLBACK;