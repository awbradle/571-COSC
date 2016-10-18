5.1
Q1
SELECT S.sname 
FROM Students S, Class C, Enrolled E, Faculty F 
WHERE F.fid = C.fid AND F.fname = ''I. Teach' AND S.level = 'JR' AND
C.name = E.cname AND S.snum = E.snum;
Q2
SELECT max(A.age) 
FROM 
	(SELECT S.age FROM Students S WHERE S.major = 'History'
	UNION
	SELECT S.age name FROM Students S, Class C, Enrolled E, Faculty F
	Where S.snum = E.snum AND F.fname = 'I. Teach' AND F.fid = C.fid AND 
	C.name = E.cname) as A;
Q3
SELECT C.name 
FROM 
	(Select R.name From Class R WHERE R.room = 'R128'
	UNION
	Select Counted.name
	FROM
		(SELECT Five.name, count(Five.name) as counted
		FROM Enrolled Five group by Five.name) 
	as Num
	WHERE Num.counted > 4);
Q4
SELECT DISTINCT S.sname
FROM Class C1, Class C2, Student S, Enrolled E
WHERE C1.meets_at = C2.meets_at AND S.snum = E.snum AND C1.name = E.cname;
Q5
SELECT F.fname
FROM Faculty F
WHERE NOT EXISTS
	(SELECT C1.room
	FROM Class C1
	EXCEPT
	SELECT C2.room
	FROM Class C2
	WHERE F.fid = C2.fid); 
Q6
SELECT F.fname
FROM Faculty, (SELECT C.fid as fid, COUNT(E.snum) as enrollments
	       FROM Classes C, Enrolled E
	       WHERE E.fid = C.fid
	       GROUP BY facnum) as N
Where F.fid = N.fid AND N.enrollments < 5;
Q7
SELECT S.level, AVG(age)
FROM Students S
GROUP BY S.level;
Q8
SELECT S.level, AVG(age)
FROM Students S
WHERE level <> 'JR'
GROUP BY S.level;
Q9
SELECT S.sname 
FROM Students S,
	(SELECT snum, count(snum) as maxnum 
	FROM Enrolled GROUP BY snum) as Counted,
	(SELECT max(maxnum) as maxnum 
	FROM (SELECT snum, count(snum) as maxnum from Enrolled GROUP BY snum)) as Max
WHERE S.snum = Counted.snum AND Counted.maxnum = Max.maxnum;
Q10
SELECT S.sname
FROM Students S
WHERE S.snum NOT IN 
	(SELECT snum from Enrolled);
Q11
Select A.age, max(countlvl)
FROM	
	(SELECT S.age as age, S.level, count(S.level) as countlvl
	FROM Students S
	GROUP BY S.age, S.level) as A
GROUP BY A.age;
5.3
Q1
SELECT aname
FROM Aircraft 
EXCEPT
SELECT A.aname
FROM Aircraft A, Employees E, Certified C
WHERE A.aid = C.aid AND E.eid = C.eid AND E.salary < 80000
Q2
SELECT P.pilots, MAX(A.crusingrange)
FROM Aircraft A, Certified C,
	(SELECT eid as pilots, count(eid) as counted
	FROM Certified) as P
	Group By pilots
WHERE P.pilots > 3 AND A.aid = C.aid AND P.pilots = C.eid 
GROUP BY pilots;
Q3
SELECT E.ename, E.eid
FROM Employees,
	(SELECT MIN(F.price) as cheapest
	FROM Flights F
	WHERE from = 'Los Angeles' AND to = 'Honolulu) as Wages
WHERE E.salary < Wages.cheapest;
Q4
SELECT A.aid, AVG(E.salary)
FROM Employees E, Aircraft A, Certified C
WHERE E.eid = C.eid AND A.aid - C.aid AND A.cruisingrange > 1000
GROUP BY A.aid;
Q5
SELECT E.ename
FROM Employees E, Certified C, Aircraft A
WHERE E.eid = C.eid AND C.aid = a.aid AND A.name like 'BOEING%';
Q6
SELECT A.aid
FROM Aircraft A, Flights F
WHERE A.cruisingrange > F.distance AND F.from = 'Los Angeles' AND F.to = 'Chicago';
Q7
SELECT A.aid
FROM Aircraft A, Flights F
WHERE A.crusiingrange > F.distance;
SELECT F.flno
FROM Flights F
WHERE NOT EXISTS
	(SELECT E.eid
	FROM E.Employees
	WHERE E.salary > 100000
	EXCEPT 
	SELECT E.eid
	FROM EMPLOYEES E, Certified C, Aircraft A
	WHERE E.eid = C.eid AND A.aid = C.aid AND A.cruisingrange > F.distance);
Q8. 
SELECT E.ename
FROM Employees E, Aircraft A, Certified C
WHERE E.eid = C.eid AND A.aid = C.aid AND A.cruisingrange > 3000
EXCEPT
SELECT E.ename
FROM Employees E, Aircraft A, Certified C
WHERE E.eid = C.eid AND A.aid = C.aid AND A.aname NOT LIKE 'BOEING%';
Q9
SELECT flno
FROM Flights
WHERE from = 'Madison' AND to = 'New York' AND arrives < 18:00:00;

SELECT F1.flno, F2.flno
FROM Flights F1, Flights F2
WHERE F1.from = 'Madison' AND F2.to = 'New York' AND F2.arrives < 18:00:00
AND F1.arrives < F2.departs AND F1.to = F2.FROM;

SELECT F1.flno, F2.flno, F3.flno
FROM Flights F1, Flights F2, Flights F3
WHERE F1.from = 'Madison' AND F3.to = 'New York' AND F3.arrives < 18:00:00
AND F1.arrives < F2.departs AND F1.to = F2.FROM AND F2.arrives < F3.departs
AND F2.to = F3.from;
Q10
SELECT (P.pilots - A.allemp)
FROM
	(SELECT AVG(E.salary) as pilots
	FROM Employees E. Certified C
	WHERE E.eid in C.eid) as P,
	(SELECT AVG(E.salary) as allemp
	FROM Employees E) as A;
Q11
SELECT E.salary, E.ename
FROM Employees
	(SELECT AVG(E.salary) as pilots
	FROM Employees E. Certified C
	WHERE E.eid in C.eid) as P
WHERE E.salary > P.pilots
EXCEPT
SELECT E.salary E.name
FROM Employees, Certified C
WHERE E.eid = C.eid;
5.4
Q1
SELECT E.ename, E.age
FROM Emp E, Works W, Dept D
WHERE E.eid = W.eid AND W.did = D.did AND D.did = 'Hardware#'
INTERSECT
SELECT E.ename, E.age
FROM Emp E, Works W, Dept D
WHERE E.eid = W.eid AND W.did = D.did AND D.did = 'Software#';
Q2.
SELECT D.dept, count(W.eid)
FROM Works,
	(SELECT W.did as dept, SUM(W.pct_time) as hours
	FROM Works W
	GROUP BY dept) as D
WHERE D.dept = W.did AND D.hours > 20
GROUP BY D.dept;
Q3.
SELECT E.eid, E.ename
FROM Employees E, Works W, Dept D
WHERE E.eid = W.eid AND W.did = D.did AND E.salary > S.budget
EXCEPT
SELECT E.eid, E.ename
FROM Employees E, Works W, Dept D
WHERE E.eid = W.eid AND W.did = D.did AND E.salary < S.budget;
Q4.
SELECT D.managerid
FROM Dept D
WHERE D.budget > 1000000
INTERSECT
SELECT D.managerid
FROM Dept D
WHERE D.budget <= 1000000;
Q5.
SELECT E.ename
FROM Emp E, Dept D,
	(SELECT max(D.budget) as maxbud
	FROM Dept D) as B
WHERE E.eid = D.managerid AND B.maxbud = D.budget;
Q6.
SELECT M.man
FROM	
	(SELECT D.manager as man, SUM(D.budget) as totbud
	FROM Dept D
	GROUP BY D.manager) as M
WHERE M.totbud > 5000000;
Q7.
SELECT 
(SELECT MAX(totbud)
FROM	
	(SELECT D.manager as man, SUM(D.budget) as totbud
	FROM Dept D
	GROUP BY D.manager) as M)

	



