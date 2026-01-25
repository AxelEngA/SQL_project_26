/* 
Question:
- Identify top 10 highest paying data analyst roles that are remote.
- Focus on job posting with specified salaries (no nulls).
- Why? Highlight the top paying oppurtinities for Data Analysts, offering insights employer.
*/


SELECT *
FROM job_postings_fact
limit 100;



SELECT *
FROM skills_dim
limit 100;


SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    salary_year_avg IS NOT NULL AND 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
