/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SalesTaxRateID]
      ,[StateProvinceID]
      ,[TaxType]
      ,[TaxRate]
      ,[Name]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2016CTP3].[Sales].[SalesTerritory]

  Create view MycustomUSView AS
  Select * FROM [AdventureWorks2016CTP3].[Sales].[SalesTerritory]
  Where CountryRegionCode like 'US'

  Select * from MycustomUSView

  CREATE VIEW NASALESQUTA AS
  SELECT [name], [GROUP], [SalesQuota], [Bonus] FROM [AdventureWorks2016CTP3].[Sales].[SalesTerritory] a
  inner join [Sales].[SalesPerson] b on a.TerritoryID = b.TerritoryID
  where [GROUP] like 'North America'

  select * from NASALESQUTA


