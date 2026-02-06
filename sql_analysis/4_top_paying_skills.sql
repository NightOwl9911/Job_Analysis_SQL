/*
Problem / Question:
What are the top-paying skills based on average salary for:
- Data Analyst roles
- Data Scientist roles

Scope & Assumptions:
- Focus only on job postings located in Colombia
- Include only roles with a specified annual salary
- Analyze both Data Analyst and Data Scientist positions together

Why this analysis?
- Reveals how different skills influence salary levels
- Helps identify the most financially rewarding skills to acquire or improve
- Provides insight into market value beyond skill demand alone
*/

WITH colombia_information AS (
    -- Extracts relevant job information for Colombia-based roles
    -- Filters to Data Analyst and Data Scientist positions
    -- Excludes job postings without salary information
    SELECT
        job_id,                                 -- Unique job identifier
        job_title_short,                        -- Standardized job title
        job_location,                           -- Job location
        salary_year_avg                         -- Average annual salary
    FROM
        job_postings_fact
    WHERE
        job_location LIKE '%Colombia%'          -- Limits analysis to Colombia
        AND salary_year_avg IS NOT NULL         -- Ensures salary data is available
        AND job_title_short IN ('Data Analyst','Data Scientist')
),

information_filter AS (
    -- Associates each skill with the average salary of jobs requiring it
    -- Aggregates salary impact at the skill level
    SELECT 
        sd.skills AS skill,                     -- Skill name
        AVG(ci.salary_year_avg) AS avg_salary_skill
                                                -- Average salary for jobs requiring this skill
    FROM colombia_information ci
    INNER JOIN skills_job_dim sjd 
        ON ci.job_id = sjd.job_id               -- Links jobs to their required skills
    INNER JOIN skills_dim sd 
        ON sjd.skill_id = sd.skill_id           -- Retrieves skill names
    GROUP BY
        sd.skills                               -- Groups results by skill
)

-- Retrieves the top 30 highest-paying skills
SELECT
    infil.skill,                               -- Skill name
    ROUND(infil.avg_salary_skill, 2)           -- Average salary rounded to 2 decimals
FROM
    information_filter infil
ORDER BY
    infil.avg_salary_skill DESC                -- Orders skills by salary (highest first)
LIMIT 30;                                      -- Returns top 30 highest-paying skills

    

