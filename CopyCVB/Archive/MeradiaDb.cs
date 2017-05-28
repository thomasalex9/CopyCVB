using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace CopyCVB
{
    class MeradiaDb
    {
        public static void InsertConsultants(SqlDataReader rows)
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

        public static void InsertTitles(SqlDataReader rows)
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

        public static void InsertAppDomains(SqlDataReader rows)
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

        public static void InsertAppVendors(SqlDataReader rows)
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
    }
}