/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each kill for Data Anlysis and Data Sciencie positions
- Focuses on roles with specified salaries in Colombia
- Why? It reveals how different skills impact salary levels for Data Analysts and Data Scientists and 
    helps identify the most financially rewarding skills to acquire or improve

*/

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
        AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
),
information_filter AS (
    SELECT 
        sd.skills AS skill,
        avg(ci.salary_year_avg) AS avg_salary_skill
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

    

