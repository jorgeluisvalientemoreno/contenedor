using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class GasServiceDetaExe
    {
        private Int64 geograpLocationId;
        private String descriptionGeograpLocationId;
        private Int64 executedAmount;
        private Int64 budgetAmount;
        private Int64 difference;
        private Int64 percentage;

        public Int64 GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }
        public String DescriptionGeograpLocationId
        {
            get { return descriptionGeograpLocationId; }
            set { descriptionGeograpLocationId = value; }
        }
        public Int64 ExecutedAmount
        {
            get { return executedAmount; }
            set { executedAmount = value; }
        }
        public Int64 BudgetAmount
        {
            get { return budgetAmount; }
            set { budgetAmount = value; }
        }
        public Int64 Difference
        {
            get { return difference; }
            set { difference = value; }
        }
        public Int64 Percentage
        {
            get { return percentage; }
            set { percentage = value; }
        }
    }
}
