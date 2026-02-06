# <p align="center"> OPTIMAL SKILLS TO LEARN TO BECOME A DATA ANALYST/SCIENTIST IN COLOMBIA - 2023 </p>
## 🔷 Introduction 🐍🗄️
### SQL Queries
Check them here: [query_results](./query_results/)
## 🔷 Background
Analysis in [Optimal Skill](.https://github.com/NightOwl9911/Job_Analysis_SQL)

## 🔷 Tools Used
## 🔷 Analysis
### 1. Top Paying Data Analyist and Scientist Jobs

```sql
SELECT
-- Core job information for each job posting
    jpf.job_id,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date,

    -- Replace missing companies with a default label
    COALESCE(cd.name, 'Company_No_Specified') AS company_name

-- Main job posting table
FROM
    job_postings_fact jpf

-- Join company table to retrieve company names; LEFT JOIN ensure jobs without company data are included.
LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id

-- Filtering by:
-- 1) Jobs with reported salaries
-- 2) Jobs located in Colombia
-- 3) Data Analyst and Scientist roles
WHERE
    jpf.salary_year_avg IS NOT NULL
    AND jpf.job_location LIKE '%Colombia%'
    AND (jpf.job_title_short = 'Data Analyst' OR jpf.job_title_short = 'Data Scientist')

-- Sort by highest annual salary
ORDER BY
    jpf.salary_year_avg DESC

-- Return only the top 20 highest-paying jobs
LIMIT 20;
```

### 2. Skills for Top Paying Jobs
### 3. In-demand Skills for Data Analysts and Scientists
### 4. Skills Based on Salary
### 5. Most Optimal Skills to Learn
This was done with the intentation
## 🔷 What I take
## 🔷 Conclusions
### Closing takes

