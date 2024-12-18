using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class LDCAVRReclamos
    {
        //columna 0
        private Boolean Eselection;
        [DisplayName(" ")]
        public Boolean selection
        {
            get { return Eselection; }
            set { Eselection = value; }
        }

        //columna 1
        private String Esolicitud;
        [DisplayName("Solicitud")]
        public String solicitud
        {
            get { return Esolicitud; }
            set { Esolicitud = value; }
        }

        //columna 2
        private String Ecuenta;
        [DisplayName("Cuenta de Cobro")]
        public String cuenta
        {
            get { return Ecuenta; }
            set { Ecuenta = value; }
        }

        //columna 3
        private String Efactura;
        [DisplayName("Factura")]
        public String factura
        {
            get { return Efactura; }
            set { Efactura = value; }
        }

        //columna 4
        private String Ecargos;
        [DisplayName("Cargos")]
        public String cargos
        {
            get { return Ecargos; }
            set { Ecargos = value; }
        }

        //columna 5
        private String Econtrato;
        [DisplayName("Contrato")]
        public String contrato
        {
            get { return Econtrato; }
            set { Econtrato = value; }
        }

        //columna 6
        private String Ecausal;
        [DisplayName("Causal")]
        public String causal
        {
            get { return Ecausal; }
            set { Ecausal = value; }
        }

        //columna 7
        private String Etiposolicitud;
        [DisplayName("Tipo Solicitud")]
        public String tiposolicitud
        {
            get { return Etiposolicitud; }
            set { Etiposolicitud = value; }
        }

        //columna 8
        private String Efecharegitro;
        [DisplayName("Fecha Registro")]
        public String fecharegitro
        {
            get { return Efecharegitro; }
            set { Efecharegitro = value; }
        }

        //columna 9
        private String Epuntoatencion;
        [DisplayName("Punto Atencion")]
        public String puntoatencion
        {
            get { return Epuntoatencion; }
            set { Epuntoatencion = value; }
        }

        //columna 10
        private String Efuncionario;
        [DisplayName("Funcionario")]
        public String funcionario
        {
            get { return Efuncionario; }
            set { Efuncionario = value; }
        }

        //columna 11
        private Double Evalorfactura;
        [DisplayName("Valor Factura")]
        public Double valorfactura
        {
            get { return Evalorfactura; }
            set { Evalorfactura = value; }
        }

        //columna 12
        private Double Evalorreclamo;
        [DisplayName("Valor Reclamo")]
        public Double valorreclamo
        {
            get { return Evalorreclamo; }
            set { Evalorreclamo = value; }
        }

        //columna 13
        private Double Ereclamosid;
        [DisplayName("Reclamo ID")]
        public Double reclamosid
        {
            get { return Ereclamosid; }
            set { Ereclamosid = value; }
        }

        //columna 14
        private Double Ereclamoorignal;
        [DisplayName("Reclamo Original")]
        public Double reclamooriginal
        {
            get { return Ereclamoorignal; }
            set { Ereclamoorignal = value; }
        }

    }
}
