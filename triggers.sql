  --trigers

  Select * from [HumanResources].[Shift]
  Create trigger demotrigger
  ON [HumanResources].[Shift]
  After insert
  as
  begin
  print 'insert is not allowed'
  ROLLBACK TRANSACTION
  end
  go
  ---test
   --TEST THE TRIGGER
 INSERT INTO [HumanResources].[Shift]
 (
[Name],
[StartTime],
[EndTime],
[ModifiedDate])
VALUES
('RAKESH2'
,'07:00:00.0000000'
,'8:00:00.0000000'
,getdate()
)


CREATE TRIGGER DEMO_DBLEVELTRIGGER
ON DATABASE
AFTER CREATE_TABLE
AS
BEGIN
PRINT 'CREATION OF NEW TABLES NOT ALLOWED'
ROLLBACK TRANSACTION
END
GO

CREATE TABLE MYDEMOTABLE(Col1 varchar(10))

---start procuderes
create procedure MytestProc 
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
execute MytestProc

create procedure MytestProc2
AS
SET NOCOUNT off
SELECT * FROM [HumanResources].[Shift]

drop proc MytestProc
drop proc MytestProc2

create Procedure MyFirstParamProc
@param_name varchar(50)
as
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
where Name = @param_name

exec MyFirstParamProc @param_name = 'Day'
exec MyFirstParamProc 'Day'
drop proc MyFirstParamProc

create Procedure MyFirstParamProc1
@param_name varchar(50) = 'Evening'
as
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
where Name = @param_name
drop proc MyFirstParamProc1

--output parameter4s
create Procedure MyOutputParamProc1
@topshift varchar(50) Output
as
SET @topshift =
(SELECT top(1) ShiftID FROM [HumanResources].[Shift])

Declare @outputresult varchar(50)
exec MyOutputParamProc1 @outputresult output
select @outputresult

drop proc MyOutputParamProc1

create procedure myfirstReturningSp
AS 
return 12

Declare @tresult int
exec  @tresult = myfirstReturningSp
select @tresult

--user defined functions
SELECT * FROM [Sales].[SalesTerritory]

create function ytdSales()
Returns Money
as 
begin
Declare @ytdSales Money
select @ytdSales = sum(SalesYTD) from [Sales].[SalesTerritory]
return @ytdSales
end

declare @ytdSales as Money
select @ytdSales = dbo.ytdSales()
print @ytdSales

DROP FUNCTION ytdSales
--parameterized functions
SELECT * FROM [Sales].[SalesTerritory]

create function YD_GROUP
(@group varchar(50))
returns money
as
begin
declare @ytdSales as money
select @ytdSales = sum(SalesYTD) from [Sales].[SalesTerritory]
where [Group] = @group
return @ytdSales
end

declare @result Money
select @result = dbo.YD_GROUP('North America')
print @result

drop function YD_GROUP

---functions returning tables
create function st_Tabvalue
(@territoryID INT)
returns table
as return
select name, CountryRegionCode, [Group], SalesYTD from [Sales].[SalesTerritory]
where TerritoryID = @territoryID

select *from dbo.st_Tabvalue(7)


--Transaction
select * from [Sales].[SalesTerritory]

begin transaction
	Update Sales.SalesTerritory
	set CostYTD = 1.00
	where TerritoryID = 1
Commit transaction
--@@error
declare @errorResult varchar(50)
begin transaction
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'us'
           ,'na'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-11DE20267FF3'
           ,GETDATE())

Set @errorResult = @@ERROR
if(@errorResult = 0)
begin
	print 'success!!'
	commit transaction
end 
else
begin
	print'failed'
	rollback transaction
end

--custom error message
declare @errorResult varchar(50)
begin transaction
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'us'
           ,'na'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-11DE20267FF3'
           ,GETDATE())

Set @errorResult = @@ERROR
if(@errorResult = 0)
begin
	print 'success!!'
	commit transaction
end 
else
begin
	Raiserror('failed' , 16, 1)
	rollback transaction
end

-- try and catch
begin try
begin transaction
declare @errorResult varchar(50)
begin transaction
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC'
           ,'us'
           ,'na'
           ,1.00
           ,1.00
           ,1.00
           ,1.00
           ,'43689A10-E30B-497F-B0DE-11DE20267FF3'
           ,GETDATE())

		   commit transaction
end try

begin catch
	print 'catch statement entered'
	rollback transaction
end catch

--cte
with cte
as
(
	select Name, CountryRegionCode from Sales.SalesTerritory
)

select *from cte
where Name like 'North%'

select name, sum(SalesYTD) from Sales.SalesTerritory
Group by name 

UNION ALL

SELECT Name, CountryRegionCode, NULL,  SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode

UNION ALL

SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode,  [group]

---GROUPING SETS
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY GROUPING SETS
(
	(Name),
	(Name, CountryREgionCode),
	(Name, CountryRegionCode, [Group])
)
--rolloup
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY rollup
(
	(Name, CountryRegionCode, [Group])
)

--cube
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY cube
(
	(Name, CountryRegionCode, [Group])
)
---ranking function
select * from [Person].Address

select PostalCode from [Person].Address
where PostalCode in ('98011', '98027', '98055')

select PostalCode,
ROW_NUMBER() over (order by PostalCode) as 'row number',
RANK() over (order by PostalCode) as 'rank number',
DENSE_RANK() over (order by PostalCode) as 'desk rank ',
NTILE(10) over (order by PostalCode) as 'ntle number'
 from [Person].Address
where PostalCode in ('98011', '98027', '98055')

---PIVOT
select * from sales.salesterritory

select countryregioncode, [group], salesytd
from sales.salesterritory

select countryregioncode , [North America], [Europe]
from sales.salesterritory
pivot 
(
	sum(salesytd) for [group]
	in ([North America], [Europe], [Pacific])
)
as pvt

---Dynamic Queries
declare @sqlstring varchar(2000)
set @sqlstring = 'select countryregioncode, [group], '
set @sqlstring = @sqlstring + 'salesytd from sales.salesterritory'

print @sqlstring 
exec (@sqlstring)
