--ZESTAW A

--1 
SELECT SUM(OD.PRICEEACH * OD.QUANTITYORDERED) FROM ORDERDETAILS OD 
INNER JOIN ORDERS O ON OD.ORDERNUMBER = O.ORDERNUMBER
WHERE O.ORDERDATE >= to_date('2003-04-01','YYYY-MM-DD') 
AND O.ORDERDATE <to_date('2003-05-01','YYYY-MM-DD'); 

--2
SELECT SUM(OD.PRICEEACH * OD.QUANTITYORDERED), CUSTOMERS.CONTACTLASTNAME FROM ORDERDETAILS OD 
INNER JOIN ORDERS O ON OD.ORDERNUMBER = O.ORDERNUMBER
INNER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMERNUMBER = O.CUSTOMERNUMBER
WHERE O.ORDERDATE >= to_date('2003-04-01','YYYY-MM-DD') 
AND O.ORDERDATE <to_date('2003-05-01','YYYY-MM-DD') 
GROUP BY CUSTOMERS.CONTACTLASTNAME;


--3
SELECT PR.PRODUCTNAME FROM PRODUCTS PR 
INNER JOIN ORDERDETAILS OD ON PR.PRODUCTCODE = OD.PRODUCTCODE
INNER JOIN ORDERS ORD ON ORD.CUSTOMERNUMBER = OD.ORDERNUMBER
WHERE ORD.SHIPPEDDATE > ORD.REQUIREDDATE;


--4
SELECT ORD.ORDERNUMBER, OD.QUANTITYORDERED * (PD.BUYPRICE - PD.MSRP) AS PRICE FROM ORDERS ORD
INNER JOIN ORDERDETAILS OD ON OD.ORDERNUMBER = ORD.ORDERNUMBER
INNER JOIN PRODUCTS PD ON PD.PRODUCTCODE = OD.PRODUCTCODE
WHERE ORD.ORDERDATE >= to_date('2003-04-01','YYYY-MM-DD') 
AND ORD.ORDERDATE <to_date('2003-05-01','YYYY-MM-DD')
ORDER BY PRICE DESC; 


--5 PROBLEM
SELECT ORD.ORDERNUMBER, ORD.COMMENTS FROM ORDERS ORD
INNER JOIN CUSTOMERS CST ON CST.CUSTOMERNUMBER = ORD.CUSTOMERNUMBER
INNER JOIN PAYMENTS PMN ON PMN.CUSTOMERNUMBER = CST.CUSTOMERNUMBER
WHERE ORD.ORDERDATE >= to_date('2003-04-01','YYYY-MM-DD') 
AND ORD.ORDERDATE <to_date('2003-05-01','YYYY-MM-DD')
ORDER BY ORD.ORDERNUMBER DESC;

--6
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);
insert  into payments(customerNumber,checkNumber,paymentDate,amount) values (103,'HQR336336',to_date('2020-02-19','YYYY-MM-DD'),6066.78);


--7
UPDATE ORDERS ORD
SET ORD.STATUS = 'Delivered',
ORD.SHIPPEDDATE = to_date('2005-06-04','YYYY-MM-DD') 
WHERE ORD.STATUS = 'In Process';


--8
UPDATE ORDERS ORD
SET ORD.STATUS = 'Delivered',
ORD.COMMENTS = 'A TU JEST NOWY, MOZE DLUGI KOMENTAZ, ALE TAKI POTRZEBNY ZEBY CZAS BYL WIEKSZY'
WHERE ORD.STATUS = 'Shipped'
AND ORD.COMMENTS IS NULL;
