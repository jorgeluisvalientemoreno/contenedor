using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class concept
    {

        private Int64 codeId;

        [DisplayName("Código")]
        public Int64 CodeId
        {
            get { return codeId; }
            set { codeId = value; }
        }
        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }
        private Int64 distributingvalue;

        [DisplayName("Valor a Distribuir")]
        public Int64 Distributingvalue
        {
            get { return distributingvalue; }
            set { distributingvalue = value; }
        }

        public concept(DataRow row)
        {
            codeId = Convert.ToInt64(row["concepto"]);
            Description = row["descripcion"].ToString();
            //Distributingvalue = Convert.ToInt64(row[""]);
        }

    }
}
