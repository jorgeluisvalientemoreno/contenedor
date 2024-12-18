using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.IO;
using System.Windows.Forms;


//LIBRERIAS DE OPEN
using OpenSystems.Windows.Controls;

using VENTACUPONESMAS.BL;
using VENTACUPONESMAS.Entities;
using Infragistics.Win.UltraWinGrid;


using iTextSharp.text;
using iTextSharp.text.pdf;

namespace VENTACUPONESMAS.UI
{
    public partial class LDIMPMAS : OpenForm
    {
        public LDIMPMAS()
        {
            InitializeComponent();
            //lista de valores de planes comerciales
            DataTable identType = general.getValueList("select a.commercial_plan_id CODIGO, a.name DESCRIPCION from cc_commercial_plan a order by a.name");
            uc_plancomer.DataSource = identType;
            uc_plancomer.ValueMember = "CODIGO";
            uc_plancomer.DisplayMember = "DESCRIPCION";
            //PARAMETROS DE CUPON
            tipodoc = int.Parse(general.getParam("EXTRACT_COUPON", "Int64").ToString());
        }

        BLLDIMPMAS general = new BLLDIMPMAS();
        int tipodoc;

        //validacion de Campos Obligatorios
        Boolean validar()
        {
            //validacion de una fecha inicial
            if (String.IsNullOrEmpty(txt_fechareg.TextBoxValue))
            {
                general.mensajeERROR("Debe ingresar la Fecha de Registro de la Solicitud");
                txt_fechareg.Focus();
                return false;
            }
            //validacion de una fecha final
            if (String.IsNullOrEmpty(txt_fechafin.TextBoxValue))
            {
                general.mensajeERROR("Debe ingresar la Fecha de Final del Registro de la Solicitud");
                txt_fechafin.Focus();
                return false;
            }
            //validacion de la carpeta destino de los cupones
            /*if (String.IsNullOrEmpty(txt_ruta.TextBoxValue))
            {
                general.mensajeERROR("Debe seleccionar la Carpeta donde se guadaran los Cupones");
                btn_buscar.Focus();
                return false;
            }*/
            return true;
        }

        private void btn_generar_Click(object sender, EventArgs e)
        {
            //validacion de la carpeta destino de los cupones
            if (String.IsNullOrEmpty(txt_ruta.TextBoxValue))
            {
                general.mensajeERROR("Debe seleccionar la Carpeta donde se guadaran los Cupones");
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

                    foreach (Infragistics.Win.UltraWinGrid.UltraGridRow fila in dtg_datos.Rows)
                    {
                        if (fila.Cells[0].Value.ToString() == "True")
                        {
                            //creo el cupon
                            String[] tipos = { "Int64", "Int64", "String" };
                            String[] campos = { "inuCupoNume", "inuConfexme", "inuRuta" };
                            object[] valores1 = { fila.Cells[2].Value.ToString(), tipodoc, ruta };
                            general.executeMethod("LD_BOCOUPONPRINTINGCM.PrintCoupon", 3, tipos, campos, valores1);
                            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
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
                    //se dispara al haber un error en el proceso
                    general.mensajeERROR("Hubo errores al Generar los Cupones.\n" + error.ToString());
                }
                finally
                {
                    //valido si finalizo el proceso de creacion sin errores
                    if (sw)
                    {
                        general.mensajeOk("Cupones Guardados en la Ruta Indicada");
                    }
                }
            }
        }

        private void btn_buscar_Click(object sender, EventArgs e)
        {
            //ejecuto el cuadro de dialogo de buusqueda de la carpeta destino de los cupones
            fld_carpetas.ShowDialog();
            txt_ruta.TextBoxValue = fld_carpetas.SelectedPath;
        }

        //cambio de alcance caso 200-1483
        //se creo el boton buscar cupones para que el usuario seleccione los que quiere generar
        private void btn_buscup_Click(object sender, EventArgs e)
        {
            if (validar())
            {
                cuponesBindingSource.DataSource = null;
                //control de las fechas
                String fecha1 = "";
                String fecha2 = "";
                if (txt_fechareg.TextBoxValue != null)
                {
                    fecha1 = DateTime.Parse(txt_fechareg.TextBoxValue).ToString("dd/MM/yyyy");
                }
                if (txt_fechafin.TextBoxValue != null)
                {
                    fecha2 = DateTime.Parse(txt_fechafin.TextBoxValue).ToString("dd/MM/yyyy");
                }
                //busqueda de los cupones asociados al contrato , bajo la especificacion de fechas y demas criterios opcionales
                object[] valores = { txt_codclie.TextBoxValue, fecha1, fecha2, txt_idclie.TextBoxValue, uc_plancomer.Value };
                DataSet DatosFactura = general.consultaCupones("ld_bocouponprintingcm.procnltacupones", valores);
                int cont = DatosFactura.Tables["cupones"].Rows.Count;
                //genera la alerta cuando no se hallo ningun cupon
                List<cupones> Cupones = new List<cupones>();
                if (cont == 0)
                {
                    general.mensajeERROR("No se hallaron Cupones, Revise la información suministrada");
                    cuponesBindingSource.DataSource = Cupones;
                }
                else
                {
                    int pos = 0;
                    foreach (DataRow fila in DatosFactura.Tables["cupones"].Rows)
                    {
                        pos++;
                        cupones Cupon = new cupones
                        {
                            seleccion = true,
                            numcupon = pos,
                            cupon = Int64.Parse(fila.ItemArray[0].ToString()),
                            solicitud = Int64.Parse(fila.ItemArray[1].ToString()),
                            contrato = Int64.Parse(fila.ItemArray[2].ToString()),
                            cliente = fila.ItemArray[3].ToString(),
                            plancomercial = fila.ItemArray[4].ToString(),
                            localidad = fila.ItemArray[5].ToString(),
                            direccion = fila.ItemArray[6].ToString()
                        };
                        Cupones.Add(Cupon);
                    }
                    cuponesBindingSource.DataSource = Cupones;
                    bloquear();
                }
            }
        }

        void bloquear()
        {
            //Bloqueo de columnas
            dtg_datos.DisplayLayout.Bands[0].Columns[1].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[2].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[3].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[4].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[5].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[6].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[7].CellActivation = Activation.NoEdit;
            dtg_datos.DisplayLayout.Bands[0].Columns[8].CellActivation = Activation.NoEdit;
        }

        private void tsb_seleccionar_Click(object sender, EventArgs e)
        {
            if (dtg_datos.Rows.Count > 0)
            {
                Boolean marcarT = false;
                for (int i = 0; i <= dtg_datos.Rows.Count - 1; i++)
                {
                    if (dtg_datos.Rows[i].Cells[0].Value.ToString() == "False")
                    {
                        marcarT = true;
                    }
                }
                if (marcarT)
                {
                    for (int i = 0; i <= dtg_datos.Rows.Count - 1; i++)
                    {
                        dtg_datos.Rows[i].Cells[0].Value = 1;
                    }
                }
                else
                {
                    for (int i = 0; i <= dtg_datos.Rows.Count - 1; i++)
                    {
                        dtg_datos.Rows[i].Cells[0].Value = 0;
                    }
                }
            }
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

        //  <== 200-2022

    }
}
