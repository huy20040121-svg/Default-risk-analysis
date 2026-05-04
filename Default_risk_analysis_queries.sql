Select *
FROM [Credit_risk]

--Q1: WHAT IS THE OVERALL DEFAULT RATE ?
SELECT	
	COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND (CAST(SUM(loan_status) as float) / COUNT(*) *100, 2) AS Default_percentage
FROM	
    [Credit_risk];

--Q2: WHAT IS THE DEFAULT RATE BY LOAN INTENT?
SELECT	
    loan_intent,
	COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND (CAST(SUM(loan_status) as float) / COUNT(*) *100, 2) AS Default_percentage
FROM	
    [Credit_risk]
GROUP BY   
   loan_intent
ORDER BY
   loan_intent;

--Q3: IS THERE ANY RELATIONSHIP BETWEEN DEBT-TO-INCOME(DTI) RATIO AND THE LIKELIHOOD OF DEFAULTING?
WITH DTIdata AS (
    SELECT 
        loan_status,
        CASE 
            WHEN debt_to_income_ratio < 0.2 THEN '0-19%'
            WHEN debt_to_income_ratio BETWEEN 0.2 AND 0.29 THEN '20-29%'
            WHEN debt_to_income_ratio BETWEEN 0.3 AND 0.39 THEN '30-39%'
            WHEN debt_to_income_ratio BETWEEN 0.4 AND 0.49 THEN '40-49%'
            ELSE '50%+'
        END AS dti_rate
    FROM [Credit_risk]
)
SELECT 
    dti_rate,
    COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND(CAST(SUM(loan_status) AS FLOAT) / COUNT(*) * 100, 2) AS Default_percentage
FROM DTIdata
GROUP BY dti_rate
ORDER BY Default_percentage DESC;

--Q4: DOES THE AVERAGE LOAN AMOUNT DIFFER SIGNIFICANTLY BETWEEN DEFAULTED AND NON-DEFAULTED LOAN ?
SELECT
    loan_status,
    COUNT(*) AS Total_loans,
    ROUND(AVG(loan_amnt), 0) AS Average_loan_amount,
    MIN(loan_amnt) AS min_loan,
    MAX(loan_amnt) AS max_loan
FROM
    [Credit_risk]
GROUP BY
    loan_status;

--Q5: HOW DO EMPLOYMENT TYPE AFFECT DEFAULT RISK?
SELECT	
    employment_type,
	COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND (CAST(SUM(loan_status) as float) / COUNT(*) *100, 2) AS Default_percentage
FROM	
    [Credit_risk]
GROUP BY   
   employment_type
ORDER BY
   employment_type DESC;

--Q6: HOW DO YEARS EMPLOYED AFFECT DEFAULT RISK?
WITH TenureData AS (
    SELECT 
        loan_status,
        CASE 
            WHEN person_emp_length < 2 THEN '<2 years'
            WHEN person_emp_length BETWEEN 2 AND 5 THEN '2-5 years'
            WHEN person_emp_length BETWEEN 6 AND 10 THEN '6-10 years'
            ELSE '10 years +'
        END AS emp_tenure
    FROM [Credit_risk]
)
SELECT 
    emp_tenure,
    COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND(CAST(SUM(loan_status) AS FLOAT) / COUNT(*) * 100, 2) AS Default_percentage
FROM TenureData
GROUP BY emp_tenure
ORDER BY Default_percentage DESC;

--Q7: ARE BORROWERS WITH LESS THAN 2 YEARS OF EMPLOYMENT MORE LIKELY TO DEFAULT?
WITH TenureData AS (
    SELECT 
        loan_status,
        CASE 
            WHEN person_emp_length < 2 THEN '<2 years'
            ELSE '2+ years '
        END AS emp_tenure
    FROM [Credit_risk]
)
SELECT 
    emp_tenure,
    COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND(CAST(SUM(loan_status) AS FLOAT) / COUNT(*) * 100, 2) AS Default_percentage
FROM TenureData
GROUP BY emp_tenure
ORDER BY Default_percentage DESC;

--Q8: HOW DOES LOAN GRADE AFFECT DEFAULT RISK?
SELECT	
    loan_grade,
	COUNT(*) AS Total_loans,
    SUM(loan_status) AS Default_count,
    ROUND (CAST(SUM(loan_status) as float) / COUNT(*) *100, 2) AS Default_percentage
FROM	
    Credit_risk
GROUP BY   
   loan_grade
ORDER BY
   loan_grade DESC;