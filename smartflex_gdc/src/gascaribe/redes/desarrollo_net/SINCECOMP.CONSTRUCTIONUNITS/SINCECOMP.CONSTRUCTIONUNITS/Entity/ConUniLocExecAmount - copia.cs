using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConUniLocExecAmount
    {
        private Int64 geograpLocationId;
        private String descriptiongeograpLocation;
        private Int64 amountExecuted; 
        private Int64 amountBudget;
        private Int64 differenceAmount;
        private Int64 percentageAmount;
        private Int64 executedUnitCost;
        private Int64 budgetUnitCost;

        public Int64 GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }
        public String DescriptiongeograpLocation
        {
            get { return descriptiongeograpLocation; }
            set { descriptiongeograpLocation = value; }
        }
        public Int64 AmountExecuted
        {
            get { return amountExecuted; }
            set { amountExecuted = value; }
        }
        public Int64 AmountBudget
        {
            get { return amountBudget; }
            set { amountBudget = value; }
        }
        public Int64 DifferenceAmount
        {
            get { return differenceAmount; }
            set { differenceAmount = value; }
        }
        public Int64 PercentageAmount
        {
            get { return percentageAmount; }
            set { percentageAmount = value; }
        }
        public Int64 ExecutedUnitCost
        {
            get { return executedUnitCost; }
            set { executedUnitCost = value; }
        }
        public Int64 BudgetUnitCost
        {
            get { return budgetUnitCost; }
            set { budgetUnitCost = value; }
        }

        public ConUniLocExecAmount(DataRow row)
        {
            GeograpLocationId = Convert.ToInt64(row["GeograpLocationId"]);
            DescriptiongeograpLocation = Convert.ToString(row["DescriptionGeograpLocationId"]);
            AmountExecuted = Convert.ToInt64(row["AmountExecuted"]);
            AmountBudget = Convert.ToInt64(row["AmountBudget"]);
            DifferenceAmount = Convert.ToInt64(row["DifferenceAmount"]);
            PercentageAmount = Convert.ToInt64(row["PercentageAmount"]);
            ExecutedUnitCost = Convert.ToInt64(row["ExecutedUnitCost"]);
            BudgetUnitCost = Convert.ToInt64(row["BudgetUnitCost"]);
        }

    }
}
