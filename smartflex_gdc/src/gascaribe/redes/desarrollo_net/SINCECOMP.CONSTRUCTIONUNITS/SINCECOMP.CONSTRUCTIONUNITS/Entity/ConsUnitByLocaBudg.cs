using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConsUnitByLocaBudg
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

        private String execUnitCost;

        [DisplayName("Costo Unitario - Eje")]

        public String ExecUnitCost
        {
            get { return execUnitCost; }
            set { execUnitCost = value; }
        }

        private String budgUnitCost;

        [DisplayName("Costo Unitario - Pre")]

        public String BudgUnitCost
        {
            get { return budgUnitCost; }
            set { budgUnitCost = value; }
        }
    }
}
