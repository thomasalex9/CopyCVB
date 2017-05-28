using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace CopyCVB
{
    class MeradiaDbInserts
    {

        public static void CopyTable(string table_nm, SqlDataReader rows)
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

        public static void app_domain(SqlDataReader rows)
        {
            string query = "INSERT INTO app_domain (id,app_domain_nm)" +
                " VALUES (@id,@app_domain_nm)";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@app_domain_nm", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "app_domain_nm");
                ins.ExecuteNonQuery();
            }
        }

        public static void app_vendor(SqlDataReader rows)
        {
            string query = "INSERT INTO app_vendor (id,app_vendor_nm)" +
                " VALUES (@id,@app_vendor_nm)";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@app_vendor_nm", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "app_vendor_nm");
                ins.ExecuteNonQuery();
            }
        }

        public static void application(SqlDataReader rows)
        {
            string query = "INSERT INTO application ( " +
                "   id,application_nm,application_descr, " +
                "   app_vendor_id, app_domain_id, formal_nm )" +
                " VALUES ( " +
                "   @id, @application_nm, @application_descr, " +
                "   @app_vendor_id, @app_domain_id, @formal_nm ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@application_nm", SqlDbType.VarChar);
            ins.Parameters.Add("@application_descr", SqlDbType.VarChar);
            ins.Parameters.Add("@app_vendor_id", SqlDbType.Int);
            ins.Parameters.Add("@app_domain_id", SqlDbType.Int);
            ins.Parameters.Add("@formal_nm", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "application_nm");
                Program.ParamSet<string>(ins.Parameters, rows, "application_descr");
                Program.ParamSet<int>(ins.Parameters, rows, "app_vendor_id");
                Program.ParamSet<int>(ins.Parameters, rows, "app_domain_id");
                Program.ParamSet<string>(ins.Parameters, rows, "formal_nm");
                ins.ExecuteNonQuery();
            }
        }

        public static void company(SqlDataReader rows)
        {
            string query = "INSERT INTO company ( " +
                "   id,company_nm,company_location,is_client,company_descr," +
                "   company_short_nm )" +
                " VALUES ( " +
                "   @id,@company_nm,@company_location,@is_client,@company_descr," +
                "   @company_short_nm ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@company_nm", SqlDbType.VarChar);
            ins.Parameters.Add("@company_location", SqlDbType.VarChar);
            ins.Parameters.Add("@is_client", SqlDbType.Bit);
            ins.Parameters.Add("@company_descr", SqlDbType.VarChar);
            ins.Parameters.Add("@company_short_nm", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "company_nm");
                Program.ParamSet<string>(ins.Parameters, rows, "company_location");
                ins.Parameters["@is_client"].Value = Convert.ToInt32(rows["is_client"]);
                Program.ParamSet<string>(ins.Parameters, rows, "company_descr");
                Program.ParamSet<string>(ins.Parameters, rows, "company_short_nm");
                ins.ExecuteNonQuery();
            }
        }

        public static void consultant(SqlDataReader rows)
        {
            string query = "INSERT INTO consultant ( " +
                "   id,consultant_nm,title_id,consultant_initials,start_dt,end_dt,image_url," +
                "   is_admin,is_manager,email_address,noteworthy_intro,birth_dt,vacation_available )" +
                " VALUES ( " +
                "   @id,@consultant_nm,@title_id,@consultant_initials,@start_dt,@end_dt,@image_url," +
                "   @is_admin,@is_manager,@email_address,@noteworthy_intro,@birth_dt,@vacation_available ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@consultant_nm", SqlDbType.VarChar);
            ins.Parameters.Add("@title_id", SqlDbType.Int);
            ins.Parameters.Add("@consultant_initials", SqlDbType.VarChar);
            ins.Parameters.Add("@start_dt", SqlDbType.DateTime);
            ins.Parameters.Add("@end_dt", SqlDbType.DateTime);
            ins.Parameters.Add("@image_url", SqlDbType.VarChar);
            ins.Parameters.Add("@is_admin", SqlDbType.Int);
            ins.Parameters.Add("@is_manager", SqlDbType.Bit);
            ins.Parameters.Add("@email_address", SqlDbType.VarChar);
            ins.Parameters.Add("@noteworthy_intro", SqlDbType.VarChar);
            ins.Parameters.Add("@birth_dt", SqlDbType.DateTime);
            ins.Parameters.Add("@vacation_available", SqlDbType.Decimal);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "consultant_nm");
                Program.ParamSet<int>(ins.Parameters, rows, "title_id");
                Program.ParamSet<string>(ins.Parameters, rows, "consultant_initials");
                Program.ParamSet<DateTime>(ins.Parameters, rows, "start_dt");
                Program.ParamSet<DateTime>(ins.Parameters, rows, "end_dt");
                Program.ParamSet<string>(ins.Parameters, rows, "image_url");
                ins.Parameters["@is_admin"].Value = Convert.ToInt32(rows["is_admin"]);
                ins.Parameters["@is_manager"].Value = Convert.ToInt32(rows["is_manager"]);
                Program.ParamSet<string>(ins.Parameters, rows, "email_address");
                Program.ParamSet<string>(ins.Parameters, rows, "noteworthy_intro");
                Program.ParamSet<DateTime>(ins.Parameters, rows, "birth_dt");
                Program.ParamSet<decimal>(ins.Parameters, rows, "vacation_available");
                ins.ExecuteNonQuery();
            }
        }

        public static void consultant_application(SqlDataReader rows)
        {
            string query = "INSERT INTO consultant_application ( " +
                "   id,consultant_id,application_id,order_nbr," +
                "   suppressed,proficiency_id,suppressed_RIC )" +
                " VALUES ( " +
                "   @id,@consultant_id,@application_id,@order_nbr," +
                "   @suppressed,@proficiency_id,@suppressed_RIC ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@consultant_id", SqlDbType.Int);
            ins.Parameters.Add("@application_id", SqlDbType.Int);
            ins.Parameters.Add("@order_nbr", SqlDbType.Int);
            ins.Parameters.Add("@suppressed", SqlDbType.Bit);
            ins.Parameters.Add("@proficiency_id", SqlDbType.Int);
            ins.Parameters.Add("@suppressed_RIC", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<int>(ins.Parameters, rows, "consultant_id");
                Program.ParamSet<int>(ins.Parameters, rows, "application_id");
                Program.ParamSet<int>(ins.Parameters, rows, "order_nbr");
                ins.Parameters["@suppressed"].Value = Convert.ToInt32(rows["suppressed"]);
                Program.ParamSet<int>(ins.Parameters, rows, "proficiency_id");
                Program.ParamSet<string>(ins.Parameters, rows, "suppressed_RIC");
                ins.ExecuteNonQuery();
            }
        }

        public static void timeslip(SqlDataReader rows)
        {
            string query = "INSERT INTO timeslip ( " +
                "   id,consultant_id,sow_id,slip_start_dt,slip_end_dt,slip_phase_nm," +
                "   slip_location,slip_desc,slip_status,slip_time,slip_task_nm,slip_bill_status )" +
                " VALUES ( " +
                "   @id,@consultant_id,@sow_id,@slip_start_dt,@slip_end_dt,@slip_phase_nm," +
                "   @slip_location,@slip_desc,@slip_status,@slip_time,@slip_task_nm,@slip_bill_status ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@consultant_id", SqlDbType.Int);
            ins.Parameters.Add("@sow_id", SqlDbType.Int);
            ins.Parameters.Add("@slip_start_dt", SqlDbType.DateTime);
            ins.Parameters.Add("@slip_end_dt", SqlDbType.DateTime);
            ins.Parameters.Add("@slip_phase_nm", SqlDbType.Int);
            ins.Parameters.Add("@slip_location", SqlDbType.VarChar);
            ins.Parameters.Add("@slip_desc", SqlDbType.VarChar);
            ins.Parameters.Add("@slip_status", SqlDbType.VarChar);
            ins.Parameters.Add("@slip_time", SqlDbType.Decimal);
            ins.Parameters.Add("@slip_task_nm", SqlDbType.VarChar);
            ins.Parameters.Add("@slip_bill_status", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<int>(ins.Parameters, rows, "consultant_id");
                Program.ParamSet<int>(ins.Parameters, rows, "sow_id");
                Program.ParamSet<DateTime>(ins.Parameters, rows, "slip_start_dt");
                Program.ParamSet<DateTime>(ins.Parameters, rows, "slip_end_dt");
                Program.ParamSet<int>(ins.Parameters, rows, "slip_phase_nm");
                Program.ParamSet<string>(ins.Parameters, rows, "slip_location");
                Program.ParamSet<string>(ins.Parameters, rows, "slip_desc");
                Program.ParamSet<string>(ins.Parameters, rows, "slip_status");
                Program.ParamSet<decimal>(ins.Parameters, rows, "slip_time");
                Program.ParamSet<string>(ins.Parameters, rows, "slip_task_nm");
                Program.ParamSet<string>(ins.Parameters, rows, "slip_bill_status");
                ins.ExecuteNonQuery();
            }
        }

        public static void title(SqlDataReader rows)
        {
            string query = "INSERT INTO title ( id,title_nm,title_descr )" +
                " VALUES ( @id,@title_nm,@title_descr ) ";

            SqlCommand ins = new SqlCommand(query, Program.mdb_conn);
            ins.Parameters.Add("@id", SqlDbType.Int);
            ins.Parameters.Add("@title_nm", SqlDbType.VarChar);
            ins.Parameters.Add("@title_descr", SqlDbType.VarChar);

            while (rows.Read())
            {
                Program.ParamSet<int>(ins.Parameters, rows, "id");
                Program.ParamSet<string>(ins.Parameters, rows, "title_nm");
                Program.ParamSet<string>(ins.Parameters, rows, "title_descr");
                ins.ExecuteNonQuery();
            }
        }

        public static Type GetClrType(SqlDbType sqlType)
        {
            switch (sqlType)
            {
                case SqlDbType.BigInt:
                    return typeof(long?);

                case SqlDbType.Binary:
                case SqlDbType.Image:
                case SqlDbType.Timestamp:
                case SqlDbType.VarBinary:
                    return typeof(byte[]);

                case SqlDbType.Bit:
                    return typeof(bool?);

                case SqlDbType.Char:
                case SqlDbType.NChar:
                case SqlDbType.NText:
                case SqlDbType.NVarChar:
                case SqlDbType.Text:
                case SqlDbType.VarChar:
                case SqlDbType.Xml:
                    return typeof(string);

                case SqlDbType.DateTime:
                case SqlDbType.SmallDateTime:
                case SqlDbType.Date:
                case SqlDbType.Time:
                case SqlDbType.DateTime2:
                    return typeof(DateTime?);

                case SqlDbType.Decimal:
                case SqlDbType.Money:
                case SqlDbType.SmallMoney:
                    return typeof(decimal?);

                case SqlDbType.Float:
                    return typeof(double?);

                case SqlDbType.Int:
                    return typeof(int?);

                case SqlDbType.Real:
                    return typeof(float?);

                case SqlDbType.UniqueIdentifier:
                    return typeof(Guid?);

                case SqlDbType.SmallInt:
                    return typeof(short?);

                case SqlDbType.TinyInt:
                    return typeof(byte?);

                case SqlDbType.Variant:
                case SqlDbType.Udt:
                    return typeof(object);

                case SqlDbType.Structured:
                    return typeof(DataTable);

                case SqlDbType.DateTimeOffset:
                    return typeof(DateTimeOffset?);

                default:
                    throw new ArgumentOutOfRangeException("sqlType");
            }
        }
    }
}
        