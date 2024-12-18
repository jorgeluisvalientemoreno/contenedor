using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class ConstructionUnitExe
    {
        private Int64 constructUnitID;
        private String descriptionConstructUnitID;
        private Int64 amountBudget;
        private Int64 valueBudget;
        private Int64 amountExecuted;
        private Int64 valueExecuted;
        private Int64 differenceAmount;
        private Int64 percentageAmount;
        private Int64 differenceValue;
        private Int64 percentageValue;

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
        public Int64 AmountBudget
        {
            get { return amountBudget; }
            set { amountBudget = value; }
        }
        public Int64 ValueBudget
        {
            get { return valueBudget; }
            set { valueBudget = value; }
        }
        public Int64 AmountExecuted
        {
            get { return amountExecuted; }
            set { amountExecuted = value; }
        }
        public Int64 ValueExecuted
        {
            get { return valueExecuted; }
            set { valueExecuted = value; }
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
        public Int64 DifferenceValue
        {
            get { return differenceValue; }
            set { differenceValue = value; }
        }
        public Int64 PercentageValue
        {
            get { return percentageValue; }
            set { percentageValue = value; }
        }


    }
}
