using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.BL;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;

using SINCECOMP.FNB.Controls;

namespace SINCECOMP.FNB.UI
{
    public partial class FIACS : OpenForm
    {
        private static BLFIACS _blFIACS = new BLFIACS();
        BLGENERAL general = new BLGENERAL();

        public FIACS()
        {
            InitializeComponent();
           /// SAO 214611 Se cambia el componente a listas de valores en arbol
            cb_geograph_location.SqlSelect = BLConsultas.UbicacionGeograficaTree;
            cb_geograph_location.IsUsedInGrid = true;

            cb_geograph_location.Caption = "Ubicación geográfica";            
        }

        private void btn_cancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_process_Click(object sender, EventArgs e)
        {

            // EVESAN 03/Julio/2013 -- Se valida que se escriba un dato válido en el combo[Ubicación Geográfica]
            //                         antes de empezar el proceso
            if (cb_geograph_location.Value == null)
            {
                general.mensajeERROR("Se debe ingresar un dato valido para el proceso");
            }
            else
            {
                try
                {
                    String[] p1 = new string[] { "Int64" };
                    String[] p2 = new string[] { "inugeographloca" };
                    Object[] p3 = new object[] { cb_geograph_location.Value };
                    general.executeMethod(BLConsultas.SimulaciondeCuotas, 1, p1, p2, p3);
                    //primer excel general
                    DataTable simulationQuery = general.cursorProcedure(BLConsultas.querySimulateGeneral);
                    if (simulationQuery.Rows.Count == 0)
                    {
                        general.mensajeERROR("No hay Registros para procesar");
                    }
                    else
                    {

                        general.mensajeOk("Datos registrados con exito. Los datos seran desplegados en el reporte CUPO SIMULADO en ORM.");

                        //Excel.Application oXL = new Excel.Application();
                        //Excel.Workbook oWB = (Excel.Workbook)(oXL.Workbooks.Add(Missing.Value));
                        //Excel.Worksheet oSheet = (Excel.Worksheet)oWB.ActiveSheet;
                        ////LEYENDAS
                        //oSheet.Cells[1, 1] = "Suscripción";
                        //oSheet.Cells[1, 2] = "Departamento";
                        //oSheet.Cells[1, 3] = "Localidad";
                        //oSheet.Cells[1, 4] = "Barrio";
                        //oSheet.Cells[1, 5] = "Tipo de Vivienda";
                        //oSheet.Cells[1, 6] = "Categoria";
                        //oSheet.Cells[1, 7] = "Subcategoria";
                        //oSheet.Cells[1, 8] = "Monto de Cupo Actual";
                        //oSheet.Cells[1, 9] = "Monto de Cupo Simulado";
                        //int fila = 2;
                        //for (int i = 0; i <= simulationQuery.Rows.Count - 1; i++)
                        //{
                        //    oSheet.Cells[fila, 1] = simulationQuery.Rows[i][0].ToString();
                        //    oSheet.Cells[fila, 2] = simulationQuery.Rows[i][1].ToString();
                        //    oSheet.Cells[fila, 3] = simulationQuery.Rows[i][2].ToString();
                        //    oSheet.Cells[fila, 4] = simulationQuery.Rows[i][3].ToString();
                        //    oSheet.Cells[fila, 5] = simulationQuery.Rows[i][4].ToString();
                        //    oSheet.Cells[fila, 6] = simulationQuery.Rows[i][5].ToString();
                        //    oSheet.Cells[fila, 7] = simulationQuery.Rows[i][6].ToString();
                        //    oSheet.Cells[fila, 8] = simulationQuery.Rows[i][7].ToString();
                        //    oSheet.Cells[fila, 9] = simulationQuery.Rows[i][8].ToString();
                        //    fila++;
                        //}
                        //oSheet.get_Range("A1", "A1").ColumnWidth = 15;
                        //oSheet.get_Range("B1", "B1").ColumnWidth = 25;
                        //oSheet.get_Range("C1", "C1").ColumnWidth = 25;
                        //oSheet.get_Range("D1", "D1").ColumnWidth = 15;
                        //oSheet.get_Range("E1", "E1").ColumnWidth = 20;
                        //oSheet.get_Range("F1", "F1").ColumnWidth = 15;
                        //oSheet.get_Range("G1", "G1").ColumnWidth = 15;
                        //oSheet.get_Range("H1", "H1").ColumnWidth = 15;
                        //oSheet.get_Range("I1", "I1").ColumnWidth = 15;
                        //////ALINEACIONES
                        //oSheet.get_Range("A1", "I1").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        //oSheet.get_Range("A1", "I1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        //oSheet.get_Range("A1", "I1").WrapText = true;
                        //oSheet.Name = "Asignación de Cupo de Crédito";
                        //oXL.Visible = true;
                        ////segundo excel resumen
                        //DataTable resumeQuery = general.cursorProcedure(BLConsultas.querySimulateResume);
                        //Excel.Application oXL1 = new Excel.Application();
                        //Excel.Workbook oWB1 = (Excel.Workbook)(oXL1.Workbooks.Add(Missing.Value));
                        //Excel.Worksheet oSheet1 = (Excel.Worksheet)oWB1.ActiveSheet;

                        ////LEYENDAS
                        //oSheet1.Cells[1, 5] = "Politica Vigente";
                        //oSheet1.Cells[1, 7] = "Simulación";
                        //oSheet1.Cells[2, 7] = "Información de la Variables modificadas de la politica";
                        //oSheet1.Cells[3, 1] = "Departamento";
                        //oSheet1.Cells[3, 2] = "Localidad";
                        //oSheet1.Cells[3, 3] = "Categoria";
                        //oSheet1.Cells[3, 4] = "Subcategoria";
                        //oSheet1.Cells[3, 5] = "Cantidad Clientes";
                        //oSheet1.Cells[3, 6] = "Monto Cupo";
                        //oSheet1.Cells[3, 7] = "Cantidad Clientes";
                        //oSheet1.Cells[3, 8] = "Monto Cupo";
                        //oSheet1.Cells[3, 9] = "% de Variación";
                        //fila = 4;
                        //Double variacion;
                        //for (int i = 0; i <= resumeQuery.Rows.Count - 1; i++)
                        //{

                        //    oSheet1.Cells[fila, 1] = resumeQuery.Rows[i][0].ToString();
                        //    oSheet1.Cells[fila, 2] = resumeQuery.Rows[i][1].ToString();
                        //    oSheet1.Cells[fila, 3] = resumeQuery.Rows[i][2].ToString();
                        //    oSheet1.Cells[fila, 4] = resumeQuery.Rows[i][3].ToString();
                        //    oSheet1.Cells[fila, 5] = resumeQuery.Rows[i][4].ToString();
                        //    oSheet1.Cells[fila, 6] = resumeQuery.Rows[i][5].ToString();
                        //    oSheet1.Cells[fila, 7] = resumeQuery.Rows[i][4].ToString();
                        //    oSheet1.Cells[fila, 8] = resumeQuery.Rows[i][6].ToString();
                        //    try
                        //    {

                        //        if(Convert.ToDouble(resumeQuery.Rows[i][5].ToString()) == 0 )
                        //            if(Convert.ToDouble(resumeQuery.Rows[i][6].ToString())==0)
                        //                variacion = 0;
                        //            else
                        //                variacion = 100;
                        //        else
                        //            variacion = ((Convert.ToDouble(resumeQuery.Rows[i][6].ToString())/ Convert.ToDouble(resumeQuery.Rows[i][5].ToString())) -1) * 100;

                        //        oSheet1.Cells[fila, 9] = variacion;
                        //    }
                        //    catch { }
                        //    oSheet1.get_Range("A" + fila.ToString(), "A" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("B" + fila.ToString(), "B" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("C" + fila.ToString(), "C" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("D" + fila.ToString(), "D" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("E" + fila.ToString(), "E" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("F" + fila.ToString(), "F" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("G" + fila.ToString(), "G" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("H" + fila.ToString(), "H" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    oSheet1.get_Range("I" + fila.ToString(), "I" + fila.ToString()).BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //    fila++;

                        //}
                        ////COMBINAR
                        //oSheet1.get_Range("E1", "F2").Merge(Type.Missing);
                        //oSheet1.get_Range("G1", "H1").Merge(Type.Missing);
                        //oSheet1.get_Range("G2", "H2").Merge(Type.Missing);
                        ////TAMANOS
                        //oSheet1.get_Range("A2", "A2").RowHeight = 32;
                        //oSheet1.get_Range("A1", "A1").ColumnWidth = 25;
                        //oSheet1.get_Range("B1", "B1").ColumnWidth = 25;
                        //oSheet1.get_Range("C1", "C1").ColumnWidth = 15;
                        //oSheet1.get_Range("D1", "D1").ColumnWidth = 15;
                        //oSheet1.get_Range("E1", "E1").ColumnWidth = 17;
                        //oSheet1.get_Range("F1", "F1").ColumnWidth = 12;
                        //oSheet1.get_Range("G1", "G1").ColumnWidth = 17;
                        //oSheet1.get_Range("H1", "H1").ColumnWidth = 12;
                        //oSheet1.get_Range("I1", "I1").ColumnWidth = 15;
                        ////ALINEACIONES
                        //oSheet1.get_Range("E1", "H2").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        //oSheet1.get_Range("E1", "H2").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        //oSheet1.get_Range("G2", "H2").WrapText = true;
                        //oSheet1.get_Range("A3", "I3").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        //oSheet1.get_Range("A3", "I3").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        //oSheet1.get_Range("A3", "I3").WrapText = true;
                        ////BORDES
                        //oSheet1.get_Range("E1", "F2").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("G1", "H1").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("G2", "H2").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("A3", "A3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("B3", "B3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("C3", "C3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("D3", "D3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("E3", "E3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("F3", "F3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("G3", "G3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("H3", "H3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        //oSheet1.get_Range("I3", "I3").BorderAround(Excel.XlLineStyle.xlContinuous, Excel.XlBorderWeight.xlMedium, Excel.XlColorIndex.xlColorIndexAutomatic, Excel.XlColorIndex.xlColorIndexAutomatic);
                        ////
                        //oSheet1.Name = "Asignación de Cupo de Crédito";
                        //oXL1.Visible = true;

                    }
                }
                catch (Exception ex)
                {
                    general.mensajeERROR("Error generando la Documentación: " + ex.Message);
                }
            }
        }
    }
}