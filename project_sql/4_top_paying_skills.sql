SELECT
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
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 30

/*
[
  {
    "skill_name": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skill_name": "watson",
    "avg_salary": "160515"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill_name": "swift",
    "avg_salary": "153750"
  },
  {
    "skill_name": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skill_name": "pandas",
    "avg_salary": "151821"
  },
  {
    "skill_name": "golang",
    "avg_salary": "145000"
  },
  {
    "skill_name": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skill_name": "numpy",
    "avg_salary": "143513"
  },
  {
    "skill_name": "databricks",
    "avg_salary": "141907"
  },
  {
    "skill_name": "linux",
    "avg_salary": "136508"
  },
  {
    "skill_name": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "127000"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "126103"
  },
  {
    "skill_name": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skill_name": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skill_name": "notion",
    "avg_salary": "125000"
  },
  {
    "skill_name": "scala",
    "avg_salary": "124903"
  },
  {
    "skill_name": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skill_name": "gcp",
    "avg_salary": "122500"
  },
  {
    "skill_name": "microstrategy",
    "avg_salary": "121619"
  },
  {
    "skill_name": "crystal",
    "avg_salary": "120100"
  },
  {
    "skill_name": "go",
    "avg_salary": "115320"
  },
  {
    "skill_name": "confluence",
    "avg_salary": "114210"
  },
  {
    "skill_name": "db2",
    "avg_salary": "114072"
  },
  {
    "skill_name": "hadoop",
    "avg_salary": "113193"
  }
]
*/