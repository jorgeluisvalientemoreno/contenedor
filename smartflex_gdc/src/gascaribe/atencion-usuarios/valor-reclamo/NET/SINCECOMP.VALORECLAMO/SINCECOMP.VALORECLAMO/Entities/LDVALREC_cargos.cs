using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class LDVALREC_cargos
    {

        private Boolean Eselection;

        //columna 0
        //[DisplayName("    ")]
        public Boolean selection
        {
            get { return Eselection; }
            set { Eselection = value; }
        }
        private String Esolicitud;

        [DisplayName("Solicitud")]
        public String solicitud
        {
            get { return Esolicitud; }
            set { Esolicitud = value; }
        }
        private String Ecuenta;

        //columna 1
        [DisplayName("Cuenta de Cobro")]
        public String cuenta
        {
            get { return Ecuenta; }
            set { Ecuenta = value; }
        }
        private Int64 Eproduct;

        //columna 2
        [DisplayName("Producto")]
        public Int64 product
        {
            get { return Eproduct; }
            set { Eproduct = value; }
        }
        private String Econcept;

        //columna 3
        [DisplayName("Concepto")]
        public String concept
        {
            get { return Econcept; }
            set { Econcept = value; }
        }
        private String Tipoproducto;

        //columna 3_1
        [DisplayName("Tipo de Producto")]
        public String tipoproducto
        {
            get { return Tipoproducto; }
            set { Tipoproducto = value; }
        }
        private String Esigned;

        //columna 4
        [DisplayName("Signo")]
        public String signed
        {
            get { return Esigned; }
            set { Esigned = value; }
        }
        private Double Eunit;

        //13.10.17 manejar las unidades
        [DisplayName("Unidades")]
        public Double unit
        {
            get { return Eunit; }
            set { Eunit = value; }
        }
        private Double EVLR_FACTURADO;

        //columna 5
        [DisplayName("Valor Facturado")]
        public Double VLR_FACTURADO
        {
            get { return EVLR_FACTURADO; }
            set { EVLR_FACTURADO = value; }
        }
        private String ECAUSAL;

        //columna 6
        [DisplayName("Causal")]
        public String CAUSAL
        {
            get { return ECAUSAL; }
            set { ECAUSAL = value; }
        }
        private String EDOCUMENTO;

        //columna 7
        [DisplayName("Documento")]
        public String DOCUMENTO
        {
            get { return EDOCUMENTO; }
            set { EDOCUMENTO = value; }
        }
        private String ECONSECUTIVO;

        //columna 8
        [DisplayName("Consecutivo")]
        public String CONSECUTIVO
        {
            get { return ECONSECUTIVO; }
            set { ECONSECUTIVO = value; }
        }


        /// <summary>
        /// CASO 275 Nuevo Campo UNIDADES RECLAMADAS
        private Double Eunitreclamadas;

        //13.10.17 manejar las unidades
        [DisplayName("Unidades Reclamadas")]
        public Double unitreclamadas
        {
            get { return Eunitreclamadas; }
            //set { Eunitreclamadas = value; }
            set
            {
                if (value <= Eunit && value >= 0)
                {
                    Eunitreclamadas = value;
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, "Valor de Unidades Reclamadas no valido");
                    Eunitreclamadas = 0;
                }

            }
        }
        /// </summary>

        private Double EVLR_RECLAMADO;

        //columna 9 ANTES 6
        [DisplayName("Valor Reclamado")]
        public Double VLR_RECLAMADO
        {
            get { return EVLR_RECLAMADO; }
            set {
                if (value <= EVLR_FACTURADO && value >= 0)
                {
                    EVLR_RECLAMADO = value;
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, "Valor de Reclamo no valido");
                    EVLR_RECLAMADO = 0;
                    Eunitreclamadas = 0;
                }
                if (value == 0)
                {
                    Eunitreclamadas = 0;
                }

            }
        }
        private String Efactura;

        //columna 10 ANTES 7
        public String factura
        {
            get { return Efactura; }
            set { Efactura = value; }
        }
        private String Eano;

        //columna 11 ANTES 8
        public String ano
        {
            get { return Eano; }
            set { Eano = value; }
        }
        private String Emes;

        //columna 12 ANTES 9
        public String mes
        {
            get { return Emes; }
            set { Emes = value; }
        }
        private String Esaldo;

        //columna 13 ANTES 10
        public String saldo
        {
            get { return Esaldo; }
            set { Esaldo = value; }
        }
        private DateTime Efecha;

        //columna 14 ANTES 11
        public DateTime fecha
        {
            get { return Efecha; }
            set { Efecha = value; }
        }
        private String EVLRTOTAL;

        //columna 15
        public String VLRTOTAL
        {
            get { return EVLRTOTAL; }
            set { EVLRTOTAL = value; }
        }
        private String Eeditable;

        public String editable
        {
            get { return Eeditable; }
            set { Eeditable = value; }
        }
        private String Econcepoblig;

        public String concepoblig
        {
            get { return Econcepoblig; }
            set { Econcepoblig = value; }
        }

    }
}
