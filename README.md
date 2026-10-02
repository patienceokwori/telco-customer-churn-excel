# Telco Customer Churn Analysis in Excel

## Project Overview

This project analyses customer churn for a telecommunications company using Microsoft Excel. The goal was to identify customer groups with higher churn rates and provide practical recommendations that could support customer retention.

## Dataset

- Source: IBM Telco Customer Churn Dataset
- Total customers: 7,043
- Original columns: 21
- Target column: Churn

## Tools and Excel Skills Used

- Microsoft Excel Online
- Data cleaning and validation
- Excel Tables
- IF and nested IF formulas
- TRIM, LEN and VALUE functions
- Helper columns
- PivotTables
- KPI calculations
- Charts and dashboard design
- Business insight development

## Data Cleaning

The following quality checks and cleaning steps were completed:

- Checked all columns for missing values
- Identified 11 hidden blank values in `TotalCharges`
- Confirmed that those customers had zero months of tenure
- Replaced the hidden blanks with zero in a cleaned helper column
- Checked customer IDs for duplicates
- Validated numerical ranges and categorical values
- Checked consistency between related service columns

## Calculated Columns

The following helper columns were created:

- `TotalCharges_Clean`
- `ChurnFlag`
- `TenureGroup`
- `ChargeBand`

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Customers | 7,043 |
| Customers Churned | 1,869 |
| Customers Retained | 5,174 |
| Overall Churn Rate | 26.54% |

## Key Findings

- Month-to-month customers had the highest contract churn rate at 42.71%.
- Customers within their first 12 months had a churn rate of 47.44%.
- Fiber-optic customers had a churn rate of 41.89%.
- Electronic-check customers had a churn rate of 45.29%.
- Customers without technical support had a churn rate of 41.64%.
- Customers without online security had a churn rate of 41.77%.
- Senior citizens had a churn rate of 41.68%.
- Customers with high monthly charges had a churn rate of 33.99%.

## Recommendations

- Encourage suitable month-to-month customers to consider longer-term contracts.
- Improve onboarding and early support for new customers.
- Investigate the service quality, pricing and expectations of fiber-optic customers.
- Promote automatic payment methods where appropriate.
- Improve access to technical support and online security services.
- Provide clearer billing and additional assistance for senior customers.

## Dashboard

![Telco Customer Churn Dashboard](Screenshot%202026-10-02%20110008.png)

## Project Files

- `Telco_Customer_Churn_Analysis.xlsx` — complete Excel workbook
- `telco_churn_dashboard.png` — dashboard image

## Author

**Patience Okwori**  
Data Analyst Portfolio Project
