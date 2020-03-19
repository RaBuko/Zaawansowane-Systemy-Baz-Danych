--SELECTY
--1. Zarobek wygenerowany z zamówień przez wybranego pracownika

-- Wpłaty na poczet pracownika
SELECT 
	SUM(PAYMENT),
	Customernumber
FROM (
SELECT 
	p.AMOUNT AS payment,
	e.EMPLOYEENUMBER,
	e.LASTNAME, 
	e.FIRSTNAME, 
	c.CUSTOMERNUMBER
	FROM EMPLOYEES e
		INNER JOIN CUSTOMERS c
		ON e.EMPLOYEENUMBER  = c.SALESREPEMPLOYEENUMBER
		INNER JOIN PAYMENTS p
		ON p.CUSTOMERNUMBER  = c.CUSTOMERNUMBER
		WHERE e.EMPLOYEENUMBER  = 1166) a
	GROUP BY CUSTOMERNUMBER;

-- Zarobek na zamówieniu
SELECT EMPLOYEENUMBER, SUM(EARNED) AS EARNED FROM CUSTOMERS cu RIGHT JOIN (
SELECT SUM(EARNED) AS EARNED, CUSTOMERNUMBER FROM ORDERS o INNER JOIN (
SELECT SUM(EARNED) AS EARNED, ORDERNUMBER FROM(
SELECT (PRICEEACH * QUANTITYORDERED) - (BUYPRICE * QUANTITYORDERED) AS EARNED, ORDERNUMBER FROM (
SELECT * FROM PRODUCTS p INNER JOIN ORDERDETAILS od ON od.PRODUCTCODE = p.PRODUCTCODE) a ORDER BY ORDERNUMBER ) b GROUP BY ORDERNUMBER ) c ON o.ORDERNUMBER  = c.ORDERNUMBER GROUP BY CUSTOMERNUMBER ORDER BY CUSTOMERNUMBER) d ON d.CUSTOMERNUMBER = cu.CUSTOMERNUMBER
RIGHT JOIN EMPLOYEES e ON cu.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER GROUP BY EMPLOYEENUMBER ORDER BY EMPLOYEENUMBER ;

--2. Który pracownik miał największą różnicę pomiędzy najdroższym a najtańszym produktem

--3. Ilu pracowników ma dane stanowisko

--4. Z którego kraju klient zrobił najdroższe zamówienie

--5. Który pracownik ma najwięcej klientów


--CRUDY
--6. Przeniesienia pracownika do innego biura

--7. Zmiana pracownika odpowiedzialnego za daną grupę klientów

--8. Zmniejszenie limitu kredytowego o 10% dla klientów którzy w wybranym miesiącu zrobili zamówienie na kwotę mniej niż 1000
