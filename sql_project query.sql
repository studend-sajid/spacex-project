create database space;
use space;

select * from spacex;


-- 1. Display the names of the unique launch sites in the space mission ;

select Launch_Site from spacex group by Launch_Site;

select distinct Launch_Site from spacex;

-- 2. Display 5 records where launch sites begin with the string 'CCA' ;

SELECT * FROM spacex WHERE Launch_Site LIKE 'CCA%' LIMIT 5;

-- 3. Display the total payload mass carried by boosters launched by NASA (CRS) ;

select Customer , sum(PAYLOAD_MASS__KG_) from spacex where Customer='NASA (CRS)' group by Customer;

-- 4. Display average payload mass carried by booster version F9 v1.1 ;
select Booster_Version , avg(PAYLOAD_MASS__KG_) from spacex where   Booster_Version ='F9 v1.1' group by Booster_Version;


-- 5. List the date when the first successful landing outcome in ground pad was acheived. ;
select Date ,Landing_Outcome from spacex where Landing_Outcome = 'Success (ground pad)' order by Date  limit 1;

-- Hint:Use min function ;
-- 6. List the names of the boosters which have success in drone ship and have payload mass greater than 4000 but less than 6000 ;

select Booster_Version, PAYLOAD_MASS__KG_, Landing_Outcome from spacex where Landing_Outcome='Success (drone ship)' and (PAYLOAD_MASS__KG_ >=4000 and PAYLOAD_MASS__KG_ <6000);


-- 7. List the total number of successful and failure mission outcomes ;
select Mission_Outcome , count(Mission_Outcome)  from spacex WHERE Mission_Outcome IN ('Success', 'Failure(in flight)') group by Mission_Outcome;

-- 8. List the names of the booster_versions which have carried the maximum payload mass. Use a subquery ;
select Booster_Version ,max(PAYLOAD_MASS__KG_) as max_mss from spacex group by Booster_Version order by max_mss desc;

-- 8. List the names of the booster versions which have carried the maximum payload mass
SELECT Booster_Version, PAYLOAD_MASS__KG_
FROM spacex
WHERE PAYLOAD_MASS__KG_ = (
    SELECT MAX(PAYLOAD_MASS__KG_) 
    FROM spacex
);

-- 9. List the failed landing_outcomes in drone ship, their booster versions, and launch site names for in year 2015; 
select Landing_Outcome,Booster_Version,Launch_site from spacex where Landing_Outcome='Failure (drone ship)' and Date between '2015-01-01' AND '2015-12-31';

-- 10. Rank the count of landing outcomes (such as Failure (drone ship) or Success (ground pad)) ;
-- between the date 2010-06-04 and 2017-03-20, in descending order;

-- 10. Rank the count of landing outcomes between given dates, in descending order
SELECT Landing_Outcome, COUNT(Landing_Outcome) AS Outcome_Count
FROM spacex
WHERE Date BETWEEN '2010-06-04' AND '2017-03-20'
GROUP BY Landing_Outcome
ORDER BY Outcome_Count DESC;
