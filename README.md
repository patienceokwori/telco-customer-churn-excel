# Telco Customer Churn Analysis Using Excel and PostgreSQL

## Project Overview

This project analyses customer churn for a telecommunications company using Microsoft Excel and PostgreSQL.

The purpose of the analysis was to identify customer groups with high churn rates, estimate the business impact of customer churn and recommend practical actions that could improve customer retention.

The project demonstrates how the same business problem can be investigated using both a visual spreadsheet tool and a relational database.

## Business Objectives

The analysis was designed to answer the following questions:

1. What is the overall customer churn rate?
2. Which contract type has the highest churn rate?
3. Does customer tenure affect churn?
4. Which internet service has the highest churn rate?
5. Which payment method has the highest churn rate?
6. Do customers with higher monthly charges churn more?
7. Do senior citizens have a higher churn rate?
8. How much monthly revenue is associated with churned customers?
9. Which combination of customer characteristics produces the highest-risk segment?

## Dataset

- **Dataset:** IBM Telco Customer Churn
- **Total customers:** 7,043
- **Original columns:** 21
- **Target column:** `Churn`
- **Source:** [IBM Telco Customer Churn Dataset](https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv)

The dataset contains customer demographic information, account details, subscribed services, payment information, monthly charges, total charges and churn status.

## Tools and Skills Used

### Microsoft Excel

- Data cleaning and validation
- Excel Tables
- `IF` and nested `IF` formulas
- `TRIM`, `LEN` and `VALUE` functions
- Helper columns
- PivotTables
- KPI calculations
- Charts
- Dashboard design
- Business insight development

### PostgreSQL

- Database and table creation
- CSV data import
- Data-quality checks
- Duplicate detection
- Missing-value investigation
- Data cleaning
- Data-type conversion
- Aggregate functions
- `WHERE` and `FILTER` conditions
- `GROUP BY`
- `ORDER BY`
- `CASE` statements
- Customer segmentation
- Business analysis

## Data Cleaning and Quality Checks

The following data-quality checks and cleaning steps were completed:

- Confirmed that the dataset contained 7,043 customer records
- Checked customer IDs for duplicates
- Confirmed that all customer IDs were unique
- Checked numerical columns for unreasonable minimum and maximum values
- Validated important categorical values
- Identified 11 hidden blank values in `TotalCharges`
- Confirmed that all 11 affected customers had zero months of tenure
- Replaced the blank `TotalCharges` values with zero
- Converted `TotalCharges` from text to a numerical data type
- Checked consistency between related customer-service columns

## Excel Helper Columns

The following helper columns were created in Excel:

- `TotalCharges_Clean`
- `ChurnFlag`
- `TenureGroup`
- `ChargeBand`

These columns supported the PivotTables, calculations and dashboard analysis.

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Customers | 7,043 |
| Customers Churned | 1,869 |
| Customers Retained | 5,174 |
| Overall Churn Rate | 26.54% |

## Excel Analysis

Excel PivotTables were used to calculate churn rates across important customer groups, including:

- Contract type
- Customer tenure
- Internet service
- Payment method
- Monthly charge band
- Technical support
- Online security
- Senior-citizen status
- Paperless billing
- Partner status
- Dependent status

The final Excel dashboard contains KPI cards, charts, key findings and business recommendations.

## PostgreSQL Analysis

PostgreSQL was used to reproduce and extend the Excel analysis.

The SQL script contains:

- Table creation
- Data-import documentation
- Row-count verification
- Duplicate detection
- Missing-value investigation
- Data cleaning
- Data-type conversion
- Numerical-range validation
- Overall churn calculation
- Churn analysis by customer category
- `CASE`-based customer grouping
- Revenue analysis
- High-risk customer segmentation

## Key Findings

### 1. Overall churn

The company had an overall churn rate of **26.54%**. Out of 7,043 customers, 1,869 churned and 5,174 remained.

### 2. Contract type

Month-to-month customers had the highest contract churn rate at **42.71%**.

Customers with one-year and two-year contracts had much lower churn rates.

### 3. Customer tenure

Customers within their first 12 months had the highest tenure-group churn rate at **47.44%**.

Churn decreased as customer tenure increased.

### 4. Internet service

Fiber-optic customers had the highest internet-service churn rate at **41.89%**.

### 5. Payment method

Customers paying by electronic check had the highest payment-method churn rate at **45.29%**.

Customers using automatic payment methods had lower churn rates.

### 6. Monthly charges

Customers paying $80 or more per month had the highest charge-band churn rate at **33.99%**.

### 7. Technical support

Customers without technical support had a churn rate of **41.64%**, compared with **15.17%** among customers with technical support.

### 8. Online security

Customers without online security had a churn rate of **41.77%**, compared with **14.61%** among customers with online security.

### 9. Senior citizens

Senior citizens had a churn rate of **41.68%**, compared with **23.61%** among non-senior customers.

### 10. Paperless billing

Customers using paperless billing had a churn rate of **33.57%**, compared with **16.33%** among customers not using paperless billing.

### 11. Partner status

Customers without partners had a churn rate of **32.96%**, compared with **19.66%** among customers with partners.

### 12. Dependents

Customers without dependents had a churn rate of **31.28%**, compared with **15.45%** among customers with dependents.

## High-Risk Customer Segment

PostgreSQL was used to combine three high-risk characteristics:

- Month-to-month contract
- Fiber-optic internet
- Electronic-check payment

The results were:

| High-Risk Segment Metric | Result |
|---|---:|
| Total Customers | 1,307 |
| Customers Churned | 789 |
| Churn Rate | 60.37% |

This combined segment had a much higher churn rate than the company’s overall churn rate of 26.54%.

## Business Recommendations

Based on the analysis, the company should consider the following actions:

1. Strengthen onboarding and early customer support during the first 12 months.
2. Encourage suitable month-to-month customers to consider longer-term contracts.
3. Investigate fiber-optic service quality, pricing and customer expectations.
4. Promote automatic payment methods where appropriate.
5. Improve access to technical support and online security services.
6. Provide clearer billing and additional assistance for senior customers.
7. Review plans offered to customers with high monthly charges.
8. Target the identified high-risk segment with appropriate retention offers.
9. Monitor churn rates regularly to determine whether retention strategies are working.

## Important Analytical Note

The findings show relationships between customer characteristics and churn. They do not prove that any single characteristic directly caused a customer to leave.

Further customer feedback and service-quality information would be required to establish the causes of churn.

## Dashboard

![Telco Customer Churn Dashboard](Screenshot%202026-10-02%20110008.png)

## Project Files

- `Telco_Customer_Churn_Analysis.xlsx` — cleaned Excel workbook, calculations, PivotTables and dashboard
- `telco_churn_analysis.sql` — PostgreSQL table creation, data cleaning and business analysis
- `telco_churn_dashboard.png` — Excel dashboard image
- `README.md` — project documentation, findings and recommendations

## Project Outcome

This project demonstrates the ability to:

- Clean and validate customer data
- Analyse data using Excel and PostgreSQL
- Calculate and explain business KPIs
- Segment customers using formulas and SQL
- Develop an interactive Excel dashboard
- Translate analytical results into practical business recommendations
- Document and present a complete data-analysis project on GitHub

## Author

**Patience Okwori**  
Data Analyst Portfolio Project


