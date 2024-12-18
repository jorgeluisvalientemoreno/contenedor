using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConUniLocDetExeVal
    {
        private Int64 constructUnitID;
        private String descriptionConstructUnitID;
        private Int64 valueExecuted;
        private Int64 valueBudget;
        private Int64 differenceValue;
        private Int64 percentagExecute;
        private Int64 executedUnitCost;
        private Int64 budgetUnitCost;

        public Int64 ConstructUnitID
        {
            get { return constructUnitID; }
            set { constructUnitID = value; }
        }
        public String DescriptionConstructUnitID
        {
            get { return descriptionConstructUnitID; }
            set { descriptionConstructUnitID = value; }
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
