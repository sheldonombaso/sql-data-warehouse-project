/*
  ===============================================================================
Stored Procure:Load Bronze Layer (Source - > Bronze)
===================================================================================
Scrpit Purpose: 
              This loads data into bronze schema from external csv
              IT: Truncates dronze data before loading data
                  Uses BULK insert to load all data
===================================================================================              
*/

--EXEC bronze.load_bronze

USE Datawarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
     DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY

PRINT'====================================================================================================';
PRINT 'Loading The Bronze Layer';
PRINT'====================================================================================================';

PRINT '--------------------------------------------------------------------------------------------------';
PRINT'Loading CRM Tables';
PRINT '--------------------------------------------------------------------------------------------------';


        SET @start_time = GETDATE();
PRINT '>> Truncating the Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;

-- (FULL LOAD) Here we first make the table empty then load data....
--So every time you run this code it refresh data in the table with new data

--USE DataWarehouse;
--GO

BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>> -------------------------------: '

--SELECT * FROM bronze.crm_cust_info
--The above sql is for displaying rows

--SELECT COUNT (*)FROM bronze.crm_cust_info

----------------------------------------------------------------------------------------------------
SET @start_time = GETDATE();

PRINT '>> Truncating the Table: bronze.crm_prd_info';

TRUNCATE TABLE bronze.crm_prd_info;
-- (FULL LOAD) Here we first make the table empty then load data....
--So every time you run this code it refresh data in the table with new data

--USE DataWarehouse;
--GO

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--SELECT * FROM bronze.crm_prd_info
--SELECT COUNT (*)FROM bronze.crm_prd_info

        SET @end_time = GETDATE();
        PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
        PRINT '>> -------------------------------: '

---------------------------------------------------------------------------------------------------------------
SET @start_time = GETDATE();

PRINT '>> Truncating the Table: bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details;


BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--SELECT * FROM bronze.crm_sales_details
--SELECT COUNT (*)FROM bronze.crm_sales_details

SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
PRINT '>> -------------------------------: '

----------------------------------------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------';
PRINT'Loading ERP Tables';
PRINT '--------------------------------------------------------------------------------------------------';
----------------------------------------------------------------------------------------------------------------------------------------

SET @start_time = GETDATE();

PRINT '>> Truncating the Table: bronze.erp_cust_az12';

TRUNCATE TABLE bronze.erp_cust_az12;
--  erp_cust_az12
--C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--SELECT * FROM bronze.erp_cust_az12
--SELECT COUNT (*)FROM bronze.erp_cust_az12

SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
PRINT '>> -------------------------------: '

-----------------------------------------------------------------------------------------------------------------------------------

SET @start_time = GETDATE();

PRINT '>> Truncating the Table: bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101;
--  erp_loc_a101
--C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

--SELECT * FROM bronze.erp_loc_a101
--SELECT COUNT (*)FROM bronze.erp_loc_a101
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
PRINT '>> -------------------------------: '

-------------------------------------------------------------------------------------------------------------------------------------------

SET @start_time = GETDATE();

PRINT '>> Truncating the Table: bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
--   erp_px_cat_g1v2
--C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\SHELDON\Desktop\Dataware House\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


--SELECT * FROM bronze.erp_px_cat_g1v2
--SELECT COUNT (*)FROM bronze.erp_px_cat_g1v2
SET @end_time = GETDATE();
PRINT '>>Load Duration: ' + CAST(DATEDIFF (second, @start_time,@end_time) AS NVARCHAR) + 'seconds';
PRINT '>> -------------------------------: '

    END TRY
    BEGIN CATCH
        PRINT '======================================================================================'
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE ();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '======================================================================================'

    END CATCH


END
