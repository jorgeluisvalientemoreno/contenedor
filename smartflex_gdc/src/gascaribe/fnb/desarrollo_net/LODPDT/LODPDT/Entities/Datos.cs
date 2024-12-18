using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace LODPDT.Entities
{
    class Datos
    {

        private Boolean seleccion;

        [Description("Permite Seleccionar uno o mas registros al tiempo para ser Procesados.")]
        [DisplayName("Sel.")]
        public Boolean Seleccion
        {
            get { return seleccion; }
            set { seleccion = value; }
        }
        private Int64 contrato;

        [Description("Numero del Contrato.")]
        [DisplayName("Contrato")]
        public Int64 Contrato
        {
            get { return contrato; }
            set { contrato = value; }
        }
        private String departamento;

        [Description("Nombre del Departamento.")]
        [DisplayName("Departamento")]
        public String Departamento
        {
            get { return departamento; }
            set { departamento = value; }
        }
        private String localidad;

        [Description("Nombre de la Localidad.")]
        [DisplayName("Localidad")]
        public String Localidad
        {
            get { return localidad; }
            set { localidad = value; }
        }
        private Int64 solicitud;

        [Description("Número de la Solicitud.")]
        [DisplayName("Solicitud")]
        public Int64 Solicitud
        {
            get { return solicitud; }
            set { solicitud = value; }
        }
        private String estadoSolicitud;

        [Description("Estado de la Solicitud.")]
        [DisplayName("Estado Solicitud")]
        public String EstadoSolicitud
        {
            get { return estadoSolicitud; }
            set { estadoSolicitud = value; }
        }
        private DateTime fechaVenta;

        [Description("Fecha en la que se ejecuto la Venta.")]
        [DisplayName("Fecha de Venta")]
        public DateTime FechaVenta
        {
            get { return fechaVenta; }
            set { fechaVenta = value; }
        }
        private Int64 orden;

        [Description("Número de la Orden.")]
        [DisplayName("Orden")]
        public Int64 Orden
        {
            get { return orden; }
            set { orden = value; }
        }
        private String contratista;

        [Description("Nombre del Contratista.")]
        [DisplayName("Contratista")]
        public String Contratista
        {
            get { return contratista; }
            set { contratista = value; }
        }
        private String unidadOperativa;

        [Description("Nombre de la Unidad Operativa.")]
        [DisplayName("Unidad Operativa")]
        public String UnidadOperativa
        {
            get { return unidadOperativa; }
            set { unidadOperativa = value; }
        }
        private String nombreCliente;

        [Description("Nombre del Cliente.")]
        [DisplayName("Nombre del Cliente")]
        public String NombreCliente
        {
            get { return nombreCliente; }
            set { nombreCliente = value; }
        }
        private String nuevoNombreCliente;

        [Description("Nuevo Nombre que sera asignado al Cliente.")]
        [DisplayName("Nuevo Nombre del Cliente")]
        public String NuevoNombreCliente
        {
            get { return nuevoNombreCliente; }
            set {
                if (value == null)
                {
                    nuevoNombreCliente = "";
                }
                else
                {
                    nuevoNombreCliente = value;
                }
            }
        }
        private String apellidoCliente;

        [Description("Apellido del Cliente.")]
        [DisplayName("Apellido del Cliente")]
        public String ApellidoCliente
        {
            get { return apellidoCliente; }
            set { apellidoCliente = value; }
        }
        private String nuevoApellidoCliente;

        [Description("Nuevo Apellido que sera asignado al Cliente.")]
        [DisplayName("Nuevo Apellido del Cliente")]
        public String NuevoApellidoCliente
        {
            get { return nuevoApellidoCliente; }
            set { nuevoApellidoCliente = value; }
        }
        private String identificacionCliente;

        [Description("Identificacion del Cliente.")]
        [DisplayName("Identificación del Cliente")]
        public String IdentificacionCliente
        {
            get { return identificacionCliente; }
            set { identificacionCliente = value; }
        }
        private String nuevoIdentificacionCliente;

        [Description("Nueva Identificación que sera asignada al Cliente.")]
        [DisplayName("Nueva Identificación del Cliente")]
        public String NuevoIdentificacionCliente
        {
            get { return nuevoIdentificacionCliente; }
            set { nuevoIdentificacionCliente = value; }
        }
        private DateTime fechaRegistro;

        [Browsable(false)]
        [DisplayName("Fecha de Registro")]
        public DateTime FechaRegistro
        {
            get { return fechaRegistro; }
            set { fechaRegistro = value; }
        }
        private DateTime? fechaFinal;

        [Browsable(false)]
        [DisplayName("Fecha Final")]
        public DateTime? FechaFinal
        {
            get { return fechaFinal; }
            set { fechaFinal = value; }
        }
        private Int64 valorTotalVenta;

        [Description("Valor Total de la Venta.")]
        [DisplayName("Valor Total de Venta")]
        public Int64 ValorTotalVenta
        {
            get { return valorTotalVenta; }
            set { valorTotalVenta = value; }
        }
        private Int64 valorFinanciar;

        [Description("Valor que sera Financiado al Cliente.")]
        [DisplayName("Valor a Financiar")]
        public Int64 ValorFinanciar
        {
            get { return valorFinanciar; }
            set { valorFinanciar = value; }
        }
        private Double cuotaInicial;

        [Description("Valor de la Cuota Inicial.")]
        [DisplayName("Cuota Inicial")]
        public Double CuotaInicial
        {
            get { return cuotaInicial; }
            set { cuotaInicial = value; }
        }
        private String pagare;

        [Description("Codigo del Pagare.")]
        [DisplayName("Pagare")]
        public String Pagare
        {
            get { return pagare; }
            set { pagare = value; }
        }
        private String vendedor;

        [Browsable(false)]
        [DisplayName("Vendedor")]
        public String Vendedor
        {
            get { return vendedor; }
            set { vendedor = value; }
        }
        private String puntoVenta;

        [Browsable(false)]
        [DisplayName("Punto de Venta")]
        public String PuntoVenta
        {
            get { return puntoVenta; }
            set { puntoVenta = value; }
        }
        private String nombreCodeudor;

        [Description("Nombre del Codeudor.")]
        [DisplayName("Nombre Codeudor")]
        public String NombreCodeudor
        {
            get { return nombreCodeudor; }
            set { nombreCodeudor = value; }
        }
        private String nuevoNombreCodeudor;

        [Description("Nuevo Nombre que sera asignado al Codeudor.")]
        [DisplayName("Nuevo Nombre Codeudor")]
        public String NuevoNombreCodeudor
        {
            get { return nuevoNombreCodeudor; }
            set { nuevoNombreCodeudor = value; }
        }
        private String apellidoCodeudor;

        [Description("Apellido del Codeudor.")]
        [DisplayName("Apellido Codeudor")]
        public String ApellidoCodeudor
        {
            get { return apellidoCodeudor; }
            set { apellidoCodeudor = value; }
        }
        private String nuevoApellidoCodeudor;

        [Description("Nuevo Apellido que sera asignado al Codeudor.")]
        [DisplayName("Nuevo Apellido Codeudor")]
        public String NuevoApellidoCodeudor
        {
            get { return nuevoApellidoCodeudor; }
            set { nuevoApellidoCodeudor = value; }
        }
        private String identificacionCodeudor;

        [Description("Identificación del Codeudor.")]
        [DisplayName("Identificación Codeudor")]
        public String IdentificacionCodeudor
        {
            get { return identificacionCodeudor; }
            set { identificacionCodeudor = value; }
        }
        private String nuevoIdentificacionCodeudor;

        [Description("Nueva Identificación que sera asignado al Codeudor.")]
        [DisplayName("Nueva Identificación del Codeudor")]
        public String NuevoIdentificacionCodeudor
        {
            get { return nuevoIdentificacionCodeudor; }
            set { nuevoIdentificacionCodeudor = value; }
        }
        private String pagareUnico;

        [Description("Codigo del Pagaré Unico.")]
        [DisplayName("Pagaré Unico")]
        public String PagareUnico
        {
            get { return pagareUnico; }
            set { pagareUnico = value; }
        }
        private String observacion;

        [Description("Observación del Usuario.")]
        [DisplayName("Observación")]
        public String Observacion
        {
            get { return observacion; }
            set { observacion = value; }
        }
        /*private String actualizar;

        [DisplayName("Actualizar Datos\nActualizar")]
        public String Actualizar
        {
            get { return actualizar; }
            set { actualizar = value; }
        }
        private String noActualizar;

        [DisplayName("Actualizar Datos\nNo Actualizar")]
        public String NoActualizar
        {
            get { return noActualizar; }
            set { noActualizar = value; }
        }
        private String actualizarSoloDeudor;

        [DisplayName("Actualizar Datos\nActualizar Solo Deudor")]
        public String ActualizarSoloDeudor
        {
            get { return actualizarSoloDeudor; }
            set { actualizarSoloDeudor = value; }
        }
        private String actualizarSoloCoDeudor;

        [DisplayName("Actualizar Datos\nActualizar Solo Codeudor")]
        public String ActualizarSoloCoDeudor
        {
            get { return actualizarSoloCoDeudor; }
            set { actualizarSoloCoDeudor = value; }
        }
        private String autoriza;

        [DisplayName("Estado de Ley\nAutoriza")]
        public String Autoriza
        {
            get { return autoriza; }
            set { autoriza = value; }
        }
        private String noAutoriza;

        [DisplayName("Estado de Ley\nNo Autoriza")]
        public String NoAutoriza
        {
            get { return noAutoriza; }
            set { noAutoriza = value; }
        }
        private String revocado;

        [DisplayName("Estado de Ley\nRevocado")]
        public String Revocado
        {
            get { return revocado; }
            set { revocado = value; }
        }*/
        private String actualizarDatos;

        [Description("Accion ha aplicar con el Registro.")]
        [DisplayName("Actualizar Datos")]
        public String ActualizarDatos
        {
            get { return actualizarDatos; }
            set { actualizarDatos = value; }
        }
        private String estadoLey;

        [Description("Estado de la Ley 1581.")]
        [DisplayName("Estado de Ley 1581")]
        public String EstadoLey
        {
            get { return estadoLey; }
            set { estadoLey = value; }
        }
        private String causalLegalizacion;

        [Description("Seleccione la Causal de Legalización.")]
        [DisplayName("Causal de Legalización")]
        public String CausalLegalizacion
        {
            get { return causalLegalizacion; }
            set { causalLegalizacion = value; }
        }
        private String estadoOT;

        [Description("Estado de la Orden de Trabajo.")]
        [DisplayName("Estado de OT Entrega")]
        public String EstadoOT
        {
            get { return estadoOT; }
            set { estadoOT = value; }
        }

    }
}