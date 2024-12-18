using System;
using System.Collections.Generic;
using System.Text;
//using System.Data;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.CANCELLATION.Entities
{
    class GridDetailTwoFNBIR
    {
        private Boolean selection;

        [DisplayName(" ")]
        public Boolean Selection
        {
            get { return selection; }
            set { selection = value; }
        }

        private String article;

        [DisplayName("artículo")]
        public String Article
        {
            get { return article; }
            set { article = value; }
        }

        private String address;

        [DisplayName("Dirección")]
        public String Address
        {
            get { return address; }
            set { address = value; }
        }

        private Int64 deliver;

        [DisplayName("Entregado")]
        public Int64 Deliver
        {
            get { return deliver; }
            set { deliver = value; }
        }

        private Int64 recib;

        [DisplayName("Recibido")]
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

        private Decimal iva;

        [DisplayName("IVA")]
        public Decimal Iva
        {
            get { return iva; }
            set { iva = value; }
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

        public GridDetailTwoFNBIR(DataRow row)
        {
            Article=Convert.ToString(row["article_id"]);
            Deliver=Convert.ToInt64(row["amount"]);
            UniqueValue=Convert.ToDecimal(row["valuetotal"]);
            Iva = Convert.ToDecimal(row["iva"]);
            Value = Convert.ToDecimal(Deliver) * (UniqueValue + Iva); //Se agrega valor IVA - KCienfuegos.NC3858 27-11-2014
            activity = Convert.ToInt64(row["ORDER_ACTIVITY_ID"]);
        }
    }
}
