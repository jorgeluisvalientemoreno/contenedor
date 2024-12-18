using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class PropUnitEquivalence
    {
        private Boolean selected;

        [DisplayName(" ")]
        public Boolean Selected
        {
            get { return selected; }
            set { selected = value; }
        }

        private Int64 address;

        [DisplayName("Id Dirección")]
        public Int64 Address
        {
            get { return address; }
            set { address = value; }
        }

        private String adressParsed;

        [DisplayName("Dirección")]
        public String AdressParsed
        {
            get { return adressParsed; }
            set { adressParsed = value; }
        }

        private Int64 product;

        [Browsable(true)]
        [DisplayName("Producto")]
        public Int64 Product
        {
            get { return product; }
            set { product = value; }
        }

        private Int64 propUnitId;

        [Browsable(true)]
        [DisplayName("Unidad Predial")]
        public Int64 PropUnitId
        {
            get { return propUnitId; }
            set { propUnitId = value; }
        }

        public PropUnitEquivalence()
        {
        }

        public PropUnitEquivalence(DataRow drPropUnitEquivalences)
        {
            this.Selected = false;
            this.Address = Convert.ToInt64(drPropUnitEquivalences["ADDRESS_ID"]);
            this.AdressParsed = Convert.ToString(drPropUnitEquivalences["ADDRESS_PARSED"]);
            this.Product = Convert.ToInt64(drPropUnitEquivalences["PRODUCT_ID"]);
        }

    }
}
