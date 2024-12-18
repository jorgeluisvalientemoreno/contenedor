using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class totalesActa
    {
        private Int64 subsidy_id;

        [DisplayName("Subsidio")]
        public Int64 Subsidy_id
        {
            get { return subsidy_id; }
            set { subsidy_id = value; }
        }

        private Int64 subsidy_Value;

        [DisplayName("Total Subsidiado")]
        public Int64 Subsidy_Value
        {
            get { return subsidy_Value; }
            set { subsidy_Value = value; }
        }

        public totalesActa(DataRow row)
        {
            if (Convert.IsDBNull(row["Subsidy_id"]) != true)
                Subsidy_id = Convert.ToInt64(row["Subsidy_id"]);
            else
                Subsidy_id = 0;
            if (Convert.IsDBNull(row["Subsidy_Value"]) != true)
                Subsidy_Value = Convert.ToInt64(row["Subsidy_Value"]);
            else
                Subsidy_Value=0;
        }
    }
}
