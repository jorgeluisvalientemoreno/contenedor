/* CREACION. CASO 229
 * JOSH BRITO AVILA
 * 
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.OleDb;
using System.Data.Common;
using System.IO;
using OpenSystems.Common;
using OpenSystems.Common.Data;
using OpenSystems.Common.Resources;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using Oracle.DataAccess.Client;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Net;
using BSS.LineamientosPSPD.Entities;
using BSS.LineamientosPSPD.src;

namespace BSS.LineamientosPSPD
{
    public partial class LDC_CARGINFO : OpenForm
    {

        ServiceLDC_CARGINFO src = new ServiceLDC_CARGINFO();
        GUtilities utilities = new GUtilities();

        public LDC_CARGINFO()
        {
            InitializeComponent();
            CargaCombos();
        }

        private void CargaCombos() 
        {

            //Tipo de Cargue
            DataTable dtTipoCargue = utilities.GetListOfValue(GeneralQueries.strTipoCargue);
            cTipoCargue.DataSource = dtTipoCargue;
            cTipoCargue.ValueMember = "CODIGO";
            //cTipoCargue.DisplayMember = "DESCRIPCION";

            //Origen de Cargue
            DataTable dtOrigenCargue = utilities.GetListOfValue(GeneralQueries.strOrigenCargue);
            cOrigenCargue.DataSource = dtOrigenCargue;
            cOrigenCargue.ValueMember = "CODIGO";

            //Origen de Cargue
            DataTable dtDocSoporte = utilities.GetListOfValue(GeneralQueries.strDocSoporte);
            cDocSoporte.DataSource = dtDocSoporte;
            cDocSoporte.ValueMember = "CODIGO";
            
        }

        void ConfigurarColumnas()
        {
            //Bloqueo de columnas
            //dataGridView3.Columns[0].Width = 32;
            dataGridView3.Columns[0].ReadOnly = true;
            dataGridView3.Columns[1].ReadOnly = true;
            dataGridView3.Columns[2].ReadOnly = true;
            dataGridView3.Columns[3].Visible = false;
            dataGridView3.Columns[4].ReadOnly = true;
           // dataGridView3.Columns[5].ReadOnly = false;
          
            DataGridViewComboBoxColumn column =
                        new DataGridViewComboBoxColumn();
            DataTable dt = utilities.GetListOfValue(GeneralQueries.strMotivInclusion);
            column.DataPropertyName = "CODIGO";
            column.HeaderText = "Motivo Inclusión";
            column.DropDownWidth = 160;
            column.Width = 90;
            column.MaxDropDownItems = 3;
            column.FlatStyle = FlatStyle.Flat;
            column.DataSource = dt;
            column.ValueMember = "CODIGO";
            //dataGridView3.Columns.Insert(5, column);
            dataGridView3.Columns.Add(column);

            for (int i = 0; i < dataGridView3.RowCount;i++ ) 
            {
                if (dataGridView3.Rows[i].Cells[2].Value.Equals("NO existe contrato"))
                {
                    dataGridView3.Rows[i].Cells[5].ReadOnly = true;
                    dataGridView3.Rows[i].Cells[5].Style.BackColor = Color.DarkGray;
                    dataGridView3.Rows[i].Cells[5].Style.ForeColor = Color.Red;
                }
            }


        }

        void bloquearWidgets()
        {
            bProcesar.Enabled = false;
        }

        private void bBuscar_Click(object sender, EventArgs e)
        {
            //String txtcontrato = "";
            dataGridView3.Columns.Clear();
            if (chCargueIndiv.Checked)
            {
                if (tContrato.Text.Equals("") || tContrato.Text.Equals(null))
                {
                    utilities.DisplayErrorMessage("Debe ingresar un Contrato");
                    return;
                } 
                else
                {
                    //busqueda contrato
                    object[] valores = { tContrato.Text };
                    DataSet DatosEC = src.consultaContrato("LDC_CARGUEINFOCONTRA.PR_VALIDA_CONTRATO", valores);
                    int cont = DatosEC.Tables["contratos"].Rows.Count;

                    List<Cargue> Carg = new List<Cargue>();
                    if (cont == 0)
                    {
                        utilities.DisplayErrorMessage("El contrato ingresado no está registrado en el sistema");
                        dataGridView3.Columns.Clear();
                        return;
                    }
                    else
                    {
                        int pos = 0;
                        foreach (DataRow fila in DatosEC.Tables["contratos"].Rows)
                        {
                            pos++;
                            Cargue CA = new Cargue
                            {
                                Contrato = fila.ItemArray[0].ToString(),
                                DireccionReportada = "",
                                DireccionPredioOsf = fila.ItemArray[1].ToString(),
                                SuscriptorId = Int64.Parse(fila.ItemArray[2].ToString()),
                                NombreSuscriptor = fila.ItemArray[3].ToString()
                            };
                            Carg.Add(CA);
                        }
                        dataGridView3.DataSource = Carg;
                        ConfigurarColumnas();

                    }
                }
            }
            else
            {
                //archivo plano
                //busqueda contrato
                DataSet DatosEC = src.GetTEMP("LDC_CARGUEINFOCONTRA.PR_LEER_ARCHIVO");
                int cont = DatosEC.Tables["contratos"].Rows.Count;

                List<Cargue> Carg = new List<Cargue>();
                if (cont == 0)
                {
                    utilities.DisplayErrorMessage("No se encontraron resultados");
                    dataGridView3.Columns.Clear();
                    return;
                }
                else
                {
                    int pos = 0;
                    foreach (DataRow fila in DatosEC.Tables["contratos"].Rows)
                    {
                        pos++;
                        Cargue CA = new Cargue
                        {
                            Contrato = fila.ItemArray[0].ToString(),
                            DireccionReportada = fila.ItemArray[1].ToString(),
                            DireccionPredioOsf = fila.ItemArray[2].ToString(),
                            SuscriptorId = Int64.Parse(fila.ItemArray[3].ToString()),
                            NombreSuscriptor = fila.ItemArray[4].ToString()
                        };
                        Carg.Add(CA);
                    }
                    dataGridView3.DataSource = Carg;
                    ConfigurarColumnas();

                }
            }

        }


        private void bCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void bProcesar_Click(object sender, EventArgs e)
        {
            int causal = 2;
            if (chCargueIndiv.Checked)
            {
                causal = 1;
            }
            int onuErrorCode = 0;
            String osbErrorMessage = "";
            object[] parametros = { causal
                                   ,cTipoCargue.Text
                                   ,cOrigenCargue.Text
                                   ,cDocSoporte.Text
                                   ,tObsCargue.Text,
                                   tContrato.Text 
                                  };
            src.ValidaCampos("LDC_CARGUEINFOCONTRA.PR_VALIDACAMPOS", parametros, out onuErrorCode, out osbErrorMessage);
            if (onuErrorCode != 0)
            {
                utilities.DisplayErrorMessage(osbErrorMessage);
            }
            else
            {
                foreach (DataGridViewRow row in dataGridView3.Rows)
                {
                    if (row.Cells[2].Value.Equals("NO existe contrato"))
                    {
                        continue;
                    }
                    else
                    {
                        if (row.Cells[5].Value == null)
                        {
                            utilities.RaiseERROR("Seleccione [Motivo de Inclusión] para los contratos. ");
                            return;
                        }
                    }
                }
                Int64 seqCarge = utilities.GetSeq("LDC_CARGUEINFOCONTRA.GETSEQ", "SEQ_CODCARGUE");
                int countRegPro = 0;
                foreach (DataGridViewRow row in dataGridView3.Rows)
                {
                    if (row.Cells[2].Value.Equals("NO existe contrato"))
                    {
                        continue;
                    }
                    else
                    {

                        object[] valores = { seqCarge
                                   ,causal
                                   ,cTipoCargue.Text
                                   ,cOrigenCargue.Text
                                   ,cDocSoporte.Text
                                   ,tObsCargue.Text
                                   ,row.Cells[0].Value
                                   ,row.Cells[1].Value
                                   ,row.Cells[2].Value
                                   ,row.Cells[3].Value
                                   ,row.Cells[5].Value };

                        Int64? cragRG = src.registraCargo("LDC_CARGUEINFOCONTRA.PR_PROCESAINFOCONTR", valores);
                        if (cragRG == 1)
                        {
                            countRegPro++;
                        }

                    }

                }

                object[] val = { seqCarge
                                   ,dataGridView3.Rows.Count
                                   ,countRegPro
                                   ,dataGridView3.Rows.Count - countRegPro
                               };

                src.registraLog("LDC_CARGUEINFOCONTRA.PR_REGLOG", val);

                DeleteTableTemp();
                utilities.doCommit();
                utilities.DisplayInfoMessage("Proceso termino correctamente.");
                dataGridView3.Columns.Clear();
                return;
            }
            
        }

        private void tExaminar_Click(object sender, EventArgs e)
        {
            //btnProcesar.Enabled = false;
            tRuta.Text = "";
            DataTable dataExcel = new DataTable();
            Boolean isInfoCompleta = true;
            String ruta;
            Importar imprExc = new Importar();
            ruta = imprExc.importarExcel(dataExcel, "Hoja1");
            if (ruta.Equals("") == false)
            {
                tRuta.Text = Path.GetDirectoryName(ruta);
                tNombreArch.Text = Path.GetFileName(ruta);
                DeleteTableTemp();
                foreach (DataRow dr in dataExcel.Rows)
                {
                    String infoCell1;
                    String infoCell2;
                    try{
                        infoCell1 = dr[0].ToString();
                        infoCell2 = dr[1].ToString();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Excel no valido");
                        infoCell1 = null;
                        infoCell2 = null;
                        tRuta.Text = "";
                        tNombreArch.Text = "";
                        return;
                    }
                   // String infoCell3 = dataGridView1.Rows[i].Cells[2].Value.ToString();
                    String infoCells = infoCell1 + infoCell2;

                    if (infoCells == "" || infoCells == null)
                    {
                        continue;
                    }
                    else
                    {
                        if (infoCell1 == "" || infoCell2 == "")
                        {
                            isInfoCompleta = false;
                        }
                        else 
                        {
                            src.SentenceTEMP(" INSERT INTO LDC_TEMPOCONTRATOS (ID_CONTRATO,DIR_REPORTADA) VALUES (" + dr[0].ToString() + ",'" + dr[1].ToString() + "') ");
                        }
                        //MessageBox.Show(infoCells);
                    }
                    
                }


                if (isInfoCompleta == false)
                {
                    MessageBox.Show("Algunos registros estan incompletos. Favor completar [contrato], [direccion_reportada] del documento excel");
                }
                else
                {                    
                    MessageBox.Show("Archivo importado");
                }


                
                
            }  


        }


        private void DeleteTableTemp() 
        {
            src.SentenceTEMP(" DELETE FROM LDC_TEMPOCONTRATOS ");
        }

       

        private void chCargueIndiv_CheckedChanged(object sender, EventArgs e)
        {
            if (chCargueIndiv.Checked)
            {
                tContrato.Enabled = true;
                tRuta.Enabled = false;
                tNombreArch.Enabled = false;
                tExaminar.Enabled = false;
                dataGridView3.Columns.Clear();
            }
            else
            {
                tContrato.Enabled = false;
                tRuta.Enabled = true;
                tNombreArch.Enabled = true;
                tExaminar.Enabled = true;
                dataGridView3.Columns.Clear();

            }
            SendKeys.Send("{TAB}");
        }

        private void dataGridView3_ColumnStateChanged(object sender, DataGridViewColumnStateChangedEventArgs e)
        {
            if (dataGridView3.Rows.Count == 0)
            {
                bProcesar.Enabled = false;

            }
            else
            {
                bProcesar.Enabled = true;
            }
            //SendKeys.Send("{TAB}");
        }

        private void dataGridView3_CausesValidationChanged(object sender, EventArgs e)
        {
           /* if (dataGridView3.Rows.Count == 0)
            {
                bProcesar.Enabled = false;

            }
            else
            {
                bProcesar.Enabled = true;
            }
            SendKeys.Send("{TAB}");
            MessageBox.Show("ok");*/
        }

        private void tContrato_KeyPress(object sender, KeyPressEventArgs e)
        {
            //We only want to allow numeric style chars
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                //Setting e.Handled cancels the keypress event, so the key is not entered
                e.Handled = true;
            }
        }
       
        /*  
        public void FacturasDuplicadosPDF(String isbsource, String isbfilename, int fact, String regOrNoreg, String marcaDuplicado, String marcaFirma)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKDUPLIFACT.PROCIMPRIMEFACT"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.AddInParameter(cmdCommand, "isFactura", DbType.Int64, fact);
                OpenDataBase.db.AddInParameter(cmdCommand, "regOrNoreg", DbType.String, regOrNoreg);
                OpenDataBase.db.AddInParameter(cmdCommand, "isDuplicado", DbType.String, marcaDuplicado);
                OpenDataBase.db.AddInParameter(cmdCommand, "isImpreso", DbType.String, marcaFirma);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

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

        private void button1_Click(object sender, EventArgs e)
        {
            tContrato.Clear();
            tAno.Clear();
            tMes.Clear();
            chk_duplicado.Checked = false;
            bntGenerar.Enabled = false;
            tsb_seleccionar.Enabled = false;
            dataGridView3.Columns.Clear();
        }
       
        void bloquear()
        {
            //Bloqueo de columnas
            dataGridView3.Columns[0].Width = 32;
            dataGridView3.Columns[0].ReadOnly = false;
            dataGridView3.Columns[1].ReadOnly = true;
            dataGridView3.Columns[2].ReadOnly = true;
            dataGridView3.Columns[3].ReadOnly = true;
            dataGridView3.Columns[4].ReadOnly = true;
            dataGridView3.Columns[5].ReadOnly = true;

            tsb_seleccionar.Enabled = true;

        }

        private void button3_Click(object sender, EventArgs e)
        {
            txtcontrato = "";
            String txtano = "";
            String txtmes = "";
            if (tContrato.Text != null)
            {
                txtcontrato = Convert.ToString(tContrato.Text);
                txtano = Convert.ToString(tAno.Text);
                txtmes = Convert.ToString(tMes.Text);
            }
            //busqueda de contrato
            object[] valores = { txtcontrato, txtano, txtmes };
            DataSet DatosEC = gnl.consultaEstadoCuentas("PKDUPLICADOSFACTURAEFG.GETESTADOSCUENTA", valores);
            int cont = DatosEC.Tables["estacuenta"].Rows.Count;

            //genera la alerta
            List<EstadoCuentas> ECs = new List<EstadoCuentas>();
            if (cont == 0)
            {
                utilities.DisplayInfoMessage("No se encontraron resultados, Revise la información suministrada");
                dataGridView3.DataSource = ECs;
                return;
            }
            else
            {
                if (cont > 0 && cont < 13)
                {
                    utilities.DisplayInfoMessage("Se obtuvieron resultados parciales");
                }
                int pos = 0;
                foreach (DataRow fila in DatosEC.Tables["estacuenta"].Rows)
                {
                    pos++;
                    EstadoCuentas EC = new EstadoCuentas
                    {
                        Seleccion = false,                        
                        EstadoCuenta = fila.ItemArray[0].ToString(),
                        Contrato = fila.ItemArray[1].ToString(),
                        Ano = Int64.Parse(fila.ItemArray[2].ToString()),
                        Mes = Int64.Parse(fila.ItemArray[3].ToString()),
                        Valor_total = Int64.Parse(fila.ItemArray[4].ToString())
                    };
                    ECs.Add(EC);
                }
                dataGridView3.DataSource = ECs;
                bloquear();
            }
        }
     
        private void NewFolderSeq(String path)
        {

            if (Directory.Exists(path).Equals(false))
            {
                DirectoryInfo Dif = new DirectoryInfo(path);
                Dif.Create();
            }
        }

        private void tContrato_KeyPress(object sender, KeyPressEventArgs e)
        {
            //We only want to allow numeric style chars
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                //Setting e.Handled cancels the keypress event, so the key is not entered
                e.Handled = true;
            }
        }

     
        private void bntGenerar_Click(object sender, EventArgs e)
        {
            Imprimir frmImprimir = new Imprimir(dataGridView3,chk_duplicado);
            frmImprimir.Show();
        }

        private void tAno_KeyPress(object sender, KeyPressEventArgs e)
        {
            //We only want to allow numeric style chars
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                //Setting e.Handled cancels the keypress event, so the key is not entered
                e.Handled = true;
            }
        }

        private void tMes_KeyPress(object sender, KeyPressEventArgs e)
        {
            //We only want to allow numeric style chars
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                //Setting e.Handled cancels the keypress event, so the key is not entered
                e.Handled = true;
            }
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            SendKeys.Send("{TAB}");
        }

        private void dataGridView3_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            object value = dataGridView3.Rows[e.RowIndex].Cells[0].Value;
            if (value is DBNull) { return; }
            int count = 0;
            foreach (DataGridViewRow row in dataGridView3.Rows)
            {
                if (Convert.ToBoolean(row.Cells[0].Value) == false)
                {
                    count++;
                }
            }
            if (count == dataGridView3.Rows.Count)
            {
                bntGenerar.Enabled = false;
            }
            else 
            {
                bntGenerar.Enabled = true;
            }
        }

        private void tsb_seleccionar_Click(object sender, EventArgs e)
        {
            if (dataGridView3.Rows.Count > 0)
            {
                Boolean marcarT = false;
                for (int i = 0; i <= dataGridView3.Rows.Count - 1; i++)
                {
                    if (dataGridView3.Rows[i].Cells[0].Value.ToString() == "False")
                    {
                        marcarT = true;
                    }
                }
                if (marcarT)
                {
                    for (int i = 0; i <= dataGridView3.Rows.Count - 1; i++)
                    {
                        dataGridView3.Rows[i].Cells[0].Value = 1;
                    }
                }
                else
                {
                    for (int i = 0; i <= dataGridView3.Rows.Count - 1; i++)
                    {
                        dataGridView3.Rows[i].Cells[0].Value = 0;
                    }
                }
            }
        }
        */
       
         
    }
}
