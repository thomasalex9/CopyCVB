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
            cvb_conn = new SqlConnection(cvb_conn_str);
            //BuildCsvFiles();
            //CopyTables();
            
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

            mdb_conn = new SqlConnection(mdb_conn_str);
            mdb_conn.Open();

            CopyTablesADO();

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

        static void CopyTablesADO()
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
                MeradiaDbInserts.CopyTable(table_nm, rows);

                //switch (tables[0].ToString())
                //{   
                //    case "app_domain":
                //        MeradiaDbInserts.app_domain(rows);
                //        break;
                //    case "app_vendor":
                //        MeradiaDbInserts.app_vendor(rows);
                //        break;
                //    case "application":
                //        MeradiaDbInserts.application(rows);
                //        break;
                //    case "company":
                //        MeradiaDbInserts.company(rows);
                //        break;
                //    case "consultant":
                //        MeradiaDbInserts.consultant(rows);
                //        break;                   
                //    case "consultant_application":
                //        MeradiaDbInserts.consultant_application(rows);
                //        break;
                //    case "timeslip":
                //        MeradiaDbInserts.timeslip(rows);
                //        break;
                //    case "title":
                //        MeradiaDbInserts.title(rows);
                //        break;
                //}
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

        public static void ParamSet<T>(SqlParameterCollection p_param, SqlDataReader p_reader, string p_col_name)
        {
            string param_name = ("@" + p_col_name);

            if (p_reader.IsDBNull(p_reader.GetOrdinal(p_col_name)))
                p_param[param_name].Value = DBNull.Value;
            else
                p_param[param_name].Value = (T) p_reader[p_col_name];
        }
    }
}

