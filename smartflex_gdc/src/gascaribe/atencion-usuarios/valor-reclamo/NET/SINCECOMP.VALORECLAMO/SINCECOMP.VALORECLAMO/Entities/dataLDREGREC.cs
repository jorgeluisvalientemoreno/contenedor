using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class dataLDREGREC
    {
        //0
        private Int64 solicitud;

        [DisplayName("Solicitud")]
        public Int64 Solicitud
        {
            get { return solicitud; }
            set { solicitud = value; }
        }
        //--reclamo
        private Int64 reclamo;

        [Browsable(false)]
        [DisplayName("Reclamo")]
        public Int64 Reclamo
        {
            get { return reclamo; }
            set { reclamo = value; }
        }
        //1
        private Int64 factcodi;

        [DisplayName("Id. Factura")]
        public Int64 Factcodi
        {
            get { return factcodi; }
            set { factcodi = value; }
        }
        //2
        private Int64 cucocodi;

        [DisplayName("Id. cuenta de cobro")]
        public Int64 Cucocodi
        {
            get { return cucocodi; }
            set { cucocodi = value; }
        }
        //3
        private DateTime date_Gencodi;

        [DisplayName("Fecha de la generación de la cuenta de cobro")]
        public DateTime Date_Gencodi
        {
            get { return date_Gencodi; }
            set { date_Gencodi = value; }
        }
        //4
        private String reconcep;

        [DisplayName("Concepto")]
        public String Reconcep
        {
            get { return reconcep; }
            set { reconcep = value; }
        }
        //5
        private String resbsig;

        [DisplayName("Signo")]
        public String Resbsig
        {
            get { return resbsig; }
            set { resbsig = value; }
        }
        //6
        private String renucausal;

        [DisplayName("Causal")]
        public String Renucausal
        {
            get { return renucausal; }
            set { renucausal = value; }
        }
        //7
        private String redocsop;

        [DisplayName("Documento Soporte del Cargo")]
        public String Redocsop
        {
            get { return redocsop; }
            set { redocsop = value; }
        }
        //8
        private String recaucar;

        [DisplayName("Causa del cargo")]
        public String Recaucar
        {
            get { return recaucar; }
            set { recaucar = value; }
        }
        //9
        private Double valorCargo;

        [DisplayName("Valor facturado del cargo")]
        public Double ValorCargo
        {
            get { return valorCargo; }
            set { valorCargo = value; }
        }
        //10
        private Int64 remes;

        [DisplayName("Mes de la factura")]
        public Int64 Remes
        {
            get { return remes; }
            set { remes = value; }
        }
        //11
        private Int64 reano;

        [DisplayName("Año de la factura")]
        public Int64 Reano
        {
            get { return reano; }
            set { reano = value; }
        }
        //12
        private Double reValTotal;

        [DisplayName("Valor total")]
        public Double ReValTotal
        {
            get { return reValTotal; }
            set { reValTotal = value; }
        }
        //13
        private Double reSalPen;

        [DisplayName("Saldo pendiente")]
        public Double ReSalPen
        {
            get { return reSalPen; }
            set { reSalPen = value; }
        }
        //14
        private Double reValoReca;

        [DisplayName("Valor del reclamo")]
        public Double ReValoReca
        {
            get { return reValoReca; }
            set { reValoReca = value; }
        }
        //15
        private Int64 subscription_Id;

        [DisplayName("Id. Contrato")]
        public Int64 Subscription_Id
        {
            get { return subscription_Id; }
            set { subscription_Id = value; }
        }
        //16
        private Double reCargUni;

        [DisplayName("Unidades")]
        public Double ReCargUni
        {
            get { return reCargUni; }
            set { reCargUni = value; }
        }
    }
}
