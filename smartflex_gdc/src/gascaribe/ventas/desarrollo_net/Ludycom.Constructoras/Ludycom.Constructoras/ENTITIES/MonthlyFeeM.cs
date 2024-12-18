using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class MonthlyFeeM
    {
        private Boolean Eseleccion;

        [DisplayName("Sel.")]
        public Boolean seleccion
        {
            get { return Eseleccion; }
            set { Eseleccion = value; }
        }

        private Int64? cupon;

        [Browsable(true)]
        [DisplayName("Cupón")]
        public Int64? Cupon
        {
            get { return cupon; }
            set { cupon = value; }
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

        

        private String proyecto;

        [DisplayName("Proyecto")]
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

        
        private String nombre_proyecto;
        [Browsable(true)]
        [DisplayName("Descripcion")]

        public String Nombre_Proyecto
        {
            get { return nombre_proyecto; }
            set { nombre_proyecto = value; }
        }

      
        private String nombre_Cliente;
        [Browsable(true)]
        [DisplayName("Cliente")]

        public String Nombre_Cliente
        {
            get { return nombre_Cliente; }
            set { nombre_Cliente = value; }
        }

        
        private String saldo_Pendiente;
        [Browsable(true)]
        [DisplayName("S. Pendiente")]

        public String Saldo_Pendiente
        {
            get { return saldo_Pendiente; }
            set { saldo_Pendiente = value; }
        }

        
        private String saldo_Diferido;
        [Browsable(true)]
        [DisplayName("S. Diferido")]

        public String Saldo_Diferido
        {
            get { return saldo_Diferido; }
            set { saldo_Diferido = value; }
        }

       
/*
        public MonthlyFeeM()
        {
            this.BillingDate = (OpenDate.getSysDateOfDataBase()).AddDays(2);
            this.AlarmDate = (OpenDate.getSysDateOfDataBase()).AddDays(1);
            this.Operation = "R";
        }

        public MonthlyFeeM(DataRow drMonthlyFeeM)
        {
            Int64? nullValue = null;
            this.Id = Convert.ToInt64(drMonthlyFeeM["CONSECUTIVO"]);
            this.billingDate = Convert.ToDateTime(drMonthlyFeeM["FECHA_COBRO"]);
            this.FeeValue = Convert.ToDouble(drMonthlyFeeM["VALOR"]);
            this.AlarmDate = Convert.ToDateTime(drMonthlyFeeM["FECHA_ALARMA"]);
            this.Status = Convert.ToString(drMonthlyFeeM["ESTADO"]);
            this.Cupon = string.IsNullOrEmpty(Convert.ToString(drMonthlyFeeM["CUPON"])) ? nullValue : Convert.ToInt64(drMonthlyFeeM["CUPON"]);
            this.Operation = "N";//Convert.ToString(drMonthlyFee["OPERACION"]);
        }*/
    }
}
