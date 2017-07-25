# CopyCVB
First push.

CopyCVB is a repeatable method to port the legacy Access DB to AZURE SQL Server

1. Meradia_Db_Original.SQL was generated from Enity Framework Designer pointing to the legacy 
MS Access Web App SQL Db under SharePoint.  This was used to create the new Azure SQL DB ("Meradia_Db").
This creates foreign keys and primary keys.

2. Meradia_Db_Initialize.SQL deletes the foreign keys so that the CopyCVB program 
doesn't generate errors as it copies raw rows from legacy db to the new db.

3. After running the Initialize.SQL script, run the CopyCVB console app to actually copy the 
records.   This app will disable/re-enable identity columns as needed.

3. Meradia_Db_Modify.SQL changes the new Schema to eliminate unused columns, and 
maybe introduce new ones.  Use this sparingly.

4. Meradia_Db_Finalize.SQL restores foreign key constraints.
