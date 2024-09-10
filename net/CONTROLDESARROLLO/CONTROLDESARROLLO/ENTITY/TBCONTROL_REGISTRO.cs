using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
////////
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;


namespace CONTROLDESARROLLO.ENTITY
{
    class TBCONTROL_REGISTRO
    {

        //columna 0
        private Int64 ETcr_id;
        [DisplayName("TIPO CONTROL")]
        public Int64 Tcr_id
        {
            get { return ETcr_id; }
            set { ETcr_id = value; }
        }

        //columna 1
        private Int64 ECr_id;
        [DisplayName("CODIGO")]
        public Int64 Cr_id
        {
            get { return ECr_id; }
            set { ECr_id = value; }
        }

        //columna 2
        private Int64 ECliente_id;
        [DisplayName("CLIENTE")]
        public Int64 Cliente_id
        {
            get { return ECliente_id; }
            set { ECliente_id = value; }
        }

        //columna 3
        private Int64 EContacto_id;
        [DisplayName("CONTACTO")]
        public Int64 Contacto_id
        {
            get { return EContacto_id; }
            set { EContacto_id = value; }
        }

        //columna 4
        private Int64 EDependencia_id;
        [DisplayName("DEPENDENCIA")]
        public Int64 Dependencia_id
        {
            get { return EDependencia_id; }
            set { EDependencia_id = value; }
        }

        //columna 5
        private Int64 EN1_id;
        [DisplayName("N1")]
        public Int64 N1_id
        {
            get { return EN1_id; }
            set { EN1_id = value; }
        }

        //columna 6
        private Int64 EFecha_creacion_gasera;
        [DisplayName("Fecha Creacion")]
        public Int64 Fecha_creacion_gasera
        {
            get { return EFecha_creacion_gasera; }
            set { EFecha_creacion_gasera = value; }
        }

        //columna 7
        private Int64 EFecha_asignacion_contratista;
        [DisplayName("Fecha Asignacion")]
        public Int64 Fecha_asignacion_contratista
        {
            get { return EFecha_asignacion_contratista; }
            set { EFecha_asignacion_contratista = value; }
        }

        //columna 8
        private Int64 EFecha_envio_cotizacion;
        [DisplayName("Fecha Cotizacion")]
        public Int64 Fecha_envio_cotizacion
        {
            get { return EFecha_envio_cotizacion; }
            set { EFecha_envio_cotizacion = value; }
        }

        //columna 9
        private Int64 EFecha_aprobacion_desarrollo;
        [DisplayName("Fecha Aprobacion Desarrollo")]
        public Int64 Fecha_aprobacion_desarrollo
        {
            get { return EFecha_aprobacion_desarrollo; }
            set { EFecha_aprobacion_desarrollo = value; }
        }

        //columna 10
        private Int64 EFecha_entrega_solucion;
        [DisplayName("Fecha Entrega")]
        public Int64 Fecha_entrega_solucion
        {
            get { return EFecha_entrega_solucion; }
            set { EFecha_entrega_solucion = value; }
        }

        //columna 11
        private Int64 EVersion_cr;
        [DisplayName("Version")]
        public Int64 Version_cr
        {
            get { return EVersion_cr; }
            set { EVersion_cr = value; }
        }
        
        //columna 12
        private Int64 EDescripcion;
        [DisplayName("Observacion")]
        public Int64 Descripcion
        {
            get { return EDescripcion; }
            set { EDescripcion = value; }
        }

        //columna 13
        private Int64 EEstado_id;
        [DisplayName("Estado")]
        public Int64 Estado_id
        {
            get { return EEstado_id; }
            set { EEstado_id = value; }
        }

    }
}
