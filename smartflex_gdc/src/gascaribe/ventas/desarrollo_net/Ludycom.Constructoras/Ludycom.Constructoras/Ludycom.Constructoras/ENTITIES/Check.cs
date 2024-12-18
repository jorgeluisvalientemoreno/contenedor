using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class Check
    {
        private Int64 consecutive;

        [DisplayName("Consecutivo")]
        public Int64 Consecutive
        {
            get { return consecutive; }
            set { consecutive = value; }
        }

        private Int64 bank;

        [Browsable(true)]
        [DisplayName("Entidad")]
        public Int64 Bank
        {
            get { return bank; }
            set { bank = value; }
        }

        private String account;

        [Browsable(true)]
        [DisplayName("Cuenta")]
        public String Account
        {
            get { return account; }
            set { account = value; }
        }

        private String checkNumber;

        [Browsable(true)]
        [DisplayName("Número del Cheque")]
        public String CheckNumber
        {
            get { return checkNumber; }
            set { checkNumber = value; }
        }

        private Double checkValue;

        [Browsable(true)]
        [DisplayName("Valor")]
        public Double CheckValue
        {
            get { return checkValue; }
            set { checkValue = value; }
        }

        private DateTime checkDate;

        [Browsable(true)]
        [DisplayName("Fecha del Cheque")]
        public DateTime CheckDate
        {
            get { return checkDate; }
            set { checkDate = value; }
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

        private String newCheckNumber;

        [Browsable(true)]
        [DisplayName("Nuevo Cheque")]
        public String NewCheckNumber
        {
            get { return newCheckNumber; }
            set { newCheckNumber = value; }
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

        public Check()
        {
            this.Operation = "R";
            this.CheckDate = (OpenDate.getSysDateOfDataBase()).AddDays(2);
            this.AlarmDate = (OpenDate.getSysDateOfDataBase()).AddDays(1);
        }

        public Check(DataRow drCheck)
        {
            Int64? nullValue = null;
            this.Consecutive = Convert.ToInt64(drCheck["CONSECUTIVO"]);
            this.Bank = Convert.ToInt64(drCheck["ENTIDAD"]);
            this.Account = Convert.ToString(drCheck["CUENTA"]);
            this.CheckNumber = Convert.ToString(drCheck["NUMERO_CHEQUE"]);
            this.CheckDate = Convert.ToDateTime(drCheck["FECHA_CHEQUE"]);
            this.AlarmDate = Convert.ToDateTime(drCheck["FECHA_ALARMA"]);
            this.CheckValue = Convert.ToDouble(drCheck["VALOR"]);
            this.Status = Convert.ToString(drCheck["ESTADO"]);
            this.NewCheckNumber = string.IsNullOrEmpty(Convert.ToString(drCheck["NUEVO_CHEQUE"]))?"":Convert.ToString(drCheck["NUEVO_CHEQUE"]);
            this.Cupon = string.IsNullOrEmpty(Convert.ToString(drCheck["CUPON"])) ? nullValue : Convert.ToInt64(drCheck["CUPON"]);
            this.Operation = "N";
        }
    }
}
