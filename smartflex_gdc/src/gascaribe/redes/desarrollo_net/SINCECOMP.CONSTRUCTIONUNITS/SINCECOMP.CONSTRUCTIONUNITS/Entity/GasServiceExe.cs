using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class GasServiceExe
    {
        private Int64 cateCodi;
        private String catedesc;
        private Int64 sucaCodi;
        private String sucadesc;
        private Int64 executedAmount;
        private Int64 budgetAmount;
        private Int64 difference;
        private Int64 percentage;

        public Int64 CateCodi
        {
            get { return cateCodi; }
            set { cateCodi = value; }
        }
        public String Catedesc
        {
            get { return catedesc; }
            set { catedesc = value; }
        }
        public Int64 SucaCodi
        {
            get { return sucaCodi; }
            set { sucaCodi = value; }
        }
        public String Sucadesc
        {
            get { return sucadesc; }
            set { sucadesc = value; }
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
