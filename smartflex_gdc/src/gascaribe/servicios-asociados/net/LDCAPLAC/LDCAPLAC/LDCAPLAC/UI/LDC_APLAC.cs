using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using LDCAPLAC.Entities;
using LDCAPLAC.BL;
using LDCAPLAC.DAL;
using OpenSystems.Common.Util;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Collections;

namespace LDCAPLAC.UI
{
    public partial class LDC_APLAC : OpenForm
    {

        BLUtilities utilities = new BLUtilities();
        BLLDC_APLAC blLDC_FCVC = new BLLDC_APLAC();
        DALLDC_APLAC dalLDC_APLAC = new DALLDC_APLAC();
       
        public static Boolean ChangeCheck = false;
        public static String User;
        public static Int64 ContMesgUserConect = 0;
        public List<Int64> ListNewlistas = new List<Int64>();

        private List<LovItem> QuotationStatusList = new List<LovItem>();
        private List<GridDetaMedi> itemToDeleteList = new List<GridDetaMedi>();

        List<Keys> notValidKeys;

        private ComboCostList selectedItem;

        private ComboCostCoti selectItemCoti;

        private bool swChkGridMed = false;

        private bool SWChangeCausal = false;

        private OpenGridDropDown itemsDropDown = null;

        // ---------------------------- NUEVAS DECLARACIONES DE ITEMS --------------------------//

        private QuotationBasicData quotationBasicData;

        private List<ComboCostList> itemsCostList;

        private List<ComboCostCoti> itemsCostCoti;

        private ArrayList ArrayItemsLega = new ArrayList();

        private ArrayList ArrayItemsCoti = new ArrayList();

        // -------------------------------------------------------------------------------------//

        public LDC_APLAC()
        {
            InitializeComponent();

            InitializeData();

            disableAceptarButton();

            disableButtonAprobarRechazasGDC();

            User = ObtenerUsuarioConectado();

        }


        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 24-04-2019  MiguelBallesteros      1 - creación   
        /// </changelog>
        public void InitializeData()
        {
            quotationBasicData = new QuotationBasicData(); 

            bsChargeByDetaMedi.DataSource = quotationBasicData.ItemsList;

            // se deshabilitan los tabs
            DisableTabs();
             
            // se deshabilitan los campos
            DisableCampos();

            // procedimiento llenado combo causal
            setValueCbCausal();

            // procedimiento llenado combo responsable
           // setValueCbResponsable();

        }

        private void itemsList_RowSelected(object sender, RowSelectedEventArgs e)
        {
            
            if (sender!=null)
            {
                UltraDropDown dropDown = (UltraDropDown)sender;

                if (dropDown.SelectedRow!=null)
                {
                    ComboCostList tmpSelectedItem = dropDown.SelectedRow.ListObject as ComboCostList;
                    selectedItem = itemsCostList.Find(delegate(ComboCostList il) { return il.Codigo == tmpSelectedItem.Codigo; });
                }
            }
        }


        private void itemsList_RowSelectedCoti(object sender, RowSelectedEventArgs e)
        {

            if (sender != null)
            {
                UltraDropDown dropDown = (UltraDropDown)sender;

                if (dropDown.SelectedRow != null)
                {
                    ComboCostCoti tmpSelectedItem = dropDown.SelectedRow.ListObject as ComboCostCoti;
                    selectItemCoti = itemsCostCoti.Find(delegate(ComboCostCoti il) { return il.Codigo == tmpSelectedItem.Codigo; });
                }
            }
        }


        /// <summary>
        /// Se define la lista de valores para la columna de la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void setValueListToGridColumn(UltraGrid ultraGrid, String key, Infragistics.Win.IValueList list)
        {
            ultraGrid.DisplayLayout.Bands[0].Columns[key].ValueList = list;
            ultraGrid.DisplayLayout.Bands[0].Columns[key].AutoEdit = false;
        }

        /// <summary>
        /// Se retira la lista de valores para la columna de la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación       
        private void delValueListToGridColumn()
        {
            while (ugInternalDetaMedi.Rows.Count > 0)
            {
                ugInternalDetaMedi.Rows[0].Activate();
                deleteItemFromSource(bsChargeByDetaMedi, ugInternalDetaMedi);
            }
       
        }

        /// <summary>
        /// Se establecen propiedades para lista desplegable items utilizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void setUpDropDown(OpenGridDropDown dropDown)
        {
            dropDown.DropDownWidth = 305;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostList.LIST_DESCRIPTION_2].Width = 240;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostList.LIST_ID_KEY].Hidden = false;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostList.LIST_DESCRIPTION_KEY].Hidden = true;
        }

        /// <summary>
        /// Se establecen propiedades para lista desplegable items cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void setUpDropDownCoti(OpenGridDropDown dropDown)
        {
            dropDown.DropDownWidth = 305;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostCoti.LIST_DESCRIPTION_2].Width = 240;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostCoti.LIST_ID_KEY].Hidden = false;
            dropDown.DisplayLayout.Bands[0].Columns[ComboCostCoti.LIST_DESCRIPTION_KEY].Hidden = true;
        }


        /// <summary>
        /// Se establece la lista de valores para el combobox del causal
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 06-02-2020  Miguel Ballesteros     1. Creación 
        private void setValueCbCausal()
        {

            String query = "select g.CAUSAL_ID CODIGO, " +
                            " g.DESCRIPTION DESCRIPCION " +
                            " from ge_causal g, or_task_type_causal tp where tp.causal_id = g.causal_id "+
                            " and tp.task_type_id in (dald_parameter.fnugetnumeric_value('LDCTTLEGA')) " +
                            " order by CODIGO asc";


            DataTable dtListCausal = utilities.getListOfValue(query); 
            cbCausal.DataSource = dtListCausal;
            cbCausal.ValueMember = "CODIGO";
            cbCausal.DisplayMember = "DESCRIPCION"; 
        }


        /// <summary>
        /// Se establece la lista de valores para el combobox responsable
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 06-02-2020  Miguel Ballesteros     1. Creación 
        private void setValueCbResponsable(Int64 inuOrder)
        {

            String query = "select ooup.person_id CODIGO, " +
                           " dage_person.fsbgetname_(ooup.person_id, null) DESCRIPCION " +
                           " from or_oper_unit_persons ooup, or_order o where o.order_id =" + inuOrder +
                           " and   o.operating_unit_id = ooup.operating_unit_id " +
                           " ORDER BY ooup.person_id";

            DataTable dtListResponsable = utilities.getListOfValue(query);
            cbResponsable.DataSource = dtListResponsable;
            cbResponsable.ValueMember = "CODIGO";
            cbResponsable.DisplayMember = "DESCRIPCION";
        }
        


        /// <summary>
        /// Se habilita el botón Aceptar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void enableAceptarButton()
        {
            btnAceptar.Enabled = true;
        }



        /// <summary>
        /// Se inhabilita el botón Aceptar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                   
        /// </changelog>
        private void disableAceptarButton()
        {
            btnAceptar.Enabled = false;
        }

        private void disableButtonAprobarRechazasGDC()
        {
            btnAprobar.Enabled = false;
            btnRechazar.Enabled = false;
        }

        private void EnableButtonAprobarRechazasGDC()
        {
            btnAprobar.Enabled = true;
            btnRechazar.Enabled = true;
        }



        /// <summary>
        /// Se habilitan todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void enableCampos()
        {
            cbResponsable.Enabled = true;
            cbCausal.Enabled = true;
            tbComment.Enabled = true;
            cbDateValidInic.Enabled = true;
            cbDateValidFin.Enabled = true;
        }



        /// <summary>
        /// Se Deshabilita todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void DisableCampos()
        {
            cbResponsable.Enabled = false;
            cbCausal.Enabled = false;
            tbComment.Enabled = false;
            cbDateValidInic.Enabled = false;
            cbDateValidFin.Enabled = false;
        }
        


        /// <summary>
        /// Se Deshabilita todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void EnableTabs()
        {
            ugDataWarranty.Tabs[0].Enabled = true;
            //TabItems.Tabs[0].Enabled = true;
            //TabItems.Tabs[1].Enabled = true;
            //OSF-50
            openFlagAppWarr.Enabled = true;
        }
        


        /// <summary>
        /// Se Deshabilita todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void DisableTabs()
        {
            ugDataWarranty.Tabs[0].Enabled = false;
            //TabItems.Tabs[0].Enabled = false;
            //TabItems.Tabs[1].Enabled = false;
            //OSF-50
            openFlagAppWarr.Enabled = false;
        }



        /// <summary>
        /// Se Deshabilita todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void CleanLabels()
        {
            ulbProducto.Text = "";
            ulbTaskType.Text = "";
            ulbActivity.Text = "";
            ulbDescription.Text = "";
            ulbStatus.Text = "";
            ulbContrato.Text = "";
        }



        /// <summary>
        /// Se Deshabilita todos los campos de la forma
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private void CleanTextBox()
        {
            SWChangeCausal = true;
            ulbmultifam.Text = "";
            cbResponsable.Value = "";
            tbComment.TextBoxValue = "";
            cbDateValidInic.TextBoxValue = "";
            cbDateValidFin.TextBoxValue = "";
            cbCausal.Value = "";
            tbOrder.TextBoxValue = "";
            tbCommentFuncionario.TextBoxValue = "";
            ulCantidadCont.Text = "";
            ulContSel.Text = "";
        }

        /// <summary>
        /// Se envia notificacion por email
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-08-2021  Horbath                 1. Creación                   
        /// </changelog>
        private void sendMailNotification(Int64 orderId, Int64 flagMess, String useParam)
        {
            blLDC_FCVC.sendNotificationEmail(orderId, flagMess, useParam);
        }

        /// <summary>
        /// Se actualizan los datos de la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                   
        /// </changelog>
        private void refreshGrid(BindingSource source, UltraGrid ultraGrid)
        {
            source.ResetBindings(false);
            ultraGrid.Rows.Refresh(RefreshRow.ReloadData);
        }

        #endregion



        #region Validation
        /// <summary>
        /// Se valida que se hayan ingresado los datos obligatorios de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private Boolean fieldsAreValid(UltraGrid ultragrid)
        {
            int nuTam = ultragrid.Rows.Count, i = 0;
            bool sw = false;

            if (ultragrid.Rows.Count > 0)
            {
                // se recorren todos los registros de la grilla de items
                while (i <= nuTam - 1 && !sw)
                {
                    // se validan que en todos los registros no exista un campo vacio o nulo  
                    try
                    {
                        if (String.IsNullOrEmpty(ultragrid.Rows[i].Cells[0].Value.ToString().Trim()))
                        {
                            sw = true;
                        }
                    }
                    catch(Exception ex) 
                    {
                        sw = true;
                    }

                    i++;
                }
            }

            return sw;
        }




        /// <summary>
        /// Valida si el ítem seleccionado ya existe en la grilla
        /// <param name="newItem">El nuevo item de la grilla</param>
        /// <returns>Devuelve valor booleano indicando si existe o no</returns>
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private Boolean itemAlreadyExists(Object newItem, ArrayList ArrayItems)
        {

            ComboCostList tmpNewItem = (ComboCostList)newItem;
 
            if (ArrayItems.Count > 0)
            {
                foreach (String item in ArrayItems)
                {
                    String[] ItemSplit = item.Split('|'); //ItemSplit[0] es el codigo del item, ItemSplit[1] es la descripcion
                    
                    if (tmpNewItem.Codigolist == ItemSplit[0] && tmpNewItem.Description == ItemSplit[1])
                    {
                        return true;
                    }
                }
                
            }

            return false;
        }



        /// <summary>
        /// Valida si el ítem seleccionado ya existe en la grilla
        /// <param name="newItem">El nuevo item de la grilla</param>
        /// <returns>Devuelve valor booleano indicando si existe o no</returns>
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 04-08-2020  Miguel Ballesteros     1. Creación                  
        /// </changelog>
        private Boolean itemAlreadyExistsCoti(Object newItem, ArrayList ArrayItems)
        {

            ComboCostCoti tmpNewItem = (ComboCostCoti)newItem;

            if (ArrayItems.Count > 0)
            {
                foreach (String item in ArrayItems)
                {
                    String[] ItemSplit = item.Split('|'); //ItemSplit[0] es el codigo del item, ItemSplit[1] es la descripcion

                    if (tmpNewItem.Codigolist == ItemSplit[0] && tmpNewItem.Description == ItemSplit[1])
                    {
                        return true;
                    }
                }

            }

            return false;
        }



        private void deleteItem(GridDetaMedi item, BindingSource source)
        {
         //   item.Option = Constants.DELETE_OPTION;
            itemToDeleteList.Add(item.Clone());

            List<GridDetaMedi> list = (List<GridDetaMedi>)source.DataSource;

            list.Remove(item);
        }


        /// <summary>
        /// Se definen teclas no válidas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void defineNotValidKeys()
        {
            notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);
        }

        #endregion

        #region NewItems
        /// <summary>
        /// Acción del boton que agrega una nueva lista a la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void bnAddNewItem_Click(object sender, EventArgs e)
        {

            // metodo que se encarga de cambiar el contenido del combo dentro de la grilla dependiendo del Nivel y Fechas escogidos
            this.cbx_List_ValueChanged();

            // Establece el foco en la grilla
            this.bnChargeByItemLega.Focus();
            // función para habilitar el botón aceptar
            enableAceptarButton();

            if (fieldsAreValid(this.ugInternalItemLega))
            {
                utilities.DisplayInfoMessage("Debe seleccionar un item en la lista antes de agregar otro !!!");
                return;
            }
            else
            {
                ChangeCheck = false;
                addItemToSource(bsChargueByItemLega, ugInternalItemLega);
            }
        }



        /// <summary>
        /// Acción del boton que agrega una nueva lista a la grilla de items cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void bnAddNewItem_ClickCoti(object sender, EventArgs e)
        {

            // metodo que se encarga de cambiar el contenido del combo dentro de la grilla dependiendo del Nivel y Fechas escogidos
            this.cbx_List_ValueChangedCoti();

            // Establece el foco en la grilla
            this.bnChargeByItemCoti.Focus();
            // función para habilitar el botón aceptar
            enableAceptarButton();

            if (fieldsAreValid(this.ugInternalItemCoti))
            {
                utilities.DisplayInfoMessage("Debe seleccionar un item en la lista antes de agregar otro !!!");
                return;
            }
            else
            {
                ChangeCheck = false;
                addItemToSourceCoti(bsChargueByItemCoti, ugInternalItemCoti);
            }
        }
        


        /// <summary>
        /// Acción del boton que elimina una lista de la grilla de items legalizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void bnChargeByConnItemsDeleteItem_Click(object sender, EventArgs e)
        {
            DeleteRowGrid(this.ugInternalItemLega, this.ArrayItemsLega, this.bsChargueByItemLega);
        }



        /// <summary>
        /// Acción del boton que elimina una lista de la grilla de items cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void bnChargeByConnItemsDeleteItem_ClickCoti(object sender, EventArgs e)
        {
            DeleteRowGrid(this.ugInternalItemCoti, this.ArrayItemsCoti, this.bsChargueByItemCoti);

        }


        /// <summary>
        /// funcion generrica para el proceso de eliminacion de item
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void DeleteRowGrid(UltraGrid ultragrid, ArrayList ArrayListItems, BindingSource source)
        {
            try
            {
                // se elimina la informacion del arreglo de item legalizados // 
                int Index = ultragrid.ActiveRow.Index, i = 0;
                bool sw = false;

                while (i <= ArrayListItems.Count && !sw)
                {
                    String[] ItemSplit = ArrayListItems[i].ToString().Split('|'); //ItemSplit[0] es el codigo del item, ItemSplit[1] es la descripcion

                    if (ItemSplit[1] == ultragrid.Rows[Index].Cells[0].Value.ToString())
                    {
                        ArrayListItems.RemoveAt(i);
                        sw = true;
                    }
                    
                    i++;
                }

            }
            catch (Exception ex) { }

            // luego se elimina la informacion de la grilla //
            deleteItemFromSource(source, ultragrid);
        }



        #endregion


        #region ButtonsActions
        /// <summary>
        /// Acción del boton aceptar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                
                DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "¿Desea Ingresar la informacion diligenciada?",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

                if (ContinueCancel == DialogResult.No)
                {
                    return;
                }
                if (ContinueCancel == DialogResult.Yes)
                {
                    
                        DateTime FechaIni = Convert.ToDateTime(cbDateValidInic.TextBoxValue);
                        DateTime FechaFin = Convert.ToDateTime(cbDateValidFin.TextBoxValue);
                        DateTime fechaActual = DateTime.Now; // fecha actual
                            
                        // se valida que todos los campos de la forma estén diligenciados
                         
                        if (tbOrder.TextBoxValue == null)
                        {
                            utilities.DisplayErrorMessage("Debe ingresar el codigo de la orden !!");
                            return;
                        }

                        if (cbCausal.Value == null)
                        {
                            utilities.DisplayErrorMessage("Debe ingresar el codigo de la Causal !!");
                            return;
                        }

                        if (String.IsNullOrEmpty(tbComment.TextBoxValue.Trim()))
                        {
                            utilities.DisplayErrorMessage("Debe ingresar la observación");
                            return;
                        }

                        if (cbResponsable.Value == null)
                        {
                            utilities.DisplayErrorMessage("Debe ingresar el nombre del responsable de la legalización de la orden !!");
                            return;
                        }

                        if (String.IsNullOrEmpty(cbDateValidInic.TextBoxValue))
                        {
                            utilities.DisplayErrorMessage("Debe ingresar la fecha de inicio de la ejecución !!");
                            return;
                        }

                        if (String.IsNullOrEmpty(cbDateValidFin.TextBoxValue))
                        {
                            utilities.DisplayErrorMessage("Debe ingresar la fecha fin de la ejecución!!");
                            return;
                        }

                        if (FechaFin < FechaIni)
                        {
                            utilities.DisplayErrorMessage("La fecha final debe ser mayor o igual a la fecha inicial");
                            return;
                        }

                        if (FechaIni > fechaActual)
                        {
                            utilities.DisplayErrorMessage("La fecha inicial no puede ser mayor a la fecha actual");
                            return;
                        }  

                        if (FechaFin > fechaActual)
                        {
                            utilities.DisplayErrorMessage("La fecha final no puede ser mayor a la fecha actual");
                            return;
                        }

                        // se convierten en los formatos correspondientes los datos obtenidos de los campos de la forma
                       
                        Int64 CodOrden = Convert.ToInt64(tbOrder.TextBoxValue);
                        Int64 CodContrato = Convert.ToInt64(ulbContrato.Text);
                        Int64 CodProducto = Convert.ToInt64(ulbProducto.Text); 
                        String sbObservacion = Convert.ToString(tbComment.TextBoxValue);
                        Int64 CodCausal = Convert.ToInt64(cbCausal.Value);
                        Int64 CodResponsable = Convert.ToInt64(cbResponsable.Value); 
                        string CodStatusOrder = "P"; // estado de la orden queda en pendiente a aprobar
                        DateTime FechaInicial = Convert.ToDateTime(cbDateValidInic.TextBoxObjectValue);//Convert.ToDateTime(.TextBoxValue).Date;
                        DateTime FechaFinal = Convert.ToDateTime(cbDateValidFin.TextBoxObjectValue);//Convert.ToDateTime(cbDateValidFin.TextBoxValue).Date;
                        Int64 CodMultifam = Convert.ToInt64(ulbmultifam.Text);
                        //Flag para mensaje enviado por email
                        Int64 flagMessage = 1;
                        String useParam = "Y";
 
                        // variables para manejar errores y procesos de la cabecera de la forma .NET//
                        Int64 onuErrorCodeOrder = 0;
                        String osbErrorMessageOrder = "";
                        
                        
                        // variables para manejar errores y procesos del area de medidores //
                        Int64   onuErrorCodeMed = 0;
                        String  osbErrorMessageMed = "";
                        Boolean Check = false;

                        
                        // variables para manejar errores y procesos del area de los items//
                        Int64 onuErrorCodeItem = 0;
                        String osbErrorMessageItem = "";

                        // si la causal seleccionada en la forma es de exito o de fallo para guardar
                        //  items y medidores o no relacionandolo con la orden

                        if (validaCausalFalloExito() == 1)
                        {
                            // se valida que por lo menos exista una lista checkeada en la grilla de medidores
                            for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                            {
                                if (ugInternalDetaMedi.Rows[i].Cells[3].Value.ToString() == "True")
                                {
                                    Check = true;
                                }
                            }

                            // si hay al menos un elemento checkeado
                            if (Check)
                            {
                                // se validad que existe un registro en la grilla de los items utilizados
                                if (ugInternalItemLega.Rows.Count > 0 || ugInternalItemCoti.Rows.Count > 0)
                                {
                                    for (int i = 0; i <= ugInternalItemLega.Rows.Count - 1; i++)
                                    {
                                        String Descripcion = "";
                                        try
                                        {
                                            Descripcion = Convert.ToString(ugInternalItemLega.Rows[i].Cells[0].Value.ToString());
                                            Int64 CodItem = FindCodeItem(this.ArrayItemsLega, Descripcion);
                                        }
                                        catch
                                        {
                                            utilities.DisplayErrorMessage("El ítem utilizado [" + Descripcion + "] no se encuentra configurado");
                                            return;
                                        }

                                    }

                                    for (int i = 0; i <= ugInternalItemCoti.Rows.Count - 1; i++)
                                    {
                                        String Descripcion = "";
                                        try
                                        {
                                            Descripcion = Convert.ToString(ugInternalItemCoti.Rows[i].Cells[0].Value.ToString());
                                            Int64 CodItem = FindCodeItem(this.ArrayItemsCoti, Descripcion);
                                        }
                                        catch
                                        {
                                            utilities.DisplayErrorMessage("El ítem cotizado [" + Descripcion + "] no se encuentra configurado");
                                            return;
                                        }
                                    }

                                    //Se valida el flag de Garantia
                                    String flagWarranty = "N";
                                    if (openFlagAppWarr.CheckState == CheckState.Checked)
                                    {
                                        flagWarranty = "Y";
                                    }
                                    else if (openFlagAppWarr.CheckState == CheckState.Indeterminate)
                                    {   
                                        utilities.DisplayErrorMessage("Debe activar o desactivar el flag de <Aplicar Garantia>");
                                        return;
                                    }
                                    else
                                    {
                                        flagWarranty = "N";
                                    }

                                    // se hace el llamado al procedimiento que hace el insert en la tabla LDC_LEGAORACO       
                                    blLDC_FCVC.SaveDatosOrdenCont(CodOrden, CodContrato, CodProducto, CodResponsable, sbObservacion, CodCausal,
                                                                    CodStatusOrder, null, FechaInicial, FechaFinal, CodMultifam, out onuErrorCodeOrder, out osbErrorMessageOrder);


                                    // se hace el llamado del procedimiento que hace la insercion en la tabla de medidores LDC_DETAMED
                                    for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                                    {
                                        // solo se procesarán los medidores que esten seleccionados
                                        if (ugInternalDetaMedi.Rows[i].Cells[3].Value.ToString() == "True")
                                        {
                                            String CodMedidor = Convert.ToString(ugInternalDetaMedi.Rows[i].Cells[0].Value.ToString());
                                            String Direccion = Convert.ToString(ugInternalDetaMedi.Rows[i].Cells[1].Value.ToString());
                                            Int64 nuContrato = Convert.ToInt64(ugInternalDetaMedi.Rows[i].Cells[2].Value.ToString());

                                            blLDC_FCVC.SaveDatosMedidores(CodOrden, CodMedidor, nuContrato, Direccion, out onuErrorCodeMed, out osbErrorMessageMed);
                                            utilities.doCommit();

                                        }

                                    }

                                    // se hace el llamado al procedimiento que hace la inserccion en la tabla de Items LDC_ORITEM

                                    // se envia la informacion de las pestaña de los items utilizados siempre y cuando exista algun dato
                                    if (ugInternalItemLega.Rows.Count > 0)
                                    {
                                        for (int i = 0; i <= ugInternalItemLega.Rows.Count - 1; i++)
                                        {
                                            String Descripcion = Convert.ToString(ugInternalItemLega.Rows[i].Cells[0].Value.ToString());
                                            Int64 CodItem = FindCodeItem(this.ArrayItemsLega, Descripcion); // se llama a la funcion para traer el codigo del item en el arreglo
                                            String TypeItems = "N"; // se ingresa el tipo de item normal
                                            Double nuCantidad = Convert.ToDouble(ugInternalItemLega.Rows[i].Cells[1].Value.ToString());
                                            Int64 nuValor = Convert.ToInt64(ugInternalItemLega.Rows[i].Cells[2].Value.ToString());
                                            Int64 nuValorTotal = Convert.ToInt64(ugInternalItemLega.Rows[i].Cells[3].Value.ToString());

                                            blLDC_FCVC.SaveDatosItems(CodOrden, CodItem, Descripcion, TypeItems, nuCantidad, nuValor, nuValorTotal, out onuErrorCodeItem, out osbErrorMessageItem);
                                            utilities.doCommit();

                                        }
                                    }                                    

                                    // se envia la informacion de las pestaña de los items utilizados siempre y cuando exista algun dato
                                    if (ugInternalItemCoti.Rows.Count > 0)
                                    {
                                        for (int i = 0; i <= ugInternalItemCoti.Rows.Count - 1; i++)
                                        {
                                            String Descripcion = Convert.ToString(ugInternalItemCoti.Rows[i].Cells[0].Value.ToString());
                                            Int64 CodItem = FindCodeItem(this.ArrayItemsCoti, Descripcion);
                                            String TypeItems = "C"; // se ingresa el tipo de item cotizado
                                            Double nuCantidad = Convert.ToDouble(ugInternalItemCoti.Rows[i].Cells[1].Value.ToString());
                                            Int64 nuValor = Convert.ToInt64(ugInternalItemCoti.Rows[i].Cells[2].Value.ToString());
                                            Int64 nuValorTotal = Convert.ToInt64(ugInternalItemCoti.Rows[i].Cells[3].Value.ToString());

                                            blLDC_FCVC.SaveDatosItems(CodOrden, CodItem, Descripcion, TypeItems, nuCantidad, nuValor, nuValorTotal, out onuErrorCodeItem, out osbErrorMessageItem);
                                            utilities.doCommit();

                                        }
                                    }

                                    //Se ejecuta proceso de generacion de garantias
                                    //processWarranty(CodOrden, flagWarranty);
                                    blLDC_FCVC.InsOrUpdByOrderWarranty(CodOrden, flagWarranty);

                                    // si la inserccion de los medidores en la tabla es correcta
                                    if (onuErrorCodeOrder == 0 && onuErrorCodeMed == 0 && onuErrorCodeItem == 0)
                                    {
                                        //Se realiza envio por correo de una notificacion
                                        sendMailNotification(CodOrden, flagMessage, useParam);

                                        MessageBox.Show("Las ordenes con los medidores y con los Items se agregaron con exito");
                                        //this.Close();

                                        // se resetean los labels
                                        CleanLabels();

                                        //desactivar pestañas
                                        DisableTabs();

                                        // desactivar campos
                                        DisableCampos();

                                        // se limpian las cajas de texto
                                        CleanTextBox();

                                        // se resetea la grilla
                                        bsChargeByDetaMedi.Clear();

                                        // se resetea la grilla de los items normales
                                        bsChargueByItemLega.Clear();

                                        // se resetea la grilla de los items cotizados
                                        bsChargueByItemCoti.Clear();
                                    }
                                    else if (onuErrorCodeOrder != 0)
                                    {
                                        utilities.DisplayErrorMessage("Se presento el siguiente Error con respecto a la informacion de la orden!! " + onuErrorCodeOrder + " " + osbErrorMessageOrder);
                                    }
                                    else if (onuErrorCodeMed != 0)
                                    {
                                        utilities.DisplayErrorMessage("Se presento el siguiente Error con respecto a los medidores!! " + onuErrorCodeMed + " " + osbErrorMessageMed);
                                    }
                                    else if (onuErrorCodeItem != 0)
                                    {
                                        utilities.DisplayErrorMessage("Se presento el siguiente Error con respecto a los Items!! " + onuErrorCodeItem + " " + osbErrorMessageItem);
                                    }
                                    Check = false;

                                }
                                else
                                {
                                    utilities.DisplayErrorMessage("Debe seleccionar por lo menos un item");
                                }
                            }
                            else
                            {
                                utilities.DisplayErrorMessage("Debe seleccionar por lo menos un medidor");
                            }

                        }
                        else  /// si la causal ingresada es una causal de fallo
                        {
                            
                            // se hace el llamado al procedimiento que hace el insert en la tabla LDC_LEGAORACO,
                            // pero no para hacer el insert sino para legalizar la causal de fallo

                            blLDC_FCVC.SaveDatosOrdenCont(CodOrden, CodContrato, CodProducto, CodResponsable, sbObservacion, CodCausal,
                                                            CodStatusOrder, null, FechaInicial, FechaFinal, CodMultifam, out onuErrorCodeOrder, out osbErrorMessageOrder);

                            // si la legalizacion de la orden es correcta
                            if (onuErrorCodeOrder == 0)
                            {
                                MessageBox.Show("La orden con causal de fallo se legalizó de forma correcta");

                                // se resetean los labels
                                CleanLabels();

                                //desactivar pestañas
                                DisableTabs();

                                // desactivar campos
                                DisableCampos();

                                // se limpian las cajas de texto
                                CleanTextBox();

                                // se resetea la grilla
                                bsChargeByDetaMedi.Clear();

                                // se resetea la grilla de los items
                                bsChargueByItemLega.Clear();

                                // se resetea la grilla de los items cotizados
                                bsChargueByItemCoti.Clear();
                            }
                            else
                            {
                                utilities.DisplayErrorMessage(onuErrorCodeOrder + " [ " + osbErrorMessageOrder + " ] ");
                            }

                        }

                }

            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                this.Dispose();
            }
        }



        // se crea la funcion para encontrar el codigo del item en el arraylist de cada grilla (item normal e item cotizado) //
        private int FindCodeItem(ArrayList ArrayItems, String DescItem)
        {
            bool sw = false;
            int i = 0, ItemId = 0;

            // se realiza el proceso del llenado de la informacion del los items con la informacion cargada en la grilla
            while (i <= ArrayItems.Count && !sw)
            {
                //ItemSplit[0] es el codigo del item, ItemSplit[1] es la descripcion
                String[] ItemSplit = ArrayItems[i].ToString().Split('|');

                if (ItemSplit[1] == DescItem)
                {
                    ItemId = Convert.ToInt32(ItemSplit[0]);
                    sw = true;
                }
                i++;
            }

            return ItemId;
        }



        /// <summary>
        /// Acción del boton cancelar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnCancel_Click(object sender, EventArgs e)
        {

            DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "No se han guardado todos los cambios. ¿Desea cerrar la aplicación sin guardar",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

            if (ContinueCancel == DialogResult.No)
            {
                return;
            }
            else
            {
                this.Dispose();
            }

        }

        #endregion


        private void ugInternalConnItems_KeyUp(object sender, KeyEventArgs e)
        {
            var grid = (UltraGrid)sender;

            setItemFilter(grid, e);
        }

        private void ugCertificationItems_KeyUp(object sender, KeyEventArgs e)
        {
            var grid = (UltraGrid)sender;

            setItemFilter(grid, e);
        }


        private void setItemFilter(UltraGrid ultragrid, KeyEventArgs e)
        {
            if (!notValidKeys.Contains(e.KeyCode))
            {
                if (ultragrid.ActiveCell != null)
                {
                    if (ultragrid.ActiveCell.Column.Key == "Description")
                    {
                        if (!string.IsNullOrEmpty(ultragrid.ActiveCell.Text))
                        {
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostList.LIST_DESCRIPTION_KEY].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + ultragrid.ActiveCell.Text + "*");
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters.LogicalOperator = FilterLogicalOperator.Or;
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostList.LIST_ID_KEY].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + ultragrid.ActiveCell.Text + "*");
                        }
                        else
                        {
                            clearFilterConditions();
                        }
                    }
                }
            }
        }

        private void clearFilterConditions()
        {
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostList.LIST_DESCRIPTION_KEY].FilterConditions.Clear();
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostList.LIST_ID_KEY].FilterConditions.Clear();
        }

        private void clearFilterConditionsCoti()
        {
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostCoti.LIST_DESCRIPTION_KEY].FilterConditions.Clear();
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ComboCostCoti.LIST_ID_KEY].FilterConditions.Clear();
        }


        private void ugChargeByConnItems_AfterCellUpdate(object sender, CellEventArgs e)
        {

            // se obtiene el index de la fila en donde esta seleccionado
            int Index = ugInternalItemLega.ActiveRow.Index;

            if (this.ugInternalItemLega.Rows[Index].Cells[1].IsActiveCell)
            {
                // se actualizan los datos de la grilla si la celda "Cantidad" es seleccionada/editada
                UpdateCeldaCantidad(Index);
            }
            else if (this.ugInternalItemLega.Rows[Index].Cells[0].IsActiveCell)
            {
                // se actualizan los datos de la grilla si el combobox es seleccionado/editado
                try
                {
                    setAfterCellUpdBehaviour(bsChargueByItemLega, e, itemsDropDown.SelectedRow.ListObject as ComboCostList, Index);
                }
                catch (NullReferenceException ex)
                {
                    utilities.DisplayInfoMessage("El ítem utilizado no se encuentra configurado");
                }
            }
            

        }


        private void setAfterCellUpdBehaviour(BindingSource source, CellEventArgs e, ComboCostList List, int Index)
        {

            if (e.Cell.Column.Key.ToUpper() == GridItemsLegal.DESCRIPTION_KEY)
            {
                setUpNewItem(source, List, Index);
            }

            clearFilterConditions();

        }

        private void setUpNewItem(BindingSource source, ComboCostList List, int Index)
        {
            GridItemsLegal currentItem;

            if (itemAlreadyExists(List, ArrayItemsLega))
            {
                utilities.DisplayInfoMessage("Este item ya existe");
                source.RemoveCurrent();
            }
            else
            {
                currentItem = (GridItemsLegal)source.Current;
                setNewItemData(currentItem, List, Index);
            }

        }


        /// <summary>
        /// Se setean los datos para nuevo Lista
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void setNewItemData(GridItemsLegal targetItem, ComboCostList List, int Index)
        {
            targetItem.Codigo = List.Codigo;
            targetItem.Description = List.Description;
            Int64 nuItem = Convert.ToInt64(targetItem.Codigo);
            Int64 OrdenTrabajo = Convert.ToInt64(tbOrder.TextBoxValue);
            DateTime FechaExeOrden = Convert.ToDateTime(cbDateValidFin.TextBoxObjectValue);

            //targetItem.Valor = blLDC_FCVC.getItemPrecio(OrdenTrabajo, nuItem);
            targetItem.Valor = blLDC_FCVC.getItemPrecio(OrdenTrabajo, nuItem, FechaExeOrden);
            targetItem.Cantidad = 0;

            // se deshabilita la celda o columna numero 1
           // ugInternalItemLega.Rows[Index].Cells[1].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

            // se deshabilita la celda o columna numero 2
            ugInternalItemLega.Rows[Index].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

            // se deshabilita la celda o columna numero 4 ValorTotal
            ugInternalItemLega.Rows[Index].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            
            // se guarda la informacion del codigo del item agregado con su descripcion en un arreglo
            ArrayItemsLega.Add(targetItem.Codigo +"|"+ targetItem.Description);
            
        }


        private void UpdateCeldaCantidad(int Index)
        {
            BindingSource source = bsChargueByItemLega;
            GridItemsLegal currentItem;

            currentItem = (GridItemsLegal)source.Current;

            currentItem.Cantidad = Convert.ToDouble(Convert.ToString(ugInternalItemLega.Rows[Index].Cells[1].Value));
          
            currentItem.ValorTotal = Convert.ToInt64(Convert.ToDouble(currentItem.Valor) * currentItem.Cantidad);
         

        }



        //------------------------------------------- seccion items cotizados ---------------------------------------//

        
        private void ugChargeByConnItems_AfterCellUpdateCoti(object sender, CellEventArgs e)
        {

            // se obtiene el index de la fila en donde esta seleccionado
            int Index = ugInternalItemCoti.ActiveRow.Index;

            if (this.ugInternalItemCoti.Rows[Index].Cells[1].IsActiveCell)
            {
                // se actualizan los datos de la grilla si la celda "Cantidad" es seleccionada/editada
                UpdateCeldaCantidadCoti(Index);
            }
            else if (this.ugInternalItemCoti.Rows[Index].Cells[0].IsActiveCell)
            {
                // se actualizan los datos de la grilla si el combobox es seleccionado/editado
                try
                {
                    setAfterCellUpdBehaviourCoti(bsChargueByItemCoti, e, (itemsDropDown.SelectedRow.ListObject as ComboCostCoti), Index);
                }
                catch (NullReferenceException ex)
                {
                    utilities.DisplayInfoMessage("El ítem cotizado no se encuentra configurado");
                }
            }

        }


        private void setAfterCellUpdBehaviourCoti(BindingSource source, CellEventArgs e, ComboCostCoti List, int Index)
        {

            if (e.Cell.Column.Key.ToUpper() == GridItemsCoti.DESCRIPTION_KEY)
            {
                setUpNewItemCoti(source, List, Index);
            }

            clearFilterConditionsCoti();

        }


        private void setUpNewItemCoti(BindingSource source, ComboCostCoti List, int Index)
        {
            GridItemsCoti currentItem;

            if (itemAlreadyExistsCoti(List, ArrayItemsCoti))
            {
                utilities.DisplayInfoMessage("Este item ya existe");
                source.RemoveCurrent();
            }
            else 
            {
                currentItem = (GridItemsCoti)source.Current;
                setNewItemDataCoti(currentItem, List, Index);
            }        
        }



        /// <summary>
        /// Se setean los datos para nuevo Lista
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void setNewItemDataCoti(GridItemsCoti targetItem, ComboCostCoti List, int Index)
        {
            targetItem.Codigo = List.Codigo; 
            targetItem.Description = List.Description; 
            Int64 nuItem = Convert.ToInt64(targetItem.Codigo); 
            Int64 OrdenTrabajo = Convert.ToInt64(tbOrder.TextBoxValue); 
            DateTime FechaExeOrden = Convert.ToDateTime(cbDateValidFin.TextBoxObjectValue); 

            //targetItem.Valor = blLDC_FCVC.getItemPrecio(nuItem);
            targetItem.Valor = blLDC_FCVC.getItemPrecio(OrdenTrabajo, nuItem, FechaExeOrden); 
            targetItem.Cantidad = 0;

            // se deshabilita la celda o columna numero 1
           // ugInternalItemCoti.Rows[Index].Cells[1].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

            // se deshabilita la celda o columna numero 2
            ugInternalItemCoti.Rows[Index].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

            // se deshabilita la celda o columna numero 4 ValorTotal
            ugInternalItemCoti.Rows[Index].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

            // se guarda la informacion del codigo del item agregado con su descripcion en un arreglo
            ArrayItemsCoti.Add(targetItem.Codigo +"|"+ targetItem.Description);

        }

        private void UpdateCeldaCantidadCoti(int Index)
        {
            BindingSource source = bsChargueByItemCoti;
            GridItemsCoti currentItem;

            currentItem = (GridItemsCoti)source.Current;

            currentItem.Cantidad = Convert.ToDouble(Convert.ToString(ugInternalItemCoti.Rows[Index].Cells[1].Value));

            currentItem.ValorTotal = Convert.ToInt64(Convert.ToDouble(currentItem.Valor) * currentItem.Cantidad);
        }


        //------------------------------------------- fin ---------------------------------------//

    

        /// <summary>
        /// Metodo que se encarga de agregar un item a la grilla en este caso el item seria una lista
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void addItemToSource(BindingSource source, UltraGrid ultragrid)
        {
            GridItemsLegal tmpQuotationItem = (GridItemsLegal)source.AddNew();

                refreshGrid(source, ultragrid);
        }


        /// <summary>
        /// Metodo que se encarga de agregar un item a la grilla de items cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void addItemToSourceCoti(BindingSource source, UltraGrid ultragrid)
        {
            GridItemsCoti tmpQuotationItem = (GridItemsCoti)source.AddNew();

            refreshGrid(source, ultragrid);
        }

        /// <summary>
        /// Metodo principal de eliminación
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void deleteItemFromSource(BindingSource source, UltraGrid ultragrid)
        {
            if (source.Count <= 0) return;
            else source.RemoveCurrent();
        }


        private void tbDiscount_Validating(object sender, CancelEventArgs e)
        {
            if (String.IsNullOrEmpty(tbOrder.TextBoxValue))
            {
                tbOrder.TextBoxObjectValue = 0;
            }
        }

        /// <summary>
        /// metodo que se encarga de cambiar el contenido del combo dentro de la grilla de items utilizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void cbx_List_ValueChanged()
        {

            Int64 OrdenTrabajo = Convert.ToInt64(tbOrder.TextBoxValue);        

            //realizo la consulta basicas de generacion de listas a partir del codigo devuelto por el combo de nivel o grupo
            itemsDropDown = new OpenGridDropDown();
            itemsCostList = blLDC_FCVC.getItemsNorm(OrdenTrabajo);
            itemsDropDown.DataSource = itemsCostList;
            itemsDropDown.ValueMember = ComboCostList.LIST_ID_KEY;
            itemsDropDown.DisplayMember = ComboCostList.LIST_DESCRIPTION_KEY;

            itemsDropDown.Parent = this;

            setUpDropDown(itemsDropDown);
                    
            //llenado de combos
            setValueListToGridColumn(ugInternalItemLega, "Description", itemsDropDown);
                        
            itemsDropDown.RowSelected += new RowSelectedEventHandler(itemsList_RowSelected);

            ugInternalItemLega.AfterCellUpdate -= ugChargeByConnItems_AfterCellUpdate;

            ugInternalItemLega.AfterCellUpdate += ugChargeByConnItems_AfterCellUpdate;

            refreshGrid(bsChargueByItemLega, ugInternalItemLega);

        }


        /// <summary>
        /// metodo que se encarga de cambiar el contenido del combo dentro de la grilla de items cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void cbx_List_ValueChangedCoti()
        {
                Int64 OrdenTrabajo = Convert.ToInt64(tbOrder.TextBoxValue);       

                //realizo la consulta basicas de generacion de listas a partir del codigo devuelto por el combo de nivel o grupo
                itemsDropDown = new OpenGridDropDown();
                itemsCostCoti = blLDC_FCVC.getItemsCoti(OrdenTrabajo);
                itemsDropDown.DataSource = itemsCostCoti;
                itemsDropDown.ValueMember = ComboCostCoti.LIST_ID_KEY;
                itemsDropDown.DisplayMember = ComboCostCoti.LIST_DESCRIPTION_KEY;

                itemsDropDown.Parent = this;

                setUpDropDownCoti(itemsDropDown);

                //llenado de combos
                setValueListToGridColumn(ugInternalItemCoti, "Description", itemsDropDown);

                itemsDropDown.RowSelected += new RowSelectedEventHandler(itemsList_RowSelectedCoti);

                ugInternalItemCoti.AfterCellUpdate -= ugChargeByConnItems_AfterCellUpdateCoti;

                ugInternalItemCoti.AfterCellUpdate += ugChargeByConnItems_AfterCellUpdateCoti;


                refreshGrid(bsChargueByItemCoti, ugInternalItemCoti);

        }


        /// <summary>
        /// metodo que se acciona cuando se le da click al check
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void ClickCheckList(object sender, EventArgs e)
        {
            CheckListAll();
        }

        /// <summary>
        /// Evento al cambiar de valor el check de aplica garantia
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ClickCheckApplyWarranty(object sender, EventArgs e)
        {
            Int64 orderId = Convert.ToInt64(Convert.ToString(tbOrder.TextBoxValue));
            bsChargueByItemLega.DataSource = blLDC_FCVC.GetDatosItemsNew(orderId, openFlagAppWarr.Value);
            bsChargueByItemCoti.DataSource = blLDC_FCVC.GetDatosItemsNewCoti(orderId, openFlagAppWarr.Value);
        }


        /// <summary>
        /// evento que se acciona cuando se cambia el valor del check de la grilla de medidores
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 30-06-2020  Miguel Ballesteros     1. Creación 
        private void CellProrrateoChange(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            ChangeValueCheckMain(e.Cell.Text);
        }


        /// <summary>
        /// evento que se acciona cuando se cambia el valor del check de la grilla de medidores
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 30-06-2020  Miguel Ballesteros     1. Creación 
        private void ChangeValueCheckMain(String ValueRowSelect)
        {
            int nuTam = ugInternalDetaMedi.Rows.Count, i = 0;
            bool sw = false;
            swChkGridMed = true;
            int Index = ugInternalDetaMedi.ActiveRow.Index;

            if (ugInternalDetaMedi.Rows.Count > 0)
            {
                // se valida cuando el checkbox sea clickeado en true
                if (ValueRowSelect == "True")
                {
                    // se recorren todos los registros de la grilla de medidores
                    while (i <= nuTam - 1 && !sw)
                    {
                        // No se tiene en cuenta el valor de la fila seleccionada
                        if (Index != i)
                        {
                            // se validan que todos los check esten en true para habilitar el check principal
                            if (ugInternalDetaMedi.Rows[i].Cells[3].Value.ToString() == "True")
                            {
                                chkActList.Value = "Y";
                            }
                            else
                            {
                                chkActList.Value = "N";
                                sw = true;
                            }
                        }

                        i++;
                    }

                }
                else
                {
                    chkActList.Value = "N";
                }

                swChkGridMed = false;
            }
        }

        /// <summary>
        /// metodo para seleccionar todo los checkbox de la grilla al checkear "Aplicar todo"
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void CheckListAll()
        {
            if (!swChkGridMed)
            {
                if (ugInternalDetaMedi.Rows.Count > 0)
                {
                    if (!chkActList.Enabled)
                    {
                        // se seleccionan todos los medidores
                        for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                        {
                            ugInternalDetaMedi.Rows[i].Cells[3].Value = 1;
                        }
                    }
                    else
                    {
                        // si el check "Aplicar todo" retorna un valor seleccionado procede a seleccionar todas las filas
                        if (chkActList.Value == "Y")
                        {
                            for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                            {
                                if (ugInternalDetaMedi.Rows[i].Cells[3].Value.ToString() == "False")
                                {
                                    ugInternalDetaMedi.Rows[i].Cells[3].Value = 1;
                                }
                            }
                        }
                        else
                        {
                            for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                            {
                                if (ugInternalDetaMedi.Rows[i].Cells[3].Value.ToString() == "True")
                                {
                                    ugInternalDetaMedi.Rows[i].Cells[3].Value = 0;
                                }
                            }
                        }
                    }
                }
            }     

        }

        /// <summary>
        /// Obtiene garantías
        /// </summary>
        /// <param name="orderId"></param>
        private void GetWarranties(Int64 orderId)
        {
            
            try
            {
                bsWarranty.DataSource = blLDC_FCVC.getWarrantyByProduct(orderId);                
            }
            catch
            {
                utilities.DisplayErrorMessage("Error obteniendo garantías orden: [" + orderId + "]");
            }
        }

        /// <summary>
        /// metodo que se encarga de cargar todos los medidores de acuerdo al codigo de la Orden
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void LoadAllMedidores(Int64 nuMulti)
        { 
                try
                {

                    if (!String.IsNullOrEmpty(tbOrder.TextBoxValue))
                    {                         
                        BindingSource originBindingSource = bsChargeByDetaMedi;

                        quotationBasicData.ItemsList = blLDC_FCVC.GetDatosMedidor(nuMulti);

                        if (quotationBasicData.ItemsList.Count > 0)
                        {
                            originBindingSource.DataSource = quotationBasicData.ItemsList;
                        }
                        else
                        {
                            utilities.DisplayErrorMessage("No existen medidores asociados al codido multifamiliar [" + nuMulti + "]");
                        }
                       
                    }
                    // si el campo orden esta vacío
                    else
                    {
                        // se resetea la grilla
                        bsChargeByDetaMedi.Clear();
                    }
                }
                catch
                {
                }


        }


        // funcion que valida cuando se presiona tab en el campo de la orden
        private void tbOrden_Leave(object sender, EventArgs e)
        {
            // se limpia la informacion basica de la forma//
            cbResponsable.Value = "";
            tbComment.TextBoxValue = "";
            cbDateValidInic.TextBoxValue = "";
            cbDateValidFin.TextBoxValue = "";
            cbCausal.Value = "";
 
            // antes de realizar el cargado de la forma se limpiaran los datos de los arreglos de los items
            ArrayItemsLega.Clear();
            ArrayItemsCoti.Clear();

            // se resetea la grilla de los items
            bsChargueByItemLega.Clear();

            // se resetea la grilla de los items cotizados
            bsChargueByItemCoti.Clear();

            FsbCargueInfoForma();
        }


        private void FsbCargueInfoForma()
        {

            try
            {

                if (!String.IsNullOrEmpty(tbOrder.TextBoxValue))
                {

                    Int64 CodOrden = Convert.ToInt64(tbOrder.TextBoxValue);
                    SWChangeCausal = true;
                    
                    // se obtiene el valor de la orden si existe
                    DataTable BasicDateOrdenExiste = DALLDC_APLAC.getOrderExist(CodOrden);

                    if (BasicDateOrdenExiste.Rows.Count > 0)
                    {
                        if (!String.IsNullOrEmpty(BasicDateOrdenExiste.Rows[0]["nuExisteOP"].ToString()))
                        {

                            // si el usuario que esta conectado es un contratista
                            if (User == "CONT")
                            {
                                
                                // se cargan los valores al combo RESPONSABLE
                                setValueCbResponsable(CodOrden);

                                    if (Convert.ToInt64(BasicDateOrdenExiste.Rows[0]["EstadoOrden"].ToString()) != 7)
                                    {

                                        if (!String.IsNullOrEmpty(BasicDateOrdenExiste.Rows[0]["nuExisteTipoTrabajo"].ToString()))
                                        {

                                            DataTable BasicDate = DALLDC_APLAC.FrfOrdenTrabajo(CodOrden);

                                            if (BasicDate.Rows.Count > 0)
                                            {
                                                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                                                String MessageError = "tiene que contactar a su asesor para notificar que no existe multifamiliar vinculado a la orden [" + CodOrden + "]  y no se puede continuar.";

                                                // se valida que el codigo multifamiliar no sea nulo 
                                                if (String.IsNullOrEmpty(BasicDate.Rows[0]["multiv"].ToString()) ||
                                                    Convert.ToInt64(BasicDate.Rows[0]["multiv"].ToString()) == -1)
                                                {
                                                    utilities.DisplayErrorMessage(MessageError);
                                                }
                                                else
                                                {
                                                    // Se valida el estado de la orden ingresada para verificar si es rechazada o no //
                                                    DataTable BasicDateRechazada = DALLDC_APLAC.getEstadoOrder(CodOrden);

                                                    ulbProducto.Text = BasicDate.Rows[0]["producto"].ToString();
                                                    ulbTaskType.Text = BasicDate.Rows[0]["tipotrabajo"].ToString();
                                                    ulbActivity.Text = BasicDate.Rows[0]["actividad"].ToString();
                                                    ulbDescription.Text = BasicDate.Rows[0]["descripcion"].ToString();
                                                    ulbStatus.Text = BasicDate.Rows[0]["estado"].ToString();
                                                    ulbContrato.Text = BasicDate.Rows[0]["contrato"].ToString();
                                                    ulbmultifam.Text = BasicDate.Rows[0]["multiv"].ToString();

                                                    Int64 nuMulti = Convert.ToInt64(ulbmultifam.Text);

                                                    // se llama a la funcion que hace la consulta de los medidores
                                                    LoadAllMedidores(nuMulti);

                                                    // si la orden es rechazada---------------------------------------------------------------------
                                                    if (BasicDateRechazada.Rows.Count > 0)
                                                    {

                                                        // se cargan de datos los campos
                                                        cbResponsable.Value = BasicDateRechazada.Rows[0]["codResponsable"].ToString();
                                                        cbCausal.Value = BasicDateRechazada.Rows[0]["codCausal"].ToString();
                                                        tbComment.TextBoxValue = BasicDateRechazada.Rows[0]["osbContratista"].ToString();
                                                        cbDateValidInic.TextBoxValue = BasicDateRechazada.Rows[0]["Fecha_Ini"].ToString();
                                                        cbDateValidFin.TextBoxValue = BasicDateRechazada.Rows[0]["Fecha_Fin"].ToString();

                                                        //--------------------------------------------------------------------------//
                                                        //--------------------------- PROCESO MEDIDORES ----------------------------//
                                                        //--------------------------------------------------------------------------//
                                                        DataTable BasicDateMedi = DALLDC_APLAC.GetDatosMediValidate(CodOrden);
                                                        for (int i = 0; i < BasicDateMedi.Rows.Count; i++)
                                                        {
                                                            for (int j = 0; j < ugInternalDetaMedi.Rows.Count; j++)
                                                            {
                                                                if (Convert.ToString(ugInternalDetaMedi.Rows[j].Cells[0].Value.ToString()) ==
                                                                    BasicDateMedi.Rows[i]["medidor"].ToString() &&
                                                                    Convert.ToString(ugInternalDetaMedi.Rows[j].Cells[2].Value.ToString()) ==
                                                                    BasicDateMedi.Rows[i]["contrato"].ToString())
                                                                {
                                                                    this.ugInternalDetaMedi.Rows[j].Cells[3].Value = "True";
                                                                }
                                                            }
                                                        }


                                                        //--------------------------------------------------------------------------//
                                                        //-------------------------- PROCESO ITEMS NORMAL --------------------------//
                                                        //--------------------------------------------------------------------------//

                                                        // se llena la grilla de los items Normales con los datos de la nueva tabla
                                                        BindingSource originBindingItems = bsChargueByItemLega;

                                                        quotationBasicData.ItemsListNormal = blLDC_FCVC.GetDatosItemsNew(CodOrden);

                                                        if (quotationBasicData.ItemsListNormal.Count > 0)
                                                        {
                                                            originBindingItems.DataSource = quotationBasicData.ItemsListNormal;

                                                            ugInternalItemLega.AfterCellUpdate -= ugChargeByConnItems_AfterCellUpdate;

                                                            ugInternalItemLega.AfterCellUpdate += ugChargeByConnItems_AfterCellUpdate;
                                                        
                                                        }

                                                        // se valida que la grilla no este vacia para poder guardar el codigo del item en el array de items
                                                        // normales, en caso que en la grilla no esté vacia entonces no hará el llenado completo del arreglo
                                                        if (ugInternalItemLega.Rows.Count > 0)
                                                        {
                                                            // se llena el array de los items normales con la informacion de los items cargados
                                                            DataTable BasicDateItemsLega = DALLDC_APLAC.getItemsNormValidate(CodOrden);

                                                            // se realiza el recorrido en la grilla de los items normales
                                                            for (int i = 0; i < ugInternalItemLega.Rows.Count; i++)
                                                            {
                                                                // se obtiene la descripcion del item de la grilla
                                                                String DescItemGrilla = Convert.ToString(ugInternalItemLega.Rows[i].Cells[0].Value.ToString());

                                                                // se deshabilita la celda o columna numero 2
                                                                ugInternalItemLega.Rows[i].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

                                                                // se deshabilita la celda o columna numero 4 ValorTotal
                                                                ugInternalItemLega.Rows[i].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                                                        

                                                                for (int j = 0; j < BasicDateItemsLega.Rows.Count; j++)
                                                                {
                                                                    // si la descripcion de la grilla esta en la consulta de los items del combobox de items
                                                                    if (DescItemGrilla == BasicDateItemsLega.Rows[j]["Descripcion"].ToString())
                                                                    {
                                                                        ArrayItemsLega.Add(BasicDateItemsLega.Rows[j]["codigo"].ToString() + "|" + DescItemGrilla);
                                                                    }
                                                                }
                                                            }


                                                        }

                                                        //--------------------------------------------------------------------------//
                                                        //-------------------------- PROCESO ITEMS COTIZADOS -----------------------//
                                                        //--------------------------------------------------------------------------//

                                                        // se llena la grilla de los items Cotizados con los datos de la nueva tabla
                                                        BindingSource originBindingItemsCoti = bsChargueByItemCoti;

                                                        quotationBasicData.ItemsListCoti = blLDC_FCVC.GetDatosItemsNewCoti(CodOrden);

                                                        if (quotationBasicData.ItemsListCoti.Count > 0)
                                                        {
                                                            originBindingItemsCoti.DataSource = quotationBasicData.ItemsListCoti;

                                                            ugInternalItemCoti.AfterCellUpdate -= ugChargeByConnItems_AfterCellUpdateCoti;

                                                            ugInternalItemCoti.AfterCellUpdate += ugChargeByConnItems_AfterCellUpdateCoti;
                                                        }

                                                        // se valida que la grilla no este vacia para poder guardar el codigo del item en el array de items
                                                        // cotizados, en caso que en la grilla no esté vacia entonces no hará el llenado completo del arreglo
                                                        if (ugInternalItemCoti.Rows.Count > 0)
                                                        {
                                                            // se llena el array de los items cotizados con la informacion de los items cargados
                                                            DataTable BasicDateItemsCoti = DALLDC_APLAC.getItemsCotiValidate(CodOrden);

                                                            // se realiza el recorrido en la grilla de los items cotizados
                                                            for (int i = 0; i < ugInternalItemCoti.Rows.Count; i++)
                                                            {
                                                                // se obtiene la descripcion del item de la grilla
                                                                String DescItemGrilla = Convert.ToString(ugInternalItemCoti.Rows[i].Cells[0].Value.ToString());


                                                                // se deshabilita la celda o columna numero 2
                                                                ugInternalItemCoti.Rows[i].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;

                                                                // se deshabilita la celda o columna numero 4 ValorTotal
                                                                ugInternalItemCoti.Rows[i].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                                                        

                                                                for (int j = 0; j < BasicDateItemsCoti.Rows.Count; j++)
                                                                {
                                                                    // si la descripcion de la grilla esta en la consulta de los items del combobox de items
                                                                    if (DescItemGrilla == BasicDateItemsCoti.Rows[j]["Descripcion"].ToString())
                                                                    {
                                                                        ArrayItemsCoti.Add(BasicDateItemsCoti.Rows[j]["codigo"].ToString() + "|" + DescItemGrilla);
                                                                    }
                                                                }
                                                            }


                                                        }

                                                        //--------------------------------------------------------------------------//
                                                        //-------------------------- FIN PROCESO ITEMS COTIZADOS -----------------------//
                                                        //--------------------------------------------------------------------------//

                                                        //activar pestañas
                                                        EnableTabs();

                                                        // se establece el comentario del funcional en la caja de texto tbCommentFuncionario
                                                        tbCommentFuncionario.TextBoxValue = BasicDateRechazada.Rows[0]["osbFuncionario"].ToString();

                                                        // activar boton aceptar
                                                        btnAceptar.Enabled = true;

                                                    }

                                                    // activar campos
                                                    enableCampos();

                                                    // se cambia la propiedad de edicion de la grilla de medidores
                                                    NoEditUgInternalDetaMedi();

                                                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                                                }

                                            }
                                            else 
                                            {
                                                utilities.DisplayErrorMessage("La orden no se puede procesar porque no cuenta con las especificaciones requeridas!!");
                                            }

                                        }
                                        else 
                                        {
                                            utilities.DisplayErrorMessage("El tipo de trabajo no se encuentra configurado para ser legalizado por la forma, validar el parametro LDCTTLEGA!!");
                                        }

                                    }
                                    else
                                    {
                                        CleanLabelsCamposCONT();
                                        utilities.DisplayErrorMessage("No se puede procesar la orden porque esta en estado 7 (Ejecutada)!!");
                                    }

                                    openFlagAppWarr.Enabled = true;
                            }

                            // SI EL USUARIO QUE ESTA CONECTADO ES UN USUARIO FUNCIONAL
                            if (User == "GDC")
                            {

                                DataTable BasicDate = DALLDC_APLAC.FrfOrdenTrabNew(CodOrden);

                                if (BasicDate.Rows.Count > 0)
                                {

                                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                                    // se cargan de datos los labels
                                    ulbProducto.Text = BasicDate.Rows[0]["codProduct"].ToString();
                                    ulbTaskType.Text = BasicDate.Rows[0]["tipotrabajo"].ToString();
                                    ulbActivity.Text = BasicDate.Rows[0]["actividad"].ToString();
                                    ulbDescription.Text = BasicDate.Rows[0]["descripcion"].ToString();
                                    ulbStatus.Text = BasicDate.Rows[0]["estado"].ToString();
                                    ulbContrato.Text = BasicDate.Rows[0]["codContrato"].ToString();
                                    ulbmultifam.Text = BasicDate.Rows[0]["nuMultifam"].ToString();

                                    // se cargan de datos los campos
                                    cbResponsable.Value = BasicDate.Rows[0]["codResponsable"].ToString();
                                    cbCausal.Value = BasicDate.Rows[0]["codCausal"].ToString();
                                    tbComment.TextBoxValue = BasicDate.Rows[0]["osbContratista"].ToString();
                                    cbDateValidInic.TextBoxValue = BasicDate.Rows[0]["Fecha_Ini"].ToString();
                                    cbDateValidFin.TextBoxValue = BasicDate.Rows[0]["Fecha_Fin"].ToString();

                                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;                                                                        

                                    // se llena la grilla de los medidores con los datos de la nueva tabla

                                    BindingSource originBindingSource = bsChargeByDetaMedi;

                                    quotationBasicData.ItemsList = blLDC_FCVC.GetDatosMediNew(CodOrden);

                                    if (quotationBasicData.ItemsList.Count > 0)
                                    {
                                        originBindingSource.DataSource = quotationBasicData.ItemsList;
                                    }

                                    // si existe algun dato en la grilla entonces desactive el select
                                    if(ugInternalDetaMedi.Rows.Count > 0)
                                    {
                                        // se desactiva la seleccion de la fila
                                        ugInternalDetaMedi.ActiveRow = ugInternalDetaMedi.Rows[0];
                                        ugInternalDetaMedi.ActiveRow = null;

                                    }
                                    


                                    // se llena la grilla de los items Normales con los datos de la nueva tabla

                                    BindingSource originBindingItems = bsChargueByItemLega;

                                    quotationBasicData.ItemsListNormal = blLDC_FCVC.GetDatosItemsNew(CodOrden);

                                    if (quotationBasicData.ItemsListNormal.Count > 0)
                                    {
                                        originBindingItems.DataSource = quotationBasicData.ItemsListNormal;
                                    }

                                    // si existe algun dato en la grilla entonces desactive el select
                                    if(ugInternalItemLega.Rows.Count > 0)
                                    {
                                        // se desactiva la seleccion de la fila
                                        ugInternalItemLega.ActiveRow = ugInternalItemLega.Rows[0]; 
                                        ugInternalItemLega.ActiveRow = null;

                                    }
                                    


                                    // se llena la grilla de los items Cotizados con los datos de la nueva tabla

                                    BindingSource originBindingItemsCoti = bsChargueByItemCoti;

                                    quotationBasicData.ItemsListCoti = blLDC_FCVC.GetDatosItemsNewCoti(CodOrden);

                                    if (quotationBasicData.ItemsListCoti.Count > 0)
                                    {
                                        originBindingItemsCoti.DataSource = quotationBasicData.ItemsListCoti;
                                    }

                                    // si existe algun dato en la grilla entonces desactive el select
                                    if(ugInternalItemCoti.Rows.Count > 0)
                                    {
                                        ugInternalItemCoti.ActiveRow = ugInternalItemCoti.Rows[0];
                                        ugInternalItemCoti.ActiveRow = null;
                                    }
                                    


                                    // se deshabilitan los botones de agregar y eliminar registros de las grillas
                                    bnChargeByConnItemCoti.Enabled = false;
                                    bnDeleteItemCoti.Enabled = false;
                                    bnChargeByConnItemsAddNewItem.Enabled = false;
                                    bnChargeByConnItemsDeleteItem.Enabled = false;

                                    // se deshabilita el checkBox
                                    chkActList.Enabled = false;

                                    // se llenan de manera automatica todos los checkbox de todos los medidores cargados
                                    CheckListAll();

                                    // se habilitan los botones rechazar y aprobar de la forma
                                    EnableButtonAprobarRechazasGDC();

                                    //se habilitan los tabs de la grilla de items para su navegacion
                                    TabItems.Tabs[0].Enabled = true;
                                    TabItems.Tabs[1].Enabled = true;

                                    // se deshabilitan la grilla de los items cotizados y normales
                                    ugInternalItemCoti.Enabled = false;
                                    ugInternalItemLega.Enabled = false;

                                    ugDataWarranty.Tabs[0].Enabled = true;
                                    ugDataWarranty.Tabs[1].Enabled = true;

                                    tbWarranty.Enabled = false;
                                    ugInternalDetaMedi.Enabled = false;

                                }
                                else
                                {
                                    MessageBox.Show("No se ha encontrado informacion de La orden [" + tbOrder.TextBoxValue + "] ");
                                    // se resetean los labels
                                    CleanLabels();
                                }

                                openFlagAppWarr.Enabled = false;
                            }

                            if (!String.IsNullOrEmpty(tbOrder.TextBoxValue) && !String.IsNullOrEmpty(ulbmultifam.Text))
                            {
                                //Se asignan variables de total de contratos
                                Int64 totalContratos;
                                Int64 contSelec;

                                blLDC_FCVC.getContratosMulti(Convert.ToInt64(Convert.ToString(tbOrder.TextBoxValue)), Convert.ToInt64(ulbmultifam.Text), out totalContratos, out contSelec);

                                ulCantidadCont.Text = Convert.ToString(totalContratos);
                                ulContSel.Text = Convert.ToString(contSelec);

                                //Obtiene garantías
                                GetWarranties(Convert.ToInt64(Convert.ToString(tbOrder.TextBoxValue)));
                            }

                            String flag = blLDC_FCVC.GetFlagByOrder(Convert.ToInt64(Convert.ToString(tbOrder.TextBoxValue)));
                            openFlagAppWarr.Value = flag;
							
							//Si no tiene Garantias, se deshabilita el flag "Aplica Garantia"
							if (bsWarranty.Count == 0)
							{
								openFlagAppWarr.Enabled = false;
								openFlagAppWarr.Value = "N";
							}
                        }
                        else
                        {
                            CleanLabelsCamposCONT();
                            utilities.DisplayErrorMessage("El usuario conectado no esta asociado a la unidad operativa!!");
                        }

                    }
                    else
                    {
                        CleanLabelsCamposCONT();
                        utilities.DisplayErrorMessage("La orden no existe en la base de datos!!");
                    }                
                
                
                }
                // si el campo orden esta vacío
                else
                {
                    // se resetea la grilla
                    bsChargeByDetaMedi.Clear();

                    // se resetea la grilla de los items
                    bsChargueByItemLega.Clear();

                    // se resetea la grilla de los items cotizados
                    bsChargueByItemCoti.Clear();

                    // se resetean los labels
                    CleanLabels();

                    //desactivar pestañas
                    DisableTabs();

                    // desactivar campos
                    DisableCampos();

                    // se limpian las cajas de texto
                    CleanTextBox();

                    // se deshabilitan los botones rechazar y aprobar de la forma
                    disableButtonAprobarRechazasGDC();

                    // se deshabilita el boton aceptar
                    disableAceptarButton();
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                this.Dispose();
            }

            ugInternalItemLega.ActiveRow = null;
            ugInternalItemCoti.ActiveRow = null;
            tbWarranty.ActiveRow = null;
            ugInternalItemLega.DisplayLayout.Override.ActiveCellAppearance.Reset();
            ugInternalItemLega.DisplayLayout.Override.ActiveRowAppearance.Reset();
            ugInternalItemCoti.DisplayLayout.Override.ActiveCellAppearance.Reset();
            ugInternalItemCoti.DisplayLayout.Override.ActiveRowAppearance.Reset();
            tbWarranty.DisplayLayout.Override.ActiveCellAppearance.Reset();
            tbWarranty.DisplayLayout.Override.ActiveRowAppearance.Reset();

        }


        public void CleanLabelsCamposCONT()
        {
            // se resetea la grilla
            bsChargeByDetaMedi.Clear();

            // se resetea la grilla de los items
            bsChargueByItemLega.Clear();

            // se resetea la grilla de los items cotizados
            bsChargueByItemCoti.Clear();

            // se resetean los labels
            CleanLabels();

            //desactivar pestañas
            DisableTabs();

            // desactivar campos
            DisableCampos();

            // se limpian las cajas de texto
            CleanTextBox();
        }

        /// <summary>
        /// Crea las ordenes de garantía
        /// </summary>
        /// <param name="orderId"></param>
        /// <param name="flag"></param>
        public void processWarranty(Int64 orderId, String flag)
        {
            blLDC_FCVC.processWarranty(orderId, flag);
        }
            
        public String ObtenerUsuarioConectado()
        {
                
            String Usuario = blLDC_FCVC.getUserConect();

            if (ContMesgUserConect <= 0)
            {
                // si el usuario conectado esta configurado en CONT o GDC
                if (Usuario != "NotFind")
                {
                    if (Usuario == "CONT")
                    {
                        btnAprobar.Hide();
                        btnRechazar.Hide();
                        TitleFuncionario.Enabled = false;
                        tbCommentFuncionario.Enabled = false;
                        openTitleCont.Show();
                        openTitleGDC.Hide();

                        // se redimensiona el tamaño de la forma
                        /*  this.ClientSize = new Size(1038, 680);// 1038, 788;
                          this.panel2.Visible = false;
                          this.panel4.ClientSize = new Size(1267, 420);
                          this.TabDetaMedi.ClientSize = new Size(1259, 250);
                          this.ugInternalDetaMedi.ClientSize = new Size(1261, 97);*/

                    }
                    else if ((Usuario == "GDC"))
                    {
                        btnAceptar.Hide();
                        openTitleCont.Hide();
                        openTitleGDC.Show();

                    }
                }
                else
                {
                    utilities.DisplayErrorMessage("Debe configurar el usuario conectado como Contratista [CONT] o funcional[GDC] en la forma LDC_PERFILUSUARIOS");
                    ContMesgUserConect++;
                }
            }


            return Usuario;
                
        }


        //---------------------- FUNCIONALIDADES DE LOS BOTONES ACEPTAR Y RECHAZAR ---------------------------//

        public void btnAprobar_Click(object sender, EventArgs e)
        {
            try
            {   
                DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "¿Desea Aprobar el proceso de legalizacion de la Orden?",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

                if (ContinueCancel == DialogResult.No)
                {
                    return;
                }
                if (ContinueCancel == DialogResult.Yes)
                {
                    
                    if (!String.IsNullOrEmpty(tbCommentFuncionario.TextBoxValue))
                    {
                        // Variables de la forma //
                        String sbObservacion = Convert.ToString(tbCommentFuncionario.TextBoxValue);
                        DateTime FechaIni = Convert.ToDateTime(cbDateValidInic.TextBoxValue);
                        DateTime FechaFin = Convert.ToDateTime(cbDateValidFin.TextBoxValue);
                        Int64 inuOrden = Convert.ToInt64(tbOrder.TextBoxValue);
                        Int64 flagMessage = 2;
                        String useParam = "N";                                              

                        // Otras Variables //
                        Int64 onuErrorCode ;
                        String osbErrorMessage ;

                        for (int i = 0; i <= ugInternalDetaMedi.Rows.Count - 1; i++)
                        {
                            // solo se procesarán los medidores que esten seleccionados                                                        
                            Int64 nuContrato = Convert.ToInt64(ugInternalDetaMedi.Rows[i].Cells[2].Value.ToString());
                            Int64 estadoCorte = Convert.ToInt64(ugInternalDetaMedi.Rows[i].Cells[5].Value.ToString());

                            String validaFact = blLDC_FCVC.fsbEsFacturable(estadoCorte);

                            if (validaFact == "N")
                            {
                                ExceptionHandler.EvaluateErrorCode(2741, "El contrato [" + nuContrato + "] se encuentra en un estado de corte no facturable. Estado de corte [" + estadoCorte+"]");  
                                //utilities.DisplayErrorMessage(2741 + " " + "El contrato ["+ nuContrato+"] se encuentra en un estado de corte no facturable");
                            }
                        }

                        String flagWarranty = null;
                        if (openFlagAppWarr.Checked)
                        {
                            flagWarranty = "Y";
                        }
                        else
                        {
                            flagWarranty = "N";
                        }
                        //blLDC_FCVC.InsOrUpdByOrderWarranty(inuOrden, flagWarranty);

                        blLDC_FCVC.AprobarRechazOrden_click(inuOrden, "A", sbObservacion, FechaIni, FechaFin,
                                                            out onuErrorCode, out osbErrorMessage);

                        // si la inserccion de los medidores en la tabla es correcta
                        if (onuErrorCode == 0)
                        {
                            sendMailNotification(inuOrden, flagMessage, useParam);

                            MessageBox.Show("La orden Fue legalizada y se crearon Ordenes hijas VSI con exito");

                            // se resetean los labels
                            CleanLabels();

                            //desactivar pestañas
                            DisableTabs();

                            // desactivar campos
                            DisableCampos();

                            // se limpian las cajas de texto
                            CleanTextBox();

                            // se resetea la grilla
                            bsChargeByDetaMedi.Clear();

                            // se resetea la grilla de los items
                            bsChargueByItemLega.Clear();

                            // se resetea la grilla de los items cotizados
                            bsChargueByItemCoti.Clear();

                        }
                        else if (onuErrorCode != 0)
                        {
                            utilities.DisplayErrorMessage(onuErrorCode + " " + osbErrorMessage);
                        }
                    }
                    else
                    {
                        MessageBox.Show("No puede dejar el campo Observacion Vacio");
                    }

                }

            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                //this.Dispose();
            }
        }




        public void btnRechazar_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "¿Desea Rechazar el proceso de legalizacion de la Orden?",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

                if (ContinueCancel == DialogResult.No)
                {
                    return;
                }
                if (ContinueCancel == DialogResult.Yes)
                {

                    if (!String.IsNullOrEmpty(tbCommentFuncionario.TextBoxValue))
                    {

                        // Variables de la forma //
                        String sbObservacion = Convert.ToString(tbCommentFuncionario.TextBoxValue);
                        DateTime FechaIni = Convert.ToDateTime(cbDateValidInic.TextBoxValue);
                        DateTime FechaFin = Convert.ToDateTime(cbDateValidFin.TextBoxValue);
                        Int64 inuOrden = Convert.ToInt64(tbOrder.TextBoxValue);
                        Int64 flagMessage = 3;
                        String useParam = "N";

                        // Otras Variables //
                        Int64 onuErrorCode ;
                        String osbErrorMessage;

                        blLDC_FCVC.AprobarRechazOrden_click(inuOrden, "R", sbObservacion, FechaIni, FechaFin,
                                                            out onuErrorCode, out osbErrorMessage);

                        // si la inserccion de los medidores en la tabla es correcta
                        if (onuErrorCode == 0)
                        {
                            sendMailNotification(inuOrden, flagMessage, useParam);

                            MessageBox.Show("La orden Fue Rechazada con exito");
                            //this.Close();
                            // se resetean los labels
                            CleanLabels();

                            //desactivar pestañas
                            DisableTabs();

                            // desactivar campos
                            DisableCampos();

                            // se limpian las cajas de texto
                            CleanTextBox();

                            // se resetea la grilla
                            bsChargeByDetaMedi.Clear();

                            // se resetea la grilla de los items
                            bsChargueByItemLega.Clear();

                            // se resetea la grilla de los items cotizados
                            bsChargueByItemCoti.Clear();
                        }
                        else if (onuErrorCode != 0)
                        {
                            utilities.DisplayErrorMessage(onuErrorCode + " - " + osbErrorMessage);
                        }

                    }
                    else
                    {
                        MessageBox.Show("No puede dejar el campo Observacion Vacio");
                    }

                }

            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                this.Dispose();
            }
        }


        //---------------------- FUNCIONALIDAD AL CAMBIAR EL VALOR DEL COMBOBOX CAUSAL EN LA FORMA ---------------------------//

        /*private void cbCausal_ValueChanged(object sender, EventArgs e)
        {

            if (SWChangeCausal)
            {
                //se obtiene el valor del causal del combobox
                Int64 nuCausal = Convert.ToInt64(cbCausal.Value.ToString());

                // se obtiene desde la base de datos la clase de causal
                Int64 nuClassCausal = blLDC_FCVC.getClassCausal(nuCausal);

                // se deshabilita la seccion de medidores e items
                // se valida causal de fallo
                if (nuClassCausal == 2)
                {

                    bsChargeByDetaMedi.Clear();
                    bsChargueByItemLega.Clear();
                    DisableTabs();
                    enableAceptarButton();

                    // se valida causal de exito 
                }
                else if (nuClassCausal == 1)
                {
                    EnableTabs();
                    disableAceptarButton();
                    FsbCargueInfoForma();
                }
            
            }
 
        }*/


        // procedimiento que recorre la grilla de los medidores recien cargada para validar cada fila y modificar su atributo a no editado
        private void NoEditUgInternalDetaMedi()
        {
            for (int i = 0; i < ugInternalDetaMedi.DisplayLayout.Rows.Count; i++)
            {
                ugInternalDetaMedi.Rows[i].Cells[0].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                ugInternalDetaMedi.Rows[i].Cells[1].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                ugInternalDetaMedi.Rows[i].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            }

        }

        // -------------------------- METODO PARA VALIDAR LA TECLA DE BARRA ESPACIADORA PRESIONADA --------------------------//
        private void ugInternalDetaMedi_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode.Equals(Keys.Space))
            {
                // se obtiene el index de la celda activada
                int Index = ugInternalDetaMedi.ActiveRow.Index;

                if (ugInternalDetaMedi.Rows[Index].Cells[3].Value.ToString() == "False")
                {
                    // se activa el checkbox de la grilla de medidores
                    this.ugInternalDetaMedi.Rows[Index].Cells[3].Value = "True";
                    ChangeValueCheckMain(ugInternalDetaMedi.Rows[Index].Cells[3].Value.ToString());
                }
                else
                {
                    // se desactiva el checkbox de la grilla de medidores
                    this.ugInternalDetaMedi.Rows[Index].Cells[3].Value = "False";
                    ChangeValueCheckMain(ugInternalDetaMedi.Rows[Index].Cells[3].Value.ToString());
                }
            }
        }




        //---------------------- FUNCIONALIDAD AL PRESIONAR TAB EN LOS CAMPOS DEL ENCABEZADO DE LA FORMA LDCAPLAC ---------------------------//

        // CAMPO RESPONSABLE //
        private void tbResponsable_Leave(object sender, EventArgs e)
        {
            if (validaCampollenado()) { EnableTabs(); } else { DisableTabs(); }
        }

        // CAMPO CAUSAL //
        private void tbCausal_Leave(object sender, EventArgs e)
        {
            if (validaCampollenado()) { EnableTabs(); } else { DisableTabs(); }
        }

        // CAMPO FECHA INICIO DE EJECUCION //
        private void tbFechaIniEjecucion_Leave(object sender, EventArgs e)
        {
            if (validaCampollenado()) { EnableTabs(); } else { DisableTabs(); }
        }

        // CAMPO FECHA FIN DE EJECUCION //
        private void tbFechaFinEjecucion_Leave(object sender, EventArgs e)
        {
            if (validaCampollenado()) { EnableTabs(); } else { DisableTabs(); }
        }
        
        // CAMPO OBSERVACION //
        private void tbObservacion_Leave(object sender, EventArgs e)
        {
            if (validaCampollenado()) { EnableTabs(); } else { DisableTabs(); }
        }

        private bool validaCampollenado()
        {
            bool sw = false;

            if (!String.IsNullOrEmpty(cbDateValidInic.TextBoxValue) &&
                !String.IsNullOrEmpty(cbDateValidFin.TextBoxValue) &&
                !String.IsNullOrEmpty(tbComment.TextBoxValue) &&
                cbResponsable.Value != null &&
                cbCausal.Value != null  ) 
            {
                
                enableAceptarButton();

                if (validaCausalFalloExito() == 1) // aqui se valida la causal de exito
                {
                    sw = true;
                }
                else
                {
                    sw = false;
                }
       
            }
            else
            {
                sw = false;
            }


            return sw;
        }


        private Int64 validaCausalFalloExito()
        {

            //se obtiene el valor del causal del combobox
            Int64 nuCausal = Convert.ToInt64(cbCausal.Value.ToString());

            // se obtiene desde la base de datos la clase de causal
            Int64 nuClassCausal = blLDC_FCVC.getClassCausal(nuCausal);

            return nuClassCausal;
        }

        private void ugInternalItemLega_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void openFlagAppWarr_CheckedChanged(object sender, EventArgs e)
        {
            if (openFlagAppWarr.CheckState == CheckState.Checked)
            {
                TabItems.Tabs[0].Enabled = true;
                TabItems.Tabs[1].Enabled = true;
            }
            else if (openFlagAppWarr.CheckState == CheckState.Indeterminate)
            {
                TabItems.Tabs[0].Enabled = false;
                TabItems.Tabs[1].Enabled = false;
            }
            else
            {
                TabItems.Tabs[0].Enabled = true;
                TabItems.Tabs[1].Enabled = true;
            }
        }




    }
}
