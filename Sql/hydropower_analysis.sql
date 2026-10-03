-- Stage:1 Understanding the table
SELECT count(*) as total_under_construction
FROM construction_data;

select count(*) as total_operating
FROM operating_data;

select count(*) as total_under_survery
FROM survey_data;

SELECT * 
FROM construction_data
;

SELECT 
	COUNT(*) as total_rows,
	COUNT(DISTINCT project) as unique_projects
FROM construction_data;


SELECT project,lic_no,
COUNT(project) as unique_projects
FROM construction_data
GROUP BY project,lic_no
ORDER BY unique_projects DESC
;

SELECT project,lic_no,
COUNT(project) as unique_projects
FROM survey_data
GROUP BY project,lic_no
ORDER BY unique_projects DESC
;

SELECT project,lic_no,
COUNT(project) as unique_projects
FROM operating_data
GROUP BY project,lic_no
ORDER BY unique_projects DESC
;



-- Step 2: Understanding the Basics

-- a) Total capacity by stages


SELECT ROUND(SUM(capacity_mw)::NUMERIC,2) as operating_capacity_mw
FROM operating_data;

SELECT ROUND(SUM(capacity_mw)::NUMERIC,2) as construction_capacity_mw
FROM construction_data;

SELECT ROUND(SUM(capacity_mw)::NUMERIC,2) as surveyed_capacity_mw
FROM survey_data;

-- STEP 3: Geographic EDA

-- a) Project by district

SELECT district,
COUNT(district) as project_count_survey
FROM survey_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY project_count_survey DESC ;


SELECT district,
COUNT(district) as project_count_construction
FROM construction_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY project_count_construction DESC 
;


SELECT district,
COUNT(district) as project_count_operating
FROM operating_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY project_count_operating DESC
; 

SELECT district,
COUNT(*) as total_projects,
ROUND(SUM(capacity_mw)::NUMERIC,2) as "total_capacity(mw)_construction"
FROM construction_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY "total_capacity(mw)_construction" DESC,total_projects DESC
;

SELECT district,
COUNT(*) as total_projects,
ROUND(SUM(capacity_mw)::NUMERIC,2) as "total_capacity(mw)_survey"
FROM survey_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY "total_capacity(mw)_survey" DESC,total_projects DESC
;

SELECT district,
COUNT(*) as total_projects,
ROUND(SUM(capacity_mw)::NUMERIC,2) as "total_capacity(mw)_operating"
FROM operating_data
WHERE district IS NOT NULL
GROUP BY district
ORDER BY "total_capacity(mw)_operating" DESC,total_projects DESC
;

-- STEP 4) Company/Promoter Analysis

SELECT *
FROM survey_data;

-- a) Total projects and capacity by promoter 


SELECT promoter_new,
COUNT(*) AS total_projects_construction,
SUM(capacity_mw) as total_capacity_mw
FROM construction_data
GROUP BY promoter_new
ORDER BY total_capacity_mw DESC
;

SELECT promoter_new,
COUNT(*) AS total_projects_surveying,
SUM(capacity_mw) as total_capacity_mw
FROM survey_data
GROUP BY promoter_new
ORDER BY total_capacity_mw DESC
;

SELECT promoter_new,
COUNT(*) AS total_projects_operating,
ROUND(SUM(capacity_mw)::NUMERIC,2) as total_capacity_mw
FROM operating_data
GROUP BY promoter_new
ORDER BY total_capacity_mw DESC
;



-- STEP 5) Time Analysis 

-- NEED TO TYPE CAST
SELECT 
	EXTRACT(YEAR FROM c_o_d_ad::DATE) as commercial_operation_year,
	COUNT(*) as total_projects
FROM operating_data
WHERE EXTRACT(YEAR FROM c_o_d_ad::DATE) IS NOT NULL
GROUP BY commercial_operation_year
ORDER BY commercial_operation_year DESC
;


SELECT 
	EXTRACT(YEAR FROM issue_date_ad::DATE) as construction_issue_year,
	COUNT(*) as total_projects
FROM construction_data
WHERE EXTRACT(YEAR FROM issue_date_ad::DATE) IS NOT NULL
GROUP BY construction_issue_year
ORDER BY construction_issue_year 
;

SELECT 
	EXTRACT(YEAR FROM issue_date_ad::DATE) as survey_issue_year,
	COUNT(*) as total_projects
FROM survey_data
WHERE EXTRACT(YEAR FROM issue_date_ad::DATE) IS NOT NULL
GROUP BY survey_issue_year
ORDER BY survey_issue_year
;

SELECT 
	EXTRACT(YEAR FROM c_o_d_ad::DATE) as commercial_operation_year,
	ROUND(SUM(capacity_mw)::NUMERIC,2) as total_capacity
FROM operating_data
WHERE EXTRACT(YEAR FROM c_o_d_ad::DATE) IS NOT NULL
GROUP BY commercial_operation_year
ORDER BY commercial_operation_year DESC
;

-- STEP 6) Identifying the relationship

SELECT *
FROM construction_data;

SELECT *
FROM operating_data;

