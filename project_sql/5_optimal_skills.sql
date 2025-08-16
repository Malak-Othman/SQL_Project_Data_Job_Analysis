WITH top_demanded_skills AS (  
    SELECT
        skills_dim.skill_id,
        skills AS skill_name,
        COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
         AND
        job_work_from_home = 'true'
        AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
), 
top_paying_skills AS (
    SELECT
        skills_dim.skill_id,
        skills AS skill_name,
        ROUND (AVG (salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND
        job_work_from_home = 'true'
        AND
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)
SELECT
    top_demanded_skills.skill_id,
    top_demanded_skills.skill_name,
    top_demanded_skills.demand_count,
    top_paying_skills.avg_salary
FROM
    top_demanded_skills
INNER JOIN top_paying_skills ON top_demanded_skills.skill_id = top_paying_skills.skill_id
WHERE
    top_demanded_skills.demand_count >10    
ORDER BY top_paying_skills.avg_salary DESC,
         top_demanded_skills.demand_count DESC
LIMIT 10;