using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;
using LDCGESTTA.BL;
using System.Data;
using System.IO;


namespace LDCGESTTA.Metodos
{
    class FileExcel
    {
        BLUtilities utilities = new BLUtilities();
        ArchivoPlano ArchPlano = new ArchivoPlano();
        BLLDC_GESTTA blLDC_FCVC = new BLLDC_GESTTA();

        public Int64 ReadExcel(string sbPath, string fileName, Int64 CodProyecto, Int64 TipoServ)
        {
            Excel.Application xlApp ;
            Excel.Workbook xlWorkBook ;
            Excel.Worksheet xlWorkSheet ;
            Excel.Range range ;

            string str;
            string strfull = "";
            int LineaExcel ;
            int cCnt ;
            int rw = 0;
            int cl = 0;
            Int64 ValMensajeError = 0;

            xlApp = new Excel.Application();
            xlWorkBook = xlApp.Workbooks.Open(@sbPath, 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
            xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

            range = xlWorkSheet.UsedRange;
            rw = range.Rows.Count;
            cl = range.Columns.Count;

            // variables para manejar errores y procesos de la cabecera de la forma .NET//
            Int64 onuErrorCode;
            String osbErrorMessage;

            // se valida si existe el archivo, si existe se elimina y se vuelve a crear
            if (File.Exists(fileName))
            {
                File.Delete(fileName);
            }

            using (StreamWriter sw = File.CreateText(fileName))
            {
                for (LineaExcel = 2; LineaExcel <= rw; LineaExcel++)
                {

                    String sbDescripcion = Convert.ToString((range.Cells[LineaExcel, 1] as Excel.Range).Value2);
                    Int64 nuMercaRelevante = Convert.ToInt64((range.Cells[LineaExcel, 2] as Excel.Range).Value2);
                    String sbtipoMoneda = Convert.ToString((range.Cells[LineaExcel, 3] as Excel.Range).Value2);
                    Int64 nutarifaConcepto = Convert.ToInt64((range.Cells[LineaExcel, 4] as Excel.Range).Value2);
                    Double nuRangoInicial = Convert.ToDouble((range.Cells[LineaExcel, 5] as Excel.Range).Value2);
                    Double nuRangoFinal = Convert.ToDouble((range.Cells[LineaExcel, 6] as Excel.Range).Value2);
                    Int64 nuCategoria = Convert.ToInt64((range.Cells[LineaExcel, 7] as Excel.Range).Value2);
                    Int64 nuestrato = Convert.ToInt64((range.Cells[LineaExcel, 8] as Excel.Range).Value2);
                    Double nuValorMonetario = Convert.ToDouble((range.Cells[LineaExcel, 9] as Excel.Range).Value2);
                    Double nuValorPorcentaje = Convert.ToDouble((range.Cells[LineaExcel, 10] as Excel.Range).Value2);
                    Double nuTarifaDirecta = Convert.ToDouble((range.Cells[LineaExcel, 11] as Excel.Range).Value2);
                    Double nuPorceTaDirecta = Convert.ToDouble((range.Cells[LineaExcel, 12] as Excel.Range).Value2);


                    blLDC_FCVC.ProcesarInfoExcel(CodProyecto, sbDescripcion, nuMercaRelevante,
                                                  TipoServ, sbtipoMoneda, nutarifaConcepto,
                                                  nuRangoInicial, nuRangoFinal, nuCategoria,
                                                  nuestrato, nuValorMonetario, nuValorPorcentaje,
                                                  nuTarifaDirecta, nuPorceTaDirecta,
                                                  LineaExcel, out  onuErrorCode, out  osbErrorMessage);


                    // se llama al proceso que genera el TXT
                    // Se crea el archivo y se escribe sobre él
                    if (onuErrorCode == 0)
                    {
                        sw.WriteLine("Linea = " + LineaExcel + " OK");
                    }
                    else
                    {
                        sw.WriteLine("ERRROR!! en Linea = " + LineaExcel + ", Codigo Error= [" + onuErrorCode + "], Mensaje Error= [" + osbErrorMessage + "]");
                        ValMensajeError = 1;
                    }
                    

                }

                xlWorkBook.Close(true, null, null);
                xlApp.Quit();

                Marshal.ReleaseComObject(xlWorkSheet);
                Marshal.ReleaseComObject(xlWorkBook);
                Marshal.ReleaseComObject(xlApp);
            }

            return Convert.ToInt64(ValMensajeError);
        
        }

            


        public void CrearExcel(DataTable BasicDataTarifas)
        {
            Excel.Application xlApp = new Microsoft.Office.Interop.Excel.Application();

            if (xlApp == null)
            {
                utilities.DisplayErrorMessage("Error!! No se tiene la propiedad xlApp instalada.");
            }
            else
            {
                Excel.Workbook xlWorkBook;
                Excel.Worksheet xlWorkSheet;
                object misValue = System.Reflection.Missing.Value;

                xlWorkBook = xlApp.Workbooks.Add(misValue);
                xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

                xlWorkSheet.Cells[1, 1] = "Descripcion";
                xlWorkSheet.Cells[1, 2] = "Mercado Relevante";
                xlWorkSheet.Cells[1, 3] = "Tipo Moneda";
                xlWorkSheet.Cells[1, 4] = "Tarifa Concepto";
                xlWorkSheet.Cells[1, 5] = "Rango Inicial";
                xlWorkSheet.Cells[1, 6] = "Rango Final";
                xlWorkSheet.Cells[1, 7] = "Categoria";
                xlWorkSheet.Cells[1, 8] = "Estrato";
                xlWorkSheet.Cells[1, 9] = "Valor Monetario";
                xlWorkSheet.Cells[1, 10] = "Valor Porcentaje";
                xlWorkSheet.Cells[1, 11] = "Tarifa Directa";
                xlWorkSheet.Cells[1, 12] = "Porcentaje Tarifa Directa";

                Int64 Filas = 2;

                for (int i = 0; i < BasicDataTarifas.Rows.Count; i++)
                {
                    xlWorkSheet.Cells[Filas, 1] = BasicDataTarifas.Rows[i]["Descripcion"].ToString();
                    xlWorkSheet.Cells[Filas, 2] = BasicDataTarifas.Rows[i]["Mercado_relevante"].ToString();
                    xlWorkSheet.Cells[Filas, 3] = BasicDataTarifas.Rows[i]["Tipo_Moneda"].ToString();
                    xlWorkSheet.Cells[Filas, 4] = BasicDataTarifas.Rows[i]["tarifa_concepto"].ToString();
                    xlWorkSheet.Cells[Filas, 5] = BasicDataTarifas.Rows[i]["rango_inicial"].ToString();
                    xlWorkSheet.Cells[Filas, 6] = BasicDataTarifas.Rows[i]["rango_final"].ToString();
                    xlWorkSheet.Cells[Filas, 7] = BasicDataTarifas.Rows[i]["categoria"].ToString();
                    xlWorkSheet.Cells[Filas, 8] = BasicDataTarifas.Rows[i]["estrato"].ToString();
                    xlWorkSheet.Cells[Filas, 9] = BasicDataTarifas.Rows[i]["valor_monetario"].ToString();
                    xlWorkSheet.Cells[Filas, 10] = BasicDataTarifas.Rows[i]["valor_porcentaje"].ToString();
                    xlWorkSheet.Cells[Filas, 9] = BasicDataTarifas.Rows[i]["valor_monetario"].ToString();
                    xlWorkSheet.Cells[Filas, 10] = BasicDataTarifas.Rows[i]["valor_porcentaje"].ToString();
                    xlWorkSheet.Cells[Filas, 11] = BasicDataTarifas.Rows[i]["tarifa_directa"].ToString();
                    xlWorkSheet.Cells[Filas, 12] = BasicDataTarifas.Rows[i]["porc_tarifa_directa"].ToString();

                    Filas++;

                }

                // se llama al proceso SavefileDialog para elegir en donde se guardará el archivo

                SaveFileDialog saveFiledialog = new SaveFileDialog();
                saveFiledialog.Filter = "Excel file |*.xls";
                saveFiledialog.Title = "Guardar Archivo Excel";
                String RutaCreateFile = ""; 

                if(saveFiledialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    RutaCreateFile = saveFiledialog.FileName;
                }

                xlWorkBook.SaveAs(RutaCreateFile, Excel.XlFileFormat.xlWorkbookNormal, misValue, misValue, misValue, misValue, Excel.XlSaveAsAccessMode.xlExclusive, misValue, misValue, misValue, misValue, misValue);
                xlWorkBook.Close(true, misValue, misValue);
                xlApp.Quit();

                Marshal.ReleaseComObject(xlWorkSheet);
                Marshal.ReleaseComObject(xlWorkBook);
                Marshal.ReleaseComObject(xlApp);

                utilities.DisplayInfoMessage("El archivo de Excel Se creo con exito en la ruta: " + RutaCreateFile);
            }

            
        
        }



    }
}
