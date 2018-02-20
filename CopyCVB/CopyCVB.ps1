# Copy-Db
#
# Copies the Access Web App SQL Db tables to Azure SQL
#
# 2/18/2018 TEA: Original

Set-StrictMode -Version Latest

Import-Module SqlServer 

function Main {
    Log(-Join("Starting CopyCVB..."))
    # Connect to Access (source) and Meradia-1 (target)
    InitializeSql 
    CopyTables
    FinalizeSql
    Log ("Done")
}

function Log($msg) {
    Write-Output ("{0} {1}" -f (Get-Date -Format "hh:mm:ss"), $msg)
}

function InitializeSql {
   
    Log ("Connecting to CVBuilder SQL database...")
    $cvb_conn_str = @"
        data source=ghid4mi5ig.database.windows.net;
        initial catalog=db_aaa0651b_2358_4854_b28f_614a67adaa8b;
        persist security info=True;
        user id=db_aaa0651b_2358_4854_b28f_614a67adaa8b_ExternalReader;
        password=671EmZd-9Ywoz5z;
        MultipleActiveResultSets=True;
"@    
    $script:cvb_conn = new-object system.data.SqlClient.SQLConnection($cvb_conn_str)
    $cvb_conn.Open()
    Log ("Connected")

    Log ("Connecting to Meradia Azure SQL database...")
    $script:mdb_conn_str = @"
        data source=meradia1-db.database.windows.net,1433;
        initial catalog=meradia_db;
        persist security info=False;
        user id=db_admin; password=Tiller17!;
        MultipleActiveResultSets=False;
        TrustServerCertificate = False; Connection Timeout = 30
"@    
    $script:mdb_conn = new-object system.data.SqlClient.SQLConnection($mdb_conn_str)
    $mdb_conn.Open()
    Log ("Connected")

    # Initialize Meradia-1 DB
    Log ("Initializing Meradia DB")
    Invoke-Sqlcmd -ConnectionString $mdb_conn_str -InputFile "Meradia_Db_Initialize.sql" | 
        Out-File -FilePath ("{0}\{1}" -f $pwd, "Meradia_Db_Initialize.out") 
}

function FinalizeSql {

    $cvb_conn.Close()
    $mdb_conn.Close()

    # Finalize Meradia-1 DB
    Log("Running Finalize.SQL script...")
    Invoke-Sqlcmd -ConnectionString $mdb_conn_str -InputFile "Meradia_Db_Finalize.sql" | 
        Out-File -FilePath ("{0}\{1}" -f $pwd, "Meradia_Db_Finalize.out") 
}

function CopyTables {
    $qry = @"
        SELECT ObjectName FROM AccessSystem.Objects 
         WHERE ObjectTypeNumber=100  AND  
               Definition not LIKE '<Query%' AND 
               Definition not like '<DataMacro%' and 
               ObjectName not in ('trace','tag','view_log') and 
               ObjectName not in ('timeslip_role','timeslip_task') and 
               ObjectName not in ('experience','experience_detail') and  
               ObjectName not in ('thought_leadership','company_info') and 
               ObjectName not like 'dummy%' and 
               ObjectName not like 'i_%' 
         order by ObjectName
"@

    $cmd = New-Object System.Data.SqlClient.SqlCommand($qry, $cvb_conn) 
    $dr = $cmd.ExecuteReader()

    # Process each table
    While ($dr.Read()) {
        $table = $dr.GetValue(0)
        Log(("table {0}" -f $table))
        $qry2 = "select * from " + $table
        $cmd2 = New-Object System.Data.SqlClient.SqlCommand($qry2, $cvb_conn)
        $rows = $cmd2.ExecuteReader()
        SetIdentityInsert "ON"
        CopyTable 
        SetIdentityInsert "OFF"
        Log ("  source rows {0}, destination rows {1}" -f 
            (GetRowCount $cvb_conn $table), (GetRowCount $mdb_conn $table))
    }
}

function GetRowCount ($conn, $table) {
    $sql = "select count(*) from {0}" -f $table
    $cmd = New-Object System.Data.SqlClient.SqlCommand($sql, $conn)
    try {
        $row_count = $cmd.ExecuteScalar() 
    } catch [Exception] {
      	Log("SQL Error")
       	echo $_.Exception.GetType().FullName, $_.Exception.Message
       	Exit
    }
    return $row_count
}

function SetIdentityInsert($setting) {
    $sql = "SET IDENTITY_INSERT {0} {1}" -f $table, $setting
    $cmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdb_conn)
    try {
        $cmd.ExecuteNonQuery() > $null
    } catch [Exception] {
      	Log("SQL Error")
       	echo $_.Exception.GetType().FullName, $_.Exception.Message
       	Exit
    }
}

function CopyTable {

    # build the SQL INSERT statement: 
    $sql = "INSERT INTO {0} ({1}" -f $table, $rows.GetName(0)
    for ($i = 1; $i -le ($rows.FieldCount - 1); $i++) {
        $sql += ",{0}" -f $rows.GetName($i)
    }
    $sql += ") VALUES (@{0}" -f $rows.GetName(0)
    for ($i = 1; $i -le ($rows.FieldCount - 1); $i++) {
        $sql += ",@{0}" -f $rows.GetName($i)
    }
    $sql += ")"

    # create the ADO.NET command from the SQL INSERT command and add parms
    $cmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdb_conn)
    for ($i = 0; $i -le ($rows.FieldCount - 1); $i++) {
        $param_nm = "@" + $rows.GetName($i)
        $param_type = $rows.GetProviderSpecificFieldType($i)
        $cmd.Parameters.Add($param_nm, $param_type) > $null
    }

    while ($rows.Read()) {
        for ($i = 0; $i -le ($rows.FieldCount - 1); $i++) {
            $cmd.Parameters[$i].Value = $rows.GetValue($i)
        }
        try {
           	$cmd.ExecuteNonQuery() > $null
        } catch [Exception] {
           	Log("SQL Insert Error")
           	echo $_.Exception.GetType().FullName, $_.Exception.Message
           	Exit
        }
    }
}

# run the script
. Main
exit
