-- Add a new NVARCHAR column
ALTER TABLE global_housing
ADD Country_new NVARCHAR(100);

-- Copy data from the old TEXT/NTEXT column
UPDATE global_housing
SET Country_new = CAST(Country AS NVARCHAR(100));

-- Drop the problematic column
ALTER TABLE global_housing
DROP COLUMN Country;

-- Rename the new column to 'Country'
EXEC sp_rename 'global_housing.Country_new', 'Country', 'COLUMN';

-- Determine Trend of Housing Prices by Country
SELECT Country, Year, house_price_index
FROM global_housing
ORDER BY Country, Year;

-- Calculating Average Affordability Ratio by Country
SELECT Country, ROUND(AVG(affordability_ratio), 2) AS avg_affordability
FROM global_housing
GROUP BY Country
ORDER BY avg_affordability DESC;

-- Create Grouped Trends

SELECT Year, AVG(gdp_growth) AS avg_gdp, AVG(house_price_index) AS avg_hpi
FROM global_housing
GROUP BY Year
ORDER BY Year;

-- Calculate US Monthly Trends

SELECT 
  FORMAT(Date, 'yyyy-MM') AS YearMonth,
  AVG(house_price_index) AS avg_price
FROM us_housing
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY YearMonth;

-- Determine Top 5 Years with Highest GDP & Price Growth

SELECT TOP 5 Date, gdp, house_price_index
FROM us_housing
ORDER BY gdp DESC;


