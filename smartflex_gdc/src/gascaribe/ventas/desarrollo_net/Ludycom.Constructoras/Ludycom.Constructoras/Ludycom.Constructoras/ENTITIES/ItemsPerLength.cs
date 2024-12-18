using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    public class ItemsPerLength : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        private Int64? projectId;

        [DisplayName("Id del Proyecto")]
        public Int64? Project
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64? quotationId;

        [DisplayName("Id Cotización")]
        public Int64? QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private /*Int64*/String itemId;

        [DisplayName("Id del Item")]
        public /*Int64*/String ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String itemDescription;

        [DisplayName("Descripción")]
        public String ItemDescription
        {
            get { return itemDescription; }
            set { itemDescription = value; }
        }

        private Double cost;

        [Browsable(true)]
        [DisplayName("Costo")]
        public Double Cost
        {
            get { return cost; }
            set { cost = value; }
        }

        private Double price;

        [Browsable(true)]
        [DisplayName("Precio")]
        public Double Price
        {
            get { return price; }
            set { price = value; }
        }

        private Boolean flute;

        [DisplayName("Flauta")]
        public Boolean Flute
        {
            get { return flute; }
            set { flute = value; }
        }

        private Boolean oven;

        [DisplayName("Horno")]
        public Boolean Oven
        {
            get { return oven; }
            set { oven = value; }
        }

        private Boolean bbq;

        [DisplayName("BBQ")]
        public Boolean BBQ
        {
            get { return bbq; }
            set { bbq = value; }
        }

        private Boolean stove;

        [DisplayName("Estufa")]
        public Boolean Stove
        {
            get { return stove; }
            set { stove = value; }
        }

        private Boolean dryer;

        [DisplayName("Secadora")]
        public Boolean Dryer
        {
            get { return dryer; }
            set { dryer = value; }
        }

        private Boolean heater;

        [DisplayName("Calentador")]
        public Boolean Heater
        {
            get { return heater; }
            set { heater = value; }
        }

        private Boolean longValBaj;

        [DisplayName("Longitud de Val a Bajante")]
        public Boolean LongValBaj
        {
            get { return longValBaj; }
            set { longValBaj = value; }
        }

        private Boolean longBajTabl;

        [DisplayName("Longitud de Bajante a Tablero")]
        public Boolean LongBajTabl
        {
            get { return longBajTabl; }
            set { longBajTabl = value; }
        }

        private Boolean longTab;

        [DisplayName("Longitud de Tablero")]
        public Boolean LongTab
        {
            get { return longTab; }
            set { longTab = value; }
        }

        private Boolean longBaj;

        [DisplayName("Longitud del Bajante")]
        public Boolean LongBaj
        {
            get { return longBaj; }
            set { longBaj = value;
                this.NotifyPropertyChanged("Make");
            }
        }

        private String itemType = "IM";

        public String ItemType
        {
            get { return itemType; }
            set { itemType = value; }
        }

        private String operation = "R";

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public ItemsPerLength()
        {

        }

        public ItemsPerLength(QuotationItem quotationItem)
        {
            this.QuotationId = quotationItem.QuotationId;
            this.Project = quotationItem.ProjectId;
            this.ItemId = quotationItem.ItemId;
            this.ItemDescription = quotationItem.ItemDescription;
            this.Cost = quotationItem.Cost;
            this.Price = quotationItem.Price;
            this.ItemType = "IM";
            this.Operation = quotationItem.Operation;
        }

        public ItemsPerLength(DataRow drItemPerLength)
        {
            Int64? nullValue = null;
            this.Project = Convert.ToInt64(drItemPerLength["ID_PROYECTO"]);
            this.QuotationId = string.IsNullOrEmpty(Convert.ToString(drItemPerLength["QUOTATION_ID"])) ? nullValue : Convert.ToInt64(drItemPerLength["QUOTATION_ID"]);
            //Caso 200-1640
            this.ItemId = Convert.ToString(drItemPerLength["ID_ITEM"]);
            this.ItemDescription = Convert.ToString(drItemPerLength["ITEM_DESC"]);
            this.Flute = (Convert.ToString(drItemPerLength["FLAUTA"]) == "S") ? true : false;
            this.Oven = (Convert.ToString(drItemPerLength["HORNO"]) == "S") ? true : false;
            this.BBQ = (Convert.ToString(drItemPerLength["BBQ"]) == "S") ? true : false;
            this.Stove = (Convert.ToString(drItemPerLength["ESTUFA"]) == "S") ? true : false;
            this.Dryer = (Convert.ToString(drItemPerLength["SECADORA"]) == "S") ? true : false;
            this.Heater = (Convert.ToString(drItemPerLength["CALENTADOR"]) == "S") ? true : false;
            this.LongValBaj = (Convert.ToString(drItemPerLength["LONG_VAL_BAJANTE"]) == "S") ? true : false;
            this.LongBajTabl = (Convert.ToString(drItemPerLength["LONG_BAJANTE_TABL"]) == "S") ? true : false;
            this.LongTab = (Convert.ToString(drItemPerLength["LONG_TABLERO"]) == "S") ? true : false;
            this.LongBaj = (Convert.ToString(drItemPerLength["LONG_BAJANTE"]) == "S") ? true : false;
            this.Operation = Convert.ToString(drItemPerLength["OPERACION"]);
            this.ItemType = Convert.ToString(drItemPerLength["TIPO_ITEM"]);
            this.Price = Convert.ToDouble(drItemPerLength["PRECIO"]);
            this.Cost = Convert.ToDouble(drItemPerLength["COSTO"]);
        }

        private void NotifyPropertyChanged(string name)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(name));
        }
    }
}
