/* 
Query 3: Top 5 Most Demanded Skills for Remote Data Analysts  
- Count skills requested in remote Data Analyst job postings.  
- Rank by frequency of appearance.  
- Limit results to the top 5.  
- Why? To help job seekers focus on the most in-demand skills.  
*/


SELECT
    skills AS skill_name,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'  AND
     job_work_from_home = 'true'
    
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5