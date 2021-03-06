Create database [DWHDemo]
GO

USE [DWHDemo]
GO

CREATE TABLE [dbo].[DWH_employee](
	[Emp_No] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DOB] [nvarchar](100) NULL,
	[Gender] [nvarchar](100) NULL,
	[Salary] [int] NULL,
	[City] [nvarchar](50) NULL
)  
GO

CREATE TABLE [dbo].[DWH_employee_Destination](
	[Emp_No] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DOB] [nvarchar](100) NULL,
	[Gender] [nvarchar](100) NULL,
	[Salary] [int] NULL,
	[City] [nvarchar](50) NULL
)  
GO


INSERT INTO [dbo].[DWH_employee] ([Emp_No], [Name], [DOB], [Gender], [Salary], [City]) VALUES (100, 'Mahesh', '1965-12-01', 'Male', 30000, 'Delhi')
INSERT INTO [dbo].[DWH_employee] ([Emp_No], [Name], [DOB], [Gender], [Salary], [City]) VALUES (101, 'Suresh', '1963-11-14', 'Male', 34000, 'Delhi')
INSERT INTO [dbo].[DWH_employee] ([Emp_No], [Name], [DOB], [Gender], [Salary], [City]) VALUES (102, 'Rajat', '1969-12-21', 'Male', 23000, 'Shimla')
INSERT INTO [dbo].[DWH_employee] ([Emp_No], [Name], [DOB], [Gender], [Salary], [City]) VALUES (103, 'Kalpana', '1961-12-01', 'Female', 40000, 'Goa')
GO


ALTER TABLE DWH_employee_Destination
ADD Isdeleted INT NOT NULL DEFAULT 0




SELECT is_cdc_enabled,*
FROM SYS.databases
WHERE name='DWHDemo'
 
----------------Enable CDC at Database Level-----------
Use DWHDemo
EXEC SYS.SP_CDC_ENABLE_DB

----------------Enable CDC at table---------------

EXEC SYS.SP_CDC_ENABLE_TABLE
	@SOURCE_SCHEMA = 'dbo',
	@SOURCE_NAME = 'cdc_states',
	@ROLE_NAME = NULL,
	@SUPPORTS_NET_CHANGES=0



select * from DWH_employee
truncate table DWH_employee_Destination
select * from DWH_employee_Destination
select * from cdc_states