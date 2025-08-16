# 📊 SQL Project: Data Job Market Analysis

## 🔍 Introduction
This project explores the **Data Analyst job market** using SQL queries on a PostgreSQL database.
The goal is to uncover **salary trends, in-demand skills, and high-value opportunities** for data professionals.

By analyzing job postings, we provide insights into:
- 💰 The highest-paying remote roles
- 🛠️ The most valuable technical skills
- 📈 The balance between demand and pay

## ⚙️ Tools & Setup
- **Database:** PostgreSQL
- **Editor:** VS Code
- **Language:** SQL
- **Data Source:** Job postings dataset

**To run the queries:**
1. Clone the repo
2. Connect to PostgreSQL
3. Run the `.sql` file inside your database

## 📊 SQL Queries & Insights

### 1️⃣ Top 10 Highest Paying Remote Data Analyst Jobs
- Focused on remote-friendly roles
- Considered only jobs with valid salary data
- Highlighted the **top 10 highest-paying opportunities**
**Why?** To reveal the most financially rewarding remote analyst roles
```sql
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
```
**Results Insight:**
- Highest paying roles include leadership or senior Data Analyst positions
- Remote opportunities are financially competitive
- Companies like AT&T and large tech firms dominate top salaries

### 2️⃣ Skills for Top Paying Jobs
- Analyzed skills tied to top-paying roles
- Revealed what employers demand for premium salaries
**Why?** To understand what makes these jobs so valuable
```sql
WITH top_paying_jobs AS (
    
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL

    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills AS skill_name
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 10;
```
**Results Insight:**
- Core data skills (**SQL, Python**) dominate top-paying jobs
- Cloud & Big Data tools (**Azure, Databricks, AWS**) raise earning potential
- Analytical libraries (**Excel, Pandas**) remain relevant at higher salary levels

### 3️⃣ Most Demanded Skills for Remote Analysts
- Counted how often each skill appears in remote Data Analyst postings
- Ranked the **top 10 most requested skills**
**Why?** To guide job seekers toward the most in-demand skills
```sql
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
LIMIT 10;
```
**Results Insight:**
- HTML, Python, SQL are most requested
- Development & data visualization skills highly valued

### 4️⃣ Highest Paying Skills
- Calculated the average salary linked to each skill
- Ranked skills by financial return
**Why?** To show which skills directly increase salary
```sql
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
LIMIT 30;

```
**Results Insight:**
- PySpark, Bitbucket, Watson top average salary
- Cloud, DevOps, and Big Data tools significantly boost earning potential
- Programming libraries (**Pandas, NumPy**) increase analytics value

### 5️⃣ Skills with Both High Demand & High Pay
- Combined **demand frequency + salary data**
- Highlighted skills balancing both
**Why?** To prioritize skills that give the best career ROI
```sql
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
```
**Results Insight:**
- **SQL & Python**: Most demanded AND well-paid → essential
- Cloud platforms (**AWS, Azure, GCP**) offer strong salary + demand
- Data Engineering tools (**PostgreSQL, Databricks**) secure future career growth

## ✅ Conclusion
- 💰 Remote Data Analyst roles can pay extremely well, especially with niche technical expertise
- 🛠️ **SQL & Python** remain non-negotiable for analysts
- ☁️ Cloud & Big Data tools significantly increase market value
- 🎯 Professionals should target a **mix of demand + pay skills** for long-term growth

## 🔗 Repo Structure
- `project.sql` → All SQL queries + comments 🔽  
[project.sql](project_sql)
- `README.md` → Project documentation 🔽  
[README.md](README.md)

## 🚀 Author
👩‍💻 Malak Othman
🔗 [GitHub Profile](https://github.com/Malak-Othman)
