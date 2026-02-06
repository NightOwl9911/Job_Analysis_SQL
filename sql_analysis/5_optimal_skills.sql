/* 
Problem / Question:
What are the most optimal skills to learn?
(Defined as skills that are BOTH high in demand and high-paying)

Scope & Assumptions:
- Focus on Data Analyst and Data Scientist roles
- Limit analysis to job postings located in Colombia
- Include only positions with specified salary information
- Identify skills that balance job security (demand) and financial reward (salary)

Why this analysis?
- Highlights skills that are frequently requested and offer higher salaries
- Helps prioritize learning paths with strong market demand and earning potential
- Supports strategic career development in data analysis and data science
*/

WITH skills_demand AS (
    -- Calculates how frequently each skill appears in job postings
    -- Measures skill demand across Data Analyst and Data Scientist roles
    SELECT
        sd.skill_id AS skill_id,                 -- Unique skill identifier
        sd.skills AS skills,                     -- Skill name
        COUNT(sjd.job_id) AS skill_in_demand     -- Number of job postings requiring the skill
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd 
        ON jpf.job_id = sjd.job_id               -- Links jobs to required skills
    INNER JOIN skills_dim sd 
        ON sjd.skill_id = sd.skill_id            -- Retrieves skill details
    WHERE
        (jpf.job_title_short = 'Data Analyst' 
         OR jpf.job_title_short = 'Data Scientist')
        AND jpf.job_location LIKE '%Colombia%'   -- Limits analysis to Colombia
        AND jpf.salary_year_avg IS NOT NULL      -- Ensures salary data exists
    GROUP BY
        sd.skill_id                              -- Aggregates demand per skill
),

average_salary AS (
    -- Computes the average salary associated with each skill
    -- Based on Colombia-based Data Analyst and Data Scientist roles

    WITH colombia_information AS (
        -- Filters relevant job postings with salary data in Colombia
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
        -- Associates each skill with the average salary of jobs requiring it
        SELECT 
            sd.skill_id AS skill_id,              -- Skill identifier
            sd.skills AS skill,                   -- Skill name
            AVG(ci.salary_year_avg) AS avg_salary_skill
                                                 -- Average salary for jobs requiring the skill
        FROM colombia_information ci
        INNER JOIN skills_job_dim sjd 
            ON ci.job_id = sjd.job_id             -- Links jobs to skills
        INNER JOIN skills_dim sd 
            ON sjd.skill_id = sd.skill_id         -- Retrieves skill names
        GROUP BY
            sd.skill_id                           -- Aggregates salary per skill
    )

    -- Final output of average salary per skill
    SELECT
        infil.skill AS skill,
        infil.skill_id AS skill_id,
        ROUND(infil.avg_salary_skill, 2) AS avg_salary
    FROM
        information_filter infil
)

-- Combines demand and salary to identify optimal skills
SELECT 
    skd.skills AS skill,                          -- Skill name
    skd.skill_in_demand AS in_demand_skill,       -- Demand count
    avsa.avg_salary AS avg_salary                 -- Average salary
FROM
    skills_demand skd
INNER JOIN average_salary avsa 
    ON skd.skill_id = avsa.skill_id               -- Matches demand and salary per skill
WHERE
    skd.skill_in_demand > 2                       -- Filters out low-demand skills
ORDER BY
    avg_salary DESC,                              -- Prioritizes higher-paying skills
    in_demand_skill DESC                          -- Breaks ties by demand
LIMIT 10;                                        -- Top 10 optimal skills
