
CREATE VIEW TOTALHOTEL AS
SELECT * FROM DBO.['2018$'] 
UNION
SELECT * FROM DBO.['2019$']
UNION
SELECT * FROM DBO.['2020$']

---------------------------------------------------------------------------------
--IS THE HOTEL REVENUE GROWING BY YEAR?
--TOTAL REVENUE

SELECT * FROM TOTALHOTEL
WHERE ARRIVAL_DATE_YEAR ='2018'

SELECT HOTEL,ARRIVAL_DATE_YEAR AS YEAR,
ROUND (SUM((STAYS_IN_WEEKEND_NIGHTS+STAYS_IN_WEEK_NIGHTS)*ADR),2) AS TOTALREVENUE
FROM TOTALHOTEL
WHERE HOTEL = 'CITY HOTEL'
GROUP BY HOTEL,ARRIVAL_DATE_YEAR

SELECT HOTEL,ARRIVAL_DATE_YEAR AS YEAR,
ROUND (SUM((STAYS_IN_WEEKEND_NIGHTS+STAYS_IN_WEEK_NIGHTS)*ADR) ,2)AS TOTALREVENUE
FROM TOTALHOTEL
WHERE HOTEL = 'RESORT HOTEL'
GROUP BY HOTEL,ARRIVAL_DATE_YEAR

--------------------------------------------------------------------------------------------------------
--SHOULD WE INCREASE OUR PARKING LOT SIZE
SELECT HOTEL,ARRIVAL_DATE_YEAR, ROUND (AVG(REQUIRED_CAR_PARKING_SPACES)*100,2 )AS AVERAGEPARKINGSPACE
FROM TOTALHOTEL
GROUP BY ARRIVAL_DATE_YEAR,HOTEL

--------------------------------------------------------------------------------------------
--MONTH THAT POEPLE MAKE HIGH RESERVATIONS

SELECT HOTEL,ARRIVAL_DATE_YEAR,ARRIVAL_DATE_MONTH,MAX(STAYS_IN_WEEKEND_NIGHTS+STAYS_IN_WEEK_NIGHTS) AS MONTHMOSTRESERVED
FROM TOTALHOTEL
GROUP BY HOTEL,ARRIVAL_DATE_YEAR,ARRIVAL_DATE_MONTH
HAVING HOTEL ='CITY HOTEL' AND ARRIVAL_DATE_YEAR= '2020'
ORDER BY MONTHMOSTRESERVED DESC,ARRIVAL_DATE_YEAR 

--------------------------------------------------------------------------------------------------
--ROOM TYPE THATS MOSTLY RESERVED
SELECT ARRIVAL_DATE_YEAR,HOTEL,RESERVED_ROOM_TYPE,COUNT(RESERVED_ROOM_TYPE) AS TOTALRESERVEDROOMTYPES
FROM TOTALHOTEL
GROUP BY HOTEL,ARRIVAL_DATE_YEAR,RESERVED_ROOM_TYPE
HAVING HOTEL='CITY HOTEL' AND ARRIVAL_DATE_YEAR='2019'
ORDER BY TOTALRESERVEDROOMTYPES DESC

SELECT ARRIVAL_DATE_YEAR,HOTEL,RESERVED_ROOM_TYPE,COUNT(RESERVED_ROOM_TYPE) AS TOTALRESERVEDROOMTYPES
FROM TOTALHOTEL
GROUP BY HOTEL,ARRIVAL_DATE_YEAR,RESERVED_ROOM_TYPE
HAVING HOTEL='RESORT HOTEL' AND ARRIVAL_DATE_YEAR='2019'
ORDER BY TOTALRESERVEDROOMTYPES DESC

--------------------------------------------------------------------------------------------------
--MARKET SEGMENTS
SELECT ARRIVAL_DATE_YEAR,HOTEL,MARKET_SEGMENT,COUNT(MARKET_SEGMENT) AS TOTAL_MARKETSEGMENT_TYPES
FROM TOTALHOTEL
GROUP BY HOTEL,ARRIVAL_DATE_YEAR,MARKET_SEGMENT
HAVING HOTEL='CITY HOTEL' AND ARRIVAL_DATE_YEAR='2019'
ORDER BY TOTAL_MARKETSEGMENT_TYPES DESC

SELECT ARRIVAL_DATE_YEAR,HOTEL,MARKET_SEGMENT,COUNT(MARKET_SEGMENT) AS TOTAL_MARKETSEGMENT_TYPES
FROM TOTALHOTEL
GROUP BY HOTEL,ARRIVAL_DATE_YEAR,MARKET_SEGMENT
HAVING HOTEL='RESORT HOTEL' AND ARRIVAL_DATE_YEAR='2019'
ORDER BY TOTAL_MARKETSEGMENT_TYPES DESC