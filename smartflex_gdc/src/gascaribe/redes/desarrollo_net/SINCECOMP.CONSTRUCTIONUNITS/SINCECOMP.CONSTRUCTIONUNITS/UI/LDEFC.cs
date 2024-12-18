using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
//using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;
using SINCECOMP.CONSTRUCTIONUNITS.DAL;
using SINCECOMP.CONSTRUCTIONUNITS.BL;
using SINCECOMP.CONSTRUCTIONUNITS.Entity;

namespace SINCECOMP.CONSTRUCTIONUNITS.UI
{
    public partial class LDEFC : OpenForm
    {

        public static Int64 nuGeograpLocationId;
        public static Int64 nuInitialYear;
        public static Int64 nuFinalYear;
        public static Int64 nuInitialMonth;
        public static Int64 nuFinalMonth;

        public LDEFC()
        {
            InitializeComponent();

            DataTable TBLdRelevantMarket = DALLDEFC.DSLdRelevantMarket();

            this.cbRelevantMarket.DataSource = TBLdRelevantMarket;

            this.cbRelevantMarket.DisplayMember = "DESCRIPCION";

            this.cbRelevantMarket.ValueMember = "CODIGO";

        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text.ToString()))
            {
                MessageBox.Show("Seleccione un Mercado Relevante.", "Mercado Relevante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.cbRelevantMarket.Focus();
            }
            else
            {
                if (this.tbInitialMonth.TextBoxValue == null)
                {
                    MessageBox.Show("Digite Mes Inicial.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbInitialMonth.Focus();
                }
                else
                {
                    if (this.tbInitialYear.TextBoxValue == null)
                    {
                        MessageBox.Show("Digite Año Inicial.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbInitialYear.Focus();
                    }
                    else
                    {
                        if (this.tbFinalYear.TextBoxValue == null)
                        {
                            MessageBox.Show("Digite Año Final.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            this.tbFinalYear.Focus();
                        }
                        else
                        {
                            if (this.tbFinalMonth.TextBoxValue == null)
                            {
                                MessageBox.Show("Digite Mes Final.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbFinalMonth.Focus();
                            }
                            else
                            {
                                ofdFile.ShowDialog();
                                tbFilePath.TextBoxValue = ofdFile.SelectedPath;
                            }
                        }
                    }
                }
            }
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            Int64 nuInsert;
            Int64 nuRow;
            Int64 nuColumn;
            Int64 nuColumnDRM;

            Int64 nuColBugedAmount;
            Int64 nuColBugedValue;
            Int64 nuColExecAmount;
            Int64 nuColExecValue;

            if (String.IsNullOrEmpty(this.tbFilePath.TextBoxValue.ToString()))
            {
                MessageBox.Show("Seleccione un ruta valida.", "Ruta Archivo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.btnFind.Focus();
            }
            else
            {
                nuRow = 0;
                nuColumn = 0;

                nuInsert = DALLDEFC.ExpressionReferenceRecords(Convert.ToInt64(this.cbRelevantMarket.Value), Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue));

                if (nuInsert > 0)
                {
                    String filename;
                    if ((this.tbFilePath.TextBoxValue.Length <= 3))
                    {
                        filename = Convert.ToString(this.tbFilePath.TextBoxValue) + "InformeCreg " + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss");
                    }
                    else
                    {
                        filename = Convert.ToString(this.tbFilePath.TextBoxValue) + @"\InformeCreg " + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss");
                    }

                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                    List<LdCreg> listCregDRM = new List<LdCreg>();
                    listCregDRM = BLLDEFC.FcuBLCreg(1, 0, "", "");

                    List<LdCreg> listCregDCU = new List<LdCreg>();
                    listCregDCU = BLLDEFC.FcuBLCreg(2, 0, "", "");

                    List<LdCreg> listCregYear = new List<LdCreg>();
                    listCregYear = BLLDEFC.FcuBLCreg(3, 0, "", "");

                    List<LdCreg> listCregAmount = new List<LdCreg>();

                    String sbColumnInitial = String.Empty;
                    String sbColumnFinal = String.Empty;

                    Excel.Application oXL = new Excel.Application();
                    Excel.Workbook oWB = (Excel.Workbook)(oXL.Workbooks.Add(Missing.Value));
                    Excel.Worksheet oSheet = (Excel.Worksheet)oWB.ActiveSheet;

                    //LEYENDAS
                    oSheet.Cells[1, 1] = "Mercado Relevante";
                    oSheet.Cells[3, 1] = "Mes Inicial: " + Convert.ToString(this.tbInitialMonth.TextBoxValue) + "- Mes Final: " + Convert.ToString(this.tbFinalMonth.TextBoxValue);
                    oSheet.Cells[4, 1] = "Unidad Constructiva";   
                    
                    //TAMANOS
                    oSheet.get_Range("A1", "A1").ColumnWidth = 50;
                    ////ALINEACIONES
                    oSheet.get_Range("A1", "A1").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    oSheet.get_Range("A1", "A1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                    oSheet.get_Range("A3", "A3").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    oSheet.get_Range("A3", "A3").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                    oSheet.get_Range("A4", "A4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    oSheet.get_Range("A4", "A4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                    oSheet.get_Range("A4", "A4").Font.Bold = true;                    
                    
                    ///LLENAR CELDAS CONTENIDO                
                    nuColBugedAmount = 0;
                    nuColBugedValue = 0;

                    nuColExecAmount = 0;
                    nuColExecValue = 0;

                    //Diccionario para establecer las formulas de suma
                    Dictionary<string, string> formulasVerticales = new Dictionary<string, string>();

                    Dictionary<Int64, string> formulasHorizontalesCP = new Dictionary<Int64, string>();
                    Dictionary<Int64, string> formulasHorizontalesVP = new Dictionary<Int64, string>();
                    Dictionary<Int64, string> formulasHorizontalesCE = new Dictionary<Int64, string>();
                    Dictionary<Int64, string> formulasHorizontalesVE = new Dictionary<Int64, string>();

                    //Establecer los titulos de los mercados relevante
                    nuColumn = 2;
                    nuColumnDRM = listCregYear.Count; //Convert.ToInt64(tbFinalYear.TextBoxValue) - Convert.ToInt64(tbInitialYear.TextBoxValue) + 1;
                    foreach (LdCreg row in listCregDRM)
                    {
                        nuColBugedAmount = nuColumn;

                        nuColBugedValue = nuColumn + 1;

                        nuColExecAmount = nuColumn + 2;

                        nuColExecValue = nuColumn + 3;

                        oSheet.Cells[1, nuColumn] = row.DescRelevantMarket;                        

                        sbColumnInitial = DALLDEFC.ColumnExcel(nuColBugedAmount);
                        sbColumnFinal = DALLDEFC.ColumnExcel(nuColExecValue);
                        oSheet.get_Range(sbColumnInitial + "1", sbColumnFinal + "1").Merge(Type.Missing);
                        oSheet.get_Range(sbColumnInitial + "1", sbColumnFinal + "1").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        oSheet.get_Range(sbColumnInitial + "1", sbColumnFinal + "1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        //Establecer los años de cada mercado relevante
                        foreach (LdCreg rowCregYear in listCregYear)
                        {
                            oSheet.Cells[3, nuColBugedAmount] = "Presupuesto " + rowCregYear.Year;
                            sbColumnInitial = DALLDEFC.ColumnExcel(nuColBugedAmount);
                            sbColumnFinal = DALLDEFC.ColumnExcel(nuColBugedAmount + 1);
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").Merge(Type.Missing);
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                            oSheet.Cells[4, nuColBugedAmount] = "Cantidad";
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").Font.Bold = true;                            
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                                                        
                            oSheet.Cells[4, nuColBugedValue] = "Valor";
                            sbColumnInitial = DALLDEFC.ColumnExcel(nuColBugedValue);
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").Font.Bold = true;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                             
                            //-----------

                            oSheet.Cells[3, nuColExecAmount] = "Ejecución " + rowCregYear.Year;
                            sbColumnInitial = DALLDEFC.ColumnExcel(nuColExecAmount);
                            sbColumnFinal = DALLDEFC.ColumnExcel(nuColExecAmount + 1);
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").Merge(Type.Missing);
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "3", sbColumnFinal + "3").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                            oSheet.Cells[4, nuColExecAmount] = "Cantidad";
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").Font.Bold = true;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                             
                            oSheet.Cells[4, nuColExecValue] = "Valor";
                            sbColumnInitial = DALLDEFC.ColumnExcel(nuColExecValue);
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").Font.Bold = true;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range(sbColumnInitial + "4", sbColumnInitial + "4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                                                        
                            //-----------                            

                            //Establecer los titulos de las unidades constrcutivas
                            nuRow = 5;
                            foreach (LdCreg rowCregDCU in listCregDCU)
                            {
                                oSheet.Cells[nuRow, 1] = rowCregDCU.DescConstructUnit;                                

                                listCregAmount = BLLDEFC.FcuBLCreg(4, Convert.ToInt64(rowCregYear.Year), Convert.ToString(row.DescRelevantMarket), Convert.ToString(rowCregDCU.DescConstructUnit));

                                if (listCregAmount.Count > 0)
                                {
                                    foreach (LdCreg rowCregAmount in listCregAmount)
                                    {
                                        oSheet.Cells[nuRow, nuColBugedAmount] = rowCregAmount.AmountBudget;
                                        String sbColumn1 = DALLDEFC.ColumnExcel(nuColBugedAmount);
                                        oSheet.get_Range(sbColumn1 + (nuRow), sbColumn1 + (nuRow)).HorizontalAlignment = Excel.XlHAlign.xlHAlignRight;
                                        oSheet.get_Range(sbColumn1 + (nuRow), sbColumn1 + (nuRow)).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;                                        

                                        oSheet.Cells[nuRow, nuColBugedValue] = rowCregAmount.ValueBudget;
                                        String sbColumn2 = DALLDEFC.ColumnExcel(nuColBugedValue);
                                        oSheet.get_Range(sbColumn2 + (nuRow), sbColumn2 + (nuRow)).HorizontalAlignment = Excel.XlHAlign.xlHAlignRight;
                                        oSheet.get_Range(sbColumn2 + (nuRow), sbColumn2 + (nuRow)).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                                        oSheet.Cells[nuRow, nuColExecAmount] = rowCregAmount.AmountExecuted;
                                        String sbColumn3 = DALLDEFC.ColumnExcel(nuColExecAmount);
                                        oSheet.get_Range(sbColumn3 + (nuRow), sbColumn3 + (nuRow)).HorizontalAlignment = Excel.XlHAlign.xlHAlignRight;
                                        oSheet.get_Range(sbColumn3 + (nuRow), sbColumn3 + (nuRow )).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                                        oSheet.Cells[nuRow, nuColExecValue] = rowCregAmount.ValueExecuted;
                                        String sbColumn4 = DALLDEFC.ColumnExcel(nuColExecValue);
                                        oSheet.get_Range(sbColumn4 + (nuRow), sbColumn4 + (nuRow)).HorizontalAlignment = Excel.XlHAlign.xlHAlignRight;
                                        oSheet.get_Range(sbColumn4 + (nuRow), sbColumn4 + (nuRow)).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                                        if (nuRow == 5)
                                        {
                                            formulasVerticales[sbColumn1] = "=" + sbColumn1 + (nuRow);
                                            formulasVerticales[sbColumn2] = "=" + sbColumn2 + (nuRow);
                                            formulasVerticales[sbColumn3] = "=" + sbColumn3 + (nuRow);
                                            formulasVerticales[sbColumn4] = "=" + sbColumn4 + (nuRow);
                                        }
                                        else
                                        {
                                            formulasVerticales[sbColumn1] = formulasVerticales[sbColumn1] + "+" + sbColumn1 + (nuRow);
                                            formulasVerticales[sbColumn2] = formulasVerticales[sbColumn2] + "+" + sbColumn2 + (nuRow);
                                            formulasVerticales[sbColumn3] = formulasVerticales[sbColumn3] + "+" + sbColumn3 + (nuRow);
                                            formulasVerticales[sbColumn4] = formulasVerticales[sbColumn4] + "+" + sbColumn4 + (nuRow);
                                        }

                                        if (nuColumn == 2)
                                        {
                                            formulasHorizontalesCP[nuRow] = "=" + sbColumn1 + (nuRow);
                                            formulasHorizontalesVP[nuRow] = "=" + sbColumn2 + (nuRow);
                                            formulasHorizontalesCE[nuRow] = "=" + sbColumn3 + (nuRow);
                                            formulasHorizontalesVE[nuRow] = "=" + sbColumn4 + (nuRow);
                                        }
                                        else {
                                            formulasHorizontalesCP[nuRow] = formulasHorizontalesCP[nuRow] + "+" + sbColumn1 + (nuRow);
                                            formulasHorizontalesVP[nuRow] = formulasHorizontalesVP[nuRow] + "+" + sbColumn2 + (nuRow);
                                            formulasHorizontalesCE[nuRow] = formulasHorizontalesCE[nuRow] + "+" + sbColumn3 + (nuRow);
                                            formulasHorizontalesVE[nuRow] = formulasHorizontalesVE[nuRow] + "+" + sbColumn4 + (nuRow);
                                        }
                                    }
                                }
                                else
                                {
                                    oSheet.Cells[nuRow, sbColumnInitial] = 0;
                                    oSheet.get_Range(sbColumnInitial + (nuRow), sbColumnInitial + (nuRow)).HorizontalAlignment = Excel.XlHAlign.xlHAlignRight;
                                    oSheet.get_Range(sbColumnInitial + (nuRow), sbColumnInitial + (nuRow)).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                                }

                                nuRow += 1;
                            }

                            nuColBugedAmount += 4;
                            nuColBugedValue += 4;
                            nuColExecAmount += 4;
                            nuColExecValue += 4;
                        }

                        nuColumn = nuColumn + 4 * nuColumnDRM;
                    }

                    String sbColumnSuma = null;                    

                    //Realiza la suma por mercado relevante (parte inferior)
                    for (nuColumn = 2; nuColumn < nuColBugedAmount; nuColumn++)
                    {
                        sbColumnSuma = DALLDEFC.ColumnExcel(nuColumn);
                        oSheet.get_Range(sbColumnSuma + (nuRow + 1), sbColumnSuma + (nuRow + 1)).Formula = formulasVerticales[sbColumnSuma];
                    }                    

                    oSheet.Cells[nuRow + 1, 1] = "Total";
                    oSheet.get_Range("A" + (nuRow + 1), "A" + (nuRow + 1)).Font.Bold = true;
                    Int64 nuRowSuma;

                    string sbColSumaCP = DALLDEFC.ColumnExcel(nuColumn + 1);
                    string sbColSumaVP = DALLDEFC.ColumnExcel(nuColumn + 2);
                    string sbColSumaCE = DALLDEFC.ColumnExcel(nuColumn + 3);
                    string sbColSumaVE = DALLDEFC.ColumnExcel(nuColumn + 4);
                    //sbColumnTotal = DALLDEFC.ColumnExcel(nuColBugedAmount);

                    //Realiza la suma por ubicación geográfica (a la derecha)
                    for (nuRowSuma = 5; nuRowSuma < nuRow; nuRowSuma++)
                    {
                        oSheet.get_Range(sbColSumaCP + (nuRowSuma), sbColSumaCP + (nuRowSuma)).Formula = formulasHorizontalesCP[nuRowSuma];
                        oSheet.get_Range(sbColSumaVP + (nuRowSuma), sbColSumaVP + (nuRowSuma)).Formula = formulasHorizontalesVP[nuRowSuma];
                        oSheet.get_Range(sbColSumaCE + (nuRowSuma), sbColSumaCE + (nuRowSuma)).Formula = formulasHorizontalesCE[nuRowSuma];
                        oSheet.get_Range(sbColSumaVE + (nuRowSuma), sbColSumaVE + (nuRowSuma)).Formula = formulasHorizontalesVE[nuRowSuma];
                    }

                    oSheet.Cells[3, nuColumn + 1] = "Total Presupuesto";              
                    oSheet.get_Range(sbColSumaCP + "3", sbColSumaVP + "3").Merge(Type.Missing);

                    oSheet.Cells[3, nuColumn + 3] = "Total Ejecución";
                    oSheet.get_Range(sbColSumaCE + "3", sbColSumaVE + "3").Merge(Type.Missing);

                    oSheet.get_Range(sbColSumaCP + "3", sbColSumaVE + "3").Font.Bold = true;
                    oSheet.get_Range(sbColSumaCP + "3", sbColSumaVE + "3").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    oSheet.get_Range(sbColSumaCP + "3", sbColSumaVE + "3").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                    oSheet.Cells[4, nuColumn + 1] = "Cantidad";
                    oSheet.Cells[4, nuColumn + 2] = "Valor";
                    oSheet.Cells[4, nuColumn + 3] = "Cantidad";
                    oSheet.Cells[4, nuColumn + 4] = "Valor";

                    oSheet.get_Range(sbColSumaCP + "4", sbColSumaVE + "4").Font.Bold = true;
                    oSheet.get_Range(sbColSumaCP + "4", sbColSumaVE + "4").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    oSheet.get_Range(sbColSumaCP + "4", sbColSumaVE + "4").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                    oSheet.Name = "Informe CREG";
                    oXL.ActiveWorkbook.Close(true, filename + ".xlsx", Type.Missing);
                    oXL.Quit();
                    oXL.Workbooks.Open(filename + ".xlsx", Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
                    oXL.Visible = true;
                    oXL.WindowState = Microsoft.Office.Interop.Excel.XlWindowState.xlMaximized;

                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                }
                else
                {
                    String NewLine = char.ConvertFromUtf32(13) + char.ConvertFromUtf32(10);
                    MessageBox.Show("Valide que el mercado relevante tenga configuración en: " + NewLine + "1. Presupuesto - Mercado Relevante [LDCUC]" + NewLine + "2. Presupuesto - Unidad Constructiva [LDCUD].", "Validacion de configuración", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        private List<LdCreg> UICreg()
        {
            BLLDEFC cuCreg = new BLLDEFC();

            return cuCreg.BLLdCreg();

        }

        private void LDEFC_Load(object sender, EventArgs e)
        {
            this.cbRelevantMarket.Focus();
        }

        private void cbRelevantMarket_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

        }

        private void cbRelevantMarket_ValueChanged(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text.ToString()))
            {
                MessageBox.Show("Seleccione un Mercado Relevante.", "Mercado Relevante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.cbRelevantMarket.Focus();
            }

        }

        private void cbRelevantMarket_ListChanged(object sender, Infragistics.Win.ValueListChangedEventArgs e)
        {

        }

        private void cbRelevantMarket_Leave(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text.ToString()))
            {
                MessageBox.Show("Seleccione un Mercado Relevante.", "Mercado Relevante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.cbRelevantMarket.Focus();
            }

        }

        private void tbInitialYear_Leave(object sender, EventArgs e)
        {
            if (this.tbInitialYear.TextBoxValue == null)
            {
                MessageBox.Show("Digite Año Inicial.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbInitialYear.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbInitialYear.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Año Inicial.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbInitialYear.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbInitialYear.TextBoxValue) < 1)
                    {
                        MessageBox.Show("Año Inicial no debe ser negativo.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbInitialYear.TextBoxValue = null;
                        this.tbInitialYear.Focus();
                    }
                    else
                    {
                        if (Convert.ToInt64(this.tbInitialYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                        {
                            MessageBox.Show("Año Inicial no debe ser mayor al Año Actual.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            this.tbInitialYear.TextBoxValue = null;
                            this.tbInitialYear.Focus();
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(this.tbFinalYear.TextBoxValue) == false)
                            {
                                if (Convert.ToInt64(this.tbInitialYear.TextBoxValue) > Convert.ToInt64(this.tbFinalYear.TextBoxValue))
                                {
                                    MessageBox.Show("Año Inicial no debe ser mayor al Año Final.", "Año Inicial - Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    this.tbInitialYear.TextBoxValue = null;
                                    this.tbInitialYear.Focus();
                                }
                            }
                        }
                    }    
                }
            }
        }

        private void tbFinalYear_Leave(object sender, EventArgs e)
        {
            if (this.tbFinalYear.TextBoxValue == null)
            {
                MessageBox.Show("Digite Año Final.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbFinalYear.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbFinalYear.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Año Final.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbFinalYear.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbFinalYear.TextBoxValue) < 1)
                    {
                        MessageBox.Show("Año Final no debe ser negativo.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbFinalYear.TextBoxValue = null;
                        this.tbFinalYear.Focus();
                    }
                    else
                    {
                        if (Convert.ToInt64(this.tbFinalYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                        {
                            MessageBox.Show("Año Final no debe ser mayor al Año Actual.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            this.tbFinalYear.TextBoxValue = null;
                            this.tbFinalYear.Focus();
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(this.tbInitialYear.TextBoxValue) == false)
                            {

                                if (Convert.ToInt64(this.tbFinalYear.TextBoxValue) < Convert.ToInt64(this.tbInitialYear.TextBoxValue))
                                {
                                    MessageBox.Show("Año Final no debe ser menor al Año Inicial.", "Año Inicial - Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    this.tbFinalYear.TextBoxValue = null;
                                    this.tbFinalYear.Focus();
                                }
                            }
                        }
                    }
                }
            }
        }

        private void tbInitialMonth_Leave(object sender, EventArgs e)
        {
            if (this.tbInitialMonth.TextBoxValue == null)
            {
                MessageBox.Show("Digite Mes Inicial.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbInitialMonth.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbInitialMonth.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Mes Inicial.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbInitialMonth.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbInitialMonth.TextBoxValue) < 1 || Convert.ToInt64(this.tbInitialMonth.TextBoxValue) > 12)
                    {
                        MessageBox.Show("Digite Mes Valido.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbInitialMonth.TextBoxValue = null;
                        this.tbInitialMonth.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbFinalMonth.TextBoxValue) == false)
                        {
                            if (Convert.ToInt64(this.tbInitialMonth.TextBoxValue) > Convert.ToInt64(this.tbFinalMonth.TextBoxValue))
                            {
                                MessageBox.Show("Mes Inicial no debe ser mayor al Mes Final.", "Mes Inicial - Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbInitialMonth.TextBoxValue = null;
                                this.tbInitialMonth.Focus();
                            }
                        }
                    }
                }
            }
        }

        private void tbFinalMonth_Leave(object sender, EventArgs e)
        {
            if (this.tbFinalMonth.TextBoxValue == null)
            {
                MessageBox.Show("Digite Mes Final.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbFinalMonth.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbFinalMonth.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Mes Final.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbFinalMonth.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbFinalMonth.TextBoxValue) < 1 || Convert.ToInt64(this.tbFinalMonth.TextBoxValue) > 12)
                    {
                        MessageBox.Show("Digite Mes Valido.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbFinalMonth.TextBoxValue = null;
                        this.tbFinalMonth.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbInitialMonth.TextBoxValue) == false)
                        {
                            if (Convert.ToInt64(this.tbFinalMonth.TextBoxValue) < Convert.ToInt64(this.tbInitialMonth.TextBoxValue))
                            {
                                MessageBox.Show("Mes Final no debe ser menor al Mes Inicial.", "Mes Inicial - Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbFinalMonth.TextBoxValue = null;
                                this.tbFinalMonth.Focus();
                            }

                        }
                    }
                }
            }
        }

        private void opCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }


}