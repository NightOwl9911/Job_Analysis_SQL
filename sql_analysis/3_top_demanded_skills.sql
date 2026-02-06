/*
Problem / Question:
What are the most in-demand skills for:
1) Data Analyst roles
2) Data Scientist roles

Scope & Assumptions:
- Focus on ALL job postings
- Filter results to jobs located in Colombia
- Identify the top 10 most frequently required skills for each role

Why this analysis?
- Helps identify the skills with the highest demand in the job market
- Provides guidance for job seekers on which skills are most valuable to learn
*/


-- ===============================
-- Top 10 In-Demand Skills: Data Analyst (Colombia)
-- ===============================
SELECT
    sd.skills,                                  -- Skill name
    COUNT(sjd.job_id) AS skill_in_demand        -- Number of job postings requiring this skill
FROM
    job_postings_fact jpf                       -- Main job postings table
INNER JOIN skills_job_dim sjd 
    ON jpf.job_id = sjd.job_id                  -- Links jobs to required skills
INNER JOIN skills_dim sd 
    ON sjd.skill_id = sd.skill_id               -- Retrieves skill names
WHERE
    jpf.job_title_short = 'Data Analyst'        -- Filters for Data Analyst roles
    AND jpf.job_location LIKE '%Colombia%'     -- Filters jobs located in Colombia
GROUP BY
    sd.skills                                   -- Groups results by skill
ORDER BY
    skill_in_demand DESC                        -- Orders skills by demand (highest first)
LIMIT 10;                                       -- Returns top 10 most in-demand skills


-- ===============================
-- Top 10 In-Demand Skills: Data Scientist (Colombia)
-- ===============================
SELECT
    sd.skills,                                  -- Skill name
    COUNT(sjd.job_id) AS skill_in_demand        -- Number of job postings requiring this skill
FROM
    job_postings_fact jpf                       -- Main job postings table
INNER JOIN skills_job_dim sjd 
    ON jpf.job_id = sjd.job_id                  -- Links jobs to required skills
INNER JOIN skills_dim sd 
    ON sjd.skill_id = sd.skill_id               -- Retrieves skill names
WHERE
    jpf.job_title_short = 'Data Scientist'      -- Filters for Data Scientist roles
    AND jpf.job_location LIKE '%Colombia%'     -- Filters jobs located in Colombia
GROUP BY
    sd.skills                                   -- Groups results by skill
ORDER BY
    skill_in_demand DESC                        -- Orders skills by demand (highest first)
LIMIT 10;                                       -- Returns top 10 most in-demand skills