--SELECTY
--1. Zarobek wygenerowany z zamówień przez wybranego pracownika

SELECT EMPLOYEENUMBER, SUM(EARNED) AS EARNED FROM CUSTOMERS cu INNER JOIN (
SELECT SUM(EARNED) AS EARNED, CUSTOMERNUMBER FROM ORDERS o INNER JOIN (
SELECT SUM(EARNED) AS EARNED, ORDERNUMBER FROM(
SELECT (PRICEEACH * QUANTITYORDERED) - (BUYPRICE * QUANTITYORDERED) AS EARNED, ORDERNUMBER FROM (
SELECT * FROM PRODUCTS p INNER JOIN ORDERDETAILS od ON od.PRODUCTCODE = p.PRODUCTCODE) a ORDER BY ORDERNUMBER ) b GROUP BY ORDERNUMBER ) c ON o.ORDERNUMBER  = c.ORDERNUMBER GROUP BY CUSTOMERNUMBER ORDER BY CUSTOMERNUMBER) d ON d.CUSTOMERNUMBER = cu.CUSTOMERNUMBER
RIGHT JOIN EMPLOYEES e ON cu.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER WHERE EMPLOYEENUMBER = 1216 GROUP BY EMPLOYEENUMBER ORDER BY EMPLOYEENUMBER ;

--2. Który pracownik miał największą różnicę pomiędzy najdroższym a najtańszym produktem
SELECT MAX(DIFFERENCE), EMPLOYEENUMBER FROM (
SELECT MAX(BUYPRICE) - MIN(BUYPRICE) AS DIFFERENCE, EMPLOYEENUMBER FROM (
SELECT e.EMPLOYEENUMBER, o.ORDERNUMBER, QUANTITYORDERED, PRICEEACH, p.PRODUCTNAME, p.BUYPRICE FROM EMPLOYEES e INNER JOIN CUSTOMERS c ON c.SALESREPEMPLOYEENUMBER = e.EMPLOYEENUMBER INNER JOIN ORDERS o ON o.CUSTOMERNUMBER  = c.CUSTOMERNUMBER INNER JOIN ORDERDETAILS od ON od.ORDERNUMBER = o.ORDERNUMBER INNER JOIN PRODUCTS p ON p.PRODUCTCODE = od.PRODUCTCODE) a
GROUP BY EMPLOYEENUMBER) b GROUP BY EMPLOYEENUMBER ORDER BY MAX(DIFFERENCE);

--3. Ilu pracowników ma dane stanowisko

SELECT COUNT(*) AS nr, JOBTITLE FROM EMPLOYEES e GROUP BY JOBTITLE ORDER BY nr desc;

--4. Z którego kraju klient zrobił najdroższe zamówienie
SELECT o.ORDERNUMBER, ORDERPRICE, COUNTRY FROM (
(SELECT SUM(ORDERPRICE) AS ORDERPRICE, ORDERNUMBER FROM (
SELECT ORDERNUMBER, PRICEEACH * QUANTITYORDERED AS ORDERPRICE FROM ORDERDETAILS o) GROUP BY ORDERNUMBER)) a INNER JOIN ORDERS o ON o.ORDERNUMBER = a.ORDERNUMBER INNER JOIN CUSTOMERS c ON c.CUSTOMERNUMBER = o.CUSTOMERNUMBER ORDER BY ORDERPRICE desc;

--5. Który pracownik ma najwięcej klientów
SELECT COUNT(*) AS Nr, SALESREPEMPLOYEENUMBER FROM CUSTOMERS c GROUP BY SALESREPEMPLOYEENUMBER ORDER BY NR desc;


--CRUDY
--6. Przeniesienia pracownika do innego biura
SELECT EMPLOYEENUMBER, OFFICECODE FROM EMPLOYEES WHERE EMPLOYEENUMBER  = 1076;
-- 1076 należy do office 1

UPDATE EMPLOYEES SET OFFICECODE = 2 WHERE EMPLOYEENUMBER  = 1076;
-- 1076 należy do office 2

--7. Zmiana pracownika odpowiedzialnego za daną grupę klientów
SELECT COUNT(*) FROM CUSTOMERS c WHERE SALESREPEMPLOYEENUMBER  = 1076;
-- 1076 nie ma żadnych klientów

SELECT COUNT(*) FROM CUSTOMERS c WHERE SALESREPEMPLOYEENUMBER  = 1216;
-- 1216 ma 6 klientów

UPDATE CUSTOMERS SET SALESREPEMPLOYEENUMBER = 1076 WHERE SALESREPEMPLOYEENUMBER = 1216;

--8. Zmniejszenie limitu kredytowego o 10% dla klientów którzy w wybranym miesiącu zrobili zamówienie na kwotę mniej niż 20 000
-- Na razie tylko select z id klientów którym trzeba zmienić kredyt

SELECT customernumber FROM (
SELECT SUM(payment) AS payment, CUSTOMERNUMBER FROM (
SELECT SUM(PRICEEACH * QUANTITYORDERED) AS payment, c.CUSTOMERNUMBER FROM CUSTOMERS c
LEFT JOIN ORDERS o ON o.CUSTOMERNUMBER = c.CUSTOMERNUMBER
LEFT JOIN ORDERDETAILS od ON o.ORDERNUMBER = od.ORDERNUMBER WHERE EXTRACT(MONTH FROM o.ORDERDATE) = 1 AND EXTRACT(YEAR FROM o.ORDERDATE) = 2005 GROUP BY c.CUSTOMERNUMBER, od.ORDERNUMBER, od.PRODUCTCODE) a GROUP BY Customernumber) WHERE payment < 20000;
