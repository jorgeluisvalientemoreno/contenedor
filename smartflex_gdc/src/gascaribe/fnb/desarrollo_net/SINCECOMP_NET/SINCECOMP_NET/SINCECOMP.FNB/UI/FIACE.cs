using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using System.Collections;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using System.IO;
using Infragistics.Excel;
using System.Data.OleDb;
using OpenSystems.Common.ExceptionHandler;
using SINCECOMP.FNB.Controls;

//
//using Infragistics.Excel; //Excel = Microsoft.Office.Interop.Excel;

namespace SINCECOMP.FNB.UI
{
    public partial class FIACE : OpenForm
    {
        BindingSource customerbinding = new BindingSource();
        Boolean start;
        String errMsg = null;
        //columnas extra cupo
        String a = "ExtraQuotaId";
        String b = "SupplierId";
        String c = "CategoryId";
        String d = "SubCategoryId";
        String e = "GeograpLocationId";
        String f = "SaleChanelId";
        String g = "QuotaOption";
        String h = "Value";
        String i = "LineId";
        String j = "SubLineId";
        String k = "InitialDate";
        String l = "FinalDate";
        String m = "Observation";
        String n = "Document";
        String o = "CheckSave";
        String p = "CheckModify";
        String q = "FilePath";
        String r = "TypeDate";
        //
        BLGENERAL general = new BLGENERAL();

        public FIACE()
        {
            InitializeComponent();
            start = false;
            List<ExtraFIACE> ListExtraQuota = new List<ExtraFIACE>();
            ListExtraQuota = BLFIACE.FcuExtraQuota();
            customerbinding.DataSource = ListExtraQuota;
            bnNavigator.BindingSource = customerbinding;
            dgExtraCupo.DataSource = customerbinding;
            //quota option
            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("V", "Valor"));
            lista.Add(new ListSN("P", "Porcentaje"));
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;
            UltraDropDown dropDownsn = new UltraDropDown();
            dropDownsn.DataSource = tabla;
            dropDownsn.ValueMember = "Id";
            dropDownsn.DisplayMember = "Description";
            //
            dropDownsn.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[g].ValueList = dropDownsn;
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[g].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[g].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //combo Proveedor en grid
            dgExtraCupo.DisplayLayout.Bands[0].Columns[b].ValueList = general.valuelistNumberId(BLConsultas.Proveedor, "NOMBRE", "IDENTIFICACION");
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[b].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[b]..Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            //dgExtraCupo.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            //bool descending = false;
            //dgExtraCupo.DisplayLayout.Bands[0].SortedColumns.Add(b, descending);
            //propiedad para validar contenido
            //dgCommission.DisplayLayout.Bands[0].Columns[h].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[b].FilterOperatorDropDownItems = FilterOperatorDropDownItems.All; //Infragistics.Win.UltraWinGrid..HeaderClickAction .SortMulti;
            //this.cbPriceList.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[b].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //combo categoria
            dgExtraCupo.DisplayLayout.Bands[0].Columns[c].ValueList = general.valuelistNumberId(BLConsultas.Categoria, "DESCRIPCION", "CODIGO");
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[c].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[c].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //combo subcategoria
            int conteo;
            for (conteo = 0; conteo <= dgExtraCupo.Rows.Count - 1; conteo++)
            {
                dgExtraCupo.Rows[conteo].Cells[d].ValueList = null;
                if (dgExtraCupo.Rows[conteo].Cells[c].Value.ToString() == " ")
                    dgExtraCupo.Rows[conteo].Cells[d].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                else
                    dgExtraCupo.Rows[conteo].Cells[d].ValueList = general.valuelistNumberId(BLConsultas.SubCategoria + " where Sucacodi != -1 AND sucacate = " + dgExtraCupo.Rows[conteo].Cells[c].Value.ToString() + " Order by Sucacodi", "DESCRIPCION", "CODIGO");
                //
                dgExtraCupo.DisplayLayout.Bands[0].Columns[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                //
                //dgExtraCupo.Rows[conteo].Cells[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            }
            //combo ubicacion geografica
            
            /// SAO 214255 Se cambia por el component de ubicaciones geograficas
            UltraCombo ucbGeographLocation = new ListOfValues().SetTreeLov(BLConsultas.UbicacionGeograficaTree, "Ubicación Geográfica");
            ucbGeographLocation.Tag = dgExtraCupo.DisplayLayout.Bands[0].Columns[e];
            dgExtraCupo.DisplayLayout.Bands[0].Columns[e].EditorControl = ucbGeographLocation;               
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[e].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[e].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //linea
            dgExtraCupo.DisplayLayout.Bands[0].Columns[i].ValueList = general.valuelistNumberId(BLConsultas.LineasControladas, "DESCRIPCION", "CODIGO");
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[i].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[i].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //sublinea
            for (conteo = 0; conteo <= dgExtraCupo.Rows.Count - 1; conteo++)
            {
                dgExtraCupo.Rows[conteo].Cells[j].ValueList = null;
                if (dgExtraCupo.Rows[conteo].Cells[i].Value.ToString() == " ")
                    dgExtraCupo.Rows[conteo].Cells[j].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                else
                    dgExtraCupo.Rows[conteo].Cells[j].ValueList = general.valuelistNumberId(BLConsultas.ListadoSublineas + " where line_id = " + dgExtraCupo.Rows[conteo].Cells[i].Value.ToString() + " And Approved='Y' Order By Subline_id", "DESCRIPCION", "CODIGO");
                //
                dgExtraCupo.DisplayLayout.Bands[0].Columns[j].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;                
            }
            //canales de venta
            dgExtraCupo.DisplayLayout.Bands[0].Columns[f].ValueList = general.valuelistNumberId(BLConsultas.CanalesdeVenta, "DESCRIPCION", "CODIGO");
            //
            dgExtraCupo.DisplayLayout.Bands[0].Columns[f].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //dgExtraCupo.DisplayLayout.Bands[0].Columns[f].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //documento
            //columna con busqueda de archivo
            dgExtraCupo.DisplayLayout.Bands[0].Columns[n].CellActivation = Activation.NoEdit;
            UltraGridColumn _colCode = dgExtraCupo.DisplayLayout.Bands[0].Columns[n];
            _colCode.CellAppearance.TextHAlign = Infragistics.Win.HAlign.Left;
            _colCode.ButtonDisplayStyle = Infragistics.Win.UltraWinGrid.ButtonDisplayStyle.Always;
            _colCode.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.EditButton;
            _colCode.CellDisplayStyle = CellDisplayStyle.FullEditorDisplay;
            //ocultar columnas            
            dgExtraCupo.DisplayLayout.Bands[0].Columns[o].Hidden = true;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[p].Hidden = true;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[q].Hidden = true;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[r].Hidden = true;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[a].CellAppearance.TextHAlign = HAlign.Right;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[a].CellActivation = Activation.NoEdit;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[a].CellAppearance.BackColor = Color.LightGray;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[h].CellAppearance.TextHAlign = HAlign.Right;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[h].MaskInput = "nnnnnnnnnnnnn.nn"; //EVESAN
            dgExtraCupo.DisplayLayout.Bands[0].Columns[h].MaxLength = 18;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[h].MaxValue = 999999999999999.99;
            dgExtraCupo.DisplayLayout.Bands[0].Columns[h].Format = "#,##0.00";
            dgExtraCupo.DisplayLayout.Bands[0].Columns[m].MaxLength = 200;
            //campos obligatorios
            String[] fieldsextra = new string[] { g, h, k, l, m };
            general.setColumnRequiered(dgExtraCupo, fieldsextra);
            //
            String[] fieldsupper = new string[] { b, c, d, e, f, g, i, j, m };
            general.setColumnUpper(dgExtraCupo, fieldsupper);
            start = true;
        }

        private void bindingNavigatorAddNewItem_Click(object sender, EventArgs et)
        {
            customerbinding.Add(BLFIACE.AddRowList());
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[b].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[c].Value = "";
            start = false;
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[d].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[d].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[j].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[j].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
            start = true;
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[e].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[f].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[g].Value = "V";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[i].Value = " ";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[n].Value = "No";
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[o].Value = 1;
            dgExtraCupo.Rows[dgExtraCupo.Rows.Count - 1].Cells[a].Value = BLFIACE.consExtraQuota();
            bindingNavigatorMoveLastItem.PerformClick();
        }

        private void dgExtraCupo_CellChange(object sender, CellEventArgs et)
        {
            dgExtraCupo.Rows[et.Cell.Row.Index].Cells[p].Value = 1;
            if (et.Cell.Column.Key == m && dgExtraCupo.ActiveRow.Cells[m].Text == "")
                dgExtraCupo.ActiveRow.Cells[m].Value = "";
            if (et.Cell.Column.Key == h && dgExtraCupo.ActiveRow.Cells[h].Text == "")
                dgExtraCupo.ActiveRow.Cells[h].Value = 1;
            
        }

        Boolean validate(int irow)
        {
            if (Convert.ToDecimal(dgExtraCupo.Rows[irow].Cells[h].Text) == 0)
                return false;
            DateTime fb = general.TruncDateTime(System.DateTime.Now);
            DateTime fi = general.TruncDateTime(Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[k].Text));//Cells[k].Value
            DateTime ff = general.TruncDateTime(Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[l].Text));//Cells[k].Value
            if (dgExtraCupo.Rows[irow].Cells[o].Text == "1" || dgExtraCupo.Rows[irow].Cells[p].Text == "1")
            {
                if (DateTime.Compare(fi, fb) < 0)
                {
                    errMsg = "Fecha inicial no debe ser menor a la fecha del sistema. ";
                    return false;
                }
                if (DateTime.Compare(ff, fb) < 0)
                {
                    errMsg = "Fecha final no debe ser menor a la fecha del sistema";
                    return false;
                }
            }
            if (dgExtraCupo.Rows[irow].Cells[m].Text == "")
            {
                errMsg = "Debe ingresar la observación";
                return false;
            }
            return true;
        }


        private void bindingNavigatorSaveItem_Click(object sender, EventArgs et)
        {
            if (dgExtraCupo.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                //Boolean error = false;
                //
                try
                {
                    dgExtraCupo.ActiveRow.Cells[o].Activated = true;
                }
                catch
                {
                    dgExtraCupo.Rows[0].Activated = true;
                }
                //
                int irow;


                for (irow = 0; irow <= dgExtraCupo.Rows.Count - 1; irow++)
                {
                    if (dgExtraCupo.Rows[irow].IsAddRow || dgExtraCupo.Rows[irow].IsDeleted)
                    {
                        if (validate(irow))
                        {
                            if (errMsg != null)
                            {
                                break;
                            }
                            Int64 inuextra_quota_id = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[a].Text);
                            String inusupplier_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[b].Value.ToString());
                            String inucategory_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[c].Value.ToString());
                            String inusubcategory_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[d].Value.ToString());
                            String inugeograp_location_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[e].Value.ToString());
                            String inusale_chanel_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[f].Value.ToString());
                            String inuquota_option = dgExtraCupo.Rows[irow].Cells[g].Value.ToString();
                            Decimal inuvalue = Convert.ToDecimal(dgExtraCupo.Rows[irow].Cells[h].Text);
                            String inuline_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[i].Value.ToString());
                            String inusubline_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[j].Value.ToString());
                            DateTime inuinitial_date = Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[k].Value.ToString());
                            DateTime inufinal_date = Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[l].Value.ToString());
                            String inuobservation = dgExtraCupo.Rows[irow].Cells[m].Text;
                            String inudocument = dgExtraCupo.Rows[irow].Cells[n].Text;
                            Object ruta = dgExtraCupo.Rows[irow].Cells[q].Value;
                            String td = dgExtraCupo.Rows[irow].Cells[r].Text;

                            if (dgExtraCupo.Rows[irow].Cells[m].Text == "")
                            {
                                errMsg = "Debe ingresar la observación";
                            }
                            else
                            {
                                Int64 cs = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[o].Value);
                                if (cs == 1)
                                {
                                    BLFIACE.saveExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
                                    dgExtraCupo.Rows[irow].Cells[o].Value = 0;
                                    dgExtraCupo.Rows[irow].Cells[p].Value = 0;
                                }
                                Int64 cm = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[p].Value);
                                if (cm == 1)
                                {
                                    BLFIACE.modifyExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
                                    dgExtraCupo.Rows[irow].Cells[o].Value = 0;
                                    dgExtraCupo.Rows[irow].Cells[p].Value = 0;
                                }
                                if (errMsg != null)
                                {
                                    general.mensajeERROR(errMsg);
                                    errMsg = null;
                                }
                            }

                            if (errMsg != null)
                            {
                                general.mensajeERROR(errMsg);
                                errMsg = null;
                            }
                        }
                        else
                        {
                            general.mensajeERROR(errMsg);
                            errMsg = null;
                        }
                    }

                    else if (dgExtraCupo.Rows[irow].DataChanged)
                    {

                        if (errMsg != null)
                        {
                            break;
                        }
                        Int64 inuextra_quota_id = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[a].Text);
                        String inusupplier_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[b].Value.ToString());
                        String inucategory_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[c].Value.ToString());
                        String inusubcategory_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[d].Value.ToString());
                        String inugeograp_location_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[e].Value.ToString());
                        String inusale_chanel_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[f].Value.ToString());
                        String inuquota_option = dgExtraCupo.Rows[irow].Cells[g].Value.ToString();
                        Decimal inuvalue = Convert.ToDecimal(dgExtraCupo.Rows[irow].Cells[h].Text);
                        String inuline_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[i].Value.ToString());
                        String inusubline_id = Convert.ToString(dgExtraCupo.Rows[irow].Cells[j].Value.ToString());

                        if (dgExtraCupo.Rows[irow].Cells[k].DataChanged || dgExtraCupo.Rows[irow].Cells[l].DataChanged)
                        {
                            if (!validate(irow))
                            {
                                general.mensajeERROR(errMsg);
                                errMsg = null;
                            }
                        }
                        DateTime inuinitial_date = Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[k].Value.ToString());
                        DateTime inufinal_date = Convert.ToDateTime(dgExtraCupo.Rows[irow].Cells[l].Value.ToString());
                        String inuobservation = dgExtraCupo.Rows[irow].Cells[m].Text;
                        String inudocument = dgExtraCupo.Rows[irow].Cells[n].Text;
                        Object ruta = dgExtraCupo.Rows[irow].Cells[q].Value;
                        String td = dgExtraCupo.Rows[irow].Cells[r].Text;

                        if (dgExtraCupo.Rows[irow].Cells[m].Text == "")
                        {
                            errMsg = "Debe ingresar la observación";
                        }
                        else
                        {
                            Int64 cs = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[o].Value);
                            if (cs == 1)
                            {
                                BLFIACE.saveExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
                                dgExtraCupo.Rows[irow].Cells[o].Value = 0;
                                dgExtraCupo.Rows[irow].Cells[p].Value = 0;
                            }

                            Int64 cm = Convert.ToInt64(dgExtraCupo.Rows[irow].Cells[p].Value);
                            if (cm == 1)
                            {
                                BLFIACE.modifyExtraQuota(inuextra_quota_id, inusupplier_id, inucategory_id, inusubcategory_id, inugeograp_location_id, inusale_chanel_id, inuquota_option, inuvalue, inuline_id, inusubline_id, inuinitial_date, inufinal_date, inuobservation, inudocument, ruta, td);
                                dgExtraCupo.Rows[irow].Cells[o].Value = 0;
                                dgExtraCupo.Rows[irow].Cells[p].Value = 0;
                            }
                            if (errMsg != null)
                            {
                                general.mensajeERROR(errMsg);
                                errMsg = null;
                            }

                        }
                        if (errMsg != null)
                        {
                            general.mensajeERROR(errMsg);
                            errMsg = null;
                        }



                    }
                }
                general.doCommit();//BLFIACE.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (errMsg != null)
                {
                    general.mensajeERROR(errMsg);
                    errMsg = null;
                }

            }
            else
            {
                general.doCommit();//BLFIACE.Save();
            }
        }

        private void dgExtraCupo_ClickCellButton(object sender, CellEventArgs e)
        {
            Question desicion = new Question("Agregar o Quitar Documento", "Desea Modificar o Quitar un Documento?", "Modificar", "Quitar", "Cancelar");
            desicion.ShowDialog();
            Int64 answer = desicion.answer;
            switch (answer)
            {
                case 1:
                    {
                        if (DialogResult.OK == ofdFile.ShowDialog())
                        {
                            dgExtraCupo.Rows[e.Cell.Row.Index].Cells[q].Value = ofdFile.FileName;
                            dgExtraCupo.Rows[e.Cell.Row.Index].Cells[n].Value = "Si";
                            dgExtraCupo.Rows[e.Cell.Row.Index].Cells[p].Value = 1;
                            dgExtraCupo.Rows[e.Cell.Row.Index].Cells[r].Value = "P";
                        }
                    }
                    break;
                case 2:
                    {
                        dgExtraCupo.Rows[e.Cell.Row.Index].Cells[n].Value = "No";
                        dgExtraCupo.Rows[e.Cell.Row.Index].Cells[p].Value = 1;
                    }
                    break;
            }
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ningun Extra Cupo Seleccionado");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgExtraCupo.ActiveRow.Cells[o].Value);//dgExtraCupo.Rows[int.Parse(bindingNavigatorPositionItem.Text) - 1].Cells[o].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ninguna Asignación Extra de Cupo Seleccionado");
                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("FIACE - Eliminar Cupo Extra", "¿Desea Eliminar el Cupo Extra " + dgExtraCupo.ActiveRow.Cells[a].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            BLFIACE.deleteExtraQuota(Convert.ToInt64(dgExtraCupo.ActiveRow.Cells[a].Value));
                            dgExtraCupo.ActiveRow.Delete(false);
                        }
                        catch
                        {
                            general.mensajeERROR("No puede eliminar este Cupo Extra");
                        }
                    }
                }
                else
                {
                    if (del)
                        //{
                        //    MessageBox.Show(cs.ToString ());
                        dgExtraCupo.ActiveRow.Delete(false);
                    //}
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }

        private void dgExtraCupo_Error(object sender, Infragistics.Win.UltraWinGrid.ErrorEventArgs et)
        {
            //String tMensaje = "";
            if (et.ErrorType == ErrorType.Data)
            {
                //if (et.DataErrorInfo.Source == DataErrorSource.CellUpdate)
                //{
                //if (et.DataErrorInfo.Cell.Column.Key == f)
                //tMensaje = "Referencia invalida. Debe seleccionar una Referencia de la lista.";
                //}
                et.Cancel = true;
                //general.mensajeERROR(tMensaje);
            }
        }

        private void bindingNavigatorPrintItem_Click(object sender, EventArgs e)
        {
            // Following code shows a print preview dialog and then prints the UltraGrid.

            try
            {
                System.Drawing.Printing.PrintDocument pdoc = new System.Drawing.Printing.PrintDocument();
                pdoc.DefaultPageSettings.Landscape = true;
                pdoc.DefaultPageSettings.Margins.Left = 50;
                pdoc.DefaultPageSettings.Margins.Right = 50;
                pdoc.DefaultPageSettings.Margins.Bottom = 50;
                pdoc.DefaultPageSettings.Margins.Top = 50;

                PageSetupDialog psd = new PageSetupDialog();
                psd.Document = pdoc;
                //psd.ShowDialog(); --Mostrar cuadro de dialogo de impresora

                // Optinally show the print preview dialog.
                this.dgExtraCupo.PrintPreview(this.dgExtraCupo.DisplayLayout, pdoc, RowPropertyCategories.All);//Vista preliminar

                // Calling print causes the UltraGrid to send the print job to the printer.
                this.dgExtraCupo.Print();
                //this.dgExtraCupo.Print(this.dgExtraCupo.DisplayLayout, pdoc);
            }
            catch (Exception exc)
            {
                // Catch any exceptions that may get thrown and let the user know.

                MessageBox.Show("Error occured while printing.\n" + exc.Message, "Error printing",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dgExtraCupo_BeforePrint(object sender, CancelablePrintEventArgs e)
        {
            // Following code shows a message box giving the user a last chance to cancel printing the 
            // UltraGrid.

            DialogResult result = MessageBox.Show("Continuar con la Impresión?", "Confirmar",
                MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
            e.DefaultLogicalPageLayoutInfo.FitWidthToPages = 1;// UltraGrid1_InitializePrint

            if (DialogResult.Cancel == result)
                e.Cancel = true;
        }

        private static DataSet ImportExcelXLS(string FileName, bool hasHeaders)
        {
            string HDR = hasHeaders ? "Yes" : "No";
            string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FileName + ";Extended Properties=\"Excel 8.0;HDR=" + HDR + ";IMEX=1\"";

            DataSet output = new DataSet();

            using (OleDbConnection conn = new OleDbConnection(strConn))
            {
                conn.Open();

                DataTable dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                foreach (DataRow row in dt.Rows)
                {
                    string sheet = row["TABLE_NAME"].ToString();

                    OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + sheet + "]", conn);
                    cmd.CommandType = CommandType.Text;

                    DataTable outputTable = new DataTable(sheet);
                    output.Tables.Add(outputTable);
                    new OleDbDataAdapter(cmd).Fill(outputTable);
                }
            }
            return output;
        }

        private void importar_Click(object sender, EventArgs e)
        {

            //Importar
            ofdFileImport.ShowDialog();
            String source = ofdFileImport.FileName.ToString();

            /*Infragistics.Excel.Workbook internalWorkBook;
            internalWorkBook = Infragistics.Excel.Workbook.Load(source);
            return;*/

            DataTable dt = new DataTable();
            DataSet ds = ImportExcelXLS(source, true);
            /*
            dt = ds.Tables[0];
            //ds.Tables.Add(dt);
            dt.Rows[0].Delete();//Eliminamos el encabezado
            */

            //Bind this table to the first UltraGrid 
            this.dgExtraCupo.SetDataBinding(ds, null);

            /*this.dgExtraCupo.DataSource = dt;
            this.dgExtraCupo.DataBind();*/
        }

        private void exportar_Click(object sender, EventArgs e)
        {

            try
            {
                if (sfdFile.ShowDialog() == DialogResult.OK)
                {
                    String ruta = sfdFile.FileName.ToString();
                    this.Cursor = Cursors.WaitCursor;
                    Infragistics.Excel.Workbook w = new Infragistics.Excel.Workbook();
                    Infragistics.Excel.Worksheet ws = w.Worksheets.Add("ExtraQuota");//Colocar Nombre a la hoja


                    this.ultraGridExcelExporter1.Export(this.dgExtraCupo, ws, 0, 0); //Esta linea exporta a Excel
                    Infragistics.Excel.BIFF8Writer.WriteWorkbookToFile(w, @ruta);
                    this.Cursor = Cursors.Default;
                    general.mensajeOk("El proceso se ha ejecutado. Por favor verifique los resultados de la ejecución.");
                }
            }
            catch (Exception ex)
            {
                this.Cursor = Cursors.Default;
                general.mensajeERROR("Error al realizar la exportación. " + ex.Message);
            }
        }

        private void dgExtraCupo_InitializePrint(object sender, CancelablePrintEventArgs e)
        {
            e.PrintDocument.DefaultPageSettings.Margins.Left = 50;
            e.PrintDocument.DefaultPageSettings.Margins.Right = 50;
            e.PrintDocument.DefaultPageSettings.Margins.Bottom = 50;
            e.PrintDocument.DefaultPageSettings.Margins.Top = 50;
        }

        private void ultraGridExcelExporter1_CellExported(object sender, Infragistics.Win.UltraWinGrid.ExcelExport.CellExportedEventArgs e)
        {
            if (e.GridColumn.Index == 1)
            {
                //if (Convert.ToInt32(e.GridRow.Cells["IdTipoDato"].Value) == 4)  //dgExtraCupo
                {
                    int excelrow = e.CurrentRowIndex;
                    int excelcol = e.CurrentColumnIndex;
                    //System.Diagnostics.Debug.WriteLine( e.GridRow.Cells[b].Value.ToString() +
                    //           "|" + e.GridRow.Cells[b].Text;

                    e.CurrentWorksheet.Rows[excelrow].Cells[excelcol].Value = e.GridRow.Cells[b].Value.ToString() +
                            "|" + e.GridRow.Cells[b].Text;
                }
            }

            if (e.Value != null && e.Value.GetType() == typeof(DateTime))
            {
                Infragistics.Excel.IWorksheetCellFormat format = e.CurrentWorksheet.Rows[e.CurrentRowIndex].Cells[e.CurrentColumnIndex].CellFormat;
                format.FormatString = "dd/MM/yyyy";

            }

            /*
            if (e.Column.DataType == typeof(System.DateTime?) && e.Column.Format != null)
            {
            }
            else
            {
                e.ExcelFormatStr = e.Column.Format;
            }
            
            string sCellType = e.Value.GetType().FullName;
            if (sCellType == "System.String")
            {
                string sCellContents = e.Value.ToString();
                
            }
            */

        }

        private void dgExtraCupo_AfterCellActivate(object sender, EventArgs et)
        {
            //
           /* if (dgExtraCupo.ActiveCell.Column.Key == b ||
                dgExtraCupo.ActiveCell.Column.Key == g ||
                dgExtraCupo.ActiveCell.Column.Key == c ||
                dgExtraCupo.ActiveCell.Column.Key == d ||
                dgExtraCupo.ActiveCell.Column.Key == e ||
                dgExtraCupo.ActiveCell.Column.Key == i ||
                dgExtraCupo.ActiveCell.Column.Key == j ||
                dgExtraCupo.ActiveCell.Column.Key == f)
                dgExtraCupo.ActiveCell.DroppedDown = true;*/
        }

        private void dgExtraCupo_AfterCellUpdate(object sender, CellEventArgs e)
        {
            
            if (dgExtraCupo.ActiveCell != null)
            {
                if (dgExtraCupo.ActiveCell.Column.Key == c)
                {
                    if (dgExtraCupo.ActiveRow.Cells[c].Value.ToString() != "" && dgExtraCupo.ActiveRow.Cells[c].Value.ToString() != " ")
                    {
                        start = false;
                        dgExtraCupo.ActiveRow.Cells[d].ValueList = null;
                       dgExtraCupo.ActiveRow.Cells[d].ValueList = general.valuelistNumberId(BLConsultas.SubCategoria + " where Sucacodi != -1 AND sucacate = " + dgExtraCupo.ActiveRow.Cells[c].Value.ToString() + " Order By Sucacodi", "DESCRIPCION", "CODIGO");

                        start = true;
                    }
                    else
                    {
                        start = false;
                        dgExtraCupo.ActiveRow.Cells[d].ValueList = null;
                        dgExtraCupo.ActiveRow.Cells[d].ValueList = general.valuelistNumberId("", "DESCRIPCION", "CODIGO");
                        start = true;
                    }
                }


                //
                if (dgExtraCupo.ActiveCell.Column.Key == i)
                {
                    if (dgExtraCupo.ActiveRow.Cells[i].Value.ToString() != "" && dgExtraCupo.ActiveRow.Cells[i].Value.ToString() != " ")
                    {
                        start = false;
                        dgExtraCupo.ActiveRow.Cells[j].ValueList = null;
                        dgExtraCupo.ActiveRow.Cells[j].ValueList = general.valuelistNumberId(BLConsultas.ListadoSublineas + " where line_id = " + dgExtraCupo.ActiveRow.Cells[i].Value.ToString() + " And Approved='Y' Order By Subline_id", "DESCRIPCION", "CODIGO");
                        start = true;
                    }
                    else
                    {
                        start = false;
                        dgExtraCupo.ActiveRow.Cells[j].ValueList = null;
                        dgExtraCupo.ActiveRow.Cells[j].ValueList = general.valuelistNumberId("", "DESCRIPCION", "CODIGO"); 
                        start = true;
                    }
                }

                if (e.Cell.Column.Key == g)
                {
                    if (Convert.ToString(e.Cell.Value ) == "P" )
                    {
                        if (Convert.ToInt64(dgExtraCupo.ActiveRow.Cells[h].Value) > 100)
                        {
                            dgExtraCupo.ActiveRow.Cells[h].Value = "1";
                        }
                    }
                }

            }
        }

        //Aecheverry 08-08-2013 SAO
        private void dgExtraCupo_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {      
            if(e.Cell.Column.Key == h)
                if (Convert.ToString(dgExtraCupo.ActiveRow.Cells[g].Value) == "P")
                {
                    if (Convert.ToInt64(e.NewValue) > 100)
                    {
                        ExceptionHandler.DisplayMessage(2741, "El valor no puede ser mayor al 100%");
                        e.Cancel = true;
                    }
                }
        }

    }
}