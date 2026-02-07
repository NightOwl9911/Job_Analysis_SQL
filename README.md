# <p align="center"> OPTIMAL SKILLS TO LEARN TO BECOME A DATA ANALYST/SCIENTIST IN COLOMBIA - 2023 </p>
## 🔷 Introduction 🐍🗄️
🔍 Exploring the data job market in 2023. This project analyzes data analyst and data science roles, focusing on 💰 top-paying jobs, 🔥 in-demand skills, and 📊 the relationship between salary and market demand. It also applies SQL techniques to clean, query, and analyze job market data.

The results of this analysis will serve as a baseline for a future project comparing job roles and skill requirements in 2025, enabling an evaluation of how the data job market evolves over time in Colombia.
### SQL Queries
Check them here: [query_results](./query_results/)
## 🔷 Background and Motivation 🎯
This project was driven by a personal interest in understanding the data analytics job market and identifying the skills required to become a data analyst or data scientist. The primary goal is to analyze job market data to determine which technical and analytical abilities are most valuable, allowing for a structured learning roadmap and practical skill development.

The analysis focuses on the Colombian job market as a starting point, providing insights into local demand before extending future research to international markets, particularly Germany. Additionally, this project serves as an opportunity to apply and strengthen SQL skills by querying, aggregating, and analyzing real-world job market data.

### Dataset

The dataset used in this project originates from a SQL-focused course and contains information on job titles, salaries, locations, and required skills for data-related roles. This dataset provides a foundation for exploring salary trends and skill demand in the Colombian data job market.

### Research Questions

The following questions were explored using SQL queries:

1. What are the top-paying data analyst and data scientist jobs in Colombia?

2. What skills are required for the top-paying data analyst and data scientist roles?

3. Which skills are most in demand across all data analyst and data scientist job postings in Colombia?

4. Which skills are associated with the highest average salaries (based on jobs that mention those skills)?

5. What are the most optimal skills to learn, considering both frequency (appearing more than twice) and average salary?

## 🔷 Tools Used ⚙️
● **SQL** for data extraction, aggregation, and analytical querying.

● **PostgreSQL** as the relational database system for storing and querying job postings.

● **Visual Studio** Code as the integrated development environment for database interaction and scripting.

● **Git** and **GitHub** for version control, reproducibility, and project documentation.

## 🔷 Analysis 🛠️
For each research question, SQL queries were developed to extract and aggregate relevant information from the dataset. The query results were exported as CSV files and processed in Python, where pandas were used for data cleaning and transformation, and matplotlib was used to generate tables and visualizations for analysis and interpretation.

[<u>*(Get to the Python files here)*</u>](./python_code_graphs)

[<u>*(Get to the query results here)*</u>](./query_results/)

Here is what I got:



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

![Top paying jobs Colombia](./job_analysis_graphs/top_10_jobs_colombia.png)


### 2. Skills for Top Paying Jobs

```sql
WITH top_jobs AS (
    SELECT
        jpf.job_id,
        jpf.job_title,
        jpf.job_location,
        jpf.salary_year_avg,
        COALESCE(cd.name, 'Company_No_Specified') AS company_name
    FROM job_postings_fact jpf
    LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id

    WHERE
        jpf.salary_year_avg IS NOT NULL
        AND jpf.job_location LIKE '%Colombia%'
        AND jpf.job_title_short IN ('Data Analyst', 'Data Scientist')
    ORDER BY jpf.salary_year_avg DESC
    LIMIT 20
)
SELECT
    COUNT(sd.skills) AS frequency,
    sd.skills                        
FROM top_jobs tp
INNER JOIN skills_job_dim sjd
    ON tp.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
GROUP BY sd.skills
ORDER BY frequency DESC;
```
![Top paying skills](./job_analysis_graphs/top_skills_by_frequency.png)


### 3. In-demand Skills for Data Analysts and Scientists

```sql
SELECT
    sd.skills, 
    COUNT(sjd.job_id) AS skill_in_demand
FROM
    job_postings_fact jpf 
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id 
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND jpf.job_location LIKE '%Colombia%'
GROUP BY
    sd.skills
ORDER BY
    skill_in_demand DESC 
LIMIT 10;  
```

```sql
SELECT
    sd.skills, 
    COUNT(sjd.job_id) AS skill_in_demand
FROM
    job_postings_fact jpf 
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id 
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Scientist'
    AND jpf.job_location LIKE '%Colombia%'
GROUP BY
    sd.skills
ORDER BY
    skill_in_demand DESC 
LIMIT 10;  
```
![Demanded skills for data analysts and scientists](./job_analysis_graphs/in_demand_skills.png)

### 4. Skills Based on Salary

```sql
WITH colombia_information AS (
    SELECT
        job_id,                                
        job_title_short,                    
        job_location,                          
        salary_year_avg                       
    FROM
        job_postings_fact
    WHERE
        job_location LIKE '%Colombia%'         
        AND salary_year_avg IS NOT NULL        
        AND job_title_short IN ('Data Analyst','Data Scientist')
),
information_filter AS (
    SELECT 
        sd.skills AS skill,     
        AVG(ci.salary_year_avg) AS avg_salary_skill
    FROM colombia_information ci
    INNER JOIN skills_job_dim sjd ON ci.job_id = sjd.job_id         
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id      
    GROUP BY
        sd.skills                         
)
SELECT
    infil.skill,                   
    ROUND(infil.avg_salary_skill, 2)       
FROM
    information_filter infil
ORDER BY
    infil.avg_salary_skill DESC 
LIMIT 30; 
```
![Top paying job skills](./job_analysis_graphs/top_payings_skills.png)


### 5. Most Optimal Skills to Learn


```SQL
WITH skills_demand AS (
    SELECT
        sd.skill_id AS skill_id,     
        sd.skills AS skills,                
        COUNT(sjd.job_id) AS skill_in_demand     
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id            
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id         
    WHERE
        jpf.job_title_short IN ('Data Analyst','Data Scientist')
        AND jpf.job_location LIKE '%Colombia%' 
        AND jpf.salary_year_avg IS NOT NULL     
    GROUP BY
        sd.skill_id                          
),

average_salary AS (
    WITH colombia_information AS (
        SELECT
            job_id,
            job_title_short,
            job_location,
            salary_year_avg
        FROM
            job_postings_fact
        WHERE
            job_location LIKE '%Colombia%'
            AND salary_year_avg IS NOT NULL
            AND job_title_short IN ('Data Analyst','Data Scientist')
    ),
    information_filter AS (
        SELECT 
            sd.skill_id AS skill_id,      
            sd.skills AS skill,             
            AVG(ci.salary_year_avg) AS avg_salary_skill
        FROM colombia_information ci
        INNER JOIN skills_job_dim sjd ON ci.job_id = sjd.job_id        
        INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id      
        GROUP BY
            sd.skill_id 
    )
    SELECT
        infil.skill AS skill,
        infil.skill_id AS skill_id,
        ROUND(infil.avg_salary_skill, 2) AS avg_salary
    FROM
        information_filter infil
)
SELECT 
    skd.skills AS skill,                      
    skd.skill_in_demand AS in_demand_skill,     
    avsa.avg_salary AS avg_salary                
FROM
    skills_demand skd
INNER JOIN average_salary avsa ON skd.skill_id = avsa.skill_id            
WHERE
    skd.skill_in_demand > 2                 
ORDER BY
    avg_salary DESC,                        
    in_demand_skill DESC                     
LIMIT 10;                                     
```

![Most optimal skills](./job_analysis_graphs/optimal_skills.png)

This was done with the intentation
## 🔷 What I take 📖
Throughout this project, I significantly strengthened my SQL skill set by applying advanced querying techniques and analytical methods.

The key take aways:
- Understanding the SQL syntax alongside working with a real project made understand important concepts



## 🔷 Conclusions 📝
### Closing takes

