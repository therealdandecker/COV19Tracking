USE [Development]
GO

/****** Object:  View [dbo].[vUSCovidData]    Script Date: 11/22/2020 12:53:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create View [dbo].[vUSCovidData] as

SELECT 
cast([CreateDate] as date) as RecordedDate
--,[UpdateDate]
,[USAState]
,max([TotalCases]) as TotalCases
,max([NewCases]) as NewCases
,max([TotalDeaths]) as TotalDeaths
,max([NewDeaths]) as NewDeaths
,max([ActiveCases]) as ActiveCases
,max([TotalTests]) as TotalTests
  FROM [Development].[dbo].[USCovidData]


  Group by 

  cast([CreateDate] as date) 
--,[UpdateDate]
,[USAState]
GO


