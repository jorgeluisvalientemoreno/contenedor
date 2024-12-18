using System;
using System.Collections.Generic;
using System.Text;

//CASO 415
using System.ComponentModel;

namespace TARIFATRANSITORIA.Entity
{
    public class DetalleFacturacion
    {

        //Factura - 
        private String Efactura;
        [DisplayName("Factura")]
        public String factura
        {
            get { return Efactura; }
            set { Efactura = value; }
        }

        //Periodo - 
        private String Eperiodo;
        [DisplayName("Periodo")]
        public String periodo
        {
            get { return Eperiodo; }
            set { Eperiodo = value; }
        }

        //Cuenta - 
        private String Ecuenta;
        [DisplayName("Cuenta")]
        public String cuenta
        {
            get { return Ecuenta; }
            set { Ecuenta = value; }
        }

        //Concepto - 
        private String Econcepto;
        [DisplayName("Concepto")]
        public String concepto
        {
            get { return Econcepto; }
            set { Econcepto = value; }
        }

        //Causal de Cargo - 
        private String Ecausalcargo;
        [DisplayName("Causal de Cargo")]
        public String causalcargo
        {
            get { return Ecausalcargo; }
            set { Ecausalcargo = value; }
        }
        
        //Nota - 
        private String Enota;
        [DisplayName("# Nota")]
        public String nota
        {
            get { return Enota; }
            set { Enota = value; }
        }

        //Fecha de Registro - 
        private String Efecharegistro;
        [DisplayName("Fecha de Registro")]
        public String fecharegistro
        {
            get { return Efecharegistro; }
            set { Efecharegistro = value; }
        }

        //Signo - 
        private String Esignonota;
        [DisplayName("Signo")]
        public String signonota
        {
            get { return Esignonota; }
            set { Esignonota = value; }
        }

        //Valor - 
        private Double Evalornota;
        [DisplayName("Valor")]
        public Double valornota
        {
            get { return Evalornota; }
            set { Evalornota = value; }
        }

    }
}
