/* CASO 200-1515
 * ING. DANIEL EDUARDO VALIENTE MORENO
 * MODIFICACION:
 * SE AGREGO UN BOTON DE PRUEBA - esta oculto en la forma volver visible para poder usarlo en pruebas sin archivos de fuente
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
using LDCDUPLIFACT.Entities;
using LDCDUPLIFACT.src;

namespace LDCDUPLIFACT
{
    public partial class Form1 : OpenForm
    {

        Boolean goAhead = false;
        General gnl = new General();
        GUtilities utilities = new GUtilities();
        Object r;
        String txtcontrato = "";
        public Form1()
        {
            InitializeComponent();
            btnProcesar.Enabled = false;
            button3.Enabled = false;
            button4.Hide();
            btnImprReg.Hide();
            btnImprNoReg.Hide();
            textBox1.Enabled = false;
            btnGuardar.Location = new Point(14, 425);
            btnGuardar.Hide();
        }

        private void bntImportar_Click(object sender, EventArgs e)
        {

            btnProcesar.Enabled = false;
            textBox1.Text = "";
            dataGridView1.DataSource = null;
            Boolean isInfoCompleta = true;
            String ruta;
            Importar imprExc = new Importar();            
            ruta = imprExc.importarExcel(dataGridView1, "Hoja1");
            if (ruta.Equals("") == false)
            {
                dataGridView1.Columns[0].SortMode = DataGridViewColumnSortMode.NotSortable;
                dataGridView1.Columns[1].SortMode = DataGridViewColumnSortMode.NotSortable;
                dataGridView1.Columns[2].SortMode = DataGridViewColumnSortMode.NotSortable;
                for (int i = 0; i < dataGridView1.RowCount; i++)
                {
                    String infoCell1 = dataGridView1.Rows[i].Cells[0].Value.ToString();
                    String infoCell2 = dataGridView1.Rows[i].Cells[1].Value.ToString();
                    String infoCell3 = dataGridView1.Rows[i].Cells[2].Value.ToString();
                    String infoCells = infoCell1 + infoCell2 + infoCell3;

                    if (infoCells == "" || infoCells == null)
                    {
                        dataGridView1.Rows.RemoveAt(i);
                    }
                    else
                    {
                        if (infoCell1 == "" || infoCell2 == "" || infoCell3 == "")
                        {
                            isInfoCompleta = false;
                        }
                    }
                }
                dataGridView1.Sort(dataGridView1.Columns[0], ListSortDirection.Ascending);
                if (isInfoCompleta == false)
                {
                    MessageBox.Show("Algunos registros estan incompletos. Favor completar [CONTRATO], [PERIODO], [FACTURA]");
                }
                textBox1.Text = ruta;
                btnProcesar.Enabled = true;
            }           


       
        }

        
        private void btnProcesar_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(cmbPlantilla.Text.ToString()))
            {
                MessageBox.Show("Debe seleccionar una Plantilla");
                return;
            }
            if (goAhead == true)
            {
                //recorre grilla
                List<Facturas> factList = new List<Facturas>();
                MessageBox.Show("Procesando.. No cierre el sistema SmartFlex. Se harán cambios en segundo plano");
                foreach (DataGridViewRow row in dataGridView3.Rows)
                {
                    this.Hide();
                    if (row.Cells[0].Value.Equals(true))
                    {
                        r = utilities.getParameterValue("PARRUTADISAPAPELES", "String");
                        if (r == null || r.ToString() == "")
                        {
                            MessageBox.Show("Para continuar debe configurar la ruta de Disapapeles");
                        }
                        else
                        {
                            int cont = 0;
                            DirectoryInfo di = new DirectoryInfo(@"" + r.ToString());
                            foreach (var fi in di.GetFiles("*" + txtcontrato + "-" + row.Cells[1].Value.ToString() + ".pdf*", SearchOption.AllDirectories))
                            {
                                cont++;
                                string nameSpool = OpenConvert.ToString(fi.Name);
                                string rutaSpool = OpenConvert.ToString(fi.FullName);
                                String nameSinExt = Path.GetFileNameWithoutExtension(nameSpool);
                                /*if (nameSpool.Equals(nameSinExt))
                                {
                                    MessageBox.Show("archivo " + nameSpool.ToString());
                                }
                                else
                                {
                                    MessageBox.Show("archivo con extension" + nameSpool.ToString());
                                }*/
                                int contrato = Int32.Parse(txtcontrato);
                                int periodo = Int32.Parse(row.Cells[1].Value.ToString());
                                int factura = Int32.Parse(row.Cells[3].Value.ToString());
                                Facturas fact = new Facturas(contrato, periodo, factura, "Obtenido de Disapapeles", "NP", true);
                                factList.Add(fact);
                                
                            }
                            if (cont == 0)
                            {
                                if (textBox2.Text != "")
                                {
                                    //buscar en el spool
                                    int contrato = Int32.Parse(txtcontrato);
                                    int periodo = Int32.Parse(row.Cells[1].Value.ToString());
                                    int factura = Int32.Parse(row.Cells[3].Value.ToString());
                                    String observ = "";
                                    Boolean good = false;
                                    String categoria = "";
                                    procesarFactura(contrato, periodo, factura, out observ, out good, out categoria);
                                    Facturas fact = new Facturas(contrato, periodo, factura, observ, categoria, good);
                                    factList.Add(fact);
                                }
                                else
                                {
                                    MessageBox.Show("Favor Indicar la ruta fuente de los Spools.");
                                    return;
                                }
                            }
                        }
                    }
                }
                showResult(factList);
            }
            else
            {
                if (textBox2.Text != "")
                {
                    List<Facturas> factList = new List<Facturas>();
                    MessageBox.Show("Procesando.. No cierre el sistema SmartFlex. Se harán cambios en segundo plano");
                    for (int i = 0; i < dataGridView1.RowCount; i++)
                    {
                        int contrato = Int32.Parse(dataGridView1.Rows[i].Cells[0].Value.ToString());
                        int periodo = Int32.Parse(dataGridView1.Rows[i].Cells[1].Value.ToString());
                        int factura = Int32.Parse(dataGridView1.Rows[i].Cells[2].Value.ToString());
                        String observ = "";
                        Boolean good = false;
                        String categoria = "";
                        procesarFactura(contrato, periodo, factura, out observ, out good, out categoria);
                        Facturas fact = new Facturas(contrato, periodo, factura, observ, categoria, good);
                        factList.Add(fact);

                    }

                    showResult(factList);
                }
                else
                {
                    MessageBox.Show("Favor Indicar la ruta fuente de los Spools");
                }
            }
            /*funcionprueba();*/
        }

        public void showResult(Object factList)
        {
            if (goAhead)
            {
                bntImportar.Enabled = false;
                dataGridView2.DataSource = factList;
                dataGridView2.Columns[4].Visible = false;
                dataGridView2.Columns[5].Visible = false;
                dataGridView2.Columns[0].Width = 100;
                dataGridView2.Columns[1].Width = 100;
                dataGridView2.Columns[2].Width = 100;
                dataGridView1.Hide();
                dataGridView2.Show();
                dataGridView3.Hide();
                btnProcesar.Hide();
                btnImprReg.Hide();
                btnImprNoReg.Hide();
                btnGuardar.Show();
               // button4.Show();
                this.Show();
            }
            else
            {
                bntImportar.Enabled = false;
                dataGridView2.DataSource = factList;
                dataGridView2.Columns[4].Visible = false;
                dataGridView2.Columns[5].Visible = false;
                dataGridView2.Columns[0].Width = 100;
                dataGridView2.Columns[1].Width = 100;
                dataGridView2.Columns[2].Width = 100;
                dataGridView1.Hide();
                dataGridView3.Hide();
                btnProcesar.Hide();
                btnImprReg.Show();
                btnImprNoReg.Show();
                this.Show();
            }
        }

        public void getBack()
        {
            bntImportar.Enabled = true;
            dataGridView2.DataSource = null;
            dataGridView2.Hide();
            dataGridView1.Hide();
            dataGridView3.Show();
            btnProcesar.Show();
            btnImprReg.Hide();
            btnImprNoReg.Hide();
            btnGuardar.Hide();
           // button4.Hide();
        }

        public void procesarFactura(int pContrato, int pPeriodo, int pFactura, out string observ, out Boolean good, out string categoria)
        {
           // MessageBox.Show("Procesando.. No cierre el sistema SmartFlex");
            this.Hide();
            observ = "";
            categoria = "";
            good = false;
                //Valida que el contrato y el periodo correspondan a la factura
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKDUPLIFACT.VALIDAFACTURAS"))
                {
                    try
                    {
                        String msgOut;
                        int codPeriodo;
                        OpenDataBase.db.AddInParameter(cmdCommand, "contrato", DbType.Int64, pContrato);
                        OpenDataBase.db.AddInParameter(cmdCommand, "periodo", DbType.Int64, pPeriodo);
                        OpenDataBase.db.AddInParameter(cmdCommand, "factura", DbType.Int64, pFactura);
                        OpenDataBase.db.AddOutParameter(cmdCommand, "id_periodo", DbType.Int64, 0);
                        OpenDataBase.db.AddOutParameter(cmdCommand, "categoria", DbType.String, 0);
                        OpenDataBase.db.AddOutParameter(cmdCommand, "msg", DbType.String, 4000);
                        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                        codPeriodo = Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "id_periodo"));
                        categoria = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "categoria"));
                        msgOut = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "msg"));
                        if (msgOut.Equals("N"))
                        {
                            srchSpool(codPeriodo, pFactura, out observ, out good);

                        }
                        else
                        {
                            //La Facturao el Periodo de facturacion no hacen parte del Contrato:
                            observ = msgOut;
                            //La factura fue actualizada anteriormente
                            if (codPeriodo == 0)
                            {
                                good = true;
                            }
                        }
                    }
                    catch (OracleException ex)
                    {
                        Console.WriteLine("Error lista_dir.NET");
                        Console.WriteLine("Exception Message: " + ex.Message);
                        Console.WriteLine("Exception Source: " + ex.Source);
                    }
                }
            
        }
        public void srchSpool(int spPeriodo, int spFactura, out string observ, out Boolean good)
        {
            try
            {
                observ = "";
                good = false;
                //\\FAMILIAR\x
                DirectoryInfo di = new DirectoryInfo(@""+textBox2.Text);
                int count = 0;
                String Msg = "La Factura " + spFactura.ToString() + " no existe en los spool:";
                Boolean existe = false;
                foreach (var fi in di.GetFiles("*FIDF_" + spPeriodo.ToString() + "_*", SearchOption.AllDirectories))
                {
                    // Console.WriteLine(fi.Name);
                    //MessageBox.Show(fi.FullName);
                    Boolean ext = false;
                    count++;
                    string nameSpool = OpenConvert.ToString(fi.Name);
                    string rutaSpool = OpenConvert.ToString(fi.FullName);
                    String nameSinExt = Path.GetFileNameWithoutExtension(nameSpool);
                    if (nameSpool.Equals(nameSinExt))
                    {
                        int counter = 0;
                        string line;
                        string CAMPOS_SPOOLTXT = "";
                        string FACT_TXT = "";
                        Boolean capturarCampo = false;
                        System.IO.StreamReader file =
                        new System.IO.StreamReader(@"" + rutaSpool);
                        while ((line = file.ReadLine()) != null)
                        {
                            if (counter == 0 && capturarCampo.Equals(false))
                            {
                                CAMPOS_SPOOLTXT = line;
                            }
                            else
                            {
                                Boolean exist = line.Contains("|" + spFactura.ToString() + "|");
                                if (exist)
                                {
                                    FACT_TXT = line;
                                    updateXML(CAMPOS_SPOOLTXT, FACT_TXT, spFactura, out ext);
                                    capturarCampo = true;
                                }
                            }
                            counter++;
                        }

                        file.Close();
                    }

                    if (ext)
                    {
                        existe = true;
                    }
                    else if (ext.Equals(false) && nameSpool.Equals(nameSinExt))
                    {
                        Msg = Msg + " [" + nameSpool + "]";
                    }

                }
                if (existe && count > 0)
                {
                    observ = "Factura Actualizada";
                    good = true;
                }
                else if (count > 0)
                {
                    //La factura no existe en los spools
                    observ = Msg;
                    good = false;
                }
                if (count == 0)
                {
                    observ = "No existen spool para el periodo ";
                    good = false;
                }
            }
            catch (Exception ex)
            {
                observ = "";
                good = false;
                MessageBox.Show(ex.Message);
            }
            
                    
        }
        /*
        public void srchSpool(int spPeriodo, int spFactura, out string observ, out Boolean good)
        {
            observ = "";
            good = false;
            String query = "SELECT T1.file_name, RTRIM(T1.ruta, T1.file_name) ruta_spool "
                + "FROM (SELECT substr(FNAME_KRBMSFT, INSTR(FNAME_KRBMSFT,'FIDF_'||TO_CHAR(" + spPeriodo.ToString() + ")||'_')) file_name, FNAME_KRBMSFT ruta "
                + "FROM SYS.VW_X$KRBMSFT "
                + "WHERE FNAME_KRBMSFT LIKE '%FIDF_'||TO_CHAR(" + spPeriodo.ToString() + ")||'_%') T1 ";
            using (DbCommand storedProcCommand = OpenDataBase.db.GetSqlStringCommand(query.ToString()))
            {
                OpenDataBase.db.AddReturnRefCursor(storedProcCommand);
                using (IDataReader dataReader = OpenDataBase.db.ExecuteReader(storedProcCommand, CommandBehavior.SingleResult))
                {
                    int ordinal1 = dataReader.GetOrdinal("file_name");
                    int ordinal2 = dataReader.GetOrdinal("ruta_spool");
                    int count = 0;
                    String Msg = "La Factura " + spFactura.ToString() + " no existe en los spool:";
                    Boolean existe = false;
                    while (dataReader.Read())
                    {
                        
                        Boolean ext = false;
                        count++;
                        string nameSpool = OpenConvert.ToString(dataReader[ordinal1]);
                        string rutaSpool = OpenConvert.ToString(dataReader[ordinal2]);
                        String nameSinExt = Path.GetFileNameWithoutExtension(nameSpool);
                        if (nameSpool.Equals(nameSinExt))
                        {
                            updateXML(rutaSpool, nameSpool, spFactura, out ext);
                        }
                        
                        if (ext)
                        {
                            existe = true;
                        }
                        else if (ext.Equals(false) && nameSpool.Equals(nameSinExt))
                        {
                            Msg = Msg + " [" + nameSpool + "]";
                        }
                    }
                    if (existe && count >0)
                    {
                        observ = "Factura Actualizada";
                        good = true;
                    }
                    else if (count > 0)
                    {
                        //La factura no existe en los spools
                        observ = Msg;
                        good = false;
                    }
                    if (count == 0)
                    {
                        observ = "No existen spool para el periodo ";
                        good = false;
                    }
                }
            }
        }*/

        public void updateXML(String uRuta, String uNameFile, int uFactura, out Boolean existe)
        {
            existe = false;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKDUPLIFACT.OBTIENEFACTURASP"))
            {                
                try
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "CAMPOTXT", DbType.String, uRuta);
                    OpenDataBase.db.AddInParameter(cmdCommand, "FACTURATXT", DbType.String, uNameFile);
                    OpenDataBase.db.AddInParameter(cmdCommand, "FACTURA", DbType.Int64, uFactura);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "EXISTE", DbType.Boolean, 0);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    existe = Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, "EXISTE"));
                
                }
                catch (OracleException ex)
                {
                    existe = false;
                    Console.WriteLine("Error lista_dir.NET");
                    Console.WriteLine("Exception Message: " + ex.Message);
                    Console.WriteLine("Exception Source: " + ex.Source);
                }
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            base.Close();
        }

        private void btnImprReg_Click(object sender, EventArgs e)
        {
            ImprirDuplicadosFacturas("R");           
        }

        private void btnImprNoReg_Click(object sender, EventArgs e)
        {
            ImprirDuplicadosFacturas("NR");  
        }

        public void ImprirDuplicadosFacturas(String regOrNoreg)
        {
            ///String cadenafact = "";
            int contCateg = 0;
            foreach (DataGridViewRow row in dataGridView2.Rows)
            {
                if (Convert.ToBoolean(row.Cells[5].Value))
                {
                    if (row.Cells[4].Value.ToString().Equals(regOrNoreg))
                    {
                        /*if (contCateg == 0)
                        {
                            cadenafact = cadenafact + row.Cells[2].Value.ToString();
                        }
                        else
                        {
                            cadenafact = cadenafact + "," + row.Cells[2].Value.ToString();
                        }*/
                        contCateg++;
                    }
                }
            }
            if (contCateg > 0)
            {
                /*if (cadenafact.Equals("") == false)
                {*/
                    String path = "";
                    Int64 inuControl = 0;
                    FolderBrowserDialog fbdDirectory = new FolderBrowserDialog();
                    if (fbdDirectory.ShowDialog() == DialogResult.OK)
                    {
                        MessageBox.Show("Generando facturas, por favor espere unos minutos...");
                        path = fbdDirectory.SelectedPath + @"\D0$4F%&URA";
                        NewFolderHidden(path);
                        String isbOutNameFile = "FACT_";
                        String namePdf = fbdDirectory.SelectedPath + @"\Duplicado_Facturas_" + regOrNoreg + ".pdf";
                        //CASO 200-1515
                        String marcaDuplicado = "1";
                        String marcaFirma = "1";
                        if (chk_duplicado.Checked)
                        {
                            marcaDuplicado = "0";
                        }
                        //
                        foreach (DataGridViewRow row in dataGridView2.Rows)
                        {
                            if (Convert.ToBoolean(row.Cells[5].Value))
                            {
                                if (row.Cells[4].Value.ToString().Equals(regOrNoreg))
                                {
                                    //FacturasDuplicadosPDF(path, isbOutNameFile, Convert.ToInt32(row.Cells[2].Value), regOrNoreg);
                                    //CASO 200-1515
                                    FacturasDuplicadosPDF(path, isbOutNameFile, Convert.ToInt32(row.Cells[2].Value), regOrNoreg, marcaDuplicado, marcaFirma, cmbPlantilla.Text);
                                    //
                                    //FacturasDuplicadosPDF(fbdDirectory.SelectedPath, isbOutNameFile, cadenafact, regOrNoreg);
                                    Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                                    OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                                    inuControl = 1;
                                }
                            }
                        }
                        CreateMergedPDF(namePdf, path);

                        if (System.IO.Directory.Exists(path))
                        {
                            deleteFolder(path);
                        }

                        if (inuControl == 0)
                        {
                            MessageBox.Show("No se generaron duplicados de facturas");
                        }
                        else
                        {
                            MessageBox.Show("Se generaron los duplicados de facturas");
                        }
                        
                    }
                //}
            }
            else
            {
                MessageBox.Show("No se generaron Facturas para la categoria");
            }
        }

        public void FacturasDuplicadosPDF(String isbsource, String isbfilename, int fact, String regOrNoreg, String marcaDuplicado, String marcaFirma, String isPlantilla)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKDUPLIFACT.PROCIMPRIMEFACT"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbsource", DbType.String, isbsource);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbfilename", DbType.String, isbfilename);
                OpenDataBase.db.AddInParameter(cmdCommand, "isFactura", DbType.Int64, fact);
                OpenDataBase.db.AddInParameter(cmdCommand, "regOrNoreg", DbType.String, regOrNoreg);
                OpenDataBase.db.AddInParameter(cmdCommand, "isDuplicado", DbType.String, marcaDuplicado);
                OpenDataBase.db.AddInParameter(cmdCommand, "isImpreso", DbType.String, marcaFirma);
                OpenDataBase.db.AddInParameter(cmdCommand, "isPlantilla", DbType.String, isPlantilla);
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
            FolderBrowserDialog fbdDirectory = new FolderBrowserDialog();
            if (fbdDirectory.ShowDialog() == DialogResult.OK)
            {
                textBox2.Text = fbdDirectory.SelectedPath;

            }
        }

        //19-02-18 Caso 200-1515
        //modificacion de prueba para verificar generacion de un solo reporte quemado
        private void button2_Click(object sender, EventArgs e)
        {
            funcionprueba();
        }

        void funcionprueba()
        {
            String regOrNoreg = "R";
            String path = @"C:\Users\Daniel Valiente\Desktop\D0$4F%&URA";
            NewFolderHidden(path);
            String isbOutNameFile = "FACT_";
            String namePdf = path + @"C:\Users\Daniel Valiente\Desktop\Duplicado_Facturas_" + regOrNoreg + ".pdf";
            String marcaDuplicado = "1";
            String marcaFirma = "1";
            if(chk_duplicado.Checked)
            {
                marcaDuplicado = "1";
            }
            FacturasDuplicadosPDF(path, isbOutNameFile, 1126357878, regOrNoreg, marcaDuplicado, marcaFirma, cmbPlantilla.Text);
            //FacturasDuplicadosPDF(fbdDirectory.SelectedPath, isbOutNameFile, cadenafact, regOrNoreg);
            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
            //CreateMergedPDF(namePdf, path);
        }

      /*  private void tbContrato_TextChanged(object sender, EventArgs e)
        {
            if (tbContrato.Text != null && tbContrato.Text != "" && tbContrato.Text > 0)
            {

            }
        }*/
        
        void bloquear()
        {
            //Bloqueo de columnas
            dataGridView3.Columns[0].Width = 32;
            dataGridView3.Columns[0].ReadOnly = false;
            dataGridView3.Columns[1].ReadOnly = true;
            dataGridView3.Columns[2].ReadOnly = true;
            dataGridView3.Columns[3].ReadOnly = true;
            btnProcesar.Enabled = true;

        }


        private void tContrato_TextChanged(object sender, EventArgs e)
        {               
            if (tContrato.Text != null && tContrato.Text != "" && Convert.ToInt64(tContrato.Text) > 0)
            {
                bntImportar.Enabled = false;
                //textBox1.Enabled = false;
                dataGridView3.Show();
                goAhead = true;
                //btnProcesar.Enabled = true;
                button3.Enabled = true;
            }
            else
            {
                bntImportar.Enabled = true;
                //textBox1.Enabled = true;
                dataGridView3.Hide();
                dataGridView1.Show();
                goAhead = false;
                btnProcesar.Enabled = false;
                button3.Enabled = false;
                dataGridView3.DataSource = null;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            txtcontrato = "";
            if (tContrato.Text != null)
            {
                txtcontrato = Convert.ToString(tContrato.Text);
            }
            //busqueda de contrato
            object[] valores = { txtcontrato };
            DataSet DatosEC = gnl.consultaEstadoCuentas("LDC_PKDUPLIFACT.OBTFACTRECURRENTE", valores);
            int cont = DatosEC.Tables["estacuenta"].Rows.Count;

            //genera la alerta cuando no se hallo ningun contrato
            List<EstadoCuentas> ECs = new List<EstadoCuentas>();
            if (cont == 0)
            {
                utilities.DisplayInfoMessage("No se hallaron Contratos, Revise la información suministrada");
                dataGridView3.DataSource = ECs;
                return;
            }
            else
            {
                int pos = 0;
                foreach (DataRow fila in DatosEC.Tables["estacuenta"].Rows)
                {
                    pos++;
                    EstadoCuentas EC = new EstadoCuentas
                    {
                        Seleccion = false,
                        Cod_periodo = Int64.Parse(fila.ItemArray[0].ToString()),
                        Periodo = fila.ItemArray[1].ToString(),
                        EstadoCuenta = fila.ItemArray[2].ToString(),
                        FechaEmision = DateTime.Parse(fila.ItemArray[3].ToString())
                    };
                    ECs.Add(EC);
                }
                dataGridView3.DataSource = ECs;
                bloquear();
            }//end if (cont == 0)
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
           // MessageBox.Show("cambios resgistrado");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            getBack();
        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(cmbPlantilla.Text.ToString()))
            {
                MessageBox.Show("Debe seleccionar una Plantilla");
                return;
            }

            String path = "";
           // int seq = 0;
            Int64 inuControl = 0;
            FolderBrowserDialog fbdDirectory = new FolderBrowserDialog();
            if (fbdDirectory.ShowDialog() == DialogResult.OK)
            {
                MessageBox.Show("Generando facturas, por favor espere unos minutos...");
                path = fbdDirectory.SelectedPath + @"\" + gnl.GetSeq().ToString();
               // MessageBox.Show(path);

                String marcaDuplicado = "1";
                String marcaFirma = "1";
                if (chk_duplicado.Checked)
                {
                    marcaDuplicado = "0";
                }
                foreach (DataGridViewRow row in dataGridView2.Rows)
                {
                    
                    if (Convert.ToBoolean(row.Cells[5].Value))
                    {
                        NewFolderSeq(path);
                        if (row.Cells[4].Value.ToString().Equals("NP"))
                        {
                            DirectoryInfo di = new DirectoryInfo(@"" + r.ToString());
                            foreach (var fi in di.GetFiles("*" + row.Cells[0].Value.ToString() + "-" + row.Cells[1].Value.ToString() + ".pdf*", SearchOption.AllDirectories))
                            {
                                string destFile = System.IO.Path.Combine(path, fi.Name);
                                if (System.IO.File.Exists(destFile) == false)
                                {
                                    //example (@"C:\Users\SASO\Desktop", @"C:\Users\SASO\Desktop\SubDir", true)
                                    File.Copy(fi.FullName, destFile, true);
                                }
                            }
                            inuControl = 1;
                        }
                        else
                        {
                            FacturasDuplicadosPDF(path
                                , row.Cells[0].Value + "-" + row.Cells[1].Value
                                , Convert.ToInt32(row.Cells[2].Value)
                                , row.Cells[4].Value.ToString()
                                , marcaDuplicado
                                , marcaFirma
                                , cmbPlantilla.Text);
                          //cambiar nombre
                            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);

                            DirectoryInfo di = new DirectoryInfo(@"" + path);
                            foreach (var fi in di.GetFiles("*" + row.Cells[0].Value.ToString() + "-" + row.Cells[1].Value.ToString() + "_*.pdf", SearchOption.AllDirectories))
                            {
                                string destFile = System.IO.Path.Combine(path, row.Cells[0].Value.ToString() + "-" + row.Cells[1].Value.ToString() + ".pdf");
                                if (System.IO.File.Exists(destFile) == false)
                                {
                                    //example (@"C:\Users\SASO\Desktop", @"C:\Users\SASO\Desktop\SubDir", true)
                                    File.Move(fi.FullName, destFile);
                                }
                            }
                            inuControl = 1;
                        }
                    }
                }

                if (inuControl == 0)
                {
                    MessageBox.Show("No se generaron duplicados de facturas");
                }
                else
                {
                    MessageBox.Show("Se generaron los duplicados de facturas");
                }
            }
        }

        private void NewFolderSeq(String path)
        {

            if (Directory.Exists(path).Equals(false))
            {
                DirectoryInfo Dif = new DirectoryInfo(path);
                Dif.Create();
              //  Dif.Attributes = FileAttributes.Hidden;
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
        
        //

       
    }
}
