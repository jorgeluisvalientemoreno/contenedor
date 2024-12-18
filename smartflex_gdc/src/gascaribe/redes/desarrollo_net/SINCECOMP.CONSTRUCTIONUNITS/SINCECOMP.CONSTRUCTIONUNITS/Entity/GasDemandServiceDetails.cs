using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class GasDemandServiceDetails
    {
        private Int64 geograpLocationId;
        private String descriptionGeograpLocation;
        private Int64 executedAmount;
        private Int64 budgetAmount;
        private Int64 difference;
        private Double percentage;

        [DisplayName("Código")]
        public Int64 GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }
        [DisplayName("Descripción")]
        public String DescriptionGeograpLocation
        {
            get { return descriptionGeograpLocation; }
            set { descriptionGeograpLocation = value; }
        }
        [DisplayName("Ejecutado")]
        public Int64 ExecutedAmount
        {
            get { return executedAmount; }
            set { executedAmount = value; }
        }
        [DisplayName("Presupuestado")]
        public Int64 BudgetAmount
        {
            get { return budgetAmount; }
            set { budgetAmount = value; }
        }
        [DisplayName("Diferencia")]
        public Int64 Difference
        {
            get { return difference; }
            set { difference = value; }
        }
        [DisplayName("%Variación")]//[DisplayName("Porcentaje")]
        public Double Percentage
        {
            get { return percentage; }
            set { percentage = value; }
        }

        public GasDemandServiceDetails(DataRow row)
        {
            GeograpLocationId = Convert.ToInt64(row["GeograpLocationId"]);
            DescriptionGeograpLocation = Convert.ToString(row["DescriptionGeograpLocation"]);
            ExecutedAmount = Convert.ToInt64(row["ExecutedAmount"]);
            BudgetAmount = Convert.ToInt64(row["BudgetAmount"]);
            Difference = Convert.ToInt64(row["Difference"]);
            Percentage = Convert.ToDouble(row["Percentage"]);
        }    
    }
}
