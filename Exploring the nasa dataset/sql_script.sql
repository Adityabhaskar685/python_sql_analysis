-- Select all records from the table
select * from astronauts;

-- Find out the status of the astronaut
SELECT Status, COUNT(*) as number
FROM astronauts
GROUP BY 1;

-- Counting astronaut by military branch
SELECT Military_Branch, COUNT(*) as number
FROM astronauts
GROUP BY 1;

-- Top 5 Military Ranks Among Astronauts.
SELECT Military_Rank , COUNT(*) AS number
FROM astronauts
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Count of Astronauts by Gender.
SELECT Gender , COUNT(*) as number
FROM astronauts
GROUP BY 1;

-- Average Life Expectancy of Astronauts.
SELECT ROUND(AVG(life)) as avg_life_expentancy
FROM (SELECT CASE
	WHEN Status = 'Deceased' THEN YEAR(Death_Date) - YEAR(Birth_Date)
    ELSE 2023 - YEAR(Birth_Date)
    END AS life
FROM astronauts ) AS l;

-- Average Life Expectancy of Female Astronauts.
SELECT ROUND(AVG(life)) as avg_life_expentancy
FROM (SELECT CASE
	WHEN Status = 'Deceased' THEN YEAR(Death_Date) - YEAR(Birth_Date)
    ELSE 2023 - YEAR(Birth_Date)
    END AS life
FROM astronauts
WHERE Gender = 'Female' ) AS l;

-- Average Life Expectancy of Male Astronauts.
SELECT ROUND(AVG(life)) as avg_life_expentancy
FROM (SELECT CASE
	WHEN Status = 'Deceased' THEN YEAR(Death_Date) - YEAR(Birth_Date)
    ELSE 2023 - YEAR(Birth_Date)
    END AS life
FROM astronauts
WHERE Gender = 'Male' ) AS l;

-- Top 10 Graduate Majors Among Astronauts.
select Graduate_Major , count(*) as number 
from astronauts
group by 1
order by 2 desc
limit 10;

/* Astronaut Education Statistics.
Calculate the count of astronauts with undergraduate and graduate degrees. */
    
select COUNT(*) as Number_of_Astronauts , 
	(SELECT COUNT(Undergraduate_Major) FROM astronauts WHERE Undergraduate_Major is not null) as Astronauts_with_Undergraduate_Degrees,
    (SELECT COUNT(Graduate_Major)  FROM astronauts WHERE Graduate_Major is not null) as Astronauts_with_Graduate_Degrees
FROM astronauts;

-- Top 5 States of Birth for Astronauts.

SELECT RIGHT(Birth_Place,2) AS State,
	COUNT(*) AS number 
from astronauts
group by 1
order by 2 desc
limit 5;

-- Average Space Flights and Spacewalks per Astronaut.
select ROUND(AVG(Space_Flights),2) as avg_number_of_space_flights,
	ROUND(AVG(Space_Walks), 2) as avg_number_of_space_walks
 from astronauts;






    










