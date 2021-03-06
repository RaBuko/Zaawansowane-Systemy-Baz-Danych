--XML_query_1-7
-- FLUSH 
ALTER SYSTEM FLUSH buffer_cache;
ALTER SYSTEM FLUSH shared_pool;
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';

VARIABLE  START_TIME_XML NUMBER;
EXEC :START_TIME_XML := EXTRACT(SECOND FROM SYSTIMESTAMP);
-- START MIERZENIA CZASU

--1
DELETE FROM ORDERS ORD
WHERE
ORD.ORDERNUMBER IN (SELECT ORD.ORDERNUMBER AS NUMER FROM ORDERS ORD
WHERE ORD.DETAILS.EXTRACT('//details/element/orderLineNumber/text()').getStringVal() LIKE '%7%');



--2
INSERT INTO orders (
    ordernumber,
    orderdate,
    requireddate,
    shippeddate,
    status,
    comments,
    customernumber,
    details
)
SELECT
	99999 + CST.CUSTOMERNUMBER,
	to_date('2020-05-01','YYYY-MM-DD'),
	to_date('2020-10-01','YYYY-MM-DD'),
	NULL,
	'In Process',
	NULL,
	CST.CUSTOMERNUMBER,
	'<?xml version="1.0" encoding="UTF-8"?>
	<details>
	<element>
			<id>0</id>
			<productCode>vb369_375</productCode>
			<quantityOrdered>7</quantityOrdered>
			<priceEach>4283</priceEach>
			<orderLineNumber>0</orderLineNumber>
		</element><element>
			<id>0</id>
			<productCode>hv232_198</productCode>
			<quantityOrdered>2</quantityOrdered>
			<priceEach>4839</priceEach>
			<orderLineNumber>1</orderLineNumber>
		</element><element>
			<id>0</id>
			<productCode>so561_437</productCode>
			<quantityOrdered>3</quantityOrdered>
			<priceEach>569</priceEach>
			<orderLineNumber>2</orderLineNumber>
		</element><element>
			<id>0</id>
			<productCode>hn522_363</productCode>
			<quantityOrdered>4</quantityOrdered>
			<priceEach>958</priceEach>
			<orderLineNumber>3</orderLineNumber>
		</element><element>
			<id>0</id>
			<productCode>aw922_829</productCode>
			<quantityOrdered>0</quantityOrdered>
			<priceEach>23</priceEach>
			<orderLineNumber>4</orderLineNumber>
		</element>
	</details>'
FROM CUSTOMERS CST
INNER JOIN EMPLOYEES EMP ON CST.SALESREPEMPLOYEENUMBER = EMP.EMPLOYEENUMBER        
WHERE
	EMP.EMPLOYEENUMBER = 1323;
	
	
/*	
--3
DECLARE
    parser          xmlparser.parser;
    xmldoc          xmldom.domdocument;       
    mydoc           VARCHAR2(4000);    
BEGIN
    FOR rec IN (
        SELECT
            *
        FROM
            customers
    ) LOOP
        mydoc := rec.customernumber;
        parser := xmlparser.newparser;
        xmldoc := xmlparser.getdocument(parser); 
        IF rec.customernumber = 103  THEN          
            
		Insert INTO payments VALUES ('<?xml version="1.0" encoding="UTF-8"?>
            <payment>
                <customerNumber>103</customerNumber>
                <checkNumber>ny213802</checkNumber>
                <paymentDate>01.05.2020</paymentDate>
                <amount>10672.0</amount>
            </payment>');          
        END IF;
        xmldom.freedocument(xmldoc);
        xmlparser.freeparser(parser);
    END LOOP;
END;
*/
--4 -- 10000/ US

UPDATE CUSTOMERS CST
SET CST.CREDITLIMIT = CST.CREDITLIMIT + 1000
WHERE CST.CUSTOMERNUMBER IN (
SELECT DISTINCT Customer FROM 
(
    SELECT CAST(XMLTYPE(p.PAYMENT).EXTRACT('/payment/amount/text()').getStringVal() AS NUMBER) AS amount,
    XMLTYPE(p.PAYMENT).EXTRACT('/payment/customerNumber/text()').getStringVal() AS Customer 
    FROM PAYMENTS p
) WHERE amount > 100000);

--5 POCZATEK
SELECT  XMLTYPE(PAY.PAYMENT).EXTRACT('/payment/checkNumber/text()').getStringVal() AS NUMER_ZAMUWIENIA, 
XMLTYPE(PAY.PAYMENT).EXTRACT('/payment/paymentDate/text()').getStringVal() AS DATA_ZAMUWIENIA  FROM PAYMENTS PAY
WHERE to_date(XMLTYPE(PAY.PAYMENT).EXTRACT('/payment/paymentDate/text()').getStringVal(), 'DD-MM-YYYY') BETWEEN  to_date('22.10.2004','DD-MM-YYYY') 
AND to_date('31.12.2004','DD-MM-YYYY');

/*
--6
DECLARE
	parser xmlparser.parser;
	xmldoc xmldom.domdocument;       
	mydoc VARCHAR2(4000);    
BEGIN
    FOR rec IN (
        SELECT CUSTOMERNUMBER 
		FROM CUSTOMERS c 
		INNER JOIN EMPLOYEES e ON c.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER 
		INNER JOIN OFFICES o ON o.OFFICECODE = e.OFFICECODE 
		WHERE O.DETAILS.EXTRACT('//office/country/text()').getStringVal() = 'USA'
    ) LOOP
        mydoc := rec.customernumber;
        parser := xmlparser.newparser;
        xmldoc := xmlparser.getdocument(parser); 
       
       	DELETE FROM CUSTOMERS c 
       	WHERE c.CUSTOMERNUMBER = rec.CUSTOMERNUMBER;
       
        xmldom.freedocument(xmldoc);
        xmlparser.freeparser(parser);
    END LOOP;
END;*/

--7
SELECT CST.CUSTOMERNUMBER, CST.CITY, OFC.details.extract('//office/city/text()').getstringval() AS OFFICE_CITY FROM CUSTOMERS CST
INNER JOIN EMPLOYEES EMP ON CST.SALESREPEMPLOYEENUMBER = EMP.EMPLOYEENUMBER
INNER JOIN OFFICES OFC ON EMP.OFFICECODE = OFC.OFFICECODE
WHERE CST.CITY = OFC.details.extract('//office/city/text()').getstringval();


VARIABLE  TIME_FOR_XML NUMBER;
EXEC :TIME_FOR_XML := EXTRACT(SECOND FROM SYSTIMESTAMP)-:START_TIME_XML;
spool etap3_results.txt append;
PRINT TIME_FOR_XML;
spool off;
ROLLBACK;