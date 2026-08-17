-- =====================================================
-- DATA AUDIT
-- Missing values in loan_int_rate
-- =====================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(loan_int_rate) AS non_null_values,
    COUNTIF(loan_int_rate IS NULL) AS null_values,
    ROUND(COUNTIF(loan_int_rate IS NULL) * 100 / COUNT(*),2) AS null_percentage
FROM `credit-risk-analysis-503718.dataset.Data`;



-- =====================================================
-- Inspect records with missing interest rates
-- =====================================================

SELECT
    loan_status,
    loan_amnt,
    loan_percent_income,
    loan_grade
FROM `credit-risk-analysis-503718.dataset.Data`
WHERE loan_int_rate IS NULL;
-- =====================================================
-- Data Audit
-- Objective: Analyze the distribution of NULL values in
-- loan_int_rate by loan status.
-- =====================================================

SELECT
    loan_status,
    COUNT(*) AS total_nulls
FROM `credit-risk-analysis-503718.dataset.Data`
WHERE loan_int_rate IS NULL
GROUP BY loan_status
ORDER BY total_nulls DESC;
-- =====================================================
-- Data Audit
-- Objective: Identify completely duplicated records.
-- =====================================================

SELECT
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
    cb_person_cred_hist_length,
    COUNT(*) AS duplicate_count
FROM `credit-risk-analysis-503718.dataset.Data`
GROUP BY
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
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
-- =====================================================
-- Data Audit
-- Objective: Review categories in person_home_ownership.
-- =====================================================

SELECT DISTINCT
    person_home_ownership
FROM `credit-risk-analysis-503718.dataset.Data`;
-- =====================================================
-- Data Audit
-- Objective: Analyze the distribution of
-- person_home_ownership.
-- =====================================================

SELECT
    person_home_ownership,
    COUNT(*) AS total
FROM `credit-risk-analysis-503718.dataset.Data`
GROUP BY person_home_ownership
ORDER BY total DESC;
-- =====================================================
-- Data Audit
-- Objective: Review categories in loan_intent.
-- =====================================================

SELECT DISTINCT
    loan_intent
FROM `credit-risk-analysis-503718.dataset.Data`;
-- =====================================================
-- Data Audit
-- Objective: Analyze the distribution of loan_intent.
-- =====================================================

SELECT
    loan_intent,
    COUNT(*) AS total
FROM `credit-risk-analysis-503718.dataset.Data`
GROUP BY loan_intent
ORDER BY total DESC;
-- =====================================================
-- Data Audit
-- Objective: Review categories in
-- cb_person_default_on_file.
-- =====================================================

SELECT DISTINCT
    cb_person_default_on_file
FROM `credit-risk-analysis-503718.dataset.Data`;
-- =====================================================
-- Data Audit
-- Objective: Analyze the distribution of
-- cb_person_default_on_file.
-- =====================================================

SELECT
    cb_person_default_on_file,
    COUNT(*) AS total
FROM `credit-risk-analysis-503718.dataset.Data`
GROUP BY cb_person_default_on_file
ORDER BY total DESC;
-- =====================================================
-- Data Audit
-- Objective: Review categories in loan_grade.
-- =====================================================

SELECT DISTINCT
    loan_grade
FROM `credit-risk-analysis-503718.dataset.Data`;
-- =====================================================
-- Data Audit
-- Objective: Analyze the distribution of loan grades.
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total
FROM `credit-risk-analysis-503718.dataset.Data`
GROUP BY loan_grade
ORDER BY total DESC;
-- =====================================================
-- Data Audit
-- Objective: Review the range of numerical variables.
-- =====================================================

SELECT
    MIN(person_age) AS min_age,
    MAX(person_age) AS max_age,

    MIN(person_income) AS min_income,
    MAX(person_income) AS max_income,

    MIN(person_emp_length) AS min_emp_length,
    MAX(person_emp_length) AS max_emp_length,

    MIN(loan_amnt) AS min_loan_amount,
    MAX(loan_amnt) AS max_loan_amount,

    MIN(loan_int_rate) AS min_interest_rate,
    MAX(loan_int_rate) AS max_interest_rate,

    MIN(loan_percent_income) AS min_percent_income,
    MAX(loan_percent_income) AS max_percent_income,

    MIN(cb_person_cred_hist_length) AS min_credit_history,
    MAX(cb_person_cred_hist_length) AS max_credit_history

FROM `credit-risk-analysis-503718.dataset.Data`;