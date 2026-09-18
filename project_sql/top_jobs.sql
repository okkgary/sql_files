WITH table_1 AS (
            
SELECT
    job_postings_fact.job_id AS ID,
    job_postings_fact.job_title AS POSITION,
    company_dim.name AS COMPANY,
    job_postings_fact.salary_year_avg AS SALARY
FROM job_postings_fact 
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_work_from_home = TRUE AND
    job_postings_fact.salary_year_avg IS NOT NULL AND
    job_postings_fact.job_title_short = 'Data Analyst' 
ORDER BY job_postings_fact.salary_year_avg DESC
)
SELECT 
    --POSITION,
    --COMPANY,
    round(avg(SALARY),0) AS average_salary,
    skills_dim.skills AS SKILLS,
    count(*) AS demand_count
FROM table_1
INNER JOIN skills_job_dim
    ON table_1.ID = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
HAVING
    count(*) > 10
ORDER BY 
    average_salary desc, 
    demand_count desc
LIMIT 10 ;