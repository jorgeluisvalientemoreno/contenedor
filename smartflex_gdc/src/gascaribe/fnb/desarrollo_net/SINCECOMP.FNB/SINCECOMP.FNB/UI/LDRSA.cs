using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using Excel = Microsoft.Office.Interop.Excel;
using Word = Microsoft.Office.Interop.Word;
using System.Reflection;
using System.Collections;
using Infragistics.Win.UltraWinGrid;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.UI
{
    public partial class LDRSA : OpenForm
    {
        //columnas
        int ca = 0; //liquidation id //numero diferido
        int cb = 1; //subscriptor id //saldo diferido
        int cc = 2; //valor cuota cartera
        int cd = 3; //located //valor interes cartera
        int ce = 4; //fecha de vencimiento //total
        int cf = 5; //fecha de nacimiento
        int cg = 6; //fecha de creacion
        int ch = 7; //fecha de reclamo
        int ci = 8; //nombre asegurado
        int cj = 9; //codigo solicitud
        int ck = 10; //fecha de la solicitud
        int cl = 11; //genero
        int cm = 12; //value Debito
        int cn = 13; //valor seguro -- ultima fila
        int co = 14; //id reportes
        int cp = 15; //localidad
        int cq = 16; //identificacion
        BLGENERAL general = new BLGENERAL();
        public LDRSA()
        {
            InitializeComponent();
            //carga de lista de tipos de cobertura
            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("1", "Vida o Incapacidad total y permanente"));
            lista.Add(new ListSN("2", "Rotura maquinaria"));
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;
            UltraDropDown dropDownsn = new UltraDropDown();
            cmbCoverageType.DataSource = tabla;
            cmbCoverageType.ValueMember = "Id";
            cmbCoverageType.DisplayMember = "Description";
            cmbCoverageType.Value = 1;
        }

        Boolean validar()
        {
            return true;
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (validar())
            {
                DataTable datos = new DataTable();
                String inuliquidationid = tbLiquidationNumber.TextBoxValue;
                String inusubscription_id = tbContractnumber.TextBoxValue;
                String inupackageid = tbRequestnumber.TextBoxValue;
                String inuinsuredid = tbIdnumber.TextBoxValue;
                
                //////////////////EVESAN
                String idtclaimdate;
                if (dtpClaimDate.Value.ToString() != "")
                    idtclaimdate = Convert.ToDateTime(dtpClaimDate.Value).ToString("dd/MM/yyyy");
                else
                    idtclaimdate = null;
                String idtsinesterdate;
                if (dtpSinisterDate.Value.ToString() != "")
                    idtsinesterdate = Convert.ToDateTime(dtpSinisterDate.Value).ToString("dd/MM/yyyy");
                else
                    idtsinesterdate = null;
                //////////////////EVESAN
                
                Int64 inucoveragetype = Convert.ToInt64(cmbCoverageType.Value);
                datos = BLLDRSA.getReport(inuliquidationid, inusubscription_id, inupackageid, inuinsuredid, idtclaimdate, idtsinesterdate, inucoveragetype);
                if (datos.Rows.Count == 0)
                    general.mensajeERROR("Los datos no presentan ningún registro asociado");
                else
                {
                    int cant = datos.Rows.Count;
                    Dictionary<string, string> DicRegistros = new Dictionary<string, string>();
                    for (int i = 0; i < cant; i++)
                    {
                        DicRegistros[datos.Rows[i][co].ToString()] = datos.Rows[i][co].ToString();
                    }

                    String[] registros = new String[DicRegistros.Count];

                    int x = 0;
                    foreach (KeyValuePair<string, string> clave in DicRegistros)
                    {
                        registros[x] = DicRegistros[clave.Key];
                        x++;
                    }
       
                    Cursor.Current = Cursors.WaitCursor;
                    String filename;
               
                    if (cbReportingexcel.Checked == true)
                    {
                        DataRow[] rdatos;
                        for (int totexc = 0; totexc < registros.Length; totexc++)
                        {
                            filename = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + @"\Reporte de liquidación " + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss");
                            
                            rdatos = datos.Select("CONTRATO='" + registros[totexc] + "'");
                            
                            Excel.Application oXL = new Excel.Application();
                            Excel.Workbook oWB = (Excel.Workbook)(oXL.Workbooks.Add(Missing.Value));
                            Excel.Worksheet oSheet = (Excel.Worksheet)oWB.ActiveSheet;

                            //LEYENDAS
                            oSheet.Cells[1, 1] = "Reporte de liquidación de siniestro";
                            oSheet.Cells[3, 1] = "Cod. liquidación:";
                            if (Convert.IsDBNull(rdatos[0][ca]) == false)
                                oSheet.Cells[3, 3] = rdatos[0][ca].ToString();
                            oSheet.Cells[5, 1] = "Localidad:";
                            if (Convert.IsDBNull(rdatos[0][cp]) == false)
                                oSheet.Cells[5, 3] = rdatos[0][cp].ToString();
                            oSheet.Cells[7, 1] = "Suscripción:";
                            if (Convert.IsDBNull(rdatos[0][cb]) == false)
                                oSheet.Cells[7, 3] = rdatos[0][cb].ToString();
                            oSheet.Cells[9, 1] = "Cod. de la solicitud:";
                            if (Convert.IsDBNull(rdatos[0][cc]) == false)
                                oSheet.Cells[9, 3] = rdatos[0][cc].ToString();
                            oSheet.Cells[3, 5] = "Fecha Nacimiento:";
                            if (Convert.IsDBNull(rdatos[0][cf]) == false)
                                oSheet.Cells[3, 7] = rdatos[0][cf].ToString();
                            oSheet.Cells[5, 5] = "Fecha Siniestro:";
                            if (Convert.IsDBNull(rdatos[0][ce]) == false)
                                oSheet.Cells[5, 7] = rdatos[0][ce].ToString();
                            oSheet.Cells[7, 5] = "Fecha Reclamo:";
                            if (Convert.IsDBNull(rdatos[0][ch]) == false)
                                oSheet.Cells[7, 7] = Convert.ToDateTime(rdatos[0][ch].ToString()).ToString("dd/MM/yyyy");
                            oSheet.Cells[9, 5] = "Fecha Liquidación:";
                            if (Convert.IsDBNull(rdatos[0][cg]) == false)
                                oSheet.Cells[9, 7] = rdatos[0][cg].ToString();
                            oSheet.Cells[12, 1] = "Nombre asegurado:";
                            if (Convert.IsDBNull(rdatos[0][ci]) == false)
                                oSheet.Cells[12, 3] = rdatos[0][ci].ToString();
                            oSheet.Cells[13, 1] = "Cédula asegurado:";
                            if (Convert.IsDBNull(rdatos[0][cq]) == false)
                                oSheet.Cells[13, 3] = rdatos[0][cq].ToString();
                            oSheet.Cells[16, 1] = "# Solicitud de venta";
                            oSheet.Cells[16, 2] = "fecha de solicitud";
                            oSheet.Cells[16, 3] = "# de diferido";
                            oSheet.Cells[16, 4] = "Saldo diferido";
                            oSheet.Cells[16, 5] = "Valor cuota (cartera corriente)";
                            oSheet.Cells[16, 6] = "Valor interés (cartera corriente)";
                            oSheet.Cells[16, 7] = "Total";
                            int fila = 17;
                            for (int i = 1; i <= rdatos.Length - 1; i++)
                            {
                                if (Convert.IsDBNull(rdatos[i][cj]) == false)
                                    oSheet.Cells[fila, 1] = rdatos[i][cj].ToString();
                                if (Convert.IsDBNull(rdatos[i][ck]) == false)
                                    oSheet.Cells[fila, 2] = Convert.ToDateTime(rdatos[i][ck].ToString()).ToString("dd/MM/yyyy");
                                if (Convert.IsDBNull(rdatos[i][ca]) == false)
                                    oSheet.Cells[fila, 3] = rdatos[i][ca].ToString();
                                if (Convert.IsDBNull(rdatos[i][cb]) == false)
                                    oSheet.Cells[fila, 4] = rdatos[i][cb].ToString();
                                if (Convert.IsDBNull(rdatos[i][cc]) == false)
                                    oSheet.Cells[fila, 5] = rdatos[i][cc].ToString();
                                if (Convert.IsDBNull(rdatos[i][cd]) == false)
                                    oSheet.Cells[fila, 6] = rdatos[i][cd].ToString();
                                if (Convert.IsDBNull(rdatos[i][ce]) == false)
                                    oSheet.Cells[fila, 7] = rdatos[i][ce].ToString();
                                oSheet.get_Range("A" + fila.ToString(), "A" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("B" + fila.ToString(), "B" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("C" + fila.ToString(), "C" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("D" + fila.ToString(), "D" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("E" + fila.ToString(), "E" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("F" + fila.ToString(), "F" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                oSheet.get_Range("G" + fila.ToString(), "G" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                                fila++;
                            }
                            fila = fila + 2;
                            oSheet.Cells[fila, 1] = "Valor seguro:";
                            oSheet.get_Range("B" + fila.ToString(), "B" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            //

                            Double acumTotal = 0;
                            for (int j = 1; j <= rdatos.Length - 1; j++)
                            {
                                acumTotal = acumTotal + Convert.ToDouble(rdatos[j][cf].ToString()); //acumTotal
                            }

                            if (Convert.IsDBNull(rdatos[rdatos.Length - 1][cn]) == false)
                                oSheet.Cells[fila, 2] = acumTotal; //rdatos[rdatos.Length - 1][cn].ToString();
                            //
                            fila = fila + 2;
                            oSheet.Cells[fila, 1] = "Usuario que realiza liquidación:";
                            oSheet.get_Range("C" + fila.ToString(), "G" + fila.ToString()).Merge(Type.Missing);
                            oSheet.get_Range("C" + fila.ToString(), "G" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            if (Convert.IsDBNull(rdatos[0][cl]) == false)
                                oSheet.Cells[fila, 3] = rdatos[0][cl].ToString();
                            fila = fila + 2;
                            oSheet.Cells[fila, 1] = "Fecha de elaboración:";
                            oSheet.get_Range("C" + fila.ToString(), "C" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.Cells[fila, 3] = DateTime.Now.ToString("dd/MM/yyyy");
                            
                            //COMBINAR
                            oSheet.get_Range("A1", "G1").Merge(Type.Missing);
                            oSheet.get_Range("C12", "G12").Merge(Type.Missing);
                            oSheet.get_Range("C13", "G13").Merge(Type.Missing);
                            oSheet.get_Range("A1", "A1").ColumnWidth = 19;
                            oSheet.get_Range("B1", "G1").ColumnWidth = 15;
                            oSheet.get_Range("A16", "A16").RowHeight = 50;
                            
                            //ALINEACIONES
                            oSheet.get_Range("A1", "A1").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range("A16", "G16").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range("A16", "G16").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                            oSheet.get_Range("A16", "G16").WrapText = true;
                            //BORDES
                            oSheet.get_Range("C3", "C3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C5", "C5").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C7", "C7").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C9", "C9").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("G3", "G3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("G5", "G5").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("G7", "G7").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("G9", "G9").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C12", "G12").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C13", "G13").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("A16", "A16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("B16", "B16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("C16", "C16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("D16", "D16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("E16", "E16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("F16", "F16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            oSheet.get_Range("G16", "G16").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                            //LLENAR TABLA
                            //
                            oSheet.Name = "Liquidación de Siniestro";
                            oXL.ActiveWorkbook.Close(true, filename + ".xlsx", Type.Missing);
                            oXL.Quit();
                            oXL.Workbooks.Open(filename + ".xlsx", Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
                            oXL.Visible = true;
                        }
                    }
                    if (cbLetter.Checked == true)
                    {
                        String T1, T2, T3, T4, T5, T6;
                        BLLDRSA.parametersReport(out T1, out T2, out T3, out T4, out T5, out T6);
                        DataRow[] rdatos;
                        for (int totexc = 0; totexc < registros.Length; totexc++)
                        {
                            filename = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + @"\Reporte de liquidación " + DateTime.Now.ToString("dd.MM.yyyy.hh.mm.ss");

                            rdatos = datos.Select("CONTRATO='" + registros[totexc] + "'");

                            BLNUMBERTOLETTER NumberToLetter = new BLNUMBERTOLETTER();
                            Double ValueDebt, BalanceDeferred, ValueQuota, ValueCredit;
                            String NameClient;
                            String nValueDebt, nBalanceDeferred, nValueQuota, nValueCredit;
                            Word.Application oDOC = new Word.Application();
                            Word.Document oWD;
                            Object oMissing = System.Reflection.Missing.Value;
                            oWD = oDOC.Documents.Add(ref oMissing, ref oMissing, ref oMissing, ref oMissing);
                            oWD.Activate();
                            //inicio del TEXTO
                            oWD.Paragraphs.Format.SpaceAfter = 0;
                            oDOC.Selection.Font.Bold = 1;
                            oDOC.Selection.Font.Name = "Arial";
                            oDOC.Selection.Font.Size = 12;
                            oDOC.Selection.ParagraphFormat.Alignment = Word.WdParagraphAlignment.wdAlignParagraphCenter;
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeText(T3);
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.ParagraphFormat.Alignment = Word.WdParagraphAlignment.wdAlignParagraphCenter;
                            oDOC.Selection.TypeText("CERTIFICA  QUE:");
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.Font.Bold = 0;
                            oDOC.Selection.Font.Name = "Arial";
                            oDOC.Selection.Font.Size = 10;
                            oDOC.Selection.ParagraphFormat.Alignment = Word.WdParagraphAlignment.wdAlignParagraphJustify;
                            if (Convert.IsDBNull(rdatos[0][ci]) == false)
                                NameClient = rdatos[0][ci].ToString();
                            else
                                NameClient = "";
                            if (cmbCoverageType.Value.ToString() == "1")
                            {
                                if (Convert.IsDBNull(rdatos[0][cm]) == false)
                                    ValueDebt = Convert.ToDouble(rdatos[0][cm].ToString());
                                else
                                    ValueDebt = 0;

                                Double acumCuota = 0;
                                Double acumInteres = 0;
                                Double acumDifer = 0;
                                Double acumSecuc = 0;
                                for (int i = 1; i <= rdatos.Length - 1; i++)
                                {
                                    if (Convert.IsDBNull(rdatos[i][cj]) == false)
                                        acumDifer = acumDifer + Convert.ToDouble(rdatos[i][cb].ToString());
                                    if (Convert.IsDBNull(rdatos[i][cj]) == false)
                                        acumCuota = acumCuota + Convert.ToDouble(rdatos[i][cc].ToString());
                                    if (Convert.IsDBNull(rdatos[i][cj]) == false)
                                        acumInteres = acumInteres + Convert.ToDouble(rdatos[i][cd].ToString());
                                    if (Convert.IsDBNull(rdatos[i][cj]) == false)
                                        acumSecuc = acumSecuc + Convert.ToDouble(rdatos[i][cf].ToString());
                                }
                                BalanceDeferred = acumDifer;
                                ValueDebt = acumCuota + acumInteres + acumDifer + acumSecuc;

                                if (Convert.IsDBNull(rdatos[rdatos.Length - 1][cn]) == false)
                                    //ValueQuota = Convert.ToDouble(rdatos[rdatos.Length - 1][cn].ToString());
                                    ValueQuota = ValueDebt - BalanceDeferred;
                                else
                                    ValueQuota = 0;
                                //
                                nValueDebt = NumberToLetter.Convertir(ValueDebt.ToString("#.00"), false);
                                if (ValueDebt == 0) nValueDebt = "cero pesos M/L";
                                nBalanceDeferred = NumberToLetter.Convertir(BalanceDeferred.ToString("#.00"), false);
                                if (BalanceDeferred == 0) nBalanceDeferred = "cero pesos M/L";
                                nValueQuota = NumberToLetter.Convertir(ValueQuota.ToString("#.00"), false);
                                if (ValueQuota == 0) nValueQuota = "cero pesos M/L";
                                oDOC.Selection.TypeText("El valor del crédito en la suscripción " + rdatos[0][cb].ToString() + " a nombre de el(la) señor(a) " + NameClient + " identificado(a) con cédula de ciudadanía número " + rdatos[0][cq].ToString() + ", a la fecha presenta una deuda por valor de $ " + ValueDebt.ToString("#,##0.##") + " (" + nValueDebt + ") correspondientes al saldo del diferido $ " + BalanceDeferred.ToString("#,##0.##") + " (" + nBalanceDeferred + ") más las cuotas generadas desde la fecha del siniestro a la fecha por $ " + ValueQuota.ToString("#,##0.##") + " (" + nValueQuota + ").");
                            }
                            else
                            {
                                if (Convert.IsDBNull(rdatos[0][cm]) == false)
                                    ValueCredit = Convert.ToDouble(rdatos[0][cm].ToString());
                                else
                                    ValueCredit = 0;
                                //ValueCredit = 534201;
                                nValueCredit = NumberToLetter.Convertir(ValueCredit.ToString("#.00"), false);
                                if (ValueCredit == 0) nValueCredit = "cero pesos M/L";
                                oDOC.Selection.TypeText("El valor del crédito en la suscripción " + rdatos[0][cb].ToString() + " a nombre de el(la) señor(a) " + NameClient + " identificado(a) con cédula de ciudadanía número " + rdatos[0][cq].ToString() + ", por valor de $ " + ValueCredit.ToString("#,##0.##") + " (" + nValueCredit + ") tiene cobertura de póliza todo riesgo adquirido en la financiación del Kit de conversión GNCV.");//Convert.ToInt64(rdatos[0][cq].ToString()).ToString("#,##0")
                            }
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.Font.Bold = 1;
                            oDOC.Selection.TypeText("Para constancia se firma en la ciudad de "+T5+ ", a los " + DateTime.Now.ToString("dd") + " días del mes de " + DateTime.Now.ToString("MMMM") + " de " + DateTime.Now.ToString("yyyy") + ".");
                            oDOC.Selection.Font.Bold = 0;
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeText("Se anexan soportes para trámite correspondiente.");
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeText("Atentamente,");
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.Font.Size = 14;
                            oDOC.Selection.TypeText(T2);
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeText(T1);
                            oDOC.Selection.Font.Size = 10;
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.Font.Size = 8;
                            oDOC.Selection.TypeText("Elaborado por: ");
                            oDOC.Selection.Font.Underline = Word.WdUnderline.wdUnderlineSingle;
                            oDOC.Selection.TypeText(T6);
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeParagraph();
                            oDOC.Selection.TypeText(T4);
                            oDOC.Selection.TypeParagraph();
                            //fin del texto
                            Object ruta = filename + ".docx";
                            oDOC.ActiveDocument.SaveAs(ref ruta, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing);
                            oDOC.Documents.Close(ref oMissing, ref oMissing, ref oMissing);
                            oWD = oDOC.Documents.Open(ref ruta, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing);
                            oDOC.Visible = true;
                        }
                    }
                    Cursor.Current = Cursors.Arrow;
                }
                
               
            }
            else
                general.mensajeERROR("Falta Información por Ingresar");
        }

        private void cbReportingexcel_CheckedValueChanged(object sender, EventArgs e)
        {
            if (cbReportingexcel.Checked == true)
                btnPrint.Enabled = true;
            else
            {
                if (cbLetter.Checked == false)
                    btnPrint.Enabled = false;
            }
        }

        private void cbLetter_CheckedValueChanged(object sender, EventArgs e)
        {
            if (cbLetter.Checked == true)
                btnPrint.Enabled = true;
            else
            {
                if (cbReportingexcel.Checked == false)
                    btnPrint.Enabled = false;
            }
        }

    }
}
