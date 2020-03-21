--SELECT
--Średnia wysokość płatności dla wybranego miasta i okresu czasu
SELECT AVG(p.AMOUNT) 
FROM PAYMENTS p 
INNER JOIN CUSTOMERS c ON c.CUSTOMERNUMBER = p.CUSTOMERNUMBER 
WHERE c.CITY = 'Paris'
AND p.PAYMENTDATE BETWEEN to_date('2003-12-07','YYYY-MM-DD') AND to_date('2004-12-07','YYYY-MM-DD');

--Najczęściej sprzedawany produkt dla klientów z danego kraju
SELECT p.PRODUCTCODE, COUNT(p.PRODUCTCODE), c.COUNTRY 
FROM CUSTOMERS c 
JOIN ORDERS o ON c.CUSTOMERNUMBER = o.CUSTOMERNUMBER 
JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER 
JOIN PRODUCTS p ON od.PRODUCTCODE = p.PRODUCTCODE 
WHERE c.COUNTRY = 'France'
GROUP BY p.PRODUCTCODE, c.COUNTRY 
ORDER BY COUNT(p.PRODUCTCODE) desc

--Które produkty były najdłużej dostarczane
SELECT p.PRODUCTCODE, MAX(SHIPPEDDATE - ORDERDATE)
FROM ORDERS o 
JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER 
JOIN PRODUCTS p ON p.PRODUCTCODE = od.PRODUCTCODE 
WHERE o.SHIPPEDDATE IS NOT NULL 
GROUP BY P.PRODUCTCODE
ORDER BY MAX(SHIPPEDDATE - ORDERDATE) DESC 

--Ile sprzedawca zyskał albo stracił na dany produkt
--PRODUCTS.BUYPRICE - cena za ile zostało kupuione od proceduetna, ORDERDETAILS.PRICEEACH - cena za ile faktycznie zostało sprzedane
-- Zysk sprzedawcy = (PRICEEACH - BUYPRICE) * QUANTITYORDERED
SELECT SUM((o.PRICEEACH - p.BUYPRICE) * o.QUANTITYORDERED) 
FROM ORDERDETAILS o 
JOIN PRODUCTS p ON o.PRODUCTCODE = p.PRODUCTCODE 
WHERE p.PRODUCTCODE = 'S18_2581'

--Jakie produkty sprzedaje najczęściej poszczególne biuro
SELECT od.PRODUCTCODE, COUNT(od.PRODUCTCODE)
FROM OFFICES off
JOIN EMPLOYEES e ON off.OFFICECODE = e.OFFICECODE 
JOIN CUSTOMERS c ON c.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER 
JOIN ORDERS o ON o.CUSTOMERNUMBER = c.CUSTOMERNUMBER 
JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER
WHERE off.OFFICECODE = 4
GROUP BY od.PRODUCTCODE 
ORDER BY COUNT(od.PRODUCTCODE) desc

--CRUD
--Zwiększenie ilości towaru w magazynie
UPDATE PRODUCTS 
SET QUANTITYINSTOCK = QUANTITYINSTOCK + 5
WHERE PRODUCTCODE = 'S18_2319'

--Zmiana procentowa ceny (np. wzrost o 10%) na wszystkie produkty danego producenta
UPDATE PRODUCTS 
SET BUYPRICE = BUYPRICE * 1.10 -- wzrost ceny o 10%
WHERE PRODUCTVENDOR = 'Unimax Art Galleries'

--Dodanie nowego product line wraz z produktami
BEGIN
	-- Dodanie linii produkcyjnej
	INSERT INTO PRODUCTLINES
	(PRODUCTLINE, TEXTDESCRIPTION, HTMLDESCRIPTION, IMAGE)
	VALUES('Food', 'Something what you can eat', NULL, NULL);	
	
	-- Dodanie produktu 1 do dodanej linii produkcyjnej
	INSERT INTO PRODUCTS
	(PRODUCTCODE, PRODUCTNAME, PRODUCTLINE, PRODUCTSCALE, PRODUCTVENDOR, PRODUCTDESCRIPTION, QUANTITYINSTOCK, BUYPRICE, MSRP)
	VALUES ('F00_0001', 'Banana', 'Food', '1:1', 'Biedronka', 'Banana', 1000, 2.99, 3.99),
	
	INSERT INTO PRODUCTS
	(PRODUCTCODE, PRODUCTNAME, PRODUCTLINE, PRODUCTSCALE, PRODUCTVENDOR, PRODUCTDESCRIPTION, QUANTITYINSTOCK, BUYPRICE, MSRP)
	VALUES ('F00_0002', 'Orange', 'Food', '1:1', 'Biedronka', 'Orange', 5000, 3.99, 4.49);
END;

