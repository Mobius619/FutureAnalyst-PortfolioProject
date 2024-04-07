/*****  Ramir Aguilo  *****/
/*****  Intro to SQL Programming Language Project  *****/


/*****  Question #1: Provide a report displaying 10 artists with the most sales 
from July 2011 through June 2012  *****/

SELECT TOP 10 WITH TIES 
	A.Name AS [Artist Name]
	,SUM(IL.UnitPrice * IL.Quantity) AS [Total Sales]
FROM Artist A
LEFT JOIN Album AL
	ON AL.ArtistId = A.ArtistId
LEFT JOIN Track T
	ON T.AlbumId = AL.AlbumId
LEFT JOIN InvoiceLine IL
	ON IL.TrackId = T.TrackId
LEFT JOIN Invoice I
	ON I.InvoiceId = IL.InvoiceId
WHERE InvoiceDate BETWEEN '7/1/2011' AND '6/30/2012'
	AND MediaTypeId != 3
GROUP BY A.Name
ORDER BY [Total Sales] DESC
		, A.Name
			


/*****  Question #2: Provide a report displaying total sales for all Sales Support Agents
        grouped by year and quarter  *****/

SELECT 
	CONCAT(E.FirstName,' ',E.LastName) AS [Full Name]
	,YEAR(InvoiceDate) AS [Calendar Year]
	,CASE
		WHEN DATENAME(QUARTER,InvoiceDate) = 1 THEN 'First'
		WHEN DATENAME(QUARTER,InvoiceDate) = 2 THEN 'Second'
		WHEN DATENAME(QUARTER,InvoiceDate) = 3 THEN 'Third'
		ELSE 'Fourth'
		END [Sales Quarter]
	,MAX(Total) AS [Highest Sale]
	,COUNT(InvoiceId) AS [Number Of Sales]
	,SUM(I.Total) AS [Total Sales]
FROM Employee E
LEFT JOIN Customer C
	ON C.SupportRepId = E.EmployeeId
LEFT JOIN Invoice I
	ON I.CustomerId = C.CustomerId
WHERE InvoiceDate BETWEEN '1/1/2010' AND '6/30/2012'
GROUP BY
	E.FirstName
	,E.LastName
	,YEAR(InvoiceDate)
	,DATENAME(QUARTER,InvoiceDate)

	   
/***** Question #3: Write a report that displays the duplicate Playlist IDs 
		and Playlist Names, as well as any associated Track IDs if they exist  *****/
SELECT 
	(P.Name) AS [Playlist Name]
	,(P.PlaylistId) AS [Playlist ID]
	,TrackId AS [Track ID]
FROM Playlist P
LEFT JOIN PlaylistTrack PT
	ON PT.PlaylistId = P.PlaylistId
WHERE EXISTS(
	SELECT *
	FROM Playlist P2
	GROUP BY P2.Name
	HAVING COUNT(*) > 1
		AND MAX(P2.PlaylistId) = P.PlaylistId
)


/***** Question #4: Provide a report that displays the Customer country 
       and the Artist name*****/

SELECT
	 BillingCountry AS Country
	 ,A.Name AS [Artist Name]
	 ,COUNT(*) AS [Track Count]
	 ,COUNT(DISTINCT T.Name) AS [Unique Track Count]
	 ,COUNT(*) - COUNT(DISTINCT T.Name) AS [Count Difference]
	 ,SUM(IL.UnitPrice * IL.Quantity) AS [Total Revenue]
	 ,IIF(T.MediaTypeId = 3, 'Video','Audio') AS [Media Type]
FROM Artist A
JOIN Album AL
	ON AL.ArtistId = A.ArtistId
JOIN Track T
	ON T.AlbumId = AL.AlbumId
JOIN InvoiceLine IL
    ON IL.TrackId = T.TrackId
JOIN Invoice I
	ON I.InvoiceId = IL.InvoiceId
WHERE 
	(InvoiceDate BETWEEN  '7/1/2009'  AND  '6/30/2013')
GROUP BY
		 I.BillingCountry
	     ,A.Name
		 ,IIF(T.MediaTypeId = 3, 'Video','Audio')  
ORDER BY	
		Country
		,[Track Count] DESC
		,[Artist Name]


/*****  Question #5:  HR wants to plan birthday celebrations for all employees in 2016. 
		They would like a list of employee names and birth dates, as well as the day of
		the week the birthday falls on in 2016  *****/

SELECT 
		CONCAT(FirstName,' ',LastName) AS [Full Name]
		,CONVERT(varchar, BirthDate, 101) AS [Birth Date]
		,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar) AS [Birth Day 2016]
		,DATENAME(WEEKDAY,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar)) AS [Birth Day Of Week]
		,CASE
			WHEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar)) = 'Saturday' THEN LEFT(CONVERT(varchar,DATEADD(DAY,2,BirthDate),101),6)+CAST(2016 AS varchar)
			WHEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar)) = 'Sunday' THEN LEFT(CONVERT(varchar,DATEADD(DAY,1,BirthDate),101),6)+CAST(2016 AS varchar)
			ELSE LEFT(CONVERT(varchar,BirthDate,101),6)+CAST(2016 AS varchar)
			END [Celebration Date]
		,CASE
			WHEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar)) = 'Saturday' THEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar,DATEADD(DAY,2,BirthDate),101),6)+CAST(2016 AS varchar))
			WHEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar, BirthDate, 101),6)+CAST(2016 AS varchar)) = 'Sunday' THEN DATENAME(WEEKDAY,LEFT(CONVERT(varchar,DATEADD(DAY,1,BirthDate),101),6)+CAST(2016 AS varchar))
			ELSE DATENAME(WEEKDAY,LEFT(CONVERT(varchar,BirthDate,101),6)+CAST(2016 AS varchar))
			END [Celebration Day of Week]
FROM Employee 
	
	






