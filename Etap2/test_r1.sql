---r1 - PRUBKA
---crud
UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road',
ORD.REQUIREDDATE = ORD.REQUIREDDATE +1
WHERE ORD.ORDERNUMBER = 10420;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road',
ORD.REQUIREDDATE = ORD.REQUIREDDATE +1
WHERE ORD.ORDERNUMBER = 10421;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road',
ORD.REQUIREDDATE = ORD.REQUIREDDATE +1
WHERE ORD.ORDERNUMBER = 10422;

UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road',
ORD.REQUIREDDATE = ORD.REQUIREDDATE +1
WHERE ORD.ORDERNUMBER = 10423;


UPDATE ORDERS ORD
SET ORD.STATUS = 'On Road',
ORD.REQUIREDDATE = ORD.REQUIREDDATE +1
WHERE ORD.ORDERNUMBER = 10424;

ROLLBACK;
---------------------r1
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




 

