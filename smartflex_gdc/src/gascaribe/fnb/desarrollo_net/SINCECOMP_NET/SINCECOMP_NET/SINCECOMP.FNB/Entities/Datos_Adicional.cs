using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class Datos_Adicional
    {

        private Int64 E_VOUCHER;

        public Int64 VOUCHER
        {
            get { return E_VOUCHER; }
            set { E_VOUCHER = value; }
        }
        private Int64 E_PAGARE_UNICO;

        public Int64 PAGARE_UNICO
        {
            get { return E_PAGARE_UNICO; }
            set { E_PAGARE_UNICO = value; }
        }
        private Int64 E_CONTRATO;

        public Int64 CONTRATO
        {
            get { return E_CONTRATO; }
            set { E_CONTRATO = value; }
        }
        private String E_CIUDAD;

        public String CIUDAD
        {
            get { return E_CIUDAD; }
            set { E_CIUDAD = value; }
        }
        private String E_NOMBRE_DEUDOR;

        public String NOMBRE_DEUDOR
        {
            get { return E_NOMBRE_DEUDOR; }
            set { E_NOMBRE_DEUDOR = value; }
        }
        private String E_IDENTIFICACION;

        public String IDENTIFICACION
        {
            get { return E_IDENTIFICACION; }
            set { E_IDENTIFICACION = value; }
        }
        private Int64 E_CELULAR;

        public Int64 CELULAR
        {
            get { return E_CELULAR; }
            set { E_CELULAR = value; }
        }
        private String E_NOMBRE_ESTABLECIMIENTO;

        public String NOMBRE_ESTABLECIMIENTO
        {
            get { return E_NOMBRE_ESTABLECIMIENTO; }
            set { E_NOMBRE_ESTABLECIMIENTO = value; }
        }
        private String E_VENDEDOR;

        public String VENDEDOR
        {
            get { return E_VENDEDOR; }
            set { E_VENDEDOR = value; }
        }
        private Int64 E_TOTAL_FINANCIAR;

        public Int64 TOTAL_FINANCIAR
        {
            get { return E_TOTAL_FINANCIAR; }
            set { E_TOTAL_FINANCIAR = value; }
        }
        private Int64 E_TOTAL_COUTAS;

        public Int64 TOTAL_COUTAS
        {
            get { return E_TOTAL_COUTAS; }
            set { E_TOTAL_COUTAS = value; }
        }
        private Int64 E_CUOTA_INICIAL;

        public Int64 CUOTA_INICIAL
        {
            get { return E_CUOTA_INICIAL; }
            set { E_CUOTA_INICIAL = value; }
        }
        private Int64 E_COSTO_SEGURO;

        public Int64 COSTO_SEGURO
        {
            get { return E_COSTO_SEGURO; }
            set { E_COSTO_SEGURO = value; }
        }
        private String E_DIA1;

        public String DIA1
        {
            get { return E_DIA1; }
            set { E_DIA1 = value; }
        }
        private String E_DIA2;

        public String DIA2
        {
            get { return E_DIA2; }
            set { E_DIA2 = value; }
        }
        private String E_MES1;

        public String MES1
        {
            get { return E_MES1; }
            set { E_MES1 = value; }
        }
        private String E_MES2;

        public String MES2
        {
            get { return E_MES2; }
            set { E_MES2 = value; }
        }
        private String E_ANNO1;

        public String ANNO1
        {
            get { return E_ANNO1; }
            set { E_ANNO1 = value; }
        }
        private String E_ANNO2;

        public String ANNO2
        {
            get { return E_ANNO2; }
            set { E_ANNO2 = value; }
        }
        private String E_ANNO3;

        public String ANNO3
        {
            get { return E_ANNO3; }
            set { E_ANNO3 = value; }
        }
        private String E_ANNO4;

        public String ANNO4
        {
            get { return E_ANNO4; }
            set { E_ANNO4 = value; }
        }
        private Int64 E_VALOR_TOTAL;

        public Int64 VALOR_TOTAL
        {
            get { return E_VALOR_TOTAL; }
            set { E_VALOR_TOTAL = value; }
        }
        private Int64 E_CUOTA_MENSUAL;

        public Int64 CUOTA_MENSUAL
        {
            get { return E_CUOTA_MENSUAL; }
            set { E_CUOTA_MENSUAL = value; }
        }
        private String E_EDFN;

        public String EDFN
        {
            get { return E_EDFN; }
            set { E_EDFN = value; }
        }

        public Datos_Adicional(DataRow row)
        {
            try
            {



                VOUCHER = Convert.ToInt64(row["VOUCHER"].ToString());
                PAGARE_UNICO = Convert.ToInt64(row["PAGARE_UNICO"].ToString());
                CONTRATO = Convert.ToInt64(row["CONTRATO"].ToString());
                CIUDAD = row["CIUDAD"].ToString();
                NOMBRE_DEUDOR = row["NOMBRE_DEUDOR"].ToString();
                IDENTIFICACION = row["IDENTIFICACION"].ToString();
                CELULAR = Convert.ToInt64(row["CELULAR"].ToString());
                NOMBRE_ESTABLECIMIENTO = row["NOMBRE_ESTABLECIMIENTO"].ToString();
                VENDEDOR = row["VENDEDOR"].ToString();
                TOTAL_FINANCIAR = Convert.ToInt64(row["TOTAL_FINANCIAR"].ToString());
                TOTAL_COUTAS = Convert.ToInt64(row["TOTAL_COUTAS"].ToString());
                CUOTA_INICIAL = Convert.ToInt64(row["CUOTA_INICIAL"].ToString());
                COSTO_SEGURO = Convert.ToInt64(row["COSTO_SEGURO"].ToString());
                DIA1 = row["DIA1"].ToString();
                DIA2 = row["DIA2"].ToString();
                MES1 = row["MES1"].ToString();
                MES2 = row["MES2"].ToString();
                ANNO1 = row["ANNO1"].ToString();
                ANNO2 = row["ANNO2"].ToString();
                ANNO3 = row["ANNO3"].ToString();
                ANNO4 = row["ANNO4"].ToString();
                VALOR_TOTAL = Convert.ToInt64(row["VALOR_TOTAL"].ToString());
                CUOTA_MENSUAL = Convert.ToInt64(row["CUOTA_MENSUAL"].ToString());
                EDFN = row["EDFN"].ToString();
        


            }
            catch { }
        }

    }
}
