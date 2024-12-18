using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class ArticleOrderLDOA
    {
        private Int64 article;

        [DisplayName("Artículo")]
        public Int64 Article
        {
            get { return article; }
            set { article = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private Double lastPrice;

        [DisplayName("Precio Anterior")]
        public Double LastPrice
        {
            get { return lastPrice; }
            set { lastPrice = value; }
        }

        private Double actualPrice;

        [DisplayName("Precio Actual")]
        public Double ActualPrice
        {
            get { return actualPrice; }
            set { actualPrice = value; }
        }

        private DateTime? asignDate;

        [DisplayName("Fecha Asignación")]
        public DateTime? AsignDate
        {
            get { return asignDate.HasValue ? asignDate : null; }
            set { asignDate = value; }
        }

        public ArticleOrderLDOA(DataRow row)
        {
            article = Convert.ToInt64(row["article_id"]);
            description = row["description"].ToString();
            actualPrice = Convert.ToDouble(row["precioAct"]);
            lastPrice = Convert.ToDouble(row["precioAnt"]);
            asignDate = Convert.IsDBNull(row["assigned_date"]) ? (DateTime?)null : Convert.ToDateTime(row["assigned_date"]);
        }
    }
}
