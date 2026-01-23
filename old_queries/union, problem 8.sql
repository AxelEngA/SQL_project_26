
/* 
Find job posting sfrom the 
first quarter that have a salary
greater than 70k
- Combine job posting tables from the first quarter of 2023 (jan-mar)
- Gets job postings with an average yearly salarly > 70 000 */



-- creating seperate table, this is not CTE!

CREATE TABLE quarter_1 AS

    SELECT *
    FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL -- union all does not remove duplicates


    SELECT *
    FROM march_jobs


Select job_title_short,
    company_id,
    job_location
from quarter_1
where salary_year_avg > 70000


DROP TABLE quarter_1 --if you have to remove table CAREFUL


--CTE strategy


SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_location,
    quarter1_job_postings.salary_year_avg

FROM (
SELECT *
FROM january_jobs

UNION ALL

SELECT *
FROM february_jobs

UNION ALL -- union all does not remove duplicates


SELECT *
FROM march_jobs)
AS quarter1_job_postings
WHERE  
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC



