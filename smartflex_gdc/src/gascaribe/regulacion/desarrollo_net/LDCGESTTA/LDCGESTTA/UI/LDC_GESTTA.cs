using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using LDCGESTTA.Entities;
using LDCGESTTA.BL;
using LDCGESTTA.DAL;
using OpenSystems.Common.Util;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Collections;
using OpenSystems.Component.Framework;
using LDCGESTTA.Metodos;
using System.IO;


namespace LDCGESTTA.UI
{
    public partial class LDC_GESTTA : OpenForm
    {

        BLUtilities utilities = new BLUtilities();
        BLLDC_GESTTA blLDC_FCVC = new BLLDC_GESTTA();
        FileExcel file_Excel = new FileExcel();

        List<Keys> notValidKeys;

        private FolderBrowserDialog folderBrowserDialog1;
        private OpenFileDialog openFileDialog1;

        private RichTextBox richTextBox1;

        private MainMenu mainMenu1;
        private MenuItem fileMenuItem, openMenuItem;
        private MenuItem folderMenuItem, closeMenuItem;

        private string openFileName, folderName;

        private bool fileOpened = false;


        public LDC_GESTTA()
        {
            InitializeComponent();

            InitializeData();
        }


        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 24-04-2019  MiguelBallesteros      1 - creación   
        /// </changelog>
        public void InitializeData()
        {

            // se llena el combo de tipo de servicio
            setValueCbTipoServ();

            // se deshabilita el campo del codigo del proyecto
            tbCod_Proyect.Enabled = false;

        }


        /// <summary>
        /// Se establece la lista de valores para el combobox del tipo de servicio
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 06-02-2020  Miguel Ballesteros     1. Creación 
        private void setValueCbTipoServ()
        {

            String query = "select se.servcodi CODIGO, " +
                            " se.servdesc DESCRIPCION " +
                            " from servicio se where se.servcodi != -1" +
                            " order by CODIGO asc";


            DataTable dtListTipoServ = utilities.getListOfValue(query);
            cbTipoServicio.DataSource = dtListTipoServ;
            cbTipoServicio.ValueMember = "CODIGO";
            cbTipoServicio.DisplayMember = "DESCRIPCION";
        }


        /// <summary>
        /// Se definen teclas no válidas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void defineNotValidKeys()
        {
            notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);
        }


        /// <summary>
        /// Se limpian los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void CleanFields()
        {
            tbCod_Proyect.TextBoxValue = "";
            tbDesc_Proyect.TextBoxValue = "";
            tbObservacion.TextBoxValue = "";
            tbDocumento.TextBoxValue = "";
            cbDateValidInic.TextBoxValue = "";
            cbDateValidFin.TextBoxValue = "";
            cbTipoServicio.Text = "";
            cbEstad_Proyect.Value = "";
            cbNuevoEstado.Value = "";
            txtPath.Text = "";
        }


        #endregion



        /// <summary>
        /// metodo que se acciona cuando se le da click al check Actualizacion
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void ClickCheckActualiz(object sender, EventArgs e)
        {

            // se descheckea el flag Actualizacion
            if (chkActualizacion.Value == "Y")
            {
                // se limpian todos los labels y cajas de texto
                CleanFields();
                    
                chkNuevo.Value = "N";

                // se habilita el campo del codigo de proyecto
                tbCod_Proyect.Enabled = true;

                // se establece el combobox estado del proyecto en vacio
                cbEstad_Proyect.DataSource = null;

                // se resetea el combo de actividad
                cbNuevoEstado.DataSource = null;

                // se restablece la activaccion a los campos de archivo
                txtPath.Enabled = true;
                btnBrowse.Enabled = true;

                // se restablece el boton procesar
                btnProcesar.Enabled = true;
            }                
        }


        /// <summary>
        /// metodo que se acciona cuando se le da click al check Nuevo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void ClickCheckNuevo(object sender, EventArgs e)
        {
            if (chkNuevo.Value == "Y")
            {
                // se limpian todos los labels y cajas de texto
                CleanFields();

                // se descheckea el flag Actualizacion
                chkActualizacion.Value = "N";
                
                // se deshabilita el campo del codigo de proyecto
                tbCod_Proyect.Enabled = false;

                // se resetea el combo de actividad
                cbNuevoEstado.DataSource = null;

                // se establece el combobox estado del proyecto en 1
                cbEstad_Proyect.Value = 1;

                // se restablece la activaccion a los campos de archivo
                txtPath.Enabled = true;
                btnBrowse.Enabled = true;

                // se restablece el boton procesar
                btnProcesar.Enabled = true;
            }

        }



        public void cbNuevoEstado_Leave(object sender, EventArgs e)
        {
            if (Convert.ToInt64(cbNuevoEstado.Value) == 3 || Convert.ToInt64(cbNuevoEstado.Value) == 4)
            {
                // se inactiva el campo archivo
                txtPath.Enabled = false;
                btnBrowse.Enabled = false;
            }
            else
            {
                // se activa el campo archivo
                txtPath.Enabled = true;
                btnBrowse.Enabled = true;
            }
        }
        
        


        /// <summary>
        /// metodo que se acciona cuando se presiona TAB en el campo del codigo del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void tbProject_Leave(object sender, EventArgs e)
        {
            // se valida que el codigo del proyecto no este vacio//
            if (!String.IsNullOrEmpty(tbCod_Proyect.TextBoxValue))
            {
                // se trae la información del codigo del proyecto //
                Int64 nuCodProyecto = Convert.ToInt64(tbCod_Proyect.TextBoxValue);
                String sbDescProyecto;
                String osbObservacion;
                String osbDocumento;
                Int64 CodTipoServicio;
                Int64 onuErrorCode;
                String osbErrorMessage;
                String osbFechaIni;
                String osbFechaFin;

                blLDC_FCVC.GetInfoProyecto(nuCodProyecto, out sbDescProyecto, out CodTipoServicio, 
                                            out  osbObservacion, out osbDocumento,
                                            out osbFechaIni, out osbFechaFin,
                                            out onuErrorCode, out osbErrorMessage);

                if (onuErrorCode == 0)
                {
                    tbDesc_Proyect.TextBoxValue = sbDescProyecto;
                    tbObservacion.TextBoxValue = osbObservacion;
                    tbDocumento.TextBoxValue = osbDocumento;
                    cbDateValidInic.TextBoxValue = osbFechaIni;
                    cbDateValidFin.TextBoxValue = osbFechaFin;

                    // se consulta la descripcion del tipo de servicio
                    String query = "select se.servcodi CODIGO, " +
                                 " se.servdesc DESCRIPCION " +
                                 " from servicio se " +
                                 " where se.servcodi != -1" +
                                 " and se.servcodi = " + CodTipoServicio;

                    DataTable dtListTipoServ = utilities.getListOfValue(query);
                    cbTipoServicio.Value = dtListTipoServ.Rows[0]["CODIGO"].ToString();
                    cbTipoServicio.DataSource = dtListTipoServ;
                    cbTipoServicio.ValueMember = "CODIGO";
                    cbTipoServicio.DisplayMember = "DESCRIPCION";


                    // se resetea el combobox del tipo de servicio
                    cbNuevoEstado.DataSource = null;
                    cbNuevoEstado.Value = null;

                    // se vuelve a cargar el combo con la informacion de todos los tipos de servicios
                    setValueCbTipoServ();
                    
                    // se consulta el estado del proyecto
                    query = " select nvl(TA.PRTAESTA,1) CODIGO," +
                                   " decode( nvl(TA.PRTAESTA,1), 1, 'Registrado', 2, 'En aprobacion',3, 'Aprobado',5,'Inconsistente',4,'Anulado') DESCRIPCION " +
                                   " from TA_PROYTARI TA " +
                                   " where TA.PRTACONS = " + nuCodProyecto;

                    DataTable dtListEstadoProyect = utilities.getListOfValue(query);
                    cbEstad_Proyect.Value = dtListEstadoProyect.Rows[0]["CODIGO"].ToString();
                    cbEstad_Proyect.DataSource = dtListEstadoProyect;
                    cbEstad_Proyect.ValueMember = "CODIGO";
                    cbEstad_Proyect.DisplayMember = "DESCRIPCION";


                    // se llena el combo de actividades a realizar 
                    /*query = " SELECT DISTINCT p.acpeacti CODIGO,  A.acprdesc DESCRIPCION " +
                        " FROM   ta_actiperf p , " +
                                "   ta_actiproy A , " +
                                "   ta_perfusua pu , " +
                                "   ge_person pe ,  " +
                                "   ta_tranespr te " +
                        " WHERE A.acprcons = p.acpeacti " +
                                "   AND pu.peusperf = p.acpeperf " +
                                "   AND pe.user_id = pu.peususua " +
                                "   AND SYSDATE BETWEEN p.acpefein AND p.acpefefi " +
                                "   AND p.acpeserv = " + dtListTipoServ.Rows[0]["CODIGO"].ToString() +
                                "   AND pe.person_id = ge_bopersonal.fnuGetPersonId " +
                                "   AND te.tresesre = p.acpeesta " +
                                "   AND te.tresesre = " + dtListEstadoProyect.Rows[0]["CODIGO"].ToString() +
                                "   order by CODIGO asc";*/

                    query = "SELECT DISTINCT TE.TRESESAP CODIGO,  E.ESPRDESC DESCRIPCION " +
                                "FROM ta_actiperf p ," +
                                    "ta_actiproy A, " +
                                    "ta_perfusua pu," +
                                    "ge_person pe, " +
                                    "ta_tranespr te," +
                                    "TA_ESTAPROY E" +
                               " WHERE A.acprcons = p.acpeacti " +
                                " AND pu.peusperf = p.acpeperf " +
                                " AND pe.user_id = pu.peususua " +
                                " AND te.tresesre = p.acpeesta " +
                                " AND te.TRESESAP = E.ESPRCONS " +
                                " AND SYSDATE BETWEEN p.acpefein AND p.acpefefi " +
                                " AND p.acpeserv = " + dtListTipoServ.Rows[0]["CODIGO"].ToString() +
                                " AND pe.person_id = ge_bopersonal.fnuGetPersonId " +
                                " AND te.tresesre = " + dtListEstadoProyect.Rows[0]["CODIGO"].ToString() +
                                " ORDER BY te.TRESESAP";

                    DataTable dtListActReali = utilities.getListOfValue(query);
                    cbNuevoEstado.DataSource = dtListActReali;
                    cbNuevoEstado.ValueMember = "CODIGO";
                    cbNuevoEstado.DisplayMember = "DESCRIPCION";

                    btnProcesar.Enabled = true;
                    // se activa el campo archivo
                    txtPath.Enabled = true;
                    btnBrowse.Enabled = true;

                    // se realiza el proceso de inactivacion del campo "Archivo" si el flag es actualizacion y el estado
                    // del proyecto es 3 o 4
                    if (chkActualizacion.Value == "Y" && (Convert.ToInt64(cbEstad_Proyect.Value) == 3 || Convert.ToInt64(cbEstad_Proyect.Value) == 4))
                    {
                        btnProcesar.Enabled = false;
                    }

                }
                else
                {
                    utilities.DisplayErrorMessage(onuErrorCode + " " + osbErrorMessage);
                    // se limpian todos los labels y cajas de texto
                    CleanFields();
                }
            }
            else
            {
                utilities.DisplayErrorMessage("Debe ingresar el codigo del Proyecto!!");
            }


        }
       

        #region ButtonsActions

        /// <summary>
        /// Permite navegar dentro del explorador
        /// </summary>
        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if (opnFileDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtPath.Text = opnFileDialog.FileName;
            }
        }

  
        /// <summary>
        /// Acción del boton aceptar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnGenPlatilla_Click(object sender, EventArgs e)
        {

            if (cbTipoServicio.Value == null)
            {
                utilities.DisplayErrorMessage("Debe ingresar el tipo de Servicio!!");
            }
            else 
            {

                Int64 nuTipoServ = Convert.ToInt64(cbTipoServicio.Value.ToString());
                Int64 onuErrorCode;
                String osbErrorMessage;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
         
                DataTable BasicDataTarifas = DALDC_GESTTA.GetInfoTarifa(nuTipoServ, out onuErrorCode, out osbErrorMessage);

                if(onuErrorCode == 0)
                {

                    file_Excel.CrearExcel(BasicDataTarifas);
                    // se limpian todos los labels y cajas de texto
                    CleanFields();
                }
                else
                {
                    utilities.DisplayErrorMessage(onuErrorCode + " " + osbErrorMessage);
                    // se limpian todos los labels y cajas de texto
                    CleanFields();
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
     
            }

        }



        /// <summary>
        /// Acción del boton procesar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnProcesar_Click(object sender, EventArgs e)
        {
             int gvalResult = 0; /*0 - Indica que el proceso fue exitoso, -1 - Indica que hubo error en alguna de las lineas*/
             string sbPath = txtPath.Text;
             

             // se valida que por lo menos haya un flag chekeado
             if (chkActualizacion.Value == "Y" || chkNuevo.Value == "Y")
             {  
                 Int64 CodProyecto = -1;
                 Int64 CodActRealizar = -1;
                 Boolean swActualizacion = false;
                 Int64 onuErrorCode = 0;
                 String osbErrorMessage = "";
                 Int64 OnuCodProyecto = 0;

                 // se convierten en los formatos correspondientes los datos obtenidos de los campos de la forma
                 String sbDescProyecto =        Convert.ToString(tbDesc_Proyect.TextBoxValue);
                 Int64 CodTipoServicio =        Convert.ToInt64(cbTipoServicio.Value);
                 Int64 CodEstProyecto =         Convert.ToInt64(cbEstad_Proyect.Value);
                 String sbObservacion =         Convert.ToString(tbObservacion.TextBoxValue);
                 String sbDocumento =           Convert.ToString(tbDocumento.TextBoxValue);
                 DateTime FechaIni =            Convert.ToDateTime(cbDateValidInic.TextBoxValue);
                 DateTime FechaFin =            Convert.ToDateTime(cbDateValidFin.TextBoxValue);
                 DateTime fechaActual =         DateTime.Now; // fecha actual

                 if (chkActualizacion.Value == "Y")
                 {
                     swActualizacion = true;

                     if (tbCod_Proyect.TextBoxValue == null)
                     {
                         utilities.DisplayErrorMessage("Debe ingresar el codigo del proyecto !!");
                         return;
                     }

                     if (cbNuevoEstado.Value == null)
                     {
                         utilities.DisplayErrorMessage("Debe ingresar el Nuevo Estado !!");
                         return;
                     }

                     CodProyecto = Convert.ToInt64(tbCod_Proyect.TextBoxValue);
                     CodActRealizar = Convert.ToInt64(cbNuevoEstado.Value);

                 }

                 // se validan los datos //
                 if (String.IsNullOrEmpty(tbDesc_Proyect.TextBoxValue))
                 {
                     utilities.DisplayErrorMessage("Debe ingresar la descripcion del proyecto !!");
                     return;
                 }

                 if (String.IsNullOrEmpty(tbObservacion.TextBoxValue))
                 {
                     utilities.DisplayErrorMessage("Debe ingresar la Observación del proyecto !!");
                     return;
                 }

                 if (String.IsNullOrEmpty(tbDocumento.TextBoxValue))
                 {
                     utilities.DisplayErrorMessage("Debe ingresar el Documento del proyecto !!");
                     return;
                 }

                 if (String.IsNullOrEmpty(cbDateValidInic.TextBoxValue))
                 {
                     utilities.DisplayErrorMessage("Debe ingresar la fecha de inicio de la ejecución !!");
                     return;
                 }

                 if (String.IsNullOrEmpty(cbDateValidFin.TextBoxValue))
                 {
                     utilities.DisplayErrorMessage("Debe ingresar la fecha fin de la ejecución!!");
                     return;
                 }

                 if (cbTipoServicio.Value == null)
                 {
                     utilities.DisplayErrorMessage("Debe ingresar el Tipo de Servicio !!");
                     return;
                 }

                 if (cbEstad_Proyect.Value == null)
                 {
                     utilities.DisplayErrorMessage("Debe ingresar el estado del proyecto !!");
                     return;
                 }

                 if (FechaFin < FechaIni)
                 {
                     utilities.DisplayErrorMessage("La fecha final debe ser mayor o igual a la fecha inicial");
                     return;
                 }

                /* if (FechaIni > fechaActual)
                 {
                     utilities.DisplayErrorMessage("La fecha inicial no puede ser mayor a la fecha actual");
                     return;
                 }*/

                /* if (FechaFin > fechaActual)
                 {
                     utilities.DisplayErrorMessage("La fecha final no puede ser mayor a la fecha actual");
                     return;
                 }*/
  
                 
                 // se valida si el check esta activado en actualizacion y si el estado del proyecto es 3 y 4
               /*  if (swActualizacion && (Convert.ToInt64(cbEstad_Proyect.Value) == 3 || Convert.ToInt64(cbEstad_Proyect.Value) == 4))
                 {
                     //solo se procesa la tarifa y no se lee el archivo de excel
                     blLDC_FCVC.ProcesaTarifas(CodProyecto, sbDescProyecto, CodTipoServicio, CodEstProyecto, sbObservacion, sbDocumento,
                                             CodActRealizar, FechaIni, FechaFin, out  OnuCodProyecto, out onuErrorCode, out osbErrorMessage);

                     if (onuErrorCode == 0)
                     {
                         MessageBox.Show("Se hizo el proceso de tarifas de forma correcta ");
                     }
                     else
                     {
                         utilities.DisplayErrorMessage("Error al procesar tarifa "+onuErrorCode + " " + osbErrorMessage);
                     }

                 }
                 else
                 {*/

                 if (sbPath == "" && Convert.ToInt64(cbEstad_Proyect.Value) == 1 && CodProyecto == -1)
                     {
                         utilities.DisplayErrorMessage("Error!! Debe seleccionar un archivo.");
                     }
                     else
                     {

                         // Proceso para establecer el nombre del TXT
                         // se obtiene la ruta completa
                         
                         string fileName = @sbPath;
                         string firstPart = "";
                         string secondPart = "";
                         Int64 ValMensajeError = 0;
                         System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                         if (sbPath != "")
                         {
                         // se hace la division de la cadena de la ruta, para solo obtener la ruta sin el nombre archivo de excel
                         int lastIndex = fileName.LastIndexOf('\\');
                         if (lastIndex + 1 < fileName.Length)
                         {
                             firstPart = fileName.Substring(0, lastIndex);
                             secondPart = fileName.Substring(lastIndex + 1);

                             secondPart = secondPart.Remove(secondPart.IndexOf('.'));

                             // se establece el nombre que tendra el archivo
                             fileName = firstPart + "\\Log_" + secondPart + ".txt";
                         }

                        
                         
                             // se llama al metodo que lee el archivo de excel//
                             ValMensajeError = file_Excel.ReadExcel(sbPath, fileName, CodProyecto, CodTipoServicio);

                         }
                        
                         if (ValMensajeError == 0)
                         {

                             // se llama al proceso
                             blLDC_FCVC.ProcesaTarifas(CodProyecto, sbDescProyecto, CodTipoServicio, CodEstProyecto, sbObservacion, sbDocumento,
                                                     CodActRealizar, FechaIni, FechaFin, out  OnuCodProyecto, out onuErrorCode, out osbErrorMessage);

                             if (onuErrorCode == 0)
                             {
                                 utilities.doCommit();
                                 if (OnuCodProyecto != 0 ){
                                     utilities.DisplayInfoMessage("Proceso termino correctamente, se genero proyecto de tarifa [" + OnuCodProyecto+ "]");
                                 }else{
                                     utilities.DisplayInfoMessage("Proceso termino correctamente!!!");
                                 }

                                 // se limpian todos los labels y cajas de texto
                                 CleanFields();
                             }
                             else
                             {
                                 utilities.DisplayErrorMessage("Error al procesar tarifa ["+ osbErrorMessage+"]");
                                 utilities.doRollback();
                                 // se limpian todos los labels y cajas de texto
                                 CleanFields();
                             }

                         }
                         else
                         {
                             utilities.DisplayErrorMessage("Error!!Existen Inconsistencias al procesar el Excel, \n" +
                                                             "Validar el archivo de LOG = " + "LOG_" + secondPart + ".txt \n" +
                                                             "Generado en la ruta = " + firstPart);
                             utilities.doRollback();
                             // se limpian todos los labels y cajas de texto
                             CleanFields();
                         }
                         System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                     }
                // }
                 
             }
             else
             {
                  utilities.DisplayErrorMessage("Debe chekear por lo menos un flag (Actualizacion o Nuevo)");
             }

        }


        #endregion


    }
}
