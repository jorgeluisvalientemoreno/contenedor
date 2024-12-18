using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class MarketingDistributionExpenses
    {
        Int64 executed;
        Int64 budget;
        Int64 difference;
        Int64 percentage;

        [DisplayName("Ejecutado")]
        public Int64 Executed
        {
            get { return executed; }
            set { executed = value; }
        }
        [DisplayName("Presupuestado")]
        public Int64 Budget
        {
            get { return budget; }
            set { budget = value; }
        }
        [DisplayName("Diferencia")]
        public Int64 Difference
        {
            get { return difference; }
            set { difference = value; }
        }
        [DisplayName("%Variación")]//[DisplayName("Procentaje")]
        public Int64 Percentage
        {
            get { return percentage; }
            set { percentage = value; }
        }

        public MarketingDistributionExpenses(DataRow row)
        {
            Executed = Convert.ToInt64(row["Executed"]);
            Budget = Convert.ToInt64(row["Budget"]);
            Difference = Convert.ToInt64(row["Difference"]);
            Percentage = Convert.ToInt64(row["Percentage"]);
        }

    }
}
