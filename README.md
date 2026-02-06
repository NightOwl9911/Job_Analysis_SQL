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
    jpf.job_title,
    jpf.salary_year_avg,
    COALESCE(cd.name, 'Company_No_Specified') AS company_name
FROM
    job_postings_fact jpf
LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
WHERE
    jpf.salary_year_avg IS NOT NULL
    AND jpf.job_location LIKE '%Colombia%'
    AND jpf.job_title_short IN ('Data Analyst','Data Scientist')
ORDER BY
    jpf.salary_year_avg DESC
LIMIT 20;
```

![Top paying jobs Colombia](job_analysis_graphs\top_20_jobs_colombia.png)


### 2. Skills for Top Paying Jobs
### 3. In-demand Skills for Data Analysts and Scientists
### 4. Skills Based on Salary
### 5. Most Optimal Skills to Learn
This was done with the intentation
## 🔷 What I take
## 🔷 Conclusions
### Closing takes

