-- Q.No.6
DECLARE @sal DECIMAL(18,2)
SELECT @sal = AVG(Salary) FROm Employees

SELECT	First_Name+Last_Name 'Name',
		Salary SalaryDrawn,
		Salary-(@sal) AvgCompare,
		(SELECT (CASE WHEN Salary-(@sal) > 0 THEN 'High'
						WHEN Salary-(@sal) < 0 THEN 'Low'
						END)) SalaryStatus
FROM Employees
GO

WITH AvgSalary AS(
	SELECT  AVG(Salary) sal FROm Employees
) 

SELECT	First_Name+Last_Name 'Name',
		Salary SalaryDrawn,
		Salary-(a.sal) AvgCompare,
		(SELECT (CASE WHEN Salary-(a.sal) > 0 THEN 'High'
						WHEN Salary-(a.sal) < 0 THEN 'Low'
						END)) SalaryStatus
FROM Employees e
CROSS JOIN AvgSalary a




-- Q.No.11
SELECT First_Name+Last_Name Manager_Name, Department_Id FROM Employees
WHERE Employee_Id IN (

SELECT b.Manager_Id 
FROM 
	(SELECT Manager_Id, COUNT(Employee_Id) Under_Staff FROM Employees
							GROUP BY Manager_Id
							HAVING COUNT(Employee_Id) >=4) b
							)

SELECT E.* FROM Employees E INNER JOIN
(SELECT AVG(Salary)sal FROM Employees) T
ON E.Salary >= T.sal


--employees who report to manager based on US
SELECT e1.First_Name, e1.Last_Name 
FROM Employees e1 
		INNER JOIN Employees e2
			ON e1.Manager_Id = e2.Employee_Id
		INNER JOIN Department D
			ON e1.Department_Id = D.Department_Id
		INNER JOIN Locations L
			ON D.Location_Id = L.Location_Id
WHERE L.Country_Id = ' US'
ORDER BY e1.First_Name


-- Joins


