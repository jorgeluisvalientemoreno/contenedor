using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    public class Comando
    {

        private String E_CIUDAD_CODEUDOR;

        public String CIUDAD_CODEUDOR
        {
            get { return E_CIUDAD_CODEUDOR; }
            set { E_CIUDAD_CODEUDOR = value; }
        }
        private String E_NOMBRE_DEUDOR;

        public String NOMBRE_DEUDOR
        {
            get { return E_NOMBRE_DEUDOR; }
            set { E_NOMBRE_DEUDOR = value; }
        }
        private String E_IDENTIFICACION_CODEUDOR;

        public String IDENTIFICACION_CODEUDOR
        {
            get { return E_IDENTIFICACION_CODEUDOR; }
            set { E_IDENTIFICACION_CODEUDOR = value; }
        }
        private Int64 E_CELULAR_CODEUDOR;

        public Int64 CELULAR_CODEUDOR
        {
            get { return E_CELULAR_CODEUDOR; }
            set { E_CELULAR_CODEUDOR = value; }
        }


        public Comando(DataRow row)
        {
            try
            {



                CIUDAD_CODEUDOR = row["CIUDAD_CODEUDOR"].ToString();
                NOMBRE_DEUDOR = row["NOMBRE_DEUDOR"].ToString();
                IDENTIFICACION_CODEUDOR = row["IDENTIFICACION_CODEUDOR"].ToString();
                CELULAR_CODEUDOR =  Convert.ToInt64(row["CELULAR_CODEUDOR"].ToString());

                


            }
            catch { }
        }

    }
}
