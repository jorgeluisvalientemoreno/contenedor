using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace VENTACUPONESMAS.Entities
{
    class cupones
    {

        private Boolean Eseleccion;

        [DisplayName("Sel.")]
        public Boolean seleccion
        {
            get { return Eseleccion; }
            set { Eseleccion = value; }
        }

        private Int64 Enumcupon;

        [DisplayName("Num.")]
        public Int64 numcupon
        {
            get { return Enumcupon; }
            set { Enumcupon = value; }
        }

        private Int64 Ecupon;

        [DisplayName("Cupón")]
        public Int64 cupon
        {
            get { return Ecupon; }
            set { Ecupon = value; }
        }
        private Int64 Esolicitud;

        [DisplayName("Solicitud")]
        public Int64 solicitud
        {
            get { return Esolicitud; }
            set { Esolicitud = value; }
        }
        private Int64 Econtrato;

        [DisplayName("Contrato")]
        public Int64 contrato
        {
            get { return Econtrato; }
            set { Econtrato = value; }
        }
        private String Ecliente;

        [DisplayName("Cliente")]
        public String cliente
        {
            get { return Ecliente; }
            set { Ecliente = value; }
        }
        private String Eplancomercial;

        [DisplayName("Plan Comercial")]
        public String plancomercial
        {
            get { return Eplancomercial; }
            set { Eplancomercial = value; }
        }
        private String Elocalidad;

        [DisplayName("Localidad")]
        public String localidad
        {
            get { return Elocalidad; }
            set { Elocalidad = value; }
        }
        private String Edireccion;

        [DisplayName("Dirección")]
        public String direccion
        {
            get { return Edireccion; }
            set { Edireccion = value; }
        }

    }
}
