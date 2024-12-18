using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class CheckConcept
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

        public CheckConcept()
        {
            this.concepto = 0;
            this.costo_adicional = 0;
            this.valor_adicional = 0;
            this.subtotal = 0;
            this.iva = 0;
            this.total = 0;
        }


        public CheckConcept(Int64 concepto, Double costo_adicional, Double valor_adicional, Double subtotal, Double iva, Double total)
        {
            this.concepto = concepto;
            this.costo_adicional = costo_adicional;
            this.valor_adicional = valor_adicional;
            this.subtotal = subtotal;
            this.iva = iva;
            this.total = total;
        }

        public CheckConcept(DataRow drCheck)
        {
            //Int64? nullValue = null;
            this.concepto = Convert.ToInt64(drCheck["CONCEPTO"]);
            this.costo_adicional = Convert.ToDouble(drCheck["COSTO_ADICIONAL"]);
            this.valor_adicional = Convert.ToDouble(drCheck["VALOR_ADICIONAL"]);
            this.subtotal = Convert.ToDouble(drCheck["SUBTOTAL"]);
            this.iva = Convert.ToDouble(drCheck["IVA"]);
            this.total = Convert.ToDouble(drCheck["TOTAL"]);


        }
    }
}
