using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConUniLocExecValue
    {

        private Int64 geograpLocationId;
        private String descriptiongeograpLocation;
        private Int64 valueExecuted;
        private Int64 valueBudget;
        private Int64 differenceValue;
        private Int64 percentageExecute;
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
        public Int64 ValueExecuted
        {
            get { return valueExecuted; }
            set { valueExecuted = value; }
        }
        public Int64 ValueBudget
        {
            get { return valueBudget; }
            set { valueBudget = value; }
        }
        public Int64 DifferenceValue
        {
            get { return differenceValue; }
            set { differenceValue = value; }
        }
        public Int64 PercentageExecute
        {
            get { return percentageExecute; }
            set { percentageExecute = value; }
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

        public ConUniLocExecValue(DataRow row)
        {
            GeograpLocationId = Convert.ToInt64(row["GeograpLocationId"]);
            DescriptiongeograpLocation = Convert.ToString(row["DescriptionGeograpLocationId"]);
            ValueExecuted = Convert.ToInt64(row["ValueExecuted"]);
            ValueBudget = Convert.ToInt64(row["ValueBudget"]);
            DifferenceValue = Convert.ToInt64(row["DifferenceValue"]);
            PercentageExecute = Convert.ToInt64(row["PercentageExecute"]);
            ExecutedUnitCost = Convert.ToInt64(row["ExecutedUnitCost"]);
            BudgetUnitCost = Convert.ToInt64(row["BudgetUnitCost"]);
        }

    }
}
