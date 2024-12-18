#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Gases del Caribe (c).                                                  
 *===========================================================================================================
 * Unidad        : LDSEMAIL
 * Descripción   : Ejecutable encargado de enviar los cupones por correo
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ============    ======================================================================
 * 23-09-2020   505     Horbath          Creación     
 * 24-06-2020   684     Horbath          Se ajusta para que se tenga en cuenta el tipo de impresion de la solicitud
 * =========================================================================================================*/
#endregion Documentación
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;
using System.IO;
using System.Text.RegularExpressions;
using OpenSystems.Common.Util;

namespace LDSEMAIL
{
    public partial class LDSEMAIL : OpenForm
    {
        DataTable dtCupon = new DataTable();
        Int64 gnuTipoSol;
        
        public LDSEMAIL(Int64 inuContractId)
        {
            InitializeComponent();
            //Se establece tamaño minimo
            this.MinimumSize = new Size(899, 491);
            //this.lblContrato.Text = "Contrato: " + inuContractId;
            this.LoadData();

            this.txtContrato.Text = inuContractId.ToString();
        }
        private void LoadData()
        {
            // Se cargan las unidades de trabajo
            List<string> lstItems = new List<string>();
            DataSet _dsLOV = getDataLOV();

            foreach (DataRow row in _dsLOV.Tables[0].Rows)
            {
                lstItems.Add(row["ID"] + " - " + row["DESCRIPTION"]);
            }

            this.cmbTipoSoli.DataSource = lstItems;
        }

        // Obtiene las unidades de trabajo de la pesona conectada
        internal static DataSet getDataLOV()
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BoLDSEMAIL.GetLOVPackType"))
                {
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            string sbValorSelec = this.cmbTipoSoli.Text;
            this.dtCupon.Clear();
            Int64 nuTipoImpre;
            if (sbValorSelec == "")
            {
                ExceptionHandler.EvaluateErrorCode(2741, "Debe seleccionar un tipo de solicitud.");                
            }

            string sbTipoSoli = sbValorSelec.Split(new[] { " - " }, StringSplitOptions.None)[0];
            this.gnuTipoSol = Convert.ToInt64(sbTipoSoli);

            //Se obtiene el tipo de impresion
            nuTipoImpre = fnuGetTipoImpresion(this.gnuTipoSol);

            // Se cargan los cupones
            DataSet _dsCupones = getCuponesByCont(Convert.ToInt64(this.txtContrato.Text), this.gnuTipoSol, nuTipoImpre);
            Int64 number = dtCupon.Columns.IndexOf("Cupon");
            if (dtCupon.Columns.IndexOf("Cupon") < 0)
            {
                dtCupon.Columns.Add("Cupon");
                dtCupon.Columns.Add("Fecha de registro");
                dtCupon.Columns.Add("Valor");
                dtCupon.Columns.Add("Tipo de cupón");
                dtCupon.Columns.Add("Contrato");
                dtCupon.Columns.Add("Documento de soporte");
            }
         

            foreach (DataRow row in _dsCupones.Tables[0].Rows)
            {
                DataRow rowdg = dtCupon.NewRow();
                rowdg["Cupon"] = row["CUPONUME"];
                rowdg["Fecha de registro"] = row["FECHA_REGISTRO"].ToString();
                rowdg["Valor"] = row["VALOR"];
                rowdg["Tipo de cupón"] = row["TIPO_CUPON"].ToString();
                rowdg["Contrato"] = row["CONTRATO"];
                rowdg["Documento de soporte"] = row["DOCUMENTO_SOPORTE"].ToString();

                dtCupon.Rows.Add(rowdg);
            }

            this.dgvCupones.DataSource = dtCupon;

            this.dgvCupones.Columns["Cupon"].ReadOnly = true;
            this.dgvCupones.Columns["Cupon"].Width = 100;
            this.dgvCupones.Columns["Fecha de registro"].ReadOnly = true;
            this.dgvCupones.Columns["Fecha de registro"].Width = 150;
            this.dgvCupones.Columns["Valor"].ReadOnly = true;
            this.dgvCupones.Columns["Valor"].Width = 100;
            this.dgvCupones.Columns["Valor"].DefaultCellStyle.Format = "N2";
            this.dgvCupones.Columns["Tipo de cupón"].ReadOnly = true;
            this.dgvCupones.Columns["Tipo de cupón"].Width = 120;
            this.dgvCupones.Columns["Contrato"].ReadOnly = true;
            this.dgvCupones.Columns["Contrato"].Width = 100;
            this.dgvCupones.Columns["Documento de soporte"].ReadOnly = true;
            this.dgvCupones.Columns["Documento de soporte"].Width = 170;

        }

        // Obtiene las unidades de trabajo de la pesona conectada
        internal static DataSet getCuponesByCont(Int64 nuContrato, Int64 nuPackaType, Int64 nuTipoImp)
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BoLDSEMAIL.GetCuponByCont"))
                {
                    OpenDataBase.db.AddInParameter(dbCommand, "inuSubscripId", DbType.Int64, nuContrato);
                    OpenDataBase.db.AddInParameter(dbCommand, "inuPackType", DbType.Int64, nuPackaType);
                    OpenDataBase.db.AddInParameter(dbCommand, "inuTipoImpre", DbType.Int64, nuTipoImp);
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            this.dgvCupones.DataSource = null;
            this.txtCorreo.Text = "";
        }

        private void btnProcesar_Click(object sender, EventArgs e)
        {
            string sbCorreo = this.txtCorreo.Text;
            string sbNameFile = null;
            Int64 nuTipoImpre;

            if (sbCorreo == "")
            {
                ExceptionHandler.EvaluateErrorCode(2741, "Debe digitar el correo electrónico");   
            }

            if (!blValidaCorreo(sbCorreo))
            {
                ExceptionHandler.EvaluateErrorCode(2741, "La dirección de correo no es válida."); 
            }

            Int64 nuCuponId = Convert.ToInt64(this.dgvCupones.CurrentRow.Cells["Cupon"].Value.ToString());
            string sbDocument = this.dgvCupones.CurrentRow.Cells["Documento de soporte"].Value.ToString();

            //Se obtiene el tipo de impresion
            nuTipoImpre = fnuGetTipoImpresion(this.gnuTipoSol);

            //Dependiendo del tipo de solicitud, se busca con el cupon o el documento de soporte
            if (this.gnuTipoSol == 100006)
            {
                sbNameFile = sbDocument;
            }
            else if (this.gnuTipoSol == 279)
            {
                sbNameFile = "Document";
            }
            else
            {
                sbNameFile = nuCuponId.ToString();
            }

            //Si el tipo de impresion es 3 se imprime el cupon y se continua
            if (nuTipoImpre == 3)
            {
                this.imprimeCupon(nuCuponId); 
            }

            //Se llama al servicio que guarda en la base de datos
            this.uploadFileBlob(nuCuponId, sbNameFile, sbCorreo);

            //Se envia correo
            this.enviaCorreo(nuCuponId, nuTipoImpre);

            //
            this.mensajeInformativo("Correo enviado con éxito.");

            this.Close();
        }

        // Se genera el cupon
        private void imprimeCupon(Int64 inuCupon)
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOCouponPrinting.PrintCouponNet"))
                {

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuCupon", DbType.Int64, inuCupon);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        // Obtiene el tipo de impresion de la solicitud
        private Int64 fnuGetTipoImpresion(Int64 inuTipoSoli)
        {
            Int64 nuTipoImp;
            try
            {                
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BoLDSEMAIL.GetTipoImpByTipoSoli"))
                {

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuPackType", DbType.Int64, inuTipoSoli);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuTipoImpre", DbType.Int64, 1000);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    nuTipoImp = (Int64)OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuTipoImpre"));
                }
            }
            catch (Exception)
            {
                throw;
            }
            return nuTipoImp;
        }

        private void uploadFileBlob(Int64 inuCupon, string isbNameFile, string sbCorreo)
        {
            string net_base = Path.GetTempFileName();
            string[] sbPaths = net_base.Split('\\');
            string sbExtension = null;
            string nuevaRuta = null;
            

            sbExtension = sbPaths[sbPaths.Length - 1];

            for (int i = 0; i < sbPaths.Length - 1; i++)
            {
                nuevaRuta = nuevaRuta + "\\" + sbPaths[i];
            }

            if (this.gnuTipoSol == 279)
            {
                nuevaRuta = nuevaRuta + "\\" + isbNameFile + ".html";
            }
            else
            {
                nuevaRuta = nuevaRuta + "\\" + isbNameFile + ".pdf";
            }           

            nuevaRuta = nuevaRuta.Substring(1, nuevaRuta.Length - 1); 
            
            try
            {
                if (!File.Exists(nuevaRuta))
                {
                    ExceptionHandler.EvaluateErrorCode(2741, "No se ha generado el cupón. Por favor genere el proceso y vuelva a consultar.");
                }

                byte[] AsBytes = File.ReadAllBytes(nuevaRuta);
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BoLDSEMAIL.pSaveFile"))
                {

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuCuponId", DbType.Int64, inuCupon);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbNameFile", DbType.String, isbNameFile);
                    OpenDataBase.db.AddInParameter(cmdCommand, "iblFile", DbType.Binary, AsBytes);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbCorreo", DbType.String, sbCorreo);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, this.gnuTipoSol);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                }
            }
            catch (Exception)
            {
                throw;
            }            
        }

        private void enviaCorreo(Int64 inuCupon, Int64 inuTipoImpre)
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BoLDSEMAIL.pEnvioCorreo"))
                {

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuCuponId", DbType.Int64, inuCupon);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoImpre", DbType.Int64, inuTipoImpre);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        private Boolean blValidaCorreo(String sbEmail)
        {
            String sbExpresion = "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";

            if (Regex.IsMatch(sbEmail, sbExpresion))
            {
                if (Regex.Replace(sbEmail, sbExpresion, String.Empty).Length == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public void mensajeInformativo(String mesagge)
        {

            //ExceptionHandler.DisplayMessage(mesagge.Length, mesagge, System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Information);
            ExceptionHandler.DisplayMessage(16, mesagge, System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Information);
        }          
    }
}
