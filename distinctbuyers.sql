SELECT vw.PostalCode, COunt(vw.PostalCode) as DistinctBuyers
FROM  [Sales].[vIndividualCustomer] vw 
	INNER JOIN (SELECT DISTINCT customerID, personID, TerritoryID FROM [Sales].[Customer]) c 
		on vw.BusinessEntityID = c.PersonID
WHERE c.TerritoryID in ( 1,2,3,4,5)
GROUP BY vw.PostalCode