using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.UI;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using System.Collections;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlGEC : UserControl
    {
        #region campos
        BindingSource customerbinding = new BindingSource();
        Boolean start;
        String typeUser;
        Int64 userId;
        //int conteo;
        //columnas
        String a = "CommissionId";
        String b = "ArticleId";
        String c = "SaleChanelId";
        String d = "GeograpLocationId";
        String e = "ContratorId";
        String f = "RecoveryPercentage";
        String g = "PymentPercentage";
        String h = "IncluVatRecoCommi";
        String i = "IncluVatPayCommi";
        String j = "InitialDate";
        String k = "CheckSave";
        String l = "CheckModify";
        String m = "LineId";
        String n = "SublineId";
        String o = "SupplierId";
        String p = "InitialDateA";
        #endregion campos
        //
        //
        BLGENERAL general = new BLGENERAL();
        String msjError = string.Empty;
        public Boolean operPendientes = false;
        
        //
        Boolean msjConfirm = false;

        public ctrlGEC()
        {
            InitializeComponent();

        }

        public void PopulateData(String typeuser, Int64 userid)
        {

            //validaciones de usuario
            typeUser = typeuser;
            userId = userid;
            //
            start = false;
            List<ComArtGEC> ListCommision = new List<ComArtGEC>();
            ListCommision = BLGEC.FcuCommission();
            customerbinding.DataSource = ListCommision;
            bnNavigator.BindingSource = customerbinding;
            dgCommission.DataSource = customerbinding;
            //combo ubicacion geografica comisiones
            //dgCommission.DisplayLayout.Bands[0].Columns[d].ValueList = ValueListGeoLocation("CODIGO", "DESCRIPCION");
            /// SAO216977 Se adiciona el control de ubicaciones geograficas a la columna

            UltraCombo ucbGeographLocation = new ListOfValues().SetTreeLov(BLConsultas.UbicacionGeograficaTree, "Ubicación Geográfica");
            ucbGeographLocation.Tag = dgCommission.DisplayLayout.Bands[0].Columns[d];
            dgCommission.DisplayLayout.Bands[0].Columns[d].EditorControl = ucbGeographLocation;
            dgCommission.DisplayLayout.Bands[0].Columns[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

            //
            dgCommission.DisplayLayout.Bands[0].Columns[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dgCommission.DisplayLayout.Bands[0].Columns[m].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dgCommission.DisplayLayout.Bands[0].Columns[m].ValueList = ValueListLine("CODIGO", "DESCRIPCION");

            //sublinea

            SetCollectionSublineByLine();

            //Configuración Combo SubLineas
            dgCommission.DisplayLayout.Bands[0].Columns[n].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            dgCommission.DisplayLayout.Bands[0].Columns[n].Nullable = Infragistics.Win.UltraWinGrid.Nullable.EmptyString;
            dgCommission.DisplayLayout.Bands[0].Columns[n].ValueList = ValueListSubLinea("CODIGO", "DESCRIPCION");


            SetCollectionArticles();

            dgCommission.DisplayLayout.Bands[0].Columns[b].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            dgCommission.DisplayLayout.Bands[0].Columns[b].Nullable = Infragistics.Win.UltraWinGrid.Nullable.EmptyString;
            dgCommission.DisplayLayout.Bands[0].Columns[b].ValueList = ValueListArticulos("CODIGO", "DESCRIPCION");

            


            ////
            ////canales de venta
            dgCommission.DisplayLayout.Bands[0].Columns[c].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            dgCommission.DisplayLayout.Bands[0].Columns[c].ValueList = ValueListSalesChanel("CODIGO", "DESCRIPCION");
            //Contratista
            dgCommission.DisplayLayout.Bands[0].Columns[e].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            dgCommission.DisplayLayout.Bands[0].Columns[e].ValueList = ValueListContractor("CODIGO", "DESCRIPCION");
            ////proveedor
            dgCommission.DisplayLayout.Bands[0].Columns[o].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
            dgCommission.DisplayLayout.Bands[0].Columns[o].ValueList = ValueListSupplier("IDENTIFICACION", "NOMBRE");
            
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
            //
            dgCommission.DisplayLayout.Bands[0].Columns[h].ValueList = dropDownsn;
            //
            dgCommission.DisplayLayout.Bands[0].Columns[h].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dgCommission.DisplayLayout.Bands[0].Columns[i].ValueList = dropDownsn;
            //
            dgCommission.DisplayLayout.Bands[0].Columns[i].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //ocultar columnas guias
            dgCommission.DisplayLayout.Bands[0].Columns[k].Hidden = true;
            dgCommission.DisplayLayout.Bands[0].Columns[l].Hidden = true;
            dgCommission.DisplayLayout.Bands[0].Columns[p].Hidden = true;
            //alineaciones y bloqueo
            dgCommission.DisplayLayout.Bands[0].Columns[f].CellAppearance.TextHAlign = HAlign.Right;
            dgCommission.DisplayLayout.Bands[0].Columns[g].CellAppearance.TextHAlign = HAlign.Right;
            dgCommission.DisplayLayout.Bands[0].Columns[a].CellActivation = Activation.NoEdit;
            dgCommission.DisplayLayout.Bands[0].Columns[a].CellAppearance.BackColor = Color.LightGray;
            dgCommission.DisplayLayout.Bands[0].Columns[h].CellAppearance.TextHAlign = HAlign.Center;
            dgCommission.DisplayLayout.Bands[0].Columns[i].CellAppearance.TextHAlign = HAlign.Center;
            dgCommission.DisplayLayout.Bands[0].Columns[f].MaskInput = "nn.nn"; //EVESAN
            dgCommission.DisplayLayout.Bands[0].Columns[f].MaxLength = 5;
            dgCommission.DisplayLayout.Bands[0].Columns[f].MaxValue = 99.99;
            dgCommission.DisplayLayout.Bands[0].Columns[f].Format = "#,##0.00";
            dgCommission.DisplayLayout.Bands[0].Columns[g].MaskInput = "nn.nn"; //EVESAN
            dgCommission.DisplayLayout.Bands[0].Columns[g].MaxLength = 5;
            dgCommission.DisplayLayout.Bands[0].Columns[g].MaxValue = 99.99;
            dgCommission.DisplayLayout.Bands[0].Columns[g].Format = "#,##0.00";
            dgCommission.DisplayLayout.Bands[0].Columns[j].MinValue = DateTime.Today;
            //campos obligatorios
            String[] fieldscommision = new string[] { f, g, h, i, j, m, n };
            general.setColumnRequiered(dgCommission, fieldscommision);
            //
            String[] fieldsupper = new string[] { b, c, d, e, h, i, m, n, o };
            general.setColumnUpper(dgCommission, fieldsupper);
            start = true;
            operPendientes = false;

        }

        private UltraDropDown ValueListLine(string ValueMember, string DisplayMember)
        {

            UltraDropDown _udd = new UltraDropDown();
            _udd.DataSource = DAL.DALGEC.GetSentence(BLConsultas.LineasControladas.ToString());
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;

            return _udd;
        }
        private UltraDropDown ValueListGeoLocation(string ValueMember, string DisplayMember)
        {

            UltraDropDown _udd = new UltraDropDown();
            _udd.DataSource = DAL.DALGEC.GetSentence(BLConsultas.UbicacionGeografica.ToString());
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;

            return _udd;
        }


        private UltraDropDown ValueListSubLinea(string ValueMember, string DisplayMember)
        {
            List<ContainerSublineByLine> _Sublines = new List<ContainerSublineByLine>();
            UltraDropDown _udd = new UltraDropDown();
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;
            _udd.DataSource = ContainerCollections.GetInstance().CollectionSublinesByLine;

            return _udd;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ValueMember"></param>
        /// <param name="DisplayMember"></param>
        /// <returns></returns>
        private UltraDropDown ValueListArticulos(string ValueMember, string DisplayMember)
        {
            List<ContainerArticle> _Articles = new List<ContainerArticle>();
            UltraDropDown _udd = new UltraDropDown();
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;
            _udd.DataSource = ContainerCollections.GetInstance().CollectionArticles;

            return _udd;
        }

        private UltraDropDown ValueListSalesChanel(string ValueMember, string DisplayMember)
        {
            UltraDropDown _udd = new UltraDropDown();
            _udd.DataSource    = DAL.DALGEC.GetSentence(BLConsultas.CanalesdeVenta.ToString());
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember   = ValueMember;

            return _udd;
        }

        private UltraDropDown ValueListContractor(string ValueMember, string DisplayMember)
        {
            UltraDropDown _udd = new UltraDropDown();
            _udd.DataSource = DAL.DALGEC.GetSentence(BLConsultas.Contratista.ToString());
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;

            return _udd;
        }

        private UltraDropDown ValueListSupplier(string ValueMember, string DisplayMember)
        {
            UltraDropDown _udd = new UltraDropDown();
            _udd.DataSource = DAL.DALGEC.GetSentence(BLConsultas.Proveedor.ToString());
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;

            return _udd;
        }

        private void SetCollectionArticles()
        {
            List<ContainerArticle> _articles = new List<ContainerArticle>();
            StringBuilder sb = new StringBuilder();

            sb.Append("select article_id CODIGO, description DESCRIPCION, subline_id  from ld_article ");

            DataSet ds = new DataSet();
            ds = DAL.DALGEC.GetSentence(sb.ToString());

            foreach (DataRow dr in ds.Tables[0].Rows)
            {

                ContainerArticle ca = new ContainerArticle();
                ca.CODIGO = Convert.ToString(dr[0].ToString());
                ca.DESCRIPCION = Convert.ToString(dr[1].ToString());
                ca.SubLineId = Convert.ToString(dr[2].ToString());
                _articles.Add(ca);
            }

            ContainerCollections.GetInstance().CollectionArticles = _articles;
        }

        private void SetCollectionSublineByLine()
        {
            List<ContainerSublineByLine> _sublines = new List<ContainerSublineByLine>();
            StringBuilder sb = new StringBuilder();

            sb.Append("SELECT -1 CODIGO, '' DESCRIPCION, -1 LINEA FROM dual ");
            sb.Append("UNION ALL ");
            sb.Append("SELECT subline_id CODIGO, description DESCRIPCION, line_id LINEA FROM ld_subline WHERE approved = 'Y' ");

            DataSet ds = new DataSet();
            ds = DAL.DALGEC.GetSentence(sb.ToString());

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ContainerSublineByLine csbl = new ContainerSublineByLine();
                csbl.CODIGO = Convert.ToString(dr[0].ToString());
                csbl.DESCRIPCION = Convert.ToString(dr[1].ToString());
                csbl.Line_id = Convert.ToString(dr[2].ToString());
                _sublines.Add(csbl);
            }

            ContainerCollections.GetInstance().CollectionSublinesByLine = _sublines;
        }

        private UltraDropDown populateBySubline(string subLineId)
        {
            UltraDropDown _list = new UltraDropDown();

            List<ContainerArticle> filterArticles = new List<ContainerArticle>();
            List<ContainerArticle> _AllArticles = new List<ContainerArticle>();
            _AllArticles = ContainerCollections.GetInstance().CollectionArticles;

            foreach (ContainerArticle _art in _AllArticles)
            {

                if (_art.SubLineId == subLineId)
                {
                    ContainerArticle _a = new ContainerArticle();
                    _a.CODIGO = _art.CODIGO;
                    _a.DESCRIPCION = _art.DESCRIPCION;
                    _a.SubLineId = _art.SubLineId;
                    filterArticles.Add(_a);
                }
            }

            _list.DataSource = filterArticles;
            _list.ValueMember = "CODIGO";
            _list.DisplayMember = "DESCRIPCION"; 

            return _list;

        }

        private UltraDropDown populateByLine(string lineId)
        {
            //general.mensajeOk("Línea en fila: " + lineId);
            UltraDropDown _list = new UltraDropDown();

            List<ContainerSublineByLine> filteredSublines = new List<ContainerSublineByLine>();
            List<ContainerSublineByLine> _AllSublines = new List<ContainerSublineByLine>();
            _AllSublines = ContainerCollections.GetInstance().CollectionSublinesByLine;

            foreach (ContainerSublineByLine _subl in _AllSublines)
            {

                if (_subl.Line_id == lineId)
                {
                    ContainerSublineByLine _s = new ContainerSublineByLine();
                    _s.CODIGO = _subl.CODIGO;
                    _s.DESCRIPCION = _subl.DESCRIPCION;
                    _s.Line_id = _subl.Line_id;
                    filteredSublines.Add(_s);
                }
            }

            _list.DataSource = filteredSublines;
            _list.ValueMember = "CODIGO";
            _list.DisplayMember = "DESCRIPCION";

            return _list;

        }

        private void bindingNavigatorAddItem_Click(object sender, EventArgs et)
        {
            if (dgCommission.Rows.Count > 0)
            {
                try
                {
                    dgCommission.ActiveRow.Cells[k].Activated = true;
                }
                catch
                {
                    dgCommission.Rows[0].Activated = true;
                }
                msjError = "";
                if (validate(dgCommission.Rows.Count - 1))
                {
                    operPendientes = true;
                    customerbinding.Add(BLGEC.AddRowListc());
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[a].Value = general.valueReturn(BLConsultas.secuenceComision, "Int64"); //BLGEC.consCommission();
                    start = false;
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[m].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[n].Value = " ";
                    //dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[n].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                    start = true;
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[b].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[d].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[c].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[e].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[o].Value = " ";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[h].Value = "N";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[i].Value = "N";
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[k].Value = 1;
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[l].Value = 0;
                    dgCommission.Rows[dgCommission.Rows.Count - 1].Cells[j].Value = DateTime.Now.ToString("dd/MM/yyyy");
                    bindingNavigatorLastPosition.PerformClick();
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
                customerbinding.Add(BLGEC.AddRowListc());
                dgCommission.Rows[0].Cells[a].Value = general.valueReturn(BLConsultas.secuenceComision, "Int64"); //BLGEC.consCommission();
                start = false;
                dgCommission.Rows[0].Cells[m].Value = " ";
                dgCommission.Rows[0].Cells[n].Value = " ";
                //dgCommission.Rows[0].Cells[n].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                start = true;
                dgCommission.Rows[0].Cells[b].Value = " ";
                dgCommission.Rows[0].Cells[d].Value = " ";
                dgCommission.Rows[0].Cells[c].Value = " ";
                dgCommission.Rows[0].Cells[e].Value = " ";
                dgCommission.Rows[0].Cells[o].Value = " ";
                dgCommission.Rows[0].Cells[h].Value = "N";
                dgCommission.Rows[0].Cells[i].Value = "N";
                dgCommission.Rows[0].Cells[k].Value = 1;
                dgCommission.Rows[0].Cells[l].Value = 0;
                dgCommission.Rows[0].Cells[j].Value = DateTime.Now.ToString("dd/MM/yyyy");
                bindingNavigatorLastPosition.PerformClick();
            }
        }

        private void bindingNavigatorSaveItem_Click(object sender, EventArgs et)
        {
            msjConfirm = false;
            if (dgCommission.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                try
                {
                    dgCommission.ActiveRow.Cells[k].Activated = true;
                }
                catch
                {
                    dgCommission.Rows[0].Activated = true;
                }
                Boolean error = false;
                //cadena de errores
                String errorRow = "";
                int irow;
                for (irow = 0; irow <= dgCommission.Rows.Count - 1; irow++)
                {
                    //msjError = "";
                    if (validate(irow))
                    {
                        Int64 commisionid = Convert.ToInt64(dgCommission.Rows[irow].Cells[a].Text);
                        String articleid = Convert.ToString(dgCommission.Rows[irow].Cells[b].Value);
                        String salechanelid = Convert.ToString(dgCommission.Rows[irow].Cells[c].Value);
                        String geograplocationid = Convert.ToString(dgCommission.Rows[irow].Cells[d].Value);
                        String contratorid = Convert.ToString(dgCommission.Rows[irow].Cells[e].Value);
                        Decimal recoverypercentage = Convert.ToDecimal(dgCommission.Rows[irow].Cells[f].Text);
                        Decimal pymentpercentage = Convert.ToDecimal(dgCommission.Rows[irow].Cells[g].Text);
                        DateTime initialdate = Convert.ToDateTime(dgCommission.Rows[irow].Cells[j].Value);
                        DateTime initialdateA = Convert.ToDateTime(dgCommission.Rows[irow].Cells[p].Value);
                        String incluvatpaycommi = Convert.ToString(dgCommission.Rows[irow].Cells[i].Value);
                        String incluvatrecocommi = Convert.ToString(dgCommission.Rows[irow].Cells[h].Value);
                        String lineid = Convert.ToString(dgCommission.Rows[irow].Cells[m].Value);
                        String sublineid = Convert.ToString(dgCommission.Rows[irow].Cells[n].Value);
                        String supplierid = Convert.ToString(dgCommission.Rows[irow].Cells[o].Value);
                        Int64 cs = Convert.ToInt64(dgCommission.Rows[irow].Cells[k].Text);

                        DateTime d1 = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                        DateTime d2 = new DateTime(Convert.ToInt32(initialdate.ToString("yyyy")),
                                                   Convert.ToInt32(initialdate.ToString("MM")),
                                                   Convert.ToInt32(initialdate.ToString("dd"))
                                                   );
                        if (cs == 1)
                        {


                            if (d1 <= d2)
                            {
                                //BLGENERAL.mensaje("");
                                BLGEC.saveCommission(commisionid, articleid, salechanelid, geograplocationid, contratorid, recoverypercentage, pymentpercentage, initialdate, incluvatpaycommi, incluvatrecocommi, lineid, sublineid, supplierid);
                                dgCommission.Rows[irow].Cells[p].Value = dgCommission.Rows[irow].Cells[j].Value;
                                dgCommission.Rows[irow].Cells[k].Value = 0;
                                dgCommission.Rows[irow].Cells[l].Value = 0;
                            }
                            else
                            {
                                errorRow += dgCommission.Rows[irow].Cells[a].Text + ", ";
                                error = true;
                            }
                        }
                        Int64 cm = Convert.ToInt64(dgCommission.Rows[irow].Cells[l].Text);
                        if (cm == 1)
                        {
                            DateTime d3 = new DateTime(Convert.ToInt32(initialdateA.ToString("yyyy")),
                                                       Convert.ToInt32(initialdateA.ToString("MM")),
                                                       Convert.ToInt32(initialdateA.ToString("dd"))
                                                       );


                            if(d1 <= d2 || d2 == d3)
                            {
                                try
                                {
                                    BLGEC.modifyCommission(commisionid, articleid, salechanelid, geograplocationid, contratorid, recoverypercentage, pymentpercentage, initialdate, incluvatpaycommi, incluvatrecocommi, lineid, sublineid, supplierid);
                                    dgCommission.Rows[irow].Cells[p].Value = dgCommission.Rows[irow].Cells[j].Value;
                                    dgCommission.Rows[irow].Cells[k].Value = 0;
                                    dgCommission.Rows[irow].Cells[l].Value = 0;
                                }
                                catch
                                {
                                    errorRow += dgCommission.Rows[irow].Cells[a].Text + ", ";
                                    //general.mensajeERROR("El registro Comisión [" + commisionid.ToString() + "] ya presenta los mismos Criterios que un registro Anterior. Revise la Información.");
                                    error = true;
                                }
                            }
                            else
                            {
                                errorRow += dgCommission.Rows[irow].Cells[a].Text + ", ";

                                error = true;
                            }
                        }
                    }
                    else
                    {
                        msjConfirm = true;

                    }
                }
                general.doCommit();//BLGEPBR.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error && !msjConfirm)
                    general.mensajeERROR("Error en la información ingresada, las Comisiones con Identificación: " + errorRow + "pudierón no ser Guardadas o Modificadas");
                else
                    operPendientes = false;
            }
        }

        Boolean validate(int irow)
        {
            if (dgCommission.Rows[irow].Cells[m].Value != null && string.IsNullOrEmpty(dgCommission.Rows[irow].Cells[m].Value.ToString()))
            {
                general.mensajeERROR("Debera ingresar una Linea para la Comisión con Identificación: " + dgCommission.Rows[irow].Cells[a].Text);
                return false;
            }
            if (dgCommission.Rows[irow].Cells[n].Value != null && string.IsNullOrEmpty(dgCommission.Rows[irow].Cells[n].Value.ToString()))
            {
                general.mensajeERROR("Debera ingresar una SubLinea para la Comisión con Identificación: " + dgCommission.Rows[irow].Cells[a].Text);
                return false;
            }
            if (dgCommission.Rows[irow].Cells[h].Text != null && string.IsNullOrEmpty(dgCommission.Rows[irow].Cells[h].Text))
            {
                general.mensajeERROR("Debera seleccionar un Criterio para la opcion sobre Incluir IVA la comisión de cobro para la Comisión con Identificación: " + dgCommission.Rows[irow].Cells[a].Text);
                return false;
            }
            if (dgCommission.Rows[irow].Cells[i].Text != null && string.IsNullOrEmpty(dgCommission.Rows[irow].Cells[i].Text))
            {
                general.mensajeERROR("Debera seleccionar un Criterio para la opcion sobre Incluir IVA la comisión de pago para la Comisión con Identificación: " + dgCommission.Rows[irow].Cells[a].Text);
                return false;
            }

            return true;
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ninguna Comisión Seleccionada");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgCommission.ActiveRow.Cells[k].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ninguna Comisión Seleccionada");

                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("LDAPB - Eliminar Comisión", "¿Desea Eliminar la Comisión " + dgCommission.ActiveRow.Cells[a].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inucommission_id" };
                            Object[] p3 = new object[] { dgCommission.ActiveRow.Cells[a].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deleteComision, 1, p1, p2, p3);
                            //BLGEC.deleteComission(Convert.ToInt64(dgCommission.ActiveRow.Cells[a].Value));
                            dgCommission.ActiveRow.Delete(false);
                            general.doCommit();//BLGEC.Save();
                        }
                        catch
                        {
                            general.mensajeERROR("No puede eliminar esta Comisión");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgCommission.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }

        private void dgCommission_CellChange(object sender, CellEventArgs et)
        {
            //incio de operaciones
            operPendientes = true;
            dgCommission.Rows[et.Cell.Row.Index].Cells[l].Value = 1;
        }

        private void bindingNavigatorPrintItem_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgCommission);
        }

        private void importar_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgCommission);
        }

        private void exportar_Click(object sender, EventArgs e)
        {
            //String[] listaColumnas = new string[] { a };
            general.exportarExcel(dgCommission);//, listaColumnas);
        }

        private void dgCommission_AfterCellActivate(object sender, EventArgs et)
        {

            if (dgCommission.ActiveCell.Column.Key == b ||
                dgCommission.ActiveCell.Column.Key == c ||
                dgCommission.ActiveCell.Column.Key == d ||
                dgCommission.ActiveCell.Column.Key == e ||
                dgCommission.ActiveCell.Column.Key == m ||
                dgCommission.ActiveCell.Column.Key == n ||
                dgCommission.ActiveCell.Column.Key == h ||
                dgCommission.ActiveCell.Column.Key == i ||
                dgCommission.ActiveCell.Column.Key == o)
                dgCommission.ActiveCell.DroppedDown = true;
        }

        private void dgCommission_Error(object sender, ErrorEventArgs et)
        {

            if (et.ErrorType == ErrorType.Data)
            {
                if (et.DataErrorInfo.Cell.Column.Key == j)
                    general.mensajeERROR("Debera ingresar una Fecha Inicial valida para la Comisión con Identificación: " + dgCommission.ActiveRow.Cells[a].Text);

                et.Cancel = true;

            }
        }

        private void dgCommission_CellListSelect(object sender, CellEventArgs et)
        {

        }

        private void dgCommission_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            if (dgCommission.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgCommission.Rows)
                {
                    if (fila.Cells[k].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
         
        }

        private void dgCommission_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            
            if (dgCommission.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgCommission.Rows)
                {
                    if (fila.Cells[k].Text == "1")
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

            if (dgCommission.Rows.Count > 0)
            {
                try
                {
                    dgCommission.ActiveRow.Cells[k].Activated = true;
                }
                catch
                {
                    dgCommission.Rows[0].Activated = true;
                }
                for (irow = 0; irow <= dgCommission.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        DateTime initialdate = Convert.ToDateTime(dgCommission.Rows[irow].Cells[j].Value);
                        DateTime initialdateA = Convert.ToDateTime(dgCommission.Rows[irow].Cells[p].Value);
                        Int64 cs = Convert.ToInt64(dgCommission.Rows[irow].Cells[k].Text);
                        if (cs == 1)
                        {
                            if (Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy")) <= Convert.ToDateTime(initialdate.ToString("dd/MM/yyyy")))
                                saveR = true;
                            else
                            {
                                general.mensajeERROR("Hay errores en algunas fechas asignadas");
                                return false;
                            }
                        }
                        Int64 cm = Convert.ToInt64(dgCommission.Rows[irow].Cells[l].Text);
                        if (cm == 1)
                        {
                            if ((Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy")) <= Convert.ToDateTime(initialdate.ToString("dd/MM/yyyy"))) || (Convert.ToDateTime(initialdate.ToString("dd/MM/yyyy")) == Convert.ToDateTime(initialdateA.ToString("dd/MM/yyyy"))))
                                saveR = true;
                            else
                            {
                                general.mensajeERROR("Hay errores en algunas fechas asignadas");
                                return false;
                            }
                        }
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        return false;
                    }
                }
            }
            //
            if (saveR)
            {
                Question pregunta = new Question("LDAPB - Pregunta", "¿Desea Guardar los cambios en Definición de Comisiones?", "Si", "No");
                pregunta.ShowDialog();
                Int64 answer = pregunta.answer;
                if (answer == 2)
                {
                    try
                    {
                        bindingNavigatorSaveItem.PerformClick();
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
            return true;
        }



        private void dgCommission_AfterCellUpdate(object sender, CellEventArgs e)
        {

            if (dgCommission.ActiveCell != null)
            {
                if (dgCommission.ActiveCell.Column.Key == m)
                {
                    if (dgCommission.ActiveRow.Cells[m].Value.ToString() != "" && dgCommission.ActiveRow.Cells[m].Value.ToString() != " ")
                    {

                        //
                        start = false;
                        dgCommission.ActiveRow.Cells[b].ValueList = null;
                        dgCommission.ActiveRow.Cells[b].Value = string.Empty;
                        dgCommission.ActiveRow.Cells[b].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                        start = true;
                    }
                }


                /*
                if (dgCommission.ActiveCell.Column.Key == n)
                {
                    if (dgCommission.ActiveRow.Cells[n].Value.ToString() != "" && dgCommission.ActiveRow.Cells[n].Value.ToString() != " ")
                    {
                        //start = false;
                        //dgCommission.ActiveRow.Cells[b].ValueList = null;
                        //dgCommission.ActiveRow.Cells[b].Value = string.Empty;
                        //dgCommission.ActiveRow.Cells[b].ValueList = general.valuelistNumberId(BLConsultas.Articulos + " where subline_id = " + dgCommission.ActiveRow.Cells[n].Value.ToString() + " And Approved='Y' Order By article_id", "DESCRIPCION", "CODIGO");
                        //start = true;
                    }
                    else
                    {
                        start = false;
                        dgCommission.ActiveRow.Cells[b].ValueList = null;
                        dgCommission.ActiveRow.Cells[b].Value = string.Empty;
                        dgCommission.ActiveRow.Cells[b].ValueList = general.valuelistNumberId("", "DESCRIPCION", "CODIGO");
                        start = true;
                    }
                
                } * */



            }
        }

        private void dgCommission_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            /* if (dgCommission.ActiveCell.Column.Key == j)
             {
                 if (dgCommission.ActiveCell. < DateTime.Now)
                 {
                     general.mensajeERROR("");
                 }
             }*/
        }

        private void dgCommission_BeforeCellActivate(object sender, CancelableCellEventArgs e)
        {
            string articuloID = b;
            string subLinea = n;

            if (e.Cell.Column.Key == articuloID)
                this.dgCommission.ActiveRow.Cells[b].ValueList = populateBySubline(this.dgCommission.ActiveRow.Cells[2].Value.ToString());
            else if (e.Cell.Column.Key == subLinea)
                this.dgCommission.ActiveRow.Cells[n].ValueList = populateByLine(this.dgCommission.ActiveRow.Cells[1].Value.ToString());

        }
    }
}
