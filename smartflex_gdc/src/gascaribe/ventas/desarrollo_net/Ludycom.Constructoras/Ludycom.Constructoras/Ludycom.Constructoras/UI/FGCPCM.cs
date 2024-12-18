using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.IO;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;

using iTextSharp.text;
using iTextSharp.text.pdf;

namespace Ludycom.Constructoras.UI
{
    public partial class FGCPCM : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFGCPCM blFGCPCM = new BLFGCPCM();

        private bool pendingChanges = false;
        

        public FGCPCM()
        {
            InitializeComponent();
            cargarLista();
            //InitializeData(project);
        }

        public void cargarLista()
        {
            //Se carga la lista de tipos de trabajo de instalación interna
            DataTable dtProyectos = utilities.getListOfValue(BLGeneralQueries.strProyectos);

            cbx_proyecto.DataSource = dtProyectos;
            cbx_proyecto.ValueMember = "CODIGO";
            cbx_proyecto.DisplayMember = "DESCRIPCION";
        }

               /// <summary>
        /// Método para cancelar cancelar/cerrar la aplicación
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (pendingChanges)
            {
                DialogResult continueCancelling = ExceptionHandler.DisplayMessage(
                                    2741,
                                    "No han guardado todos los cambios. Desea cerrar la aplicación sin guardar los cambios?",
                                    MessageBoxButtons.YesNo,
                                    MessageBoxIcon.Question);

                if (continueCancelling == DialogResult.No)
                {
                    return;
                }
            }

            this.Close();
        }

        /// <summary>
        /// Método para generar el cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
      /*  private void btnGenerateCupon_Click(object sender, EventArgs e)
        {
            Int64? nuCupon;
            if (currentMonthlyFee!=null)
	        {
                try 
	            {	
                    //Se genera el cupón
		            nuCupon = blFGCPC.GenerateCupon(nuProjectId, currentMonthlyFee);

                    if (nuCupon!=null)
	                {
		                utilities.DisplayInfoMessage("Cupón generado exitosamente: ["+nuCupon+"]");
                        utilities.doCommit();

                        //Se cargan las cuotas actualizadas
                        LoadMonthlyFee(nuProjectId);
	                }
	            }
	            catch (Exception ex)
	            {
		            utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
	            }
	        }
        }*/

        /// <summary>
        /// Método para imprimir el cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnPrintCupon_Click(object sender, EventArgs e)
        {
            //validacion de la carpeta destino de los cupones
            if (String.IsNullOrEmpty(txt_ruta.TextBoxValue))
            {
                blFGCPCM.mensajeERROR("Debe seleccionar la Carpeta donde se guadaran los Cupones");
                btn_buscar.Focus();
            }
            else
            {
                String path = "";
                String ruta = "";
                Boolean sw = false;
                try
                {
                    path = txt_ruta.TextBoxValue + @"\C%P03$";
                    String namePdf = txt_ruta.TextBoxValue + @"\Cupones_00.pdf";
                    if (chk_PrintUnico.Checked == true)
                    {
                        NewFolderHidden(path);
                        ruta = path;
                    }
                    else
                    {
                        ruta = txt_ruta.TextBoxValue;
                    }

                    Int64 proyecto;
                    DateTime fecha;

                    foreach (Infragistics.Win.UltraWinGrid.UltraGridRow fila in ugMonthlyFeeM.Rows)
                    {
                        //validad el selector
                        if (fila.Cells[0].Value.ToString() == "True")
                        {
                            proyecto = Int64.Parse(fila.Cells[7].Value.ToString());
                            fecha = DateTime.Parse(fila.Cells[5].Value.ToString());
                            //validad si existe numero de cupon 
                            if (fila.Cells[1].Value.ToString() == null || Int64.Parse(fila.Cells[1].Value.ToString()) == 0)
                            {

                                
                                Int64? nuCupon;
                                //Int64 consecutivo = Int64.Parse(fila.Cells[1].Value.ToString());
                                //validad consecutivo es diferente de null 
                                if (fila.Cells[2].Value.ToString() != null)
                                {
                                    try
                                    {
                                        //Se genera el cupón
                                        nuCupon = blFGCPCM.GenerateCupon(Int64.Parse(fila.Cells[7].Value.ToString()), Int64.Parse(fila.Cells[2].Value.ToString()));

                                        if (nuCupon != null)
                                        {
                                            // utilities.DisplayInfoMessage("Cupón generado exitosamente: [" + nuCupon + "]");
                                           //  utilities.doCommit();

                                             //MessageBox.Show(nuCupon.ToString());
                                            //creo el cupon
                                            GeneraImpresion(Int64.Parse(nuCupon.ToString()), fecha, proyecto, ruta);
                                            //Se cargan las cuotas actualizadas
                                            //LoadMonthlyFee(nuProjectId);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        utilities.doRollback();
                                        GlobalExceptionProcessing.ShowErrorException(ex);
                                    }
                                }


                            }
                            else
                            {
                               // MessageBox.Show(fila.Cells[6].Value.ToString());
                                GeneraImpresion(Int64.Parse(fila.Cells[1].Value.ToString()),fecha, proyecto, ruta);
                            }
                        }
                    }
                    if (chk_PrintUnico.Checked == true)
                    {
                        CreateMergedPDF(namePdf, path);
                        if (System.IO.Directory.Exists(path))
                        {
                            deleteFolder(path);
                        }
                    }

                    sw = true;
                }
                catch (Exception error)
                {
                    utilities.doRollback();
                    //se dispara al haber un error en el proceso
                    blFGCPCM.mensajeERROR("Hubo errores al Generar los Cupones.\n" + error.ToString());
                }
                finally
                {
                    //valido si finalizo el proceso de creacion sin errores
                    if (sw)
                    {
                        blFGCPCM.mensajeOk("Cupones Guardados en la Ruta Indicada");
                        utilities.doCommit();
                        Limpiar();
                    }
                }
            }
        }

        private void GeneraImpresion(Int64 cupon, DateTime fecha, Int64? proyecto , String ruta )
        {

            String[] tipos = { "Int64","DateTime", "Int64" ,"String" };
            String[] campos = { "inuCupon", "isbFecha", "inuProyecto", "inuRuta"};
            object[] valores1 = { cupon, fecha, proyecto, ruta };
            blFGCPCM.executeMethod("ldc_boVentaConstructora.proImprimeCuponM", 4, tipos, campos, valores1);
            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
           

        }

       /* private void FGCPC_FormClosing(object sender, FormClosingEventArgs e)
        {
           // ValidateTotalFeeValue();
        }
        */
        private void btn_buscup_Click(object sender, EventArgs e)
        {
            if (validar())
            {
                bsMonthlyFeeM.DataSource = null;
                //control de las fechas
                String fecha1 = "";
                String fecha2 = "";
                if (txt_fechaini.TextBoxValue != null)
                {
                    fecha1 = DateTime.Parse(txt_fechaini.TextBoxValue).ToString("dd/MM/yyyy");
                }
                if (txt_fechafin.TextBoxValue != null)
                {
                    fecha2 = DateTime.Parse(txt_fechafin.TextBoxValue).ToString("dd/MM/yyyy");
                }
                //busqueda de los cupones de proyectos
                object[] valores = { fecha1, fecha2, cbx_proyecto.Value};
                DataSet DatosFactura = blFGCPCM.consultaCupones("ldc_bcVentaConstructora.procnltacupones", valores);
                int cont = DatosFactura.Tables["cupones"].Rows.Count;
                //genera la alerta cuando no se hallo ningun cupon

                List<MonthlyFeeM> Cupones = new List<MonthlyFeeM>();
                if (cont == 0)
                {
                    blFGCPCM.mensajeERROR("No se hallaron Cupones, Revise la información suministrada");
                    bsMonthlyFeeM.DataSource = Cupones;
                }
                else
                {
                    int pos = 0;
                    foreach (DataRow fila in DatosFactura.Tables["cupones"].Rows)
                    {
                        pos++;
                        MonthlyFeeM Cupon = new MonthlyFeeM
                        {
                            seleccion = true,
                           // Id = pos,
                            Id = Int64.Parse(fila.ItemArray[0].ToString()),
                            BillingDate = DateTime.Parse(fila.ItemArray[1].ToString()),
                            AlarmDate = DateTime.Parse(fila.ItemArray[2].ToString()),
                            Status = fila.ItemArray[3].ToString(),
                            Cupon = String.IsNullOrEmpty(Convert.ToString(fila.ItemArray[4])) ? 0 : Convert.ToInt32(fila.ItemArray[4]),
                            //Int64.Parse(fila.ItemArray[4].ToString()),
                            FeeValue = Double.Parse(fila.ItemArray[5].ToString()),
                            Proyecto = fila.ItemArray[6].ToString(),
                            Nombre_Proyecto = fila.ItemArray[7].ToString(),
                            Nombre_Cliente = fila.ItemArray[8].ToString(),
                            Saldo_Pendiente = fila.ItemArray[9].ToString(),
                            Saldo_Diferido = fila.ItemArray[10].ToString()
                        };
                        Cupones.Add(Cupon);
                    }
                    bsMonthlyFeeM.DataSource = Cupones;
                    bloquear();
                }
            }
        }

        void bloquear()
        {
            //Bloqueo de columnas
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[1].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[2].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[3].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[4].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[5].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[6].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[7].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[8].Hidden = true;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[9].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[10].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[11].CellActivation = Activation.NoEdit;
            ugMonthlyFeeM.DisplayLayout.Bands[0].Columns[12].CellActivation = Activation.NoEdit;
        }
        //validacion de Campos Obligatorios
        Boolean validar()
        {
            //validacion de una fecha inicial
            if (String.IsNullOrEmpty(txt_fechaini.TextBoxValue))
            {
                blFGCPCM.mensajeERROR("Debe ingresar la Fecha de Registro de la Solicitud");
                txt_fechaini.Focus();
                return false;
            }
            //validacion de una fecha final
            if (String.IsNullOrEmpty(txt_fechafin.TextBoxValue))
            {
                blFGCPCM.mensajeERROR("Debe ingresar la Fecha de Final del Registro de la Solicitud");
                txt_fechafin.Focus();
                return false;
            }
            //validacion de la carpeta destino de los cupones
            if (String.IsNullOrEmpty(txt_ruta.TextBoxValue))
            {
                blFGCPCM.mensajeERROR("Debe seleccionar la Carpeta donde se guadaran los Cupones");
                btn_buscar.Focus();
                return false;
            }
            return true;
        }


        //200-2022 ==>
        private void NewFolderHidden(String path)
        {

            if (System.IO.Directory.Exists(path))
            {
                deleteFolder(path);
            }

            if (Directory.Exists(path).Equals(false))
            {
                DirectoryInfo Dif = new DirectoryInfo(path);
                Dif.Create();
                Dif.Attributes = FileAttributes.Hidden;
            }
        }

        private void deleteFolder(String path)
        {
            System.IO.Directory.Delete(path, true);
        }

        private void CreateMergedPDF(string targetPDF, string sourceDir)
        {
            using (FileStream stream = new FileStream(targetPDF, FileMode.Create))
            {
                Document pdfDoc = new Document(PageSize.A4);
                PdfCopy pdf = new PdfCopy(pdfDoc, stream);
                pdfDoc.Open();
                var files = Directory.GetFiles(sourceDir);
                Console.WriteLine("Merging files count: " + files.Length);
                int i = 1;
                PdfReader reader = null;
                foreach (string file in files)
                {
                    reader = new PdfReader(file);
                    Console.WriteLine(i + ". Adding: " + file);
                    pdf.AddDocument(reader);
                    i++;

                    pdf.FreeReader(reader);
                    reader.Close();
                    File.Delete(file);
                }

                if (pdfDoc != null)
                {
                    pdfDoc.Close();
                }
                Console.WriteLine("SpeedPASS PDF merge complete.");
            }
        }

        private void btn_buscar_Click(object sender, EventArgs e)
        {
            //ejecuto el cuadro de dialogo de buusqueda de la carpeta destino de los cupones
            fld_carpetas.ShowDialog();
            txt_ruta.TextBoxValue = fld_carpetas.SelectedPath;
        }

        private void tsb_seleccionar_Click(object sender, EventArgs e)
        {
            if (ugMonthlyFeeM.Rows.Count > 0)
            {
                Boolean marcarT = false;
                for (int i = 0; i <= ugMonthlyFeeM.Rows.Count - 1; i++)
                {
                    if (ugMonthlyFeeM.Rows[i].Cells[0].Value.ToString() == "False")
                    {
                        marcarT = true;
                    }
                }
                if (marcarT)
                {
                    for (int i = 0; i <= ugMonthlyFeeM.Rows.Count - 1; i++)
                    {
                        ugMonthlyFeeM.Rows[i].Cells[0].Value = 1;
                    }
                }
                else
                {
                    for (int i = 0; i <= ugMonthlyFeeM.Rows.Count - 1; i++)
                    {
                        ugMonthlyFeeM.Rows[i].Cells[0].Value = 0;
                    }
                }
            }
        }


        public void Limpiar()
        {
            try
            {
                //List<MonthlyFeeM> vacio = new List<MonthlyFeeM>();
                txt_fechaini.TextBoxValue = null;
                txt_fechafin.TextBoxValue = null;
                txt_ruta.TextBoxValue = null;
                cbx_proyecto.Value = null;
                bsMonthlyFeeM.Clear();
                
            }
            catch (Exception error)
            {
                //se dispara al haber un error en el proceso
                blFGCPCM.mensajeERROR("Error al Limpiar Datos \n" + error.ToString());
            }

        }

        private void FGCPCM_Load(object sender, EventArgs e)
        {

        }
        
       

    }
}
