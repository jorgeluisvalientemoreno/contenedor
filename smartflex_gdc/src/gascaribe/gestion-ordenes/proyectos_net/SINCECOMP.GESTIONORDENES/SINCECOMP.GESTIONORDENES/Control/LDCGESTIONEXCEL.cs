using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
//
//using System.Text;
//using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;
using SINCECOMP.GESTIONORDENES.BL;
using SINCECOMP.GESTIONORDENES.DAL;


namespace SINCECOMP.GESTIONORDENES.Control
{
    public partial class LDCGESTIONEXCEL : UserControl
    {

        DALLEGO oDALLEGO = new DALLEGO();
        BLGENERAL general = new BLGENERAL();

        public LDCGESTIONEXCEL()
        {
            InitializeComponent();


            //DataTable tipotrab = general.getValueList("select lol.task_type_id CODIGO, lol.task_type_id || ' ' || daor_task_type.fsbgetdescription(lol.task_type_id,null) DESCRIPCION from ldc_otlegalizar lol where lol.legalizado = 'N' group by lol.task_type_id ORDER BY 1");
            //DataTable tipotrab = general.getValueList("select -1 CODIGO,'TODOS' DESCRIPCION from dual union select distinct lol.task_type_id CODIGO,daor_task_type.fsbgetdescription(lol.task_type_id, null) DESCRIPCION from ldc_otlegalizar   lol, ldc_anexolegaliza la, ldc_otadicional   lo, ldc_usualego      lu where lol.legalizado = 'N' and lol.order_id = la.order_id and lol.order_id = lo.order_id and la.agente_id = lu.agente_id and lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID order by 1");
            DataTable tipotrab = general.getValueList("select -1 CODIGO,'TODOS' DESCRIPCION from dual union select distinct lol.task_type_id CODIGO,daor_task_type.fsbgetdescription(lol.task_type_id, null) DESCRIPCION from ldc_otlegalizar   lol, ldc_anexolegaliza la, ldc_usualego      lu where lol.legalizado = 'N' and lol.order_id = la.order_id and la.agente_id = lu.agente_id and lu.person_id = OPEN.GE_BOPERSONAL.FNUGETPERSONID order by 1");
            this.ocbTipoTrab.DataSource = tipotrab;
            this.ocbTipoTrab.DisplayMember = "DESCRIPCION";
            this.ocbTipoTrab.ValueMember = "CODIGO";
            this.ocbTipoTrab.Value = -1;

            ocbHasta.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
            ocbDesde.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();

        }

        private void obReporte_Click(object sender, EventArgs e)
        {

            //MessageBox.Show(ocbTipoTrab.Value.ToString());
            //MessageBox.Show(ocbDesde.TextBoxObjectValue.ToString());
            //MessageBox.Show(ocbHasta.TextBoxObjectValue.ToString());


            if (String.IsNullOrEmpty(ocbDesde.TextBoxObjectValue.ToString()))
            {
                ocbDesde.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
            }
            if (String.IsNullOrEmpty(ocbHasta.TextBoxObjectValue.ToString()))
            {
                ocbHasta.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
            }

            //DataTable BasicDateExcel = DALLEGO.FrfOrdenGestionExcel(Convert.ToInt64(ocbTipoTrab.Value), (DateTime)ocbDesde.TextBoxObjectValue, (DateTime)ocbHasta.TextBoxObjectValue);
            DataTable BasicDateExcel = DALLEGO.FrfOrdenLEGO(Convert.ToInt64(ocbTipoTrab.Value), (DateTime)ocbDesde.TextBoxObjectValue, (DateTime)ocbHasta.TextBoxObjectValue);
            if (BasicDateExcel.Rows.Count > 0)
            {

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                //iniicalizar datos basicos de la orden
                //ulbOrden.Text = dtgTrabAdic.ActiveCell.Value.ToString();
                //ulbDepartamento.Text = BasicDate.Rows[0]["departamento"].ToString();

                Excel.Application oXL = new Excel.Application();
                Excel.Workbook oWB = (Excel.Workbook)(oXL.Workbooks.Add(Missing.Value));
                Excel.Worksheet oSheet = (Excel.Worksheet)oWB.ActiveSheet;

                //LEYENDAS
                //oSheet.Cells[1, 1] = "ORDEN";
                //oSheet.Cells[1, 2] = "CAUSAL";
                //oSheet.Cells[1, 3] = "TECNICO";
                //oSheet.Cells[1, 4] = "OBSERVACION";
                //oSheet.Cells[1, 5] = "ITEM";
                //oSheet.Cells[1, 6] = "ITEM_CANTIDAD";
                //oSheet.Cells[1, 7] = "TIPO TRAB ADICIONAL";
                //oSheet.Cells[1, 8] = "ACTIVIDAD ADICIONAL";
                //oSheet.Cells[1, 9] = "MATERIAL";
                //oSheet.Cells[1, 10] = "CANTIDAD";
                //oSheet.Cells[1, 11] = "PRODUCTO";
                //oSheet.Cells[1, 12] = "SOLICITUD";
                //oSheet.Cells[1, 13] = "UNIDAD_TRABAJO";
                //oSheet.Cells[1, 14] = "UNIDAD_TRABAJO_DESCRIPCION";
                //oSheet.Cells[1, 15] = "CICLO";
                //oSheet.Cells[1, 16] = "ERROR";
                //oSheet.Cells[1, 17] = "DATO ADICIONAL OT PRINICPAL";
                //oSheet.Cells[1, 18] = "VALOR DATO ADICIONAL OT PRINICPAL";
                //oSheet.Cells[1, 19] = "DATO ADICIONAL OT ADICIONAL";
                //oSheet.Cells[1, 20] = "VALOR DATO ADICIONAL OT ADICIONAL";

                oSheet.Cells[1, 1] = "ORDEN";
                oSheet.Cells[1, 2] = "TIPO TRABAJO";
                oSheet.Cells[1, 3] = "CAUSAL";
                oSheet.Cells[1, 4] = "TECNICO";
                oSheet.Cells[1, 5] = "OBSERVACION";
                oSheet.Cells[1, 6] = "ITEM";
                oSheet.Cells[1, 7] = "ITEM_CANTIDAD";
                oSheet.Cells[1, 8] = "DATO ADICIONAL OT PRINICPAL";
                oSheet.Cells[1, 9] = "VALOR DATO ADICIONAL OT PRINICPAL";
                oSheet.Cells[1, 10] = "TIPO TRAB ADICIONAL";
                oSheet.Cells[1, 11] = "CAUSAL";
                oSheet.Cells[1, 12] = "ACTIVIDAD ADICIONAL";
                oSheet.Cells[1, 13] = "MATERIAL";
                oSheet.Cells[1, 14] = "CANTIDAD";
                oSheet.Cells[1, 15] = "DATO ADICIONAL OT ADICIONAL";
                oSheet.Cells[1, 16] = "VALOR DATO ADICIONAL OT ADICIONAL";
                oSheet.Cells[1, 17] = "COMPONENTES ACTIVIDAD OT ADICIONAL";
                oSheet.Cells[1, 18] = "PRODUCTO";
                oSheet.Cells[1, 19] = "SOLICITUD";
                oSheet.Cells[1, 20] = "UNIDAD_TRABAJO";
                oSheet.Cells[1, 21] = "UNIDAD_TRABAJO_DESCRIPCION";
                oSheet.Cells[1, 22] = "CICLO";
                oSheet.Cells[1, 23] = "ERROR";
                

                Int64 nuRow = 2;
                //Int64 nuColumn;


                foreach (DataRow row in BasicDateExcel.Rows)
                {

                    oSheet.Cells[nuRow, 1] = row["ORDEN"].ToString();
                    oSheet.Cells[nuRow, 2] = row["TIPO_TRABAJO"].ToString() + " - " + row["DESCRIPCION_TIPO_TRABAJO"].ToString();
                    oSheet.Cells[nuRow, 3] = row["CAUSAL"].ToString();
                    oSheet.Cells[nuRow, 4] = row["TECNICO"].ToString() + " - " + row["NOMBRE_TECNICO"].ToString();
                    oSheet.Cells[nuRow, 5] = row["OBSERVACION"].ToString();
                    //oSheet.Cells[nuRow, 6] = row["ITEM"].ToString();
                    //oSheet.Cells[nuRow, 7] = row["ITEM_CANTIDAD"].ToString();
                    //oSheet.Cells[nuRow, 8] = row["DATO_ADICIONAL_GESTION"].ToString();
                    //oSheet.Cells[nuRow, 9] = row["VALOR_DATO_ADICIONAL_GESTION"].ToString();                    
                    //oSheet.Cells[nuRow, 10] = row["TIPO_TRABAJO"].ToString();
                    //oSheet.Cells[nuRow, 11] = row["CAUSAL"].ToString();
                    //oSheet.Cells[nuRow, 12] = row["ACTIVIDAD"].ToString();
                    //oSheet.Cells[nuRow, 13] = row["MATERIAL"].ToString();
                    //oSheet.Cells[nuRow, 14] = row["CANTIDAD"].ToString();
                    //oSheet.Cells[nuRow, 15] = row["DATO_ADICIONAL"].ToString();
                    //oSheet.Cells[nuRow, 16] = row["VALOR_DATO_ADICIONAL"].ToString();
                    //oSheet.Cells[nuRow, 17] = "COMPONENTES ACTIVIDAD OT ADICIONAL";                
                    oSheet.Cells[nuRow, 18] = row["PRODUCTO"].ToString();
                    oSheet.Cells[nuRow, 19] = row["SOLICITUD"].ToString();
                    oSheet.Cells[nuRow, 20] = row["UNIDAD_TRABAJO"].ToString();
                    oSheet.Cells[nuRow, 21] = row["UNIDAD_TRABAJO_DESCRIPCION"].ToString();
                    oSheet.Cells[nuRow, 22] = row["CICLO"].ToString();
                    oSheet.Cells[nuRow, 23] = row["ERROR"].ToString();

                    oSheet.get_Range(oSheet.Cells[nuRow, 4], oSheet.Cells[nuRow, 4]).RowHeight = 15;
                    //oSheet.get_Range(oSheet.Cells[nuRow, 15], oSheet.Cells[nuRow, 15]).RowHeight = 15;


                    //Ciclo para los mostrar los items de la orden principal
                    Int64 ItemnuRow = nuRow;
                    DataTable DTFrfItemOrdenLEGO = DALLEGO.FrfItemOrdenLEGO(Convert.ToInt64(row["ORDEN"].ToString()));
                    if (DTFrfItemOrdenLEGO.Rows.Count > 0)
                    {
                        foreach (DataRow Itemrow in DTFrfItemOrdenLEGO.Rows)
                        {
                            oSheet.Cells[ItemnuRow, 1] = row["ORDEN"].ToString();
                            oSheet.Cells[ItemnuRow, 6] = Itemrow["ITEM"].ToString();
                            oSheet.Cells[ItemnuRow, 7] = Itemrow["ITEM_CANTIDAD"].ToString();
                            ItemnuRow++;
                        }
                    }

                    Int64 NuClasificadorCausal = 0;
                    NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(Convert.ToInt64(row["CODIGO_CAUSAL"].ToString()));
                    Int64 DAnuRow = nuRow;
                    //////////////////

                    if (NuClasificadorCausal == 1)
                    {
                        //Ciclo para los mostrar los datos adicionales de la orden principal
                        DataTable DTFrfDAOrdenLEGO = DALLEGO.FrfDAOrdenLEGO(Convert.ToInt64(row["ORDEN"].ToString()));
                        if (DTFrfDAOrdenLEGO.Rows.Count > 0)
                        {
                            foreach (DataRow DArow in DTFrfDAOrdenLEGO.Rows)
                            {
                                oSheet.Cells[DAnuRow, 1] = row["ORDEN"].ToString();
                                oSheet.Cells[DAnuRow, 8] = DArow["DATO_ADICIONAL_GESTION"].ToString();
                                oSheet.Cells[DAnuRow, 9] = DArow["VALOR_DATO_ADICIONAL_GESTION"].ToString();
                                DAnuRow++;
                            }
                        }
                    }

                    //Ciclo para los mostrar los trabajos adicionales de la orden principal
                    Int64 TAnuRow = nuRow;
                    DataTable DTFrfTAOrdenLEGO = DALLEGO.FrfTAOrdenLEGO(Convert.ToInt64(row["ORDEN"].ToString()));
                    if (DTFrfTAOrdenLEGO.Rows.Count > 0)
                    {
                        foreach (DataRow TArow in DTFrfTAOrdenLEGO.Rows)
                        {
                            oSheet.Cells[TAnuRow, 1] = row["ORDEN"].ToString();
                            oSheet.Cells[TAnuRow, 10] = TArow["TIPO_TRABAJO"].ToString();
                            oSheet.Cells[TAnuRow, 11] = TArow["CAUSAL"].ToString() + " - " + TArow["DESCRIPCION_CAUSAL"].ToString();
                            oSheet.Cells[TAnuRow, 12] = TArow["ACTIVIDAD"].ToString();
                            oSheet.Cells[TAnuRow, 13] = TArow["MATERIAL"].ToString() + " - " + TArow["DESCRIPCION_MATERIAL"].ToString();
                            oSheet.Cells[TAnuRow, 14] = TArow["CANTIDAD"].ToString();

                            //////////Dato adicional del ripo de trabajo adicional
                            Int64 NuClasificadorCausalDATA = 0;
                            NuClasificadorCausalDATA = DALLEGO.FnuClasificadorCausal(Convert.ToInt64(TArow["CAUSAL"].ToString()));
                            Int64 DATAnuRow = TAnuRow;
                            //////////////////

                            if (NuClasificadorCausalDATA == 1)
                            {
                                //Ciclo para los mostrar los datos adicionales de la orden principal
                                DataTable DTFrfDATAOrdenLEGO = DALLEGO.FrfDATAOrdenLEGO(Convert.ToInt64(row["ORDEN"].ToString()), Convert.ToInt64(TArow["CODIGO_TIPO_TRABAJO"].ToString()), Convert.ToInt64(TArow["CODIGO_ACTIVIDAD"].ToString()), Convert.ToInt64(TArow["MATERIAL"].ToString()));
                                if (DTFrfDATAOrdenLEGO.Rows.Count > 0)
                                {
                                    foreach (DataRow DArow in DTFrfDATAOrdenLEGO.Rows)
                                    {
                                        oSheet.Cells[DATAnuRow, 1] = row["ORDEN"].ToString();
                                        oSheet.Cells[DATAnuRow, 15] = DArow["DATO_ADICIONAL"].ToString();
                                        oSheet.Cells[DATAnuRow, 16] = DArow["VALOR_DATO_ADICIONAL"].ToString();
                                        DATAnuRow++;
                                    }
                                }

                                //Ciclo para los mostrar los componentes de la actividad de la OT adicional
                                Int64 ACOAnuRow = nuRow; 
                                DataTable DTFrfCAOTAdicionalLEGO = DALLEGO.FrfCAOTAdicionalLEGO(Convert.ToInt64(row["ORDEN"].ToString()), Convert.ToInt64(TArow["CODIGO_ACTIVIDAD"].ToString()));
                                if (DTFrfCAOTAdicionalLEGO.Rows.Count > 0)
                                {
                                    foreach (DataRow DArow in DTFrfCAOTAdicionalLEGO.Rows)
                                    {
                                        oSheet.Cells[ACOAnuRow, 1] = row["ORDEN"].ToString();
                                        oSheet.Cells[ACOAnuRow, 16] = DArow["NOMBRE"].ToString() + " [ " + DArow["VALOR_ATRIBUTO"].ToString() + " ] [ " + DArow["VALOR_COMPONENTE"].ToString() + " ]";
                                        ACOAnuRow++;
                                    }
                                }


                            }
                            //////////////////////////////////////////////////////////////

                            if (DATAnuRow > TAnuRow)
                            {
                                TAnuRow = DATAnuRow;
                            }
                            else
                            {
                                TAnuRow++;
                            }
                        }
                    }

                    //////////////////////////////////////////////
                    if (ItemnuRow > nuRow)
                    {
                        nuRow = ItemnuRow;
                    }

                    if (TAnuRow > nuRow)
                    {
                        nuRow = TAnuRow;
                    }

                    if (DAnuRow > nuRow)
                    {
                        nuRow = DAnuRow;
                    }

                    nuRow++;


                }

                oSheet.Name = "Ordenes Gestionadas";
                //oXL.ActiveWorkbook.Close(true, filename + ".xlsx", Type.Missing);
                //oXL.Quit();
                //oXL.Workbooks.Open(filename + ".xlsx", Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing);
                oXL.Visible = true;
                oXL.WindowState = Microsoft.Office.Interop.Excel.XlWindowState.xlMaximized;

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

            }
        }
    }
}
