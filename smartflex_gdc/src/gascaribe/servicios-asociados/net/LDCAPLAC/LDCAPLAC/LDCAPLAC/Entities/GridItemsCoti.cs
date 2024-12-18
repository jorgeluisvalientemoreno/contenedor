using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using LDCAPLAC.UI;

namespace LDCAPLAC.Entities
{
    public class GridItemsCoti
    {

        
        private String codigo;

        [Browsable(false)]
        [DisplayName("Codigo")]
        public String Codigo
        {
            get { return codigo; }
            set { codigo = value; }
        }

        private String codigolist;

        [Browsable(false)]
        [DisplayName("Codigo")]
        public String Codigolist
        {
            get { return codigolist; }
            set { codigolist = value; }
        }

        private String description;

        [Browsable(true)]
        [DisplayName("Descripcion")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private Double cantidad;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Double Cantidad
        {
            get { return cantidad; }
            set { cantidad = value; }
        }

        private Int64 valor;

        [Browsable(true)]
        [DisplayName("Valor Unitario")]
        public Int64 Valor
        {
            get { return valor; }
            set { valor = value; }
        }

        private Int64 valorTotal;

        [Browsable(true)]
        [DisplayName("Valor total")]
        public Int64 ValorTotal
        {
            get { return valorTotal; }
            set { valorTotal = value; }
        }


        public GridItemsCoti()
        {

        }

        public const String DESCRIPTION_KEY = "DESCRIPTION";

        public GridItemsCoti(GridItemsCoti item)
        {
            this.codigolist = item.Codigolist;
            this.description = item.Description;
            this.cantidad = item.Cantidad;
            this.valor = item.Valor;
            this.valorTotal = item.valorTotal;
        }

               public GridItemsCoti(DataRow drQuotationItem)
        {
            this.codigolist = Convert.ToString(drQuotationItem["nuItem"]);
            this.description = Convert.ToString(drQuotationItem["sbDescripcion"]);
            this.cantidad = Convert.ToDouble(drQuotationItem["nuCantidad"]);
            this.valor = Convert.ToInt64(drQuotationItem["nuValor"]);
            this.valorTotal = Convert.ToInt64(drQuotationItem["nuValorTotal"]);
        }

        public GridItemsCoti Clone()
        {
            return new GridItemsCoti(this);
        }



  
    }
}
