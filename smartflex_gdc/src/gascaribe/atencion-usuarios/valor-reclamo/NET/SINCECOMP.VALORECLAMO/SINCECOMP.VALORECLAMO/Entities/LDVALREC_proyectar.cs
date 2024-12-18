using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class LDVALREC_proyectar
    {

        private String Esolicitud;

        [DisplayName("Solicitud")]
        public String solicitud
        {
            get { return Esolicitud; }
            set { Esolicitud = value; }
        }
        private Int64 Ecuenta;

        //[DisplayName("Estado de Cuenta")]
        [DisplayName("Cuenta de Cobro")]
        public Int64 cuenta
        {
            get { return Ecuenta; }
            set { Ecuenta = value; }
        }
        private Int64 Eano;

        [DisplayName("Año")]
        public Int64 ano
        {
            get { return Eano; }
            set { Eano = value; }
        }
        private Int64 Emes;

        [DisplayName("Mes")]
        public Int64 mes
        {
            get { return Emes; }
            set { Emes = value; }
        }
        private Double Evalortotal;

        [DisplayName("Valor Total")]
        public Double valortotal
        {
            get { return Evalortotal; }
            set { Evalortotal = value; }
        }
        private Double Evaloraprobado;

        [DisplayName("Valor Abonado")]
        public Double valoraprobado
        {
            get { return Evaloraprobado; }
            set { Evaloraprobado = value; }
        }
        private Double Esaldopendiente;

        [DisplayName("Saldo Pendiente")]
        public Double saldopendiente
        {
            get { return Esaldopendiente; }
            set { Esaldopendiente = value; }
        }
        private Double Evalorreclamo;

        [DisplayName("Valor en Reclamo")]
        public Double valorreclamo
        {
            get { return Evalorreclamo; }
            set { Evalorreclamo = value; }
        }
        private DateTime Efechageneracion;

        [DisplayName("Fecha de Generación")]
        public DateTime fechageneracion
        {
            get { return Efechageneracion; }
            set { Efechageneracion = value; }
        }

    }
}
