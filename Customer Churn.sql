USE customer_churn; #using the Schema

# 1.Identify the total number of customers and the churn rate
SELECT COUNT(*) AS total_customers
FROM customer_churn;
	#Total number of customers is 4835
    
SELECT 
    COUNT(`Customer ID`) AS Churned_Customers,
    (COUNT(`Customer ID`) / (SELECT COUNT(`Customer ID`) FROM customer_churn)) * 100 AS Churn_Rate_Percentage
FROM customer_churn
WHERE `Customer Status` = 'Churned';
	# NO OF CHURNED CUSTOMER = 1586, CHURN RATE PERCENTAGE = 32.8025%
    
# 2.Find the average age of churned customers
SELECT AVG(Age) AS Average_Age_Of_Churned_Customers
FROM customer_churn
WHERE `Customer Status` = 'Churned';
	#AVERAGE AGE OF CHURNED CUSTOMER = 50.1658

# 3.Discover the most common contract types among churned customers
SELECT contract, COUNT(*) AS Number_Of_Churned_Customers
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY contract
ORDER BY Number_Of_Churned_Customers DESC
limit 1;
	#THE MOST COMMON CONTRACT TYPE AMONG CHURNED CUSTOMERS = Month-to-Month WITH 1403 CHURNED CUSTOMERS

#4.	Analyze the distribution of monthly charges among churned customers
SELECT 
    SUM(`monthly charge`) AS total_monthly_charges_churned,
    AVG(`monthly charge`) AS avg_monthly_charges_churned
FROM customer_churn
WHERE `Customer Status` = 'Churned';
         # THE DISTRIBUTION OF MONTHLY CHARGES AMONG EACH CHURNED CUSTOMERS = 81.10
         
#5.	Create a query to identify the contract types that are most prone to churn
SELECT 
    contract, 
    COUNT(*) AS churned_customers_count
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY contract
ORDER BY churned_customers_count DESC;
		# THE CONTRACT TYPE THAT ARE MOST PRONE TO CHURN IS MONTH-TO-MONTH CONTRACT TYPE
        
#6. Identify customers with high total charges who have churned
SELECT `Customer ID`, `total charges`
FROM customer_churn
WHERE `Customer Status` = 'Churned'
ORDER BY `total charges` DESC
LIMIT 10;

#7. Calculate the total charges distribution for churned and non-churned customers
SELECT 
    SUM(`total charges`) AS sum_total_charges_churned,
    AVG(`total charges`) AS avg_total_charges_churned
FROM customer_churn
WHERE `Customer Status` = 'Churned';
		#TOTAL CHARGES FOR CHURNED = 2726469, CHARGES FOR EACH = 1719.085
        
SELECT 
    SUM(`total charges`) AS sum_total_charges_stayed,
    AVG(`total charges`) AS avg_total_charges_stayed
FROM customer_churn
WHERE `Customer Status` != 'Churned';
		#TOTAL CHARGES FOR UNCHURNED = 11300430.84, CHARGES FOR EACH = 3478.12

#8.	Calculate the average monthly charges for different contract types among churned customers
SELECT 
    `contract`, 
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `contract`;
		# avg monthly charges for Month-to-Month = 79.44, One Year = 92.84 AND Two Year = 97.51
 
#9. Identify customers who have both online security and online backup services and have not churned 
SELECT `Customer ID`, `online security`, `online backup`
FROM customer_churn
WHERE `online security` = 'Yes'
  AND `online backup` = 'Yes'
  AND `Customer Status` != 'Churned';
  
SELECT *
FROM customer_churn
WHERE `online security` = 'Yes'
  AND `online backup` = 'Yes'
  AND `Customer Status` != 'Churned';

#10. Determine the most common combinations of services among churned customers
SELECT
    CONCAT_WS(', ', 
        CASE WHEN `online security` = 'Yes' THEN 'Online Security' ELSE NULL END,
        CASE WHEN `online backup` = 'Yes' THEN 'Online Backup' ELSE NULL END,
        CASE WHEN `device protection Plan` = 'Yes' THEN 'Device Protection plan' ELSE NULL END,
        CASE WHEN `Premium tech support` = 'Yes' THEN 'Premium Tech Support' ELSE NULL END,
        CASE WHEN `streaming tv` = 'Yes' THEN 'Streaming TV' ELSE NULL END,
        CASE WHEN `streaming movies` = 'Yes' THEN 'Streaming Movies' ELSE NULL END
    ) AS service_combination,
    COUNT(*) AS num_customers
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY service_combination
ORDER BY num_customers DESC;



#11. Identify the average total charges for customers grouped by gender and marital status
SELECT 
    `Gender`, 
    `Married`, 
    AVG(`total charges`) AS avg_total_charges
FROM customer_churn
GROUP BY `Gender`, `Married`;

#12. Calculate the average monthly charges for different age groups among churned customers
SELECT 
    CASE 
        WHEN `Age` < 20 THEN 'Under 20'
        WHEN `Age` BETWEEN 20 AND 29 THEN '20-29'
        WHEN `Age` BETWEEN 30 AND 39 THEN '30-39'
        WHEN `Age` BETWEEN 40 AND 49 THEN '40-49'
        WHEN `Age` BETWEEN 50 AND 59 THEN '50-59'
        WHEN `Age` >= 60 THEN '60 and above'
    END AS age_group,
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY age_group
ORDER BY age_group;

#13. Determine the average age and total charges for customers with multiple lines and online backup
SELECT 
    AVG(`Age`) AS avg_age,
    SUM(`total charges`) AS total_charges
FROM customer_churn
WHERE `Multiple Lines` = 'Yes' 
  AND `online backup` = 'Yes';
		#The average age and total charges for customers with multiple lines and online backup
        # Average age = 48.6115 And Total Charges = 6612503.850
        
#14. Identify the contract types with the highest churn rate among senior citizens (age 65 and over)
SELECT 
    `contract`,
    COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) AS churned_count,
    COUNT(*) AS total_count,
    (COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) / COUNT(*)) * 100 AS churn_rate
FROM customer_churn
WHERE `Age` >= 65
GROUP BY `contract`
ORDER BY churn_rate DESC;

#15. Calculate the average monthly charges for customers who have multiple lines and streaming TV
SELECT 
    AVG(`monthly charge`) AS avg_monthly_charges
FROM customer_churn
WHERE `Multiple Lines` = 'Yes' 
  AND `streaming tv` = 'Yes';
		#Average Monthly charges of customer who have multiple line and Streaming TV is 95.634
  
#16.  Identify the customers who have churned and used the most online services
SELECT 
    `Customer ID`,
    COUNT(CASE WHEN `online security` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `online backup` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `streaming tv` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `streaming movies` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `device protection plan` = 'Yes' THEN 1 END) +
    COUNT(CASE WHEN `premium tech support` = 'Yes' THEN 1 END) AS online_service_count
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Customer ID`
ORDER BY online_service_count DESC;

#17. Calculate the average age and total charges for customers with different combinations of streaming services
SELECT 
    CONCAT_WS(', ',
        CASE WHEN `streaming tv` = 'Yes' THEN 'Streaming TV' ELSE NULL END,
        CASE WHEN `streaming movies` = 'Yes' THEN 'Streaming Movies' ELSE NULL END
    ) AS streaming_service_combination,
    AVG(`Age`) AS avg_age,
    SUM(`total charges`) AS total_charges
FROM customer_churn
GROUP BY streaming_service_combination
ORDER BY streaming_service_combination;

#18.  Identify the gender distribution among customers who have churned and are on yearly contracts
SELECT 
    `Gender`, 
    COUNT(*) AS churned_count
FROM customer_churn
WHERE `Customer Status` = 'Churned' 
  AND `contract` != 'month-to-month' #because apart from 'month-to-month' other contract are in yearly
GROUP BY `Gender`;


#19. Calculate the average monthly charges and total charges for customers who have churned, grouped by contract type and internet service type
SELECT 
    `contract`, 
    `internet service`, 
    AVG(`monthly charge`) AS avg_monthly_charges, 
    SUM(`total charges`) AS total_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `contract`, `internet service`
ORDER BY `contract`, `internet service`;

#20.  Find the customers who have churned and are not using online services, and their average total charges
SELECT 
    COUNT(`Customer ID`) AS churned_customers_not_using_online_services,
    AVG(`total charges`) AS avg_total_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
  AND `Online security` = 'No'
  AND `Online backup` = 'No'
  AND `Device Protection Plan` = 'No'
  AND `Premium Tech Support` = 'No'
  AND `Streaming Tv` = 'No'
  AND `Streaming Movies` = 'No';
		#customers who have churned and are not using online services is 327 and their average total charges is 439.64

#21. Calculate the average monthly charges and total charges for customers who have churned, grouped by the number of dependents
SELECT 
    `Number of Dependents`, 
    AVG(`monthly charge`) AS avg_monthly_charges, 
    SUM(`total charges`) AS total_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Number of Dependents`
ORDER BY `Number of Dependents`;

#22. Identify the customers who have churned, and their contract duration in months (for monthly contracts)
SELECT 
    `Customer ID`, 
    `Tenure in Months`
FROM customer_churn
WHERE `Customer Status` = 'Churned'
  AND `contract` = 'Month-To-Month';

#23.  Determine the average age and total charges for customers who have churned, grouped by internet service and phone service
SELECT 
    `internet service`, 
    `phone service`, 
    AVG(`Age`) AS avg_age, 
    SUM(`total charges`) AS total_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `internet service`, `phone service`
ORDER BY `internet service`, `phone service`;
		# Average Age is 50 and Total Charges is 2726469

#24.  Create a view to find the customers with the highest monthly charges in each contract type
CREATE VIEW Highest_Monthly_Charges_Per_Contract AS
SELECT 
    `Customer ID`, 
    `contract`, 
    `monthly charge`
FROM customer_churn
WHERE (`contract`, `monthly charge`) IN (
    SELECT 
        `contract`, 
        MAX(`monthly charge`)
    FROM customer_churn
    GROUP BY `contract`
);

		#To view the Highest charge in each contract type
        SELECT * FROM Highest_Monthly_Charges_Per_Contract;

#25.  Create a view to identify customers who have churned and the average monthly charges compared to the overall average
CREATE VIEW Churned_Customers_Average_Comparison AS
SELECT 
    `Customer ID`, 
    `monthly charge`,
    AVG(`monthly charge`) OVER () AS overall_avg_monthly_charge,
    AVG(`monthly charge`) OVER (PARTITION BY `Customer Status`) AS churned_avg_monthly_charge
FROM customer_churn
WHERE `Customer Status` = 'Churned';

		#To view Churned Customers Average Comparison
        SELECT * FROM Churned_Customers_Average_Comparison;

#26. Create a view to find the customers who have churned and their cumulative total charges over time
CREATE VIEW Churned_Customers_Cumulative_Charges AS
SELECT 
    `Customer ID`, 
    `total charges`,
    SUM(`total charges`) OVER (PARTITION BY `Customer ID`) AS cumulative_total_charges
FROM customer_churn
WHERE `Customer Status` = 'Churned';

		#To Churned Customers Cumulative Charges
		SELECT * FROM Churned_Customers_Cumulative_Charges;
        
#27. Stored Procedure to Calculate Churn Rate
DELIMITER $$

CREATE PROCEDURE Calculate_Churn_Rate()
BEGIN
    DECLARE total_customers INT;
    DECLARE churned_customers INT;
    DECLARE churn_rate DECIMAL(5, 2);  -- Adjust precision as necessary

    -- Calculate the total number of customers
    SELECT COUNT(*) INTO total_customers FROM customer_churn;

    -- Calculate the total number of churned customers
    SELECT COUNT(*) INTO churned_customers FROM customer_churn WHERE `Customer Status` = 'Churned';

    -- Calculate the churn rate
    IF total_customers > 0 THEN
        SET churn_rate = (churned_customers / total_customers) * 100;  -- Churn rate in percentage
    ELSE
        SET churn_rate = 0;  -- To handle division by zero
    END IF;

    -- Return the churn rate
    SELECT churn_rate AS Churn_Rate;
END $$

DELIMITER ;

CALL Calculate_Churn_Rate();

#Customer Churn Rate is 32.80

#28.  Stored Procedure to Identify High-Value Customers at Risk of Churning.
DELIMITER //

CREATE PROCEDURE IdentifyHighValueCustomersAtRisk()
BEGIN
    DECLARE high_value_threshold DECIMAL(10, 2);
    DECLARE total_customers INT;
    DECLARE high_value_customers INT;
    DECLARE high_value_customers_at_risk INT;

    -- Define the threshold for high-value customers
    SET high_value_threshold = 1000; -- Adjust this threshold as needed

    -- Count total customers
    SELECT COUNT(*) INTO total_customers FROM customer_churn;

    -- Count high-value customers
    SELECT COUNT(*) INTO high_value_customers FROM customer_churn WHERE `total charges` > high_value_threshold;

    -- Count high-value customers at risk of churning
    SELECT COUNT(*) INTO high_value_customers_at_risk FROM customer_churn WHERE `total charges` > high_value_threshold AND `Customer status` = 'Churned';

    -- Output the results
    SELECT high_value_customers AS 'High_Value_Customers', high_value_customers_at_risk AS 'High_Value_Customers_at_Risk';
END//

DELIMITER ;

CALL IdentifyHighValueCustomersAtRisk();


