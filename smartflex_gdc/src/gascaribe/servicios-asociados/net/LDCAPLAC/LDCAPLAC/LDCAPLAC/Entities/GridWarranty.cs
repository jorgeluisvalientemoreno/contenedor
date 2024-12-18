using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace LDCAPLAC.Entities
{
    public class GridWarranty
    {

        
        private String item;

        [Browsable(true)]
        [DisplayName("Item")]
        public String Item
        {
            get { return item; }
            set { item = value; }
        }

        private Int64 product;

        [Browsable(true)]
        [DisplayName("Producto")]
        public Int64 Product
        {
            get { return product; }
            set { product = value; }
        }

        private String limit;

        [Browsable(true)]
        [DisplayName("Valido Hasta")]
        public String Limit
        {
            get { return limit; }
            set { limit = value; }
        }

        private String active;

        [Browsable(true)]
        [DisplayName("Activo")]
        public String Active
        {
            get { return active; }
            set { active = value; }
        }


        public GridWarranty()
        {

        }

        public const String DESCRIPTION_KEY = "DESCRIPTION";

        public GridWarranty(GridWarranty warranty)
        {
            this.item = warranty.item;
            this.product = warranty.product;
            this.limit = warranty.limit;
            this.active = warranty.active;
        }

        public GridWarranty(DataRow drQuotationItem)
        {
            this.item = Convert.ToString(drQuotationItem["item"]);
            this.product = Convert.ToInt64(drQuotationItem["producto"]);
            this.limit = Convert.ToString(drQuotationItem["valido_hasta"]);
            this.active = Convert.ToString(drQuotationItem["activo"]);
        }
    }
}
