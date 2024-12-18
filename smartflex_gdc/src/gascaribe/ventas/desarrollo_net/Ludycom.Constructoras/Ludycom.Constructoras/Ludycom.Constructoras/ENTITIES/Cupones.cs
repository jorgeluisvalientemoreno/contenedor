using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class Cupones
    {
        private Boolean Eseleccion;

        [DisplayName("Sel.")]
        public Boolean seleccion
        {
            get { return Eseleccion; }
            set { Eseleccion = value; }
        }

        private Int64 id;

        [Browsable(true)]
        [DisplayName("Id")]
        public Int64 Id
        {
            get { return id; }
            set { id = value; }
        }

        private DateTime billingDate;

        [Browsable(true)]
        [DisplayName("Fecha Pactada de Cobro")]
        public DateTime BillingDate
        {
            get { return billingDate; }
            set { billingDate = value; }
        }

        private Double feeValue;

        [Browsable(true)]
        [DisplayName("Valor")]
        public Double FeeValue
        {
            get { return feeValue; }
            set { feeValue = value; }
        }

        private DateTime alarmDate;

        [Browsable(true)]
        [DisplayName("Fecha de Alarma")]
        public DateTime AlarmDate
        {
            get { return alarmDate; }
            set { alarmDate = value; }
        }

        private String status;

        [Browsable(true)]
        [DisplayName("Estado")]
        public String Status
        {
            get { return status; }
            set { status = value; }
        }

        private Int64? cupon;

        [Browsable(true)]
        [DisplayName("Cupón")]
        public Int64? Cupon
        {
            get { return cupon; }
            set { cupon = value; }
        }

        private String proyecto;

        [Browsable(true)]
        [DisplayName("Proyecto.")]
        public String Proyecto
        {
            get { return proyecto; }
            set { proyecto = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

    }
}
