/*
Question:
What are the top-paying Data Analyst / Data Scientist jobs in Colombia?

Objectives:
- Identify the top 20 highest-paying Data Analyst and Data Scientist roles
- Consider only job postings with specified (non-null) salaries
- Include company names; if unavailable, label as 'Company_No_Specified'
- Highlight top-paying opportunities to better understand employment options

Extra:
- Retrieve and count the skills required for these top-paying roles
*/

WITH top_jobs AS (
    SELECT
        -- Unique job identifier
        jpf.job_id,

        -- Job details
        jpf.job_title,
        jpf.job_location,
        jpf.salary_year_avg,

        -- Use a default label when company information is missing
        COALESCE(cd.name, 'Company_No_Specified') AS company_name

    FROM job_postings_fact jpf

    -- Join to company table to retrieve company names
    -- LEFT JOIN ensures jobs without company data are retained
    LEFT JOIN company_dim cd
        ON jpf.company_id = cd.company_id

    WHERE
        -- Include only jobs with reported salaries
        jpf.salary_year_avg IS NOT NULL

        -- Filter jobs located in Colombia
        AND jpf.job_location LIKE '%Colombia%'

        -- Restrict to Data Analyst and Data Scientist roles
        AND jpf.job_title_short IN ('Data Analyst', 'Data Scientist')

    -- Rank jobs by highest annual salary
    ORDER BY jpf.salary_year_avg DESC

    -- Limit results to the top 20 highest-paying jobs
    LIMIT 20
)

-- Count how frequently each skill appears across the top-paying jobs
SELECT
    COUNT(sd.skills) AS frequency,   -- Number of job postings requiring the skill
    sd.skills                        -- Skill name
FROM top_jobs tp

-- Link jobs to their associated skills
INNER JOIN skills_job_dim sjd
    ON tp.job_id = sjd.job_id

-- Retrieve skill names
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id

-- Aggregate by skill
GROUP BY sd.skills

-- Order skills by descending frequency
ORDER BY frequency DESC;