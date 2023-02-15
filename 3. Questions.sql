USE Office_Training
GO
-- Subqueries

-- Q.No.1
-- employees whose salary matches the lowest salary of any of the departments
SELECT First_Name, Last_Name, Department_Id, Salary 
FROM Employees E INNER JOIN (SELECT  MIN(Salary) sal FROM Employees) T 
	ON E.Salary = T.sal


-- Q.No.2
-- employees who work in the Finance department
SELECT E.Department_Id, E.First_Name, E.Job_Id, D.Department_Name 
FROM Employees E INNER JOIN Department D 
	ON E.Department_Id=D.Department_Id
WHERE D.Department_Name='Finance' 

-- Q.No.3
-- employees whose salary is in the range of 1000, and 3000 
SELECT * FROM Employees
WHERE Salary BETWEEN 1000 AND 3000


-- Q.No.4
-- employees who get second-highest salary. Return all the fields of the employees
SELECT E.* 
FROM Employees E INNER JOIN
				(	SELECT Employee_Id, First_Name, Salary, DENSE_RANK() OVER(ORDER BY Salary DESC) AS Salary_Rank 
					FROM Employees
				) T
	ON E.Employee_Id = T.Employee_Id
WHERE T.Salary_Rank = 2




-- Q.No.5
-- employees whose salary is lower than that of employees whose job title is "MK_MAN"
SELECT * FROM Employees
WHERE Salary <
(SELECT Salary FROM Employees WHERE Job_Id = ' MK_MAN') AND Job_Id <> ' MK_MAN'

SELECT * FROM Employees E
LEFT JOIN
(SELECT Employee_Id, Salary FROM Employees WHERE Job_Id = ' MK_MAN') T
on E.Employee_Id <> T.Employee_Id
WHERE E.Salary < T.Salary


-- Q.No.6
-- employees with salaries exceeding 3700
SELECT First_Name, Last_Name, Department_Id 
FROM Employees 
WHERE EXISTS (SELECT 1 FROM Employees WHERE Salary > 3700)

IF EXISTS(SELECT 1 FROM Employees WHERE Salary > 3700)
	SELECT First_Name, Last_Name, Department_Id 
	FROM Employees


-- Q.No.7
-- employees who work in departments located in the United Kingdom
SELECT First_Name 
FROM Employees 
WHERE Department_Id IN (
						SELECT Department_Id 
						FROM Department 
						WHERE Location_Id IN(	
												SELECT Location_Id 
												FROM Locations 
												Where Country_Id = ' UK'
											) 
						)

SELECT E.First_Name, D.Department_Name, L.Country_Id 
FROM Employees E
	INNER JOIN Department D
		ON E.Department_Id = D.Department_Id
	INNER JOIN Locations L
		ON D.Location_Id = L.Location_Id
WHERE L.Country_Id=' UK'

-- Q.No.8
-- employees who are managers
SELECT * 
FROM Employees 
WHERE Employee_Id IN (SELECT Manager_Id FROM Employees )

SELECT e1.* FROM Employees e1 INNER JOIN
(SELECT DISTINCT Manager_Id FROM Employees) e2
ON e1.Employee_Id = e2.Manager_Id


-- Q.No.9
-- employees who earn more than the average salary
SELECT First_Name, Last_Name, Salary, Department_Id
FROM Employees 
WHERE Salary >(SELECT AVG(Salary) FROM Employees) 
Order By Salary DESC

SELECT First_Name, Last_Name, Salary, Department_Id
FROM Employees E INNER JOIN (SELECT  AVG(Salary)sal FROM Employees)T
	ON E.Salary > T.sal
Order By E.Salary DESC


-- Q.No.10
-- those employees who earn more than the minimum salary of a department of ID 40
SELECT First_Name, Last_Name, Salary, Department_Id
FROM Employees 
WHERE Salary > (
SELECT MIN(Salary) FROM Employees WHERE Department_Id = 40 )

SELECT First_Name, Last_Name, Salary, Department_Id
FROM Employees E
INNER JOIN 
(SELECT  MIN(Salary)sal FROM Employees WHERE Department_Id = 40 ) T
ON E.Salary>T.sal

-- Q.No.11
-- departments where maximum salary is 7000 and above. 
-- The employees worked in those departments have already completed one or more jobs. 
-- Return all the fields of the departments
SELECT * FROM Department
WHERE Department_Id IN(
					SELECT Department_Id 
					FROM Employees 
					WHERE Salary >= 7000 AND Employee_Id IN(
															SELECT a.Employee_Id FROM
															(	SELECT Employee_Id, Department_Id, COUNT(Employee_Id) Jobs_No 
																FROM Job_History
																GROUP BY Employee_Id, Department_Id
																HAVING COUNT(Employee_Id) >1
															) a
														   )
					)

SELECT D.*,E.Salary,E.Employee_Id FROM Department D 
						INNER JOIN Employees E 
							ON D.Department_Id = E.Department_Id
						INNER JOIN (SELECT Employee_Id, Department_Id, COUNT(Employee_Id) Jobs_No 
																FROM Job_History
																GROUP BY Employee_Id, Department_Id
																HAVING COUNT(Employee_Id) >1
															) a
							ON E.Employee_Id = a.Employee_Id
WHERE E.Salary >= 7000

-- Q.No.12
-- employees who earn the second-lowest salary of all the employees
SELECT E.* 
FROM Employees E INNER JOIN
				(	SELECT Employee_Id, First_Name, Salary, DENSE_RANK() OVER(ORDER BY Salary) AS Salary_Rank 
					FROM Employees
				) T
	ON E.Employee_Id = T.Employee_Id
WHERE T.Salary_Rank = 2




-- JOINS

-- Q.No.1
-- find the first name, last name, department, city, and state province for each employee
SELECT E.First_Name, E.Last_Name, D.Department_Name, L.City, L.State_Province 
FROM Employees E INNER JOIN Department D
			ON E.Department_Id = D.Department_Id
			INNER JOIN Locations L
			ON D.Location_Id = L.Location_Id



-- Q.No.2
-- find all departments, including those without employees
SELECT DISTINCT E.First_Name, E.Last_Name, D.Department_Id, D.Department_Name 
FROM Employees E RIGHT JOIN Department D
	ON E.Department_Id = D.Department_Id


-- Q.No.3
-- the department name, city, and state province for each department
SELECT D.Department_Id, D.Department_Name, L.City, L.State_Province 
FROM Department D INNER JOIN Locations L
	ON D.Location_Id = L.Location_Id


-- Q.No.4
-- find all employees who joined on or after 1st January 1993 and on or before 31 August 1997
SELECT E.First_Name, E.Last_Name, D.Department_Name, J.Job_Title 
FROM Employees E INNER JOIN Department D
	ON E.Department_Id = D.Department_Id
	INNER JOIN Jobs J
	ON E.Job_Id = J.Job_Id
	INNER JOIN Job_History JH
	ON E.Employee_Id = JH.Employee_Id
WHERE JH.Strt_Date BETWEEN '1993/01/01' AND '1997/08/31'


-- Q.No.5
-- find the name of the country, city, and departments, which are running there.
SELECT L.City, L.Country_Id, D.Department_Name 
FROM Locations L INNER JOIN Department D
	ON L.Location_Id = D.Location_Id
ORDER BY L.City


-- Q.No.6
--  find the department name, full name (first and last name) of the manager and their city
SELECT DISTINCT E.First_Name+E.Last_Name Full_Name, D.Department_Name, L.City 
FROM Employees E INNER JOIN Department D
		ON E.Manager_Id = D.Manager_Id 
	INNER JOIN Locations L
		ON D.Location_Id = L.Location_Id