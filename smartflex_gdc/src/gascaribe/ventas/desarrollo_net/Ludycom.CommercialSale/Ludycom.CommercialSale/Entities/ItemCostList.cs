using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.CommercialSale.Entities
{
    public class ItemCostList
    {
        private Int64 itemId;

        [Browsable(true)]
        [DisplayName("Id Item")]
        public Int64 ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String itemDescription;

        [Browsable(true)]
        [DisplayName("Nombre Item")]
        public String ItemDescription
        {
            get { return itemDescription; }
            set { itemDescription = value; }
        }

        private Decimal costSale;

        [Browsable(true)]
        [DisplayName("Costo de Venta")]
        public Decimal CostSale
        {
            get { return costSale; }
            set { costSale = value; }
        }

        private Int64 listId;

        [Browsable(true)]
        [DisplayName("Id Lista")]
        public Int64 ListId
        {
            get { return listId; }
            set { listId = value; }
        }

        private String listDescription;

        [Browsable(true)]
        [DisplayName("Nombre Lista Costos")]
        public String ListDescription
        {
            get { return listDescription; }
            set { listDescription = value; }
        }

        private String uniqueItemId;

        [Browsable(true)]
        public String UniqueItemId
        {
            get { return uniqueItemId; }
            set { uniqueItemId = value; }
        }

        public const String ITEM_ID_KEY = "ITEMID";

        public const String ITEM_DESCRIPTION_KEY = "ITEMDESCRIPTION";

        public const String COST_SALE_KEY = "COSTSALE";

        public const String LIST_ID_KEY = "LISTID";

        public const String LIST_DESCRIPTION_KEY = "LISTDESCRIPTION";

        public const String UNIQUE_ITEM_KEY = "UNIQUEITEMID";

        public ItemCostList(DataRow drItemCostList)
        {
            this.ItemId = Convert.ToInt64(drItemCostList["ID_ITEM"]);
            this.ItemDescription = Convert.ToString(drItemCostList["NOMBRE_ITEM"]);
            this.CostSale = Convert.ToDecimal(drItemCostList["COSTO_VENTA"]);
            this.ListId = Convert.ToInt64(drItemCostList["ID_LISTA"]);
            this.ListDescription = Convert.ToString(drItemCostList["NOMBRE_LISTA"]);
            this.UniqueItemId = this.ItemId + "_" + this.ListId;
        }

    }
}
