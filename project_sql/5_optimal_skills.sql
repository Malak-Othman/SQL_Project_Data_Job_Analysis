/* 
Query 5: Skills with Both High Demand & High Pay  
- Combine demand (frequency of skills) with salary averages.  
- Highlight skills that score well in both metrics.  
- Why? To prioritize skills that balance strong demand and high salaries.  
*/


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


/*
Results Insight:  
- SQL & Python: Essential, most demanded + highly paid.  
- Cloud Platforms (AWS, Azure, GCP): Strong demand + strong salaries.  
- Data Engineering tools (PostgreSQL, Databricks): High value for career growth.  


[
  {
    "skill_id": 8,
    "skill_name": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skill_name": "confluence",
    "demand_count": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skill_name": "hadoop",
    "demand_count": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skill_name": "snowflake",
    "demand_count": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skill_name": "azure",
    "demand_count": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skill_name": "bigquery",
    "demand_count": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skill_name": "aws",
    "demand_count": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skill_name": "java",
    "demand_count": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skill_name": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skill_name": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  }
]
*/