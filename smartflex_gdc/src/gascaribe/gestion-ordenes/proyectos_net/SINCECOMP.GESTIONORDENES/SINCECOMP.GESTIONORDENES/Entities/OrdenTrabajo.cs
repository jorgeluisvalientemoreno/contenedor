using System;
using System.Collections.Generic;
using System.Text;
//
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.GESTIONORDENES.Entities
{
    class OrdenTrabajo
    {
        private String EDepartamento;
        [DisplayName("Departamento")]
        public String departamento
        {
            get { return EDepartamento; }
            set { EDepartamento = value; }
        }

        private String ELocalidad;
        [DisplayName("Localidad")]
        public String localidad
        {
            get { return ELocalidad; }
            set { ELocalidad = value; }
        }

        private String ETipoTrabajo;
        [DisplayName("TipoTrabajo")]
        public String tipotrabajo
        {
            get { return ETipoTrabajo; }
            set { ETipoTrabajo = value; }
        }

        private String EFechaCreacion;
        [DisplayName("FechaCreacion")]
        public String fechacreacion
        {
            get { return EFechaCreacion; }
            set { EFechaCreacion = value; }
        }

        private String EFechaAsignacion;
        [DisplayName("FechaAsignacion")]
        public String fechaasignacion
        {
            get { return EFechaAsignacion; }
            set { EFechaAsignacion = value; }
        }

        private String EDireccion;
        [DisplayName("Direccion")]
        public String direccion
        {
            get { return EDireccion; }
            set { EDireccion = value; }
        }

    }
}
