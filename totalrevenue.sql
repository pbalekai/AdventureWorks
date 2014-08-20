SELECT vw.postalcode, Sum((OrderQty * UnitPrice) * (1.0 - UnitPriceDiscount)) AS totalrevenue
FROM Production.Product AS p 
	INNER JOIN Sales.SalesOrderDetail AS sod on p.ProductID = sod.ProductID 
	inner join sales.SalesOrderHeader sh on sh.SalesOrderID = sod.SalesOrderID
	INNER JOIN  [Sales].[Customer] c on c.TerritoryID = sh.TerritoryID  and c.CustomerID = sh.CustomerID
	inner join [Sales].[vIndividualCustomer] vw  on vw.BusinessEntityID = c.PersonID
	--AND 
WHERE sh.TerritoryID in ( 1,2,3,4,5)
GROUP BY vw.PostalCode