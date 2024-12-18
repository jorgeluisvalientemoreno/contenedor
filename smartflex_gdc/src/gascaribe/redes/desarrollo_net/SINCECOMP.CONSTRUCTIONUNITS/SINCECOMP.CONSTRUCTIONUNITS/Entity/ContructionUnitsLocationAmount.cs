using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ContructionUnitsLocationAmount
    {
        private Int64 geograpLocationId;
        private String descriptiongeograpLocation;
        private Double executed;
        private Double budget;
        private Double difference;
        private Double percentage;
        private Double executedUnitCost;
        private Double budgetUnitCost;


        [DisplayName("Código")]
        public Int64 GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }
        [DisplayName("Descripción")]
        public String DescriptiongeograpLocation
        {
            get { return descriptiongeograpLocation; }
            set { descriptiongeograpLocation = value; }
        }
        [DisplayName("Ejecutado")]
        public Double Executed
        {
            get { return executed; }
            set { executed = value; }
        }
        [DisplayName("Presupuestado")]
        public Double Budget
        {
            get { return budget; }
            set { budget = value; }
        }
        [DisplayName("Diferencia")]
        public Double Difference
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
        [DisplayName("Costo Unitario - Eje")]
        public Double ExecutedUnitCost
        {
            get { return executedUnitCost; }
            set { executedUnitCost = value; }
        }
        [DisplayName("Costo Unitario - Pre")]
        public Double BudgetUnitCost
        {
            get { return budgetUnitCost; }
            set { budgetUnitCost = value; }
        }

        public ContructionUnitsLocationAmount(DataRow row)
        {
            GeograpLocationId = Convert.ToInt64(row["GeograpLocationId"]);
            DescriptiongeograpLocation = Convert.ToString(row["DescriptionGeograpLocation"]);
            Executed = Convert.ToDouble(row["Executed"]);
            Budget = Convert.ToDouble(row["Budget"]);
            Difference = Convert.ToDouble(row["Difference"]);
            Percentage = Convert.ToDouble(row["Percentage"]);
            ExecutedUnitCost = Convert.ToDouble(row["ExecutedUnitCost"]);
            BudgetUnitCost = Convert.ToDouble(row["BudgetUnitCost"]);
        }

    }
}
