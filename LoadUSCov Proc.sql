USE [Development]
GO
/****** Object:  StoredProcedure [dbo].[LoadUSCov]    Script Date: 11/22/2020 12:53:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Procedure to Load Table */
ALTER Procedure [dbo].[LoadUSCov] as 

Begin

Update USCovidData
Set ActiveInd = 0, UpdateDate = getdate();



Insert into USCovidData
Select
getdate() as CreateDate,
getdate() as UpdateDate,
USAState,
TotalCases, 
replace(replace(NewCases,'+',''),',','') as NewCases,
TotalDeaths,
replace(replace(NewDeaths,'+',''),',',''),
ActiveCases,
TotalTests,
1 as ActiveRecord
from USCov

End
