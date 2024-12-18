using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class cartaspotenciales
    {

        /*
        private Int64 temp_clob_fact_id;
        public Int64 Temp_clob_fact_id
        {
            get { return temp_clob_fact_id; }
            set { temp_clob_fact_id = value; }
        }

        private String template_id;
        public String Template_id
        {
            get { return template_id; }
            set { template_id = value; }
        }
        */

        private String docudocu;
        public String Docudocu
        {
            get { return docudocu; }
            set { docudocu = value; }
        }

        /*
        private Int64 sesion;
        public Int64 Sesion
        {
            get { return sesion; }
            set { sesion = value; }
        }
        private Int64 package_id;
        public Int64 Package_id
        {
            get { return package_id; }
            set { package_id = value; }
        }
        */

        public cartaspotenciales(DataRow row)
        {
            //Temp_clob_fact_id = Convert.ToInt64(row["temp_clob_fact_id"]);
            //Template_id = row["template_id"].ToString();
            Docudocu = row["docudocu"].ToString();
            //Sesion = Convert.ToInt64(row["sesion"]);
            //Package_id = Convert.ToInt64(row["package_id"]);
        }         

    }
}
