# CopyCVB

https://github.com/thomasalex9/CopyCVB

CopyCVB is a repeatable method to port the legacy Access DB to AZURE SQL Server.  Here are the steps.

1. Connect to the target AZURE Sql Server.

2. Run Meradia_DB_Initialize.SQL.  This drops and recreates all tables.  When it completes, the target database has empty tables and NO CONSTRAINTS.

3. Run the CopyCVB console app in Visual Studia.


3. After running the Initialize.SQL script, run the CopyCVB console app to actually copy the 
records.   This app will disable/re-enable identity columns as needed.

3. Meradia_Db_Modify.SQL changes the new Schema to eliminate unused columns, and 
maybe introduce new ones.  Use this sparingly.

4. Meradia_Db_Finalize.SQL restores foreign key constraints.

Other Notes:

1. Meradia_Db_Original.SQL was generated from Enity Framework Designer pointing to the legacy 
MS Access Web App SQL Db under SharePoint.  This was used to create the new Azure SQL DB ("Meradia_Db").
This creates foreign keys and primary keys.

