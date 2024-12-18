using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace LEMADOPA.Entity
{
    public class DATOSBUSQUEDA
    {

        private Boolean Eseleccion;

        [DisplayName(" ")]
        public Boolean seleccion
        {
            get { return Eseleccion; }
            set { Eseleccion = value; }
        }
        private Int64 EnumOrden;

        [DisplayName("Número de la Orden")]
        public Int64 numOrden
        {
            get { return EnumOrden; }
            set { EnumOrden = value; }
        }
        private String EnombreUsuario;

        [DisplayName("Nombre del Usuario")]
        public String nombreUsuario
        {
            get { return EnombreUsuario; }
            set { EnombreUsuario = value; }
        }
        private Int64 Esolicitud;

        [DisplayName("Solicitud")]
        public Int64 solicitud
        {
            get { return Esolicitud; }
            set { Esolicitud = value; }
        }
        private Int64 EnumContrato;

        [DisplayName("Número de Contrato")]
        public Int64 numContrato
        {
            get { return EnumContrato; }
            set { EnumContrato = value; }
        }
        private DateTime EfechaCreacion;

        //[DisplayName("Fecha de Creación de la Orden")]
        [DisplayName("Fecha de Creación Solicitud")]
        public DateTime fechaCreacion
        {
            get { return EfechaCreacion; }
            set { EfechaCreacion =  value.Date; }
        }
        private DateTime EfechaAsign;

        [DisplayName("Fecha de Asignación de la Orden")]
        public DateTime fechaAsign
        {
            get { return EfechaAsign; }
            set { EfechaAsign = value; }
        }
        private String Eobservacion;

        [DisplayName("Observacion")]
        public String observacion
        {
            get { return Eobservacion; }
            set { Eobservacion = value; }
        }

        //CASO 200-1880
        private String Eprovcont;

        [DisplayName("Proveedor")]
        public String proveedor
        {
            get { return Eprovcont; }
            set { Eprovcont = value; }
        }
        //Fin CASO 200-1880

        public DATOSBUSQUEDA()
        {
            this.seleccion = false;
            this.numOrden = 0;
            this.nombreUsuario = "";
            this.solicitud = 0;
            this.numContrato = 0;
            this.fechaCreacion = DateTime.Now;
            this.fechaAsign = DateTime.Now;
            this.observacion = "";
            //CASO 200-1880
            this.Eprovcont = "";
            //Fin CASO 200-1880
        }

    }
}
