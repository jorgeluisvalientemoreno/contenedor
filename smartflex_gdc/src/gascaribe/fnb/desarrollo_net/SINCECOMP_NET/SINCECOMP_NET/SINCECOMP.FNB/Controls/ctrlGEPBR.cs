using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.UI;
using System.Collections;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
//
using Infragistics.Win.UltraWinEditors;
using SINCECOMP.FNB.DAL;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Controls
{
    /// <summary>
    /// 
    /// </summary>
    public partial class ctrlGEPBR : UserControl
    {
        #region Campos

        BindingSource customerbinding = new BindingSource();
        BindingSource customerbindingp = new BindingSource();
        String        funderparameter;
        String  sRow;
        Boolean start;
        String  typeUser;
        Int64   userId;
        //columnas articulos
        String articleId    = "Id";
        String description  = "Description";
        String warranty     = "Warranty";
        String installation = "Instalation";
        String subLine      = "Subline";
        String brand        = "Brand";
        String funder       = "Funder";
        String concept      = "Concept";
        String supplier     = "Supplier";
        String vat          = "Vat";
        String observation  = "Observation";
        String costControl  = "Costcontrol";
        String available    = "Available";
        String active       = "Active";
        String approvation  = "Approbation";
        String reference    = "Reference";
        String equivalence  = "Equivalence";
        String checkSave    = "CheckSave";
        String checkModify  = "CheckModify";
        //columna propiedades
        String propertiesArtId       = "PropertArtId";
        String propertiesArtId_b1    = "ArticleId";
        String propertiesId          = "PropertyId";
        String propertiesValue       = "Value";
        String propertiesCheckSave   = "CheckSave";
        String propertiesCheckModify = "CheckModify";
        //
        BLGENERAL general = new BLGENERAL();
        String msjError = "";
        //
        #endregion Campos
        //
        /// <summary>
        /// 
        /// </summary>
        public Boolean operPendientes = false;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="typeuser"></param>
        /// <param name="userid"></param>
        public ctrlGEPBR(String typeuser, Int64 _userid)
        {
            InitializeComponent();

            typeUser = string.Empty;
            userId = 0;
            //
            typeUser = typeuser;
            userId   = _userid;

            PopulatePrincial();

        }
        /// <summary>
        /// Carga de los datos principales
        /// </summary>
        public void PopulatePrincial()
        {
            try
            {
                //validaciones de usuario
                // [C]  PROVEEDOR
                // [F]  Funcionario
                // [CV] Contratista de Venta
                //articulos
                start = false;
                List<ArticleGEPBR> ListArticle = new List<ArticleGEPBR>();
                ListArticle                    = BLGEPBR.FcuArticle(userId.ToString(), typeUser.ToString());
                customerbinding.DataSource     = ListArticle;

                #region Navigator
                bnNavigator.BindingSource = customerbinding;
                bnNavigator.Enabled = true;
                #endregion Navigator
                #region Fuente de datos articulos
                dgArticle.DataSource = customerbinding;
                dgArticle.Enabled = true;
                #endregion Fuente de datos articulos
                #region combo Marca en grid

                //combo Marca en grid
                dgArticle.DisplayLayout.Bands[0].Columns[brand].ValueList = general.valuelistNumberId(BLConsultas.Marcas, "DESCRIPCION", "CODIGO");
                dgArticle.DisplayLayout.Bands[0].Columns[brand].Style     = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

                dgArticle.DisplayLayout.Bands[0].Columns[funder].ValueList = general.valuelist2(BLConsultas.Financiador, "DESCRIPCION", "CODIGO");
                dgArticle.DisplayLayout.Bands[0].Columns[funder].Style     = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

                #endregion combo Marca en grid

                //combo Proveedor en grid

                dgArticle.DisplayLayout.Bands[0].Columns[supplier].ValueList = general.valuelist2(BLConsultas.Proveedor, "NOMBRE", "IDENTIFICACION");
                dgArticle.DisplayLayout.Bands[0].Columns[supplier].Style     = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

                if (typeUser == "C")
                {
                    #region usuario contratista

                    DataTable parametro = new DataTable();
                    parametro       = general.getValueList(BLConsultas.ParametroFinanciacion);
                    funderparameter = parametro.Rows[0][0].ToString();

                    if (String.IsNullOrEmpty(funderparameter))
                        general.mensajeERROR("No se ha configurado el financiador por defecto");


                    #endregion usuario contratista
                }

                dgArticle.DisplayLayout.Bands[0].Columns[concept].ValueList = general.valuelist2(BLConsultas.Concepto, "DESCRIPCION", "CODIGO");
                dgArticle.DisplayLayout.Bands[0].Columns[concept].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

                SetCollectionSubLines();
                dgArticle.DisplayLayout.Bands[0].Columns[subLine].ValueList = ValueListSubLineas("CODIGO", "DESCRIPTION");
                dgArticle.DisplayLayout.Bands[0].Columns[subLine].Style     = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                
                //combo s/n
                #region Combo S/N

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
                dgArticle.DisplayLayout.Bands[0].Columns[costControl].ValueList = dropDownsn;
                dgArticle.DisplayLayout.Bands[0].Columns[costControl].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

                #endregion Combo S/N
                //combo s/n2
                #region combo s/n2

                List<ListSN> lista2 = new List<ListSN>();
                lista2.Add(new ListSN(" ", " "));
                lista2.Add(new ListSN("Y", "Si"));
                lista2.Add(new ListSN("N", "No"));
                BindingSource tabla2 = new BindingSource();
                tabla2.DataSource = lista2;
                UltraDropDown dropDownsn2 = new UltraDropDown();
                dropDownsn2.DataSource = tabla2;
                dropDownsn2.ValueMember = "Id";
                dropDownsn2.DisplayMember = "Description";
                dropDownsn2.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;

                #endregion combo s/n2
                // Combo Aprobación
                #region Combo Aprobación
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

                #endregion Combo Aprobación
                //
                #region visual
                dropDownAppr.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
                dgArticle.DisplayLayout.Bands[0].Columns[installation].ValueList = dropDownsn2;
                dgArticle.DisplayLayout.Bands[0].Columns[installation].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                dgArticle.DisplayLayout.Bands[0].Columns[available].ValueList = dropDownsn2;
                dgArticle.DisplayLayout.Bands[0].Columns[available].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                dgArticle.DisplayLayout.Bands[0].Columns[active].ValueList = dropDownsn2;
                dgArticle.DisplayLayout.Bands[0].Columns[active].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                dgArticle.DisplayLayout.Bands[0].Columns[approvation].ValueList = dropDownAppr;
                dgArticle.DisplayLayout.Bands[0].Columns[approvation].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                #endregion visual

                //bloques secundarios


                String data;
                sRow = bindingNavigatorPositionItem.Text;

                if (sRow == "0")
                    data = "-10";
                else
                    data = dgArticle.Rows[int.Parse(sRow) - 1].Cells[articleId].Value.ToString();

                //grilla propiedades 
                #region grilla propiedades

                List<PropArtGEPBR> ListProperty = new List<PropArtGEPBR>();
                ListProperty = BLGEPBR.FcuProperties(Convert.ToInt64(data));
                customerbindingp.DataSource = ListProperty;
                bnProperties.BindingSource = customerbindingp;
                dgProperties.DataSource = customerbindingp;
                //combo propiedad en grilla propiedades
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesId].ValueList = general.valuelistNumberId(BLConsultas.Propiedades, "DESCRIPCION", "CODIGO");
                //
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesId].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDown;
                //ocultar columnas guias
                dgArticle.DisplayLayout.Bands[0].Columns[checkSave].Hidden = true;
                dgArticle.DisplayLayout.Bands[0].Columns[checkModify].Hidden = true;
                //
                //EVESAN 01/Julio/2013

                int irow;
                for (irow = 0; irow <= dgArticle.Rows.Count - 1; irow++)
                {
                    if (dgArticle.Rows[irow].Cells[approvation].Text == "Si")
                    {
                        dgArticle.Rows[irow].Activation = Activation.NoEdit;
                        //aesguerra
                        if (typeUser == "F")
                            dgArticle.Rows[irow].Cells[available].IgnoreRowColActivation = true;
                    }
                    else
                        dgArticle.Rows[irow].Activation = Activation.AllowEdit;
                }

                if (typeUser == "C")
                    dgArticle.DisplayLayout.Bands[0].Columns[funder].Hidden = true;

                #region Configuraciòn visual

                dgProperties.DisplayLayout.Bands[0].Columns[propertiesArtId].Hidden = true;
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesArtId_b1].Hidden = true;
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesCheckSave].Hidden = true;
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesCheckModify].Hidden = true;

                #region alineaciones y bloqueo
                //alineaciones y bloqueo
                String[] fieldReadOnly = new string[] { articleId };
                general.setColumnReadOnly(dgArticle, fieldReadOnly);
                dgArticle.DisplayLayout.Bands[0].Columns[articleId].CellAppearance.TextHAlign = HAlign.Right;
                dgArticle.DisplayLayout.Bands[0].Columns[warranty].CellAppearance.TextHAlign = HAlign.Right;
                dgArticle.DisplayLayout.Bands[0].Columns[vat].CellAppearance.TextHAlign = HAlign.Right;
                dgArticle.DisplayLayout.Bands[0].Columns[articleId].CellAppearance.BackColor = Color.LightGray;
                dgArticle.DisplayLayout.Bands[0].Columns[installation].CellAppearance.TextHAlign = HAlign.Center;
                dgArticle.DisplayLayout.Bands[0].Columns[costControl].CellAppearance.TextHAlign = HAlign.Center;
                dgArticle.DisplayLayout.Bands[0].Columns[available].CellAppearance.TextHAlign = HAlign.Center;
                dgArticle.DisplayLayout.Bands[0].Columns[active].CellAppearance.TextHAlign = HAlign.Center;
                dgArticle.DisplayLayout.Bands[0].Columns[approvation].CellAppearance.TextHAlign = HAlign.Center;
                #endregion alineaciones y bloqueo
                //campos obligatorios
                String[] fieldsarticle = new string[] { articleId, description, subLine, funder, concept, supplier, costControl, reference };
                general.setColumnRequiered(dgArticle, fieldsarticle);

                if (typeUser == "C")
                {
                    fieldReadOnly = new string[] { supplier, approvation };
                    general.setColumnReadOnly(dgArticle, fieldReadOnly);
                }

                #region configuracion
                dgArticle.DisplayLayout.Bands[0].Columns[description].MaxLength = 200;
                dgArticle.DisplayLayout.Bands[0].Columns[warranty].MaskInput = "nnnn"; //EVESAN
                dgArticle.DisplayLayout.Bands[0].Columns[warranty].MaxLength = 4;
                dgArticle.DisplayLayout.Bands[0].Columns[vat].MaskInput = "nn.nn"; //EVESAN
                dgArticle.DisplayLayout.Bands[0].Columns[vat].MaxLength = 5;
                dgArticle.DisplayLayout.Bands[0].Columns[vat].MaxValue = 99.99;
                dgArticle.DisplayLayout.Bands[0].Columns[vat].Format = "#,##0.00";
                dgArticle.DisplayLayout.Bands[0].Columns[observation].MaxLength = 200;
                dgArticle.DisplayLayout.Bands[0].Columns[reference].MaxLength = 100;
                dgArticle.DisplayLayout.Bands[0].Columns[equivalence].MaxLength = 100;
                dgProperties.DisplayLayout.Bands[0].Columns[propertiesValue].MaxLength = 200;
                //tamanos columnas
                dgArticle.DisplayLayout.Bands[0].Columns[description].Width = 150;
                dgArticle.DisplayLayout.Bands[0].Columns[warranty].Width = 75;
                dgArticle.DisplayLayout.Bands[0].Columns[installation].Width = 85;
                dgArticle.DisplayLayout.Bands[0].Columns[funder].Width = 200;
                dgArticle.DisplayLayout.Bands[0].Columns[concept].Width = 150;
                dgArticle.DisplayLayout.Bands[0].Columns[vat].Width = 40;
                dgArticle.DisplayLayout.Bands[0].Columns[observation].Width = 150;
                dgArticle.DisplayLayout.Bands[0].Columns[costControl].Width = 105;
                dgArticle.DisplayLayout.Bands[0].Columns[available].Width = 90;
                dgArticle.DisplayLayout.Bands[0].Columns[active].Width = 70;
                dgArticle.DisplayLayout.Bands[0].Columns[approvation].Width = 90;
                dgArticle.DisplayLayout.Bands[0].Columns[subLine].Width = 150;
                dgArticle.DisplayLayout.Bands[0].Columns[supplier].Width = 150;
                //campos obligatorios
                String[] fieldsdetail = new string[] { propertiesArtId, propertiesArtId_b1, propertiesId, propertiesValue };
                general.setColumnRequiered(dgProperties, fieldsdetail);
                //campos mayusculas
                String[] fieldsupper = new string[] { description, observation, equivalence, reference, brand, funder, concept, supplier, costControl, installation, available, active, approvation };
                general.setColumnUpper(dgArticle, fieldsupper);
                fieldsupper = new string[] { propertiesId, propertiesValue };
                general.setColumnUpper(dgProperties, fieldsupper);
                start = true;
                #endregion configuracion

                #endregion Configuraciòn visual

                //modificado 7.2.2013
                if (typeUser != "F")
                {
                    #region Funcionario

                    //validar fecha limite
                    DataRow[] dataLimitDate = general.limitDate(userId.ToString());
                    if (dataLimitDate.Length > 0)
                    {
                        String dateinitial = dataLimitDate[0][2].ToString().Substring(0, 10) + " " + dataLimitDate[0][4].ToString();
                        String datelimit = dataLimitDate[0][3].ToString().Substring(0, 10) + " " + dataLimitDate[0][5].ToString();

                        if (Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) >=
                            Convert.ToDateTime(dateinitial) && Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) <=
                            Convert.ToDateTime(datelimit))
                        {
                            //DateTime.Compare(fi, fb)  
                        }
                        else
                        {
                            #region Navegaciòn
                            //barras de operaciones
                            bindingNavigatorAddNewItem.Enabled = false;
                            bindingNavigatorAddNewItem1.Enabled = false;
                            bindingNavigatorSaveItem.Enabled = false;
                            bindingNavigatorSaveItem.Enabled = false;
                            bindingNavigatorSaveItem1.Enabled = false;
                            bindingNavigatorDeleteItem.Enabled = false;
                            bindingNavigatorDeleteItem1.Enabled = false;
                            #endregion Navegaciòn
                            //solo lectura
                            fieldReadOnly = new string[] { articleId, description, warranty, installation, subLine, brand, funder, concept, supplier, vat, observation, costControl, available, active, approvation, reference, equivalence, checkSave, checkModify };
                            general.setColumnReadOnly(dgArticle, fieldReadOnly);
                            fieldReadOnly = new string[] { propertiesArtId, propertiesArtId_b1, propertiesId, propertiesValue, propertiesCheckSave, propertiesCheckModify };
                            general.setColumnReadOnly(dgProperties, fieldReadOnly);
                        }
                    }

                    #endregion Funcionario
                }

                operPendientes = false;

                #endregion grilla propiedades
            }
            catch (Exception ex) { GlobalExceptionProcessing.ShowErrorException(ex); }
        
        
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void bindingNavigatorAddNewItem_Click(object sender, EventArgs et)
        {
            if (dgArticle.Rows.Count > 0)
            {
                try
                {
                    dgArticle.ActiveRow.Cells[checkSave].Activated = true;
                }
                catch
                {
                    dgArticle.Rows[0].Cells[checkSave].Activated = true;
                }
                msjError = string.Empty;
                if (validate(dgArticle.Rows.Count - 1))
                {
                    #region Existe Articulo
                    try
                    {
                        //incio de operaciones
                        operPendientes = true;
                        //
                        customerbinding.Add(BLGEPBR.AddRowList());
                        start = false;
                        start = true;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[brand].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[funder].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[concept].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[installation].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[costControl].Value = "Y";
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[available].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[active].Value = string.Empty;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[approvation].Value = "Y";

                        if (typeUser == "C")
                        {
                            //consultar parametro
                            dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[funder].Value = funderparameter;
                            dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[approvation].Value = "P";
                            dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[supplier].Value = userId;
                            //dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[e].ValueList = general.valuelist2(BLConsultas.Sublineas + " and supplier_id = " + dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[i].Value.ToString() + " Order By a.Subline_id", "DESCRIPCION", "CODIGO");
                            //
                        }
                        else
                        {
                            dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[supplier].Value = " ";
                            dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[subLine].ValueList = general.valuelistNumberId("", "DESCRIPCION", "CODIGO");
                            //
                        }

                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[subLine].Value = " ";
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[checkSave].Value = 1;
                        dgArticle.Rows[dgArticle.Rows.Count - 1].Cells[articleId].Value = general.valueReturn(BLConsultas.secuenceArticle, "Int64");// BLGEPBR.consArticle();
                        bindingNavigatorMoveLastItem.PerformClick();
                    }
                    catch//(Exception ex)
                    {

                    }

                    #endregion Existe Articulo
                }
                else
                {
                    if (msjError != "")
                        general.mensajeERROR(msjError);
                }
            }
            else
            {
                //incio de operaciones
                operPendientes = true;
                //

                ArticleGEPBR _newArticle = BLGEPBR.AddRowList();
                _newArticle.Id           = Convert.ToInt64( general.valueReturn(BLConsultas.secuenceArticle, "Int64") );
                _newArticle.Brand        = string.Empty;
                _newArticle.Funder       = string.Empty;
                _newArticle.Concept      = string.Empty;
                _newArticle.Instalation  = string.Empty;
                _newArticle.Costcontrol  = "Y";
                _newArticle.Available    = string.Empty;
                _newArticle.Active       = string.Empty;
                _newArticle.Approbation  = "Y";
                _newArticle.Subline      = string.Empty;
                _newArticle.CheckSave    = 1;

                if (typeUser == "C")
                {
                    _newArticle.Funder = funderparameter;
                    _newArticle.Approbation = "P";
                    _newArticle.Supplier = Convert.ToString( userId );
                    //dgArticle.Rows[0].Cells[subLine].ValueList = ValueListSubLineas("CODIGO", "DESCRIPTION");

                    //consultar parametro
                    //dgArticle.Rows[0].Cells[funder].Value = funderparameter;
                    //dgArticle.Rows[0].Cells[approvation].Value = "P";
                    //dgArticle.Rows[0].Cells[supplier].Value = userId;
                    //dgArticle.Rows[0].Cells[subLine].ValueList = general.valuelistNumberId(BLConsultas.Sublineas + " and supplier_id = " + dgArticle.Rows[0].Cells[supplier].Value.ToString() + " Order By a.Subline_id", "DESCRIPCION", "CODIGO");
                    //
                }
                else
                    _newArticle.Supplier = string.Empty;
                //{

                    //dgArticle.Rows[0].Cells[supplier].Value = " ";
                    //dgArticle.Rows[0].Cells[subLine].ValueList = general.valuelist("", "DESCRIPCION", "CODIGO");
                    //
                //}

                customerbinding.Add(_newArticle);
                //start = false;
                //start = true;
                //dgArticle.Rows[0].Cells[brand].Value = " ";
                //dgArticle.Rows[0].Cells[funder].Value = " ";
                //dgArticle.Rows[0].Cells[concept].Value = " ";
                //dgArticle.Rows[0].Cells[installation].Value = " ";
                //dgArticle.Rows[0].Cells[costControl].Value = "Y";
                //dgArticle.Rows[0].Cells[available].Value = " ";
                //gArticle.Rows[0].Cells[active].Value = " ";
                //dgArticle.Rows[0].Cells[approvation].Value = "Y";
                //dgArticle.Rows[0].Cells[subLine].Value = " ";
                //dgArticle.Rows[0].Cells[checkSave].Value = 1;
                //dgArticle.Rows[0].Cells[articleId].Value = general.valueReturn(BLConsultas.secuenceArticle, "Int64");// BLGEPBR.consArticle();
                bindingNavigatorMoveLastItem.PerformClick();


            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="irow"></param>
        /// <returns></returns>
        Boolean validate(int irow)
        {
            if (dgArticle.Rows[irow].Cells[description] != null && dgArticle.Rows[irow].Cells[description].Text == "")
            {
                msjError = "Debe ingresar la Descripción para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }
            if (dgArticle.Rows[irow].Cells[supplier].Value != null && dgArticle.Rows[irow].Cells[supplier].Value.ToString() == " ")
            {
                msjError = "Debe ingresar el Proveedor para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }
            if (dgArticle.Rows[irow].Cells[subLine].Value != null && dgArticle.Rows[irow].Cells[subLine].Value.ToString() == " ")
            {
                msjError = "Debe ingresar la Sublinea para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }
            if (dgArticle.Rows[irow].Cells[funder].Value != null && dgArticle.Rows[irow].Cells[funder].Value.ToString() == " ")
            {
                msjError = "Debe ingresar el Financiador para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }
            if (dgArticle.Rows[irow].Cells[concept].Value != null && dgArticle.Rows[irow].Cells[concept].Value.ToString() == " ")
            {
                msjError = "Debe ingresar el Concepto para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }
            if (dgArticle.Rows[irow].Cells[reference].Value != null && dgArticle.Rows[irow].Cells[reference].Text == "")
            {
                msjError = "Debe ingresar la Referencia para el artículo con Identificación: " + dgArticle.Rows[irow].Cells[articleId].Text;
                return false;
            }

            if (dgArticle.Rows[irow].Cells[equivalence] != null)
            {
                String _value = dgArticle.Rows[irow].Cells[equivalence].Text;

                if (String.IsNullOrEmpty(_value))
                {
                    //vhurtadoSAO213549 ... : Se hace validación de si es gran superficie, pedir que se complete el campo
                    //Equivalencia, si no, se llena por defecto con el valor del id del artículo.
                    Int64 prov = Convert.ToInt64(dgArticle.Rows[irow].Cells[supplier].Value.ToString());
                    if (DALGEPBR.isGranSuperficie(prov))
                    {
                        msjError = "Faltan datos requeridos. No ha digitado la equivalencia para la gran superficie: "
                            + prov + "-" + dgArticle.Rows[irow].Cells[supplier].Text
                            + "\n(Artículo: " + dgArticle.Rows[irow].Cells[articleId].Text + ")";
                        return false;
                    }
                    else
                        dgArticle.Rows[irow].Cells[equivalence].Value = dgArticle.Rows[irow].Cells[articleId].Text;

                }
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="irow"></param>
        /// <returns></returns>
        Boolean validatep(int irow)
        {
            if (dgProperties.Rows[irow].Cells[propertiesId].Value.ToString() == " ")
            {
                msjError = "Debe ingresar una Propiedad para el artículo.";
                return false;
            }
            if (dgProperties.Rows[irow].Cells[propertiesValue].Text == "")
            {
                msjError = "Debe ingresar el Valor para la Propiedad: " + dgProperties.Rows[irow].Cells[propertiesId].Text;
                return false;
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void bindingNavigatorSaveItem_Click(object sender, EventArgs et)
        {
            if (dgArticle.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                //Boolean errorfecha = false;
                Boolean error = false;
                //variable para controlar registros
                String errorRow = "";
                int irow;
                try
                {
                    dgArticle.ActiveRow.Cells[checkSave].Activated = true;
                }
                catch
                {
                    dgArticle.Rows[0].Cells[checkSave].Activated = true;
                }
                for (irow = 0; irow <= dgArticle.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        #region Definiciones

                        Int64   id            = Convert.ToInt64(dgArticle.Rows[irow].Cells[articleId].Text);
                        String  _description  = dgArticle.Rows[irow].Cells[description].Text;
                        Int64   _warranty     = Convert.ToInt64(dgArticle.Rows[irow].Cells[warranty].Text);
                        String  subline       = Convert.ToString(dgArticle.Rows[irow].Cells[subLine].Value);
                        String  _funder       = Convert.ToString(dgArticle.Rows[irow].Cells[funder].Value);
                        String  _concept      = Convert.ToString(dgArticle.Rows[irow].Cells[concept].Value);
                        String  _supplier     = Convert.ToString(dgArticle.Rows[irow].Cells[supplier].Value);
                        String  _brand        = Convert.ToString(dgArticle.Rows[irow].Cells[brand].Value);
                        String  _reference    = dgArticle.Rows[irow].Cells[reference].Text;
                        String  approved      = dgArticle.Rows[irow].Cells[approvation].Value.ToString();
                        String  avalible      = dgArticle.Rows[irow].Cells[available].Value.ToString();
                        String  _active       = dgArticle.Rows[irow].Cells[active].Value.ToString();
                        String  pricecontrol  = dgArticle.Rows[irow].Cells[costControl].Value.ToString();
                        String  _observation  = dgArticle.Rows[irow].Cells[observation].Text;
                        Decimal _vat          = Convert.ToDecimal(dgArticle.Rows[irow].Cells[vat].Text);
                        String  _installation = dgArticle.Rows[irow].Cells[installation].Value.ToString();
                        String  _equivalence  = dgArticle.Rows[irow].Cells[equivalence].Text;
                        Int64   cs            = Convert.ToInt64(dgArticle.Rows[irow].Cells[checkSave].Text);

                        #endregion Definiciones

                        if (cs == 1)
                        {
                            try
                            {
                                BLGEPBR.saveArticle(id,
                                                    _description,
                                                    _warranty,
                                                    subline,
                                                    _funder,
                                                    _concept,
                                                    _supplier,
                                                    _brand,
                                                    _reference,
                                                    approved,
                                                    avalible,
                                                    _active,
                                                    pricecontrol,
                                                    _observation,
                                                    _vat,
                                                    _installation,
                                                    _equivalence);

                                dgArticle.Rows[irow].Cells[checkSave].Value = 0;
                                dgArticle.Rows[irow].Cells[checkModify].Value = 0;
                                //EVESAN 01/Julio/2013
                                if (dgArticle.Rows[irow].Cells[approvation].Text == "Si")
                                {
                                    dgArticle.Rows[irow].Activation = Activation.NoEdit;
                                    bnProperties.Enabled = false;

                                    //aesguerra
                                    if (typeUser == "F")
                                    {
                                        dgArticle.Rows[irow].Cells[available].IgnoreRowColActivation = true;
                                    }
                                }
                                else
                                    bnProperties.Enabled = true;

                            }
                            catch (Exception ex)
                            {
                                if (ex.Message.Contains("UX_LD_ARTICLE_05") || ex.Message.Contains("UX_LD_ARTICLE_06"))
                                {
                                    //Se deja campos de check save, así no intenta actualizar
                                    //cuando aún no se ha insertado.
                                    dgArticle.Rows[irow].Cells[checkSave].Value = 1;
                                    dgArticle.Rows[irow].Cells[checkModify].Value = 0;
                                    general.mensajeERROR("Error al guardar. Los campos equivalencia y referencia deben ser únicos por Proveedor."
                                        + "\nArtículo: " + id);
                                }
                                else
                                    throw ex;

                            }
                            ///////////////////////////////////
                        }
                        Int64 cm = Convert.ToInt64(dgArticle.Rows[irow].Cells[checkModify].Text);
                        if (cm == 1)
                        {
                            try
                            {
                                BLGEPBR.modifyArticle(id, _description, _warranty, subline, _funder, _concept, _supplier, _brand, _reference, approved, avalible, _active, pricecontrol, _observation, _vat, _installation, _equivalence);
                                dgArticle.Rows[irow].Cells[checkSave].Value = 0;
                                dgArticle.Rows[irow].Cells[checkModify].Value = 0;
                                //EVESAN 01/Julio/2013
                                if (dgArticle.Rows[irow].Cells[approvation].Text == "Si")
                                {
                                    dgArticle.Rows[irow].Activation = Activation.NoEdit;
                                    bnProperties.Enabled = false;

                                    //aesguerra
                                    if (typeUser == "F")
                                    {
                                        dgArticle.Rows[irow].Cells[available].IgnoreRowColActivation = true;
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                if (ex.Message.Contains("UX_LD_ARTICLE_05") || ex.Message.Contains("UX_LD_ARTICLE_06"))
                                    general.mensajeERROR("Error al actualizar. Los campos equivalencia y referencia deben ser únicos por Proveedor.\nArtículo: " + id);
                                else
                                    throw ex;
                            }
                        }
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        errorRow += dgArticle.Rows[irow].Cells[articleId].Text + ", ";
                        error = true;
                    }
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error)
                {
                    general.mensajeERROR("Error en la información ingresada. No se almacenaron cambios sobre los artículos con identificación: " + errorRow + ".");
                }
                else
                {
                    operPendientes = false;
                    general.doCommit();//BLGEPBR.Save();
                }
            }
        }
        /// <summary>
        /// Evento que se dispara cuando cambia un valor en una celda de la grilla
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_CellChange(object sender, CellEventArgs et)
        {
            if (start)
            {
                dgArticle.Rows[et.Cell.Row.Index].Cells[checkModify].Value = 1;
                //incio de operaciones
                operPendientes = true;
                //
                if (et.Cell.Column.Key == description || et.Cell.Column.Key == observation || et.Cell.Column.Key == reference || et.Cell.Column.Key == equivalence)
                {
                    if (dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Text == "")
                        dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Value = "";
                }
                if (et.Cell.Column.Key == warranty)
                {
                    if (dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Text == "")
                        dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Value = 0;
                }
                if (et.Cell.Column.Key == vat)
                {
                    if (dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Text == "")
                        dgArticle.Rows[et.Cell.Row.Index].Cells[et.Cell.Column.Index].Value = 0;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ningún artículo Registrado.");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgArticle.ActiveRow.Cells[checkSave].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ningún artículo Seleccionado");

                }
                if (cs == 0 && del)
                {
                    //Question pregunta = new Question("LDAPB - Eliminar artículo", "¿Desea Eliminar el artículo " + dgArticle.ActiveRow.Cells[a].Value.ToString() + " - " + dgArticle.ActiveRow.Cells[b].Value.ToString() + "?", "Si", "No");
                    //pregunta.ShowDialog();
                    //Int64 answer = pregunta.answer;
                    //if (answer == 2)
                    if (MessageBox.Show("¿Desea Eliminar el artículo " + dgArticle.ActiveRow.Cells[articleId].Value.ToString() + " - " + dgArticle.ActiveRow.Cells[description].Value.ToString(),
                                       "Eliminación",
                                       MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Warning) == DialogResult.Yes)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inuarticle_id" };
                            Object[] p3 = new object[] { dgArticle.ActiveRow.Cells[articleId].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deleteArticle, 1, p1, p2, p3);
                            dgArticle.ActiveRow.Delete(false);
                            //incio de operaciones
                            general.doCommit();
                        }
                        catch
                        {
                            general.mensajeERROR("No se puede eliminar este artículo, posiblemente se halle asociado a otros Registros");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgArticle.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void bindingNavigatorAddNewItem1_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ningún artículo registrado.");
            else
            {
                try
                {
                    if (dgArticle.Rows[dgArticle.ActiveRow.Index].Cells[checkSave].Text == "1")
                        general.mensajeERROR("El artículo seleccionado no ha sido registrado aún.");
                    else
                    {
                        if (dgProperties.Rows.Count > 0)
                        {
                            try
                            {
                                dgProperties.ActiveRow.Cells[propertiesCheckSave].Activated = true;
                            }
                            catch
                            {
                                dgProperties.Rows[0].Cells[propertiesCheckSave].Activated = true;
                            }
                            msjError = "";
                            if (validatep(dgProperties.Rows.Count - 1))
                            {
                                //incio de operaciones
                                operPendientes = true;
                                //
                                customerbindingp.Add(BLGEPBR.AddRowListp());
                                dgProperties.Rows[dgProperties.Rows.Count - 1].Cells[propertiesArtId_b1].Value = dgArticle.Rows[dgArticle.ActiveRow.Index].Cells[articleId].Value;
                                dgProperties.Rows[dgProperties.Rows.Count - 1].Cells[propertiesId].Value = " ";
                                dgProperties.Rows[dgProperties.Rows.Count - 1].Cells[propertiesArtId].Value = general.valueReturn(BLConsultas.secuencePropertyArticle, "Int64"); //BLGEPBR.consProperties();
                                dgProperties.Rows[dgProperties.Rows.Count - 1].Cells[propertiesCheckSave].Value = 1;
                                dgProperties.Rows[dgProperties.Rows.Count - 1].Cells[propertiesCheckModify].Value = 0;
                                bindingNavigatorLastPosition1.Visible = true;
                                bindingNavigatorLastPosition1.PerformClick();
                                bindingNavigatorLastPosition1.Visible = false;
                            }
                            else
                            {
                                if (msjError != "")
                                    general.mensajeERROR(msjError);
                            }
                        }
                        else
                        {
                            //incio de operaciones
                            operPendientes = true;
                            //
                            customerbindingp.Add(BLGEPBR.AddRowListp());
                            dgProperties.Rows[0].Cells[propertiesArtId_b1].Value = dgArticle.Rows[dgArticle.ActiveRow.Index].Cells[articleId].Value;
                            dgProperties.Rows[0].Cells[propertiesId].Value = " ";
                            dgProperties.Rows[0].Cells[propertiesArtId].Value = general.valueReturn(BLConsultas.secuencePropertyArticle, "Int64"); //BLGEPBR.consProperties();
                            dgProperties.Rows[0].Cells[propertiesCheckSave].Value = 1;
                            dgProperties.Rows[0].Cells[propertiesCheckModify].Value = 0;
                            bindingNavigatorLastPosition1.Visible = true;
                            bindingNavigatorLastPosition1.PerformClick();
                            bindingNavigatorLastPosition1.Visible = false;
                        }
                    }
                }
                catch
                {
                    general.mensajeERROR("Debe seleccionar un artículo.");
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void bindingNavigatorDeleteItem1_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPosition1.Text == "0")
                general.mensajeERROR("No hay ninguna Propiedad registrada.");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgProperties.ActiveRow.Cells[propertiesCheckSave].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ninguna Propiedad Seleccionada");

                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("LDAPB - Eliminar Propiedad", "¿Desea Eliminar la Propiedad " + dgProperties.ActiveRow.Cells[propertiesArtId].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inupropert_by_article_id" };
                            Object[] p3 = new object[] { dgProperties.ActiveRow.Cells[propertiesArtId].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deletePropertyArticle, 1, p1, p2, p3);
                            dgProperties.ActiveRow.Delete(false);
                            //incio de operaciones
                            general.doCommit();
                        }
                        catch
                        {
                            general.mensajeERROR("No puede eliminar esta Propiedad, puede estar asociada a un Registro");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgProperties.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void bindingNavigatorSaveItem1_Click(object sender, EventArgs e)
        {
            if (dgProperties.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                //Boolean errorfecha = false;
                Boolean error = false;
                //variable para controlar registros
                String errorRow = "";
                //
                try
                {
                    dgProperties.ActiveRow.Cells[propertiesCheckSave].Activated = true;
                }
                catch
                {
                    dgProperties.Rows[0].Cells[propertiesCheckSave].Activated = true;
                }
                int irow;
                for (irow = 0; irow <= dgProperties.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validatep(irow))
                    {
                        Int64 inupropert_by_article_id = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesArtId].Value);
                        Int64 inuarticleid = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesArtId_b1].Value);
                        String inuproperty_id = Convert.ToString(dgProperties.Rows[irow].Cells[propertiesId].Value);
                        String inuvalue = dgProperties.Rows[irow].Cells[propertiesValue].Text;
                        Int64 cs = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesCheckSave].Value);
                        if (cs == 1)
                        {
                            BLGEPBR.savePropertbyArticle(inupropert_by_article_id, inuarticleid, inuproperty_id, inuvalue);
                            dgProperties.Rows[irow].Cells[propertiesCheckSave].Value = 0;
                            dgProperties.Rows[irow].Cells[propertiesCheckModify].Value = 0;

                        }
                        Int64 cm = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesCheckModify].Value);
                        if (cm == 1)
                        {
                            if (typeUser == "F")
                            {
                                BLGEPBR.modifyPropertbyArticle(inupropert_by_article_id, inuarticleid, inuproperty_id, inuvalue);
                                dgProperties.Rows[irow].Cells[propertiesCheckSave].Value = 0;
                                dgProperties.Rows[irow].Cells[propertiesCheckModify].Value = 0;
                            }
                            else
                            {
                                BLGEPBR.modifyPropertbyArticle(inupropert_by_article_id, inuarticleid, inuproperty_id, inuvalue);
                                dgProperties.Rows[irow].Cells[propertiesCheckSave].Value = 0;
                                dgProperties.Rows[irow].Cells[propertiesCheckModify].Value = 0;
                            }
                        }
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        errorRow += dgProperties.Rows[irow].Cells[propertiesId].Text + ", ";
                        error = true;
                    }
                }
                general.doCommit();//BLGEPBR.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error)
                    general.mensajeERROR("Error en la información ingresada. No se almacenaron modificaciones sobre las propiedades: " + errorRow + ".");
                else
                {
                    //incio de operaciones
                    operPendientes = false;
                    //
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgProperties_CellChange(object sender, CellEventArgs et)
        {
            dgProperties.Rows[et.Cell.Row.Index].Cells[propertiesCheckModify].Value = 1;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void importar_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgArticle);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void exportar_Click(object sender, EventArgs et)
        {
            general.exportarExcel(dgArticle);//, listaColumnas);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgProperties);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            //String[] listaColumnas = new string[] { a };
            general.exportarExcel(dgProperties);//, listaColumnas);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void bindingNavigatorPrintItem_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgArticle);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgProperties);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgArticle_AfterRowActivate(object sender, EventArgs e)
        {
            if (dgArticle.Rows.Count > 0)
            {
                try
                {
                    sRow = bindingNavigatorPositionItem.Text;
                    //propiedades 
                    List<PropArtGEPBR> ListProperty = new List<PropArtGEPBR>();
                    ListProperty = BLGEPBR.FcuProperties(Convert.ToInt64(dgArticle.ActiveRow.Cells[articleId].Value));
                    customerbindingp.DataSource = ListProperty;

                }
                catch { }
            }
            //EVESAN
            if (dgArticle.ActiveRow.Cells[approvation].Text == "Si")
            {
                bnProperties.Enabled = false;

                //Aecheverry  23-Jul-2013                
                if (dgProperties != null)
                    dgProperties.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.False;
            }
            else
            {
                bnProperties.Enabled = true;

                //Aecheverry  23-Jul-2013                
                if (dgProperties != null)
                    dgProperties.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.True;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgArticle_AfterRowUpdate(object sender, Infragistics.Win.UltraWinGrid.RowEventArgs e)
        {
            //EVESAN
            if (e.Row.Cells[approvation].Text == "Si")
            {
                bnProperties.Enabled = false;

                //Aecheverry  23-Jul-2013                
                if (dgProperties != null)
                    dgProperties.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.False;
            }
            else
            {
                bnProperties.Enabled = true;

                if (dgProperties != null)
                    dgProperties.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.True;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_AfterCellActivate(object sender, EventArgs et)
        {
            int fila;
            if (dgArticle.ActiveCell.Row != null)
                fila = dgArticle.ActiveCell.Row.Index;

            if (dgArticle.ActiveCell.Column.Key == brand ||
                dgArticle.ActiveCell.Column.Key == funder ||
                dgArticle.ActiveCell.Column.Key == concept ||
                dgArticle.ActiveCell.Column.Key == supplier ||
                dgArticle.ActiveCell.Column.Key == subLine ||
                dgArticle.ActiveCell.Column.Key == costControl ||
                dgArticle.ActiveCell.Column.Key == available ||
                dgArticle.ActiveCell.Column.Key == active ||
                dgArticle.ActiveCell.Column.Key == approvation ||
                dgArticle.ActiveCell.Column.Key == installation)
                dgArticle.ActiveCell.DroppedDown = true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgProperties_AfterCellActivate(object sender, EventArgs et)
        {
            if (dgProperties.ActiveCell.Column.Key == propertiesId)
                dgProperties.ActiveCell.DroppedDown = true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_CellListSelect(object sender, CellEventArgs et)
        {
            int fila = et.Cell.Row.Index;
            if (et.Cell.Column.Key == supplier)
                dgArticle.Rows[fila].Cells[subLine].Value = " ";
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_Error(object sender, ErrorEventArgs et)
        {
            //String tMensaje = "";
            if (et.ErrorType == ErrorType.Data)
                et.Cancel = true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgProperties_Error(object sender, ErrorEventArgs et)
        {
            //String tMensaje = "";
            if (et.ErrorType == ErrorType.Data)
                et.Cancel = true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            Boolean pendiente;
            if (dgArticle.Rows.Count > 0)
            {
                pendiente = false;

                foreach (UltraGridRow fila in dgArticle.Rows)
                {
                    //Activa checkBox
                    if (fila.Cells[checkSave].Text == "1")
                        pendiente = true;
                }

                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras existan registros pendientes por Guardar.");
                    et.Cancel = true;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgArticle_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            if (dgArticle.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgArticle.Rows)
                {
                    if (fila.Cells[checkSave].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras existan registros pendientes por Guardar.");
                    et.Cancel = true;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgProperties_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            if (dgProperties.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgProperties.Rows)
                {
                    if (fila.Cells[propertiesCheckSave].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras existan registros pendientes por Guardar.");
                    et.Cancel = true;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="et"></param>
        private void dgProperties_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            if (dgProperties.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgProperties.Rows)
                {
                    if (fila.Cells[propertiesCheckSave].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras existan registros pendientes por Guardar.");
                    et.Cancel = true;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public Boolean validandoC()
        {
            //grilla uno
            Boolean saveR = false;
            int irow;
            if (dgArticle.Rows.Count > 0)
            {
                try
                {
                    dgArticle.ActiveRow.Cells[checkSave].Activated = true;
                }
                catch
                {
                    dgArticle.Rows[0].Cells[checkSave].Activated = true;
                }
                for (irow = 0; irow <= dgArticle.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        Int64 cs = Convert.ToInt64(dgArticle.Rows[irow].Cells[checkSave].Text);
                        if (cs == 1)
                            saveR = true;
                        Int64 cm = Convert.ToInt64(dgArticle.Rows[irow].Cells[checkModify].Text);
                        if (cm == 1)
                            saveR = true;
                    }
                    else
                    {
                        if (msjError != "")
                        {
                            general.mensajeERROR(msjError);
                            return false;
                        }
                    }
                }
            }
            //grilla dos
            if (dgProperties.Rows.Count > 0)
            {
                try
                {
                    dgProperties.ActiveRow.Cells[propertiesCheckSave].Activated = true;
                }
                catch
                {
                    dgProperties.Rows[0].Cells[propertiesCheckSave].Activated = true;
                }
                for (irow = 0; irow <= dgProperties.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validatep(irow))
                    {
                        Int64 cs = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesCheckSave].Value);
                        if (cs == 1)
                            saveR = true;
                        Int64 cm = Convert.ToInt64(dgProperties.Rows[irow].Cells[propertiesCheckModify].Value);
                        if (cm == 1)
                            saveR = true;
                    }
                    else
                    {
                        if (msjError != "")
                        {
                            general.mensajeERROR(msjError);
                            return false;
                        }
                    }
                }
            }
            //
            if (saveR)
            {
                Question pregunta = new Question("LDAPB - Pregunta", "¿Desea Guardar los cambios en Definición de artículos?", "Si", "No");
                pregunta.ShowDialog();
                Int64 answer = pregunta.answer;
                if (answer == 2)
                {
                    try
                    {
                        bindingNavigatorSaveItem.PerformClick();
                        bindingNavigatorSaveItem1.PerformClick();
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
            return true;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgArticle_AfterCellUpdate(object sender, CellEventArgs e)
        {
            /*
            if (dgArticle.ActiveCell != null)
            {

                if (dgArticle.ActiveRow.Cells[this.supplier].Value.ToString() != "" && dgArticle.ActiveRow.Cells[this.supplier].Value.ToString() != " ")
                {
                    //start = false;
                    //dgArticle.ActiveRow.Cells[this.e].ValueList = null;
                    //dgArticle.ActiveRow.Cells[this.e].ValueList = general.valuelist2(BLConsultas.Sublineas + " and supplier_id = " + dgArticle.ActiveRow.Cells[i].Value.ToString() + " Order By a.Subline_id", "DESCRIPCION", "CODIGO");
                    //start = true;
                }
                else
                {
                    start = false;
                    dgArticle.ActiveRow.Cells[this.subLine].ValueList = null;
                    dgArticle.ActiveRow.Cells[this.subLine].ValueList = general.valuelist2("", "DESCRIPCION", "CODIGO");
                    start = true;

                }
             
            }*/
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgProperties_BeforePerformAction(object sender, BeforeUltraGridPerformActionEventArgs e)
        {
            dgProperties.EventManager.SetEnabled(GridEventIds.BeforePerformAction, false);

            try
            {
                //Verifica que exista una grilla, que haya una celda activa y a su vez que haya habido un cambio en ella
                if (this.dgProperties == null || this.dgProperties.ActiveCell == null || !this.dgProperties.ActiveCell.DataChanged)
                    return;

                //Verifica si la celda es una lista de valores y ademas si se se presiona la tecla de ir a la proxima celda o la de ir a la anterior celda
                if (this.dgProperties.ActiveCell.Column.Style == Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate &&
                    this.dgProperties.ActiveCell.EditorResolved.IsInEditMode && //Verifica que esta en modo de edicion para poder realizar alguna validar
                    (e.UltraGridAction == UltraGridAction.NextCellByTab || e.UltraGridAction == UltraGridAction.PrevCellByTab))
                    this.dgProperties.ActiveCell.EditorResolved.DropDown();//Se selecciona el item en la lista de valores
            }
            catch
            {
                //Este error sucede porque pierde alguna propiedad interna el editor para evitar que se genere una cola de errores se prefiere devolver al
                //valor original que tenia la celda
                if (!this.dgProperties.ActiveCell.EditorResolved.IsValid)//Si el valor no es valido
                    this.dgProperties.ActiveCell.CancelUpdate();//devuelve al valor original que tenia la celda
            }
            finally
            {
                dgProperties.EventManager.SetEnabled(GridEventIds.BeforePerformAction, true);
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgArticle_BeforePerformAction(object sender, BeforeUltraGridPerformActionEventArgs e)
        {
            dgArticle.EventManager.SetEnabled(GridEventIds.BeforePerformAction, false);

            try
            {
                //Verifica que exista una grilla, que haya una celda activa y a su vez que haya habido un cambio en ella
                if (this.dgArticle == null || this.dgArticle.ActiveCell == null || !this.dgArticle.ActiveCell.DataChanged)
                    return;
                //Verifica si la celda es una lista de valores y ademas si se se presiona la tecla de ir a la proxima celda o la de ir a la anterior celda
                if (this.dgArticle.ActiveCell.Column.Style == Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate &&
                    this.dgArticle.ActiveCell.EditorResolved.IsInEditMode && //Verifica que esta en modo de edicion para poder realizar alguna validar
                    (e.UltraGridAction == UltraGridAction.NextCellByTab || e.UltraGridAction == UltraGridAction.PrevCellByTab))
                    this.dgArticle.ActiveCell.EditorResolved.DropDown();//Se selecciona el item en la lista de valores

            }
            catch
            {
                //Este error sucede porque pierde alguna propiedad interna el editor para evitar que se genere una cola de errores se prefiere devolver al
                //valor original que tenia la celda
                if (!this.dgArticle.ActiveCell.EditorResolved.IsValid)//Si el valor no es valido
                    this.dgArticle.ActiveCell.CancelUpdate();//devuelve al valor original que tenia la celda

            }
            finally
            {
                dgArticle.EventManager.SetEnabled(GridEventIds.BeforePerformAction, true);
            }

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="supplierId"></param>
        /// <returns></returns>
        private UltraDropDown populateSublineBySupplierID(string supplierId)
        {
            UltraDropDown _list = new UltraDropDown();

            List<ContainerSubLine>  filterSubLines = new List<ContainerSubLine>();
            List<ContainerSubLine> _AllSubLines    = new List<ContainerSubLine>();
            _AllSubLines = ContainerCollections.GetInstance().CollectionSubLines;

            if (!string.IsNullOrEmpty(supplierId))
            {
                foreach (ContainerSubLine _sub in _AllSubLines)
                {
                    if (_sub.Supplier_id == supplierId)
                    {
                        ContainerSubLine _s = new ContainerSubLine();
                        _s.Codigo = _sub.Codigo;
                        _s.Description = _sub.Description;
                        _s.Supplier_id = _sub.Supplier_id;

                        filterSubLines.Add(_s);
                    }
                }
            }

            _list.DataSource = filterSubLines;
            _list.ValueMember   = "CODIGO";
            _list.DisplayMember = "DESCRIPTION";

            return _list;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private UltraDropDown SetCollectionSubLines()
        {
            UltraDropDown dp  = new UltraDropDown();
            List<ContainerSubLine> _subLines = new List<ContainerSubLine>();
            StringBuilder sb = new StringBuilder();
            sb.Append(BLConsultas.Sublineas);

            DataSet ds = new DataSet();
            ds = DAL.DALGEC.GetSentence(sb.ToString());

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ContainerSubLine cs = new ContainerSubLine();
                cs.Codigo      = Convert.ToString(dr[0].ToString());
                cs.Description = Convert.ToString(dr[1].ToString());
                cs.Supplier_id  = Convert.ToString(dr[2].ToString());
                _subLines.Add(cs);
            }

            ContainerCollections.GetInstance().CollectionSubLines = _subLines;
            dp.DataSource = _subLines;

            return dp;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgArticle_BeforeCellActivate(object sender, CancelableCellEventArgs e)
        {
            string SublineID = this.subLine;
            string SupplierID = supplier;

            if (e.Cell.Column.Key == SublineID)
                this.dgArticle.ActiveRow.Cells[SublineID].ValueList = populateSublineBySupplierID(this.dgArticle.ActiveRow.Cells[supplier].Value.ToString());
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ValueMember"></param>
        /// <param name="DisplayMember"></param>
        /// <returns></returns>
        private UltraDropDown ValueListSubLineas(string ValueMember, string DisplayMember)
        {
            List<ContainerSubLine> _Sublines = new List<ContainerSubLine>();
            UltraDropDown _udd = new UltraDropDown();
            _udd.DisplayMember = DisplayMember;
            _udd.ValueMember = ValueMember;
            _udd.DataSource = ContainerCollections.GetInstance().CollectionSubLines;

            return _udd;
        }

    }

}
