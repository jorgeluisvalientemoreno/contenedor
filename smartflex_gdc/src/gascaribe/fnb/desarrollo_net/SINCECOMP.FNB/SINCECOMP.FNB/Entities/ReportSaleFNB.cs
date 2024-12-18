#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : ReportSaleFNB
 * Descripcion   : Clase contenedora de la informacion del reporte de venta
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ==============  =====================================================================
 * 10-10-2013   219856  LDiuza          1 - Se agregan campos y propiedades <financier> y <operatinUnit> para
 *                                          completar la informacion de un reporte de venta
 *                                      2 - Se asignan valores a las propiedades <financier> y <operatinUnit>
 *                                          en el constructor.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class ReportSaleFNB
    {
        private Int64 solicitud;

        public Int64 Solicitud
        {
            get { return solicitud; }
            set { solicitud = value; }
        }

        private Int64 suscripcion;

        public Int64 Suscripcion
        {
            get { return suscripcion; }
            set { suscripcion = value; }
        }

        private String direccion;

        public String Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }

        private Int64 articulo;

        public Int64 Articulo
        {
            get { return articulo; }
            set { articulo = value; }
        }

        private Int64 valor;

        public Int64 Valor
        {
            get { return valor; }
            set { valor = value; }
        }

        private Int64 cantidad;

        public Int64 Cantidad
        {
            get { return cantidad; }
            set { cantidad = value; }
        }

        private Int64 ncuotas;

        public Int64 Ncuotas
        {
            get { return ncuotas; }
            set { ncuotas = value; }
        }

        private Decimal iva;

        public Decimal Iva
        {
            get { return iva; }
            set { iva = value; }
        }

        private DateTime fdePago;

        public DateTime FdePago
        {
            get { return fdePago; }
            set { fdePago = value; }
        }

        private String pFinan;

        public String PFinan
        {
            get { return pFinan; }
            set { pFinan = value; }
        }

        private Int64 proveedor;

        public Int64 Proveedor
        {
            get { return proveedor; }
            set { proveedor = value; }
        }

        private DateTime fVenta;

        public DateTime FVenta
        {
            get { return fVenta; }
            set { fVenta = value; }
        }

        private String nArticulo;

        public String NArticulo
        {
            get { return nArticulo; }
            set { nArticulo = value; }
        }

        private String nProveedor;

        public String NProveedor
        {
            get { return nProveedor; }
            set { nProveedor = value; }
        }

        private Decimal abono;

        public Decimal Abono
        {
            get { return abono; }
            set { abono = value; }
        }

        private String nombre;

        public String Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }

        /****************************************/
        //10-10-2013:LDiuza.SAO219856:1
        private String financier;

        public String Financier
        {
            get { return financier; }
            set { financier = value; }
        }

        private String operatingUnit;

        public String OperatingUnit
        {
            get { return operatingUnit; }
            set { operatingUnit = value; }
        }
        /****************************************/


        /*****KCienfuegos RNP499 14/08/2014****/
        private Int64 pagare;

        public Int64 Pagare
        {
            get { return pagare;}
            set { pagare = value;}
        }
        /**************************************/

        public ReportSaleFNB(DataRow row)
        {
            try
            {
                Solicitud = Convert.ToInt64(row["solicitud"]);
                Suscripcion = Convert.ToInt64(row["suscripcion"]);
                Direccion = row["direccion"].ToString();
                Nombre = Convert.ToString(row["nombre"]);
                Valor = Convert.ToInt64(row["Valor"]);
                Cantidad = Convert.ToInt64(row["Cantidad"]);
                Ncuotas = Convert.ToInt64(row["Ncuotas"]);
                Iva = Convert.ToInt64(row["Iva"]);
                FdePago = Convert.ToDateTime(row["FdePago"]);
                PFinan = Convert.ToString(row["PFinan"]);
                //Proveedor = Convert.ToInt64(row["Proveedor"]);
                Abono = Convert.ToInt64(row["InitQuota"]);
                FVenta = Convert.ToDateTime(row["FVenta"]);
                NArticulo = row["NArticulo"].ToString();
                NProveedor = row["NProveedor"].ToString();
                //10-10-2013:LDiuza.SAO219856:2
                Financier = OpenSystems.Common.Util.OpenConvert.ToString(row["financier"]);
                OperatingUnit = OpenSystems.Common.Util.OpenConvert.ToString(row["sucursal"]);
                /* KCienfuegos RNP499 14-08-2014 */
                Pagare = Convert.ToInt64(row["nuPagare"]);
            }
            catch { }
        }
    }
}
