using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class GasDemandService
    {
        private Int64 cateCodi;
        private String catedesc;
        private Int64 sucaCodi;
        private String sucadesc;
        private Int64 executedAmount;
        private Int64 budgetAmount;
        private Int64 difference;
        private Double percentage;

        [DisplayName("Código")]
        public Int64 CateCodi
        {
            get { return cateCodi; }
            set { cateCodi = value; }
        }
        [DisplayName("Categoría")]
        public String Catedesc
        {
            get { return catedesc; }
            set { catedesc = value; }
        }
        [DisplayName("Código")]
        public Int64 SucaCodi
        {
            get { return sucaCodi; }
            set { sucaCodi = value; }
        }
        [DisplayName("Subcategoría")]
        public String Sucadesc
        {
            get { return sucadesc; }
            set { sucadesc = value; }
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

        public GasDemandService(DataRow row)
        {
            CateCodi = Convert.ToInt64(row["cateCodi"]);
            Catedesc = Convert.ToString(row["catedesc"]);
            SucaCodi = Convert.ToInt64(row["sucaCodi"]);
            Sucadesc = Convert.ToString(row["sucadesc"]);
            ExecutedAmount = Convert.ToInt64(row["executedAmount"]);
            BudgetAmount = Convert.ToInt64(row["budgetAmount"]);
            Difference = Convert.ToInt64(row["difference"]);
            Percentage = Convert.ToDouble(row["percentage"]);
        }

    }
}
