using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class dataLDVALREC
    {
        //?
        private Int64 Interaccion;

        public Int64 interaccion
        {
            get { return Interaccion; }
            set { Interaccion = value; }
        }
        //?
        private Int64 Numerosolicitud;

        public Int64 numerosolicitud
        {
            get { return Numerosolicitud; }
            set { Numerosolicitud = value; }
        }
        //?
        private String Funcionario;

        public String funcionario
        {
            get { return Funcionario; }
            set { Funcionario = value; }
        }
        //osbPointSaleName
        private String Puntoatencion;

        public String puntoatencion
        {
            get { return Puntoatencion; }
            set { Puntoatencion = value; }
        }
        //osbIdentType
        private String Solicitantetipodoc;

        public String solicitantetipodoc
        {
            get { return Solicitantetipodoc; }
            set { Solicitantetipodoc = value; }
        }
        //osbIdentification
        private String Solicitantedoc;

        public String solicitantedoc
        {
            get { return Solicitantedoc; }
            set { Solicitantedoc = value; }
        }
        //osbSubsName y osbSubsLastName
        private String Nombre;

        public String nombre
        {
            get { return Nombre; }
            set { Nombre = value; }
        }
        //?
        private DateTime Fecharegistro;

        public DateTime fecharegistro
        {
            get { return Fecharegistro; }
            set { Fecharegistro = value; }
        }
        //?
        private Int64 Mediorecepcion;

        public Int64 mediorecepcion
        {
            get { return Mediorecepcion; }
            set { Mediorecepcion = value; }
        }
        //onuAddress_Id
        private Int64 Direccionrespuesta;

        public Int64 direccionrespuesta
        {
            get { return Direccionrespuesta; }
            set { Direccionrespuesta = value; }
        }
        //?
        private String Observacion;

        public String observacion
        {
            get { return Observacion; }
            set { Observacion = value; }
        }
        //?
        private Int64 Causal;

        public Int64 causal
        {
            get { return Causal; }
            set { Causal = value; }
        }
        //?
        private Int64 Areacausante;

        public Int64 areacausante
        {
            get { return Areacausante; }
            set { Areacausante = value; }
        }
        //?
        private Int64 Areagestiona;

        public Int64 areagestiona
        {
            get { return Areagestiona; }
            set { Areagestiona = value; }
        }
        //?
        private Int64 Valorreclamado;

        public Int64 valorreclamado
        {
            get { return Valorreclamado; }
            set { Valorreclamado = value; }
        }
        private String IdentificadorCliente;

        public String identificadorCliente
        {
            get { return IdentificadorCliente; }
            set { IdentificadorCliente = value; }
        }

        public dataLDVALREC()
        {
            this.areacausante = 0;
            this.areagestiona = 0;
            this.causal = 0;
            this.direccionrespuesta = 0;
            this.fecharegistro = DateTime.Now;
            this.funcionario = "";
            this.interaccion = 0;
            this.mediorecepcion = 0;
            this.nombre = "";
            this.numerosolicitud = 0;
            this.observacion = "";
            this.puntoatencion = "";
            this.solicitantedoc = "";
            this.solicitantetipodoc = "";
            this.valorreclamado = 0;
        }

    }
}
