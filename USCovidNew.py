#!/usr/bin/env python
# coding: utf-8

#Import libraries 
from bs4 import BeautifulSoup
import sqlalchemy
from sqlalchemy import create_engine
import requests
import pandas as pd
#Create SQL Connection
conn = create_engine('mssql+pyodbc://@DV', fast_executemany=True)
cnxn = conn.raw_connection()


#Scrape infection data for the United States by state
res = requests.get("https://www.worldometers.info/coronavirus/country/us/")
#Parse Data and get it ready for Pandas
soup = BeautifulSoup(res.content,'lxml')
table = soup.find_all('table')[0] 

#Put it in a Pandas Dataframe
US = pd.read_html(str(table))[0]

#Scrape US Population data
res = requests.get("https://worldpopulationreview.com/states/")
#Parse Data and get it ready for Pandas
soup = BeautifulSoup(res.content,'lxml')
table = soup.find_all('table')[0] 

#Put it in a dataframe
USPop = pd.read_html(str(table))[0]

#Pass to SQL staging, drop and replace
#USPop.to_sql('USPop',conn, if_exists='replace') #We do not need to load this data every day
US.to_sql('USCov', conn, if_exists='replace')
USPop.to_sql('USPop', conn, if_exists='replace')

#Log the insert to SQL in a SQL table
cursor = cnxn.cursor()
cursor.fast_executemany = True 
cursor.execute(
'''
Insert into PythonImportLog
Values(getdate(),'USCovidData')
'''
)
cnxn.commit()

#Stored procedure to load the data to a real data structure
cursor = cnxn.cursor()
cursor.fast_executemany = True 
cursor.execute(
'''
Exec LoadUSCov
'''
)
cnxn.commit()