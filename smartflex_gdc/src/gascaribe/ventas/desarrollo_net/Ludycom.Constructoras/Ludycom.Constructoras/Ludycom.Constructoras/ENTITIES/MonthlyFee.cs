using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class MonthlyFee
    {
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

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public MonthlyFee()
        {
            this.BillingDate = (OpenDate.getSysDateOfDataBase()).AddDays(2);
            this.AlarmDate = (OpenDate.getSysDateOfDataBase()).AddDays(1);
            this.Operation = "R";
        }

        public MonthlyFee(DataRow drMonthlyFee)
        {
            Int64? nullValue = null;
            this.Id = Convert.ToInt64(drMonthlyFee["CONSECUTIVO"]);
            this.billingDate = Convert.ToDateTime(drMonthlyFee["FECHA_COBRO"]);
            this.FeeValue = Convert.ToDouble(drMonthlyFee["VALOR"]);
            this.AlarmDate = Convert.ToDateTime(drMonthlyFee["FECHA_ALARMA"]);
            this.Status = Convert.ToString(drMonthlyFee["ESTADO"]);
            this.Cupon = string.IsNullOrEmpty(Convert.ToString(drMonthlyFee["CUPON"])) ? nullValue : Convert.ToInt64(drMonthlyFee["CUPON"]);
            this.Operation = "N";//Convert.ToString(drMonthlyFee["OPERACION"]);
        }
    }
}
