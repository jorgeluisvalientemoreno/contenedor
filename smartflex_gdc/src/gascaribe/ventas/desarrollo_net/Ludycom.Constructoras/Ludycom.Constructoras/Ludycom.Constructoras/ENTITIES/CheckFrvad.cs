using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class CheckFrvad
    {
        private Int64 concepto;

        [DisplayName("Concepto")]
        public Int64 Concepto
        {
            get { return concepto; }
            set { concepto = value; }
        }

        private Double costo_adicional;

        [Browsable(true)]
        [DisplayName("Costo Adicional")]
        public Double Costo_adicional
        {
            get { return costo_adicional; }
            set { costo_adicional = value; }
        }

        private Double valor_adicional;

        [Browsable(true)]
        [DisplayName("Valor Adicional")]
        public Double Valor_adicional
        {
            get { return valor_adicional; }
            set { valor_adicional = value; }
        }

        private Double subtotal;

        [Browsable(true)]
        [DisplayName("Subtotal")]
        public Double Subtotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }

        private Double iva;

        [Browsable(true)]
        [DisplayName("IVA")]
        public Double Iva
        {
            get { return iva; }
            set { iva = value; }
        }

        private Double total;

        [Browsable(true)]
        [DisplayName("Total")]
        public Double Total
        {
            get { return total; }
            set { total = value; }
        }



        public CheckFrvad(DataRow drCheck)
        {
            Int64? nullValue = null;
            this.Concepto = Convert.ToInt64(drCheck["CONCEPTO"]);
            this.Costo_adicional = Convert.ToInt64(drCheck["COSTO_ADICIONAL"]);
            this.Valor_adicional = Convert.ToInt64(drCheck["VALOR_ADICIONAL"]);
            this.Subtotal = Convert.ToInt64(drCheck["SUBTOTAL"]);
            this.Iva = Convert.ToInt64(drCheck["IVA"]);
            this.Total = Convert.ToInt64(drCheck["TOTAL"]);


        }
    }
}
