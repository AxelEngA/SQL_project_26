select job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST' AS time_date,
job_posted_date AS date
from job_postings_fact
limit 100;



SELECT 
    count(job_id) as job_post_count,
    extract(month from job_posted_date) AS month_num
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month_num
ORDER BY 
    job_post_count DESC


    -- Query for jan

    CREATE TABLE jan_table AS

    SELECT 
        EXTRACT(month from job_posted_date) AS month_num
    FROM 
        job_posted_date






-- Create table for January job postings
CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;
   
-- Create table for February job postings
CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create table for March job postings
CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

--TABLES ABOVE NOW CREATED 

--TIME STAMP OF LUKE VIDEO IS:

SELECT job_title_short,
job_location
from job_postings_fact
limit 10;


SELECT
    COUNT(job_id) AS number_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_status
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY 
    job_status


--SubQuery

SELECT job_posted_date
FROM ( -- subquery
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS january_jobs
limit 50;

--SubQuery ends


-- CTE

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT job_posted_date
FROM january_jobs;

--CTE ENDS



--Subquery example, finding company name
-- and id for postings that dont require degree

SELECT 
    company_id,
    name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
)


-- CTE exempel:



WITH company_job_count AS (
    SELECT 
        company_id,
        count(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)



SELECT total_jobs,
    company_dim.name AS company_name
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC

   

--EXERCISE
--find the count of number of remote job postings per skill

    -- Display top 5 skills by their demand in remote jobs
    -- Include skill_id, name, count of postings requiring the skill

SELECT
    COUNT(job_id) AS number_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_status
FROM job_postings_fact
GROUP BY 
    job_status