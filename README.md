# 💳 Credit Risk & Loan Default Analysis

## 📌 Project Overview

This project analyzes a consumer loan portfolio to identify patterns associated with loan default and develop a risk segmentation framework based on borrower and loan characteristics.

The analysis follows the complete data analytics workflow, from data cleaning and SQL-based exploratory analysis to multivariable risk segmentation and the development of an interactive Power BI dashboard.

The objective is not to build a predictive credit scoring model, but to identify meaningful relationships within the historical data that can support credit risk analysis, portfolio monitoring, and lending policy discussions.

---

## 🎯 Business Problem

Financial institutions must balance loan portfolio growth and profitability with the risk of borrower default.

The main business question addressed in this project is:

> **Which borrower and loan characteristics are most strongly associated with default, and how can they be used to identify higher-risk segments within the portfolio?**

The analysis focuses on understanding how default behavior changes across credit grades, income burden levels, and loan purposes.

---

## 🔎 Project Objectives

- Clean and validate the raw loan dataset.
- Identify data quality issues and unrealistic records.
- Analyze the overall default behavior of the portfolio.
- Evaluate borrower and loan characteristics associated with default.
- Identify variables with meaningful risk patterns.
- Analyze interactions between multiple risk factors.
- Develop customer risk segments based on observed historical behavior.
- Build an interactive Power BI dashboard for portfolio monitoring.
- Translate analytical findings into business recommendations.

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| **Google BigQuery** | Data cleaning, transformation and SQL analysis |
| **SQL** | Exploratory analysis, segmentation and multivariable analysis |
| **Power BI** | Data modeling, DAX measures and interactive dashboard |
| **Power Query** | Data validation and final preparation |
| **DAX** | KPI calculations and dynamic risk metrics |
| **GitHub** | Project documentation and portfolio presentation |

---

## 📊 Dataset

The dataset contains borrower characteristics, loan information, credit history and loan default status.

Key variables analyzed include:

- `person_age`
- `person_income`
- `person_home_ownership`
- `person_emp_length`
- `loan_intent`
- `loan_grade`
- `loan_amnt`
- `loan_int_rate`
- `loan_status`
- `loan_percent_income`
- `cb_person_default_on_file`
- `cb_person_cred_hist_length`

The target variable used throughout the analysis is:

`loan_status`

Where:

- **0 = Non-default**
- **1 = Default**

After the data cleaning process, the final analytical dataset contained:

**32,409 loan records**

---

## 🧹 Data Preparation & Cleaning

The raw dataset was processed in Google BigQuery before performing the main analysis.

The cleaning process included:

- Data type validation.
- Duplicate record analysis.
- Missing value analysis.
- Detection of unrealistic borrower ages.
- Validation of employment length.
- Treatment of missing interest rate values.
- Validation of numerical distributions and outliers.
- Creation of a final clean analytical table.

The resulting dataset was stored as:

```sql
credit-risk-analysis-503718.dataset.Data_Clean1
```

This table was used as the primary source for both the SQL analysis and Power BI dashboard.

---

## 🔍 Exploratory Data Analysis

The exploratory analysis evaluated each variable against loan default behavior to determine whether meaningful patterns were present.

The analysis included:

- Default distribution.
- Borrower demographics.
- Income levels.
- Employment history.
- Home ownership.
- Loan amount.
- Interest rate.
- Loan purpose.
- Credit grade.
- Loan-to-income burden.
- Previous default history.
- Credit history length.

Not every variable demonstrated the same analytical relevance.

Some variables that initially appeared likely to influence default showed relatively weak patterns when analyzed independently, while others became more informative when combined with additional risk factors.

---

## 🧩 Multivariable Risk Analysis

After evaluating individual variables, the analysis focused on combinations of the strongest risk-related characteristics.

Three variables became particularly useful for risk segmentation:

- **Loan Grade**
- **Loan Percent Income**
- **Loan Intent**

### Income Burden Segmentation

`loan_percent_income` was segmented into four groups:

| Income Burden Group | Loan Percent Income |
|---|---:|
| **Q1** | ≤ 9% |
| **Q2** | > 9% – 15% |
| **Q3** | > 15% – 23% |
| **Q4** | > 23% |

This segmentation made it possible to evaluate how borrower repayment behavior changed as the loan represented a larger proportion of income.

---

## 📈 Portfolio KPIs

The final portfolio contained:

| KPI | Result |
|---|---:|
| **Total Loans** | 32,409 |
| **Total Exposure** | $310.88M |
| **Defaulted Loans** | 7,088 |
| **Default Rate** | 21.87% |
| **Default Exposure** | $76.93M |

These KPIs provide an executive-level overview of the portfolio's historical default performance.

---

## 🔥 Key Findings

### 1. Loan Grade Shows a Strong Relationship With Default

Default rates increase significantly as loan grade deteriorates.

| Loan Grade | Default Rate |
|---|---:|
| A | 9.96% |
| B | 16.32% |
| C | 20.76% |
| D | 59.05% |
| E | 64.49% |
| F | 70.54% |
| G | 98.44% |

The most significant deterioration occurs between Grades C and D.

However, loan grade should not be interpreted independently.

---

### 2. Income Burden Is a Major Risk Indicator

Default rates increase as the loan represents a greater proportion of borrower income.

| Income Burden | Default Rate |
|---|---:|
| Q1 | 11.59% |
| Q2 | 12.82% |
| Q3 | 18.65% |
| Q4 | 46.73% |

The most significant deterioration occurs in **Q4**, where borrowers allocate more than 23% of their income toward the loan.

This segment shows a default rate approximately four times higher than Q1.

---

### 3. Loan Grade and Income Burden Provide Stronger Segmentation Together

One of the most important findings of the project is that credit grade alone does not fully explain default behavior.

For example, Grade A borrowers show:

- **Q1:** 3.81% default rate
- **Q2:** 3.28%
- **Q3:** 7.45%
- **Q4:** 34.50%

Even borrowers with the highest credit grade experience substantial deterioration when income burden becomes elevated.

At the opposite end of the portfolio, Grade G borrowers show default rates between **80% and 100%**, depending on income burden.

This demonstrates the importance of evaluating multiple risk characteristics simultaneously rather than relying on a single variable.

---

### 4. Loan Purpose Provides Additional Risk Information

Loan purpose also showed meaningful differences in historical default behavior.

**Debt Consolidation** presented the highest overall default rate at approximately **28%**, followed by categories such as Medical and Home Improvement.

However, a higher default rate does not automatically imply that a particular loan product should be restricted.

Loan purpose should instead be evaluated alongside additional characteristics such as:

- Loan Grade
- Income Burden
- Borrower characteristics
- Credit history

---

## 📊 Power BI Dashboard

An interactive Power BI dashboard was developed to translate the SQL analysis into a portfolio monitoring tool.

The dashboard includes:

### Executive KPIs

- Total Loans
- Total Exposure
- Default Exposure
- Defaulted Loans
- Default Rate

### Risk Visualizations

- Default Rate by Loan Grade
- Default Rate by Loan Purpose
- Default Rate by Income Burden
- Loan Grade × Income Burden Risk Matrix

### Interactive Filters

Users can dynamically segment the portfolio by:

- Loan Grade
- Loan Purpose
- Income Burden

All KPIs and visualizations respond dynamically to the selected filters.

---

## 🖼️ Dashboard Preview

![Credit Risk Dashboard](images/credit_risk_dashboard.png)

---

## 💡 Business Recommendations

The analysis can serve as a starting point for the development of a **credit risk segmentation framework**.

A conceptual decision structure could include:

### Lower-Risk Segments

Continue through the institution's standard credit evaluation process.

### Intermediate-Risk Segments

Require additional borrower evaluation or affordability analysis.

### High-Risk Segments

Apply enhanced credit review, additional requirements or more restrictive lending conditions.

### Very High-Risk Segments

Consider restriction or rejection according to the institution's credit policy and risk appetite.

The exact thresholds should not be determined from this analysis alone.

They should be established in collaboration with credit managers, risk teams and other stakeholders based on:

- Institutional risk appetite
- Expected losses
- Profitability targets
- Portfolio strategy
- Lending limits
- Credit policy

---

## ⚠️ Project Limitations

This project is a **descriptive and exploratory analysis**.

The relationships identified within the dataset represent historical associations and:

- Do not demonstrate causality.
- Do not constitute a predictive probability-of-default model.
- Should not independently determine credit approval or rejection decisions.

Variables that show weak relationships individually may still provide useful information when combined with other borrower characteristics.

Additionally, the dataset does not contain several variables that would be important for a complete credit risk decision framework, including:

- Actual profitability by loan.
- Recovery after default.
- Loss Given Default (LGD).
- Collateral information.
- Operational costs.
- Expected credit losses.

A future extension of the project could evaluate multivariable statistical or machine-learning models to estimate probability of default.

---

## 📁 Repository Structure

```text
Credit-Risk-Analysis/
│
├── README.md
│
├── Credit_Risk_Analysis.pbix
│
├── SQL/
│   ├── data_cleaning.sql
│   ├── exploratory_analysis.sql
│   └── multivariable_risk_analysis.sql
│
├── images/
│   └── credit_risk_dashboard.png
│
└── documentation/
    └── Credit_Risk_Technical_Report.pdf
```

---

## 🚀 Skills Demonstrated

This project demonstrates practical experience in:

- SQL data cleaning
- Data quality validation
- Exploratory Data Analysis
- Credit risk segmentation
- Multivariable analysis
- CTEs and conditional logic
- SQL aggregations
- Power BI data modeling
- DAX measures
- Conditional formatting
- Interactive dashboard development
- KPI design
- Business interpretation
- Data storytelling
- Translating analytical findings into business recommendations

---

## 👤 Author

**Adrián Gámez**

Industrial Engineer | Business Intelligence & Data Analytics

### Portfolio Focus

SQL • Power BI • Business Intelligence • Data Analysis • Process Improvement
