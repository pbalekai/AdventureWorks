--Total revenue
SELECT a.postalcode, Sum(sod.LineTotal) AS totalrevenue
FROM Production.Product AS p 
INNER JOIN Sales.SalesOrderDetail AS sod on p.ProductID = sod.ProductID 
INNER JOIN sales.SalesOrderHeader sh on sh.SalesOrderID = sod.SalesOrderID
INNER JOIN Sales.Customer c on c.CustomerID = sh.CustomerID
INNER JOIN Person.Person pe ON pe.BusinessEntityID = c.PersonID
INNER JOIN [Person].[BusinessEntityAddress] bea ON bea.[BusinessEntityID] = pe.[BusinessEntityID] 
INNER JOIN [Person].[Address] a ON a.[AddressID] = bea.[AddressID]
WHERE sh.TerritoryID IN ( 1,2,3,4,5)
AND sod.ProductID IN (select DISTINCT ProductID FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE soh.SalesPersonID=276)
GROUP BY a.PostalCode


--Most popular product category
SELECT a.postalcode, Max(p.ProductID) as ProductID, p.Name
FROM Production.Product AS p 
INNER JOIN Sales.SalesOrderDetail AS sod on p.ProductID = sod.ProductID 
INNER JOIN sales.SalesOrderHeader sh on sh.SalesOrderID = sod.SalesOrderID
INNER JOIN  [Sales].[Customer] c on c.TerritoryID = sh.TerritoryID  AND c.CustomerID = sh.CustomerID
INNER JOIN Person.Person pe ON pe.BusinessEntityID = c.PersonID
INNER JOIN [Person].[BusinessEntityAddress] bea ON bea.[BusinessEntityID] = pe.[BusinessEntityID] 
INNER JOIN [Person].[Address] a ON a.[AddressID] = bea.[AddressID]
WHERE sh.TerritoryID IN ( 1,2,3,4,5)
AND sod.ProductID IN (select DISTINCT ProductID FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE soh.SalesPersonID=276)
GROUP BY a.PostalCode, p.Name

--Name of company
select * from Sales.Store
where Name LIKE 'two wheels%'

--Products associated with this company
SELECT DISTINCT ProductID FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE soh.SalesPersonID=276
AND ProductID IN (878,711,858)

--Average amount of transactions for each product
select a.postalcode, AVG(sd.LineTotal)as Average from sales.SalesOrderDetail sod
INNER JOIN Production.Product p ON p.ProductID = sod.ProductID
INNER JOIN Sales.SalesOrderDetail AS sd on p.ProductID = sd.ProductID 
INNER JOIN sales.SalesOrderHeader sh on sh.SalesOrderID = sod.SalesOrderID
INNER JOIN Sales.Customer c on c.TerritoryID = sh.TerritoryID  AND c.CustomerID = sh.CustomerID
INNER JOIN Person.Person pe ON pe.BusinessEntityID = c.PersonID
INNER JOIN [Person].[BusinessEntityAddress] bea ON bea.[BusinessEntityID] = pe.[BusinessEntityID] 
INNER JOIN [Person].[Address] a ON a.[AddressID] = bea.[AddressID]
where sh.TerritoryID IN(1,2,3,4,5)
AND sod.ProductID IN (select DISTINCT ProductID FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE soh.SalesPersonID=276)
GROUP BY a.PostalCode


--Number of distinct buyers based n postal code
SELECT a.PostalCode, COUNT(vw.PostalCode) as DistinctBuyers
FROM  Sales.vIndividualCustomer vw 
INNER JOIN (SELECT DISTINCT customerID, personID, TerritoryID FROM Sales.Customer) c on vw.BusinessEntityID = c.PersonID
INNER JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN Person.Person pe ON pe.BusinessEntityID = c.PersonID
INNER JOIN [Person].[BusinessEntityAddress] bea ON bea.[BusinessEntityID] = pe.[BusinessEntityID] 
INNER JOIN [Person].[Address] a ON a.[AddressID] = bea.[AddressID]
WHERE c.TerritoryID IN ( 1,2,3,4,5)
AND sod.ProductID IN (select DISTINCT ProductID FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE soh.SalesPersonID=276)
GROUP BY a.PostalCode

 
