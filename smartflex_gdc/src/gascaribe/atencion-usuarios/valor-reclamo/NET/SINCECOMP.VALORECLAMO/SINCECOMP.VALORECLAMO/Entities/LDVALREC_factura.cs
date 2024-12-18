using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class LDVALREC_factura
    {
        
        private Int64 EFACTURA;

        [DisplayName("Factura")]
        public Int64 FACTURA
        {
            get { return EFACTURA; }
            set { EFACTURA = value; }
        }
        private Int64 ECUENTA;

        [DisplayName("Cuenta")]
        public Int64 CUENTA
        {
            get { return ECUENTA; }
            set { ECUENTA = value; }
        }
        private Int64 EPRODUCTO;

        [DisplayName("Producto")]
        public Int64 PRODUCTO
        {
            get { return EPRODUCTO; }
            set { EPRODUCTO = value; }
        }
        private String ETIPO_PRODUCTO;

        [DisplayName("Tipo de Producto")]
        public String TIPO_PRODUCTO
        {
            get { return ETIPO_PRODUCTO; }
            set { ETIPO_PRODUCTO = value; }
        }
        private Int64 EANO;

        [DisplayName("Año")]
        public Int64 ANO
        {
            get { return EANO; }
            set { EANO = value; }
        }
        private Int64 EMES;

        [DisplayName("Mes")]
        public Int64 MES
        {
            get { return EMES; }
            set { EMES = value; }
        }
        private Int64 ESALDO;

        [DisplayName("Saldo")]
        public Int64 SALDO
        {
            get { return ESALDO; }
            set { ESALDO = value; }
        }

        public LDVALREC_factura()
        {
            FACTURA = 0;
            CUENTA = 0;
            PRODUCTO = 0;
            TIPO_PRODUCTO = "";
            ANO = 0;
            MES = 0;
            SALDO = 0;
        }

    }
}
