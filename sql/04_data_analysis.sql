-- =====================================================
-- Data Assessment
-- Objective: Analyze the overall loan portfolio and
-- calculate key portfolio indicators.
-- =====================================================

SELECT
    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,
    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;
-- =====================================================
-- Data Assessment
-- Objective: Analyze loan default rates by
-- loan purpose.
-- =====================================================

SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,
    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
GROUP BY loan_intent
ORDER BY default_rate DESC;
-- =====================================================
-- Section 4.5 - Loan Grade Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Analyze loan default rates by
-- loan grade.
-- =====================================================

SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,
    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
GROUP BY loan_grade
ORDER BY loan_grade;
-- =====================================================
-- Section 4.7 - Annual Income Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Identify income distribution quartiles
-- to define balanced income segments.
-- =====================================================

SELECT
    APPROX_QUANTILES(person_income, 4) AS income_quartiles
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;


-- =====================================================
-- Data Analysis
-- Objective: Analyze loan default rates across
-- annual income quartiles.
-- =====================================================

SELECT
    CASE
        WHEN person_income <= 38450 THEN 'Q1 - Low Income'
        WHEN person_income <= 55000 THEN 'Q2 - Lower-Middle Income'
        WHEN person_income <= 78300 THEN 'Q3 - Upper-Middle Income'
        ELSE 'Q4 - High Income'
    END AS income_quartile,

    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY income_quartile

ORDER BY
    CASE
        WHEN income_quartile = 'Q1 - Low Income' THEN 1
        WHEN income_quartile = 'Q2 - Lower-Middle Income' THEN 2
        WHEN income_quartile = 'Q3 - Upper-Middle Income' THEN 3
        WHEN income_quartile = 'Q4 - High Income' THEN 4
    END;
    -- =====================================================
-- Section 4.8 - Loan Percent Income Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Explore the distribution of
-- loan_percent_income before segmentation.
-- =====================================================

SELECT
    MIN(loan_percent_income) AS minimum_loan_percent,
    MAX(loan_percent_income) AS maximum_loan_percent,
    ROUND(AVG(loan_percent_income), 2) AS average_loan_percent,
    APPROX_QUANTILES(loan_percent_income, 4) AS loan_percent_quartiles
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;
-- =====================================================
-- Data Analysis
-- Objective: Analyze default rates across
-- loan_percent_income quartiles.
-- =====================================================

SELECT
    CASE
        WHEN loan_percent_income <= 0.09 THEN 'Q1 - Low Percent Income'
        WHEN loan_percent_income <= 0.15 THEN 'Q2 - Lower-Middle Percent Income'
        WHEN loan_percent_income <= 0.23 THEN 'Q3 - Upper-Middle Percent Income'
        ELSE 'Q4 - High Percent Income'
    END AS loan_percent_quartile,

    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY loan_percent_quartile

ORDER BY
    CASE
        WHEN loan_percent_quartile = 'Q1 - Low Percent Income' THEN 1
        WHEN loan_percent_quartile = 'Q2 - Lower-Middle Percent Income' THEN 2
        WHEN loan_percent_quartile = 'Q3 - Upper-Middle Percent Income' THEN 3
        WHEN loan_percent_quartile = 'Q4 - High Percent Income' THEN 4
    END;
    -- =====================================================
-- Data Analysis
-- Objective: Drill down into the highest loan-to-income
-- burden segment to identify where default risk increases.
-- =====================================================

SELECT
    CASE
        WHEN loan_percent_income <= 0.30 THEN '23-30%'
        WHEN loan_percent_income <= 0.40 THEN '30-40%'
        WHEN loan_percent_income <= 0.50 THEN '40-50%'
        ELSE '50%+'
    END AS loan_percent_range,

    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

WHERE loan_percent_income > 0.23

GROUP BY loan_percent_range

ORDER BY
    CASE
        WHEN loan_percent_range = '23-30%' THEN 1
        WHEN loan_percent_range = '30-40%' THEN 2
        WHEN loan_percent_range = '40-50%' THEN 3
        WHEN loan_percent_range = '50%+' THEN 4
    END;
    -- =====================================================
-- Section 4.9 - Home Ownership Analysis
-- =====================================================

-- =====================================================
-- Data Analysis
-- Objective: Analyze default rates and portfolio
-- distribution across home ownership categories.
-- =====================================================

SELECT
    person_home_ownership,

    COUNT(*) AS total_loans,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS portfolio_share,

    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY person_home_ownership

ORDER BY default_rate ASC;
-- =====================================================
-- Section 4.10 - Previous Default History Analysis
-- =====================================================

-- =====================================================
-- Data Analysis
-- Objective: Analyze the relationship between previous
-- default history and current loan default risk,
-- portfolio exposure, and contribution to total defaults.
-- =====================================================

SELECT
    cb_person_default_on_file,

    COUNT(*) AS total_loans,

    -- Share of total loan portfolio
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS portfolio_share,

    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    -- Share of all defaults contributed by each group
    ROUND(
        COUNTIF(loan_status = 1) * 100.0
        / SUM(COUNTIF(loan_status = 1)) OVER(),
        2
    ) AS default_share,

    -- Default rate within each group
    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY cb_person_default_on_file

ORDER BY default_rate ASC;
-- =====================================================
-- Section 4.11 - Applicant Age Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Explore the age distribution before
-- defining applicant age segments.
-- =====================================================

SELECT
    MIN(person_age) AS minimum_age,
    MAX(person_age) AS maximum_age,
    ROUND(AVG(person_age), 2) AS average_age,
    APPROX_QUANTILES(person_age, 4) AS age_quartiles
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;
-- =====================================================
-- Data Analysis
-- Objective: Analyze default rates, portfolio exposure,
-- and contribution to defaults across age groups.
-- =====================================================

SELECT
    CASE
        WHEN person_age BETWEEN 20 AND 24 THEN '20-24'
        WHEN person_age BETWEEN 25 AND 29 THEN '25-29'
        WHEN person_age BETWEEN 30 AND 39 THEN '30-39'
        WHEN person_age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_range,

    COUNT(*) AS total_loans,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS portfolio_share,

    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0
        / SUM(COUNTIF(loan_status = 1)) OVER(),
        2
    ) AS default_share,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY age_range

ORDER BY
    CASE
        WHEN age_range = '20-24' THEN 1
        WHEN age_range = '25-29' THEN 2
        WHEN age_range = '30-39' THEN 3
        WHEN age_range = '40-49' THEN 4
        WHEN age_range = '50+' THEN 5
    END;
    -- =====================================================
-- Section 4.12 - Employment Length Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Explore the employment length distribution
-- before defining employment tenure segments.
-- =====================================================

SELECT
    MIN(person_emp_length) AS minimum_emp_length,
    MAX(person_emp_length) AS maximum_emp_length,
    ROUND(AVG(person_emp_length), 2) AS average_emp_length,
    APPROX_QUANTILES(person_emp_length, 4) AS employment_length_quartiles
FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
WHERE person_emp_length IS NOT NULL;
-- =====================================================
-- Data Analysis
-- Objective: Analyze default rates, portfolio exposure,
-- and contribution to defaults across employment
-- length segments.
-- =====================================================

SELECT
    CASE
        WHEN person_emp_length <= 2 THEN '0-2'
        WHEN person_emp_length <= 4 THEN '3-4'
        WHEN person_emp_length <= 7 THEN '5-7'
        ELSE '8+'
    END AS employment_range,

    COUNT(*) AS total_loans,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS portfolio_share,

    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0
        / SUM(COUNTIF(loan_status = 1)) OVER(),
        2
    ) AS default_share,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

WHERE person_emp_length IS NOT NULL

GROUP BY employment_range

ORDER BY
    CASE
        WHEN employment_range = '0-2' THEN 1
        WHEN employment_range = '3-4' THEN 2
        WHEN employment_range = '5-7' THEN 3
        WHEN employment_range = '8+' THEN 4
    END;
    -- =====================================================
-- Section 4.13 - Loan Amount Analysis
-- =====================================================

-- =====================================================
-- Data Assessment
-- Objective: Explore the loan amount distribution
-- before defining loan amount segments.
-- =====================================================

SELECT
    MAX(loan_amnt) AS max,
    MIN(loan_amnt) AS min,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amnt,
    APPROX_QUANTILES(loan_amnt, 4) AS quantiles

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`;
-- =====================================================
-- Data Analysis
-- Objective: Analyze default rates, portfolio exposure,
-- and contribution to defaults across loan amount
-- segments.
-- =====================================================

SELECT
    CASE
        WHEN loan_amnt <= 5000 THEN 'Q1 - Low Amount'
        WHEN loan_amnt <= 8000 THEN 'Q2 - Lower-Middle Amount'
        WHEN loan_amnt <= 12075 THEN 'Q3 - Upper-Middle Amount'
        ELSE 'Q4 - High Amount'
    END AS loan_amount_range,

    COUNT(*) AS total_loans,

    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS portfolio_share,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0
        / SUM(COUNTIF(loan_status = 1)) OVER(),
        2
    ) AS default_share

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY loan_amount_range

ORDER BY
    CASE
        WHEN loan_amount_range = 'Q1 - Low Amount' THEN 1
        WHEN loan_amount_range = 'Q2 - Lower-Middle Amount' THEN 2
        WHEN loan_amount_range = 'Q3 - Upper-Middle Amount' THEN 3
        WHEN loan_amount_range = 'Q4 - High Amount' THEN 4
    END;
    -- =====================================================
-- Section 5.1 - Loan Amount vs Income Burden
-- =====================================================

SELECT
    CASE
        WHEN loan_amnt <= 5000 THEN 'Q1'
        WHEN loan_amnt <= 8000 THEN 'Q2'
        WHEN loan_amnt <= 12075 THEN 'Q3'
        ELSE 'Q4'
    END AS loan_amount_group,

    CASE
        WHEN loan_percent_income <= 0.09 THEN 'Q1'
        WHEN loan_percent_income <= 0.15 THEN 'Q2'
        WHEN loan_percent_income <= 0.23 THEN 'Q3'
        ELSE 'Q4'
    END AS income_burden_group,

    COUNT(*) AS total_loans,
    COUNTIF(loan_status = 0) AS non_default_loans,
    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY loan_amount_group, income_burden_group

ORDER BY
    CASE
        WHEN loan_amount_group = 'Q1' THEN 1
        WHEN loan_amount_group = 'Q2' THEN 2
        WHEN loan_amount_group = 'Q3' THEN 3
        WHEN loan_amount_group = 'Q4' THEN 4
    END,
    CASE
        WHEN income_burden_group = 'Q1' THEN 1
        WHEN income_burden_group = 'Q2' THEN 2
        WHEN income_burden_group = 'Q3' THEN 3
        WHEN income_burden_group = 'Q4' THEN 4
    END;
    -- =====================================================
-- Section 5.2 - Loan Grade vs Income Burden
-- =====================================================

-- Objective:
-- Analyze the combined relationship between loan grade,
-- income burden and loan default risk.

SELECT
    loan_grade,

    CASE
        WHEN loan_percent_income <= 0.09 THEN 'Q1'
        WHEN loan_percent_income <= 0.15 THEN 'Q2'
        WHEN loan_percent_income <= 0.23 THEN 'Q3'
        ELSE 'Q4'
    END AS income_burden_group,

    COUNT(*) AS total_loans,

    COUNTIF(loan_status = 0) AS non_default_loans,

    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY
    loan_grade,
    income_burden_group

ORDER BY
    loan_grade,

    CASE
        WHEN income_burden_group = 'Q1' THEN 1
        WHEN income_burden_group = 'Q2' THEN 2
        WHEN income_burden_group = 'Q3' THEN 3
        WHEN income_burden_group = 'Q4' THEN 4
    END;
    -- =====================================================
-- Section 5.3 - Loan Intent vs Income Burden
-- =====================================================

-- Objective:
-- Analyze the combined relationship between loan intent,
-- income burden and loan default risk.

SELECT
    loan_intent,

    CASE
        WHEN loan_percent_income <= 0.09 THEN 'Q1'
        WHEN loan_percent_income <= 0.15 THEN 'Q2'
        WHEN loan_percent_income <= 0.23 THEN 'Q3'
        ELSE 'Q4'
    END AS income_burden_group,

    COUNT(*) AS total_loans,

    COUNTIF(loan_status = 0) AS non_default_loans,

    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM `credit-risk-analysis-503718.dataset.Data_Clean1`

GROUP BY
    loan_intent,
    income_burden_group

ORDER BY
    loan_intent,

    CASE
        WHEN income_burden_group = 'Q1' THEN 1
        WHEN income_burden_group = 'Q2' THEN 2
        WHEN income_burden_group = 'Q3' THEN 3
        WHEN income_burden_group = 'Q4' THEN 4
    END;
    -- =====================================================
-- Section 5.4 - Final High-Risk Profile
-- =====================================================

-- Objective:
-- Identify high-risk loan profiles by combining
-- loan grade, loan intent and income burden.

WITH risk_data AS (

    SELECT
        loan_grade,
        loan_intent,
        loan_status,

        CASE
            WHEN loan_percent_income <= 0.09 THEN 'Q1'
            WHEN loan_percent_income <= 0.15 THEN 'Q2'
            WHEN loan_percent_income <= 0.23 THEN 'Q3'
            ELSE 'Q4'
        END AS income_burden_group

    FROM `credit-risk-analysis-503718.dataset.Data_Clean1`
)

SELECT
    loan_grade,
    loan_intent,
    income_burden_group,

    COUNT(*) AS total_loans,

    COUNTIF(loan_status = 0) AS non_default_loans,

    COUNTIF(loan_status = 1) AS default_loans,

    ROUND(
        COUNTIF(loan_status = 1) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM risk_data

GROUP BY
    loan_grade,
    loan_intent,
    income_burden_group

-- Exclude very small segments
HAVING COUNT(*) >= 50

-- Highest-risk profiles first
ORDER BY default_rate DESC;