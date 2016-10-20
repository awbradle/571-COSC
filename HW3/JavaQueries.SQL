SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice desc
LIMIT 10;

SELECT CompanyName, ContactName, Fax
FROM Customers
WHERE Fax NOT NULL;

Select E.City, E.Emptot
FROM	
	(SELECT E.City, COUNT(E.EmployeeID) as Emptot
	FROM Employees E
	GROUP BY E.City) as E
Where E.Emptot >= 2;

Select E.city, E.emp, C.cust
FROM
	(SELECT E.city, COUNT(E.city) AS emp
	FROM Employees E
	GROUP BY E.city) as E
LEFT JOIN
	(SELECT C.city, COUNT(C.city) AS cust
	FROM Customers C
	GROUP BY C.city) as C
ON E.city = C.city

Select C.city, C.cust, E.emp
FROM
	(SELECT C.city, COUNT(C.city) AS cust
	FROM Customers C
	GROUP BY C.city) as C
LEFT JOIN
	(SELECT E.city, COUNT(E.city) AS emp
	FROM Employees E
	GROUP BY E.city) as E
ON C.city = E.city;

Select E.city, E.emp, C.cust FROM (SELECT E.city, COUNT(E.city) AS emp FROM Employees E GROUP BY E.city) as E LEFT JOIN (SELECT C.city, COUNT(C.city) AS cust FROM Customers C GROUP BY C.city) as C ON E.city = C.city

Select C.city, C.cust, E.emp FROM (SELECT C.city, COUNT(C.city) AS cust FROM Customers C GROUP BY C.city) as C LEFT JOIN (SELECT E.city, COUNT(E.city) AS emp FROM Employees E GROUP BY E.city) as E ON C.city = E.city;