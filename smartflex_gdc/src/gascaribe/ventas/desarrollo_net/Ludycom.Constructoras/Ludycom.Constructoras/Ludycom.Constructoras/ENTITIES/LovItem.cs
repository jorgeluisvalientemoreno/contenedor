using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace Ludycom.Constructoras.ENTITIES
{
    public class LovItem
    {
        //Caso 200-1640
        private /*Int64*/String itemId;

        [Browsable(true)]
        [DisplayName("Id")]
        public /*Int64*/String ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String itemDescription;

        [Browsable(true)]
        [DisplayName("Descripción")]
        public String ItemDescription
        {
            get { return itemDescription; }
            set { itemDescription = value; }
        }

        private QuotationItem quotationItem;

        [Browsable(false)]
        public QuotationItem QuotationItem
        {
            get { return quotationItem; }
            set { quotationItem = value; }
        }

        //Caso 200-1640
        public LovItem(/*Int64*/String itemId, String itemDescription)
        {
            this.itemId = itemId;
            this.itemDescription = itemDescription;
        }

        public LovItem(/*Int64*/String itemId, String itemDescription, QuotationItem quotationItem)
        {
            this.itemId = itemId;
            this.itemDescription = itemDescription;
            this.quotationItem = quotationItem;
        }

    }
}
