-----------------------
---CREATE VIEW CALENDAR
-----------------------
CREATE VIEW gold.calendar
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Calendar/',
    FORMAT='PARQUET'
) AS QUER1
GO

-----------------------
---CREATE VIEW CUSTOMERS
-----------------------
CREATE VIEW gold.customers
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Customers/',
    FORMAT='PARQUET'
) AS QUER2
GO

-----------------------
---CREATE VIEW PRODUCT CATEGORIES
-----------------------
CREATE VIEW gold.product_categories
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Product_Categories/',
    FORMAT='PARQUET'
) AS QUER3
GO

-----------------------
---CREATE VIEW PRODUCTS
-----------------------
CREATE VIEW gold.products
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Products/',
    FORMAT='PARQUET'
) AS QUER4
GO

-----------------------
---CREATE VIEW RETURNS
-----------------------
CREATE VIEW gold.returns
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Returns/',
    FORMAT='PARQUET'
) AS QUER5
GO

-----------------------
---CREATE VIEW SALES
-----------------------
CREATE VIEW gold.sales
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Sales*/',
    FORMAT='PARQUET'
) AS QUER6
GO

-----------------------
---CREATE VIEW TERRITORIES
-----------------------
CREATE VIEW gold.territories
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/AdventureWorks_Territories/',
    FORMAT='PARQUET'
) AS QUER7
GO

-----------------------
---CREATE VIEW PRODUCT SUBCATEGORIES
-----------------------
CREATE VIEW gold.product_subcategories
AS
SELECT * FROM OPENROWSET(
    BULK 'https://awstoragedatalakeapamo.dfs.core.windows.net/silver-aw/Product_Subcategories/',
    FORMAT='PARQUET'
) AS QUER8
GO

---------------------------
--------CREATE EXTERNAL TABLE= EXTSALES
---------------------------------------

CREATE EXTERNAL TABLE gold.extsales
WITH
(
    LOCATION='extsales',
    DATA_SOURCE= source_gold_project,
    FILE_FORMAT= format_parquet
)
AS
SELECT* FROM gold.sales

SELECT * FROM gold.extsales