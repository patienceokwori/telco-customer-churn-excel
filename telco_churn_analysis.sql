/*==========================================================
  TELCO CUSTOMER CHURN ANALYSIS
  Tool: PostgreSQL and pgAdmin
  Author: Patience Okwori

  Project objective:
  Analyse customer churn, identify high-risk customer groups,
  and provide findings that may support customer retention.
==========================================================*/


/*==========================================================
  SECTION 1: CREATE THE TABLE
==========================================================*/

CREATE TABLE telco_churn (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen INTEGER,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INTEGER,
    phone_service VARCHAR(5),
    multiple_lines VARCHAR(20),
    internet_service VARCHAR(20),
    online_security VARCHAR(25),
    online_backup VARCHAR(25),
    device_protection VARCHAR(25),
    tech_support VARCHAR(25),
    streaming_tv VARCHAR(25),
    streaming_movies VARCHAR(25),
    contract VARCHAR(20),
    paperless_billing VARCHAR(5),
    payment_method VARCHAR(30),
    monthly_charges NUMERIC(10,2),
    total_charges VARCHAR(20),
    churn VARCHAR(5)
);


/*==========================================================
  SECTION 2: IMPORT THE DATA
==========================================================*/

/*
The Telco Customer Churn CSV file was imported through pgAdmin:

telco_churn table
→ Import/Export Data
→ Import
→ Format: CSV
→ Header: Yes
→ Delimiter: comma
→ Encoding: UTF8
*/


/*==========================================================
  SECTION 3: INITIAL DATA CHECKS
==========================================================*/


-- Display 10 sample records.

SELECT *
FROM telco_churn
LIMIT 10;


-- Count the total number of imported customers.

SELECT COUNT(*) AS total_customers
FROM telco_churn;


-- Check for duplicate customer IDs.

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_count
FROM telco_churn;


/*==========================================================
  SECTION 4: CHECK AND CLEAN TOTAL CHARGES
==========================================================*/


-- Check for NULL values and hidden blank values.

SELECT
    COUNT(*) FILTER (
        WHERE total_charges IS NULL
    ) AS null_count,

    COUNT(*) FILTER (
        WHERE TRIM(total_charges) = ''
    ) AS blank_count

FROM telco_churn;


-- Examine the customers with blank TotalCharges values.

SELECT
    customer_id,
    tenure,
    monthly_charges,
    total_charges
FROM telco_churn
WHERE TRIM(total_charges) = '';


/*
The investigation found 11 blank TotalCharges values.
All 11 customers had zero months of tenure.

The blanks were therefore replaced with zero.
*/

UPDATE telco_churn
SET total_charges = '0'
WHERE TRIM(total_charges) = '';


-- Confirm that no hidden blanks remain.

SELECT COUNT(*) AS remaining_blanks
FROM telco_churn
WHERE TRIM(total_charges) = '';


-- Convert TotalCharges from text into a numerical column.

ALTER TABLE telco_churn
ALTER COLUMN total_charges TYPE NUMERIC(10,2)
USING total_charges::NUMERIC;


/*==========================================================
  SECTION 5: VALIDATE THE CLEANED DATA
==========================================================*/


-- Check the minimum and maximum numerical values.

SELECT
    MIN(tenure) AS minimum_tenure,
    MAX(tenure) AS maximum_tenure,
    MIN(monthly_charges) AS minimum_monthly_charge,
    MAX(monthly_charges) AS maximum_monthly_charge,
    MIN(total_charges) AS minimum_total_charge,
    MAX(total_charges) AS maximum_total_charge
FROM telco_churn;


-- Check the valid values and customer counts in Churn.

SELECT
    churn,
    COUNT(*) AS customer_count
FROM telco_churn
GROUP BY churn
ORDER BY churn;


/*==========================================================
  SECTION 6: BUSINESS ANALYSIS
==========================================================*/


/*----------------------------------------------------------
  QUESTION 1:
  What is the overall customer churn rate?
----------------------------------------------------------*/

SELECT
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    COUNT(*) FILTER (
        WHERE churn = 'No'
    ) AS customers_retained,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn;


/*
Result:
Total customers: 7,043
Customers churned: 1,869
Customers retained: 5,174
Overall churn rate: 26.54%
*/


/*----------------------------------------------------------
  QUESTION 2:
  Which contract type has the highest churn rate?
----------------------------------------------------------*/

SELECT
    contract,
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY contract
ORDER BY churn_rate_percent DESC;


/*
Finding:
Month-to-month customers had the highest churn rate
at approximately 42.71%.
*/


/*----------------------------------------------------------
  QUESTION 3:
  Does customer tenure affect churn?
----------------------------------------------------------*/

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49-72 months'
    END AS tenure_group,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY tenure_group
ORDER BY tenure_group;


/*
Finding:
Customers within their first 12 months had the highest
tenure churn rate at approximately 47.44%.
*/


/*----------------------------------------------------------
  QUESTION 4:
  Which internet service has the highest churn rate?
----------------------------------------------------------*/

SELECT
    internet_service,
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY internet_service
ORDER BY churn_rate_percent DESC;


/*
Finding:
Fiber-optic customers had the highest churn rate
at approximately 41.89%.
*/


/*----------------------------------------------------------
  QUESTION 5:
  Which payment method has the highest churn rate?
----------------------------------------------------------*/

SELECT
    payment_method,
    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY payment_method
ORDER BY churn_rate_percent DESC;


/*
Finding:
Electronic-check customers had the highest churn rate
at approximately 45.29%.
*/


/*----------------------------------------------------------
  QUESTION 6:
  Do customers with higher monthly charges churn more?
----------------------------------------------------------*/

SELECT
    CASE
        WHEN monthly_charges < 50
            THEN 'Low: Under $50'

        WHEN monthly_charges < 80
            THEN 'Medium: $50-$79.99'

        ELSE 'High: $80 and above'
    END AS charge_band,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY charge_band
ORDER BY churn_rate_percent DESC;


/*
Finding:
Customers paying $80 or more per month had the highest
charge-band churn rate at approximately 33.99%.
*/


/*----------------------------------------------------------
  QUESTION 7:
  Do senior citizens have a higher churn rate?
----------------------------------------------------------*/

SELECT
    CASE
        WHEN senior_citizen = 1
            THEN 'Senior citizen'
        ELSE 'Not senior citizen'
    END AS customer_group,

    COUNT(*) AS total_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM telco_churn
GROUP BY senior_citizen
ORDER BY churn_rate_percent DESC;


/*
Finding:
Senior citizens had a churn rate of approximately 41.68%,
compared with 23.61% for non-senior customers.
*/


/*----------------------------------------------------------
  QUESTION 8:
  How much monthly revenue is associated with churned
  customers?
----------------------------------------------------------*/

SELECT
    ROUND(
        SUM(monthly_charges),
        2
    ) AS monthly_revenue_lost,

    ROUND(
        SUM(monthly_charges) * 12,
        2
    ) AS estimated_annual_revenue_lost

FROM telco_churn
WHERE churn = 'Yes';


/*
Important:
The annual value is an estimate based on multiplying
the churned customers' monthly charges by 12.
*/


/*----------------------------------------------------------
  QUESTION 9:
  What is the churn rate of the combined high-risk segment?
----------------------------------------------------------*/

SELECT
    COUNT(*) AS total_high_risk_customers,

    COUNT(*) FILTER (
        WHERE churn = 'Yes'
    ) AS high_risk_customers_churned,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE churn = 'Yes'
        ) / COUNT(*),
        2
    ) AS high_risk_churn_rate_percent

FROM telco_churn
WHERE contract = 'Month-to-month'
  AND internet_service = 'Fiber optic'
  AND payment_method = 'Electronic check';


/*
Result:
Total high-risk customers: 1,307
High-risk customers who churned: 789
High-risk churn rate: 60.37%

Finding:
Customers combining month-to-month contracts,
fiber-optic internet and electronic-check payments
formed a particularly high-risk segment.
*/


/*==========================================================
  SECTION 7: PROJECT CONCLUSION
==========================================================*/

/*
Major churn indicators identified:

1. Month-to-month contracts
2. Short customer tenure
3. Fiber-optic internet service
4. Electronic-check payments
5. High monthly charges
6. Senior-citizen status

Recommended actions:

1. Strengthen onboarding for new customers.
2. Encourage suitable customers to consider longer contracts.
3. Investigate fiber-optic pricing and service quality.
4. Promote convenient automatic payment options.
5. Provide additional assistance to senior customers.
6. Target the combined high-risk segment with retention offers.

These results show associations in the dataset.
They do not prove that any individual factor directly causes churn.
*/