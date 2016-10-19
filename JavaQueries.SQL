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

