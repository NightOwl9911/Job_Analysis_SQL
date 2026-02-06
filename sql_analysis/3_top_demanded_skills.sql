/*
Questions: What are the most in demands skills for Data analysis jobs and separately the ones for Data scientists jobs
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for a Data analyst and Data scientist
- Focus on all jobs postings
- Why? Retrieves the top 10 skills with the highest demand in job market,
    providing insights into the most valuable skills for job seekers.
*/ 


SELECT
    sd.skills,
    COUNT(sjd.job_id) AS skill_in_demand
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND job_location LIKE '%Colombia%'
GROUP BY
    sd.skills
ORDER BY
    skill_in_demand DESC
LIMIT 10;




SELECT
    sd.skills,
    COUNT(sjd.job_id) AS skill_in_demand
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Scientist'
    AND job_location LIKE '%Colombia%'
GROUP BY
    sd.skills
ORDER BY
    skill_in_demand DESC
LIMIT 10;