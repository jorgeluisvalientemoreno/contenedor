using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.Entities
{
    class unit
    {
        private String code;

        [DisplayName("Codigo")]
        public String Code
        {
            get { return code; }
            set { code = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private String execute;

        [DisplayName("Ejecutado")]
        public String Execute
        {
            get { return execute; }
            set { execute = value; }
        }

        private String budgeted;

        [DisplayName("Presupuestado")]
        public String Budgeted
        {
            get { return budgeted; }
            set { budgeted = value; }
        }

        private String difference;

        [DisplayName("Diferencia")]
        public String Difference
        {
            get { return difference; }
            set { difference = value; }
        }

        private String executepercent;

        [DisplayName("% Ejecución")]
        public String Executepercent
        {
            get { return executepercent; }
            set { executepercent = value; }
        }

        private String unitcosteje;

        [DisplayName("Costo Unita - Eje")]
        public String Unitcosteje
        {
            get { return unitcosteje; }
            set { unitcosteje = value; }
        }

        private String unitcostpre;

        [DisplayName("Costo Unita - Pre")]
        public String Unitcostpre
        {
            get { return unitcostpre; }
            set { unitcostpre = value; }
        }

    }
}
