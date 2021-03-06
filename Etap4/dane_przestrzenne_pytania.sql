--1
INSERT INTO cities 
VALUES ('Wrocław', SDO_GEOMETRY(2001,NULL, SDO_POINT_TYPE(51.1,17.0, NULL),NULL,NULL));

--2
DELETE FROM ORDERS ORD
WHERE ORD.ORDERNUMBER IN (SELECT ORDNUM FROM (SELECT ORD.ORDERNUMBER AS ORDNUM, SDO_GEOM.SDO_Length(ORD.SHIPPINGPATH) AS LINELENGHT  FROM ORDERS ORD
ORDER BY LINELENGHT)
WHERE LINELENGHT < 20);

--3
UPDATE PRODUCTS PRD
SET PRD.RECTANGLE = MDSYS.SDO_GEOMETRY(
    2003,  -- 2 wymiary
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,1003,3), -- jeden prostokat (1003 = zewn)
    MDSYS.SDO_ORDINATE_ARRAY(0,0, 20,30) -- 2 punkty definiujace prostokat (lewy dolny rog i prawy forny rog)
)
WHERE PRD.PRODUCTNAME = '1964 Mercedes Tour Bus'

--4
SELECT cu.* FROM CUSTOMERS cu
JOIN CITIES ci ON cu.CITY = ci.CITY 
WHERE SDO_EQUAL(ci.LOCATION, SDO_GEOMETRY(2001,NULL, SDO_POINT_TYPE(4.732445,-74.264192, NULL),NULL,NULL)) = 'TRUE';


--5
SELECT DISTINCT(CST.CUSTOMERNUMBER), CST.CITY, OFC.CITY FROM CUSTOMERS CST
INNER JOIN EMPLOYEES EMP ON CST.SALESREPEMPLOYEENUMBER = EMP.EMPLOYEENUMBER
INNER JOIN OFFICES OFC ON EMP.OFFICECODE = OFC.OFFICECODE
INNER JOIN CITIES CTS ON CST.CITY = CTS.CITY
INNER JOIN CITIES CTS1 ON CTS.CITY = OFC.CITY
WHERE SDO_EQUAL(CTS.LOCATION, CTS1.LOCATION) = 'TRUE'
ORDER BY CST.CITY;

--6
SELECT ORDNUM FROM (SELECT ORD.ORDERNUMBER AS ORDNUM, SDO_GEOM.SDO_Length(ORD.SHIPPINGPATH) AS LINELENGHT  FROM ORDERS ORD
ORDER BY LINELENGHT)
WHERE LINELENGHT > 150;
--7
SELECT ORD.ORDERNUMBER, SUM(ORDD.QUANTITYORDERED * SDO_GEOM.SDO_AREA(PRD.RECTANGLE, 0.005)) AS ZAJMOWANE_MIEJSCE FROM ORDERS ORD
INNER JOIN ORDERDETAILS ORDD ON ORDD.ORDERNUMBER = ORD.ORDERNUMBER
INNER JOIN PRODUCTS PRD ON PRD.PRODUCTCODE = ORDD.PRODUCTCODE
WHERE ORD.CUSTOMERNUMBER = 103
GROUP BY ORD.ORDERNUMBER;