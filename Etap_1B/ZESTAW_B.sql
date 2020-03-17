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

--Ile sprzedawca zyskał albo stracił na dany produkt w stosunku do ceny którą sugerował producent (MSRP)


--Jakie produkty sprzedaje najczęściej poszczególne biuro

--CRUD
--Zwiększenie ilości towaru w magazynie
--Zmiana procentowa ceny (np. wzrost o 10%) na wszystkie produkty danego producenta
--Dodanie nowego product line wraz z produktami */
