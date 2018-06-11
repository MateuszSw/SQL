use [AdventureWorks2016CTP3]

SELECT * FROM [HumanResources].[Department]

--SHOW ME ALL THE DEPARTMENT NAMES
SELECT Name FROM [HumanResources].[Department]
 --SHOW me all group
 SELECT GROUPNAME FROM [HumanResources].[Department]
 -- show all the distinct groupname
 SELECT DISTINCT GROUPNAME FROM [HumanResources].[Department]

 SELECT * FROM [HumanResources].[Department] WHERE GROUPNAME LIKE 'Manufacturing'

 SELECT * FROM [HumanResources].[Employee] WHERe OrganizationLevel = 2

 SELECT * FROM [HumanResources].[Employee] WHERe OrganizationLevel IN(2,3)

  SELECT * FROM [HumanResources].[Employee] WHERe JobTitle Like '%Manager'

SELECT * FROM [HumanResources].[Employee] WHERE Birthdate > '1/1/1980'
--Calculated columns
Select * from [Production].[Product] 

Select NAME, ListPrice, ListPrice + 10 as AdjustedListPrice from [Production].[Product] 

Select NAME, ListPrice, ListPrice + 10 as AdjustedListPrice INTO [Production].[Product2] from [Production].[Product] 

Update [Production].[Product2] 
Set name = 'Blade_New' 
Where Name Like 'BLADE'

--JOINS
DROP TABLE MYEMPLOYEE
DROP TABLE MYSALARY