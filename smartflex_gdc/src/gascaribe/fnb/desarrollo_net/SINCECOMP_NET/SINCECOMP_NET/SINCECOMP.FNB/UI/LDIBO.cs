#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : LDIBO
 * Descripcion   : Forma de impresión bin/ean
 * Autor         : 
 * Fecha         : 
 *
 * Fecha           SAO                  Autor           Modificación
 * ===========    ======           ==============    =====================================================================
 * 11/01/2017     CASO 200-850     Jorge Valiente     Se realizara el paso del desarrollo de CENCOSUD al desarrollo del CASO 200-854
 *                                                    esto con el fin de unificar el desarrollo de CENCOSUD con PAGARE UNICO.
 * 16-07-2013     217145           acanizales         1 - Se crean los métodos <genEANExito><GenerateDocument>
 *                                                    2 - Se módifica el método <genBINOlimpica> para que llame a <GenerateDocument>
 * 13-Sep-2013    212611           lfernandez         1 - <genBINOlimpica> Se adiciona método y se pasa la lógica de 
 *                                                        generarBIN a este, se adiciona dataTable para el código de barras
 *                                                    2 - <generarBIN> Se pasa lógica a genBINOlimpica
 *                                                    3 - <getSupplier> Se adiciona para obtener el proveedor a partir de la orden
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//
using OpenSystems.Windows.Controls;
using Microsoft.Reporting.WinForms;
using System.IO;
using System.Diagnostics;
using System.Data.Common;
using OpenSystems.Common.Data;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.ExtractAndMix.Api;
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.BL;
using OpenSystems.Common.Util;
using OpenSystems.Report;

namespace SINCECOMP.FNB.UI
{
    public partial class LDIBO : OpenForm
    {
        private long packageId;
        private static BLFIFAP _blFIFAP = new BLFIFAP();
        private BLGENERAL general = new BLGENERAL();

        public LDIBO()
        {
            InitializeComponent();
        }

        /**
         * Constructor utilizado cuando se llama la forma a nivel de solicitud.
         * vhurtadoSAO212591
         */
        public LDIBO(long packageId)
            : this()
        {
            tbnumberSecuence.TextBoxValue = general.getConsecutiveByPackage(Convert.ToString(packageId));
            tbnumberSecuence.Enabled = false;
            this.packageId = packageId;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            Int64? supplier = null;
            String order;
            String package_id;

            

            if (String.IsNullOrEmpty(tbnumberSecuence.TextBoxValue))
            {
                general.mensajeERROR("Debe digitar un Consecutivo de Venta");
            }
            else
            {
                
                if (tbnumberSecuence.Enabled)
                {
                    package_id = general.getPackageByConsecutive(tbnumberSecuence.TextBoxValue);
                }
                else
                {// si no esta activo es porque se esta ejecutando desde una solicitud
                    package_id = Convert.ToString(this.packageId);
                }

                if(String.IsNullOrEmpty(package_id))
                {
                    general.mensajeERROR("No se ingreso Consecutivo Valido");
                    return;
                }

                order = DALLDBINEOLIMPICA.FrfGetOrderEntBinEan(package_id);
                supplier = getSupplier(order);

                if (supplier == null)
                {
                    return;
                }

                //  Si el proveedor es olimpica
                if (_blFIFAP.isProvOlimpica(supplier))
                {
                    genBINOlimpica(order);
                }
                else if (_blFIFAP.isProvExito(supplier))
                {
                    genEANExito(order);
                }
                //CASO 200-850
                else if (_blFIFAP.isProvCENCOSUD(supplier))
                {
                    genEANCENCOSUD(order);
                }
                //CASO 200-850
                else
                {
                    general.mensajeERROR("El consecutivo ingresado no corresponde a una venta de una gran superficie");
                }

            }
        }

        //vhurtadoSAO212016: Se extrae esto como método de btnGenerar_Click. Se llama desde FIFAP 
        //vhurtadoSAO212016: Se anula cambio.
        public void generarBIN(String package_id)
        {
            String order = DALLDBINEOLIMPICA.FrfGetOrderEnt(package_id);

            genBINOlimpica(order);
        }

        /// <summary>
        /// Genera el bin de olimpica
        /// </summary>
        /// <param name="order"></param>
        private void genBINOlimpica(String order)
        {
            //  Obtiene los datos a partir de la orden
            DataSet data = DALLDBINEOLIMPICA.FtrfBineOlimpica(order);

            // genera documento
            this.GenerateDocument(order, data);
        }

        /// <summary>
        /// Obtiene la plantilla a partir del parámetro
        /// </summary>
        /// <returns>la primer plantilla que encuentra, null sino encuentra nada</returns>
        private Byte[] GetTemplate(String order)
        {
            String criteria;
            String method;
            DataSet data;
            String template;
            DataRow row;

            // Intenta obtener la plantilla
            try
            {
                method = "dald_suppli_settings.frfGetRecords";

                criteria = "supplier_id in " +
                    "(  SELECT  ou.contractor_id " +
                    "   FROM    or_order o, or_operating_unit ou " +
                    "   WHERE   o.operating_unit_id = ou.operating_unit_id " +
                    "   AND     ORDER_id = " + order +
                    ")";

                using (DbCommand cmd = OpenDataBase.db.GetStoredProcCommand(method))
                {
                    OpenDataBase.db.AddInParameter(cmd, "isbCriteria", DbType.String, criteria);
                    OpenDataBase.db.AddReturnRefCursor(cmd);
                    data = OpenDataBase.db.ExecuteDataSet(cmd);
                }

                row = data.Tables[0].Rows[0];
                template = row["SALE_NAME_REPORT"].ToString();

                method = "daed_plantill.frfGetRecords";
                criteria = "plannomb = '" + template + "'";

                using (DbCommand cmd = OpenDataBase.db.GetStoredProcCommand(method))
                {
                    OpenDataBase.db.AddInParameter(cmd, "isbCriteria", DbType.String, criteria);
                    OpenDataBase.db.AddReturnRefCursor(cmd);
                    data = OpenDataBase.db.ExecuteDataSet(cmd);
                }

                row = data.Tables[0].Rows[0];
                return (Byte[])row["PLANCONT"];

            }
            catch
            {
                String[] args = new String[] { "No existe reporte configurado para la impresión de la orden" };
                ExceptionHandler.Raise(2741, args);
            }
            return null;
        }

        private long? getSupplier(String order)
        {
            const String method = "daor_operating_unit.frfGetRecords";
            String criteria;
            DataSet data;
            DataRow row;
            Int64? supplierId = null; ;

            if (!String.IsNullOrEmpty(order))
            {
                criteria = "operating_unit_id in " +
                    "(  SELECT  operating_unit_id " +
                    "   FROM    OR_order " +
                    "   WHERE   ORDER_id = " + order +
                    " )";

                using (DbCommand cmd = OpenDataBase.db.GetStoredProcCommand(method))
                {
                    OpenDataBase.db.AddInParameter(cmd, "isbCriteria", DbType.String, criteria);
                    OpenDataBase.db.AddReturnRefCursor(cmd);
                    data = OpenDataBase.db.ExecuteDataSet(cmd);
                }




                if (data.Tables[0].Rows.Count > 0)
                {
                    row = data.Tables[0].Rows[0];
                    supplierId = OpenConvert.ToLongNullable(row["CONTRACTOR_ID"]);
                }

            }
            if (supplierId == null)
            {
                general.mensajeERROR("No se encontró Proveedor asociado a la orden " + order);
                return null;
            }
            
            return supplierId;
        }

        /// <summary>
        /// ´Genera Bin del exito
        /// </summary>
        /// <param name="order"></param>
        private void genEANExito(String order)
        {
            //  Obtiene los datos a partir de la orden
            DataSet data = DALLdConventExito.FtrfBineExito(order);

            // genera documento
            this.GenerateDocument(order, data);
        }

        //CASO 200-850
        /// <summary>
        /// ´Genera Bin del exito
        /// </summary>
        /// <param name="order"></param>
        private void genEANCENCOSUD(String order)
        {
            //  Obtiene los datos a partir de la orden
            DataSet data = DALBINCENCOSUD.FtrfBineCENCOSUD(order);

            // genera documento
            this.GenerateDocument(order, data);
        }
        //CASO 200-850

        /// <summary>
        /// Genera documento .pdf
        /// </summary>
        /// <param name="order">Id de la orden</param>
        /// <param name="data">Información a mostrar</param>
        /// <param name="exito">Información a mostrar</param>
        private void GenerateDocument(String order, DataSet data)
        {
            String report;
            LocalReport localReport = new LocalReport();
            ReportDataSource datasrc;
            String mime, enc, ext;
            String[] streams;
            Warning[] ws;
            String fileName = "LDIBO_" + order + ".pdf";
            String filePath = Path.GetTempPath() + @"\" + fileName;
            Byte[] reportByte = GetTemplate(order);

            report = Encoding.UTF8.GetString(reportByte, 0, reportByte.Length);

            localReport.LoadReportDefinition(new StringReader(report));


            if (data.Tables.Count == 0)
            {
                general.mensajeERROR("No se obtuvieron datos para la generación del reporte");
                return;
            }
            //  Si no obtuvo datos
            if (data.Tables[0].Rows.Count == 0)
            {
                general.mensajeERROR("No se obtuvieron datos para la generación del reporte");
                return;
            }

            //  Adiciona la tabla para el código de barras
            data.Tables.Add("EXTRA_BARCODE_");
            //  Adiciona la columna donde está el valor del código de barras
            data.Tables["EXTRA_BARCODE_"].Columns.Add("CODE");

            //  Adiciona la fila del código de barras
            data.Tables["EXTRA_BARCODE_"].Rows.Add(data.Tables["BineOlimpica"].Rows[0]["CodigoBarras"]);

            //  Obtiene el listado de DataSources
            IList<string> names = localReport.GetDataSourceNames();

            //  Le asigna a cada DataSource los datos correspondientes
            foreach (String name in names)
            {
                datasrc = OpenReportViewer.ProcessEspecialTable(data.Tables[name], name);
                localReport.DataSources.Add(datasrc);
            }

            byte[] bytes = localReport.Render("PDF", null, out mime, out enc, out ext, out streams, out ws);

            using (FileStream fs = new FileStream(filePath, FileMode.Create))
            {
                fs.Write(bytes, 0, bytes.Length);
                fs.Flush();
                fs.Close();
            }

            //  Abre el pdf
            MainApi.ShowFile(filePath);
        }

    }
}