/*
Question: What are the top-paying data analyst/scientist jobs in Colombia?
- Identify the top 20 highest-paying Data Analyst and Scientist roles
- Focuses on job postings with specified salaries (remove nulls)
- Includes company names of top 20, if there are no company related to the job it will show 'Company_No_Specified'
- Why? Highlight the top-paying opportunities for Data Analysts/Scientists, offering insights into employment options.
*/

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
    jpf.salary_year_avg is not null 
    AND jpf.job_location LIKE '%Colombia%'
    AND (jpf.job_title_short = 'Data Analyst' OR jpf.job_title_short = 'Data Scientist')

-- Sort by highest annual salary
ORDER BY
    jpf.salary_year_avg DESC

-- Return only the top 20 highest-paying jobs
LIMIT 20;













