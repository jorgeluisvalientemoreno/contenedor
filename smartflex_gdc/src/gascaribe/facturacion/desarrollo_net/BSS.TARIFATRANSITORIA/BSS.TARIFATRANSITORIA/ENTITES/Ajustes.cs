using System;
using System.Collections.Generic;
using System.Text;

//Libreria OPEN
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace BSS.TARIFATRANSITORIA.ENTITES
{
    class Ajustes
    {
        //columna A
        private String EPeriodo;
        [DisplayName("Periodo")]
        public String periodo
        {
            get { return EPeriodo; }
            set { EPeriodo = value; }
        }

        //columna B
        private String EM3fact;
        [DisplayName("M3 Fact")]
        public String m3fact
        {
            get { return EM3fact; }
            set { EM3fact = value; }
        }

        //columna C
        private String EFactura;
        [DisplayName("Fatura")]
        public String factura
        {
            get { return EFactura; }
            set { EFactura = value; }
        }

        //columna D
        private String ECuentacobro;
        [DisplayName("Cuenta")]
        public String cuentacobro
        {
            get { return ECuentacobro; }
            set { ECuentacobro = value; }
        }

        //columna E
        private Int64 EConsumo;
        [DisplayName("Consumo")]
        public Int64 consumo
        {
            get { return EConsumo; }
            set { EConsumo = value; }
        }

        //columna F
        private Int64 ESubsidio;
        [DisplayName("Subsidio")]
        public Int64 subsidio
        {
            get { return ESubsidio; }
            set { ESubsidio = value; }
        }

        //columna G
        private Int64 EContribucion;
        [DisplayName("Contribucion")]
        public Int64 contribucion
        {
            get { return EContribucion; }
            set { EContribucion = value; }
        }

        //columna I
        private Int64 EConsumo048;
        [DisplayName("Consumo 048")]
        public Int64 consumo048
        {
            get { return EConsumo048; }
            set { EConsumo048 = value; }
        }

        //columna J
        private Int64 ESubsisio048;
        [DisplayName("Subsisio 048")]
        public Int64 subsisio048
        {
            get { return ESubsisio048; }
            set { ESubsisio048 = value; }
        }

        //columna K
        private Int64 EContribucion048;
        [DisplayName("Contribucion 048")]
        public Int64 contribucion048
        {
            get { return EContribucion048; }
            set { EContribucion048 = value; }
        }

        //columna L
        private Int64 ESubadicional;
        [DisplayName("Sub Adicional")]
        public Int64 subadicional
        {
            get { return ESubadicional; }
            set { ESubadicional = value; }
        }

        //columna M
        private Int64 ESubadicionaltt;
        [DisplayName("Sub Adicional TT")]
        public Int64 subadicionaltt
        {
            get { return ESubadicionaltt; }
            set { ESubadicionaltt = value; }
        }

        //columna N
        private Int64 ETotal;
        [DisplayName("Total")]
        public Int64 total
        {
            get { return ETotal; }
            set { ETotal = value; }
        }

        
    }
}
