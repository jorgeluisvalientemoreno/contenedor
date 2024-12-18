using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace KIOSKO.Entities
{
    public class resp_facturacion
    {

        private String Eosbseguroliberty;

        public String osbseguroliberty
        {
            get { return Eosbseguroliberty; }
            set { Eosbseguroliberty = value; }
        }
        private String Eosbordensusp;

        public String osbordensusp
        {
            get { return Eosbordensusp; }
            set { Eosbordensusp = value; }
        }
        private String Eosbprocfact;

        public String osbprocfact
        {
            get { return Eosbprocfact; }
            set { Eosbprocfact = value; }
        }
        private String Eosbimprimir;

        public String osbimprimir
        {
            get { return Eosbimprimir; }
            set { Eosbimprimir = value; }
        }
        private Int64? EonuErrorCode;

        public Int64? onuErrorCode
        {
            get { return EonuErrorCode; }
            set { EonuErrorCode = value; }
        }
        private String EosbErrorMessage;

        public String osbErrorMessage
        {
            get { return EosbErrorMessage; }
            set { EosbErrorMessage = value; }
        }
        private DataSet Edatos;

        public DataSet datos
        {
            get { return Edatos; }
            set { Edatos = value; }
        }

    }
}
