using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class ReportBineOlimpica
    {
        private Int64 orden;

        public Int64 Orden
        {
            get { return orden; }
            set { orden = value; }
        }

        private String checkdigit;

        public String Checkdigit
        {
            get { return checkdigit; }
            set { checkdigit = value; }
        }

        private String codigo_barra;

        public String Codigo_barra
        {
            get { return codigo_barra; }
            set { codigo_barra = value; }
        }

        private Int64 consec;

        public Int64 Consec
        {
            get { return consec; }
            set { consec = value; }
        }

        private DateTime fecha_reportado;

        public DateTime Fecha_reportado
        {
            get { return fecha_reportado; }
            set { fecha_reportado = value; }
        }

        private String financiador;

        public String Financiador
        {
            get { return financiador; }
            set { financiador = value; }
        }

        private String proveedor;

        public String Proveedor
        {
            get { return proveedor; }
            set { proveedor = value; }
        }

        private String articulo;

        public String Articulo
        {
            get { return articulo; }
            set { articulo = value; }
        }

        private Int64 cantidad;

        public Int64 Cantidad
        {
            get { return cantidad; }
            set { cantidad = value; }
        }

        private Decimal valor;

        public Decimal Valor
        {
            get { return valor; }
            set { valor = value; }
        }

        private Decimal iva;

        public Decimal Iva
        {
            get { return iva; }
            set { iva = value; }
        }

        private Decimal totsiniva;

        public Decimal Totsiniva
        {
            get { return totsiniva; }
            set { totsiniva = value; }
        }

        private Decimal total;

        public Decimal Total
        {
            get { return total; }
            set { total = value; }
        }

        private Int64 suscriptor;

        public Int64 Suscriptor
        {
            get { return suscriptor; }
            set { suscriptor = value; }
        }

        private String nombre;

        public String Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }

        private String direccion;

        public String Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }

        private String ptoDeVenta;

        public String PtoDeVenta
        {
            get { return ptoDeVenta; }
            set { ptoDeVenta = value; }
        }

        public ReportBineOlimpica(DataRow row)
        {
            Orden=Convert .ToInt64 (row["orden"]);
            Checkdigit=row["checkdigit"].ToString();
            Codigo_barra = row["Codigo_barra"].ToString();
            Consec = Convert.ToInt64(row["Consec"]);
            if (Convert.IsDBNull(row["Fecha_reportado"]) != true)
                Fecha_reportado = Convert.ToDateTime(row["Fecha_reportado"]);
            //else
                //Fecha_reportado = "0/0/0";
            //Fecha_reportado = Convert.ToDateTime(row["Fecha_reportado"]);
            Financiador = Convert.ToString(row["Financiador"]);
            Proveedor = Convert.ToString(row["Proveedor"]);
            Articulo = Convert.ToString(row["Articulo"]);
            Cantidad = Convert.ToInt64(row["Cantidad"]);
            Valor = Convert.ToDecimal(row["Valor"]);
            Iva = Convert.ToDecimal(row["Iva"]);
            Totsiniva = Convert.ToDecimal(row["Totsiniva"]);
            Total = Convert.ToDecimal(row["Total"]);
            Suscriptor = Convert.ToInt64(row["SUSCRIPTOR"]);
            Nombre = row["NOMBRE"].ToString ();
            Direccion = row["DIRECCION"].ToString ();
            PtoDeVenta = row["PTODEVENTA"].ToString();
        }
    }
}
