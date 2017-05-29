using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace CopyCVB
{
    class Program
    {
        public static SqlConnection cvb_conn;
        public static SqlConnection mdb_conn;
        const string csv_delim = ",";

        static void Main(string[] args)
        {
            Console.WriteLine("Starting CopyCVB Latest Versions.");

            string cvb_conn_str =
                "data source=g6i6eeeoqz.database.windows.net;" +
                "initial catalog=db_aaa0651b_2358_4854_b28f_614a67adaa8b;" +
                "persist security info=True;" +
                "user id=db_aaa0651b_2358_4854_b28f_614a67adaa8b_ExternalReader;" +
                "password=8zsZDlWzRv>Cobm;" +
                "MultipleActiveResultSets=True;";
            //+
            //"App=EntityFramework;" +
            //"providerName = System.Data.SqlClient";
            Console.WriteLine("Connecting to Access Web App SQL Server.");
            cvb_conn = new SqlConnection(cvb_conn_str);
            
            // note: the localdb instance needs to be manully started at a 
            // cmd prompt:  "sqllocaldb.exe start", then
            // "sqllocaldb.exe info"
            //string mdb_conn_str =
            //   @"data source=(localdb)\ProjectsV13;" +
            //   "initial catalog=meradia_db;" +
            //   "persist security info=True;" +
            //   "Integrated Security=true;" +
            //   "MultipleActiveResultSets=True;";

            // connection string for AZURE:
            string mdb_conn_str =
               @"data source=meradia-db.database.windows.net,1433;" +
               "initial catalog=meradia_db;" +
               "persist security info=False;" +
               "user id=db_admin; password=Tiller17!;" +
               "MultipleActiveResultSets=False;" +
               "TrustServerCertificate = False; Connection Timeout = 30";

            Console.WriteLine("Connecting to Azure SQL.");
            mdb_conn = new SqlConnection(mdb_conn_str);
            mdb_conn.Open();

            CopyTables();
        }

        static void BuildCsvFiles()
        {
            string qry = "SELECT [ObjectName] FROM [AccessSystem].[Objects] WHERE " +
                        "[ObjectTypeNumber]=100  AND  " +
                        "[Definition] not LIKE '<Query%' AND " +
                        "[Definition] not like '<DataMacro%' and " +
                        "[ObjectName] <> 'Trace' and " +
                        "[ObjectName] not like 'dummy%' and " +
                        "[ObjectName] not like 'i_%'";
            cvb_conn.Open();
            SqlCommand cmd = new SqlCommand(qry, cvb_conn);
            SqlDataReader tables = cmd.ExecuteReader();
            while (tables.Read())
            {
                Console.WriteLine("\t{0}", tables[0]);
                string qry2 = "select * from " + tables[0];
                SqlCommand cmd2 = new SqlCommand(qry2, cvb_conn);
                SqlDataReader rows = cmd2.ExecuteReader();
                int row_count = 0;
                StreamWriter csv = new StreamWriter(tables[0] + ".csv");
                while (rows.Read())
                {
                    row_count++;
                    if (row_count == 1)
                    { // write a header record
                        for (int i = 0; i < rows.FieldCount; ++i)
                        {
                            if (i > 0) csv.Write(csv_delim);
                            csv.Write(rows.GetName(i));
                        }
                        csv.Write("\r\n");
                    }
                    for (int i = 0; i < rows.FieldCount; ++i)
                    {
                        if (i > 0) csv.Write(csv_delim);
                        csv.Write(rows.GetValue(i).ToString());
                    }
                    csv.Write("\r\n");
                }
                rows.Close();
                csv.Close();
            }
            tables.Close();
            Console.WriteLine("Done.  Press <ENTER> to exit..");
            Console.ReadLine();
        }

        public static void SetIdentityInsert(string p_table, string p_setting)
        {
            string qry = String.Format("SET IDENTITY_INSERT {0} {1}", p_table, p_setting);
            SqlCommand cmd = new SqlCommand(qry, mdb_conn);
            int result = cmd.ExecuteNonQuery();
        }

        public static int GetRowCount(SqlConnection conn, string p_table)
        {
            string qry = String.Format("select count(*) from {0}", p_table);
            SqlCommand cmd = new SqlCommand(qry, conn);
            var result = cmd.ExecuteScalar();
            return (int)result;
        }

        static void CopyTables()
        {
            // query list of tables from cv-builder
            string qry = "SELECT [ObjectName] FROM [AccessSystem].[Objects] WHERE " +
                        "[ObjectTypeNumber]=100  AND  " +
                        "[Definition] not LIKE '<Query%' AND " +
                        "[Definition] not like '<DataMacro%' and " +
                        "[ObjectName] not in ('trace','tag','view_log','audit') and " +
                        "[ObjectName] not like 'dummy%' and " +
                        "[ObjectName] not like 'i_%' " +
                        "order by ObjectName";
            cvb_conn.Open();
            SqlCommand cmd = new SqlCommand(qry, cvb_conn);
            SqlDataReader tables = cmd.ExecuteReader();

            while (tables.Read())
            {
                Console.Write("{0}", tables[0]);
                string qry2 = "select * from " + tables[0];
                SqlCommand cmd2 = new SqlCommand(qry2, cvb_conn);
                SqlDataReader rows = cmd2.ExecuteReader();

                string table_nm = tables[0].ToString();
                SetIdentityInsert(table_nm, "ON");
                CopyTable(table_nm, rows);
                rows.Close();
                SetIdentityInsert(tables[0].ToString(), "OFF");

                Console.WriteLine("  source rows {0}, destination rows {1}", 
                    GetRowCount(cvb_conn,tables[0].ToString()), 
                    GetRowCount(mdb_conn,tables[0].ToString()));
            }
            tables.Close();
            Console.WriteLine("Done.  Press <ENTER> to exit..");
            Console.ReadLine();
        }

        static void CopyTable(string table_nm, SqlDataReader rows)
        {

            // build the SQL Insert statement
            StringBuilder sql = new StringBuilder();
            sql.AppendFormat("INSERT INTO {0} ({1}", table_nm, rows.GetName(0));
            for (int i = 1; i < rows.FieldCount; i++)  // subsequent col names
                sql.AppendFormat(",{0}", rows.GetName(i));

            sql.AppendFormat(") VALUES (@{0}", rows.GetName(0));
            for (int i = 1; i < rows.FieldCount; i++)
                sql.AppendFormat(",@{0}", rows.GetName(i));
            sql.Append(")");

            // create the SQL insert command and add parms
            SqlCommand ins = new SqlCommand(sql.ToString(), Program.mdb_conn);
            for (int i = 0; i < rows.FieldCount; i++)
            {
                string param_nm = "@" + rows.GetName(i);
                SqlDbType type = (SqlDbType)(int)rows.GetSchemaTable().Rows[i]["ProviderType"];
                ins.Parameters.Add(param_nm, type);
            }

            while (rows.Read())
            {
                for (int i = 0; i < rows.FieldCount; i++)
                    ins.Parameters[i].Value = rows.IsDBNull(i) ? DBNull.Value : ins.Parameters[i].Value = rows[i];
                ins.ExecuteNonQuery();
            }
        }

    }
}

