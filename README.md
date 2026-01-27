TODO: Finish analysis section




# Introduction

Diving into data analyst job market. 

This project explores in-demand skills, top-paying jobs where high salary and meet high demand.

SQL Queries Found here: [project_sql folder](/project_sql/)


# Background

### The questions answered through my SQL queries:

1. What are the top-paying data analyst jobs?
2. What are the skills required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills corresponds to higher salaries?
5. What are the most optimal or ideal skills to learn?

# Tools used

- **Visual Studio Code**: Connected PostgreSQL to VSCODE, here I run my queries.
- **SQL**: Query database and reveal critical insights.
- **PostgreSQL**: Chosen database management system for this project. Connected to VSCode.
- **Git and GitHub**: Crucial for version control of SQL scripts. 

# Analysis

Queries used for each question:

### 1. Top Paying Data Analyst Jobs.

Identify the top paying remote Data Analyst jobs. 
```sql
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
```
Findings:
- **Diverse Employers:** Companies such as AT&Tdifferent companies like META, with interest across different industries. 
- **Salary Range:** 
High range of salary, ranging from 184K USD to 650k. This emphazies the signifiance of salary potential within Data Analytics.
- **Variety of Job Titles:**
High variety of data analyst roles, from Marketing Data Analyst to Director of Data Analyst.

### 2. Skills required for Top Paying Data Analyst Jobs.

```sql
With top_paying_jobs AS (
    SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name 
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        salary_year_avg IS NOT NULL AND 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC


```

![Top 10 Skills](Assets\Screenshot_2026-01-27_212337.png)

Findings: 

With each corresponding company and salary we can unearth insights about which skills are used. SQL, python and cloud platform are mentioned often. Following queries will build on this query.

The top 10 following skills:

//insert image here

### 3. Top Demanded skills

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = True
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5
```

Insights:

### 4. Top Demanded skills

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25
```

Insights:

### 5. Top Demanded skills
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst' AND 
        job_work_from_home = True AND 
        salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)> 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```




# Takeaways

# Conclusion

In conclusion, by answering these questions provide insights with SQL, spreadsheet , programming language like python and a visualization business intelligence software like PowerBI or Tableau. These In-demand skills that are highly rewarded on the Data Analyst job market. 
Additional insights is learning a Cloud Platform, AWS, Azure or GCP. 
