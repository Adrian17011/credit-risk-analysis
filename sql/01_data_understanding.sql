-- =====================================================
-- DATA UNDERSTANDING
-- Project: Credit Risk Analysis
-- =====================================================

-- 1. Total number of records

SELECT COUNT(*) AS total_records
FROM `credit-risk-analysis-503718.dataset.Data`;



-- =====================================================
-- Preview of the dataset
-- =====================================================

SELECT *
FROM `credit-risk-analysis-503718.dataset.Data`
LIMIT 10;