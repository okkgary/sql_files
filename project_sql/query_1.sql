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
limit 10