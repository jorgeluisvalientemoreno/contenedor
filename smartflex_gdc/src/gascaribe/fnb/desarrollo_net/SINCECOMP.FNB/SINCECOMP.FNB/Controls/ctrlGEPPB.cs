using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlGEPPB : UserControl
    {
        BindingSource customerbinding = new BindingSource();
        BindingSource customerbindingd = new BindingSource();
        String sRow;
        Boolean start;
        String typeUser;
        Int64 userId;
        //columnas lista de precio
        String a = "PriceListId";
        String b = "Description";
        String SupplierId = "SupplierId";
        String d = "InitialDate";
        String e = "FinalDate";
        String Approved = "Approved";
        String g = "CreationDate";
        String h = "LastDateApproved";
        String Version = "Version";
        String ConditionApproved = "ConditionApproved";
        String CheckSave = "CheckSave";
        String l = "CheckModify";
        String m = "ApprovedT";
        String n = "AmountPrintOUTS";
        //columnas detalle lista de precio
        String a1 = "ArticleId";
        String b1 = "Price";
        String c1 = "PriceAproved";
        String d1 = "SaleChanelId";
        String e1 = "GeograpLocationId";
        String f1 = "PriceListId";
        String g1 = "PriceListDetaId";
        String h1 = "Version";
        String i1 = "CheckSave";
        String j1 = "CheckModify";
        String k1 = "IdArticle";

        //
        BLGENERAL general = new BLGENERAL();
        String msjError = string.Empty;
        public Boolean operPendientes = false;

        //String valor1;
        public ctrlGEPPB(String typeuser, Int64 userid)
        {
            InitializeComponent();
            //validaciones de usuario
            typeUser = typeuser;
            userId = userid;
            //
            start = false;
            List<PriceListGEPPB> ListPriceList = new List<PriceListGEPPB>();
            ListPriceList = BLGEPPB.FcuPriceList(userId.ToString(), typeUser.ToString());
            customerbinding.DataSource = ListPriceList;
            bnNavigator.BindingSource = customerbinding;
            dgPriceList.DataSource = customerbinding;
            start = true;
            //combo s/n
            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("Y", "Si"));
            lista.Add(new ListSN("N", "No"));
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;
            UltraDropDown dropDownsn = new UltraDropDown();

            dropDownsn.DataSource = tabla;
            dropDownsn.ValueMember = "Id";
            dropDownsn.DisplayMember = "Description";
            //
            dropDownsn.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;

            List<ListSN> listaAppr = new List<ListSN>();
            listaAppr.Add(new ListSN("P", "Pendiente"));
            listaAppr.Add(new ListSN("Y", "Si"));
            listaAppr.Add(new ListSN("N", "No"));
            BindingSource tablaAppr = new BindingSource();
            tablaAppr.DataSource = listaAppr;
            UltraDropDown dropDownAppr = new UltraDropDown();

            dropDownAppr.DataSource = tablaAppr;
            dropDownAppr.ValueMember = "Id";
            dropDownAppr.DisplayMember = "Description";
            //
            dropDownAppr.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;

            //
            dgPriceList.DisplayLayout.Bands[0].Columns[Approved].ValueList = dropDownAppr;
            //
            dgPriceList.DisplayLayout.Bands[0].Columns[Approved].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //condicion de aprobacion
            dgPriceList.DisplayLayout.Bands[0].Columns[ConditionApproved].ValueList = dropDownsn;
            //
            dgPriceList.DisplayLayout.Bands[0].Columns[ConditionApproved].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //combo proveedores
            //proveedorc por proveedor
            //valuelistn por valuelist
            //dgPriceList.DisplayLayout.Bands[0].Columns[c].ValueList = general.valuelist(BLConsultas.Proveedor, "NOMBRE", "IDENTIFICACION");
            dgPriceList.DisplayLayout.Bands[0].Columns[SupplierId].ValueList = general.valuelist2(BLConsultas.ProveedorC2, "NOMBRE", "IDENTIFICACION");
            //
            dgPriceList.DisplayLayout.Bands[0].Columns[SupplierId].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //
            //bloques secundarios
            String data;
            sRow = bindingNavigatorPositionItem.Text;
            if (sRow == "0")
                data = "-10";
            else
                data = dgPriceList.Rows[int.Parse(sRow) - 1].Cells[a].Value.ToString();
            //grilla detalle
            List<DetailPrLstGEPPB> ListDetail = new List<DetailPrLstGEPPB>();
            ListDetail = BLGEPPB.FcuDetailPriceList(Convert.ToInt64(data));
            customerbindingd.DataSource = ListDetail;
            bnProperties.BindingSource = customerbindingd;
            dgDetailPriceList.DataSource = customerbindingd;
            //combo grilla articulos por proveedor
            if (typeUser == "F")
            {
                dgDetailPriceList.DisplayLayout.Bands[0].Columns[a1].ValueList = general.valuelistNumberId(BLConsultas.ArticulosControlados + " and supplier_id=" + dgPriceList.Rows[0].Cells[SupplierId].Value.ToString() + " Order By article_id", "DESCRIPCION", "CODIGO");
            }
            else
                dgDetailPriceList.DisplayLayout.Bands[0].Columns[a1].ValueList = general.valuelistNumberId(BLConsultas.ArticulosControlados + " and supplier_id=" + userId + " Order By article_id", "DESCRIPCION", "CODIGO");
            //
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[a1].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

            //// 
            /// SAO214225 Se adiciona el control de ubicaciones geograficas a la columna
            UltraCombo ucbGeographLocation = new ListOfValues().SetTreeLov(BLConsultas.UbicacionGeograficaTree, "Ubicación Geográfica");
            ucbGeographLocation.Tag = dgDetailPriceList.DisplayLayout.Bands[0].Columns[e1];
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[e1].EditorControl = ucbGeographLocation;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[e1].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

            //
            //canales de venta
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[d1].ValueList = general.valuelistNumberId(BLConsultas.CanalesdeVenta, "DESCRIPCION", "CODIGO");
            //
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[d1].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[d1].Nullable = Infragistics.Win.UltraWinGrid.Nullable.EmptyString;
            //
            //ocultar columnas guias
            dgPriceList.DisplayLayout.Bands[0].Columns[CheckSave].Hidden = true;
            //condicion de aprobacion
            dgPriceList.DisplayLayout.Bands[0].Columns[ConditionApproved].Hidden = true;
            //
            dgPriceList.DisplayLayout.Bands[0].Columns[l].Hidden = true;
            dgPriceList.DisplayLayout.Bands[0].Columns[m].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[f1].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[g1].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[h1].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[i1].Hidden = true;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[j1].Hidden = true;
            //alineaciones y bloqueo
            String[] fieldReadOnly = new string[] { a, h, g, Version, n };
            general.setColumnReadOnly(dgPriceList, fieldReadOnly);
            dgPriceList.DisplayLayout.Bands[0].Columns[a].CellAppearance.BackColor = Color.LightGray;
            dgPriceList.DisplayLayout.Bands[0].Columns[a].CellAppearance.TextHAlign = HAlign.Right;
            dgPriceList.DisplayLayout.Bands[0].Columns[Approved].CellAppearance.TextHAlign = HAlign.Center;
            dgPriceList.DisplayLayout.Bands[0].Columns[Version].CellAppearance.TextHAlign = HAlign.Right;
            dgPriceList.DisplayLayout.Bands[0].Columns[ConditionApproved].CellAppearance.TextHAlign = HAlign.Center;
            //
            dgPriceList.DisplayLayout.Bands[0].Columns[h].Format = "dd/MM/yyyy";
            //campos obligatorios
            //
            String[] fieldspricelist = new string[] { a, b, SupplierId, d, e, g };
            general.setColumnRequiered(dgPriceList, fieldspricelist);
            //
            if (typeUser == "C")
            {
                fieldReadOnly = new string[] { SupplierId, Approved };
                general.setColumnReadOnly(dgPriceList, fieldReadOnly);
                fieldReadOnly = new string[] { c1 };
                general.setColumnReadOnly(dgDetailPriceList, fieldReadOnly);
            }
            //alineaciones y bloqueo
            String[] fieldReadOnlyDetail = new string[] { k1 };
            general.setColumnReadOnly(dgDetailPriceList, fieldReadOnlyDetail);
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[k1].CellAppearance.BackColor = Color.LightGray;
            //dgDetailPriceList.DisplayLayout.Bands[0].Columns[k1].CellActivation = Activation.NoEdit;

            dgDetailPriceList.DisplayLayout.Bands[0].Columns[b1].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].CellAppearance.TextHAlign = HAlign.Right;
            fieldReadOnly = new string[] { h1 };
            general.setColumnReadOnly(dgDetailPriceList, fieldReadOnly);
            dgPriceList.DisplayLayout.Bands[0].Columns[b].MaxLength = 200;
            dgPriceList.DisplayLayout.Bands[0].Columns[Version].MaxLength = 6;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[b1].MaskInput = "nnnnnnnnnnnnn.nn"; //EVESAN
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[b1].MaxLength = 18;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[b1].MaxValue = 9999999999999.99;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[b1].Format = "#,##0.00";
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].MaskInput = "nnnnnnnnnnnnn.nn"; //EVESAN
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].MaxLength = 18;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].MaxValue = 9999999999999.99;
            dgDetailPriceList.DisplayLayout.Bands[0].Columns[c1].Format = "#,##0.00";
            //tamanos columnas
            dgPriceList.DisplayLayout.Bands[0].Columns[b].Width = 150;
            dgPriceList.DisplayLayout.Bands[0].Columns[Approved].Width = 70;
            dgPriceList.DisplayLayout.Bands[0].Columns[ConditionApproved].Width = 150;
            //campos obligatorios
            String[] fieldspricelistdetail = new string[] { a1, b1 };
            general.setColumnRequiered(dgDetailPriceList, fieldspricelistdetail);
            //campos mayusculas
            String[] fieldsupper = new string[] { b, SupplierId, Approved, ConditionApproved };
            general.setColumnUpper(dgPriceList, fieldsupper);
            //modificado 7.2.2013
            if (typeUser != "F")
            {
                //validar fecha limite
                DataRow[] dataLimitDate = general.limitDate(userId.ToString());
                if (dataLimitDate.Length > 0)
                {
                    String dateinitial = dataLimitDate[0][2].ToString().Substring(0, 10) + " " + dataLimitDate[0][4].ToString();
                    String datelimit = dataLimitDate[0][3].ToString().Substring(0, 10) + " " + dataLimitDate[0][5].ToString();
                    if (Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) >= Convert.ToDateTime(dateinitial) && Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) <= Convert.ToDateTime(datelimit))
                    {

                    }
                    else
                    {
                        //barras de operaciones
                        AddList.Enabled = false;
                        AddDetail.Enabled = false;
                        SaveList.Enabled = false;
                        SaveList.Enabled = false;
                        SaveDetail.Enabled = false;
                        DeleteList.Enabled = false;
                        DeleteDetail.Enabled = false;
                        //lista de precios
                        fieldReadOnly = new string[] { a, b, SupplierId, d, e, Approved, g, h, Version, ConditionApproved, CheckSave, l, m, n };
                        general.setColumnReadOnly(dgPriceList, fieldReadOnly);
                        //detalle lista de precios
                        fieldReadOnly = new string[] { a1, b1, c1, d1, e1, f1, g1, h1, i1, j1 };
                        general.setColumnReadOnly(dgDetailPriceList, fieldReadOnly);

                    }
                }
            }
            //ALEVAL
            int irow;
            for (irow = 0; irow <= dgPriceList.Rows.Count - 1; irow++)
            {
                if (dgPriceList.Rows[irow].Cells[Approved].Text == "Si")
                {
                    if (typeUser == "F")
                    {
                        dgPriceList.Rows[irow].Cells[e].IgnoreRowColActivation = true;
                    }
                    dgPriceList.Rows[irow].Activation = Activation.NoEdit;
                }
            }

            operPendientes = false;
        }

        private void bindingNavigatorAddItem_Click(object sender, EventArgs et)
        {
            if (dgPriceList.Rows.Count > 0)
            {
                try
                {
                    dgPriceList.ActiveRow.Cells[CheckSave].Activated = true;
                }
                catch
                {
                    dgPriceList.Rows[0].Cells[CheckSave].Activated = true;
                }
                msjError = "";
                operPendientes = true;
                if (validate(dgPriceList.Rows.Count - 1))
                {
                    customerbinding.Add(BLGEPPB.AddRowList());
                    dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[CheckSave].Value = 1;
                    dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[Approved].Value = "P";
                    //condicion de aprobacion
                    dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[ConditionApproved].Value = "Y";
                    //
                    dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[a].Value = general.valueReturn(BLConsultas.secuencePriceList, "Int64"); //BLGEPPB.consPriceList();
                    if (typeUser == "C")
                    {
                        dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[SupplierId].Value = userId;
                        dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[Version].Value = 0;
                    }
                    else
                        dgPriceList.Rows[dgPriceList.Rows.Count - 1].Cells[SupplierId].Value = null;//" ";
                    bindingNavigationLastPosition.PerformClick();
                }
                else
                {
                    if (msjError != "")
                        general.mensajeERROR(msjError);
                }
            }
            else
            {
                operPendientes = true;

                PriceListGEPPB _newListPrice    = BLGEPPB.AddRowList();
                _newListPrice.PriceListId       = Convert.ToInt64(general.valueReturn(BLConsultas.secuencePriceList, "Int64"));
                _newListPrice.CheckSave         = 1;
                _newListPrice.Approved          = "P";
                _newListPrice.ConditionApproved = "Y";

                if (typeUser == "C")
                {
                    _newListPrice.SupplierId = Convert.ToString( userId );
                    _newListPrice.Version = 0;
                }
                else
                    _newListPrice.SupplierId = string.Empty;

                customerbinding.Add(_newListPrice);


                dgPriceList.Rows[0].Cells[SupplierId].IgnoreRowColActivation = true;

                //if (dgPriceList.Rows.Count > 0 )
                //{

                //dgPriceList.Rows[0].Cells[CheckSave].Value = 1;
                //dgPriceList.Rows[0].Cells[Approved].Value = "P";
                //condicion de aprobacion
                //dgPriceList.Rows[0].Cells[ConditionApproved].Value = "Y";
                //
                //dgPriceList.Rows[0].Cells[a].Value = general.valueReturn(BLConsultas.secuencePriceList, "Int64"); //BLGEPPB.consPriceList();
                /*
                if (typeUser == "C")
                {
                    dgPriceList.Rows[0].Cells[c].Value = userId;
                    //dgPriceList.Rows[0].Cells[i].Value = 0;
                }
                else
                    dgPriceList.Rows[0].Cells[c].Value = " ";
                 */
                //}

                bindingNavigationLastPosition.PerformClick();

            }
        }

        Boolean validate(int irow)
        {
            if (dgPriceList.Rows[irow].Cells[b].Text == "")
            {
                general.mensajeERROR("Debe ingresar una Descripción para la Lista de Precios con Identificación: " + dgPriceList.Rows[irow].Cells[a].Text);
                return false;
            }
            if (dgPriceList.Rows[irow].Cells[SupplierId].Value.ToString() == "")
            {
                general.mensajeERROR("Debe ingresar un Proveedor para la Lista de Precios con Identificación: " + dgPriceList.Rows[irow].Cells[a].Text);
                return false;
            }

            return true;
        }

        Boolean validatep(int irow)
        {
            if (dgDetailPriceList.Rows[irow].Cells[a1].Value.ToString() == " ")
            {
                general.mensajeERROR("Debe ingresar un artículo en el Detalle de Lista de Precios.");
                return false;
            }
            if (dgDetailPriceList.Rows[irow].Cells[b1].Text == "")
            {
                general.mensajeERROR("Debe ingresar un Precio en el Detalle de Lista de Precios para el artículo: " + dgDetailPriceList.Rows[irow].Cells[a1].Text);
                return false;
            }
            return true;
        }

        private void bindingNavigatorSaveItem_Click(object sender, EventArgs et)
        {
            if (dgPriceList.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                try
                {
                    dgPriceList.ActiveRow.Cells[CheckSave].Activated = true;
                }
                catch
                {
                    dgPriceList.Rows[0].Activated = true;
                }
                //error fila
                String errorRow = "";
                Boolean error = false;
                int irow;
                for (irow = 0; irow <= dgPriceList.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        Int64 pricelistid = Convert.ToInt64(dgPriceList.Rows[irow].Cells[a].Value);
                        String description = dgPriceList.Rows[irow].Cells[b].Text;
                        String supplierid = Convert.ToString(dgPriceList.Rows[irow].Cells[SupplierId].Value);
                        DateTime initialdate = Convert.ToDateTime(dgPriceList.Rows[irow].Cells[d].Value);
                        DateTime finaldate = Convert.ToDateTime(dgPriceList.Rows[irow].Cells[e].Value);
                        String approved = Convert.ToString(dgPriceList.Rows[irow].Cells[Approved].Value);
                        DateTime creationdate = Convert.ToDateTime(dgPriceList.Rows[irow].Cells[g].Value);
                        Int64 version = Convert.ToInt64(dgPriceList.Rows[irow].Cells[Version].Text);
                        String conditionapproved = Convert.ToString(dgPriceList.Rows[irow].Cells[ConditionApproved].Value);
                        String approvedT = dgPriceList.Rows[irow].Cells[m].Text;
                        Int64 cs = Convert.ToInt64(dgPriceList.Rows[irow].Cells[CheckSave].Value);
                        if (cs == 1)
                        {
                            BLGEPPB.savePriceList(pricelistid, description, supplierid, initialdate, finaldate, approved, creationdate, version, conditionapproved);
                            if (dgPriceList.Rows[irow].Cells[Approved].Text == "Si")
                            {
                                dgPriceList.Rows[irow].Cells[h].Value = Convert.ToDateTime(DateTime.Now.ToString());
                                dgPriceList.Rows[irow].Activation = Activation.NoEdit;
                            }
                            dgPriceList.Rows[irow].Cells[CheckSave].Value = 0;
                            dgPriceList.Rows[irow].Cells[l].Value = 0;
                        }
                        Int64 cm = Convert.ToInt64(dgPriceList.Rows[irow].Cells[l].Value);
                        if (cm == 1)
                        {
                            if (typeUser == "F")
                            {
                                BLGEPPB.modifyPriceList(pricelistid, description, supplierid, initialdate, finaldate, approved, creationdate, version, conditionapproved);
                                if (approved == "Y" && approvedT != "Y")
                                {
                                    BLGEPPB.procApprovedList(pricelistid);
                                    dgPriceList.Rows[irow].Cells[h].Value = Convert.ToDateTime(DateTime.Now.ToString());
                                }
                                if (dgPriceList.Rows[irow].Cells[Approved].Text == "Si")
                                {
                                    dgPriceList.Rows[irow].Cells[e].IgnoreRowColActivation = true;
                                    dgPriceList.Rows[irow].Activation = Activation.NoEdit;
                                }
                                dgPriceList.Rows[irow].Cells[CheckSave].Value = 0;
                                dgPriceList.Rows[irow].Cells[l].Value = 0;
                                dgPriceList.Rows[irow].Cells[m].Value = dgPriceList.Rows[irow].Cells[Approved].Value;
                            }
                            else
                            {
                                BLGEPPB.modifyPriceList(pricelistid, description, supplierid, initialdate, finaldate, approved, creationdate, version, conditionapproved);
                                if (dgPriceList.Rows[irow].Cells[Approved].Text == "Si")
                                {
                                    dgPriceList.Rows[irow].Activation = Activation.NoEdit;
                                }
                                dgPriceList.Rows[irow].Cells[CheckSave].Value = 0;
                                dgPriceList.Rows[irow].Cells[l].Value = 0;
                                dgPriceList.Rows[irow].Cells[m].Value = dgPriceList.Rows[irow].Cells[Approved].Value;
                            }
                        }
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        errorRow += dgPriceList.Rows[irow].Cells[a].Text + ", ";
                        error = true;
                    }
                }
                general.doCommit();//BLGEPPB.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error)
                    general.mensajeERROR("Error en la información ingresada. Las Listas de Precios con la Identificación: " + errorRow + " pudieron no ser Guardadas o Modificadas");
                else
                    operPendientes = false;
                //
                if ((dgPriceList.ActiveRow.Cells[Approved].Value.ToString() == "Y") && (dgPriceList.ActiveRow.Cells[CheckSave].Value.ToString() == "0"))
                {
                    AddDetail.Enabled = false;
                    DeleteDetail.Enabled = false;
                    SaveDetail.Enabled = false;
                }
                else
                {
                    AddDetail.Enabled = true;
                    DeleteDetail.Enabled = true;
                    SaveDetail.Enabled = true;
                }
            }
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ninguna Lista Registrada.");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgPriceList.ActiveRow.Cells[CheckSave].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ninguna Lista de Precios seleccionada.");

                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("LDAPB - Eliminar Lista de Precios", "¿Desea Eliminar la Lista de Precios " + dgPriceList.ActiveRow.Cells[a].Value.ToString() + " - " + dgPriceList.ActiveRow.Cells[b].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inuprice_list_id" };
                            Object[] p3 = new object[] { dgPriceList.ActiveRow.Cells[a].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deletePriceList, 1, p1, p2, p3);
                            dgPriceList.ActiveRow.Delete(false);
                            general.doCommit();//BLGEPPB.Save();
                        }
                        catch
                        {
                            general.mensajeERROR("No es posible eliminar la Lista de Precios, ya que se encuentra asociada a otro registro.");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgPriceList.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }

        private void dgPriceList_CellChange(object sender, CellEventArgs et)
        {
            //incio de operaciones
            operPendientes = true;
            //
            dgPriceList.Rows[et.Cell.Row.Index].Cells[l].Value = 1;
            if (et.Cell.Column.Key == Approved)
            {
                /// SAO 214415 
                /// Se valida que exista algun articulo asociado a la lista
                if ((dgPriceList.Rows[et.Cell.Row.Index].Cells[Approved].Value.ToString() == "N" || dgPriceList.Rows[et.Cell.Row.Index].Cells[Approved].Value.ToString() == "P")
                   && dgDetailPriceList.Rows.Count == 0)
                {
                    general.mensajeERROR("No se puede aprobar una lista de precios sin artículos asociados.");
                    et.Cell.CancelUpdate();
                }
                else if (dgPriceList.Rows[et.Cell.Row.Index].Cells[Approved].Text == "Si" && dgPriceList.Rows[et.Cell.Row.Index].Cells[Version].Text == "0")
                {
                    if (dgDetailPriceList.Rows.Count > 0)
                    {
                        dgPriceList.Rows[et.Cell.Row.Index].Cells[Version].Value = "1";
                        dgPriceList.Rows[et.Cell.Row.Index].Cells[h].Value = DateTime.Now;
                    }
                }
                if (dgPriceList.Rows[et.Cell.Row.Index].Cells[Approved].Value.ToString() == "Y" && dgPriceList.Rows[et.Cell.Row.Index].Cells[Approved].Text == "No")
                {
                    general.mensajeERROR("No puede Cambiar el Estado a No Aprobado de la Lista de Precios");
                    et.Cell.CancelUpdate();
                }
            }
        }

        private void bindingNavigatorAddNewItem1_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ninguna Lista de Precios Registrada");
            else
            {
                try
                {
                    if (dgPriceList.Rows[dgPriceList.ActiveRow.Index].Cells[CheckSave].Text == "1")
                        general.mensajeERROR("La lista de Precios seleccionada no ha sido registrada aún.");
                    else
                    {
                        customerbindingd.Add(BLGEPPB.AddRowDetailList());
                        bindingNavigatorLastPosition1.Visible = true;
                        bindingNavigatorLastPosition1.PerformClick();
                        bindingNavigatorLastPosition1.Visible = false;
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[g1].Value = general.valueReturn(BLConsultas.secuenceDetailPriceList, "Int64"); //BLGEPPB.consPriceListDetail();

                        //dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[f1].Value = dgPriceList.Rows[int.Parse(bindingNavigatorPositionItem.Text) - 1].Cells[a].Value;
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[f1].Value = Convert.ToString(dgPriceList.Rows[dgPriceList.ActiveRow.Index].Cells[a].Value); //EVELIO


                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[d1].Value = " ";
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[e1].Value = " ";
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[a1].Value = " ";
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[b1].Value = 1;
                        dgDetailPriceList.Rows[dgDetailPriceList.Rows.Count - 1].Cells[i1].Value = 1;
                    }
                }
                catch
                {
                    general.mensajeERROR("Debe Seleccionar una lista de Precios");
                }
            }
        }
        //EVESAN , SE ANEXAN LOS PARAMETROS DE FECHA INICIAL Y FECHA FINAL - 27-Junio de 2013
        Int64 validacionArticulos(String Articulo, String Ubicacion, String Supplierid, String SaleChanelId, String InitialDate, String FinalDate, String PriceListId)
        {
            String[] p1 = new string[] { "Int64", "Int64", "Int64", "Int64", "String", "String", "Int64" };
            String[] p2 = new string[] { "nuarticleid", "nugeolocatid", "inuSupplier", "inuSalesChannel", "inuInitialDate", "inuFinalDate", "inuPriceListId" };
            String[] p3 = new string[] { Articulo, Ubicacion, Supplierid, SaleChanelId, InitialDate, FinalDate, PriceListId };
            return Convert.ToInt64(general.valueReturn(BLConsultas.ValidarArticulosLista, 7, p1, p2, p3, "Int64"));
        }

        private void bindingNavigatorSaveItem1_Click(object sender, EventArgs ev)
        {
            if (dgDetailPriceList.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                //Boolean errorfecha = false;
                Boolean error = false;
                //errores
                String errorRow = string.Empty;
                try
                {
                    dgDetailPriceList.ActiveRow.Cells[i1].Activated = true;
                }
                catch
                {
                    dgDetailPriceList.Rows[0].Activated = true;
                }
                int irow;
                for (irow = 0; irow <= dgDetailPriceList.Rows.Count - 1; irow++)
                {
                    if (validatep(irow))
                    {
                        Int64 inuprice_list_deta_id = Convert.ToInt64(dgDetailPriceList.Rows[irow].Cells[g1].Value);
                        Int64 inuprice_list_id = Convert.ToInt64(dgDetailPriceList.Rows[irow].Cells[f1].Value);
                        String inuarticle_id = Convert.ToString(dgDetailPriceList.Rows[irow].Cells[a1].Value);
                        Decimal inuprice = Convert.ToDecimal(dgDetailPriceList.Rows[irow].Cells[b1].Text);
                        Decimal inuprice_aproved = Convert.ToDecimal(dgDetailPriceList.Rows[irow].Cells[c1].Text);
                        String inusale_chanel_id = Convert.ToString(dgDetailPriceList.Rows[irow].Cells[d1].Value);
                        String inugeograp_location_id = Convert.ToString(dgDetailPriceList.Rows[irow].Cells[e1].Value);
                        Int64 inuversion = Convert.ToInt64(dgDetailPriceList.Rows[irow].Cells[h1].Text);
                        Int64 cs = Convert.ToInt64(dgDetailPriceList.Rows[irow].Cells[i1].Value);
                        //EVESAN - INICIO
                        /*
                         * En la linea de abajo donde se obtiene el proveedor del registro padre
                         * la fila se está tomando con la variable "irow", pero esta variable
                         * hace referencia a la posicion en la que está ubicado en el detalle y no
                         * en el registro padre
                         */
                        //String supplierid = Convert.ToString(dgPriceList.Rows[dgPriceList.irow].Cells[c].Value);
                        String supplierid = Convert.ToString(dgPriceList.Rows[dgPriceList.ActiveRow.Index].Cells[SupplierId].Value);//EVELIO
                        DateTime dtInitialdate = Convert.ToDateTime(dgPriceList.Rows[dgPriceList.ActiveRow.Index].Cells[d].Value);//EVELIO
                        DateTime dtFinaldate = Convert.ToDateTime(dgPriceList.Rows[dgPriceList.ActiveRow.Index].Cells[e].Value);//EVELIO
                        String initialdate = dtInitialdate.ToString("dd/MM/yyyy");
                        String finaldate = dtFinaldate.ToString("dd/MM/yyyy");
                        String priceListId = Convert.ToString(inuprice_list_id);
                        //EVESAN - FIN

                        if (cs == 1)
                        {
                            if (validacionArticulos(inuarticle_id, inugeograp_location_id, supplierid, inusale_chanel_id, initialdate, finaldate, priceListId) == 0)
                            {
                                BLGEPPB.savePriceListDetail(inuprice_list_deta_id, inuprice_list_id, inuarticle_id, inuprice, inuprice_aproved, inusale_chanel_id, inugeograp_location_id, inuversion);
                                BLGEPPB.procSaveChanges(inuprice_list_id, "I");
                                dgDetailPriceList.Rows[irow].Cells[i1].Value = 0;
                                dgDetailPriceList.Rows[irow].Cells[j1].Value = 0;
                            }
                            else
                            {
                                errorRow += dgDetailPriceList.Rows[irow].Cells[a1].Text + ", ";
                                error = true;
                                general.mensajeERROR("El Artículo ya se encuentra configurado en una lista, con la misma parametrización.");//EVESAN
                                return;//EVESAN
                            }
                        }
                        Int64 cm = Convert.ToInt64(dgDetailPriceList.Rows[irow].Cells[j1].Value);
                        if (cm == 1)
                        {

                            if (typeUser == "F")
                            {
                                if (validacionArticulos(inuarticle_id, inugeograp_location_id, supplierid, inusale_chanel_id, initialdate, finaldate, priceListId) == 0)
                                {
                                    try
                                    {
                                        BLGEPPB.modifyPriceListDetail(inuprice_list_deta_id, inuprice_list_id, inuarticle_id, inuprice, inuprice_aproved, inusale_chanel_id, inugeograp_location_id, inuversion);
                                        BLGEPPB.procSaveChanges(inuprice_list_id, "U");
                                        dgDetailPriceList.Rows[irow].Cells[i1].Value = 0;
                                        dgDetailPriceList.Rows[irow].Cells[j1].Value = 0;
                                    }
                                    catch (Exception ex)
                                    {
                                        general.mensajeERROR(ex.Message);
                                    }
                                }
                                else
                                {
                                    errorRow += dgDetailPriceList.Rows[irow].Cells[a1].Text + ", ";
                                    error = true;
                                    general.mensajeERROR("El Artículo ya se encuentra configurado en una lista, con la misma parametrización.");//EVESAN
                                    return;//EVESAN
                                }
                            }
                            else
                            {
                                if (validacionArticulos(inuarticle_id, inugeograp_location_id, supplierid, inusale_chanel_id, initialdate, finaldate, priceListId) == 0)
                                {
                                    BLGEPPB.modifyPriceListDetail(inuprice_list_deta_id, inuprice_list_id, inuarticle_id, inuprice, inuprice_aproved, inusale_chanel_id, inugeograp_location_id, inuversion);
                                    BLGEPPB.procSaveChanges(inuprice_list_id, "U");
                                    dgDetailPriceList.Rows[irow].Cells[i1].Value = 0;
                                    dgDetailPriceList.Rows[irow].Cells[j1].Value = 0;
                                }
                                else
                                {
                                    errorRow += dgDetailPriceList.Rows[irow].Cells[a1].Text + ", ";
                                    error = true;
                                    general.mensajeERROR("El Artículo ya se encuentra configurado en una lista, con la misma parametrización.");
                                    return;
                                }

                            }
                        }
                    }
                    else
                    {
                        errorRow += dgDetailPriceList.Rows[irow].Cells[a1].Text + ", ";
                        error = true;
                    }
                }
                general.doCommit();//BLGEPPB.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error)
                    general.mensajeERROR("Error en la información ingresada. Los Detalles con los artículos " + errorRow + " pudieron no ser Guardados o Modificados");
            }
        }

        private void bindingNavigatorDeleteItem1_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPosition1.Text == "0")
                general.mensajeERROR("No hay ningún Detalle Seleccionado");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgDetailPriceList.ActiveRow.Cells[i1].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No se ha seleccionado un Artículo de Lista de Precios.");

                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("LDAPB - Eliminar Detalle de Lista de Precios", "¿Desea Eliminar el Artículo " + dgDetailPriceList.ActiveRow.Cells[a1].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inuprice_list_deta_id" };
                            Object[] p3 = new object[] { dgDetailPriceList.ActiveRow.Cells[g1].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deleteDetailPriceList, 1, p1, p2, p3);
                            dgDetailPriceList.ActiveRow.Delete(false);
                            general.doCommit();//BLGEPPB.Save();
                        }
                        catch
                        {
                            general.mensajeERROR("No es posible eliminar este Artículo de Lista de Precios.");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgDetailPriceList.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }

        public static bool AreEqual(string a, string b)
        {
            if (string.IsNullOrEmpty(a))
                return string.IsNullOrEmpty(b);
            else
                return string.Equals(a, b);
        }

        private void dgDetailPriceList_CellChange(object sender, CellEventArgs et)
        {

            dgDetailPriceList.Rows[et.Cell.Row.Index].Cells[j1].Value = 1;

            if (et.Cell.Column.Key == b1 || et.Cell.Column.Key == c1)
            {
                if (dgDetailPriceList.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Text == "")
                    dgDetailPriceList.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Value = 0;
            }
        }

        private void bindingNavigatorPrintItem_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgPriceList);
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgDetailPriceList);
        }

        private void importar_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgPriceList);
        }

        private void exportar_Click(object sender, EventArgs e)
        {
            //String[] listaColumnas = new string[] { a };
            general.exportarExcel(dgPriceList);//, listaColumnas);
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgDetailPriceList);
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            //String[] listaColumnas = new string[] { a };
            general.exportarExcel(dgDetailPriceList);//, listaColumnas);
        }

        private void dgPriceList_AfterRowActivate(object sender, EventArgs et)
        {
            if (dgPriceList.Rows.Count > 0)
            {
                try
                {
                    //sRow = bindingNavigatorPositionItem.Text;
                    //detalles lista de precios
                    List<DetailPrLstGEPPB> ListDetailPriceList = new List<DetailPrLstGEPPB>();
                    ListDetailPriceList = BLGEPPB.FcuDetailPriceList(Convert.ToInt64(dgPriceList.ActiveRow.Cells[a].Value));
                    customerbindingd.DataSource = ListDetailPriceList;
                    String supplier = string.IsNullOrEmpty(dgPriceList.ActiveRow.Cells[SupplierId].Value.ToString()) ? " " : dgPriceList.ActiveRow.Cells[SupplierId].Value.ToString();

                    if ((typeUser == "F") && (supplier != " "))
                        dgDetailPriceList.DisplayLayout.Bands[0].Columns[a1].ValueList = general.valuelistNumberId(BLConsultas.ArticulosControlados + " and supplier_id=" + supplier + " Order By article_id", "DESCRIPCION", "CODIGO");
                }
                catch { }

                //
                if (dgPriceList.ActiveRow.Cells[Approved].Value != null &&
                    (dgPriceList.ActiveRow.Cells[Approved].Value.ToString() == "Y") && (dgPriceList.ActiveRow.Cells[CheckSave].Value.ToString() == "0")
                   )
                {
                    AddDetail.Enabled = false;
                    DeleteDetail.Enabled = false;
                    SaveDetail.Enabled = false;
                    //EVESAN 04/Julio/2013 -- Esto me bloquea la grilla del detalle de la lista de precio, cuando
                    //                        la lista de precio está aprobada
                    if (dgDetailPriceList != null)
                        dgDetailPriceList.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.False;
                }
                else
                {
                    AddDetail.Enabled = true;
                    DeleteDetail.Enabled = true;
                    SaveDetail.Enabled = true;

                    //EVESAN 04/Julio/2013
                    if (dgDetailPriceList != null)
                        dgDetailPriceList.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.True;
                }
                if (dgDetailPriceList.Rows.Count > 0)
                    dgPriceList.ActiveRow.Cells[SupplierId].Activation = Activation.NoEdit;
            }
        }

        private void dgPriceList_AfterCellActivate(object sender, EventArgs et)
        {
            //AECHEVERRY Validar 23-jul2013
            /*
            if (dgPriceList.ActiveCell.Column.Key == f ||
               dgPriceList.ActiveCell.Column.Key == j ||
               dgPriceList.ActiveCell.Column.Key == c)
                dgPriceList.ActiveCell.DroppedDown = true;
             */
        }

        private void dgDetailPriceList_AfterCellActivate(object sender, EventArgs e)
        {
            /*if (dgDetailPriceList.ActiveCell.Column.Key == a1 ||
               dgDetailPriceList.ActiveCell.Column.Key == e1 ||
               dgDetailPriceList.ActiveCell.Column.Key == d1)
                dgDetailPriceList.ActiveCell.DroppedDown = true;*/
        }

        private void dgPriceList_Error(object sender, ErrorEventArgs et)
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

        private void dgDetailPriceList_Error(object sender, ErrorEventArgs et)
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

        private void dgPriceList_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            if (dgPriceList.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgPriceList.Rows)
                {
                    if (fila.Cells[CheckSave].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        private void dgPriceList_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            if (dgPriceList.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgPriceList.Rows)
                {
                    if (fila.Cells[CheckSave].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        private void dgDetailPriceList_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            if (dgDetailPriceList.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgDetailPriceList.Rows)
                {
                    if (fila.Cells[i1].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        private void dgDetailPriceList_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            if (dgDetailPriceList.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgDetailPriceList.Rows)
                {
                    if (fila.Cells[i1].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        public Boolean validandoC()
        {
            //grilla uno
            Boolean saveR = false;
            int irow;

            if (dgPriceList.Rows.Count > 0)
            {
                try
                {
                    dgPriceList.ActiveRow.Cells[CheckSave].Activated = true;
                }
                catch
                {
                    dgPriceList.Rows[0].Activated = true;
                }
                for (irow = 0; irow <= dgPriceList.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        Int64 cs = Convert.ToInt64(dgPriceList.Rows[irow].Cells[CheckSave].Value);
                        if (cs == 1)
                            saveR = true;
                        Int64 cm = Convert.ToInt64(dgPriceList.Rows[irow].Cells[l].Value);
                        if (cm == 1)
                            saveR = true;
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        return false;
                    }
                }
            }
            //grilla dos

            //
            if (saveR)
            {
                Question pregunta = new Question("LDAPB - Pregunta", "¿Desea Guardar los cambios en Lista de Precios?", "Si", "No");
                pregunta.ShowDialog();
                Int64 answer = pregunta.answer;
                if (answer == 2)
                {
                    try
                    {
                        SaveList.PerformClick();
                        SaveDetail.PerformClick();
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        private void dgPriceList_AfterRowUpdate(object sender, RowEventArgs e)
        {

        }

        private void dgPriceList_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {

        }

        private void dgPriceList_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (dgPriceList.ActiveCell.OriginalValue != dgPriceList.ActiveCell.Value)
            {
                //
                if (dgPriceList.ActiveCell.Column.Key == SupplierId)
                {
                    String supplier;

                    if (Convert.ToString(dgPriceList.ActiveCell.Value) == "" || Convert.ToString(dgPriceList.ActiveCell.Value) == " ")
                    {
                        supplier = "";
                    }
                    else
                    {

                        supplier = dgPriceList.ActiveRow.Cells[SupplierId].Value.ToString();

                        foreach (DetailPrLstGEPPB x in customerbindingd)
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inuprice_list_deta_id" };
                            Object[] p3 = new object[] { x.PriceListDetaId };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deleteDetailPriceList, 1, p1, p2, p3);

                        }
                        general.doCommit();//BLGEPPB.Save();

                        if ((typeUser == "F") && (supplier != ""))
                        {

                            if (dgDetailPriceList.Rows.Count > 0)
                            {
                                customerbindingd.Clear();
                            }

                        }
                        dgDetailPriceList.DisplayLayout.Bands[0].Columns[a1].ValueList = general.valuelist2(BLConsultas.ArticulosControlados + " and supplier_id=" + supplier + " Order By article_id", "DESCRIPCION", "CODIGO");
                    }
                }
            }
        }

        private void dgDetailPriceList_BeforePerformAction(object sender, BeforeUltraGridPerformActionEventArgs e)
        {
            dgDetailPriceList.EventManager.SetEnabled(GridEventIds.BeforePerformAction, false);

            try
            {
                //Verifica que exista una grilla, que haya una celda activa y a su vez que haya habido un cambio en ella
                if (this.dgDetailPriceList == null || this.dgDetailPriceList.ActiveCell == null || !this.dgDetailPriceList.ActiveCell.DataChanged)
                {
                    return;
                }
                //Verifica si la celda es una lista de valores y ademas si se se presiona la tecla de ir a la proxima celda o la de ir a la anterior celda
                if (this.dgDetailPriceList.ActiveCell.Column.Style == Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate &&
                    this.dgDetailPriceList.ActiveCell.EditorResolved.IsInEditMode && //Verifica que esta en modo de edicion para poder realizar alguna validar
                    (e.UltraGridAction == UltraGridAction.NextCellByTab || e.UltraGridAction == UltraGridAction.PrevCellByTab))
                {
                    this.dgDetailPriceList.ActiveCell.EditorResolved.DropDown();//Se selecciona el item en la lista de valores
                }
            }
            catch
            {
                //Este error sucede porque pierde alguna propiedad interna el editor para evitar que se genere una cola de errores se prefiere devolver al
                //valor original que tenia la celda
                if (!this.dgDetailPriceList.ActiveCell.EditorResolved.IsValid)//Si el valor no es valido
                {
                    this.dgDetailPriceList.ActiveCell.CancelUpdate();//devuelve al valor original que tenia la celda
                }
            }
            finally
            {
                dgDetailPriceList.EventManager.SetEnabled(GridEventIds.BeforePerformAction, true);
            }

        }
    }
}