/* 
Query 1: Top 10 Highest Paying Remote Data Analyst Jobs  
- Focus on remote-friendly Data Analyst roles.  
- Filter only jobs with non-null salaries.  
- Rank and display the top 10 highest-paying roles.  
- Why? To highlight the most financially rewarding opportunities for remote analysts.  
*/


SELECT
    job_id,
    job_title,
    job_via,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::Date
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
LIMIT 10;
