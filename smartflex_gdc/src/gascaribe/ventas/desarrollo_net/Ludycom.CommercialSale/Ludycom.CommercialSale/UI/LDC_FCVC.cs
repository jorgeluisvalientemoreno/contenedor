using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Ludycom.CommercialSale.Entities;
using Ludycom.CommercialSale.BL;
using OpenSystems.Common.Util;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace Ludycom.CommercialSale.UI
{
    public partial class LDC_FCVC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLLDC_FCVC blLDC_FCVC = new BLLDC_FCVC();
        Int64 yesAplica;

        public static OperationType QuotationMode;
        public static Decimal certificationIVA;
        public static Decimal chargeByConnIVA;
        public static Decimal internalConnIVA;
        public static Double AIUpercentage;
        public static Decimal valueToMultiplyIVA;

        private List<LovItem> QuotationStatusList = new List<LovItem>();
        private List<ItemCostList> itemsCostList;
        private List<QuotationItem> itemToDeleteList = new List<QuotationItem>();
        private List<QuotationTaskType> taskTypeToDeleteList = new List<QuotationTaskType>();

        List<Keys> notValidKeys;

        private Int64 nuSubscriberId;
        private Int64? nuQuotationId;

        private DateTime? nullDateValue = null;
        private Int64? int64NullValue = null;

        private CustomerBasicData customerBasicData;
        private QuotationBasicData quotationBasicData;
        private QuotationBasicData originalQuotation;
        private ItemCostList selectedItem;

        private OpenGridDropDown itemsDropDown = null;

        private static String internalConnActIsNotSelectedMessage = "Debe especificar la actividad de instalación interna para agregar ítems";
        private static String chargConnActIsNotSelectedMessage = "Debe especificar la actividad de cargo por conexión para agregar ítems";
        private static String inspectionActIsNotSelectedMessage = "Debe especificar la actividad de inspección/certificación para agregar ítems";

        //Caso 200-1640
        Boolean inicio;

        //Inicio OSF-1492 Variables AIU
        public static Double AIUpercentageMax;
        public static Double AIUpercentageMin;
        //Fin OSF-1492 Variables AIU

        //Inicio OSF-3104
        public Boolean blExisteCategoriaIndsutrial;
        //Fin OSF-3104

        public LDC_FCVC(Int64 nuCode)
        {
            //Caso 200-2000
            yesAplica = blLDC_FCVC.AplicaEntrega(Constants.ENTREGA_200_2000);
            //Caso 200-1640
            inicio = true;

            InitializeComponent();

            InitializeData();

            //Se cargan los datos de acuerdo a la operación a realizar
            if (QuotationMode == OperationType.Register)
            {
                InitializeDataForQuotationRegister(nuCode);
            }
            else
            {
                InitializeDataForQuotationModification(nuCode);
            }

            enablePrintButton();

            enableSendOSFButton();
            
            disableSaveButton();

            enableDiscount();

            //Caso 200-1640
            inicio = false;
        }

        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación   
        /// 17-01-2018  Daniel Valiente        2 - se agrego las rutinas de carga de la lista de contratista constructores y se quito las referencias a items de la grilla para que no cargue por defecto con la lista indicada originalmente. esta lista sera cargada dinamicamente en el aplicativo. Caso 200-1640
        /// </changelog>
        public void InitializeData()
        {
            quotationBasicData = new QuotationBasicData();
            
            itemToDeleteList = new List<QuotationItem>();

            bsChargeByConnItems.DataSource = quotationBasicData.ChargeByConnTaskType.ItemsList;
            bsInternalConn.DataSource = quotationBasicData.InternalConnTaskType.ItemsList;
            bsCertification.DataSource = quotationBasicData.CertificationTaskType.ItemsList;
            bsQuotedTaskType.DataSource = quotationBasicData.TaskTypeList;

            //Lista de Valores para el Tipo de Identificación
            fillGenericCombo(ocIdentificationType, BLGeneralQueries.strIdentificationType);

            //Lista de Valores para los Departamentos
            fillGenericCombo(cbFatherLocation, BLGeneralQueries.strGeoFatherLocation);

            //Lista de Valores para las Localidades
            fillGenericCombo(cbLocation, BLGeneralQueries.strGeolocation);

            //Lista de Valores para categoría
            fillGenericCombo(cbCategory, BLGeneralQueries.strCategory);

            //Lista de Valores para subcategoría
            fillGenericCombo(cbSubcategory, BLGeneralQueries.strSubcategory);

            /*CA 200-2000*/
            //Lista de Valores para los sector comercial
            fillGenericCombo(cbSectorOperativo, BLGeneralQueries.strSectorOperativo);

            //Lista de Valores para los unidad opetariva de venta 
            fillGenericCombo(cbUnidadOperativa, BLGeneralQueries.strUnidadOperativa);

            //Se carga lista de estados de la cotización
            QuotationStatusList.Clear();
            QuotationStatusList.Add(new LovItem(Constants.QUOTATION_REGISTERED, "Registrada"));
            QuotationStatusList.Add(new LovItem(Constants.QUOTATION_SEND_TO_OSF, "Enviada a OSF"));
            QuotationStatusList.Add(new LovItem(Constants.QUOTATION_APROVED, "Aprobada"));

            cbQuotationStatus.DataSource = QuotationStatusList;
            cbQuotationStatus.ValueMember = "Id";
            cbQuotationStatus.DisplayMember = "Description";

            //Se cargan los IVA
            internalConnIVA = Convert.ToDecimal(utilities.getParameterValue(Constants.INTERNAL_CON_IVA_PARAM, "Int64"));
            certificationIVA = Convert.ToDecimal(utilities.getParameterValue(Constants.CERTIFICATION_IVA_PARAM, "Int64"));
            chargeByConnIVA = Convert.ToDecimal(utilities.getParameterValue(Constants.CHARGE_BY_CON_IVA_PARAM, "Int64"));
            valueToMultiplyIVA = Convert.ToDecimal(utilities.getParameterValue(Constants.PERC_AIU_FOR_IVA, "Int64")); 
            
            //Se carga el porcentaje de AIU
            AIUpercentage = Convert.ToDouble(utilities.getParameterValue(Constants.COMMERCIAL_AIU_PARAM, "Int64"));

            //Se cargan las actividades del cargo por conexión
            List<ActivityTaskType> chargConnActivityList = blLDC_FCVC.GetActivitiesByTaskType(BLGeneralQueries.strChargeByConnActivities);
            fillComboByList(cbChargeByConnActivity, chargConnActivityList, ActivityTaskType.ACTIVITY_DESCRIPTION_KEY, ActivityTaskType.ACTIVITY_KEY);

            cbChargeByConnActivity.DisplayLayout.Bands[0].Columns[ActivityTaskType.DISCOUNT_CONCEPT_KEY].Hidden = true;

            //Se cargan las actividades de la instalación interna
            List<ActivityTaskType> internalConnActivityList = blLDC_FCVC.GetActivitiesByTaskType(BLGeneralQueries.strInternalConnActivities);
            fillComboByList(cbInternalConnActivity, internalConnActivityList, ActivityTaskType.ACTIVITY_DESCRIPTION_KEY, ActivityTaskType.ACTIVITY_KEY);

            cbInternalConnActivity.DisplayLayout.Bands[0].Columns[ActivityTaskType.DISCOUNT_CONCEPT_KEY].Hidden = true;

            //Se cargan las actividades de la certificación
            List<ActivityTaskType>  certificationActivityList = blLDC_FCVC.GetActivitiesByTaskType(BLGeneralQueries.strCertificationActivities);
            fillComboByList(cbCertifActivity, certificationActivityList, ActivityTaskType.ACTIVITY_DESCRIPTION_KEY, ActivityTaskType.ACTIVITY_KEY);

            cbCertifActivity.DisplayLayout.Bands[0].Columns[ActivityTaskType.DISCOUNT_CONCEPT_KEY].Hidden = true;

            defineNotValidKeys();

            //se bloquea esta lista
            /*itemsDropDown = new OpenGridDropDown();
            itemsCostList = blLDC_FCVC.getValidItems(-1);
            itemsDropDown.DataSource = itemsCostList;
            itemsDropDown.ValueMember = ItemCostList.UNIQUE_ITEM_KEY;
            itemsDropDown.DisplayMember = ItemCostList.ITEM_DESCRIPTION_KEY;
            
            itemsDropDown.Parent = this;

            setUpDropDown(itemsDropDown);

            setValueListToGridColumn(ugChargeByConnItems, "Description", itemsDropDown);
            setValueListToGridColumn(ugInternalConnItems, "Description", itemsDropDown);
            setValueListToGridColumn(ugCertificationItems, "Description", itemsDropDown);

            itemsDropDown.RowSelected += new RowSelectedEventHandler(itemsList_RowSelected);*/

            //lista de valores para Contratistas de Construcciones. Caso 200-1640
            fillCursorCombo(cbx_contractors, BLGeneralQueries.queryContractors);

            //Inicio Constantes OSF-1492 Validar Porcentaje AIU
            AIUpercentageMax = blLDC_FCVC.numeroParametro("PORCENTAJE_MAXIMO_AIU_FCVC"); //25;
            AIUpercentageMin = blLDC_FCVC.numeroParametro("PORCENTAJE_MINIMO_AIU_FCVC"); //10;
            tbAIU.TextBoxValue = Convert.ToString(AIUpercentage);
            tbAIU.Enabled = false;
            //Fin Constantes OSF-1492 Validar Porcentaje AIU

        }

        private void itemsList_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (sender!=null)
            {
                UltraDropDown dropDown = (UltraDropDown)sender;

                if (dropDown.SelectedRow!=null)
                {
                    ItemCostList tmpSelectedItem = dropDown.SelectedRow.ListObject as ItemCostList;
                    selectedItem = itemsCostList.Find(delegate(ItemCostList il) { return il.ItemId == tmpSelectedItem.ItemId && il.ListId == tmpSelectedItem.ListId; });
                }
            }
        }

        /// <summary>
        /// Se llena combobox genérico
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void fillGenericCombo(OpenCombo targetCombo, String query)
        {
            DataTable dtGeneric = utilities.getListOfValue(query);
            targetCombo.DataSource = dtGeneric;
            targetCombo.ValueMember = "CODIGO";
            targetCombo.DisplayMember = "DESCRIPCION";
        }


        /// <summary>
        /// Se llena combo basado en lista genérica
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void fillComboByList<T>(OpenCombo targetCombo, List<T> sourceList, String displayMember, String valueMember)
        {
            targetCombo.DataSource = sourceList;
            targetCombo.DisplayMember = displayMember;
            targetCombo.ValueMember = valueMember;
        }

        /// <summary>
        /// Se define la lista de valores para la columna de la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
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
        /// 17-01-2018  Daniel Valiente        
        private void delValueListToGridColumn()
        {
            while (ugChargeByConnItems.Rows.Count > 0)
            {
                ugChargeByConnItems.Rows[0].Activate();
                deleteItemFromSource(bsChargeByConnItems, ugChargeByConnItems);
            }
            while (ugInternalConnItems.Rows.Count > 0)
            {
                ugInternalConnItems.Rows[0].Activate();
                deleteItemFromSource(bsInternalConn, ugInternalConnItems);
            }
            while (ugCertificationItems.Rows.Count > 0)
            {
                ugCertificationItems.Rows[0].Activate();
                deleteItemFromSource(bsCertification, ugCertificationItems);
            }
        }

        /// <summary>
        /// Se establecen propiedades para lista desplegable
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void setUpDropDown(OpenGridDropDown dropDown)
        {
            dropDown.DisplayLayout.Bands[0].Columns[ItemCostList.COST_SALE_KEY].Format = Constants.CURRENCY_FORMAT;
            dropDown.DisplayLayout.Bands[0].Columns[ItemCostList.ITEM_DESCRIPTION_KEY].Width = 350;
            dropDown.DisplayLayout.Bands[0].Columns[ItemCostList.LIST_DESCRIPTION_KEY].Width = 350;
            dropDown.DisplayLayout.Bands[0].Columns[ItemCostList.UNIQUE_ITEM_KEY].Hidden = true;
        }

        /// <summary>
        /// Se definen los filtros a la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void setGridFilters()
        {
            this.ugQuotedTaskType.DisplayLayout.Bands[0].ColumnFilters[QuotationTaskType.OPTION_KEY].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.NotEquals, Constants.DELETE_OPTION);
        }


        /// <summary>
        /// Se habilita el botón imprimir
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void enablePrintButton()
        {
            if (quotationBasicData.Consecutive.HasValue)
            {
                btnPrint.Enabled = true;
                if (yesAplica == 1)
                {
                    btnPrintPreCupCot.Enabled = true;
                }
                else
                {
                    btnPrintPreCupCot.Hide();
                }
            }
        }

        /// <summary>
        /// Se habilita el botón Enviar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void enableSendOSFButton()
        {
            if (quotationBasicData.Status == Constants.QUOTATION_REGISTERED && quotationBasicData.Consecutive.HasValue)
            {
                btnSendToOSF.Enabled = true;
            }
        }

        /// <summary>
        /// Se inhabilita el botón Enviar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void disableSaveButton()
        {
            if (quotationBasicData.Status == Constants.QUOTATION_APROVED)
            {
                btnSave.Enabled = false;
            }
        }

        /// <summary>
        /// Se actualizan los datos de la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void refreshGrid(BindingSource source, UltraGrid ultraGrid)
        {
            source.ResetBindings(false);
            ultraGrid.Rows.Refresh(RefreshRow.ReloadData);
        }

        /// <summary>
        /// Se inicializan los datos para registro de cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeDataForQuotationRegister(Int64 subscriberId)
        {
            nuSubscriberId = subscriberId;

            //Inicializa la fecha de registro
            tbRegisterDate.TextBoxObjectValue = OpenDate.getSysDateOfDataBase();

            //Se cargan datos del cliente
            LoadCustomerBasicData(subscriberId);

            //Se inicializa el estado de la cotización
            cbQuotationStatus.Value = Constants.QUOTATION_REGISTERED;

            calcSummaryQuotation();

            //TODO: Se debe definir la obtención del contrato y del producto
        }

        /// <summary>
        /// Se inicializan los datos para modificación de cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeDataForQuotationModification(Int64 quotationId)
        {
            nuQuotationId = quotationId;

            //Se valida si cotización existe
            if (!blLDC_FCVC.QuotationExists(quotationId))
            {
                utilities.DisplayErrorMessage("La cotización con código " + quotationId + " no existe en el sistema");
                return;
            }

            //Caso 200-1640
            //12.07.18
            //String onuErrorCode = "";
            //String osbErrorMessage = "";
            //blLDC_FCVC.proCargaComercial(quotationId, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
            //

            //Se obtiene el cliente de la cotización
            nuSubscriberId = blLDC_FCVC.GetQuotationCustomer(nuQuotationId);

            //Se cargan datos del cliente
            LoadCustomerBasicData(nuSubscriberId);

            //Se cargan los datos básicos de la cotización
            LoadQuotationBasicData(quotationId);

            //Se cargan los tipos de trabajo cotizados
            LoadQuotationTaskType();

            //Caso 200-1640

            inicio = false;

            Int64 onuContratista;
            Int64 onuOperatingUnit;
            Int64 onuErrorCode;
            String osbErrorMessage;
            blLDC_FCVC.proCargaComercial(quotationId, out onuContratista, out onuOperatingUnit, out onuErrorCode, out osbErrorMessage);

            //Contratista
            if (onuContratista != 0)
            {
                for (int i = 0; i <= cbx_contractors.Rows.Count - 1; i++)
                {
                    if (cbx_contractors.Rows[i].Cells[0].Value.ToString() == onuContratista.ToString())
                    {
                        cbx_contractors.SelectedRow = cbx_contractors.Rows[i];
                    }
                }
                //cbx_contractors.Enabled = false;
            }
            codContractors = onuContratista;
            //
            //Unidad
            if (onuOperatingUnit == 0)
            {
                onuOperatingUnit = Int64.Parse(blLDC_FCVC.getParam(BLGeneralQueries.dummyUnitWork, "Int64").ToString());
                fillCursorCombo(cbx_workunit, "", "", "", "", true, onuOperatingUnit.ToString());
                cbx_workunit.SelectedRow = cbx_workunit.Rows[0];
                //
                cbx_workunit.Enabled = false;
                pn_bloque1.Enabled = false;
                //pncontpn1.Enabled = false;
                cbChargeByConnActivity.Enabled = false;
                chkApplyDiscountChargeConn.Enabled = false;
                bnChargeByConnItemsAddNewItem.Enabled = false;
                bnChargeByConnItemsDeleteItem.Enabled = false;
                bloquearColumnas(ugChargeByConnItems);
                //pncontpn2.Enabled = false;
                cbInternalConnActivity.Enabled = false;
                chkApplyDiscountInternConn.Enabled = false;
                bnInternalConnItemsAddNewItem.Enabled = false;
                bnInternalConnDeleteItem.Enabled = false;
                bloquearColumnas(ugInternalConnItems);
                //pncontpn3.Enabled = false;
                cbCertifActivity.Enabled = false;
                chkApplyDiscountCertification.Enabled = false;
                bnCertificationItemsAddNewItem.Enabled = false;
                bnCertificationItemsDeleteItem.Enabled = false;
                bloquearColumnas(ugCertificationItems);
                //
                btnSave.Enabled = false;
                //btnSendToOSF.Enabled 
            }
            else
            {
                for (int i = 0; i <= cbx_workunit.Rows.Count - 1; i++)
                {
                    if (cbx_workunit.Rows[i].Cells[0].Value.ToString() == onuOperatingUnit.ToString())
                    {
                        cbx_workunit.SelectedRow = cbx_workunit.Rows[i];
                    }
                }
            }
            codUnitWork = onuOperatingUnit.ToString();

            inicio = true;

            //

            //Se cargan los ítems por clasificación de tipo de trabajo
            LoadItemsPerTaskTypeClass(Constants.CHARGE_BY_CON_CLASS, bsChargeByConnItems);
            LoadItemsPerTaskTypeClass(Constants.INTERNAL_CON_CLASS, bsInternalConn);
            LoadItemsPerTaskTypeClass(Constants.CERTIFICATION_CLASS, bsCertification);

            if (quotationBasicData.Status == Constants.QUOTATION_SEND_TO_OSF)
            {
                //tbAddress.ReadOnly = true;
                //cbx_contractors.Enabled = false;
            }

            calcSummaryQuotation();

            if (yesAplica == 0)
            {
                cbSectorOperativo.Hide();
                cbFormulario.Hide();
                cbNuOrdSolicitudRed.Hide();
                cbUnidadOperativa.Hide();
            }
        }

        public void bloquearColumnas(UltraGrid grilla)
        {
            foreach (UltraGridColumn columna in grilla.DisplayLayout.Bands[0].Columns)
            {
                columna.CellActivation = Activation.NoEdit;
            }
        }


        public void enableDiscount()
        {       
            chkApplyDiscountChargeConn.AutoCheck = false;
            chkApplyDiscountInternConn.AutoCheck = false;
            chkApplyDiscountCertification.AutoCheck = false;
            chkApplyDiscountChargeConn.Hide();
            chkApplyDiscountInternConn.Hide();
            chkApplyDiscountCertification.Hide();

            String aplicaDescuento = blLDC_FCVC.getParam("LDCPARPESTDESCUTCOT", "String").ToString();
            string[] split = aplicaDescuento.Split(new Char[] { ',' });
            foreach (string s in split)
            {
                if (s.Trim() == Constants.CHARGE_BY_CON_CLASS)
                {
                    chkApplyDiscountChargeConn.Show();
                }
                if (s.Trim() == Constants.INTERNAL_CON_CLASS)
                {
                    chkApplyDiscountInternConn.Show();
                }
                if (s.Trim() == Constants.CERTIFICATION_CLASS)
                {
                    chkApplyDiscountCertification.Show();
                }
            }
        }
        #endregion

        #region DataLoad
        /// <summary>
        /// Se cargan los datos básicos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadCustomerBasicData(Int64 nuSubscriberCode)
        {
            //Se obtienen los datos básicos del cliente
            customerBasicData = blLDC_FCVC.GetCustomerBasicData(nuSubscriberCode);

            //Se setean los datos básicos del cliente en la pantalla
            ocIdentificationType.Value = customerBasicData.IdentificationType;
            tbCustomerIdentification.TextBoxValue = customerBasicData.Identification;
            tbCustomerName.TextBoxValue = customerBasicData.CustomerName;
            chkSpecialCustomer.Checked = customerBasicData.SpecialCustomer;
            tbSuscription.TextBoxValue = Convert.ToString(customerBasicData.Contract);
            tbProductId.TextBoxValue = Convert.ToString(customerBasicData.Product);
        }

        /// <summary>
        /// Se cargan los datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadQuotationBasicData(Int64 nuQuotationId)
        {
            //Se obtienen los datos básicos de la cotización
            quotationBasicData = blLDC_FCVC.GetQuotationBasicData(nuQuotationId);

            originalQuotation = new QuotationBasicData();
            originalQuotation = quotationBasicData;

            quotationBasicData.Customer = customerBasicData.Clone();

            //Se setean los datos básicos de la cotización
            this.nuQuotationId = quotationBasicData.Consecutive;
            //Inicio OSF-1492 - Realizar el cargue del AIU relacionado a al cotizacion            
            if (blLDC_FCVC.obtieneAIUQuotation(Convert.ToDouble(quotationBasicData.Consecutive)) != 0)
            {
                AIUpercentage = blLDC_FCVC.obtieneAIUQuotation(Convert.ToDouble(quotationBasicData.Consecutive));
                tbAIU.TextBoxValue = Convert.ToString(AIUpercentage);
            }
            else
            {
                tbAIU.TextBoxValue = Convert.ToString(AIUpercentage); //OSF-1492 Porcentaje AIU
            }
            //Fin OSF-1492
            tbQuotationConsecutive.TextBoxValue = Convert.ToString(quotationBasicData.Consecutive);
            cbQuotationStatus.Value = quotationBasicData.Status;
            tbQuotationValidityDate.TextBoxObjectValue = quotationBasicData.ValidityDate;
            tbAddress.Address_id = Convert.ToString(quotationBasicData.AddressId);
            tbDiscount.TextBoxValue = Convert.ToString(quotationBasicData.Discount);
            tbSalePackageId.TextBoxValue = Convert.ToString(quotationBasicData.SaleRequestId);
            tbQuotationPackageId.TextBoxValue = Convert.ToString(quotationBasicData.QuotationRequestId);
            tbComment.TextBoxValue = Convert.ToString(quotationBasicData.Comment);
            tbRegisterDate.TextBoxObjectValue = quotationBasicData.RegisterDate;
            tbModificationDate.TextBoxObjectValue = quotationBasicData.LastModDate;
            tbQuotedValue.TextBoxValue = Convert.ToString(quotationBasicData.QuotedValue);
            cbSectorOperativo.Value = quotationBasicData.OperatingSector;
            cbFormulario.TextBoxValue = Convert.ToString(quotationBasicData.NuFormulario);
            cbUnidadOperativa.Value = quotationBasicData.OperatingUnit;
            string cadenaNull;
            if (quotationBasicData.SolicitudRed == 0)
            {
                cadenaNull = "";
            }
            else
            {
                cadenaNull = Convert.ToString(quotationBasicData.SolicitudRed);
            }
            cbNuOrdSolicitudRed.TextBoxValue = cadenaNull;

            setBasicAddressData();
        }

        /// <summary>
        /// Se cargan las actividades con sus tipos de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        //public void LoadActivities()
        //{
        //    activitiesList = blLDC_FCVC.GetActivities();
        //}

        /// <summary>
        /// Se cargan los tipos de trabajo de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadQuotationTaskType()
        {
            quotationBasicData.TaskTypeList = blLDC_FCVC.GetQuotedTaskType(nuQuotationId);

            bsQuotedTaskType.DataSource = quotationBasicData.TaskTypeList;

            foreach (QuotationTaskType item in quotationBasicData.TaskTypeList)
            {
                if (item.TaskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
                {
                    cbChargeByConnActivity.Value = item.Activity;

                    if (item.ApplyDiscount)
                    {
                        chkApplyDiscountChargeConn.Checked = item.ApplyDiscount;
                    }

                    quotationBasicData.ChargeByConnTaskType = item;
                }

                if (item.TaskTypeClassif == Constants.INTERNAL_CON_CLASS)
                {
                    cbInternalConnActivity.Value = item.Activity;

                    if (item.ApplyDiscount)
                    {
                        chkApplyDiscountInternConn.Checked = item.ApplyDiscount;
                    }

                    quotationBasicData.InternalConnTaskType = item;
                }

                if (item.TaskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                    cbCertifActivity.Value = item.Activity;

                    if (item.ApplyDiscount)
                    {
                        chkApplyDiscountCertification.Checked = item.ApplyDiscount;
                    }

                    quotationBasicData.CertificationTaskType = item;
                }
            }
        }

        /// <summary>
        /// Se cargan los ítems por tipo de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadItemsPerTaskTypeClass(String taskTypeClass, BindingSource originBindingSource)
        {
            if (taskTypeClass == Constants.CHARGE_BY_CON_CLASS)
            {
                quotationBasicData.ChargeByConnTaskType.ItemsList = blLDC_FCVC.GetItemsByTaskType(nuQuotationId, taskTypeClass);
                originBindingSource.DataSource = quotationBasicData.ChargeByConnTaskType.ItemsList;
            }
            else if (taskTypeClass == Constants.INTERNAL_CON_CLASS)
            {
                quotationBasicData.InternalConnTaskType.ItemsList = blLDC_FCVC.GetItemsByTaskType(nuQuotationId, taskTypeClass);
                originBindingSource.DataSource = quotationBasicData.InternalConnTaskType.ItemsList;
            }
            else if (taskTypeClass == Constants.CERTIFICATION_CLASS)
            {
                quotationBasicData.CertificationTaskType.ItemsList = blLDC_FCVC.GetItemsByTaskType(nuQuotationId, taskTypeClass);
                originBindingSource.DataSource = quotationBasicData.CertificationTaskType.ItemsList;
            }
        }
        #endregion

        #region Dataset
        /// <summary>
        /// Método para setear datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void setQuotationBasicData()
        {
            quotationBasicData.Consecutive = nuQuotationId;
            quotationBasicData.AddressId = (tbAddress.Address_id == "" ? int64NullValue : Convert.ToInt64(tbAddress.Address_id));
            quotationBasicData.QuotedValue = String.IsNullOrEmpty(tbQuotedValue.TextBoxValue)? 0 : Convert.ToDecimal(tbQuotedValue.TextBoxValue);
            quotationBasicData.Comment = tbComment.TextBoxValue;
            quotationBasicData.Discount = String.IsNullOrEmpty(tbDiscount.TextBoxValue) ? 0 : Convert.ToDecimal(tbDiscount.TextBoxValue);
            quotationBasicData.ValidityDate = String.IsNullOrEmpty(Convert.ToString(tbQuotationValidityDate.TextBoxObjectValue)) ? nullDateValue : Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue);
            quotationBasicData.OperatingSector = String.IsNullOrEmpty(Convert.ToString(cbSectorOperativo.Value)) ? 0 : Convert.ToInt64(cbSectorOperativo.Value);
            quotationBasicData.NuFormulario = String.IsNullOrEmpty(cbFormulario.TextBoxValue) ? 0 : Convert.ToInt64(cbFormulario.TextBoxValue);
            quotationBasicData.OperatingUnit = String.IsNullOrEmpty(Convert.ToString(cbUnidadOperativa.Value)) ? 0 : Convert.ToInt64(cbUnidadOperativa.Value);
            quotationBasicData.SolicitudRed = Convert.ToInt64(cbNuOrdSolicitudRed.TextBoxValue);

            defineDiscountPercentage();
        }

        private void defineDiscountPercentage()
        {
            if (quotationBasicData.Discount > 0)
            {
                QuotationTaskType tmpTaskType = quotationBasicData.TaskTypeList.Find(delegate(QuotationTaskType tt) { return tt.ApplyDiscount == true; });

                if (tmpTaskType == null)
                {
                    quotationBasicData.Discount = 0;
                }
            }
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
        /// 01-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean fieldsAreValid(ValidationArea validationArea)
        {
            if (validationArea == ValidationArea.toSendOSFData)
            {
                if (String.IsNullOrEmpty(tbComment.TextBoxValue.Trim()))
                {
                    utilities.DisplayErrorMessage("Debe ingresar la observación");
                    return false;
                }

                if (String.IsNullOrEmpty(tbAddress.Address_id))
                {
                    utilities.DisplayErrorMessage("Debe ingresar la dirección");
                    return false;
                }

                if (String.IsNullOrEmpty(tbQuotationValidityDate.TextBoxValue))
                {
                    utilities.DisplayErrorMessage("Debe ingresar la fecha de vigencia");
                    return false;
                }

                if (!String.IsNullOrEmpty(tbQuotationValidityDate.TextBoxValue))
                {
                    if (Convert.ToDateTime(tbQuotationValidityDate.TextBoxValue).Date < OpenDate.getSysDateOfDataBase().Date)
                    {
                        utilities.DisplayErrorMessage("La fecha de vigencia debe ser mayor a la fecha actual");
                        return false;
                    }
                }

                if (yesAplica == 1)
                {
                    if (cbSectorOperativo.Value == null)
                    {
                        utilities.DisplayErrorMessage("Debe seleccionar un sector comercial");
                        return false;
                    }

                    if (String.IsNullOrEmpty(cbFormulario.TextBoxValue) || Convert.ToInt64(cbFormulario.TextBoxValue) <= 0)
                    {
                        utilities.DisplayErrorMessage("Debe ingresar el numero del formulario");
                        return false;
                    }

                    if (cbUnidadOperativa.Value == null)
                    {
                        utilities.DisplayErrorMessage("Debe ingresar una unidad operativa de venta");
                        return false;
                    }
                }
            }

            if (validationArea == ValidationArea.BasicData || validationArea == ValidationArea.AllData)
            {
                if (!(Convert.ToInt64(cbChargeByConnActivity.Value) > 0) && !(Convert.ToInt64(cbInternalConnActivity.Value) > 0) && !(Convert.ToInt64(cbCertifActivity.Value) > 0))
                {
                    utilities.DisplayErrorMessage("Faltan datos requeridos, no ha seleccionado la actividad del tipo de trabajo a cotizar");
                    return false;
                }

                if (String.IsNullOrEmpty(tbComment.TextBoxValue.Trim()))
                {
                    utilities.DisplayErrorMessage("Debe ingresar la observación");
                    return false;
                }

                if (!String.IsNullOrEmpty(tbQuotationValidityDate.TextBoxValue))
                {
                    if (Convert.ToDateTime(tbQuotationValidityDate.TextBoxValue).Date < OpenDate.getSysDateOfDataBase().Date)
                    {
                        utilities.DisplayErrorMessage("La fecha de vigencia debe ser mayor a la fecha actual");
                        return false;
                    }
                }

                if (yesAplica == 1)
                {
                    if (cbSectorOperativo.Value == null)
                    {
                        utilities.DisplayErrorMessage("Debe seleccionar un sector comercial");
                        return false;
                    }

                    if (String.IsNullOrEmpty(cbFormulario.TextBoxValue) || Convert.ToInt64(cbFormulario.TextBoxValue) <= 0)
                    {
                        utilities.DisplayErrorMessage("Debe ingresar el numero del formulario");
                        return false;
                    }

                    if (cbUnidadOperativa.Value == null)
                    {
                        utilities.DisplayErrorMessage("Debe seleccionar un sector comercial");
                        return false;
                    }
                }
            }

            if (validationArea == ValidationArea.AllData || validationArea == ValidationArea.ItemsData) 
            {
                if ((Convert.ToInt64(cbChargeByConnActivity.Value) > 0 & !taskTypeHasItems(bsChargeByConnItems)))
                {
                    utilities.DisplayErrorMessage("Faltan datos requeridos. Debe ingresar los ítems que se cotizarán para el cargo por conexión");
                    return false;
                }

                if ((Convert.ToInt64(cbInternalConnActivity.Value) > 0 & !taskTypeHasItems(bsInternalConn)))
                {
                    utilities.DisplayErrorMessage("Faltan datos requeridos. Debe ingresar los ítems que se cotizarán para la instalación interna");
                    return false;
                }

                if ((Convert.ToInt64(cbCertifActivity.Value) > 0 & !taskTypeHasItems(bsCertification)))
                {
                    utilities.DisplayErrorMessage("Faltan datos requeridos. Debe ingresar los ítems que se cotizarán para la certificación");
                    return false;
                }
            }

            if (validationArea == ValidationArea.ItemsData || validationArea == ValidationArea.AllData)
            {
                if (!itemsAreValid(bsChargeByConnItems))
                {
                    return false;
                }
                else if (!itemsAreValid(bsInternalConn))
                {
                    return false;
                }
                else if (!itemsAreValid(bsCertification))
	            {
                    return false;
	            }
            }

            return true;
        }


        /// <summary>
        /// Método para verificar si los ítems son válidos
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 01-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean itemsAreValid(BindingSource source)
        {
            List<QuotationItem> itemList = source.List as List<QuotationItem>;

            QuotationItem item = itemList.Find(delegate(QuotationItem i) { return i.SaleCost == 0; });

            if (item!=null)
            {
                utilities.DisplayErrorMessage("El costo de venta de los ítems debe ser mayor a cero");
                return false;
            }

            item = itemList.Find(delegate(QuotationItem i) { return i.Amount == 0; });

            if (item != null)
            {
                utilities.DisplayErrorMessage("La cantidad de los ítems debe ser mayor a cero");
                return false;
            }

            return true;
        }


        /// <summary>
        /// Método para validar si fueron seleccionados los items a cotizar por tipo de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 01-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean taskTypeHasItems(BindingSource source)
        {
            List<QuotationItem> itemList = (List<QuotationItem>)source.DataSource;

            QuotationItem item = itemList.Find(delegate(QuotationItem i) {return i.Option != Constants.DELETE_OPTION; });

            if (item != null)
	        {
                return true;
	        }

            return false;
        }

        /// <summary>
        /// Método para validar si fueron seleccionados los items a cotizar por tipo de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 01-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean taskTypeHasItems(List<QuotationItem> itemList)
        {
            QuotationItem item = itemList.Find(delegate(QuotationItem i) { return i.Option != Constants.DELETE_OPTION; });

            if (item != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Método para validar si cambiaron los datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool quotationBasicDataChanged()
        {
            bool result = false;

            if (originalQuotation.QuotedValue != Convert.ToDecimal(tbQuotedValue.TextBoxValue))
            {
                return result = true;
            }

            if (originalQuotation.Comment != tbComment.TextBoxValue)
            {
                return result = true;
            }

            if (originalQuotation.ValidityDate != Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue))
            {
                return result = true;
            }

            if (originalQuotation.Discount != Convert.ToDecimal(tbDiscount.TextBoxValue))
            {
                return result = true;
            }

            if (originalQuotation.AddressId != (tbAddress.Address_id == "" ? int64NullValue : Convert.ToInt64(tbAddress.Address_id)))
            {
                return result = true;
            }

            if (yesAplica == 1)
            {
                if (originalQuotation.OperatingSector != Convert.ToInt64(cbSectorOperativo.Value))
                {
                    return result = true;
                }
            
                if (originalQuotation.NuFormulario != Convert.ToInt64(cbFormulario.TextBoxValue))
                {
                    return result = true;
                }

                if (originalQuotation.SolicitudRed != Convert.ToInt64(cbNuOrdSolicitudRed.TextBoxValue))
                {
                    return result = true;
                }

                if (originalQuotation.OperatingUnit != Convert.ToInt64(cbUnidadOperativa.Value))
                {
                    return result = true;
                }
            }


            return result;
        }

        /// <summary>
        /// Método para validar si cambio la marcación de cliente especial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 03-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean specialCustomerChanged()
        {
            Boolean result = false;

            if (QuotationMode == OperationType.Modification)
            {
                if (quotationBasicData.Customer.SpecialCustomer != chkSpecialCustomer.Checked)
                {
                    return true;
                }
            }
            else
            {
                if (customerBasicData.SpecialCustomer != chkSpecialCustomer.Checked)
                {
                    return true;
                }
            }

            return result;
        }

        private Boolean itemsDataChange()
        {
            if (itemToDeleteList.Count>0)
            {
                return true;
            }
            else 
            {

                if (quotationBasicData.ChargeByConnTaskType.ItemsList.Exists(delegate(QuotationItem i) { return i.Option != Constants.NONE_OPTION; }))
                {
                    return true;
                }

                if (quotationBasicData.InternalConnTaskType.ItemsList.Exists(delegate(QuotationItem i) { return i.Option != Constants.NONE_OPTION; }))
                {
                    return true;
                }

                if (quotationBasicData.CertificationTaskType.ItemsList.Exists(delegate(QuotationItem i) { return i.Option != Constants.NONE_OPTION; }))
                {
                    return true;
                }
            }

            return false;
        }

        private void updateQuotedTaskType(UltraGridRow selectedValue, String taskTypeClassif)
        {
            if (selectedValue!=null)
            {
                ActivityTaskType tmpActivitySelected = selectedValue.ListObject as ActivityTaskType;
                QuotationTaskType tmpSummaryQuotation = quotationBasicData.TaskTypeList.Find(delegate(QuotationTaskType sq) { return sq.TaskTypeClassif == taskTypeClassif && sq.Option != Constants.DELETE_OPTION; });

                if (tmpSummaryQuotation==null)
                {
                    QuotationTaskType s = (QuotationTaskType)bsQuotedTaskType.AddNew();
                    s.TaskType = tmpActivitySelected.TaskType;
                    s.Activity = tmpActivitySelected.Activity;
                    s.TaskTypeDesc = tmpActivitySelected.TaskTypeDescription;
                    s.TaskTypeClassif = taskTypeClassif;
                    s.Iva = getIvaPercentageByTaskTypeClass(taskTypeClassif);
                    refreshGrid(bsQuotedTaskType, ugQuotedTaskType);
                }
                else
                {
                    tmpSummaryQuotation.Activity = tmpActivitySelected.Activity;
                    tmpSummaryQuotation.TaskType = tmpActivitySelected.TaskType;
                    tmpSummaryQuotation.Iva = getIvaPercentageByTaskTypeClass(taskTypeClassif);
                    tmpSummaryQuotation.TaskTypeDesc = tmpActivitySelected.TaskTypeDescription;
                    setUpdateStatusToTaskType(tmpSummaryQuotation);
                    BindingSource source = getSourceByTaskTypeClass(taskTypeClassif);
                    updateItemsTaskType(source, tmpActivitySelected.TaskType, tmpActivitySelected.Activity, taskTypeClassif);
                }
            }
            else
            {
                removeTaskTypeFromSummary(taskTypeClassif);

                resetItemsByTaskTypeClass(taskTypeClassif);
            }
        }

        private BindingSource getSourceByTaskTypeClass(String taskTypeClass)
        {
            BindingSource source = new BindingSource();

            if (taskTypeClass == Constants.CHARGE_BY_CON_CLASS)
            {
                source = bsChargeByConnItems;
            }
            else if (taskTypeClass == Constants.INTERNAL_CON_CLASS)
            {
                source = bsInternalConn;   
            }
            else if (taskTypeClass == Constants.CERTIFICATION_CLASS)
            {
                source = bsCertification;
            }

            return source;
        }

        private void updateItemsTaskType(BindingSource source, Int64 taskType, Int64 activity, String taskTypeClass)
        {
            foreach (QuotationItem item in source)
            {
                item.TaskType = taskType;
                item.ActivityId = activity;

                if (itemIsValidForUpdate(item))
                {
                    item.Option = Constants.UPDATE_OPTION;   
                }
            }

            refreshGridByTaskTypeClass(taskTypeClass);
        }

        private void refreshGridByTaskTypeClass(String taskTypeClass)
        {
            if (taskTypeClass == Constants.CHARGE_BY_CON_CLASS)
            {
                refreshGrid(bsChargeByConnItems, ugChargeByConnItems);
            }
            else if (taskTypeClass == Constants.INTERNAL_CON_CLASS)
            {
                refreshGrid(bsInternalConn, ugInternalConnItems);
            }
            else if (taskTypeClass == Constants.CERTIFICATION_CLASS)
            {
                refreshGrid(bsCertification, ugCertificationItems);
            }
        }

        private Decimal getIvaPercentageByTaskTypeClass(String taskTypeClassif)
        {
            Decimal iva = 0;

            if (taskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
            {
                iva = chargeByConnIVA;
            }
            else if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
            {
                iva = internalConnIVA;
            }
            else if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
            {
                iva = certificationIVA;
            }

            return iva;
        }

        /// <summary>
        /// Se elimina tipo de trabajo cotizado
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 27-10-2016
        private void removeTaskTypeFromSummary(String taskTypeClassif)
        {
            foreach (QuotationTaskType taskType in bsQuotedTaskType)
            {
                if (taskType.TaskTypeClassif == taskTypeClassif)
                {
                    if (taskType.Option != Constants.REGISTER_OPTION)
                    {
                        taskType.Option = Constants.DELETE_OPTION;
                        taskTypeToDeleteList.Add(taskType.Clone());
                    }
                    else
                    {
                        taskType.Option = Constants.DELETE_OPTION;
                    }
                }
            }

            quotationBasicData.TaskTypeList.RemoveAll(delegate(QuotationTaskType i) { return i.Option == Constants.DELETE_OPTION; });

            if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
            {
                chkApplyDiscountInternConn.Checked = false;
            }
            else if (taskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
            {
                chkApplyDiscountChargeConn.Checked = false;
            }
            else if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
            {
                chkApplyDiscountCertification.Checked = false;
            }

            refreshGrid(bsQuotedTaskType, ugQuotedTaskType);
        }

        /// <summary>
        /// Método para validar un item
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool validQuotationItem(UltraGrid ugQuotationRow)
        {
            bool result = true;

            if (ugQuotationRow.ActiveRow != null)
            {
                QuotationItem tmpQuotationItem = ugQuotationRow.ActiveRow.ListObject as QuotationItem;

                if (tmpQuotationItem.SaleCost <= 0)
                {
                    utilities.DisplayErrorMessage("El costo de venta del artículo debe ser mayor a cero");
                    result = false;
                }
                else if (tmpQuotationItem.Amount <=0)
                {
                    utilities.DisplayErrorMessage("La cantidad de artículos debe ser mayor a cero");
                    result = false;
                }
            }

            return result;
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
        /// 28-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean itemAlreadyExists(Object newItem, BindingSource source)
        {
           
            ItemCostList tmpNewItem = (ItemCostList)newItem;

            QuotationItem tmpCurrentItem = source.Current as QuotationItem;

            foreach (QuotationItem item in source)
            {
                //Caso 200-1640
                if (tmpNewItem.ItemId == item.ItemId && tmpNewItem.ListId == item.ListId && item.Option != Constants.DELETE_OPTION)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Método para marcar los ítems como borrados de acuerdo al tipo de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void resetItemsByTaskTypeClass(String taskTypeClassif)
        {
            if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
            {
                resetItems(bsInternalConn, ugInternalConnItems); 
            }
            else if (taskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
            {
                resetItems(bsChargeByConnItems, ugChargeByConnItems);
            }
            else if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
            {
                resetItems(bsCertification, ugCertificationItems);
            }

            calcSummaryQuotation();
        }

        /// <summary>
        /// Método para borrar marcar los ítems como borrados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void resetItems(BindingSource source, UltraGrid ultraGrid)
        {
            foreach (QuotationItem item in source)
            {
                if (item.Option != Constants.REGISTER_OPTION)
                {
                    item.Option = Constants.DELETE_OPTION;
                    itemToDeleteList.Add(item.Clone());
                }
                else
                {
                    item.Option = Constants.DELETE_OPTION;
                }
            }

            List<QuotationItem> list = (List<QuotationItem>)source.DataSource;

            list.RemoveAll(delegate(QuotationItem i) {return i.Option == Constants.DELETE_OPTION; });

            refreshGrid(source, ultraGrid);
        }

        private void deleteItem(QuotationItem item, BindingSource source)
        {
            // Historia de Modificaciones
            // Fecha       Autor                  Modificacion	
            // =========   =========              =====================================
            // 16-01-2020  HORBATH                CA88 Se adiciono el control TRY para permitir seguir el proceso de 
            //                                      eliminacion de items no existentes en las grillas 1, 2 y 3

            try
            {
                item.Option = Constants.DELETE_OPTION;
                itemToDeleteList.Add(item.Clone());

                List<QuotationItem> list = (List<QuotationItem>)source.DataSource;

                list.Remove(item);
            }
            catch (Exception error)
            { }
        }


        /// <summary>
        /// Se definen teclas no válidas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
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
        private void bnChargeByConnItemsAddNewItem_Click(object sender, EventArgs e)
        {

            //validacion de combos Caso 200-1640

            if (cbx_contractors.Value == null || cbx_workunit.Value == null)//(ugChargeByConnItems.DisplayLayout.Bands[0].Columns["Description"].ValueList == null)
            {
                utilities.DisplayInfoMessage("No puede Agregar un nuevo Item Hasta que no seleccione un Contratista y Unidad");
                return;
            }
            
            if (cbChargeByConnActivity.Value == null)
            {
                utilities.DisplayInfoMessage(chargConnActIsNotSelectedMessage);
                return;
            }

            this.bnChargeByConnItems.Focus();

            addItemToSource(bsChargeByConnItems, ugChargeByConnItems, Constants.CHARGE_BY_CON_CLASS, cbChargeByConnActivity.SelectedRow.ListObject as ActivityTaskType);
        }

        private void bnInternalConnItemsAddNewItem_Click(object sender, EventArgs e)
        {

            //validacion de combos Caso 200-1640

            if (cbx_contractors.Value == null || cbx_workunit.Value == null)//(ugChargeByConnItems.DisplayLayout.Bands[0].Columns["Description"].ValueList == null)
            {
                utilities.DisplayInfoMessage("No puede Agregar un nuevo Item Hasta que no seleccione un Contratista y Unidad");
                return;
            }
            
            if (cbInternalConnActivity.Value == null)
            {
                utilities.DisplayInfoMessage(internalConnActIsNotSelectedMessage);
                return;
            }

            this.bnInternalConnItems.Focus();

            addItemToSource(bsInternalConn, ugInternalConnItems, Constants.INTERNAL_CON_CLASS, cbInternalConnActivity.SelectedRow.ListObject as ActivityTaskType);
        }

        private void bnCertificationItemsAddNewItem_Click(object sender, EventArgs e)
        {

            //validacion de combos Caso 200-1640

            if (cbx_contractors.Value == null || cbx_workunit.Value == null)//(ugChargeByConnItems.DisplayLayout.Bands[0].Columns["Description"].ValueList == null)
            {
                utilities.DisplayInfoMessage("No puede Agregar un nuevo Item Hasta que no seleccione un Contratista y Unidad");
                return;
            }
            
            if (cbCertifActivity.Value == null)
            {
                utilities.DisplayInfoMessage(inspectionActIsNotSelectedMessage);
                return;
            }

            this.bnCertificationItems.Focus();

            addItemToSource(bsCertification, ugCertificationItems, Constants.CERTIFICATION_CLASS, cbCertifActivity.SelectedRow.ListObject as ActivityTaskType);
        }
        #endregion

        #region DeleteItems
        private void bnChargeByConnItemsDeleteItem_Click(object sender, EventArgs e)
        {
            deleteItemFromSource(bsChargeByConnItems, ugChargeByConnItems);
        }

        private void bnInternalConnDeleteItem_Click(object sender, EventArgs e)
        {
            deleteItemFromSource(bsInternalConn, ugInternalConnItems);
        }

        private void bnCertificationItemsDeleteItem_Click(object sender, EventArgs e)
        {
            deleteItemFromSource(bsCertification, ugCertificationItems);
        }
        #endregion

        #region SavingData
        /// <summary>
        /// Método para guardar los datos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 03-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void saveCustomerBasicData()
        {
            if (specialCustomerChanged())
            {
                CustomerBasicData c = quotationBasicData.Customer.Clone();

                c.SpecialCustomer = chkSpecialCustomer.Checked;

                if (QuotationMode == OperationType.Register)
                {
                    c.Id = nuSubscriberId;
                }

                blLDC_FCVC.MarkSpecialCustomer(c);
                c = null;
            }
        }

        /// <summary>
        /// Método para guardar datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void saveQuotationBasicData()
        {
            if (QuotationMode == OperationType.Register)
            {
                setQuotationBasicData();
                nuQuotationId = blLDC_FCVC.registerQuotationBasicData(quotationBasicData, nuSubscriberId);
                blLDC_FCVC.registerAIUQuotation(Convert.ToDouble(nuQuotationId),AIUpercentage);
            }
            else
            {
                if (quotationBasicDataChanged())
                {
                    setQuotationBasicData();
                    //MessageBox.Show("Solicitud de red: "+quotationBasicData.SolicitudRed.ToString());
                    blLDC_FCVC.modifyQuotationBasicData(quotationBasicData);
                    blLDC_FCVC.actualizaAIUQuotation(Convert.ToDouble(quotationBasicData.Consecutive), AIUpercentage);
                }
            }
        }

        /// <summary>
        /// Método para guardar datos de los tipos de trabajo cotizados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void saveQuotedTaskTypes()
        {
            deleteTaskType();

            Decimal discount = getDiscountPercentage();

            foreach (QuotationTaskType item in quotationBasicData.TaskTypeList)
            {
                if (!item.QuotationId.HasValue)
                {
                    item.QuotationId = nuQuotationId;
                }

                if (discount==0 && item.ApplyDiscount)
                {
                    item.ApplyDiscount = false;
                }

                if (item.Option == Constants.REGISTER_OPTION)
                {
                    blLDC_FCVC.registerQuotationTaskType(item);
                }
                else if (item.Option == Constants.UPDATE_OPTION)
                {
                    blLDC_FCVC.modifyQuotationTaskType(item);
                }
            }
        }

        /// <summary>
        /// Método para guardar datos de los items por tipo de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void saveItemsByTaskType(out Boolean findError)
        {
            deleteItems(out findError);
            if (!findError)
            {
                saveItems(bsInternalConn, out findError);
            }
            if (!findError)
            {
                saveItems(bsChargeByConnItems, out findError);
            }
            if (!findError)
            {
                saveItems(bsCertification, out findError);
            }
        }

        /// <summary>
        /// Método para borrar los tipos de trabajo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void deleteTaskType()
        {
            foreach (QuotationTaskType taskType in taskTypeToDeleteList)
            {
                 blLDC_FCVC.modifyQuotationTaskType(taskType);
            }
        }

        /// <summary>
        /// Método para borrar los ítems
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void deleteItems(out Boolean findError)
        {
            findError = false;
            foreach (QuotationItem item in itemToDeleteList)
            {
                if (blLDC_FCVC.ItemExists(item.Consecutive))
                {
                    blLDC_FCVC.modifyItem(item);
                    //Caso 200-1640
                    //16.07.18
                    //Aplicacion de servicios Ing Tapias
                    Int64 onuErrorCode = 0;
                    String osbErrorMessage = "";
                    Boolean error = false;
                    /*blLDC_FCVC.proEliminaComercialItem(item.Consecutive, out onuErrorCode, out osbErrorMessage);
                    MessageBox.Show("proEliminaComercialItem - " + item.Consecutive.ToString() + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        findError = true;
                    }*/
                    //Caso 200-1640
                    //16.07.18
                    String ClaseDesc = item.Description.Substring(item.Description.Length - 1, 1).ToString();
                    blLDC_FCVC.proActualizaComercialItem(item.Consecutive, item.ItemId, ClaseDesc, item.Option, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proActualizaComercialItem - " + item.Consecutive.ToString() + " - " + item.ItemId.ToString() + " - " + ClaseDesc + " - " + item.Option + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
            }
        }

        /// <summary>
        /// Método para guardar datos de los items
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void saveItems(BindingSource source, out Boolean findError)
        {
            //Caso 200-1640
            //16.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationId.ToString());
            String ClaseDesc = "";
            foreach (QuotationItem item in source)
            {
                if (!item.QuotationId.HasValue)
                {
                    item.QuotationId = nuQuotationId;
                }

                if (item.Option == Constants.REGISTER_OPTION)
                {
                    blLDC_FCVC.registerItem(item);
                    //Caso 200-1640
                    //16.07.18
                    ClaseDesc = "";
                    for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                    {
                        if (itemsDropDown.Rows[i].Cells[0].Value.ToString() + "_" + itemsDropDown.Rows[i].Cells[3].Value.ToString() == item.Description.ToString())
                        {
                            ClaseDesc = itemsDropDown.Rows[i].Cells[1].Value.ToString().Substring(itemsDropDown.Rows[i].Cells[1].Value.ToString().Length - 1, 1).ToString();
                        }
                    }
                    blLDC_FCVC.proRegistraComercialItem(InuPackageID, item.Consecutive, item.ItemId, ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraComercialItem - " + InuPackageID.ToString() + " - " + item.Consecutive.ToString() + " - " + item.ItemId.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else if (item.Option == Constants.UPDATE_OPTION)
                {
                    if (blLDC_FCVC.ItemExists(item.Consecutive))
                    {
                        blLDC_FCVC.modifyItem(item);
                        //Caso 200-1640
                        //16.07.18
                        ClaseDesc = item.Description.Substring(item.Description.Length - 1, 1).ToString();
                        if (ClaseDesc != "C" || ClaseDesc != "G")
                        {
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() + "_" + itemsDropDown.Rows[i].Cells[3].Value.ToString() == item.Description.ToString())
                                {
                                    ClaseDesc = itemsDropDown.Rows[i].Cells[1].Value.ToString().Substring(itemsDropDown.Rows[i].Cells[1].Value.ToString().Length - 1, 1).ToString();
                                }
                            }
                        }
                        blLDC_FCVC.proActualizaComercialItem(item.Consecutive, item.ItemId, ClaseDesc, item.Option, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaComercialItem - " + InuPackageID.ToString() + " - " + item.Consecutive.ToString() + " - " + item.ItemId.ToString() + " - " + ClaseDesc + " - " + item.Option + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                }
            }
            findError = error;
        }

        /// <summary>
        /// Método para enviar cotización a OSF
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 31-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void sendQuotationToOSF()
        {
            blLDC_FCVC.sendToOSF(quotationBasicData);
        }

        /// <summary>
        /// Se guardan los cambios
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void saveChanges(out Boolean findError)
        {
            findError = false;
            saveCustomerBasicData();
            saveQuotationBasicData();
            //
            //Caso 200-1640
            //16.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationId.ToString());
            Int64 InuOperatingUnit = Int64.Parse(cbx_workunit.Value.ToString());
            Int64 InuContratista = Int64.Parse(cbx_contractors.Value.ToString());

            if (QuotationMode == OperationType.Register)
            {
                blLDC_FCVC.proRegistraComercial(InuPackageID, InuContratista, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
                //MessageBox.Show("proRegistraComercial - " + InuPackageID.ToString() + " - " + InuContratista.ToString() + " - " + InuOperatingUnit.ToString() + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                if (onuErrorCode != 0)
                {
                    findError = true;
                }
            }
            else
            {
                blLDC_FCVC.proActualizaComercial(InuPackageID, InuContratista, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
                //MessageBox.Show("proActualizaComercial - " + InuPackageID.ToString() + " - " + InuContratista.ToString() + " - " + InuOperatingUnit.ToString() + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                if (onuErrorCode != 0)
                {
                    findError = true;
                }
            }
            //
            if (!findError)
            {
                saveQuotedTaskTypes();
                saveItemsByTaskType(out findError);
            }
        }
        #endregion

        #region ButtonsActions
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                calcSummaryQuotation();

                Boolean itemsChanged = itemsDataChange();

                if (fieldsAreValid(ValidationArea.AllData))
                {

                    //Caso 200-1640
                    //16/07/2018
                    Boolean findError = false;

                    if (quotationBasicData.Status == Constants.QUOTATION_SEND_TO_OSF)
                    {
                        if (blLDC_FCVC.HasFinancCondition(Convert.ToInt64(quotationBasicData.Consecutive)) && itemsChanged)
                        {
                            DialogResult continueResult = ExceptionHandler.DisplayMessage(
                                        2741,
                                        "Se actualizará los ítems de la cotización de OSF, por tanto se borrarán las condiciones de financiación que le hayan sido definidas. Desea continuar?",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question);

                            if (continueResult == DialogResult.No)
                            {
                                return;
                            }
                        }

                        saveChanges(out findError);
                        blLDC_FCVC.UpdateOSFQuotation(Convert.ToInt64(quotationBasicData.Consecutive), itemsChanged);
                    }
                    else
                    {
                        saveChanges(out findError);
                    }

                    if (!findError)
                    {
                        utilities.doCommit();
                    }
                    else
                    {
                        utilities.doRollback();
                        utilities.DisplayInfoMessage("Error al Tratar de Guadar/Actualizar la Cotizacion");
                        return;
                    }

                    if (QuotationMode == OperationType.Register)
                    {
                        utilities.DisplayInfoMessage("Se generó la cotización con consecutivo " + nuQuotationId);
                        this.Dispose();
                    }
                    else if (QuotationMode == OperationType.Modification && quotationBasicData.Status == Constants.QUOTATION_SEND_TO_OSF)
                    {
                        utilities.DisplayInfoMessage("Los cambios fueron guardados y la cotización fue actualizada exitosamente en OSF");
                        this.Dispose();
                    }
                    else
                    {
                        utilities.DisplayInfoMessage("La cotización fue actualizada exitosamente");
                        this.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();

                GlobalExceptionProcessing.ShowErrorException(ex);

                if (QuotationMode == OperationType.Modification)
                {
                    this.Dispose();
                }
            }
        }

        private void btnSendToOSF_Click(object sender, EventArgs e)
        {
            try
            {

                /////Inicio OSF-3104
                Double nuValActInd = 0;

                //Valida si la cotizacion generada es de categoria industrial 
                if (blExisteCategoriaIndsutrial)
                {

                    if (String.IsNullOrEmpty(cbChargeByConnActivity.Text) && nuValActInd == 0)
                    {
                        utilities.DisplayInfoMessage("Error - La cotización NO tiene seleccionada en la pestaña Cargo por Conexión una actividad valida.");
                        nuValActInd = 1;
                    }

                    if (String.IsNullOrEmpty(cbCertifActivity.Text) && nuValActInd == 0)
                    {
                        utilities.DisplayInfoMessage("Error - La cotización NO tiene seleccionada en la pestaña Inspección/Certificación una actividad valida.");
                        nuValActInd = 1;
                    }

                    Double nuActividadCargoConexion = blLDC_FCVC.ExisteActividadCargoConexionIndustrial(Convert.ToDouble(cbChargeByConnActivity.Value));

                    if (nuActividadCargoConexion == 0 && nuValActInd == 0)
                    {
                        utilities.DisplayInfoMessage("Error - La cotización tiene seleccionada en la pestaña Cargo por Conexión una actividad invalida.");
                        nuValActInd = 1;
                    }

                    Double nuActividadCertificacion = blLDC_FCVC.ExisteActividadInspecCertificaIndustrial(Convert.ToDouble(cbCertifActivity.Value));

                    if (nuActividadCertificacion == 0 && nuValActInd == 0)
                    {
                        utilities.DisplayInfoMessage("Error - La cotización tiene seleccionada en la pestaña Inspección/Certificación una actividad invalida");
                        nuValActInd = 1;
                    }
                }
                /////Fin OSF-3104

                if (nuValActInd == 0)
                {
                    Boolean findError = false;
                    if (fieldsAreValid(ValidationArea.toSendOSFData))
                    {
                        if (fieldsAreValid(ValidationArea.AllData))
                        {
                            if (specialCustomerChanged() || quotationBasicDataChanged() || itemsDataChange())
                            {
                                DialogResult continueResult = ExceptionHandler.DisplayMessage(
                                            2741,
                                            "Desea guardar los cambios realizados en la cotización, antes de enviarla a OSF?",
                                            MessageBoxButtons.YesNo,
                                            MessageBoxIcon.Question);

                                if (continueResult == DialogResult.Yes)
                                {
                                    saveChanges(out findError);
                                }
                            }

                            Cursor.Current = Cursors.WaitCursor;

                            if (!findError)
                            {
                                sendQuotationToOSF();

                                utilities.doCommit();

                                Cursor.Current = Cursors.Default;
                                utilities.DisplayInfoMessage("La cotización fue enviada exitosamente a OSF");
                                this.Dispose();
                            }
                            else
                            {
                                utilities.doRollback();
                                utilities.DisplayInfoMessage("Error enviando la cotización a OSF");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
        }
        #endregion

        private void tbQuotationValidityDate_Validating(object sender, CancelEventArgs e)
        {
            if (Convert.ToDateTime(tbQuotationValidityDate.TextBoxValue).Date < OpenDate.getSysDateOfDataBase().Date)
            {
                utilities.DisplayErrorMessage("La fecha de vigencia debe ser mayor a la fecha actual");
            }
        }

        private void tbAddress_Leave(object sender, EventArgs e)
        {
            setBasicAddressData();
        }

        private void tbAddress_ValueChanged(object sender, EventArgs e)
        {
            setBasicAddressData();   
        }

        private void setBasicAddressData()
        {   
            if (!String.IsNullOrEmpty(tbAddress.Address_id))
            {
                cbCategory.Value = blLDC_FCVC.GetCategory(Convert.ToInt64(tbAddress.Address_id));
                cbSubcategory.Value = cbCategory.Value + Convert.ToString(blLDC_FCVC.GetSubcategory(Convert.ToInt64(tbAddress.Address_id)));
                cbLocation.Value = tbAddress.GeograpLocation;
                cbFatherLocation.Value = blLDC_FCVC.GetFatherLocation(OpenConvert.ToLong(tbAddress.GeograpLocation));

                //Inicio OSF-1492
                //Establecer si la caregoria esta en el parametro de bloqueo de %AIU
                String InactivaAIU = blLDC_FCVC.cadenaParametro("CATEGORIA_INACTIVA_AIU").ToString();
                string[] split = InactivaAIU.Split(new Char[] { ',' });
                tbAIU.Enabled = true;
                foreach (string s in split)
                {
                    if (s.Trim() == cbCategory.Value.ToString())
                    {
                        tbAIU.Enabled = false;
                    }
                }
                //Fin OSF-1492

                //Incio OSF-3104
                blExisteCategoriaIndsutrial = false;
                String sbCategpria_Industrial = blLDC_FCVC.cadenaParametro("CATEGORIA_INDUSTRIAL_LDC_FCVC");
                string[] splitActividad = sbCategpria_Industrial.Split(new Char[] { ',' });
                tbAIU.Enabled = true;
                foreach (string s in splitActividad)
                {
                    if (s.Trim() == cbCategory.Value.ToString())
                    {
                        blExisteCategoriaIndsutrial = true;
                    }
                }
                //Fin OSF-3104

            }
        }

        private void cbChargeByConnActivity_ValueChanged(object sender, EventArgs e)
        {
            updateQuotedTaskType(cbChargeByConnActivity.SelectedRow, Constants.CHARGE_BY_CON_CLASS);
        }

        private void cbInternalConnActivity_ValueChanged(object sender, EventArgs e)
        {
            updateQuotedTaskType(cbInternalConnActivity.SelectedRow, Constants.INTERNAL_CON_CLASS);
        }

        private void cbCertifActivity_ValueChanged(object sender, EventArgs e)
        {
            updateQuotedTaskType(cbCertifActivity.SelectedRow, Constants.CERTIFICATION_CLASS);
        }

        private void ugChargeByConnItems_KeyUp(object sender, KeyEventArgs e)
        {
            var grid = (UltraGrid)sender;

            setItemFilter(grid, e);
        }

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
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ItemCostList.ITEM_DESCRIPTION_KEY].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + ultragrid.ActiveCell.Text + "*");
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters.LogicalOperator = FilterLogicalOperator.Or;
                            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ItemCostList.ITEM_ID_KEY].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + ultragrid.ActiveCell.Text + "*");
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
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ItemCostList.ITEM_DESCRIPTION_KEY].FilterConditions.Clear();
            this.itemsDropDown.DisplayLayout.Bands[0].ColumnFilters[ItemCostList.ITEM_ID_KEY].FilterConditions.Clear();
        }

        private void ugChargeByConnItems_AfterCellUpdate(object sender, CellEventArgs e)
        {
            setAfterCellUpdBehaviour(bsChargeByConnItems, e, (cbChargeByConnActivity.SelectedRow.ListObject as ActivityTaskType));
            
        }

        private void ugInternalConnItems_AfterCellUpdate(object sender, CellEventArgs e)
        {
            setAfterCellUpdBehaviour(bsInternalConn, e, (cbInternalConnActivity.SelectedRow.ListObject as ActivityTaskType));
        }

        private void ugCertificationItems_AfterCellUpdate(object sender, CellEventArgs e)
        {
            setAfterCellUpdBehaviour(bsCertification, e, (cbCertifActivity.SelectedRow.ListObject as ActivityTaskType));
        }

        private void setAfterCellUpdBehaviour(BindingSource source, CellEventArgs e, ActivityTaskType activity)
        {
            QuotationItem currentItem;

            if (e.Cell.Column.Key.ToUpper() == QuotationItem.DESCRIPTION_KEY)
            {
                setUpNewItem(source, selectedItem, activity);
            }

            if (e.Cell.Column.Key.ToUpper() == QuotationItem.AMOUNT_KEY)
            {
                currentItem = (QuotationItem)source.Current;

                if (itemIsValidForUpdate(currentItem))
                {
                    currentItem.Option = Constants.UPDATE_OPTION;
                }
            }

            clearFilterConditions();

            calcSummaryQuotation();
        }

        private void ugChargeByConnItems_AfterRowActivate(object sender, EventArgs e)
        {
            deactivateItemDesc(this.ugChargeByConnItems);
        }

        private void ugInternalConnItems_AfterRowActivate(object sender, EventArgs e)
        {
            deactivateItemDesc(this.ugInternalConnItems);
        }

        private void ugCertificationItems_AfterRowActivate(object sender, EventArgs e)
        {
            deactivateItemDesc(this.ugCertificationItems);
        }

        private void setUpNewItem(BindingSource source, ItemCostList selectedItem, ActivityTaskType activity)
        {
            QuotationItem currentItem;
            if (itemAlreadyExists(selectedItem, source))
            {
                utilities.DisplayInfoMessage("Este item ya existe");

                source.RemoveCurrent();

                return;
            }

            currentItem = (QuotationItem)source.Current;

            setNewItemData(currentItem, selectedItem, activity);
        }

        private void deactivateItemDesc(UltraGrid ultragrid)
        {
            String currentValue = Convert.ToString(ultragrid.ActiveRow.Cells[QuotationItem.ITEM_ID_KEY].Value);

            if (!String.IsNullOrEmpty(currentValue) && currentValue != "0")
            {
                //caso 200-1640
                //ultragrid.ActiveRow.Cells[QuotationItem.DESCRIPTION_KEY].Activation = Activation.NoEdit;
            }
        }

        /// <summary>
        /// Se setean los datos para nuevo ítem
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 26-10-2016
        private void setNewItemData(QuotationItem targetItem, ItemCostList sourceItem, ActivityTaskType quotedActivity)
        {
            targetItem.ItemId = sourceItem.ItemId;
            targetItem.ListId = sourceItem.ListId;
            targetItem.SaleCost = sourceItem.CostSale;
            targetItem.TaskType = quotedActivity.TaskType;
            targetItem.ActivityId = quotedActivity.Activity;
        }

        private void chkApplyDiscountChargeConn_Click(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            processDiscount(checkBox, bsChargeByConnItems, ugChargeByConnItems, Constants.CHARGE_BY_CON_CLASS, cbChargeByConnActivity);
        }

        private void chkApplyDiscountInternConn_Click(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            processDiscount(checkBox, bsInternalConn, ugInternalConnItems, Constants.INTERNAL_CON_CLASS, cbInternalConnActivity);
        }

        private void chkApplyDiscountCertification_Click(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            processDiscount(checkBox, bsCertification, ugCertificationItems, Constants.CERTIFICATION_CLASS, cbCertifActivity);
        }

        private void processDiscount(CheckBox checkBox, BindingSource source, UltraGrid ultragrid, String taskTypeClass, OpenCombo combo)
        {
            if (!checkBox.Checked)
            {
                
                if (!validDiscountConcept((combo.SelectedRow == null ? null : combo.SelectedRow.ListObject as ActivityTaskType)))
                {
                    return;
                }

                Decimal discountPercentage = getDiscountPercentage();
                applyDiscount(discountPercentage, source, ultragrid, taskTypeClass);
                checkBox.Checked = true;
            }
            else
            {
                checkBox.Checked = false;
                deleteDiscount(source, ultragrid, taskTypeClass);
            }
        }

        /// <summary>
        /// Se verifica si el concepto de descuento es válido
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016
        private Boolean validDiscountConcept(ActivityTaskType activity)
        {
            if (activity == null)
            {
                utilities.DisplayInfoMessage("Debe seleccionar la actividad que va a cotizar");
                return false;
            }
            else
            {
                if (!activity.DiscountConcept.HasValue)
                {
                    utilities.DisplayErrorMessage("La actividad no tiene configuración de descuento");
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Se obtiene porcentaje de descuento
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 26-10-2016
        private Decimal getDiscountPercentage()
        {
            Decimal discountPercentage = String.IsNullOrEmpty(tbDiscount.TextBoxValue) ? 0 : Convert.ToDecimal(tbDiscount.TextBoxValue);

            return discountPercentage;
        }

        /// <summary>
        /// Se aplica descuento a items
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void applyDiscount(Decimal discountPercentage, BindingSource source, UltraGrid ultragrid, String taskTypeClass)
        {
            foreach (QuotationItem item in source)
            {
                item.DiscountPercentage = discountPercentage;

                if (itemIsValidForUpdate(item))
                {
                    item.Option = Constants.UPDATE_OPTION;
                }
            }

            setDiscountApplyToTaskType(taskTypeClass, true);
            refreshGrid(source, ultragrid);
            calcSummaryQuotation();
        }

        /// <summary>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
        /// Se elimina el descuento a los ítems
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void deleteDiscount(BindingSource source, UltraGrid ultragrid, String taskTypeClass)
        {
            foreach (QuotationItem item in source)
            {
              item.DiscountPercentage = 0;

              if (itemIsValidForUpdate(item))
              {
                  item.Option = Constants.UPDATE_OPTION;
              }
            }

            setDiscountApplyToTaskType(taskTypeClass, false);

            refreshGrid(source, ultragrid);
            calcSummaryQuotation();
        }

        private void setDiscountApplyToTaskType(String taskTypeClass, Boolean applyDiscount)
        {
            QuotationTaskType tmpTaskType = quotationBasicData.TaskTypeList.Find(delegate(QuotationTaskType tt) { return tt.TaskTypeClassif == taskTypeClass; });

            if (tmpTaskType != null)
            {
                tmpTaskType.ApplyDiscount = applyDiscount;
                setUpdateStatusToTaskType(tmpTaskType);
            }
        }

        private void setUpdateStatusToTaskType(QuotationTaskType taskType)
        {
            if (taskType.Option == Constants.NONE_OPTION)
            {
                taskType.Option = Constants.UPDATE_OPTION;
            }
        }

        private Boolean itemIsValidForUpdate(QuotationItem item)
        {
            if (item.Option == Constants.NONE_OPTION)
            {
                return true;   
            }
            return false;
        }

        private Boolean applyDiscount(long taskType)
        {
            QuotationTaskType tmpTaskType = quotationBasicData.TaskTypeList.Find(delegate(QuotationTaskType t) { return t.TaskType == taskType; });

            if (tmpTaskType != null)
	        {
		        if (tmpTaskType.ApplyDiscount)
	            {
		            return true;
	            }
	        }

            return false;
        }

        private void tbDiscount_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(tbDiscount.TextBoxValue))
            {
                deleteDiscount(bsChargeByConnItems, ugChargeByConnItems, Constants.CHARGE_BY_CON_CLASS);
                deleteDiscount(bsInternalConn, ugInternalConnItems, Constants.INTERNAL_CON_CLASS); 
                deleteDiscount(bsCertification, ugCertificationItems, Constants.CERTIFICATION_CLASS); 
            }
            else if (tbDiscount.TextBoxValue == "-")
            {
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "0");
            }
            else if (tbDiscount.TextBoxValue.Contains("-"))
            {
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
            else
            {
                Decimal discountPercentage = getDiscountPercentage();

                if (discountPercentage>100 || discountPercentage <0)
                {
                    tbDiscount.TextBoxObjectValue = 0;
                    utilities.DisplayErrorMessage("El porcentaje debe estar comprendido entre 0 y 100!");
                    return;
                }
                
                if (chkApplyDiscountChargeConn.Checked)
                {
                    applyDiscount(discountPercentage, bsChargeByConnItems, ugChargeByConnItems, Constants.CHARGE_BY_CON_CLASS);
                }

                if (chkApplyDiscountInternConn.Checked)
                {
                    applyDiscount(discountPercentage, bsInternalConn, ugInternalConnItems, Constants.INTERNAL_CON_CLASS);
                }

                if (chkApplyDiscountCertification.Checked)
                {
                    applyDiscount(discountPercentage, bsCertification, ugCertificationItems, Constants.CERTIFICATION_CLASS); 
                }
                
            }
        }

        private void uncheckDiscount()
        {
            chkApplyDiscountChargeConn.Checked = false;
            chkApplyDiscountInternConn.Checked = false;
            chkApplyDiscountCertification.Checked = false;
        }

        private void calcSummaryQuotation()
        {
            Decimal quotedValue = 0;

            //caso 200-1640
            foreach (QuotationTaskType taskType in bsQuotedTaskType)
            {
                taskType.Aiu = 0;
                taskType.Subtotal = 0;
                taskType.Discount = 0;
                taskType.TotalValue = 0;
                taskType.IvaValue = 0;
            }
            //

            syncItemsChangesInSummary(bsChargeByConnItems, ref quotedValue);
            syncItemsChangesInSummary(bsCertification, ref quotedValue);
            syncItemsChangesInSummary(bsInternalConn, ref quotedValue);

            //validacion de los totales
            refreshGrid(bsQuotedTaskType, ugQuotedTaskType);
        }

        private void addItemToSource(BindingSource source, UltraGrid ultragrid, String taskTypeClass, ActivityTaskType activitySelected)
        {
            if (validQuotationItem(ultragrid))
            {
                QuotationItem tmpQuotationItem = (QuotationItem)source.AddNew();

                tmpQuotationItem.TaskType = activitySelected.TaskType;

                tmpQuotationItem.Iva = getIvaPercentageByTaskTypeClass(taskTypeClass);

                tmpQuotationItem.TaskTypeClassif = taskTypeClass;

                if (applyDiscount(tmpQuotationItem.TaskType))
                {
                    tmpQuotationItem.DiscountPercentage = getDiscountPercentage();
                }

                tmpQuotationItem.Option = Constants.REGISTER_OPTION;

                refreshGrid(source, ultragrid);

                calcSummaryQuotation();
            }
        }

        private void deleteItemFromSource(BindingSource source, UltraGrid ultragrid)
        {
            
            if (source.Count <= 0)
            {
                return;
            }

            QuotationItem itemToDelete = (QuotationItem)source.Current;

            if (itemToDelete.Option != Constants.REGISTER_OPTION)
            {
                deleteItem(itemToDelete, source);
                refreshGrid(source, ultragrid);
            }
            else
            {
                source.RemoveCurrent();
            }

            calcSummaryQuotation();
        }

        private void syncItemsChangesInSummary(BindingSource sourceItems, ref Decimal quotedValue)
        {
            Boolean firstItem = true;

            foreach (QuotationTaskType taskType in bsQuotedTaskType)
            {
                firstItem = true;
                foreach (QuotationItem item in sourceItems)
                {
                    if (taskType.TaskType == item.TaskType)
                    {
                        if (firstItem)
                        {
                            taskType.Aiu = 0;
                            taskType.Subtotal = 0;
                            taskType.Discount = 0;
                            taskType.TotalValue = 0;
                            taskType.IvaValue = 0;
                            firstItem = false;
                        }

                        if (item.Option != Constants.DELETE_OPTION)
                        {
                            taskType.Aiu += item.Aiu;
                            taskType.Subtotal += item.TotalPrice;
                            taskType.IvaValue += item.IvaValue;
                            taskType.Discount += item.Discount;
                            taskType.TotalValue += item.TotalValue;
                            quotedValue += item.TotalValue;
                        }
                    }
                } 
            }

            tbQuotedValue.TextBoxObjectValue = quotedValue;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (quotationBasicData.Consecutive.HasValue)
            {
                blLDC_FCVC.PrintQuotation(Convert.ToInt64(quotationBasicData.Consecutive));    
            }
        }

        private void tbDiscount_Validating(object sender, CancelEventArgs e)
        {
            if (String.IsNullOrEmpty(tbDiscount.TextBoxValue))
            {
                tbDiscount.TextBoxObjectValue = 0;
            }
        }

        /// <summary>
        /// Se llena combobox por medio de un cursor
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 17-01-2018  Daniel Valiente        Metodo para cargar cursores a listas de valores. Caso 200-1640
        /// 16-07-2018  Daniel Valiente        Se le agrego metodo para Unidad por Defecto
        public void fillCursorCombo(OpenCombo targetCombo, String Procedure, String campo = "", String tipo = "", String valor = "", Boolean aplica = false, String indice = "")
        {
            DataSet dsgeneral = new DataSet();

            //
            if (aplica)
            {
                dsgeneral.Tables.Add("tabla");
                dsgeneral.Tables["tabla"].Columns.Add("ID");
                dsgeneral.Tables["tabla"].Columns.Add("DESCRIPTION");
                DataRow newCustomersRow = dsgeneral.Tables["tabla"].NewRow();

                newCustomersRow["ID"] = Int16.Parse(indice);
                newCustomersRow["DESCRIPTION"] = "UNIDAD POR DEFECTO";

                dsgeneral.Tables["tabla"].Rows.Add(newCustomersRow);
            }
            //
            else
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
                {
                    switch (tipo)
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, campo, DbType.String, string.IsNullOrEmpty(valor.ToString()) ? null : Convert.ToString(valor));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, campo, DbType.Int64, string.IsNullOrEmpty(valor.ToString()) ? (Object)DBNull.Value : Convert.ToInt64(valor));
                            break;
                        case "DateTime":
                            OpenDataBase.db.AddInParameter(cmdCommand, campo, DbType.DateTime, string.IsNullOrEmpty(valor.ToString()) ? (Object)DBNull.Value : Convert.ToDateTime(valor));
                            break;
                        default:
                            break;
                    }
                    OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                    OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "tabla");
                }
            }

            targetCombo.DataSource = dsgeneral.Tables["tabla"];
            targetCombo.ValueMember = "ID";
            targetCombo.DisplayMember = "DESCRIPTION";
        }

        //caso 200-1640
        object tempContractors = null;
        object tempUnitWorks = null;
        object tempActividadP1 = null;
        Boolean tempSelDescP1 = false;
        object codContractors = null;
        //
        private void cbx_contractors_ValueChanged(object sender, EventArgs e)
        {
            if (!inicio)
            {
                //SALVAR INFORMACION TEMPORAL
                //variables temporales
                if (pn_bloque1.Enabled && codContractors != null)
                {
                    tempContractors = codContractors;//cbx_contractors.Value;
                    tempUnitWorks = cbx_workunit.Value;
                    //pest 1
                    tempActividadP1 = cbChargeByConnActivity.Value;
                    tempSelDescP1 = chkApplyDiscountChargeConn.Checked;
                    //
                    if (bsChargeByConnItems_aux.Count > 0)
                    {
                        int tot = bsChargeByConnItems_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsChargeByConnItems_aux.RemoveAt(i);
                        }
                    }
                    if (bsChargeByConnItems.Count > 0)
                    {
                        foreach (QuotationItem fila in bsChargeByConnItems)
                        {
                            //MessageBox.Show(fila.Description);
                            bsChargeByConnItems_aux.Add(fila.Clone());
                        }
                    }
                    //
                    if (bsCertification_aux.Count > 0)
                    {
                        int tot = bsCertification_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsCertification_aux.RemoveAt(i);
                        }
                    }
                    if (bsCertification.Count > 0)
                    {
                        foreach (QuotationItem fila in bsCertification)
                        {
                            //MessageBox.Show(fila.Description);
                            bsCertification_aux.Add(fila.Clone());
                        }
                    }
                    //
                    if (bsInternalConn_aux.Count > 0)
                    {
                        int tot = bsInternalConn_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsInternalConn_aux.RemoveAt(i);
                        }
                    }
                    if (bsInternalConn.Count > 0)
                    {
                        foreach (QuotationItem fila in bsInternalConn)
                        {
                            //MessageBox.Show(fila.Description);
                            bsInternalConn_aux.Add(fila.Clone());
                        }
                    }
                }
                //lista de valores para unidades de Trabajo. Caso 200-1640
                codUnitWork = "";
                cbx_workunit.DataSource = null;
                cbx_workunit.Value = null;
                fillCursorCombo(cbx_workunit, BLGeneralQueries.queryUnitWork, "inuContractor", "Int64", cbx_contractors.Value.ToString());
                //cbx_workunit.Value = Int64.Parse(blLDC_FCVC.getParam(BLGeneralQueries.dummyUnitWork, "Int64").ToString());
                //Modificacion de la rutina - carga de primera unidad disponible 200-1640 : 09.07.18
                /*String indice = blLDC_FCVC.getParam(BLGeneralQueries.dummyUnitWork, "Int64").ToString();
                Boolean entro = false;
                for (int i = 0; i <= cbx_workunit.Rows.Count - 1; i++)
                {
                    if (cbx_workunit.Rows[i].Cells[0].Value.ToString() == indice)
                    {
                        entro = true;
                        cbx_workunit.SelectedRow = cbx_workunit.Rows[i];
                        codUnitWork = indice;
                    }
                }*/
                Boolean entro = false;
                if(cbx_workunit.Rows.Count > 0)
                {
                    entro = true;
                    cbx_workunit.SelectedRow = cbx_workunit.Rows[0];
                    codUnitWork = cbx_workunit.Rows[0].Cells[0].Value.ToString();
                }
                //
                if (!entro)
                {
                    //inicio = false;

                    codUnitWork = "";

                    cbx_workunit.Value = null;
                    delValueListToGridColumn();
                    //inicio = true;
                }
                //BLOQUEO DE BLOQUES Y BOTONES DE OPERACION
                if (ugChargeByConnItems.Rows.Count > 0 || ugInternalConnItems.Rows.Count > 0 || ugCertificationItems.Rows.Count > 0)
                {
                    pn_bloque1.Enabled = false;
                    pn_button.Visible = true;
                }
                //
                refreshGrid(bsCertification, ugCertificationItems);
                refreshGrid(bsChargeByConnItems, ugChargeByConnItems);
                refreshGrid(bsInternalConn, ugInternalConnItems);

                calcSummaryQuotation();

                codContractors = cbx_contractors.Value;
            }
        }

        //caso 200-1640
        String codUnitWork = ""; 
        //

        //caso 200-1640
        private void cbx_workunit_ValueChanged(object sender, EventArgs e)
        {
            //valido que no este iniciando el formulario
            if (!inicio)
            {
                //delValueListToGridColumn();
                //valido cuando el combo esta en nulo
                if (cbx_workunit.Value == null)
                {
                    //si hay un codigo previamente seleccionado se retorna este valor
                    if (codUnitWork != "")
                    {
                        inicio = true;
                        cbx_workunit.Value = Int64.Parse(codUnitWork);
                        inicio = false;
                    }
                    else
                    {
                        //llenado de combos
                        setValueListToGridColumn(ugChargeByConnItems, "Description", null);
                        setValueListToGridColumn(ugInternalConnItems, "Description", null);
                        setValueListToGridColumn(ugCertificationItems, "Description", null);
                    }
                }
                else
                {
                    //realizo la consulta basicas de generacion de listas a partir del codigo devuelto por el combo
                    Int64 codigo = Int64.Parse(cbx_workunit.Value.ToString()); 
                    itemsDropDown = new OpenGridDropDown();
                    itemsCostList = blLDC_FCVC.getValidItems(codigo);
                    itemsDropDown.DataSource = itemsCostList;
                    itemsDropDown.ValueMember = ItemCostList.UNIQUE_ITEM_KEY;
                    itemsDropDown.DisplayMember = ItemCostList.ITEM_DESCRIPTION_KEY;

                    itemsDropDown.Parent = this;

                    setUpDropDown(itemsDropDown);

                    //Caso 200-1640
                    Boolean continuarGrillas = true;
                    //confirmo si la lista no tiene asociado ningun item
                    if(itemsDropDown.Rows.Count == 0)
                    {
                        //consulto al usuario si desea aplicar los cambios
                        Question pregunta = new Question("LDC_FVC - Aplicar Cambios", "Esta seguro que desea Aplicar los Cambios, esta unidad de trabajo no tiene asociado ninguna Lista?", "Si", "No");
                        pregunta.ShowDialog();
                        //si responde que si
                        if (pregunta.answer == 2)
                        {
                            //limpio las grilas
                            delValueListToGridColumn();
                            codUnitWork = cbx_workunit.Value.ToString();
                        }
                        //si responde que no
                        else
                        {
                            //consulto si hay un codigo previo
                            if (codUnitWork != "")
                            {
                                // //inicio = true;
                                //cbx_workunit.Value = Int64.Parse(codUnitWork);
                                for (int i = 0; i <= cbx_workunit.Rows.Count - 1; i++)
                                {
                                    if (cbx_workunit.Rows[i].Cells[0].Value.ToString() == codUnitWork)
                                    {
                                        cbx_workunit.SelectedRow = cbx_workunit.Rows[i];
                                    }
                                }
                                // //inicio = false;
                            }
                        }
                    }
                    else
                    {
                        //valido los contenidos de la grilla para saber cuales no corresponden a la nueva Unidad de trabajo
                        //validador temporal para saber si no se encuentra el item en la nueva lista
                        Boolean findedNA1 = false;
                        Boolean findedNA2 = false;
                        Boolean findedNA3 = false;
                        //vector de fila de grilla hallados
                        QuotationItem[] filaGrid1 = new QuotationItem[bsChargeByConnItems.Count];
                        QuotationItem[] filaGrid2 = new QuotationItem[bsInternalConn.Count];
                        QuotationItem[] filaGrid3 = new QuotationItem[bsCertification.Count];
                        //contador de filas por grilla
                        int contFilaGrid1 = 0;
                        int contFilaGrid2 = 0;
                        int contFilaGrid3 = 0;
                        //Validaciones para los que no se encuentran
                        //Grilla 1
                        foreach (QuotationItem item in bsChargeByConnItems)
                        {
                            findedNA1 = false;
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                //valido cuando se encuentran elementos iguales en la lista
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    findedNA1 = true;
                                }
                            }
                            //si el item no fue hallado en la lista lo asigno al vector para su posible eliminacion
                            if (!findedNA1)
                            {
                                contFilaGrid1++;
                                filaGrid1[contFilaGrid1] = item;
                            }
                        }
                        //Grilla 2
                        foreach (QuotationItem item in bsInternalConn)
                        {
                            findedNA2 = false;
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                //valido cuando se encuentran elementos iguales en la lista
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    findedNA2 = true;
                                }
                            }
                            //si el item no fue hallado en la lista lo asigno al vector para su posible eliminacion
                            if (!findedNA2)
                            {
                                contFilaGrid2++;
                                filaGrid2[contFilaGrid2] = item;
                            }
                        }
                        //Grilla 3
                        foreach (QuotationItem item in bsCertification)
                        {
                            findedNA3 = false;
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                //valido cuando se encuentran elementos iguales en la lista
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    findedNA3 = true;
                                }
                            }
                            //si el item no fue hallado en la lista lo asigno al vector para su posible eliminacion
                            if (!findedNA3)
                            {
                                contFilaGrid3++;
                                filaGrid3[contFilaGrid3] = item;
                            }
                        }
                        
                        //validacion de los item si encontre al menos uno que no se halla en listado de la unidad de trabajo
                        if(contFilaGrid1 > 0 || contFilaGrid2 > 0 || contFilaGrid3 > 0)
                        {
                            //pregunto si desea retirar los elementos de las grillas
                            Question pregunta = new Question("LDC_FVC - Aplicar Cambios", "Esta seguro que desea Aplicar los Cambios, algunos Items cotizados podran ser retirados de la Lista?", "Si", "No");
                            pregunta.ShowDialog();
                            //si el usuario responde que si
                            if (pregunta.answer == 2)
                            {
                                //remuevo de la grilla1 los elementos que no se encontraron
                                foreach (QuotationItem item in filaGrid1)
                                {
                                    deleteItem(item, bsChargeByConnItems);
                                }
                                //remuevo de la grilla2 los elementos que no se encontraron
                                foreach (QuotationItem item in filaGrid2)
                                {
                                    deleteItem(item, bsInternalConn);
                                }
                                //remuevo de la grilla3 los elementos que no se encontraron
                                foreach (QuotationItem item in filaGrid3)
                                {
                                    deleteItem(item, bsCertification);
                                }


                            }
                            //si el usuario responde que no
                            else
                            {
                                continuarGrillas = false;
                            }
                        }
                        codUnitWork = cbx_workunit.Value.ToString();
                    }
                    if (continuarGrillas)
                    {
                        
                        //llenado de combos
                        setValueListToGridColumn(ugChargeByConnItems, "Description", itemsDropDown);
                        setValueListToGridColumn(ugInternalConnItems, "Description", itemsDropDown);
                        setValueListToGridColumn(ugCertificationItems, "Description", itemsDropDown);

                        itemsDropDown.RowSelected += new RowSelectedEventHandler(itemsList_RowSelected);

                        //grilla 1
                        ugChargeByConnItems.AfterCellUpdate -= ugChargeByConnItems_AfterCellUpdate;

                        foreach (QuotationItem item in bsChargeByConnItems)
                        {
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    ItemCostList tmpSelectedItem = itemsDropDown.Rows[i].ListObject as ItemCostList;
                                    item.ListId = tmpSelectedItem.ListId;
                                    item.Description = tmpSelectedItem.ItemId.ToString() + "_" + tmpSelectedItem.ListId.ToString();
                                    item.SaleCost = tmpSelectedItem.CostSale;
                                    i = itemsDropDown.Rows.Count;
                                }
                            }
                        }

                        ugChargeByConnItems.AfterCellUpdate += ugChargeByConnItems_AfterCellUpdate;

                        //grilla 2
                        ugInternalConnItems.AfterCellUpdate -= ugInternalConnItems_AfterCellUpdate;

                        foreach (QuotationItem item in bsInternalConn)
                        {
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    ItemCostList tmpSelectedItem = itemsDropDown.Rows[i].ListObject as ItemCostList;
                                    item.ListId = tmpSelectedItem.ListId;
                                    item.Description = tmpSelectedItem.ItemId.ToString() + "_" + tmpSelectedItem.ListId.ToString();
                                    item.SaleCost = tmpSelectedItem.CostSale;
                                    i = itemsDropDown.Rows.Count;
                                }
                            }
                        }

                        ugInternalConnItems.AfterCellUpdate += ugInternalConnItems_AfterCellUpdate;

                        //grilla 3
                        ugCertificationItems.AfterCellUpdate -= ugCertificationItems_AfterCellUpdate;

                        foreach (QuotationItem item in bsCertification)
                        {
                            for (int i = 0; i <= itemsDropDown.Rows.Count - 1; i++)
                            {
                                if (itemsDropDown.Rows[i].Cells[0].Value.ToString() == item.ItemId.ToString())
                                {
                                    ItemCostList tmpSelectedItem = itemsDropDown.Rows[i].ListObject as ItemCostList;
                                    item.ListId = tmpSelectedItem.ListId;
                                    item.Description = tmpSelectedItem.ItemId.ToString() + "_" + tmpSelectedItem.ListId.ToString();
                                    item.SaleCost = tmpSelectedItem.CostSale;
                                    //item.Option = Constants.UPDATE_OPTION;
                                    i = itemsDropDown.Rows.Count;
                                }
                            }
                        }

                        ugCertificationItems.AfterCellUpdate += ugCertificationItems_AfterCellUpdate;

                    }

                }

                //actualizo los datos de la grilla
                refreshGrid(bsCertification, ugCertificationItems);
                refreshGrid(bsChargeByConnItems, ugChargeByConnItems);
                refreshGrid(bsInternalConn, ugInternalConnItems);

                calcSummaryQuotation();
            }
        }

        private void ob_aceptar_Click(object sender, EventArgs e)
        {
            pn_bloque1.Enabled = true;
            pn_button.Visible = false;
            //
            if (bsChargeByConnItems.Count > 0)
            {
                foreach (QuotationItem fila in bsChargeByConnItems)
                {
                    fila.Option = Constants.UPDATE_OPTION;
                }
            }
            //
            if (bsCertification.Count > 0)
            {
                foreach (QuotationItem fila in bsCertification)
                {
                    fila.Option = Constants.UPDATE_OPTION;
                }
            }
            //
            if (bsInternalConn.Count > 0)
            {
                foreach (QuotationItem fila in bsInternalConn)
                {
                    fila.Option = Constants.UPDATE_OPTION;
                }
            }
        }

        private void ob_cancelar_Click(object sender, EventArgs e)
        {
            //cbx_contractors.Value = tempContractors;
            for (int i = 0; i <= cbx_contractors.Rows.Count - 1; i++)
            {
                if (cbx_contractors.Rows[i].Cells[0].Value.ToString() == tempContractors.ToString())
                {
                    cbx_contractors.SelectedRow = cbx_contractors.Rows[i];
                }
            }
            codContractors = tempContractors;
            //
            //cbx_workunit.Value = tempUnitWorks;
            for (int i = 0; i <= cbx_workunit.Rows.Count - 1; i++)
            {
                if (cbx_workunit.Rows[i].Cells[0].Value.ToString() == tempUnitWorks.ToString())
                {
                    cbx_workunit.SelectedRow = cbx_workunit.Rows[i];
                }
            }
            codUnitWork = tempUnitWorks.ToString();
            //pest 1
            //cbChargeByConnActivity.Value = tempActividadP1;
            for (int i = 0; i <= cbChargeByConnActivity.Rows.Count - 1; i++)
            {
                if (cbChargeByConnActivity.Rows[i].Cells[0].Value.ToString() == tempActividadP1.ToString())
                {
                    cbChargeByConnActivity.SelectedRow = cbChargeByConnActivity.Rows[i];
                }
            }
            chkApplyDiscountChargeConn.Checked = tempSelDescP1;
            //
            delValueListToGridColumn();
            //
            if (bsChargeByConnItems_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsChargeByConnItems_aux)
                {
                    bsChargeByConnItems.Add(fila.Clone());
                }
            }
            //
            if (bsCertification_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsCertification_aux)
                {
                    bsCertification.Add(fila.Clone());
                }
            }
            //
            if (bsInternalConn_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsInternalConn_aux)
                {
                    bsInternalConn.Add(fila.Clone());
                }
            }

            //
            refreshGrid(bsCertification, ugCertificationItems);
            refreshGrid(bsChargeByConnItems, ugChargeByConnItems);
            refreshGrid(bsInternalConn, ugInternalConnItems);

            calcSummaryQuotation();

            pn_bloque1.Enabled = true;
            pn_button.Visible = false;
        }

        private void btnPrintPreCupCot_Click(object sender, EventArgs e)
        {
            if (quotationBasicData.Consecutive.HasValue)
            {
                blLDC_FCVC.PrintPreCupon(Convert.ToInt64(quotationBasicData.Consecutive));
            }
        }


        /// Inicio logica caso OSF-1492

        /// <summary>
        /// Se aplica descuento a items
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28-10-2016
        private void applyAIU(BindingSource source, UltraGrid ultragrid, Int64 tipo)
        {
            Decimal itemSaleCost = 0;
            Double itemAmount = 0;
            Decimal itemAiu = 0;
            Decimal itemTotalPrice = 0;
            Decimal itemIvaValue = 0;

            foreach (QuotationItem item in source)
            {
                itemSaleCost = item.SaleCost;
                //MessageBox.Show("Costo Venta: " + itemSaleCost);
                itemAmount = item.Amount;
                //MessageBox.Show("Cantidad: " + itemAmount);
                itemAiu = item.Aiu;
                //MessageBox.Show("Valor AIU: " + itemAiu);
                itemTotalPrice = item.TotalPrice;
                //MessageBox.Show("Presion Total: " + itemTotalPrice);
                item.Aiu = SetValorAIU(itemSaleCost, itemAmount);
                //aiu = Math.Round((saleCost * Convert.ToDecimal(LDC_FCVC.AIUpercentage)) / 100 * Convert.ToDecimal(amount), 0);
                //MessageBox.Show("Nuevo Valor AIU: " + item.Aiu);
                item.TotalPrice = Math.Round((itemSaleCost * Convert.ToDecimal(itemAmount)) + item.Aiu, 0);
                //totalPrice = Math.Round((saleCost * Convert.ToDecimal(amount)) + aiu, 0);
                //MessageBox.Show("Nuevo Presion Total: " + item.TotalPrice);

                /*
                iva = chargeByConnIVA;
                }
                else if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
                {
                iva = internalConnIVA;
                }
                else if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                iva = certificationIVA;                 
                 */

                if ( tipo == 3)//Constants.CERTIFICATION_CLASS
                {
                    item.IvaValue = Math.Round((item.TotalPrice - item.Discount) * certificationIVA / 100);
                }
                else if (tipo == 2)//Constants.INTERNAL_CON_CLASS
                {
                    itemIvaValue = Math.Round((item.Aiu * internalConnIVA * (valueToMultiplyIVA / 100)) / 100, 0);
                    item.IvaValue = Math.Round(itemIvaValue - (itemIvaValue * item.Discount / 100));
                }
                else if (tipo == 1)//Constants.INTERNAL_CON_CLASS
                {
                    itemIvaValue = Math.Round((item.Aiu * chargeByConnIVA * (valueToMultiplyIVA / 100)) / 100, 0);
                    item.IvaValue = Math.Round(itemIvaValue - (itemIvaValue * item.Discount / 100));
                }

                Decimal discountPercentage = getDiscountPercentage();
                if (chkApplyDiscountChargeConn.Checked)
                {
                    applyDiscount(discountPercentage, bsChargeByConnItems, ugChargeByConnItems, Constants.CHARGE_BY_CON_CLASS);
                }

                if (chkApplyDiscountInternConn.Checked)
                {
                    applyDiscount(discountPercentage, bsInternalConn, ugInternalConnItems, Constants.INTERNAL_CON_CLASS);
                }

                if (chkApplyDiscountCertification.Checked)
                {
                    applyDiscount(discountPercentage, bsCertification, ugCertificationItems, Constants.CERTIFICATION_CLASS);
                }


                item.TotalValue = Math.Round(item.TotalPrice + item.IvaValue - item.Discount, 0);
                //totalValue = Math.Round(totalPrice + ivaValue - discount, 0);
                //MessageBox.Show("Nuevo Total Total: " + item.TotalPrice);
            }
            refreshGrid(source, ultragrid);

        }

        private Decimal SetValorAIU(Decimal InsaleCost, Double InAmount)
        {
            Decimal ValorAIU = Math.Round((InsaleCost * Convert.ToDecimal(AIUpercentage)) / 100 * Convert.ToDecimal(InAmount), 0);
            return ValorAIU;
        }


        /// <summary>
        /// Se obtiene porcentaje de descuento
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-10-2023  Jorge Valiente          OSF-1492: Servicio para obntener el valor del procenjate AIU definido en la Venta Cotizada
        private Decimal getAIUPercentage()
        {
            Decimal PorcentajeAIU = String.IsNullOrEmpty(tbAIU.TextBoxValue) ? 0 : Convert.ToDecimal(tbAIU.TextBoxValue);

            return PorcentajeAIU;
        }

        /// <summary>
        /// Se obtiene porcentaje de descuento
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-10-2023  Jorge Valiente          OSF-1492: Servicio para validar que el procentaje no sea nulo
        private void tbAIU_Validating(object sender, CancelEventArgs e)
        {
            //if (String.IsNullOrEmpty(tbAIU.TextBoxValue))
            //{
            //    tbAIU.TextBoxObjectValue = AIUpercentage;
            //}
        }

        /// <summary>
        /// Se obtiene porcentaje de descuento
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-10-2023  Jorge Valiente          OSF-1492: Servicio para reemplazar caractares no validos
        private void tbAIU_TextBoxValueChanged(object sender, EventArgs e)
        {
            try
            {
                int length = tbAIU.TextBoxValue.Length;
                //MessageBox.Show("Max AIU: " + AIUpercentageMax);
                //MessageBox.Show("Min AIU: " + AIUpercentageMin);
                //MessageBox.Show("Diemcion texto AIU: " + length);
                //MessageBox.Show("Dimencion Min AIU: " + Convert.ToString(AIUpercentageMin).Length);                
                if (tbAIU.TextBoxValue == "-")
                {
                    ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "0");
                }
                else if (tbAIU.TextBoxValue.Contains("-"))
                {
                    ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
                }
                else if (length < 3 && length > Convert.ToString(AIUpercentageMin).Length - 1)
                {
                    Decimal PorcentajeAIU = getAIUPercentage();
                    //if (PorcentajeAIU > 25 || PorcentajeAIU < 10)
                    if (PorcentajeAIU > Convert.ToDecimal(AIUpercentageMax) || PorcentajeAIU < Convert.ToDecimal(AIUpercentageMin))
                    {
                        utilities.DisplayErrorMessage("El porcentaje AIU debe estar comprendido entre " + AIUpercentageMin + " y " + Convert.ToDecimal(AIUpercentageMax));
                        tbAIU.TextBoxObjectValue = AIUpercentage;
                        return;
                    }
                    else
                    {
                        if (AIUpercentage != Convert.ToDouble(PorcentajeAIU))
                        {
                            //Reemplazar el porcentaje AIU
                            AIUpercentage = Convert.ToDouble(PorcentajeAIU);

                            //Aplica AIU a Cargo por Conexion
                            applyAIU(bsChargeByConnItems, ugChargeByConnItems,1);
                            //Aplica AIU a Interna
                            applyAIU(bsInternalConn, ugInternalConnItems,2);
                            //Aplica AIU a Inspeccion/Certificacion
                            applyAIU(bsCertification, ugCertificationItems,3);
                            //Recalcula Sumatorio
                            calcSummaryQuotation();
                        }
                    }
                }
            }
            catch
            {
                if (String.IsNullOrEmpty(tbAIU.TextBoxValue))
                {
                    tbAIU.TextBoxObjectValue = null;  
                } 
                else
                {
                    tbAIU.TextBoxObjectValue = AIUpercentage;
                }
            }
        }

        /// <summary>
        /// Se obtiene porcentaje de descuento
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-10-2023  Jorge Valiente          OSF-1492: Servicio para validar el porcentaje AIU digitado y 
        ///                                               en caso de ser valido reemplazar el valor de la variable global 
        private void tbAIU_Leave(object sender, EventArgs e)
        {
            Decimal PorcentajeAIU = getAIUPercentage();

            ////MessageBox.Show("AIUpercentage: " + AIUpercentage);
            ////MessageBox.Show("Convert.ToDouble(tbAIU.TextBoxObjectValue): " + Convert.ToDouble(tbAIU.TextBoxObjectValue));


            if (PorcentajeAIU > Convert.ToDecimal(AIUpercentageMax) || PorcentajeAIU < Convert.ToDecimal(AIUpercentageMin))
            {
                utilities.DisplayErrorMessage("El porcentaje AIU debe estar comprendido entre " + AIUpercentageMin + " y " + Convert.ToDecimal(AIUpercentageMax));
                tbAIU.TextBoxObjectValue = AIUpercentage;
                return;
            }
            //else
            //{
            //    if (AIUpercentage != Convert.ToDouble(PorcentajeAIU))
            //    {
            //        //Reemplazar el porcentaje AIU
            //        AIUpercentage = Convert.ToDouble(PorcentajeAIU);

            //        //Aplica AIU a Cargo por Conexion
            //        applyAIU(bsChargeByConnItems, ugChargeByConnItems);
            //        //Aplica AIU a Interna
            //        applyAIU(bsInternalConn, ugInternalConnItems);
            //        //Aplica AIU a Inspeccion/Certificacion
            //        applyAIU(bsCertification, ugCertificationItems);
            //        //Recalcula Sumatorio
            //        calcSummaryQuotation();
            //    }
            //}
        }
        /// Fin logica caso OSF-1492

    }
}
