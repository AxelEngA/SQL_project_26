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


### 3. Top Demanded skills

### 4. Top Demanded skills

### 5. Top Demanded skills





# Takeaways

# Conclusion

In conclusion, by answering these questions provide insights with SQL, spreadsheet , programming language like python and a visualization business intelligence software like PowerBI or Tableau. These In-demand skills that are highly rewarded on the Data Analyst job market. 
Additional insights is learning a Cloud Platform, AWS, Azure or GCP. 
