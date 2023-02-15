CREATE DATABASE Office_Training
GO

USE Office_Training
GO

CREATE TABLE Jobs(
	Job_Id varchar(50),
	Job_Title varchar(50),
	Min_Salary Decimal(18,2) DEFAULT 0,
	Max_Salary Decimal(18,2) DEFAULT 0,
	Constraint PK_Jobs_Job_Id PRIMARY KEY (Job_Id)
);
GO

CREATE TABLE Locations(
	Location_Id int,
	Street_Address varchar(50) ,
	Postal_Code varchar(50),
	City varchar(50),
	State_Province varchar(50) ,
	Country_Id varchar(50),
	CONSTRAINT PK_Location_Location_Id PRIMARY KEY (Location_id)
);
GO

CREATE TABLE Department(
	Department_Id int,
	Department_Name varchar(50),
	Manager_Id int,
	Location_Id int,
	CONSTRAINT PK_Department_Department_Id PRIMARY KEY(Department_Id),
	CONSTRAINT FK_Department_Location_Id FOREIGN KEY(Location_Id) REFERENCES Locations(Location_Id)
)
GO


CREATE TABLE Employees(
	Employee_Id int,
	First_Name varchar(50),
	Last_Name varchar(50),
	Email varchar(50),
	Phone varchar(50),
	Hire_Date date,
	Job_Id varchar(50),
	Salary Decimal(18,2) DEFAULT 0,
	Commission Decimal(18,2) DEFAULT 0,
	Manager_Id int,
	Department_Id int,
	CONSTRAINT PK_Employees_Employee_Id PRIMARY KEY(Employee_Id),
	CONSTRAINT FK_Employees_Job_Id FOREIGN KEY(Job_Id) REFERENCES Jobs(Job_Id),
	CONSTRAINT FK_Employees_Department_Id FOREIGN KEY(Department_Id) REFERENCES Department(Department_Id)
);
GO

CREATE TABLE Job_History(
	Employee_Id int,
	Strt_Date date,
	End_Date date,
	Job_Id varchar(50),
	Department_Id int,
	CONSTRAINT FK_Job_History_Employee_Id FOREIGN KEY(Employee_Id) REFERENCES Employees(Employee_Id),
	CONSTRAINT FK_Job_History_Job_Id FOREIGN KEY(Job_Id) REFERENCES Jobs(Job_Id),
	CONSTRAINT FK_Job_History_Department_Id FOREIGN KEY(Department_Id) REFERENCES Department(Department_Id)
);
GO

--ALTER TABLE Employees
--	ADD CONSTRAINT FK_Department_Manager_Id FOREIGN KEY(Manager_Id) REFERENCES Employees(Employee_Id)
--GO
DROP DATABASE Office_Training