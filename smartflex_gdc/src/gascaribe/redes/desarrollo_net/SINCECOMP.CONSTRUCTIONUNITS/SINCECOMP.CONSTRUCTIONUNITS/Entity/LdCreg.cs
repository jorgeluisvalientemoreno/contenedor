using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Util;

namespace SINCECOMP.CONSTRUCTIONUNITS.Entity
{
    class LdCreg
    {
        private Int64 year;
        private String descRelevantMarket;
        private String descConstructUnit;
        private Double amountExecuted;

        private Double amountBudget;
        private Double valueExecuted;
        private Double valueBudget;

        public Int64 Year
        {
            get { return year; }
            set { year = value; }
        }
        public String DescRelevantMarket
        {
            get { return descRelevantMarket; }
            set { descRelevantMarket = value; }
        }
        public String DescConstructUnit
        {
            get { return descConstructUnit; }
            set { descConstructUnit = value; }
        }
        public Double AmountExecuted
        {
            get { return amountExecuted; }
            set { amountExecuted = value; }
        }

        public Double AmountBudget
        {
            get { return amountBudget; }
            set { amountBudget = value; }
        }
        public Double ValueExecuted
        {
            get { return valueExecuted; }
            set { valueExecuted = value; }
        }
        public Double ValueBudget
        {
            get { return valueBudget; }
            set { valueBudget = value; }
        }

        public LdCreg(DataRow row)
        {

            Year = Convert.ToInt64(row["Year"]);
            DescRelevantMarket = Convert.ToString(row["Desc_Relevant_Market"]);
            DescConstructUnit = Convert.ToString(row["Desc_Construct_Unit"]);

            try
            {
                AmountBudget = OpenConvert.ToDouble(row["Amount_Budget"]);
            }
            catch { }
            try
            {
                ValueBudget = OpenConvert.ToDouble(row["Value_Budget"]);
            }
            catch { }
            try
            {
                AmountExecuted = OpenConvert.ToDouble(row["Amount_Executed"]);
            }
            catch { }
            try
            {
                ValueExecuted = OpenConvert.ToDouble(row["Value_Executed"]);
            }
            catch { }
        }
    }
}
