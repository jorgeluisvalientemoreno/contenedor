using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace LDCDUPLIFACT.Entities
{
	class EstadoCuentas
	{

        private Boolean seleccion;
        private Int64 cod_periodo;
        private String periodo;
        private String estadoCuenta;
        private DateTime fechaEmision;
      //  private Boolean good;

       /* public EstadoCuentas(Boolean seleccion, int cod_periodo, int periodo, string estadoCuenta, DateTime fechaEmision)//, Boolean good)
        {
            this.seleccion = seleccion;
            this.cod_periodo = cod_periodo;
            this.periodo = periodo;
            this.estadoCuenta = estadoCuenta;
            this.fechaEmision = fechaEmision;
           // this.good = good;
        }*/

        [DisplayName("Sel.")]
        public Boolean Seleccion
        {
            get { return seleccion; }
            set { seleccion = value; }
        }

        [DisplayName("Código Periodo")]
        public Int64 Cod_periodo
        {
            get { return cod_periodo; }
            set { cod_periodo = value; }
        }

        [DisplayName("Periodo")]
        public String Periodo
        {
            get { return periodo; }
            set { periodo = value; }
        }

        [DisplayName("Estado Cuenta")]
        public String EstadoCuenta
        {
            get { return estadoCuenta; }
            set { estadoCuenta = value; }
        }

        [DisplayName("Fecha Emisión")]
        public DateTime FechaEmision
        {
            get { return fechaEmision; }
            set { fechaEmision = value; }
        }
	}
}
