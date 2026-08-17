-- =====================================================
-- Data Cleaning
-- Objective: Remove exact duplicate records while
-- preserving a single copy of each duplicated group.
-- A new clean table is created to preserve the original
-- dataset.
-- =====================================================

CREATE OR REPLACE TABLE
    `credit-risk-analysis-503718.dataset.Data_Clean` AS

SELECT
    * EXCEPT(row_num)
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                person_age,
                person_income,
                person_home_ownership,
                person_emp_length,
                loan_intent,
                loan_grade,
                loan_amnt,
                loan_int_rate,
                loan_status,
                loan_percent_income,
                cb_person_default_on_file,
                cb_person_cred_hist_length
        ) AS row_num
    FROM `credit-risk-analysis-503718.dataset.Data`
)
WHERE row_num = 1;
-- =====================================================
-- Data Cleaning
-- Objective: Remove exact duplicate records while
-- preserving one copy of each unique row.
-- =====================================================

CREATE OR REPLACE TABLE
    `credit-risk-analysis-503718.dataset.Data_Clean` AS

SELECT DISTINCT *
FROM `credit-risk-analysis-503718.dataset.Data`;
-- =====================================================
-- Data Cleaning
-- Objective: Analyze interest rate ranges and averages
-- by loan grade before imputing missing values.
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total,
    MIN(loan_int_rate) AS min_interest_rate,
    MAX(loan_int_rate) AS max_interest_rate,
    ROUND(AVG(loan_int_rate), 2) AS avg_interest_rate
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
GROUP BY loan_grade
ORDER BY loan_grade;
-- =====================================================
-- Data Assessment
-- Objective: Count missing interest rates by loan grade.
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total_nulls
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
WHERE loan_int_rate IS NULL
GROUP BY loan_grade
ORDER BY total_nulls DESC;
-- =====================================================
-- Data Assessment
-- Objective: Calculate the percentage of missing
-- interest rates within each loan grade.
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total_records,
    COUNTIF(loan_int_rate IS NULL) AS total_nulls,
    ROUND(
        COUNTIF(loan_int_rate IS NULL) * 100.0 / COUNT(*),
        2
    ) AS null_percentage
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
GROUP BY loan_grade
ORDER BY null_percentage DESC;
-- =====================================================
-- Data Cleaning
-- Objective: Impute missing loan_int_rate values using
-- the average interest rate of each loan_grade.
-- =====================================================

CREATE OR REPLACE TABLE
    `credit-risk-analysis-503718.dataset.Data_Clean` AS

WITH grade_averages AS (
    SELECT
        loan_grade,
        AVG(loan_int_rate) AS avg_interest_rate
    FROM `credit-risk-analysis-503718.dataset.Data_Clean`
    GROUP BY loan_grade
)

SELECT
    d.* EXCEPT(loan_int_rate),
    CASE
        WHEN d.loan_int_rate IS NULL THEN g.avg_interest_rate
        ELSE d.loan_int_rate
    END AS loan_int_rate
FROM `credit-risk-analysis-503718.dataset.Data_Clean` AS d
INNER JOIN grade_averages AS g
    ON d.loan_grade = g.loan_grade;
    -- =====================================================
-- Data Assessment
-- Objective: Identify unrealistic age values.
-- =====================================================

SELECT
    person_age,
    COUNT(*) AS total_records
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
WHERE person_age > 100
GROUP BY person_age
ORDER BY person_age DESC;
-- =====================================================
-- Data Assessment
-- Objective: Inspect records with unrealistic ages.
-- =====================================================

SELECT *
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
WHERE person_age > 100
ORDER BY person_age DESC;
-- =====================================================
-- Data Cleaning
-- Objective: Remove records with unrealistic ages
-- greater than 100 years.
-- =====================================================

CREATE OR REPLACE TABLE
    `credit-risk-analysis-503718.dataset.Data_Clean` AS

SELECT *
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
WHERE person_age <= 100;
-- =====================================================
-- Data Validation
-- Objective: Confirm that unrealistic age values were
-- successfully removed.
-- =====================================================

SELECT
    COUNT(*) AS remaining_invalid_age_records
FROM `credit-risk-analysis-503718.dataset.Data_Clean`
WHERE person_age > 100;
-- =====================================================
-- Data Assessment
-- Objective: Evaluate missing values in
-- person_emp_length.
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    COUNTIF(person_emp_length IS NULL) AS null_records,
    ROUND(
        COUNTIF(person_emp_length IS NULL) * 100.0 / COUNT(*),
        2
    ) AS null_percentage
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;
-- =====================================================
-- Data Cleaning
-- Objective: Identify records where employment length
-- is greater than the applicant's age.
-- =====================================================

SELECT
    *
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
WHERE person_emp_length > person_age
ORDER BY person_emp_length DESC;
-- =====================================================
-- Data Cleaning
-- Objective: Remove logically inconsistent employment
-- length records while preserving NULL values.
-- =====================================================

CREATE OR REPLACE TABLE
    `credit-risk-analysis-503718.dataset.Data_Clean1` AS

SELECT *
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
WHERE person_emp_length <= person_age
   OR person_emp_length IS NULL;
   -- =====================================================
-- Data Validation
-- Objective: Confirm that invalid employment length
-- records were successfully removed.
-- =====================================================

SELECT
    COUNT(*) AS remaining_invalid_records
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
WHERE person_emp_length > person_age;
-- =====================================================