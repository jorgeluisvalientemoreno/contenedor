using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConstUnitDetaExeVal
    {
        private Int64 geograpLocationId;
        private String descriptiongeograpLocation;
        private Int64 valueExecuted;
        private Int64 valueBudget;
        private Int64 differenceValue;
        private Int64 percentagExecute;
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
        public Int64 PercentagExecute
        {
            get { return percentagExecute; }
            set { percentagExecute = value; }
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
    }
}
