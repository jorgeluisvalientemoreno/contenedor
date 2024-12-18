using System;
using System.Collections.Generic;
using System.Text;
////////
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.GESTIONORDENES.Entities
{
    class ItemOrdenGestion
    {
        //columna 0
        private Int64 EItem;
        [DisplayName("Item")]
        public Int64 item
        {
            get { return EItem; }
            set { EItem = value; }
        }

        //columna 1
        private Double ECantidad;
        [DisplayName("Cantidad")]
        public Double cantidad
        {
            get { return ECantidad; }
            set { ECantidad = value; }
        }

        //columna 1
        private Double EValorItem;
        [DisplayName("Valor Item")]
        public Double valoritem
        {
            get { return EValorItem; }
            set { EValorItem = value; }
        }

        //columna 5
        private Double EValorTotalItem;
        [DisplayName("Valor Total Item")]
        public Double valortotalitem
        {
            get { return EValorTotalItem; }
            set { EValorTotalItem = value; }
        }
    }
}
