using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class ResgisterFNBCR
    {
        /*
        private Boolean selection;

        [DisplayName(" ")]
        public Boolean Selection
        {
            get { return selection; }
            set { selection = value; }
        }
        */
        private String article;

        [DisplayName("artículo")]
        public String Article
        {
            get { return article; }
            set { article = value; }
        }



        private Int64 deliver;
        [DisplayName("Cant. Articulos")] //Entregado
        public Int64 Deliver
        {
            get { return deliver; }
            set { deliver = value; }
        }

        private Int64 recib;

        [DisplayName("Cant. Artic. a Anular/Devolver")]
        public Int64 Recib
        {
            get { return recib; }
            set { recib = value; }
        }

        private Decimal uniqueValue;

        [DisplayName("Valor Unitario")]
        public Decimal UniqueValue
        {
            get { return uniqueValue; }
            set { uniqueValue = value; }
        }

        private Decimal value;

        [DisplayName("Valor")]
        public Decimal Value
        {
            get { return this.value; }
            set { this.value = value; }
        }

        private Int64 activity;

        [Browsable(false)]
        public Int64 Activity
        {
            get { return activity; }
            set { activity = value; }
        } 

        public ResgisterFNBCR(DataRow row)
        {
            Article=Convert.ToString(row["articulo"]);
            Deliver = Convert.ToInt64(row["cantidad"]);
            UniqueValue = Convert.ToDecimal(row["valuetotal"]);
            Value = Convert.ToDecimal(Deliver) * UniqueValue;
            activity = Convert.ToInt64(row["order_activity"]);
        }
    }
}
