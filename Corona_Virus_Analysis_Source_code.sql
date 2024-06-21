
-- To avoid any errors, check missing value / null value
 
-- Q1. Write a code to check NULL values

SELECT * FROM corona 
WHERE Province IS NULL OR 
	  Country_Region IS NULL OR
      Latitude IS NULL OR
      Longitude IS NULL OR
      Date IS NULL OR
      Confirmed IS NULL OR
      Deaths IS NULL OR
      Recovered IS NULL


--Q2. If NULL values are present, update them with zeros for all columns. 

UPDATE corona
SET
Province=COALESCE(Province,'0'),
Country_Region=COALESCE(Country_Region,'0'),
Latitude=COALESCE(Latitude,0.0),
Longitude=COALESCE(Longitude,0.0),
Date=COALESCE(Date,'0'),
Confirmed=COALESCE(Confirmed,0),
Deaths=COALESCE(Deaths,0),
Recovered=COALESCE(Recovered,0) 


-- Q3. check total number of rows

SELECT COUNT(*) FROM corona

-- Q4. Check what is start_date and end_date

SELECT MIN(Date) AS start_date , MAX(Date) AS end_date
FROM corona


-- Q5. Number of month present in dataset

SELECT count(DISTINCT EXTRACT(YEAR_MONTH FROM Date)) AS Number_of_months
FROM corona

-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
AVG(Confirmed) AS confirmed_average,AVG(Deaths) AS death_average,AVG(Recovered) AS recovered_average
FROM corona
GROUP BY year,month


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,Confirmed,
COUNT(Confirmed)AS confirmed_frequency
FROM corona
GROUP BY Confirmed,year,month
ORDER BY  confirmed_frequency DESC;

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,Deaths,
COUNT(Deaths)AS deaths_frequency
FROM corona
GROUP BY Deaths,year,month
ORDER BY  deaths_frequency DESC;

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,Recovered,
COUNT(Recovered)AS recovered_frequency
FROM corona
GROUP BY Recovered,year,month
ORDER BY  recovered_frequency DESC;

-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT EXTRACT(YEAR FROM Date) AS year,
MIN(Confirmed) AS confirmed_minimum,MIN(Deaths) AS death_minimum,MIN(Recovered) AS recovered_min
FROM corona
GROUP BY year


-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT EXTRACT(YEAR FROM Date) AS year,
MAX(Confirmed) AS confirmed_max,MAX(Deaths) AS death_max,MAX(Recovered) AS recovered_max
FROM corona
GROUP BY year

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Confirmed) AS confirmed_total,SUM(Deaths) AS death_total,SUM(Recovered) AS recovered_total
FROM corona
GROUP BY year,month


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Confirmed) AS confirmed_total,AVG(Confirmed) AS confirmed_average,VARIANCE(Confirmed) AS confirmed_variance,
STDDEV(Confirmed) AS confirmed_STANDARD_dev
FROM corona
GROUP BY year,month


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Deaths) AS Deaths_total,AVG(Deaths) AS Deaths_average,VARIANCE(Deaths) AS Deaths_variance,
STDDEV(Deaths) AS Deaths_STANDARD_dev
FROM corona
GROUP BY year,month


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT EXTRACT(YEAR FROM Date) AS year,EXTRACT(MONTH FROM Date) AS month,
SUM(Recovered) AS Recovered_total,AVG(Recovered) AS Recovered_average,VARIANCE(Recovered) AS Recovered_variance,
STDDEV(Recovered) AS Recovered_STANDARD_dev
FROM corona
GROUP BY year,month

-- Q14. Find Country having highest number of the Confirmed case

SELECT Country_Region,SUM(Confirmed) AS total_confirm
FROM corona
GROUP BY Country_Region
ORDER BY total_confirm DESC
LIMIT 1


-- Q15. Find Country having lowest number of the death case

SELECT Country_Region,SUM(Deaths) AS total_death
FROM corona
GROUP BY Country_Region
ORDER BY total_death 
LIMIT 4


-- Q16. Find top 5 countries having highest recovered case

SELECT Country_Region,SUM(Recovered) AS total_recovered
FROM corona
GROUP BY Country_Region
ORDER BY total_recovered DESC
LIMIT 5