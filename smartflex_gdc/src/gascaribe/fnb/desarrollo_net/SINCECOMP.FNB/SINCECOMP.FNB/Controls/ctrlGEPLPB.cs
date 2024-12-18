using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.BL;
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlGEPLPB : UserControl
    {
        String typeUser;
        Int64 userId;
        Boolean start;
        String queryCondition;//, filename;
        BLGENERAL general = new BLGENERAL();

        public ctrlGEPLPB(String typeuser, Int64 userid)
        {
            InitializeComponent();
            start = false;
            //validaciones de usuario
            typeUser = typeuser;
            userId = userid;
            //lista de proveedor
            //combo lista de precio base
            if (typeuser == "F")
            {
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + " order by a.price_list_id");
            }
            else if (typeuser == "CV")
            {
                string filter = " and a.supplier_id in (select b.supplier_id FROM ld_catalog b WHERE b.sale_contractor_id = " + userid + ") order by a.price_list_id";
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + filter);
            }
            else
            {
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + " and a.SUPPLIER_ID = " + userId + " order by a.price_list_id");
            }
            cbPriceList.DisplayMember = "Descripcion";
            cbPriceList.ValueMember = "Codigo";
            //combo proveedor
            if (typeUser == "F")
                cbSupplier.ReadOnly = false;

            if (typeUser == "CV")
            {
                cbSupplier.DataSource = general.getValueList(BLConsultas.ProveedorCV +" AND sale_contractor_id = " + userId +" Order by ID_CONTRATISTA");
            }else
            {
                cbSupplier.DataSource = general.getValueList(BLConsultas.ProveedorC);
            }
            cbSupplier.DisplayMember = "Nombre";
            cbSupplier.ValueMember = "Identificacion";
            
            //EVESAN 04/Julio/2013
            if (typeUser == "C")
                cbSupplier.Value = userId;

            if (typeUser == "CV")
                cbSupplier.ReadOnly = false;
            
            start = true;
        }
       


        private void cbPriceList_ValueChanged(object sender, EventArgs e)
        {
            if (start && cbPriceList.SelectedRow != null)
            {
                
                start = false;
                cbVersion.DataSource = null;
                cbVersion.Text = "";
                cbVersion.DataSource = general.getValueList(BLConsultas.VersionListadePreciosC + " and lp.price_list_id=" + cbPriceList.Value.ToString());
                cbVersion.DisplayMember = "Version";
                cbVersion.ValueMember = "Version";
                start = true;
            }
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            DateTime fi, ff;
            String dfi, dff;
            queryCondition = "";
            DataTable printList = new DataTable();

            //contratista de venta
            //aprobado
            if (cbVersion.SelectedRow != null)
                queryCondition = queryCondition + "and lp.approved = 'Y' ";
            //intermedias
            if (cbPriceList.SelectedRow != null)
                queryCondition = queryCondition + "and lp.price_list_id = decode (" + cbPriceList.Value.ToString() + ", null , lp.price_list_id , " + cbPriceList.Value.ToString() + ") ";
            if (cbVersion.SelectedRow != null)
                queryCondition = queryCondition + "and lpd.version = decode (" + cbVersion.Value.ToString() + ", null, lpd.version, " + cbVersion.Value.ToString() + ") ";

            
            
            if (cbSupplier.SelectedRow != null && typeUser != "CV")
            {
                queryCondition = queryCondition + " and lp.supplier_id = decode (" + cbSupplier.Value.ToString() + ", null, lp.supplier_id, " + cbSupplier.Value.ToString() + ") ";
            }            
             

            //modificado 8.2.13
            if (ucInitialDate.Text  != "")
            {
                fi = Convert.ToDateTime(ucInitialDate.Value);
                queryCondition = queryCondition + "and trunc(lp.initial_date) >= to_date('" + fi.ToString("dd/MM/yyyy").Substring(0,10) + "','DD/MM/YYYY') ";
                dfi = fi.ToString("dd/MM/yyyy").Substring(0, 10);
            }
            else
                dfi = "";
            if (ucFinalDate.Text  != "")
            {
                ff = Convert.ToDateTime(ucFinalDate.Value);
                queryCondition = queryCondition + "and trunc(lp.final_date) <= to_date('" + ff.ToString("dd/MM/yyyy").Substring(0,10) + "','DD/MM/YYYY') ";
                dff = ff.ToString("dd/MM/yyyy").Substring(0,10);
            }
            else
                dff = "";

            queryCondition = queryCondition + " order by lp.price_list_id, a.subline_id, a.article_id"; //"order by a.subline_id, a.article_id";            

            if (typeUser != "CV")
            {
                printList = BLGEPLPB.getPrintPriceList(queryCondition, null, null);
            }
            else
            {
                printList = BLGEPLPB.getPrintPriceList(queryCondition, Convert.ToString(userId), Convert.ToString(cbSupplier.Value)); 
            }

            //Se valida que el proveedor o contratista tenga listas de precios
            if (printList.Rows.Count != 0)
            {
                //Proceso de Archivo Excel

                Excel.Application oXL = new Excel.Application();
                Excel.Workbook oWB = (Excel.Workbook)(oXL.Workbooks.Add(Missing.Value));
                Excel.Worksheet oSheet = (Excel.Worksheet)oWB.ActiveSheet;
                int posf = 1, posc = 1;
                string headera1 = string.Empty;
                string headerb1 = string.Empty;
                string headera2 = string.Empty;
                string headerb2 = string.Empty;
                string ListIdTemp = string.Empty;
                string ListId = string.Empty;
                Int64? result;
                String headeraTemp = printList.Rows[0]["sublinea"].ToString();
                headera1 = printList.Rows[0]["sublinea"].ToString();
                headera2 = printList.Rows[0]["articulo"].ToString();
                headerb1 = headera1;
                headerb2 = headera2;

                for (int fila = 0; fila < printList.Rows.Count; fila++)
                {
                    if (ListIdTemp != printList.Rows[fila]["price_list_id"].ToString())
                    {
                        posf += 2;

                        ListId = printList.Rows[fila]["price_list_id"].ToString();
                        ListIdTemp = ListId;
                        result = BLGEPLPB.addPrintPriceList(Convert.ToInt64(ListId));
                        if (result == null)
                            general.mensajeERROR("La Lista de Precios " + ListId + " ha sido generada, sin embargo hubo errores en la asignacion del consecutivo");
                        BLGEPLPB.Save();
                        //LEYENDAS

                        oSheet.Cells[posf, 1] = printList.Rows[fila]["price_list_id"].ToString() + " - " + printList.Rows[fila][1].ToString();
                        posf++;
                        //jrobayo.SAO218889. Fechas de vigencia sin hora.
                        oSheet.Cells[posf, 1] = "Vigencia " + printList.Rows[fila][14].ToString().Substring(0, 10) + " hasta " + printList.Rows[fila][15].ToString().Substring(0, 10);
                        oSheet.Cells[posf - 1, 8] = "Version " + printList.Rows[fila][16].ToString();
                        posf++;

                        int posfminus1 = posf - 1;
                        int posfminus2 = posf - 2;

                        //COMBINAR CELDAS
                        oSheet.get_Range("A" + posfminus2, "G" + posfminus2).Merge(Type.Missing);
                        oSheet.get_Range("A" + posfminus1, "G" + posfminus1).Merge(Type.Missing);
                        oSheet.get_Range("H" + posfminus2, "H" + posfminus1).Merge(Type.Missing);
                        ////TAMANOS
                        oSheet.get_Range("A" + posfminus2, "A" + posfminus2).ColumnWidth = 9;
                        oSheet.get_Range("B" + posfminus2, "B" + posfminus2).ColumnWidth = 20;
                        oSheet.get_Range("C" + posfminus2, "C" + posfminus2).ColumnWidth = 11;
                        oSheet.get_Range("D" + posfminus2, "D" + posfminus2).ColumnWidth = 11;
                        oSheet.get_Range("E" + posfminus2, "E" + posfminus2).ColumnWidth = 15;
                        oSheet.get_Range("F" + posfminus2, "F" + posfminus2).ColumnWidth = 40;
                        oSheet.get_Range("G" + posfminus2, "G" + posfminus2).ColumnWidth = 14;
                        oSheet.get_Range("H" + posfminus2, "H" + posfminus2).ColumnWidth = 25;
                        //ALINEACIONES
                        oSheet.get_Range("A" + posfminus2, "A" + posfminus2).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        oSheet.get_Range("A" + posfminus2, "A" + posfminus2).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        oSheet.get_Range("A" + posfminus1, "A" + posfminus1).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        oSheet.get_Range("A" + posfminus1, "A" + posfminus1).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        oSheet.get_Range("H" + posfminus2, "H" + posfminus2).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        oSheet.get_Range("H" + posfminus2, "H" + posfminus2).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                        headera1 = printList.Rows[fila]["sublinea"].ToString();
                        headera2 = printList.Rows[fila]["articulo"].ToString();
                        oSheet.Cells[posf, posc] = headera1 + " - " + printList.Rows[fila]["sublinead"].ToString();

                        oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).Merge(Type.Missing);
                        oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                        oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                        
                        headerb1 = headera1;
                        headerb2 = headera2;
                        
                        posf++;
                        oSheet.Cells[posf, 1] = "Artículo";
                        oSheet.Cells[posf, 2] = "Descripción";
                        oSheet.Cells[posf, 3] = "Marca";
                        oSheet.Cells[posf, 4] = "Referencia";
                        oSheet.Cells[posf, 5] = "Precio";
                        oSheet.Cells[posf, 6] = "Propiedades";
                        oSheet.Cells[posf, 7] = "Garantia Meses";
                        oSheet.Cells[posf, 8] = "Proveedor";
                        posf++;
                    }
                    
                    headera1 = printList.Rows[fila]["sublinea"].ToString();
                    headera2 = printList.Rows[fila]["articulo"].ToString();

                    if (headera1 != headerb1 || headera2 != headerb2)
                    {
                        if (headera1 != headeraTemp)
                        {
                            oSheet.Cells[posf, posc] = headera1 + " - " + printList.Rows[fila]["sublinead"];
                            headeraTemp = headera1;

                            oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).Merge(Type.Missing);
                            oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                            oSheet.get_Range("A" + posf.ToString(), "H" + posf.ToString()).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                            headerb1 = headera1;
                            headerb2 = headera2;
                            posf++;
                            oSheet.Cells[posf, 1] = "Artículo";
                            oSheet.Cells[posf, 2] = "Descripción";
                            oSheet.Cells[posf, 3] = "Marca";
                            oSheet.Cells[posf, 4] = "Referencia";
                            oSheet.Cells[posf, 5] = "Precio";
                            oSheet.Cells[posf, 6] = "Propiedades";
                            oSheet.Cells[posf, 7] = "Garantia Meses";
                            oSheet.Cells[posf, 8] = "Proveedor";
                            posf++;
                        }
                    }
                    oSheet.Cells[posf, 1] = printList.Rows[fila]["articulo"];
                    oSheet.Cells[posf, 2] = printList.Rows[fila]["descripcion"];
                    oSheet.Cells[posf, 3] = printList.Rows[fila]["marca"];
                    oSheet.Cells[posf, 4] = printList.Rows[fila]["referencia"];
                    oSheet.get_Range("E" + posf.ToString(), "E" + posf.ToString()).NumberFormat = "_ $ * #.##0,00";
                    oSheet.Cells[posf, 5] = Convert.ToDouble(printList.Rows[fila]["precio"].ToString());
                    String properties = printList.Rows[fila]["propiedades"].ToString();
                    oSheet.get_Range("F" + posf.ToString(), "F" + posf.ToString()).WrapText = true;
                    if (properties.Length > 0)
                        oSheet.Cells[posf, 6] = properties.Substring(0, properties.Length - 1).Replace("|", ", ").ToString();
                    else
                        oSheet.Cells[posf, 6] = "";
                    oSheet.Cells[posf, 7] = printList.Rows[fila]["garantia"];
                    oSheet.Cells[posf, 8] = printList.Rows[fila]["proveedor"];
                    posf++;
                }
                oSheet.Name = "Lista de Precios";
                oXL.Visible = true;
            }
            else
            {
                general.mensajeERROR("No se encontraron listas de precios con los criterios de busqueda");
            }
        }
        ///EVESAN 04/Julio/2013
        ///Metodo para darle funcionalidad al contratista de venta, y pueda imprimir listas de precios de 
        ///los proveedores existentes
        private void cbSupplier_ValueChanged(object sender, EventArgs e)
        {
            if (cbSupplier.Value != null)
            {
                cbPriceList.Value = null;
                cbPriceList.DataSource = null;
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + " and SUPPLIER_ID = " + cbSupplier.Value + " order by price_list_id");
            }
            else
                cbPriceList.DataSource = null;
        }
        /////////////////////******************************************
        
    }
}
