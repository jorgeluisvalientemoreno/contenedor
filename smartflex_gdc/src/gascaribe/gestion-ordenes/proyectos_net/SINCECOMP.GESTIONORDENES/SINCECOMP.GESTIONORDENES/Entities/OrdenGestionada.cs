using System;
using System.Collections.Generic;
using System.Text;
//
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.GESTIONORDENES.Entities
{
    class OrdenGestionada
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
        private Int64 EOrden;
        [DisplayName("Orden")]
        public Int64 orden
        {
            get { return EOrden; }
            set { EOrden = value; }
        }

        //columna 2
        private String ETipoTrab;
        [DisplayName("Tipo Trabajo")]
        public String tipotrab
        {
            get { return ETipoTrab; }
            set { ETipoTrab = value; }
        }


        //columna 3
        private String EAgente;
        [DisplayName("Agente")]
        public String agente
        {
            get { return EAgente; }
            set { EAgente = value; }
        }

        //columna 4
        private String EDireccion;
        [DisplayName("Direccion")]
        public String direccion
        {
            get { return EDireccion; }
            set { EDireccion = value; }
        }

        //columna 5
        private String ELocalidad;
        [DisplayName("Localidad")]
        public String localidad
        {
            get { return ELocalidad; }
            set { ELocalidad = value; }
        }

        //columna 6
        private String EFechaGestion;
        [DisplayName("Fecha de Gestion")]
        public String fechagestion
        {
            get { return EFechaGestion; }
            set { EFechaGestion = value; }
        }
        
        //columna 7
        private Int64 EContrato;
        [DisplayName("Contrato")]
        public Int64 contrato
        {
            get { return EContrato; }
            set { EContrato = value; }
        }

        //columna 8
        private String EObservacion;
        [DisplayName("Observacion")]
        public String observacion
        {
            get { return EObservacion; }
            set { EObservacion = value; }
        }

        //columna 9
        private String ERespuestaOSF;
        [DisplayName("Respuesta OSF")]
        public String respuestaOSF
        {
            get { return ERespuestaOSF; }
            set { ERespuestaOSF = value; }
        }

        public OrdenGestionada(
        Int64 Orden,
        String TipoTrab,
        String Agente,
        String Direccion,
        String Localidad,
        String FechaGestion,
        Int64 Contrato,
        String Observacion,
        String RespuestaOSF
            )
        {
            this.EOrden = Orden;
            this.ETipoTrab = TipoTrab;
            this.EAgente = Agente;
            this.EDireccion = Direccion;
            this.ELocalidad = Localidad;
            this.EFechaGestion = FechaGestion;
            this.EContrato = Contrato;
            this.EObservacion = Observacion;
            this.ERespuestaOSF = RespuestaOSF;
        }

    }
}
