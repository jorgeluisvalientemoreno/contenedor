using System;
using System.Collections.Generic;
using System.Text;

using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.ENTITIES
{
    class ListadoInternas
    {
        //columna 0
        private Boolean Eselection;
        [DisplayName("Permitir Legalizar")]
        public Boolean selection
        {
            get { return Eselection; }
            set { Eselection = value; }
        }

        //columna 1
        private Int64 EOrden;
        [DisplayName("Orden Interna")]
        public Int64 orden
        {
            get { return EOrden; }
            set { EOrden = value; }
        }

        //columna 2
        private Int64 EContrato;
        [DisplayName("Contrato")]
        public Int64 contrato
        {
            get { return EContrato; }
            set { EContrato = value; }
        }


        //columna 3
        private Int64 EProducto;
        [DisplayName("Producto")]
        public Int64 producto
        {
            get { return EProducto; }
            set { EProducto = value; }
        }

        //columna 4
        private String EDireccion;
        [DisplayName("Direccion")]
        public String direccion
        {
            get { return EDireccion; }
            set { EDireccion = value; }
        }



        public ListadoInternas(
                                bool seleccion,
                                Int64 Orden,            
                                Int64 Contrato,
                                Int64 Producto,
                                String Direccion
                                    )
        {
            this.Eselection = seleccion;
            this.EOrden = Orden;
            this.EContrato = Contrato;
            this.EProducto = Producto;
            this.EDireccion = Direccion;           
                     
        }

 
    }
}
