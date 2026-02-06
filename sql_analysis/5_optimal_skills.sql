/*
Question: What are the most optiomal skills to learn (aka it's in high demand and a high-playing skills)?
- Identify skills in high demand and associated with a high average salaries for Data Analyst/Scientist roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/


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
        (jpf.job_title_short = 'Data Analyst' OR jpf.job_title_short = 'Data Scientist')
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
            AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
    ),
    information_filter AS (
        SELECT 
            sd.skill_id AS skill_id,
            sd.skills AS skill,
            avg(ci.salary_year_avg) AS avg_salary_skill
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
