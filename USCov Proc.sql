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
