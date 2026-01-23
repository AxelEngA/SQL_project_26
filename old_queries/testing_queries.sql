/* find companies that have the most job openings
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)


--CTE
WITH company_job_count AS (
    SELECT  
        count(*) as jobscount,
        company_id
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name,
    company_job_count.jobscount
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    company_job_count.jobscount DESC;

/*
find count of number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill
*/



WITH Remote_jobs AS (
    SELECT 
        job_title_short,
        count(*) as total_jobs
    FROM 
        job_postings_fact
    WHERE 
        job_location = 'Anywhere'
    GROUP BY
        job_title_short
    ORDER BY total_jobs DESC
)

SELECT *
FROM Remote_jobs


SELECT *
FROM job_postings_fact
LIMIT 5;

SELECT *
FROM skills_job_dim
LIMIT 5

SELECT *
FROM skills_dim
LIMIT 5


WITH skills_left AS (
    SELECT *
    FROM skills_dim
    LEFT JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)


SELECT count(*) as total_jobs,
    skills_left.skills
FROM skills_left
INNER JOIN job_postings_fact ON skills_left.job_id = job_postings_fact.job_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
AND job_postings_fact.job_location = 'Anywhere'
GROUP BY skills_left.skills
ORDER BY total_jobs DESC
LIMIT 5;


