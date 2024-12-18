using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
//using Infragistics.Win;
//using Infragistics.Shared;
using OpenSystems.Common.ExceptionHandler;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace Ludycom.Constructoras.UI
{
    public partial class FDRCC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFDMPC blFDMPC = new BLFDMPC();
        BLFDRCC blFDRCC = new BLFDRCC();
        BLGENERAL general = new BLGENERAL();

        public static String PROJECT_LEVEL = "LDCPRC";
        public static String QUOTATION_LEVEL = "LDC_COTIZACION_DETALLADA";
        public static OperationType QuotationMode;
        public static Double initialFeePercentage = 0;

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;
        private QuotationBasicData quotationBasicData;
        private LovItem itemPerProject = null;
        private LovItem fixedItemPerPropUnit = null;
        private LovItem itemPerLength = null;
        private LovItem itemPerPropUnit = null;

        private LovItem itemPerProjectChargConn = null;
        private LovItem fixedItemPerPropUnitChargConn = null;

        private LovItem tmpItemPerProject = null;
        private LovItem tmpFixedItemPerPropUnit = null;
        private LovItem tmpItemPerLength = null;
        private LovItem tmpItemPerPropUnit = null;

        private LovItem tmpItemPerProjectChargConn = null;
        private LovItem tmpFixedItemPerPropUnitChargConn = null;

        private List<ListOfValues> QuotationStatusList = new List<ListOfValues>();
        private List<ListOfValues> PaymentModalityList = new List<ListOfValues>();
        private List<LovItem> itemsList = new List<LovItem>();
        private List<String> itemDescription = new List<String>();
        private List<LengthPerFloorPerPropUnitType> LengthPerFloorPerPropUnitTypeList = new List<LengthPerFloorPerPropUnitType>();
        private List<QuotationItem> FixedItemsPerProjectList = new List<QuotationItem>();
        private List<QuotationItem> FixedItemsPerPropUnitList = new List<QuotationItem>();
        private List<FixedValues> FixedValuesList = new List<FixedValues>();
        private List<ItemsPerLength> ItemsPerLengthList = new List<ItemsPerLength>();
        private List<PropPerFloorAndUnitType> PropPerFloorAndUnitTypeList = new List<PropPerFloorAndUnitType>();
        private List<ConsolidatedQuotation> ConsolidatedQuotationList = new List<ConsolidatedQuotation>();
        private List<QuotationItem> quotationItemsToDelete = new List<QuotationItem>();
        private List<FixedValues> fixedValuesToDelete = new List<FixedValues>();
        private List<ItemsPerLength> itemsPerLengthToDelete = new List<ItemsPerLength>();
        private List<PropPerFloorAndUnitType> PropPerFloorAndUnitTypeToDelete = new List<PropPerFloorAndUnitType>();
        private List<itemTaskType> itemTaskTypeList = new List<itemTaskType>();
        private List<QuotationTaskType> taskTypeToDelete = new List<QuotationTaskType>();

        OpenGridDropDown ocItemsPerProject = null;
        OpenGridDropDown ocFixedItemsPerPropUnit = null;
        OpenGridDropDown ocItemsPerLength = null;
        OpenGridDropDown ocItemsPerPropUnit = null;

        //Implementación del Cargo por Conexión
        private List<QuotationItem> FixedItemsPerProjectCharConnList = new List<QuotationItem>();
        private List<QuotationItem> FixedItemsPerPropCharConnList = new List<QuotationItem>();
        private List<FixedValues> FixedValuesCharConnList = new List<FixedValues>();

        OpenGridDropDown ocItemsPerProjectChargConn = null;
        OpenGridDropDown ocFixedItemsPerPropUnitChargConn = null;


        private Int64 nuProjectId;
        private Int64 nuQuotationId;
        private Int64 nuQuotationConsecutive;
        private Int64 nuSubscriberCode;
        private Int64 nuInternalConnTaskType;
        private Int64 nuChargeConnTaskType;
        private Int64 nuCertificationTaskType;
        private String BasicConfiguration = "BC";
        private String QuotationDetail = "QD";
        private String QuotationSummary = "QS";
        private String AllData = "AD";
        private String OldArticleDesc = "";
        private Double prevIntConnPrice = 0;
        private Double newIntConnPrice = 0;
        private Double calculatedIntConnPrice = 0;
        private bool hasItems = false;
        private Double calculatedChargConnPrice = 0;
        private bool hasChargConnItems = false;

        private static String SelectCostListMessage = "Debe seleccionar la lista de costos";
        private static String InternalConnIsNotSelectedMessage = "Debe cotizar Instalación interna/Red Matriz para seleccionar items";
        private static String ChargConnIsNotSelectedMessage = "Debe cotizar cargo por conexión para seleccionar items";
        private DateTime? nullDateValue = null;
        private Int32? nullInt32Value = null;


        //caso 200-1460
        Boolean inicio = true;
        //
        String indice = "";
        //

        Int64 yesAplica;

        String isPlanIntEsp = "N";

        public FDRCC(Int64 nuCode)
        {
            InitializeComponent();
            yesAplica = general.AplicaEntrega(Constants.ENTREGA_200_2022);
            //Se inicializan los datos predeterminados
            InitializeData();

            indice = blFDRCC.getParam(BLGeneralQueries.dummyUnitWork, "Int64").ToString();

            //Se cargan los datos de acuerdo a la operación a realizar
            if (QuotationMode == OperationType.Register)
            {
                otcQuotation.Tabs[2].Enabled = false;
                otcQuotation.Tabs[3].Enabled = false;
                InitializeDataForQuotationRegister(nuCode);
            }
            else
            {
                btnPrintPreCup.Enabled = true;
                InitializeDataForQuotationModification(nuCode);
            }

            //caso 200-1460
            inicio = false;

            //se activa el boton "Imprimir Cotizacion" cuando se selecciona un valor del comboboc "cbFormatoImp"///
            if (yesAplica == 0)
            {
                btImprCot.Hide();
                cbFormatoImp.Hide();
            }


        }



        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 16-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData()
        {
            bsFixedItemsPerProject.DataSource = FixedItemsPerProjectList;
            bsFixedItemsPerPropUnit.DataSource = FixedItemsPerPropUnitList;
            bsFixedValuesPerPropUnit.DataSource = FixedValuesList;
            bsLenthPerFloorPropUnitType.DataSource = LengthPerFloorPerPropUnitTypeList;
            bsItemsPerLength.DataSource = ItemsPerLengthList;
            bsItemsPropUnit.DataSource = PropPerFloorAndUnitTypeList;
            bsConsolidatedQuotation.DataSource = ConsolidatedQuotationList;

            //Implementación del Cargo por Conexión
            bsItemsPerProjectChargConn.DataSource = FixedItemsPerProjectCharConnList;
            bsItemsPerPropUnitCharConn.DataSource = FixedItemsPerPropCharConnList;
            bsFixedValuesChargConn.DataSource = FixedValuesCharConnList;

            tbAddress.ReadOnly = true;

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Lista pesada de Localidades
            hlGeograLocation.Select_Statement = string.Join(string.Empty, new string[]{
                " select   ge_geogra_location.geograp_location_id ID, ",
                "   ge_geogra_location.display_description Description,  ",
                "   ge_geogra_location.display_description A  ",
                " from ge_geogra_location ",
                "@WHERE @",
                "@ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc @",
                "@geograp_location_id like :id @ ",
                "@upper(display_description) like :description @ "});

            //Se carga lista de estados de la cotización
            QuotationStatusList.Clear();
            QuotationStatusList.Add(new ListOfValues("R", "Registrada"));
            QuotationStatusList.Add(new ListOfValues("P", "Pre-aprobada"));
            QuotationStatusList.Add(new ListOfValues("A", "Aprobada"));
            QuotationStatusList.Add(new ListOfValues("N", "Anulada"));
            ocQuotationStatus.DataSource = QuotationStatusList;
            ocQuotationStatus.ValueMember = "Id";
            ocQuotationStatus.DisplayMember = "Description";

            //Se carga lista de forma de pago
            PaymentModalityList.Clear();
            PaymentModalityList.Add(new ListOfValues("CH", "Cheque"));
            PaymentModalityList.Add(new ListOfValues("CU", "Cuotas"));
            PaymentModalityList.Add(new ListOfValues("AV", "Avance de Obra"));
            ocPaymentModality.DataSource = PaymentModalityList;
            ocPaymentModality.ValueMember = "Id";
            ocPaymentModality.DisplayMember = "Description";

            //Se cargan los tipos de trabajo
            nuInternalConnTaskType = Convert.ToInt64(utilities.getParameterValue("TIPO_TRAB_RED_INTERNA", "Int64"));
            nuChargeConnTaskType = Convert.ToInt64(utilities.getParameterValue("TIPO_TRAB_CARG_CONEX", "Int64"));
            nuCertificationTaskType = Convert.ToInt64(utilities.getParameterValue("TIPO_TRAB_CERTIF", "Int64"));

            //Se cargan los IVA
            GeneralVariables.InternConnIVA = blFDRCC.GetPercentIntInstallation();
            GeneralVariables.CertificationIVA = Convert.ToDouble(utilities.getParameterValue("PORC_IVA_REVPER", "Int64"));
            GeneralVariables.ChargeByConnIVA = Convert.ToDouble(utilities.getParameterValue("PORC_IVA_CXC", "Int64"));
            GeneralVariables.ChargeByConnIVACost = Convert.ToDouble(utilities.getParameterValue("PORC_IVA_COSTO_CXC", "Int64"));

            //Se carga la lista de tipos de trabajo de instalación interna
            DataTable dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strInternalConnItems);

            ocInternalConnection.DataSource = dtItemsActivity;
            ocInternalConnection.DisplayMember = "Description";
            ocInternalConnection.ValueMember = "Id";

            //INICIO CA 200-2022
            //Se carga la lista de plan comercial especial
            DataTable dtPlanEspecial = utilities.getListOfValue(BLGeneralQueries.strSpecialPlan);

            cbx_planComerEsp.DataSource = dtPlanEspecial;
            cbx_planComerEsp.DisplayMember = "Description";
            cbx_planComerEsp.ValueMember = "Id";

            //Lista Valores Unidad de Trabajo Instaladora
            DataTable dtUndInstaladora = utilities.getListOfValue(BLGeneralQueries.strUndInstaladora);
            cbUndInstaladora.DataSource = dtUndInstaladora;
            cbUndInstaladora.ValueMember = "CODIGO";
            cbUndInstaladora.DisplayMember = "DESCRIPCION";

            //Lista Valores Unidad de Trabajo Certificadora
            DataTable dtUndCertificadora = utilities.getListOfValue(BLGeneralQueries.strUndCertificadora);
            cbUndCertificadora.DataSource = dtUndCertificadora;
            cbUndCertificadora.ValueMember = "CODIGO";
            cbUndCertificadora.DisplayMember = "DESCRIPCION";


            //FIN CA 200-2022
            //Se carga la lista de tipos de trabajo de cargo por conexión
            dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strChargeByConnItems);

            //Se carga la lista de tipos de trabajo de cargo por conexión
            ocChargeByConnection.DataSource = dtItemsActivity;
            ocChargeByConnection.DisplayMember = "Description";
            ocChargeByConnection.ValueMember = "Id";

            //Se carga la lista de tipos de trabajo de certificación
            dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strCertificationItems);

            //Se carga la lista de tipos de trabajo de certificación
            ocCertification.DataSource = dtItemsActivity;
            ocCertification.DisplayMember = "Description";
            ocCertification.ValueMember = "Id";

            itemTaskTypeList = blFDRCC.GetItemsByTaskType();

            //caso 200-1460
            //se agrega el origen para la lista de valores de contrastistas
            fillCursorCombo(cbx_contractor, "LDC_FRFLISTCONTRACTOR");


            // llenamos el combobox de impresion ///
            dtItemsActivity = utilities.getListOfValue("select 'R' Id, 'Formatos de Resumen' Description from dual union select 'M' Id, 'Formato de Red Matriz' Description from dual union select 'D' Id, 'Formato Detallado de Cantidades' Description from dual");

            cbFormatoImp.DataSource = dtItemsActivity;
            cbFormatoImp.DisplayMember = "Description";
            cbFormatoImp.ValueMember = "Id";

        }

        /// <summary>
        /// Se inicializan los datos para registro de cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeDataForQuotationRegister(Int64 projectId)
        {
            this.nuProjectId = projectId;

            //Inicializa la fecha de registro
            tbQuotationRegisterDate.TextBoxObjectValue = OpenDate.getSysDateOfDataBase();

            //Se cargan datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

            //Se inicializa el estado de la cotización
            ocQuotationStatus.Value = "R";

            //Se carga el metraje por piso y tipo
            LoadLengthPerFloorPropUnitType();

            //Se cargan los pisos y tipos por proyecto
            LoadFloorPropUnitType();

            if (projectBasicData.LocationId == null)
            {
                utilities.DisplayInfoMessage("Recuerde que: Debe definir la localidad del proyecto para poder escoger una lista de costos.");
            }
        }

        /// <summary>
        /// Se inicializan los datos para modificación de cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeDataForQuotationModification(Int64 quotationId)
        {
            nuQuotationId = quotationId;

            this.btnCopyQuotation.Enabled = true;
            this.btnApprove.Enabled = true;

            //Se valida si cotización existe
            if (!blFDRCC.QuotationExists(quotationId))
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

            //Se obtiene el proyecto de la cotización
            nuProjectId = blFDRCC.GetProjectOfQuotation(nuQuotationId);

            //Se cargan datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

            //Se cargan los datos básicos de la cotización
            LoadQuotationBasicData(quotationId);

            //Se cargan los tipos de trabajo
            LoadQuotationTaskType();


            //Caso 200-1640

            inicio = false;

            Int64 onuContratista;
            Int64 onuOperatingUnit;
            Int64 onuErrorCode;
            String osbErrorMessage;
            //MessageBox.Show("ccc");//quotationId
            blFDRCC.proCargaConstructora(nuQuotationConsecutive, Int64.Parse(tbProjectId.TextBoxValue), out onuContratista, out onuOperatingUnit, out onuErrorCode, out osbErrorMessage);

            //Contratista
            if (onuContratista != 0)
            {
                for (int i = 0; i <= cbx_contractor.Rows.Count - 1; i++)
                {
                    if (cbx_contractor.Rows[i].Cells[0].Value.ToString() == onuContratista.ToString())
                    {
                        cbx_contractor.SelectedRow = cbx_contractor.Rows[i];
                    }
                }
                //cbx_contractor.Enabled = false;
            }
            codContractors = onuContratista;
            //
            //Unidad
            if (onuOperatingUnit == 0)
            {
                onuOperatingUnit = Int64.Parse(blFDRCC.getParam(BLGeneralQueries.dummyUnitWork, "Int64").ToString());
                //fillCursorCombo(cbx_unitwork, "", "", "", "", true, onuOperatingUnit.ToString());
                DataSet dsgeneral = new DataSet();
                dsgeneral.Tables.Add("tabla");
                dsgeneral.Tables["tabla"].Columns.Add("ID");
                dsgeneral.Tables["tabla"].Columns.Add("DESCRIPTION");
                DataRow newCustomersRow = dsgeneral.Tables["tabla"].NewRow();

                //MessageBox.Show(indice.ToString());

                newCustomersRow["ID"] = Int16.Parse(indice);
                newCustomersRow["DESCRIPTION"] = "UNIDAD POR DEFECTO";

                dsgeneral.Tables["tabla"].Rows.Add(newCustomersRow);

                cbx_unitwork.DataSource = dsgeneral.Tables["tabla"];
                cbx_unitwork.ValueMember = "ID";
                cbx_unitwork.DisplayMember = "DESCRIPTION";
                //
                cbx_unitwork.SelectedRow = cbx_unitwork.Rows[0];
                //
                cbx_unitwork.Enabled = false;
                pn_bloque1.Enabled = false;
                //pendientes bloqueos
                //
                btnSave.Enabled = false;
                //btnSendToOSF.Enabled 
            }
            else
            {
                for (int i = 0; i <= cbx_unitwork.Rows.Count - 1; i++)
                {
                    if (cbx_unitwork.Rows[i].Cells[0].Value.ToString() == onuOperatingUnit.ToString())
                    {
                        cbx_unitwork.SelectedRow = cbx_unitwork.Rows[i];
                    }
                }
            }
            codUnitWork = onuOperatingUnit.ToString();

            inicio = true;

            //


            //Se cargan los pisos y tipos por proyecto
            LoadFloorPropUnitType();

            //Se cargan los ítems por proyecto para la instalación de interna
            LoadFixedItemsPerProject();

            //Se cargan los ítems fijos por unidad predial para la instalación de interna
            LoadFixedItemsPerPropUnit();

            //Se cargan los valores fijos para la instalación de interna
            LoadFixedValuesIntConn();

            //Se cargan los ítems por proyecto para el cargo por conexión
            LoadFixedItemsPerProjectChargConn();

            //Se cargan los ítems por unidad predial para el cargo por conexión
            LoadFixedItemsPerPropUnitChargConn();

            //Se cargan los valores fijos para el cargo por conexión
            LoadFixedValuesChargConn();

            //Se carga el metraje por piso y tipo de unidad
            LoadLengthPerFloorPropUnitType();

            //Se cargan los items por metraje
            LoadItemsPerLength();

            //Se cargan los items por apartamento
            //LoadParticularItemsPerFloorAndType();

            //Se cargan los items por metraje por apartamento
            LoadItemsPerLengthPerFloorAndType();

            //Se carga el resumen de la cotización
            LoadConsolidatedQuotation();
        }
        #endregion

        #region DataLoad
        /// <summary>
        /// Se cargan los datos básicos del proyecto y el cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectAndCustomerBasicData(Int64 projectId)
        {
            //Se inicializan datos básicos del proyecto
            LoadProjectBasicData(nuProjectId);

            //Se obtiene el código del cliente
            nuSubscriberCode = blFDMPC.GetProjectCustomer(nuProjectId);

            //Se inicializan datos básicos del cliente
            LoadCustomerBasicData(nuSubscriberCode);
        }

        /// <summary>
        /// Se cargan los datos básicos del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectBasicData(Int64 projectId)
        {
            //Se obtiene Datos Básicos del Proyecto
            projectBasicData = blFDMPC.GetProjectBasicData(projectId);

            //Se setean los datos básicos del proyecto en la patalla
            projectBasicData.ProjectId = projectId;
            tbProjectId.TextBoxValue = Convert.ToString(projectId);
            tbProjectName.TextBoxValue = projectBasicData.ProjectName;
            tbAddress.Address_id = Convert.ToString(projectBasicData.AddressId);
            hlGeograLocation.Value = projectBasicData.LocationId;
            ocPaymentModality.Value = projectBasicData.PaymentModality;
            tbUnitPropQuant.TextBoxValue = Convert.ToString(projectBasicData.UnitsPropTotal);
            tbPromissoryNote.TextBoxValue = projectBasicData.PrommissoryNote;
            tbContract.TextBoxValue = projectBasicData.Contract;
        }

        /// <summary>
        /// Se cargan los datos básicos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadCustomerBasicData(Int64 nuSubscriberCode)
        {
            //Se obtienen los datos básicos del cliente
            customerBasicData = blFDCPC.GetCustomerBasicData(nuSubscriberCode);

            //Se setean los datos básicos del cliente en la pantalla
            ocIdentificationType.Value = customerBasicData.IdentificationType;
            tbCustomerId.TextBoxValue = customerBasicData.Identification;
            tbCustomerName.TextBoxValue = customerBasicData.CustomerName;
        }

        /// <summary>
        /// Se cargan los datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadQuotationBasicData(Int64 nuQuotationId)
        {
            //Se obtienen los datos básicos de la cotización
            quotationBasicData = blFDRCC.GetQuotationBasicData(nuQuotationId);

            //Se setean los datos básicos de la cotización
            nuQuotationConsecutive = quotationBasicData.Consecutive;
            tbQuotationConsecutive.TextBoxValue = Convert.ToString(quotationBasicData.Consecutive);
            tbQuotedValue.TextBoxValue = Convert.ToString(quotationBasicData.QuotedValue);
            tbQuotationComment.TextBoxValue = Convert.ToString(quotationBasicData.Comment);
            hlCostList.Value = quotationBasicData.CostList;
            ocQuotationStatus.Value = quotationBasicData.Status;
            tbQuotationRegisterDate.TextBoxObjectValue = quotationBasicData.RegisterDate;
            tbQuotationValidityDate.TextBoxObjectValue = quotationBasicData.ValidityDate;
            tbQuotationLastModifDate.TextBoxObjectValue = quotationBasicData.LastModDate;
            //INICIO CA 200-2022
            cbx_planComerEsp.Value = quotationBasicData.PlanComercEsp;
            cbUndInstaladora.Value = quotationBasicData.UnidadInstaladora;
            cbUndCertificadora.Value = quotationBasicData.UnidadCertificadora;
            //FIN CA 200-2022
            //INICIO CA 153
           // Int64 valor = 1;
            if (quotationBasicData.Flagaso == "S"){
                if (!chkFlagaso.Checked) {
                    chkFlagaso.CheckState = CheckState.Checked;
                }
               
            }else {
                if (chkFlagaso.Checked)
                {
                    chkFlagaso.CheckState = CheckState.Unchecked;
                }
            }
            
           
            //FIN CA 153
        }

        /// <summary>
        /// Se cargan los tipos de trabajo de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadQuotationTaskType()
        {
            List<QuotationTaskType> quotationTaskTypeList;
            quotationTaskTypeList = blFDRCC.GetQuotationTaskType(nuProjectId, nuQuotationConsecutive);

            foreach (QuotationTaskType item in quotationTaskTypeList)
            {
                if (item.TaskTypeClassif == Constants.INTERNAL_CON_CLASS)
                {
                    ocInternalConnection.Value = item.ItemId;
                    nuInternalConnTaskType = item.TaskType;
                }

                if (item.TaskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
                {
                    ocChargeByConnection.Value = item.ItemId;
                    nuChargeConnTaskType = item.TaskType;
                }

                if (item.TaskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                    ocCertification.Value = item.ItemId;
                    nuCertificationTaskType = item.TaskType;
                }
            }
        }

        /// <summary>
        /// Se cargan los ítems fijos por proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedItemsPerProject()
        {
            FixedItemsPerProjectList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FP", nuInternalConnTaskType);
            //FixedItemsPerProjectList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FP", Constants.INTERNAL_CON_CLASS); //TODO
            bsFixedItemsPerProject.DataSource = FixedItemsPerProjectList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {

                foreach (QuotationItem item in FixedItemsPerProjectList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    tmpQuotationItem.Price = tmpQuotationItem.Price / projectBasicData.UnitsPropTotal;
                    tmpQuotationItem.Cost = tmpQuotationItem.Cost / projectBasicData.UnitsPropTotal;
                    tmpQuotationItem.TotalPrice = tmpQuotationItem.Price * tmpQuotationItem.Amount;
                    tmpQuotationItem.TotalCost = tmpQuotationItem.Cost * tmpQuotationItem.Amount;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Se cargan los ítems fijos por proyecto del cargo por conexión
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 12-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedItemsPerProjectChargConn()
        {
            //Implementación del cargo por conexión
            FixedItemsPerProjectCharConnList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FP", nuChargeConnTaskType);
            //FixedItemsPerProjectCharConnList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FP", Constants.CHARGE_BY_CON_CLASS); //TODO
            bsItemsPerProjectChargConn.DataSource = FixedItemsPerProjectCharConnList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (QuotationItem item in FixedItemsPerProjectCharConnList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    tmpQuotationItem.Price = tmpQuotationItem.Price / projectBasicData.UnitsPropTotal;
                    tmpQuotationItem.Cost = tmpQuotationItem.Cost / projectBasicData.UnitsPropTotal;
                    tmpQuotationItem.TotalPrice = tmpQuotationItem.Price * tmpQuotationItem.Amount;
                    tmpQuotationItem.TotalCost = tmpQuotationItem.Cost * tmpQuotationItem.Amount;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Se cargan los ítems fijos por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedItemsPerPropUnit()
        {
            FixedItemsPerPropUnitList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FU", nuInternalConnTaskType);
            //FixedItemsPerPropUnitList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FU", Constants.INTERNAL_CON_CLASS); //TODO
            bsFixedItemsPerPropUnit.DataSource = FixedItemsPerPropUnitList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (QuotationItem item in FixedItemsPerPropUnitList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);

                }
            }

            refreshItemsPropUnit();

        }

        /// <summary>
        /// Se cargan los ítems fijos por unidad predial para el cargo por conexión
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 12-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedItemsPerPropUnitChargConn()
        {
            //Implementación del cargo por conexión
            FixedItemsPerPropCharConnList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FU", nuChargeConnTaskType);
            //FixedItemsPerPropCharConnList = blFDRCC.GetFixedItems(nuProjectId, nuQuotationConsecutive, "FU", Constants.CHARGE_BY_CON_CLASS); //TODO
            bsItemsPerPropUnitCharConn.DataSource = FixedItemsPerPropCharConnList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (QuotationItem item in FixedItemsPerPropCharConnList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Se refresca la grilla de items por piso y tipo
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 12-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void refreshItemsPropUnit()
        {
            bsItemsPropUnit.ResetBindings(true);
            this.ugItemsPerPropUnit.Rows.Refresh(RefreshRow.ReloadData, true);
        }

        /// <summary>
        /// Se cargan los valores fijos de la instalación interna
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedValuesIntConn()
        {
            FixedValuesList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, nuInternalConnTaskType);
            //FixedValuesList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, Constants.INTERNAL_CON_CLASS); //TODO
            bsFixedValuesPerPropUnit.DataSource = FixedValuesList;

            //Implementación de cargo por conexión
            FixedValuesCharConnList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, nuChargeConnTaskType);
            //FixedValuesCharConnList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, Constants.CHARGE_BY_CON_CLASS); //TODO
            bsFixedValuesChargConn.DataSource = FixedValuesCharConnList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (FixedValues item in FixedValuesList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Se cargan los valores fijos para el cargo por conexión
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 12-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFixedValuesChargConn()
        {
            FixedValuesCharConnList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, nuChargeConnTaskType);
            //FixedValuesCharConnList = blFDRCC.GetFixedValues(nuProjectId, nuQuotationConsecutive, Constants.CHARGE_BY_CON_CLASS); //TODO
            bsFixedValuesChargConn.DataSource = FixedValuesCharConnList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (FixedValues item in FixedValuesCharConnList)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(item);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Se carga el metraje por piso y tipo de unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadLengthPerFloorPropUnitType()
        {
            LengthPerFloorPerPropUnitTypeList = blFDRCC.GetLengthPerFloorPerPropUnitType(nuProjectId, nuQuotationConsecutive, QuotationMode);
            bsLenthPerFloorPropUnitType.DataSource = LengthPerFloorPerPropUnitTypeList;
        }

        /// <summary>
        /// Se carga los pisos y tipos de unidades prediales por proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 24-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadFloorPropUnitType()
        {
            PropPerFloorAndUnitTypeList = blFDRCC.GetFloorPropUnitType(nuProjectId);

            this.bsItemsPropUnit.DataSource = PropPerFloorAndUnitTypeList;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                pisoTipo.QuotationItemList = new List<QuotationItem>();
            }
        }

        /// <summary>
        /// Se cargan los ítems por metraje
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadItemsPerLength()
        {
            ItemsPerLengthList = blFDRCC.GetItemsPerLength(nuProjectId, nuQuotationConsecutive);
            bsItemsPerLength.DataSource = ItemsPerLengthList;
        }

        /// <summary>
        /// Se cargan los ítems por metraje por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-06-2017  KCienfuegos            2 - Se modifica para obtener los items por la clasificación del tipo
        ///                                    de trabajo, y no por el tipo de trabajo
        /// 01-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadItemsPerLengthPerFloorAndType()
        {
            List<QuotationItem> tmpQuotationItemList = blFDRCC.GetItemsPerPropUnit(nuProjectId, nuQuotationConsecutive, "IM", nuInternalConnTaskType);
            //List<QuotationItem> tmpQuotationItemList = blFDRCC.GetItemsPerPropUnit(nuProjectId, nuQuotationConsecutive, "IM", Constants.INTERNAL_CON_CLASS); //TODO

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                foreach (QuotationItem item in tmpQuotationItemList)
                {
                    if (item.FloorId == pisoTipo.FloorId && item.PropUnitTypeId == pisoTipo.PropUnitType)
                    {
                        pisoTipo.QuotationItemList.Add(item);
                    }
                }
            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Método para cargar el consolidado de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadConsolidatedQuotation()
        {
            ConsolidatedQuotationList = blFDRCC.GetConsolidatedQuotation(nuProjectId, nuQuotationConsecutive);
            bsConsolidatedQuotation.DataSource = ConsolidatedQuotationList;
        }
        #endregion

        /// <summary>
        /// Método para setear datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SetQuotationBasicData()
        {
            quotationBasicData = new QuotationBasicData();
            quotationBasicData.Consecutive = nuQuotationConsecutive;
            quotationBasicData.ProjectId = nuProjectId;
            quotationBasicData.QuotedValue = Convert.ToDouble(tbQuotedValue.TextBoxValue);
            quotationBasicData.Comment = tbQuotationComment.TextBoxValue;
            //INICIO CA 200-2022
            quotationBasicData.PlanComercEsp = String.IsNullOrEmpty(Convert.ToString(cbx_planComerEsp.Value)) ? nullInt32Value : Convert.ToInt32(cbx_planComerEsp.Value);
            quotationBasicData.UnidadInstaladora = String.IsNullOrEmpty(Convert.ToString(cbUndInstaladora.Value)) ? nullInt32Value : Convert.ToInt32(cbUndInstaladora.Value);
            quotationBasicData.UnidadCertificadora = String.IsNullOrEmpty(Convert.ToString(cbUndCertificadora.Value)) ? nullInt32Value : Convert.ToInt32(cbUndCertificadora.Value);

            //FIN CA 200-2022
            //INICIO CA 153
            if (chkFlagaso.Checked)
            {
                quotationBasicData.Flagaso = "S";
            }
            else
            {
                quotationBasicData.Flagaso = "N";
            }
           
           //FIN CA 153
            quotationBasicData.CostList = String.IsNullOrEmpty(Convert.ToString(hlCostList.Value)) ? nullInt32Value : Convert.ToInt32(hlCostList.Value);
            quotationBasicData.ValidityDate = String.IsNullOrEmpty(Convert.ToString(tbQuotationValidityDate.TextBoxObjectValue)) ? nullDateValue : Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue);
        }

        /// <summary>
        /// Método para setear datos básicos del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SetProjectBasicData()
        {
            projectBasicData.Contract = Convert.ToString(tbContract.TextBoxValue);
            projectBasicData.PrommissoryNote = Convert.ToString(tbPromissoryNote.TextBoxValue);
            projectBasicData.PaymentModality = Convert.ToString(ocPaymentModality.Value);
        }

        /// <summary>
        /// Método para validar si cambiaron los datos básicos del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool ProjectBasicDataChanged()
        {
            bool result = false;

            if (projectBasicData.PrommissoryNote != Convert.ToString(tbPromissoryNote.TextBoxValue))
            {
                result = true;
            }

            if (projectBasicData.Contract != Convert.ToString(tbContract.TextBoxValue))
            {
                result = true;
            }

            if (projectBasicData.PaymentModality != Convert.ToString(ocPaymentModality.Value))
            {
                result = true;
            }

            return result;
        }

        /// <summary>
        /// Método para validar si cambiaron los datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool QuotationBasicDataChanged()
        {
            bool result = false;

            if (quotationBasicData.QuotedValue != Convert.ToDouble(tbQuotedValue.TextBoxValue))
            {
                quotationBasicData.QuotedValue = Convert.ToDouble(tbQuotedValue.TextBoxValue);
                result = true;
            }

            if (quotationBasicData.Comment != tbQuotationComment.TextBoxValue)
            {
                quotationBasicData.Comment = tbQuotationComment.TextBoxValue;
                result = true;
            }

            if (quotationBasicData.CostList != Convert.ToInt32(hlCostList.Value))
            {
                quotationBasicData.CostList = Convert.ToInt32(hlCostList.Value);
                result = true;
            }
            //inicio ca 200-2022
            if (quotationBasicData.PlanComercEsp != Convert.ToInt32(cbx_planComerEsp.Value))
            {
                quotationBasicData.PlanComercEsp = Convert.ToInt32(cbx_planComerEsp.Value);
                result = true;
            }
            if (quotationBasicData.UnidadInstaladora != Convert.ToInt32(cbUndInstaladora.Value))
            {
                quotationBasicData.UnidadInstaladora = Convert.ToInt32(cbUndInstaladora.Value);
                result = true;
            }
            if (quotationBasicData.UnidadCertificadora != Convert.ToInt32(cbUndCertificadora.Value))
            {
                quotationBasicData.UnidadCertificadora = Convert.ToInt32(cbUndCertificadora.Value);
                result = true;
            }
            //fin ca 200-2022
            //INICIO CA 153
            if (chkFlagaso.Checked && quotationBasicData.Flagaso == "N")
            {
                quotationBasicData.Flagaso = "S";
                result = true;
            }
            else
            {
                if (!chkFlagaso.Checked && quotationBasicData.Flagaso == "S")
                {
                    quotationBasicData.Flagaso = "N";
                    result = true;
                }
                
            }
            //FIN CA 153
           

            if (quotationBasicData.ValidityDate != Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue))
            {
                quotationBasicData.ValidityDate = Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue);
                result = true;
            }

            return result;
        }

        #region SaveData
        /// <summary>
        /// Método para registrar los datos básicos de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveQuotationBasicData()
        {
            if (QuotationMode == OperationType.Register)
            {
                SetQuotationBasicData();
                nuQuotationConsecutive = blFDRCC.RegisterQuotationBasicData(quotationBasicData);
            }
            else
            {
                if (QuotationBasicDataChanged())
                {
                    SetQuotationBasicData();
                    blFDRCC.UpdateQuotationBasicData(quotationBasicData);
                }
            }

            if (ProjectBasicDataChanged())
            {
                SetProjectBasicData();
                blFDRCC.UpdateProjectData(projectBasicData);
            }
        }

        /// <summary>
        /// Método para registrar los tipos de trabajo de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveTaskTypeQuotation()
        {
            foreach (QuotationTaskType item in taskTypeToDelete)
            {
                if (item.Operation == "D")
                {
                    blFDRCC.UpdateQuotationTaskType(item);
                }
            }

            foreach (ConsolidatedQuotation item in bsConsolidatedQuotation)
            {
                if (QuotationMode == OperationType.Register || item.Operation == "R")
                {
                    item.Quotation = nuQuotationConsecutive;
                    blFDRCC.RegisterQuotationTaskType(item);
                }

                if (item.Operation == "U")
                {
                    item.Quotation = nuQuotationConsecutive;
                    blFDRCC.UpdateQuotationTaskType(new QuotationTaskType(item));
                }
            }
        }

        /// <summary>
        /// Método para registrar los ítems por proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveFixedItemsPerProject(out Boolean findError)
        {

            //Caso 200-1640
            //18.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationConsecutive.ToString());
            Int64 numberId = 0;
            String ClaseDesc = "";

            //Se registran/actualizan los ítems por proyecto de instalación interna
            foreach (QuotationItem item in bsFixedItemsPerProject)
            {
                if (QuotationMode == OperationType.Register || item.Operation == "R")
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterFixedItems(item);

                    //Caso 200-1640
                    //18.07.18
                    numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                    ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                    blFDRCC.proRegistraConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateFixedItems(item);

                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                        ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                        blFDRCC.proActualizaConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                }
            }

            if (!error)
            {
                //Se registran/actualizan los ítems por proyecto del cargo por conexión
                foreach (QuotationItem item in bsItemsPerProjectChargConn)
                {
                    if (QuotationMode == OperationType.Register || item.Operation == "R")
                    {
                        item.QuotationId = nuQuotationConsecutive;
                        blFDRCC.RegisterFixedItems(item);

                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                        ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                        blFDRCC.proRegistraConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proRegistraConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                    else
                    {
                        if (item.Operation == "U")
                        {
                            blFDRCC.UpdateFixedItems(item);

                            //Caso 200-1640
                            //18.07.18
                            numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                            ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                            blFDRCC.proActualizaConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                            //MessageBox.Show("proActualizaConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                            if (onuErrorCode != 0)
                            {
                                error = true;
                            }
                        }
                    }
                }
            }

            findError = error;
        }

        /// <summary>
        /// Método para registrar los ítems por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveFixedItemsPerPropUnit(out Boolean findError)
        {

            //Caso 200-1640
            //18.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationConsecutive.ToString());
            String ClaseDesc = "";
            Int64 numberId = 0;

            //Se registran/actualizan los ítems fijos por unidad de la instalación interna
            foreach (QuotationItem item in bsFixedItemsPerPropUnit)
            {
                if (QuotationMode == OperationType.Register || item.Operation == "R")
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterFixedItems(item);
                    //Caso 200-1640
                    //18.07.18
                    numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                    ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                    blFDRCC.proRegistraConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateFixedItems(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                        ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                        blFDRCC.proActualizaConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                }
            }

            if (!error)
            {
                //Se registran/actualizan los ítems fijos por unidad del cargo por conexión
                foreach (QuotationItem item in bsItemsPerPropUnitCharConn)
                {
                    if (QuotationMode == OperationType.Register || item.Operation == "R")
                    {
                        item.QuotationId = nuQuotationConsecutive;
                        blFDRCC.RegisterFixedItems(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                        ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                        blFDRCC.proRegistraConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proRegistraConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                    else
                    {
                        if (item.Operation == "U")
                        {
                            blFDRCC.UpdateFixedItems(item);
                            //Caso 200-1640
                            //18.07.18
                            numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                            ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                            blFDRCC.proActualizaConstructoraItem(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, item.ItemType, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                            //MessageBox.Show("proActualizaConstructoraItem - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.ItemType + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                            if (onuErrorCode != 0)
                            {
                                error = true;
                            }
                        }
                    }
                }
            }

            findError = error;
        }

        /// <summary>
        /// Método para registrar los valores fijos
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveFixedValues(out Boolean findError)
        {

            //Caso 200-1640
            //18.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationConsecutive.ToString());
            Int64 numberId = 0;
            String ClaseDesc = "";

            //Se registran/actualizan los valores fijos de la interna
            foreach (FixedValues item in bsFixedValuesPerPropUnit)
            {
                if (QuotationMode == OperationType.Register)
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterFixedValues(item);
                    //Caso 200-1640
                    //18.07.18
                    numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                    ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                    blFDRCC.proRegistraItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateFixedValues(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                        ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                        blFDRCC.proActualizaItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                    if (item.Operation == "R")
                    {
                        item.QuotationId = nuQuotationConsecutive;
                        blFDRCC.RegisterFixedValues(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                        ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                        blFDRCC.proRegistraItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proRegistraItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                }
            }

            //Se registran/actualizan los valores fijos del cargo por conexión
            foreach (FixedValues item in bsFixedValuesChargConn)
            {
                if (QuotationMode == OperationType.Register)
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterFixedValues(item);
                    //Caso 200-1640
                    //18.07.18
                    numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                    ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                    blFDRCC.proRegistraItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateFixedValues(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                        ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                        blFDRCC.proActualizaItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
                    }
                    if (item.Operation == "R")
                    {
                        item.QuotationId = nuQuotationConsecutive;
                        blFDRCC.RegisterFixedValues(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.Consecutive.ToString());//.Substring(0, item.Consecutive.Length - 1).ToString());
                        ClaseDesc = "C";//item.Consecutive.Substring(item.Consecutive.Length - 1, 1);
                        blFDRCC.proRegistraItemValFijos(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, Int64.Parse(item.TaskType.ToString()), ClaseDesc, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proRegistraItemValFijos - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + item.TaskType.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            error = true;
                        }
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
        /// Método para registrar el metraje por tipo y piso
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveLengthPerFloorPropUnitType()
        {
            foreach (LengthPerFloorPerPropUnitType item in bsLenthPerFloorPropUnitType)
            {
                if (QuotationMode == OperationType.Register)
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterLengthPerFloorPropUnitType(item);
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateLengthPerFloorPerPropUnitType(item);
                    }
                }
            }
        }

        /// <summary>
        /// Método para registrar los ítems por metraje
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveItemsPerLength(out Boolean findError)
        {

            //Caso 200-1640
            //18.07.18
            //Aplicacion de servicios Ing Tapias
            Int64 onuErrorCode = 0;
            String osbErrorMessage = "";
            Boolean error = false;
            Int64 InuPackageID = Int64.Parse(nuQuotationConsecutive.ToString());
            String ClaseDesc = "";
            Int64 numberId = 0;

            foreach (ItemsPerLength item in bsItemsPerLength)
            {
                if (QuotationMode == OperationType.Register || item.Operation == "R")
                {
                    item.QuotationId = nuQuotationConsecutive;
                    blFDRCC.RegisterItemsPerLength(item, nuInternalConnTaskType);
                    //Caso 200-1640
                    //18.07.18
                    numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                    ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                    blFDRCC.proRegistraItemMetraje(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, ClaseDesc, out onuErrorCode, out osbErrorMessage);
                    //MessageBox.Show("proRegistraItemMetraje - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + ClaseDesc + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                    if (onuErrorCode != 0)
                    {
                        error = true;
                    }
                }
                else
                {
                    if (item.Operation == "U")
                    {
                        blFDRCC.UpdateItemsPerLength(item);
                        //Caso 200-1640
                        //18.07.18
                        numberId = Int64.Parse(item.ItemId.Substring(0, item.ItemId.Length - 1).ToString());
                        ClaseDesc = item.ItemId.Substring(item.ItemId.Length - 1, 1);
                        blFDRCC.proActualizaItemMetraje(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), numberId, ClaseDesc, item.Operation, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaItemMetraje - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + numberId.ToString() + " - " + ClaseDesc + " - " + item.Operation + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
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
        /// Método para registrar el consolidado de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveConsolidatedQuotation()
        {
            foreach (ConsolidatedQuotation item in bsConsolidatedQuotation)
            {
                if (QuotationMode == OperationType.Register || item.Operation == "R")
                {
                    item.Quotation = nuQuotationConsecutive;
                    blFDRCC.RegisterConsolidatedQuotation(item);
                }
                else if (item.Operation == "U")
                {
                    blFDRCC.UpdateConsolidatedQuotation(item);
                }
            }
        }

        private void DeleteQuotationItems()
        {
            //Se borran los ítems fijos por proyecto y por unidad predial
            for (int i = 0; i < quotationItemsToDelete.Count; i++)
            {
                if (quotationItemsToDelete[i].ItemType != "IU")
                {
                    blFDRCC.UpdateFixedItems(quotationItemsToDelete[i]);
                }
            }

            //Se borran los valores fijos
            for (int i = 0; i < fixedValuesToDelete.Count; i++)
            {
                blFDRCC.UpdateFixedValues(fixedValuesToDelete[i]);
            }

            //Se borran los ítems por metraje
            for (int i = 0; i < itemsPerLengthToDelete.Count; i++)
            {
                blFDRCC.UpdateItemsPerLength(itemsPerLengthToDelete[i]);
            }

        }

        private void SaveChanges(out Boolean findError)
        {
            findError = false;
            if (!string.IsNullOrEmpty(Convert.ToString(nuProjectId)))
            {
                try
                {
                    Cursor.Current = Cursors.WaitCursor;
                    SaveQuotationBasicData();

                    //
                    //Caso 200-1640
                    //16.07.18
                    //Aplicacion de servicios Ing Tapias
                    Int64 onuErrorCode = 0;
                    String osbErrorMessage = "";
                    Boolean error = false;
                    Int64 InuPackageID = Int64.Parse(nuQuotationConsecutive.ToString());//nuQuotationId.ToString());
                    Int64 InuOperatingUnit = Int64.Parse(cbx_unitwork.Value.ToString());
                    Int64 InuContratista = Int64.Parse(cbx_contractor.Value.ToString());

                    if (QuotationMode == OperationType.Register)
                    {
                        blFDRCC.proRegistraConstructora(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), InuContratista, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proRegistraConstructora - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue + " - " + InuContratista.ToString() + " - " + InuOperatingUnit.ToString() + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            findError = true;
                        }
                    }
                    else
                    {
                        blFDRCC.proActualizaConstructora(InuPackageID, Int64.Parse(tbProjectId.TextBoxValue), InuContratista, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
                        //MessageBox.Show("proActualizaConstructora - " + InuPackageID.ToString() + " - " + tbProjectId.TextBoxValue +" - " + InuContratista.ToString() + " - " + InuOperatingUnit.ToString() + " - " + onuErrorCode.ToString() + " - " + osbErrorMessage);
                        if (onuErrorCode != 0)
                        {
                            findError = true;
                        }
                    }
                    //
                    if (!findError)
                    {
                        if (nuQuotationConsecutive != 0)
                        {
                            DeleteQuotationItems();
                            SaveTaskTypeQuotation();
                            SaveFixedItemsPerProject(out findError);
                            if (!findError)
                            {
                                SaveFixedItemsPerPropUnit(out findError);
                            }
                            if (!findError)
                            {
                                SaveFixedValues(out findError);
                            }
                            if (!findError)
                            {
                                SaveLengthPerFloorPropUnitType();
                            }
                            if (!findError)
                            {
                                SaveItemsPerLength(out findError);
                            }
                            /*if (!findError)
                            {
                                SaveConsolidatedQuotation(out findError);
                            }*/
                            SaveConsolidatedQuotation();

                            if (!findError)
                            {

                                utilities.doCommit();

                                if (QuotationMode == OperationType.Register)
                                {
                                    utilities.DisplayInfoMessage("Se generó la cotización con consecutivo " + nuQuotationConsecutive +
                                                                 " para el proyecto " + nuProjectId + "-" + projectBasicData.ProjectName);
                                    this.Dispose();
                                }
                                else
                                {
                                    utilities.DisplayInfoMessage("La cotización fue actualizada exitosamente ");
                                    this.Dispose();
                                }
                            }
                        }
                        else
                        {
                            utilities.DisplayErrorMessage("No fue posible registrar cotización");
                        }
                    }
                    else
                    {
                        utilities.doRollback();
                    }

                    Cursor.Current = Cursors.Default;
                }
                catch (Exception ex)
                {
                    //Si se genera error, se reversan cambios
                    utilities.doRollback();

                    Cursor.Current = Cursors.Default;

                    if (QuotationMode == OperationType.Register)
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                    else
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);
                        this.Dispose();
                    }
                }
            }
        }
        #endregion

        #region ListValuesChanges
        //caso 200-1460
        private void hlGeograLocation_ValueChanged(object sender, EventArgs e)
        {
            //Se bloquea el codigo pues ya no se revisa por este criterio la lista de costos
            /*if (!string.IsNullOrEmpty(Convert.ToString(hlGeograLocation.Value)))
            {
                hlCostList.Value = null;
                hlCostList.Select_Statement = string.Join(string.Empty, new string[] { 
                " select   list_unitary_cost_id id, ",
                "   description description,  ",
                "   validity_start_date fecha_inicial_vigencia,  ",
                "   validity_final_date fecha_final_vigencia  ",
                " from ge_list_unitary_cost ",
                "@where @",
                "@geograp_location_id = "+hlGeograLocation.Value+" @",
                "@validity_start_date <=sysdate @",
                "@validity_final_date >=sysdate @",
                "@list_unitary_cost_id like :id @",
                "@upper(description) like :description @ "});
            }
            else
            {
                hlCostList.Value = null;
                hlCostList.Select_Statement = "";
            }*/
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// Se modifico para el caso 200-1640 para que pudiera validar selecciones nulas y reestableceria selecciones previas segun el caso
        private void hlPriceList_ValueChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(hlCostList.Value)))
            {

                //Se obtienen los ítems asociados a los tipos de trabajo seleccionados
                itemsList = blFDRCC.GetPriceListItems(Convert.ToInt64(hlCostList.Value));

                //validacion Grillas
                Int64 contError = 0;

                //grilla 1
                foreach (QuotationItem item in bsFixedItemsPerProject)
                {
                    LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });
                    if (tmpLovItem == null)
                    {
                        contError++;
                    }
                }
                //grilla 2
                foreach (QuotationItem item in bsFixedItemsPerPropUnit)
                {
                    LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });
                    if (tmpLovItem == null)
                    {
                        contError++;
                    }
                }
                //grilla 3
                foreach (QuotationItem item in bsItemsPerProjectChargConn)
                {
                    LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });
                    if (tmpLovItem == null)
                    {
                        contError++;
                    }
                }
                //grilla 4
                foreach (QuotationItem item in bsItemsPerPropUnitCharConn)
                {
                    LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });
                    if (tmpLovItem == null)
                    {
                        contError++;
                    }
                }

                if (contError > 0)
                {
                    Question pregunta = new Question("FDRCC - Aplicar Cambios", "Esta seguro que desea Aplicar los Cambios, hay items que no se hallan en la nueva lista de costo seleccionada?", "Si", "No");
                    pregunta.ShowDialog();
                    //si responde que si
                    if (pregunta.answer == 2)
                    {
                        codListCost = hlCostList.Value.ToString();
                    }
                    else
                    {
                        inicio = true;
                        cbx_unitwork.Value = Int64.Parse(codUnitWork);
                        //
                        hlCostList.Select_Statement = string.Join(string.Empty, new string[] { 
                        " select   list_unitary_cost_id id, ",
                        "   description description,  ",
                        "   validity_start_date fecha_inicial_vigencia,  ",
                        "   validity_final_date fecha_final_vigencia  ",
                        " from ge_list_unitary_cost ",
                        "@where @",
                        "@operating_unit_id = " + cbx_unitwork.Value+" @",
                        "@validity_start_date <=sysdate @",
                        "@validity_final_date >=sysdate @",
                        "@list_unitary_cost_id like :id @",
                        "@upper(description) like :description @ "});
                        //
                        inicio = false;
                        /*if (codListCost != "")
                        {*/
                        itemsList = blFDRCC.GetPriceListItems(Convert.ToInt64(codListCost));
                        hlCostList.Value = Int64.Parse(codListCost);
                        /*}
                        else
                        {
                        }*/
                        //return;
                    }
                }
                else
                {
                    codListCost = hlCostList.Value.ToString();
                }


                ocItemsPerProject = this.DropDownListsMaker(itemsList);

                ocFixedItemsPerPropUnit = this.DropDownListsMaker(itemsList);

                ocItemsPerLength = this.DropDownListsMaker(itemsList);

                ocItemsPerPropUnit = this.DropDownListsMaker(itemsList);

                ocItemsPerProject.SetDataBinding(itemsList, null);

                ocFixedItemsPerPropUnit.SetDataBinding(itemsList, null);

                ocItemsPerLength.SetDataBinding(itemsList, null);

                ocItemsPerPropUnit.SetDataBinding(itemsList, null);

                ocFixedItemsPerPropUnit.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnitType_RowSelected);

                ocItemsPerProject.RowSelected += new RowSelectedEventHandler(ocItemsPerProject_RowSelected);

                ocItemsPerLength.RowSelected += new RowSelectedEventHandler(ocItemsPerLength_RowSelected);

                ocItemsPerPropUnit.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnit_RowSelected);

                ugFixedItemsPerProject.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerProject;

                ugFixedItemsPerPropUnit.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocFixedItemsPerPropUnit;

                ugItemsPerLength.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerLength;

                ugItemsPerPropUnit.DisplayLayout.Bands[1].Columns["ItemDescription"].ValueList = ocItemsPerPropUnit;


                //Implementación del Cargo por Conexión

                ocItemsPerProjectChargConn = this.DropDownListsMaker(itemsList);

                ocFixedItemsPerPropUnitChargConn = this.DropDownListsMaker(itemsList);

                ocItemsPerProjectChargConn.SetDataBinding(itemsList, null);

                ocFixedItemsPerPropUnitChargConn.SetDataBinding(itemsList, null);

                ocFixedItemsPerPropUnitChargConn.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnitChargConn_RowSelected);

                ocItemsPerProjectChargConn.RowSelected += new RowSelectedEventHandler(ocItemsPerProjectChargConn_RowSelected);

                ugItemsPerProjectChargConn.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerProjectChargConn;

                ugItemsPerPropUnitChargConn.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocFixedItemsPerPropUnitChargConn;

                //****************************************//

                updateCostsValue();
            }
            else
            {
                //consulto al usuario si desea aplicar los cambios
                Question pregunta = new Question("FDRCC - Aplicar Cambios", "Esta seguro que desea Aplicar los Cambios, no tiene asociada ninguna Lista?", "Si", "No");
                pregunta.ShowDialog();
                //si responde que si
                if (pregunta.answer == 2)
                {
                    codListCost = "";

                    itemsList.Clear();

                    ocItemsPerProject = this.DropDownListsMaker(itemsList);

                    ocFixedItemsPerPropUnit = this.DropDownListsMaker(itemsList);

                    ocItemsPerLength = this.DropDownListsMaker(itemsList);

                    ocItemsPerPropUnit = this.DropDownListsMaker(itemsList);

                    ocItemsPerProject.SetDataBinding(itemsList, null);

                    ocFixedItemsPerPropUnit.SetDataBinding(itemsList, null);

                    ocItemsPerLength.SetDataBinding(itemsList, null);

                    ocItemsPerPropUnit.SetDataBinding(itemsList, null);

                    ocFixedItemsPerPropUnit.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnitType_RowSelected);

                    ocItemsPerProject.RowSelected += new RowSelectedEventHandler(ocItemsPerProject_RowSelected);

                    ocItemsPerLength.RowSelected += new RowSelectedEventHandler(ocItemsPerLength_RowSelected);

                    ocItemsPerPropUnit.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnit_RowSelected);

                    ugFixedItemsPerProject.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerProject;

                    ugFixedItemsPerPropUnit.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocFixedItemsPerPropUnit;

                    ugItemsPerLength.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerLength;

                    ugItemsPerPropUnit.DisplayLayout.Bands[1].Columns["ItemDescription"].ValueList = ocItemsPerPropUnit;


                    //Implementación del Cargo por Conexión

                    ocItemsPerProjectChargConn = this.DropDownListsMaker(itemsList);

                    ocFixedItemsPerPropUnitChargConn = this.DropDownListsMaker(itemsList);

                    ocItemsPerProjectChargConn.SetDataBinding(itemsList, null);

                    ocFixedItemsPerPropUnitChargConn.SetDataBinding(itemsList, null);

                    ocFixedItemsPerPropUnitChargConn.RowSelected += new RowSelectedEventHandler(ocItemsPerPropUnitChargConn_RowSelected);

                    ocItemsPerProjectChargConn.RowSelected += new RowSelectedEventHandler(ocItemsPerProjectChargConn_RowSelected);

                    ugItemsPerProjectChargConn.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocItemsPerProjectChargConn;

                    ugItemsPerPropUnitChargConn.DisplayLayout.Bands[0].Columns["ItemDescription"].ValueList = ocFixedItemsPerPropUnitChargConn;

                    //****************************************//

                    updateCostsValue();
                }
                else
                {
                    if (codListCost != "")
                    {
                        hlCostList.Value = Int64.Parse(codListCost);
                    }
                }
            }
        }

        private void updateCostsValue()
        {
            updateFixedItemsPerProjectCostsValue(bsFixedItemsPerProject, nuInternalConnTaskType);
            updateFixedItemsPerPropUnitCostsValue(bsFixedItemsPerPropUnit, nuInternalConnTaskType);
            updateFixedItemsPerProjectCostsValue(bsItemsPerProjectChargConn, nuChargeConnTaskType);
            updateFixedItemsPerPropUnitCostsValue(bsItemsPerPropUnitCharConn, nuChargeConnTaskType);
            updateItemsPerLengthCostsValue();
            updateItemsPropUnitCostsValue();
        }

        private void updateFixedItemsPerProjectCostsValue(BindingSource bsDataToUpdate, Int64 taskType)
        {
            foreach (QuotationItem item in bsDataToUpdate)
            {
                LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });

                if (tmpLovItem != null)
                {
                    item.Price = tmpLovItem.QuotationItem.Price;
                    item.Cost = tmpLovItem.QuotationItem.Cost;
                    item.Operation = "U";
                }
                else
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            if (taskType == nuInternalConnTaskType)
            {
                FixedItemsPerProjectList.RemoveAll(delegate(QuotationItem qi) { return qi.Operation == "D"; });
            }
            else if (taskType == nuChargeConnTaskType)
            {
                FixedItemsPerProjectCharConnList.RemoveAll(delegate(QuotationItem qi) { return qi.Operation == "D"; });
            }

            bsDataToUpdate.ResetBindings(true);
        }

        private void updateFixedItemsPerPropUnitCostsValue(BindingSource bsDataToUpdate, Int64 taskType)
        {
            foreach (QuotationItem item in bsDataToUpdate)
            {
                LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });

                if (tmpLovItem != null)
                {
                    item.Price = tmpLovItem.QuotationItem.Price;
                    item.Cost = tmpLovItem.QuotationItem.Cost;
                    item.Operation = "U";
                }
                else
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            if (taskType == nuInternalConnTaskType)
            {
                FixedItemsPerPropUnitList.RemoveAll(delegate(QuotationItem qi) { return qi.Operation == "D"; });
            }
            else if (taskType == nuChargeConnTaskType)
            {
                FixedItemsPerPropCharConnList.RemoveAll(delegate(QuotationItem qi) { return qi.Operation == "D"; });
            }

            bsDataToUpdate.ResetBindings(true);
        }

        private void updateItemsPerLengthCostsValue()
        {
            foreach (ItemsPerLength item in bsItemsPerLength)
            {
                LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });

                if (tmpLovItem != null)
                {
                    item.Price = tmpLovItem.QuotationItem.Price;
                    item.Cost = tmpLovItem.QuotationItem.Cost;
                    item.Operation = "U";
                }
                else
                {
                    item.Operation = "D";
                    itemsPerLengthToDelete.Add(item);
                }
            }
            ItemsPerLengthList.RemoveAll(delegate(ItemsPerLength il) { return il.Operation == "D"; });
            bsItemsPerLength.ResetBindings(true);
        }


        private void updateItemsPropUnitCostsValue()
        {
            foreach (PropPerFloorAndUnitType itemList in bsItemsPropUnit)
            {
                foreach (QuotationItem item in itemList.QuotationItemList)
                {
                    if (item.ItemType != "VF")
                    {
                        LovItem tmpLovItem = itemsList.Find(delegate(LovItem li) { return li.ItemId == item.ItemId; });

                        if (tmpLovItem != null)
                        {
                            if (item.ItemType == "FP")
                            {
                                item.Price = (tmpLovItem.QuotationItem.Price / projectBasicData.UnitsPropTotal);
                                item.Cost = (tmpLovItem.QuotationItem.Cost / projectBasicData.UnitsPropTotal);
                            }
                            else
                            {
                                item.Price = tmpLovItem.QuotationItem.Price;
                                item.Cost = tmpLovItem.QuotationItem.Cost;
                            }
                            item.Operation = "U";
                        }
                        else
                        {
                            item.Operation = "D";
                            if (item.ItemType == "IU")
                            {
                                quotationItemsToDelete.Add(item);
                            }
                        }
                    }
                }
                itemList.QuotationItemList.RemoveAll(delegate(QuotationItem qi) { return qi.Operation == "D"; });
            }

            refreshItemsPropUnit();
        }

        private void ocInternalConnection_ValueChanged(object sender, EventArgs e)
        {
            updatebsConsolidatedQuotation(ocInternalConnection.Value, Constants.INTERNAL_CON_CLASS);
        }

        private void ocChargeByConnection_ValueChanged(object sender, EventArgs e)
        {
            updatebsConsolidatedQuotation(ocChargeByConnection.Value, Constants.CHARGE_BY_CON_CLASS);
        }

        private void ocCertification_ValueChanged(object sender, EventArgs e)
        {
            updatebsConsolidatedQuotation(ocCertification.Value, Constants.CERTIFICATION_CLASS);
        }

        private void ResetIntConnItems()
        {
            foreach (QuotationItem item in bsFixedItemsPerProject)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            FixedItemsPerProjectList.Clear();
            bsFixedItemsPerProject.DataSource = FixedItemsPerProjectList;
            bsFixedItemsPerProject.ResetBindings(true);

            foreach (QuotationItem item in bsFixedItemsPerPropUnit)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            FixedItemsPerPropUnitList.Clear();
            bsFixedItemsPerPropUnit.DataSource = FixedItemsPerPropUnitList;
            bsFixedItemsPerPropUnit.ResetBindings(true);

            foreach (ItemsPerLength item in bsItemsPerLength)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    itemsPerLengthToDelete.Add(item);
                }
            }

            ItemsPerLengthList.Clear();
            bsItemsPerLength.DataSource = ItemsPerLengthList;
            bsItemsPerLength.ResetBindings(true);

            foreach (FixedValues item in bsFixedValuesPerPropUnit)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    fixedValuesToDelete.Add(item);
                }
            }

            FixedValuesList.Clear();
            bsFixedValuesPerPropUnit.DataSource = FixedValuesList;
            bsFixedValuesPerPropUnit.ResetBindings(true);

            foreach (PropPerFloorAndUnitType item in bsItemsPropUnit)
            {
                foreach (QuotationItem quotation in item.QuotationItemList)
                {
                    if (quotation.TaskType == nuInternalConnTaskType)
                    {
                        if (quotation.Operation != "R" & quotation.ItemType == "IU")
                        {
                            quotation.Operation = "D";
                            quotationItemsToDelete.Add(quotation);
                        }
                    }
                }

                item.QuotationItemList.RemoveAll(delegate(QuotationItem ar)
                { return ar.TaskType == nuInternalConnTaskType; });
            }

            refreshItemsPropUnit();
        }

        private void ResetChargConnItems()
        {
            foreach (QuotationItem item in bsItemsPerProjectChargConn)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            FixedItemsPerProjectCharConnList.Clear();
            bsItemsPerProjectChargConn.DataSource = FixedItemsPerProjectCharConnList;
            bsItemsPerProjectChargConn.ResetBindings(true);

            foreach (QuotationItem item in bsItemsPerPropUnitCharConn)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    quotationItemsToDelete.Add(item);
                }
            }

            FixedItemsPerPropCharConnList.Clear();
            bsItemsPerPropUnitCharConn.DataSource = FixedItemsPerPropCharConnList;
            bsItemsPerPropUnitCharConn.ResetBindings(true);

            foreach (FixedValues item in bsFixedValuesChargConn)
            {
                if (item.Operation != "R")
                {
                    item.Operation = "D";
                    fixedValuesToDelete.Add(item);
                }
            }

            FixedValuesCharConnList.Clear();
            bsFixedValuesChargConn.DataSource = FixedValuesCharConnList;
            bsFixedValuesChargConn.ResetBindings(true);

            foreach (PropPerFloorAndUnitType item in bsItemsPropUnit)
            {
                foreach (QuotationItem quotation in item.QuotationItemList)
                {
                    if (quotation.TaskType == nuChargeConnTaskType)
                    {
                        if (quotation.Operation != "R" & quotation.ItemType == "IU")
                        {
                            quotation.Operation = "D";
                            quotationItemsToDelete.Add(quotation);
                        }
                    }
                }

                item.QuotationItemList.RemoveAll(delegate(QuotationItem ar)
                { return ar.TaskType == nuChargeConnTaskType; });
            }

            refreshItemsPropUnit();

        }
        #endregion

        #region ArticleRowSelected
        void ocItemsPerPropUnitType_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);

                if (a.SelectedRow != null)
                {
                    tmpFixedItemPerPropUnit = fixedItemPerPropUnit;
                    fixedItemPerPropUnit = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    fixedItemPerPropUnit.QuotationItem.ProjectId = nuProjectId;
                    fixedItemPerPropUnit.QuotationItem.ItemType = "FU";
                }
            }
        }

        void ocItemsPerProject_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);

                if (a.SelectedRow != null)
                {
                    tmpItemPerProject = itemPerProject;
                    itemPerProject = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    itemPerProject.QuotationItem.ProjectId = nuProjectId;
                    itemPerProject.QuotationItem.ItemType = "FP";
                }
            }
        }

        void ocItemsPerLength_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);

                if (a.SelectedRow != null)
                {
                    tmpItemPerLength = itemPerLength;
                    itemPerLength = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    itemPerLength.QuotationItem.ProjectId = nuProjectId;
                    itemPerLength.QuotationItem.ItemType = "IM";
                }
            }
        }

        void ocItemsPerPropUnit_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);
                if (a.SelectedRow != null)
                {
                    tmpItemPerPropUnit = itemPerPropUnit;
                    itemPerPropUnit = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    itemPerPropUnit.QuotationItem.ProjectId = nuProjectId;
                    itemPerPropUnit.QuotationItem.ItemType = "IU";
                }
            }
        }

        //Implementación del Cargo por Conexión
        void ocItemsPerPropUnitChargConn_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);
                if (a.SelectedRow != null)
                {
                    tmpFixedItemPerPropUnitChargConn = fixedItemPerPropUnitChargConn;
                    fixedItemPerPropUnitChargConn = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    fixedItemPerPropUnitChargConn.QuotationItem.ProjectId = nuProjectId;
                    fixedItemPerPropUnitChargConn.QuotationItem.ItemType = "FU";
                }
            }
        }

        void ocItemsPerProjectChargConn_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);

                if (a.SelectedRow != null)
                {
                    tmpItemPerProjectChargConn = itemPerProjectChargConn;
                    itemPerProjectChargConn = itemsList.Find(delegate(LovItem ar)
                    //Caso 200-1640
                    { return ar.ItemId == Convert.ToString(a.SelectedRow.Cells[0].Value); });
                    itemPerProjectChargConn.QuotationItem.ProjectId = nuProjectId;
                    itemPerProjectChargConn.QuotationItem.ItemType = "FP";
                }
            }
        }

        #endregion

        /// <summary>
        /// Crea la lista de valores para los ítems
        /// </summary>
        /// <returns>Lista de valores</returns>
        private OpenGridDropDown DropDownListsMaker(List<LovItem> itemList)
        {
            //Se crea instancia de lista desplegable
            OpenGridDropDown dropdown = new OpenGridDropDown();

            //Se setea la fuente de datos de la lista desplegable
            dropdown.DataSource = itemList;
            dropdown.DisplayMember = "ItemDescription";
            dropdown.ValueMember = "ItemId";

            for (int i = 0; i < itemList.Count; i++)
            {
                itemDescription.Add(itemList[i].ItemDescription);
            }

            ColumnsCollection cols = dropdown.DisplayLayout.Bands[0].Columns;

            //Se setean los títulos de la lista y se ordena por código
            cols[dropdown.ValueMember].Header.Caption = "Código";
            cols[dropdown.DisplayMember].Header.Caption = this.ugFixedItemsPerProject.DisplayLayout.Bands[0].Columns["ItemDescription"].Header.Caption;
            cols[dropdown.ValueMember].SortIndicator = SortIndicator.Ascending;

            //Activa el scrollbar
            dropdown.DisplayLayout.Scrollbars = Scrollbars.Automatic;
            dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].PerformAutoResize(PerformAutoSizeType.AllRowsInBand);
            dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].PerformAutoResize(PerformAutoSizeType.AllRowsInBand);

            if ((Screen.PrimaryScreen.WorkingArea.Width / 3) <= dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].Width + dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].Width)
            {
                dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].Width = (Screen.PrimaryScreen.WorkingArea.Width / 3) -
                dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].Width;
            }
            return dropdown;
        }

        #region Rowsvalidation
        private bool validQuotationItemRow(UltraGrid ugQuotationRow)
        {
            bool result = true;

            /*if (ugQuotationRow.ActiveRow != null)
            {
                if (OpenConvert.ToDouble(ugQuotationRow.ActiveRow.Cells["Cost"].Value) <= 0.0)
                {
                    utilities.DisplayErrorMessage("El precio del artículo no puede ser menor o igual a cero");
                    result = false;
                }
            }*/

            return result;
        }

        private bool validFixedValueRow(UltraGridRow ugr)
        {
            bool result = true;

            if (ugr != null)
            {
                FixedValues tmpFixedValue = ugr.ListObject as FixedValues;

                if (string.IsNullOrEmpty(tmpFixedValue.Description))
                {
                    utilities.DisplayErrorMessage("Debe ingresar una descripción para el valor fijo");
                    result = false;
                }
                else if (tmpFixedValue.Cost <= 0)
                {
                    utilities.DisplayErrorMessage("El precio no puede ser menor o igual a cero");
                    result = false;
                }
            }

            return result;
        }

        #endregion

        /// <summary>
        /// Valida si el ítem ya está seleccionado
        /// <param name="newItem">El nuevo item de la grilla</param>
        /// <returns>Devuelve valor booleano indicando si existe o no</returns>
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean itemAlreadyExists(Object newItem, BindingSource bsOrigin, String type)
        {
            QuotationItem tmpNewItem = (QuotationItem)newItem;

            //Caso 200-1640
            Int64 numberId1 = 0;
            Int64 numberId2 = 0;
            String elemento1 = tmpNewItem.ItemId;
            String elemento2 = "";
            if (elemento1.Contains("C") || elemento1.Contains("G"))
            {
                numberId1 = Int64.Parse(elemento1.Substring(0, elemento1.Length - 1).ToString());
            }
            else
            {
                numberId1 = Int64.Parse(elemento1.ToString());
            }
            //

            if (type == "QI")
            {
                foreach (QuotationItem item in bsOrigin)
                {
                    if (item != null)
                    {
                        if (item.ItemId != null)
                        {
                            elemento2 = item.ItemId;
                            if (elemento2.Contains("C") || elemento2.Contains("G"))
                            {
                                numberId2 = Int64.Parse(elemento2.Substring(0, elemento2.Length - 1).ToString());
                            }
                            else
                            {
                                numberId2 = Int64.Parse(elemento2.ToString());
                            }
                            if (numberId1 == numberId2)//(tmpNewItem.ItemId == item.ItemId)
                            {
                                return true;
                            }
                        }
                    }
                }

            }
            else if (type == "IL")
            {
                foreach (ItemsPerLength item in bsOrigin)
                {
                    if (item != null)
                    {
                        if (item.ItemId != null)
                        {
                            elemento2 = item.ItemId;
                            if (elemento2.Contains("C") || elemento2.Contains("G"))
                            {
                                numberId2 = Int64.Parse(elemento2.Substring(0, elemento2.Length - 1).ToString());
                            }
                            else
                            {
                                numberId2 = Int64.Parse(elemento1.ToString());
                            }
                            if (numberId1 == numberId2)//(tmpNewItem.ItemId == item.ItemId)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            else
            {
                foreach (PropPerFloorAndUnitType item in bsOrigin)
                {
                    foreach (QuotationItem a in item.QuotationItemList)
                    {
                        if (a != null)
                        {
                            if (a.ItemId != null)
                            {
                                elemento2 = a.ItemId;
                                if (elemento2.Contains("C") || elemento2.Contains("G"))
                                {
                                    numberId2 = Int64.Parse(elemento2.Substring(0, elemento2.Length - 1).ToString());
                                }
                                else
                                {
                                    numberId2 = Int64.Parse(elemento2.ToString());
                                }
                                if (numberId1 == numberId2 & tmpNewItem.ItemType == a.ItemType & tmpNewItem.TaskType == a.TaskType)//(tmpNewItem.ItemId == a.ItemId & tmpNewItem.ItemType == a.ItemType & tmpNewItem.TaskType == a.TaskType)
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }

            return false;
        }

        /// <summary>
        /// Se valida que se hayan ingresado los datos obligatorios de la cotización
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean FieldsAreValid(String validationArea)
        {
            if (validationArea == AllData)
            {
                if (String.IsNullOrEmpty(tbQuotationComment.TextBoxValue))
                {
                    utilities.DisplayErrorMessage("Faltan datos requeridos, no ha ingresado la observación");
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
            }

            if (validationArea == BasicConfiguration || validationArea == AllData)
            {
                if (hlCostList.Value != null)
                {
                    if (!(Convert.ToInt64(hlCostList.Value) > 0))
                    {
                        utilities.RaiseERROR("Faltan datos requeridos, no ha seleccionado la lista de costos");
                        return false;
                    }
                }
                else
                {
                    utilities.RaiseERROR("Faltan datos requeridos, no ha seleccionado la lista de costos");
                    return false;
                }

                if (!(Convert.ToInt64(ocInternalConnection.Value) > 0) & !(Convert.ToInt64(ocChargeByConnection.Value) > 0) & !(Convert.ToInt64(ocCertification.Value) > 0))
                {
                    utilities.RaiseERROR("Faltan datos requeridos, no ha seleccionado el tipo de trabajo a cotizar");
                    return false;
                }
            }

            if (validationArea == AllData) //validationArea == QuotationDetail || 
            {
                if (isPlanIntEsp.Equals("N"))//inicio caso 200-2022
                {
                    if ((Convert.ToInt64(ocInternalConnection.Value) > 0 & !hasItems))
                    {
                        utilities.RaiseERROR("Faltan datos requeridos. Debe ingresar los ítems que se cotizarán para la instalación interna/red matriz");
                        return false;
                    }

                    if ((Convert.ToInt64(ocChargeByConnection.Value) > 0 & !hasChargConnItems))
                    {
                        utilities.RaiseERROR("Faltan datos requeridos. Debe ingresar los ítems que se cotizarán para el cargo por conexión");
                        return false;
                    }

                    if (!ItemsPerPropUnitIsValid())
                    {
                        return false;
                    }
                }
            }

            if (validationArea == QuotationSummary || validationArea == AllData)
            {
                return QuotationConsolidateIsValid();
            }

            return true;
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[1];
        }

        private void btnNext2_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[3];
        }

        private void btnNext3_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[2];
        }

        #region BindingNavigatorAddNewItems
        private void bnItemsPerProjectAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocInternalConnection.Value == null)
            {
                utilities.DisplayInfoMessage(InternalConnIsNotSelectedMessage);
                return;
            }

            this.bnItemsPerProject.Focus();

            if (validQuotationItemRow(ugFixedItemsPerProject))
            {
                QuotationItem tmpFixedItemPerProject = (QuotationItem)bsFixedItemsPerProject.AddNew();
                tmpFixedItemPerProject.ProjectId = nuProjectId;
                tmpFixedItemPerProject.ItemType = "FP";
                tmpFixedItemPerProject.Operation = "R";
                tmpFixedItemPerProject.TaskType = nuInternalConnTaskType;
            }
        }

        private void bnItemsPerUnitAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocInternalConnection.Value == null)
            {
                utilities.DisplayInfoMessage(InternalConnIsNotSelectedMessage);
                return;
            }

            this.bnItemsPerPropUnit.Focus();

            if (validQuotationItemRow(ugFixedItemsPerPropUnit))
            {
                QuotationItem tmpFixedItemPerPropUnit = (QuotationItem)bsFixedItemsPerPropUnit.AddNew();
                tmpFixedItemPerPropUnit.ProjectId = nuProjectId;
                tmpFixedItemPerPropUnit.ItemType = "FU";
                tmpFixedItemPerPropUnit.Operation = "R";
                tmpFixedItemPerPropUnit.TaskType = nuInternalConnTaskType;
            }
        }

        private void bnFixedValuesAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocInternalConnection.Value == null)
            {
                utilities.DisplayInfoMessage(InternalConnIsNotSelectedMessage);
                return;
            }

            this.bnFixedValuesPerPropUnit.Focus();

            if (validFixedValueRow(this.ugFixedValuesPerPropUnit.ActiveRow))
            {
                FixedValues tmpFixedValues = (FixedValues)bsFixedValuesPerPropUnit.AddNew();
                tmpFixedValues.TaskType = nuInternalConnTaskType;
                tmpFixedValues.ProjectId = nuProjectId;
            }
        }

        private void bnItemsPerLengthAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocInternalConnection.Value == null)
            {
                utilities.DisplayInfoMessage(InternalConnIsNotSelectedMessage);
                return;
            }

            this.bnItemsPerLength.Focus();

            if (validQuotationItemRow(ugItemsPerLength))
            {
                ItemsPerLength tmpItemPerLength = (ItemsPerLength)bsItemsPerLength.AddNew();
                tmpItemPerLength.Project = nuProjectId;
            }

        }

        //Implementación de Cargo por Conexión
        private void bnItemsProjectCharConnAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocChargeByConnection.Value == null)
            {
                utilities.DisplayInfoMessage(ChargConnIsNotSelectedMessage);
                return;
            }

            this.bnItemsPerProjectChargConn.Focus();

            if (validQuotationItemRow(ugItemsPerProjectChargConn))
            {
                QuotationItem tmpFixedItemPerProject = (QuotationItem)bsItemsPerProjectChargConn.AddNew();
                tmpFixedItemPerProject.ProjectId = nuProjectId;
                tmpFixedItemPerProject.ItemType = "FP";
                tmpFixedItemPerProject.Operation = "R";
                tmpFixedItemPerProject.TaskType = nuChargeConnTaskType;
            }
        }

        private void bnItemsPerPropChargConnAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocChargeByConnection.Value == null)
            {
                utilities.DisplayInfoMessage(ChargConnIsNotSelectedMessage);
                return;
            }

            this.bnItemsPerPropUnitChargConn.Focus();

            if (validQuotationItemRow(ugItemsPerPropUnitChargConn))
            {
                QuotationItem tmpFixedItemPerPropUnit = (QuotationItem)bsItemsPerPropUnitCharConn.AddNew();
                tmpFixedItemPerPropUnit.ProjectId = nuProjectId;
                tmpFixedItemPerPropUnit.ItemType = "FU";
                tmpFixedItemPerPropUnit.Operation = "R";
                tmpFixedItemPerPropUnit.TaskType = nuChargeConnTaskType;
            }
        }

        private void bnFixedValuesChargConnAddNewItem_Click(object sender, EventArgs e)
        {
            if (hlCostList.Value == null)
            {
                utilities.DisplayInfoMessage(SelectCostListMessage);
                return;
            }
            if (ocChargeByConnection.Value == null)
            {
                utilities.DisplayInfoMessage(ChargConnIsNotSelectedMessage);
                return;
            }

            this.bnFixedValuesChargConn.Focus();

            if (validFixedValueRow(this.ugFixedValuesChargConn.ActiveRow))
            {
                FixedValues tmpFixedValues = (FixedValues)bsFixedValuesChargConn.AddNew();
                tmpFixedValues.TaskType = nuChargeConnTaskType;
                tmpFixedValues.ProjectId = nuProjectId;
            }
        }
        #endregion

        #region BindingNavigatorDeleteItems
        private void bindingNavigatorDeleteFixedItemPerProject_Click(object sender, EventArgs e)
        {
            if (bsFixedItemsPerProject.Count <= 0)
            {
                return;
            }

            this.bnItemsPerProject.Focus();

            deleteItemsPerPropUnit(bsFixedItemsPerProject.Current);
            QuotationItem itemToDelete = (QuotationItem)bsFixedItemsPerProject.Current;

            if (itemToDelete.Operation != "R")
            {
                itemToDelete.Operation = "D";
                quotationItemsToDelete.Add(itemToDelete);
            }

            bsFixedItemsPerProject.RemoveCurrent();

        }

        private void bindingNavigatorDeleteFixedItemPerPropUnit_Click(object sender, EventArgs e)
        {
            if (bsFixedItemsPerPropUnit.Count <= 0)
            {
                return;
            }

            this.bnItemsPerPropUnit.Focus();

            deleteItemsPerPropUnit(bsFixedItemsPerPropUnit.Current);

            QuotationItem itemToDelete = (QuotationItem)bsFixedItemsPerPropUnit.Current;

            if (itemToDelete.Operation != "R")
            {
                itemToDelete.Operation = "D";
                quotationItemsToDelete.Add(itemToDelete);
            }

            bsFixedItemsPerPropUnit.RemoveCurrent();
        }

        private void bindingNavigatorDeleteFixedValue_Click(object sender, EventArgs e)
        {
            if (bsFixedValuesPerPropUnit.Count <= 0)
            {
                return;
            }
            this.bnFixedValuesPerPropUnit.Focus();

            FixedValues tmpFixedValue = (FixedValues)bsFixedValuesPerPropUnit.Current;
            QuotationItem tmpQuotationItem = new QuotationItem(tmpFixedValue);
            deleteItemsPerPropUnit(tmpQuotationItem);
            if (tmpFixedValue.Operation != "R")
            {
                tmpFixedValue.Operation = "D";
                fixedValuesToDelete.Add(tmpFixedValue);
            }

            bsFixedValuesPerPropUnit.RemoveCurrent();
        }

        private void bindingNavItemsPerLengthDeleteItem_Click(object sender, EventArgs e)
        {
            if (bsItemsPerLength.Count <= 0)
            {
                return;
            }
            this.bnItemsPerLength.Focus();

            ItemsPerLength tmpItemPerLength = (ItemsPerLength)bsItemsPerLength.Current;
            QuotationItem tmpQuotationItem = new QuotationItem(tmpItemPerLength);
            tmpQuotationItem.TaskType = nuInternalConnTaskType;
            deleteItemsPerPropUnit(tmpQuotationItem);
            if (tmpItemPerLength.Operation != "R")
            {
                tmpItemPerLength.Operation = "D";
                itemsPerLengthToDelete.Add(tmpItemPerLength);
            }

            this.bsItemsPerLength.RemoveCurrent();
        }

        //Implementación de Cargo por Conexión
        private void bnItemsProjectCharConnDeleteItem_Click(object sender, EventArgs e)
        {
            if (bsItemsPerProjectChargConn.Count <= 0)
            {
                return;
            }

            this.bnItemsPerProjectChargConn.Focus();

            deleteItemsPerPropUnit(bsItemsPerProjectChargConn.Current);
            QuotationItem itemToDelete = (QuotationItem)bsItemsPerProjectChargConn.Current;

            if (itemToDelete.Operation != "R")
            {
                itemToDelete.Operation = "D";
                quotationItemsToDelete.Add(itemToDelete);
            }

            bsItemsPerProjectChargConn.RemoveCurrent();

        }

        private void bnItemsPerPropChargConnDeleteItem_Click(object sender, EventArgs e)
        {
            if (bsItemsPerPropUnitCharConn.Count <= 0)
            {
                return;
            }

            this.bnItemsPerPropUnitChargConn.Focus();

            deleteItemsPerPropUnit(bsItemsPerPropUnitCharConn.Current);
            QuotationItem itemToDelete = (QuotationItem)bsItemsPerPropUnitCharConn.Current;
            if (itemToDelete.Operation != "R")
            {
                itemToDelete.Operation = "D";
                quotationItemsToDelete.Add(itemToDelete);
            }

            bsItemsPerPropUnitCharConn.RemoveCurrent();
        }

        private void bnFixedValuesChargConnDeleteItem_Click(object sender, EventArgs e)
        {
            if (bsFixedValuesChargConn.Count <= 0)
            {
                return;
            }
            this.bnFixedValuesChargConn.Focus();

            FixedValues tmpFixedValue = (FixedValues)bsFixedValuesChargConn.Current;
            QuotationItem tmpQuotationItem = new QuotationItem(tmpFixedValue);

            deleteItemsPerPropUnit(tmpQuotationItem);
            if (tmpFixedValue.Operation != "R")
            {
                tmpFixedValue.Operation = "D";
                fixedValuesToDelete.Add(tmpFixedValue);
            }

            bsFixedValuesChargConn.RemoveCurrent();
        }
        #endregion

        #region BeforRowsDeactivate
        private void ugItemsPerProject_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validQuotationItemRow(ugFixedItemsPerProject))
            {
                e.Cancel = true;
            }
        }

        private void ugItemsPerPropUnit_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validQuotationItemRow(ugFixedItemsPerPropUnit))
            {
                e.Cancel = true;
            }
        }

        private void ugFixedValuesPerPropUnit_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validFixedValueRow(this.ugFixedValuesPerPropUnit.ActiveRow))
            {
                e.Cancel = true;
            }
        }

        //Implementación de Cargo por Conexión
        private void ugItemsPerProjectChargConn_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validQuotationItemRow(ugItemsPerProjectChargConn))
            {
                e.Cancel = true;
            }
        }

        private void ugItemsPerPropUnitChargConn_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validQuotationItemRow(ugItemsPerPropUnitChargConn))
            {
                e.Cancel = true;
            }
        }

        private void ugFixedValuesChargConn_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validFixedValueRow(this.ugFixedValuesChargConn.ActiveRow))
            {
                e.Cancel = true;
            }
        }
        #endregion

        #region UltragridsBeforeCellUpdate
        private void ugFixedItemsPerProject_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Cell.Value)))
                {
                    OldArticleDesc = Convert.ToString(e.Cell.Value);
                    utilities.DisplayErrorMessage("No se permite modificar la descripción del ítem");
                    itemPerProject = tmpItemPerProject;
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void ugFixedItemsPerPropUnit_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Cell.Value)))
                {
                    utilities.DisplayErrorMessage("No se permite modificar la descripción del ítem");
                    fixedItemPerPropUnit = tmpFixedItemPerPropUnit;
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void ugItemsPerLength_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Cell.Value)))
                {
                    utilities.DisplayErrorMessage("No se permite modificar la descripción del ítem");
                    itemPerLength = tmpItemPerLength;
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void ugQuotationResult_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (this.ugQuotationResult.ActiveRow != null)
            {
                ConsolidatedQuotation tmpConsolidatedQuot = this.ugQuotationResult.ActiveRow.ListObject as ConsolidatedQuotation;

                //Caso 200-1640
                //19.07.18
                //MessageBox.Show(tmpConsolidatedQuot.TaskType.ToString());

                if (e.Cell.Column.Key == "Cost" && tmpConsolidatedQuot.TaskType == nuInternalConnTaskType)
                {
                    utilities.DisplayErrorMessage("No está permitido modificar el costo calculado para la Instalación Interna/Red Matriz");
                    e.Cancel = true;

                }

                if (e.Cell.Column.Key == "Cost" && tmpConsolidatedQuot.TaskType == nuChargeConnTaskType)
                {
                    utilities.DisplayErrorMessage("No está permitido modificar el costo calculado para el cargo por conexión");
                    e.Cancel = true;

                }

                if (e.Cell.Column.Key == "Price" && e.NewValue != null && tmpConsolidatedQuot.TaskType == nuInternalConnTaskType)
                {
                    if (Convert.ToDouble(e.NewValue) < calculatedIntConnPrice)
                    {
                        utilities.DisplayErrorMessage("No se puede ingresar un valor menor al costo calculado para la instalación interna/Red Matriz");
                        e.Cancel = true;
                    }
                    else
                    {
                        prevIntConnPrice = Convert.ToDouble(e.Cell.Value);
                    }
                }

                if (e.Cell.Column.Key == "Price" && e.NewValue != null && tmpConsolidatedQuot.TaskType == nuChargeConnTaskType)
                {
                    if (Convert.ToDouble(e.NewValue) < calculatedChargConnPrice)
                    {
                        utilities.DisplayErrorMessage("No se puede ingresar un valor menor al costo calculado para el cargo por conexión");
                        e.Cancel = true;
                    }
                    else
                    {
                        prevIntConnPrice = Convert.ToDouble(e.Cell.Value);
                    }
                }
            }
        }

        //Implementación del Cargo por Conexión
        private void ugItemsPerProjectChargConn_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Cell.Value)))
                {
                    OldArticleDesc = Convert.ToString(e.Cell.Value);
                    utilities.DisplayErrorMessage("No se permite cambiar el ítem");
                    itemPerProjectChargConn = tmpItemPerProjectChargConn;
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void ugItemsPerPropUnitChargConn_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Cell.Value)))
                {
                    utilities.DisplayErrorMessage("No se permite cambiar el ítem");
                    fixedItemPerPropUnitChargConn = tmpFixedItemPerPropUnitChargConn;
                    e.Cancel = true;
                    return;
                }
            }
        }
        #endregion

        #region UltragridsAfterCellUpdate
        private void ugItemsPerProject_AfterCellUpdate(object sender, CellEventArgs e)
        {
            int index = bsFixedItemsPerProject.Position;

            QuotationItem tmpQuotationItem = (QuotationItem)bsFixedItemsPerProject[index];

            if (e.Cell.Column.Key == "ItemDescription")
            {
                //Valida si existe en la grilla de ítems por proyecto
                if (itemAlreadyExists(itemPerProject.QuotationItem, bsFixedItemsPerProject, "QI"))
                {
                    utilities.DisplayErrorMessage("Este ítem ya existe");
                    bsFixedItemsPerProject.RemoveCurrent();
                    return;
                }

                tmpQuotationItem.ItemDescription = itemPerProject.QuotationItem.ItemDescription;
                tmpQuotationItem.ItemId = itemPerProject.QuotationItem.ItemId;
                tmpQuotationItem.Price = itemPerProject.QuotationItem.Price;
                tmpQuotationItem.Cost = itemPerProject.QuotationItem.Cost;
                tmpQuotationItem.Amount = 1;

                QuotationItem tmpQuotationItem2 = new QuotationItem(tmpQuotationItem);
                tmpQuotationItem2.Price = (itemPerProject.QuotationItem.Price / projectBasicData.UnitsPropTotal);
                tmpQuotationItem2.Cost = (itemPerProject.QuotationItem.Cost / projectBasicData.UnitsPropTotal);

                addItemToItemsPerPropUnit(tmpQuotationItem2);
                bsFixedItemsPerProject.EndEdit();
            }

            if (e.Cell.Column.Key == "Amount" || (e.Cell.Column.Key == "Cost"))
            {
                if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                {
                    updateAmountValueItemsPerPropUnit(this.ugFixedItemsPerProject.ActiveRow, e.Cell.Value);
                }
                if (tmpQuotationItem.Operation == "N")
                {
                    tmpQuotationItem.Operation = "U";
                }
            }
        }

        private void ugItemsPerLength_AfterCellUpdate(object sender, CellEventArgs e)
        {
            int index = bsItemsPerLength.Position;
            ItemsPerLength tmpItemPerLength = (ItemsPerLength)bsItemsPerLength[index];

            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (itemAlreadyExists(itemPerLength.QuotationItem, bsItemsPerLength, "IL"))
                {
                    utilities.DisplayErrorMessage("Este ítem ya existe");
                    bsItemsPerLength.RemoveCurrent();
                    return;
                }

                itemPerLength.QuotationItem.ItemType = "IM";
                itemPerLength.QuotationItem.Amount = 0;

                tmpItemPerLength.ItemId = itemPerLength.QuotationItem.ItemId;
                tmpItemPerLength.ItemDescription = itemPerLength.QuotationItem.ItemDescription;
                tmpItemPerLength.Price = itemPerLength.QuotationItem.Price;
                tmpItemPerLength.Cost = itemPerLength.QuotationItem.Cost;
                tmpItemPerLength.ItemType = itemPerLength.QuotationItem.ItemType;

                bsItemsPerLength[index] = tmpItemPerLength;
                addItemToItemsPerPropUnit(new QuotationItem(tmpItemPerLength));
                bsItemsPerLength.EndEdit();
            }

            if (e.Cell.Column.Key == "Flute" || e.Cell.Column.Key == "Oven" || e.Cell.Column.Key == "BBQ" || e.Cell.Column.Key == "Stove"
                || e.Cell.Column.Key == "Dryer" || e.Cell.Column.Key == "Heater" || e.Cell.Column.Key == "LongValBaj" || e.Cell.Column.Key == "LongBajTabl" || e.Cell.Column.Key == "LongTab"
                || e.Cell.Column.Key == "LongBaj")
            {
                QuotationItem tmp = new QuotationItem(tmpItemPerLength);
                tmp.TaskType = nuInternalConnTaskType;
                if (itemAlreadyExists(tmp, bsItemsPropUnit, "PI"))
                {
                    updateItemsPerLengthInItemsPerPropUnit(-1, -1, tmpItemPerLength.ItemId);
                }

                if (tmpItemPerLength.Operation == "N")
                {
                    tmpItemPerLength.Operation = "U";
                }
            }
            refreshItemsPropUnit();
        }

        private void ugFixedItemsPerPropUnit_AfterCellUpdate(object sender, CellEventArgs e)
        {
            int index = bsFixedItemsPerPropUnit.Position;

            QuotationItem tmpQuotationItem = (QuotationItem)bsFixedItemsPerPropUnit[index];

            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (itemAlreadyExists(fixedItemPerPropUnit.QuotationItem, bsFixedItemsPerPropUnit, "QI"))
                {
                    utilities.DisplayErrorMessage("Este ítem ya existe");
                    bsFixedItemsPerPropUnit.RemoveCurrent();
                    return;
                }

                tmpQuotationItem.Amount = 1;
                tmpQuotationItem.ItemId = fixedItemPerPropUnit.QuotationItem.ItemId;
                tmpQuotationItem.ItemDescription = fixedItemPerPropUnit.QuotationItem.ItemDescription;
                tmpQuotationItem.Price = fixedItemPerPropUnit.QuotationItem.Price;
                tmpQuotationItem.Cost = fixedItemPerPropUnit.QuotationItem.Cost;

                bsFixedItemsPerPropUnit[index] = tmpQuotationItem;

                addItemToItemsPerPropUnit(tmpQuotationItem);

                bsFixedItemsPerPropUnit.EndEdit();
            }

            if (e.Cell.Column.Key == "Amount")
            {
                if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                {
                    updateAmountValueItemsPerPropUnit(this.ugFixedItemsPerPropUnit.ActiveRow, e.Cell.Value);
                }

                if (tmpQuotationItem.Operation == "N")
                {
                    tmpQuotationItem.Operation = "U";
                }
            }
        }

        private void ugFixedValuesPerPropUnit_AfterCellUpdate(object sender, CellEventArgs e)
        {

            if (e.Cell.Column.Key == "Cost" || e.Cell.Column.Key == "Description" || e.Cell.Column.Key == "Amount")
            {
                if (Convert.ToDouble(this.ugFixedValuesPerPropUnit.ActiveRow.Cells["Cost"].Value) > 0
                    & Convert.ToDouble(this.ugFixedValuesPerPropUnit.ActiveRow.Cells["Amount"].Value) > 0
                    & !string.IsNullOrEmpty(Convert.ToString(this.ugFixedValuesPerPropUnit.ActiveRow.Cells["Description"].Value)))
                {
                    int index = bsFixedValuesPerPropUnit.Position;
                    FixedValues tmpFixedValue = (FixedValues)bsFixedValuesPerPropUnit[index];
                    tmpFixedValue.ProjectId = nuProjectId;
                    tmpFixedValue.Description = Convert.ToString(this.ugFixedValuesPerPropUnit.ActiveRow.Cells["Description"].Value);
                    QuotationItem tmpQuotationItem = new QuotationItem(tmpFixedValue);

                    if (tmpFixedValue.Operation == "N")
                    {
                        tmpFixedValue.Operation = "U";
                    }

                    if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                    {
                        updateFixedValuesInItemsPerPropUnit(this.ugFixedValuesPerPropUnit.ActiveRow);
                    }
                    else
                    {
                        addItemToItemsPerPropUnit(tmpQuotationItem);
                    }

                    bsFixedValuesPerPropUnit[index] = tmpFixedValue;

                    bsFixedItemsPerPropUnit.EndEdit();
                }
            }
        }

        private void ugLengthPerFloorAndTyOfPropUnit_AfterCellUpdate(object sender, CellEventArgs e)
        {
            LengthPerFloorPerPropUnitType tmpLengthPerFloorPerPropUnitType = (LengthPerFloorPerPropUnitType)bsLenthPerFloorPropUnitType.Current;

            if (QuotationMode == OperationType.Modification)
            {
                tmpLengthPerFloorPerPropUnitType.Operation = "U";
            }

            if (e.Cell.Column.Key == "Flute" || e.Cell.Column.Key == "Oven" || e.Cell.Column.Key == "BBQ" || e.Cell.Column.Key == "Stove"
                || e.Cell.Column.Key == "Dryer" || e.Cell.Column.Key == "Heater" || e.Cell.Column.Key == "LongValBaj" || e.Cell.Column.Key == "LongBajTabl" || e.Cell.Column.Key == "LongTab"
                || e.Cell.Column.Key == "LongBaj")
            {

                for (int i = 0; i < bsItemsPerLength.Count; i++)
                {
                    ItemsPerLength tmp = (ItemsPerLength)bsItemsPerLength[i];
                    if (e.Cell.Column.Key == "Flute")
                    {
                        if (tmp.Flute)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "Oven")
                    {
                        if (tmp.Oven)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "BBQ")
                    {
                        if (tmp.BBQ)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "Stove")
                    {
                        if (tmp.Stove)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "Dryer")
                    {
                        if (tmp.Dryer)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "Heater")
                    {
                        if (tmp.Heater)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "LongValBaj")
                    {
                        if (tmp.LongValBaj)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "LongBajTabl")
                    {
                        if (tmp.LongBajTabl)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "LongTab")
                    {
                        if (tmp.LongTab)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                    if (e.Cell.Column.Key == "LongBaj")
                    {
                        if (tmp.LongBaj)
                        {
                            updateItemsPerLengthInItemsPerPropUnit(tmpLengthPerFloorPerPropUnitType.Floor, tmpLengthPerFloorPerPropUnitType.PropUnitTypeId, tmp.ItemId);
                        }
                    }
                }
            }
        }

        private void ugQuotationResult_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key == "Price" & e.Cell.Value != null && Convert.ToInt64(this.ugQuotationResult.ActiveRow.Cells["TASKTYPE"].Value) == nuInternalConnTaskType)
            {
                newIntConnPrice = Convert.ToDouble(e.Cell.Value);
            }

            ConsolidatedQuotation tmpConsolidatedQuotation = (ConsolidatedQuotation)bsConsolidatedQuotation.Current;

            if (QuotationMode == OperationType.Modification && tmpConsolidatedQuotation.Operation == "N")
            {
                tmpConsolidatedQuotation.Operation = "U";
            }

            calculateCost(nuInternalConnTaskType);
            calculateCost(nuChargeConnTaskType);
        }

        //Implementación del Cargo por Conexión
        private void ugItemsPerProjectChargConn_AfterCellUpdate(object sender, CellEventArgs e)
        {
            int index = bsItemsPerProjectChargConn.Position;

            QuotationItem tmpQuotationItem = (QuotationItem)bsItemsPerProjectChargConn[index];

            if (e.Cell.Column.Key == "ItemDescription")
            {
                //Valida si existe en la grilla de ítems por proyecto
                if (itemAlreadyExists(itemPerProjectChargConn.QuotationItem, bsItemsPerProjectChargConn, "QI"))
                {
                    utilities.DisplayErrorMessage("Este ítem ya existe");
                    bsItemsPerProjectChargConn.RemoveCurrent();
                    return;
                }

                tmpQuotationItem.ItemDescription = itemPerProjectChargConn.QuotationItem.ItemDescription;
                tmpQuotationItem.ItemId = itemPerProjectChargConn.QuotationItem.ItemId;
                tmpQuotationItem.Price = itemPerProjectChargConn.QuotationItem.Price;
                tmpQuotationItem.Cost = itemPerProjectChargConn.QuotationItem.Cost;
                tmpQuotationItem.Amount = 1;

                QuotationItem tmpQuotationItem2 = new QuotationItem(tmpQuotationItem);
                tmpQuotationItem2.Price = (itemPerProjectChargConn.QuotationItem.Price / projectBasicData.UnitsPropTotal);
                tmpQuotationItem2.Cost = (itemPerProjectChargConn.QuotationItem.Cost / projectBasicData.UnitsPropTotal);

                addItemToItemsPerPropUnit(tmpQuotationItem2);
                bsItemsPerProjectChargConn.EndEdit();
            }

            if (e.Cell.Column.Key == "Amount" || (e.Cell.Column.Key == "Cost"))
            {
                if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                {
                    updateAmountValueItemsPerPropUnit(this.ugItemsPerProjectChargConn.ActiveRow, e.Cell.Value);
                }
                if (tmpQuotationItem.Operation == "N")
                {
                    tmpQuotationItem.Operation = "U";
                }
            }
        }

        private void ugItemsPerPropUnitChargConn_AfterCellUpdate(object sender, CellEventArgs e)
        {
            int index = bsItemsPerPropUnitCharConn.Position;

            QuotationItem tmpQuotationItem = (QuotationItem)bsItemsPerPropUnitCharConn[index];

            if (e.Cell.Column.Key == "ItemDescription")
            {
                if (itemAlreadyExists(fixedItemPerPropUnitChargConn.QuotationItem, bsItemsPerPropUnitCharConn, "QI"))
                {
                    utilities.DisplayErrorMessage("Este ítem ya existe");
                    bsItemsPerPropUnitCharConn.RemoveCurrent();
                    return;
                }

                tmpQuotationItem.Amount = 1;
                tmpQuotationItem.ItemId = fixedItemPerPropUnitChargConn.QuotationItem.ItemId;
                tmpQuotationItem.ItemDescription = fixedItemPerPropUnitChargConn.QuotationItem.ItemDescription;
                tmpQuotationItem.Price = fixedItemPerPropUnitChargConn.QuotationItem.Price;
                tmpQuotationItem.Cost = fixedItemPerPropUnitChargConn.QuotationItem.Cost;

                bsItemsPerPropUnitCharConn[index] = tmpQuotationItem;

                addItemToItemsPerPropUnit(tmpQuotationItem);

                bsItemsPerPropUnitCharConn.EndEdit();
            }

            if (e.Cell.Column.Key == "Amount")
            {
                if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                {
                    updateAmountValueItemsPerPropUnit(this.ugItemsPerPropUnitChargConn.ActiveRow, e.Cell.Value);
                }

                if (tmpQuotationItem.Operation == "N")
                {
                    tmpQuotationItem.Operation = "U";
                }
            }
        }

        private void ugFixedValuesChargConn_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key == "Cost" || e.Cell.Column.Key == "Description" || e.Cell.Column.Key == "Amount")
            {
                if (Convert.ToDouble(this.ugFixedValuesChargConn.ActiveRow.Cells["Cost"].Value) > 0
                    & Convert.ToDouble(this.ugFixedValuesChargConn.ActiveRow.Cells["Amount"].Value) > 0
                    & !string.IsNullOrEmpty(Convert.ToString(this.ugFixedValuesChargConn.ActiveRow.Cells["Description"].Value)))
                {
                    int index = bsFixedValuesChargConn.Position;
                    FixedValues tmpFixedValue = (FixedValues)bsFixedValuesChargConn[index];
                    tmpFixedValue.ProjectId = nuProjectId;
                    tmpFixedValue.Description = Convert.ToString(this.ugFixedValuesChargConn.ActiveRow.Cells["Description"].Value);
                    QuotationItem tmpQuotationItem = new QuotationItem(tmpFixedValue);

                    if (tmpFixedValue.Operation == "N")
                    {
                        tmpFixedValue.Operation = "U";
                    }

                    if (itemAlreadyExists(tmpQuotationItem, bsItemsPropUnit, "PI"))
                    {
                        updateFixedValuesInItemsPerPropUnit(this.ugFixedValuesChargConn.ActiveRow);
                    }
                    else
                    {
                        addItemToItemsPerPropUnit(tmpQuotationItem);
                    }

                    bsFixedValuesChargConn[index] = tmpFixedValue;

                    bsFixedValuesChargConn.ResetBindings(true);
                }
            }
        }
        #endregion

        /// <summary>
        /// Método para agregar items fijos a los items por unidad prediales
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 25-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void addItemToItemsPerPropUnit(QuotationItem quotationItem)
        {
            if (quotationItem.Cost > 0)
            {

                foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
                {
                    QuotationItem tmpQuotationItem = new QuotationItem(quotationItem);
                    tmpQuotationItem.FloorId = pisoTipo.FloorId;
                    tmpQuotationItem.PropUnitTypeId = pisoTipo.PropUnitType;

                    if (quotationItem.ItemType == "IM")
                    {
                        tmpQuotationItem.TaskType = nuInternalConnTaskType;
                    }
                    pisoTipo.QuotationItemList.Add(tmpQuotationItem);
                }

                refreshItemsPropUnit();
            }

        }

        /// <summary>
        /// Método para actualizar la cantidad en los items por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 25-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void updateAmountValueItemsPerPropUnit(UltraGridRow ugRow, Object value)
        {
            PropPerFloorAndUnitType tmpPropPerFloorAndUnitType = new PropPerFloorAndUnitType();

            QuotationItem tmpQuotItem = ugRow.ListObject as QuotationItem;

            for (int i = 0; i < bsItemsPropUnit.Count; i++)
            {
                tmpPropPerFloorAndUnitType = (PropPerFloorAndUnitType)bsItemsPropUnit[i];

                for (int a = 0; a < tmpPropPerFloorAndUnitType.QuotationItemList.Count; a++)
                {
                    if (tmpPropPerFloorAndUnitType.QuotationItemList[a].ItemId == tmpQuotItem.ItemId
                        && tmpPropPerFloorAndUnitType.QuotationItemList[a].ItemType == tmpQuotItem.ItemType
                        && tmpPropPerFloorAndUnitType.QuotationItemList[a].TaskType == tmpQuotItem.TaskType)
                    {
                        tmpPropPerFloorAndUnitType.QuotationItemList[a].Amount = Convert.ToDouble(value);
                    }
                }

                bsItemsPropUnit[i] = tmpPropPerFloorAndUnitType;
            }
        }

        /// <summary>
        /// Método para actualizar los ítems por metraje en los items por unidades prediales
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 27-05-2016  KCienfuegos            1 - creación        
        /// 10-07-2018  DValiente              2- Modifico Int64 x String Caso 200-1640
        /// </changelog>
        private void updateItemsPerLengthInItemsPerPropUnit(Int64 floorId, Int64 propUnitTypeId, /*Int64*/String itemId)
        {
            List<PropPerFloorAndUnitType> ab = PropPerFloorAndUnitTypeList;

            for (int i = 0; i < PropPerFloorAndUnitTypeList.Count; i++)
            {
                PropPerFloorAndUnitType tmp = (PropPerFloorAndUnitType)bsItemsPropUnit[i];
                if (floorId != -1 && propUnitTypeId != -1)
                {
                    if (tmp.FloorId != floorId || tmp.PropUnitType != propUnitTypeId)  //&&
                    {
                        continue;
                    }
                }

                int index = tmp.QuotationItemList.FindIndex(delegate(QuotationItem ar) { return ar.ItemId == itemId & ar.ItemType == "IM"; });
                if (index >= 0)
                {
                    LengthPerFloorPerPropUnitType tmpLengthPerFloorPerPropUnitType = null;
                    Int32? floor = tmp.QuotationItemList[index].FloorId;
                    Int32? propUnitType = tmp.QuotationItemList[index].PropUnitTypeId;
                    tmpLengthPerFloorPerPropUnitType = LengthPerFloorPerPropUnitTypeList.Find(delegate(LengthPerFloorPerPropUnitType ar)
                    { return ar.Floor == floor && ar.PropUnitTypeId == propUnitType; });
                    if (tmpLengthPerFloorPerPropUnitType != null)
                    {
                        ItemsPerLength tmpItemsPerLength = null;

                        tmpItemsPerLength = ItemsPerLengthList.Find(delegate(ItemsPerLength il) { return il.ItemId == itemId; });

                        if (tmpItemsPerLength != null)
                        {
                            Double amount = (tmpItemsPerLength.Flute == true ? tmpLengthPerFloorPerPropUnitType.Flute : 0) +
                                        (tmpItemsPerLength.BBQ == true ? tmpLengthPerFloorPerPropUnitType.BBQ : 0) +
                                        (tmpItemsPerLength.Oven == true ? tmpLengthPerFloorPerPropUnitType.Oven : 0) +
                                        (tmpItemsPerLength.Stove == true ? tmpLengthPerFloorPerPropUnitType.Stove : 0) +
                                        (tmpItemsPerLength.Dryer == true ? tmpLengthPerFloorPerPropUnitType.Dryer : 0) +
                                        (tmpItemsPerLength.Heater == true ? tmpLengthPerFloorPerPropUnitType.Heater : 0) +
                                        (tmpItemsPerLength.LongBaj == true ? tmpLengthPerFloorPerPropUnitType.LongBaj : 0) +
                                        (tmpItemsPerLength.LongBajTabl == true ? tmpLengthPerFloorPerPropUnitType.LongBajTabl : 0) +
                                        (tmpItemsPerLength.LongValBaj == true ? tmpLengthPerFloorPerPropUnitType.LongValBaj : 0) +
                                        (tmpItemsPerLength.LongTab == true ? tmpLengthPerFloorPerPropUnitType.LongTab : 0);

                            tmp.QuotationItemList[index].Amount = amount;
                            bsItemsPropUnit[i] = tmp;
                        }
                    }
                    if (floorId != -1 && propUnitTypeId != -1)
                    {
                        break;
                    }
                }

            }

            refreshItemsPropUnit();
        }

        /// <summary>
        /// Método para actualizar los datos del valor fijo en los items por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 26-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void updateFixedValuesInItemsPerPropUnit(UltraGridRow ugRow)
        {
            PropPerFloorAndUnitType tmpPropPerFloorAndUnitType = new PropPerFloorAndUnitType();

            FixedValues tmpFixedValue = ugRow.ListObject as FixedValues;

            for (int i = 0; i < bsItemsPropUnit.Count; i++)
            {
                tmpPropPerFloorAndUnitType = (PropPerFloorAndUnitType)bsItemsPropUnit[i];

                for (int a = 0; a < tmpPropPerFloorAndUnitType.QuotationItemList.Count; a++)
                {
                    if (tmpPropPerFloorAndUnitType.QuotationItemList[a].ItemId == tmpFixedValue.Consecutive
                        & tmpPropPerFloorAndUnitType.QuotationItemList[a].TaskType == tmpFixedValue.TaskType) //Convert.ToInt64(ugRow.Cells["Consecutive"].Value)
                    {
                        tmpPropPerFloorAndUnitType.QuotationItemList[a].Comment = tmpFixedValue.Description; //Convert.ToString(ugRow.Cells["Description"].Value)
                        tmpPropPerFloorAndUnitType.QuotationItemList[a].Amount = tmpFixedValue.Amount; //Convert.ToDouble(ugRow.Cells["Amount"].Value)
                        tmpPropPerFloorAndUnitType.QuotationItemList[a].Cost = tmpFixedValue.Cost; //Convert.ToDouble(ugRow.Cells["Cost"].Value)
                    }
                }

                bsItemsPropUnit[i] = tmpPropPerFloorAndUnitType;
            }
        }

        /// <summary>
        /// Método para borrar los items por unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 25-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void deleteItemsPerPropUnit(object o)
        {
            QuotationItem itemToRemove = (QuotationItem)o;
            PropPerFloorAndUnitType tmpPropPerFloorAndUnitType;
            List<PropPerFloorAndUnitType> tmpPropPerFloorAndUnitTypeList = new List<PropPerFloorAndUnitType>();

            //this.ugItemsPerPropUnit.Rows.CollapseAll(true);

            for (int i = 0; i < bsItemsPropUnit.Count; i++)
            {
                tmpPropPerFloorAndUnitType = (PropPerFloorAndUnitType)bsItemsPropUnit[i];

                for (int j = 0; j < tmpPropPerFloorAndUnitType.QuotationItemList.Count; j++)
                {
                    if (tmpPropPerFloorAndUnitType.QuotationItemList[j].ItemId == itemToRemove.ItemId
                        && tmpPropPerFloorAndUnitType.QuotationItemList[j].ItemType == itemToRemove.ItemType
                        && tmpPropPerFloorAndUnitType.QuotationItemList[j].TaskType == itemToRemove.TaskType)
                    {
                        if (itemToRemove.Operation == "N" && itemToRemove.ItemType == "IU")
                        {
                            itemToRemove.Operation = "D";
                            quotationItemsToDelete.Add(itemToRemove);
                        }

                        tmpPropPerFloorAndUnitType.QuotationItemList.RemoveAt(j);

                        break;
                    }
                    bsItemsPropUnit.ResetItem(i);
                }
                tmpPropPerFloorAndUnitTypeList.Add(tmpPropPerFloorAndUnitType);
            }
            PropPerFloorAndUnitTypeList.Clear();
            PropPerFloorAndUnitTypeList = tmpPropPerFloorAndUnitTypeList;
            bsItemsPropUnit.DataSource = PropPerFloorAndUnitTypeList;
            refreshItemsPropUnit();
        }

        private void otcQuotation_ActiveTabChanging(object sender, Infragistics.Win.UltraWinTabControl.ActiveTabChangingEventArgs e)
        {
            calculateCost(nuInternalConnTaskType);
            calculateCost(nuChargeConnTaskType);

            if (e.Tab.Index == 1 || e.Tab.Index == 2 || e.Tab.Index == 3)
            {
                if (this.otcQuotation.ActiveTab.Index == 0)
                {
                    if (!validQuotationItemRow(ugFixedItemsPerProject) || !validQuotationItemRow(ugFixedItemsPerPropUnit) || !validFixedValueRow(this.ugFixedValuesPerPropUnit.ActiveRow))
                    {
                        e.Cancel = true;
                        return;
                    }

                    if (!FieldsAreValid(BasicConfiguration))
                    {
                        e.Cancel = true;
                        return;
                    }
                }
                else if (this.otcQuotation.ActiveTab.Index == 1)
                {
                    if (!validQuotationItemRow(ugItemsPerProjectChargConn) || !validQuotationItemRow(ugItemsPerPropUnitChargConn) || !validFixedValueRow(this.ugFixedValuesChargConn.ActiveRow))
                    {
                        e.Cancel = true;
                        return;
                    }

                    if (!FieldsAreValid(BasicConfiguration))
                    {
                        e.Cancel = true;
                        return;
                    }
                }
                else if (this.otcQuotation.ActiveTab.Index == 2) //Se validan los datos de la pestaña de Detalle de Cotización
                {
                    if (!FieldsAreValid(QuotationDetail))
                    {
                        e.Cancel = true;
                        return;
                    }
                }

                if (e.Tab.Index == 2)
                {
                    otcQuotation.Tabs[2].Enabled = true;
                }

                if (e.Tab.Index == 3)
                {
                    otcQuotation.Tabs[3].Enabled = true;
                }

                //if (e.Tab.Index == 1 || e.Tab.Index == 2 || e.Tab.Index == 3) 
                //{
                //    if (!validQuotationItemRow(ugFixedItemsPerProject) || !validQuotationItemRow(ugFixedItemsPerPropUnit) || !validFixedValueRow(this.ugFixedValuesPerPropUnit.ActiveRow))
                //    {
                //        e.Cancel = true;
                //        return;
                //    }

                //    //Se validan los datos de la pestaña de Items de Red Interna
                //    if ((this.otcQuotation.ActiveTab.Index == 0 & e.Tab.Index == 1) || (this.otcQuotation.ActiveTab.Index == 1 & e.Tab.Index == 2))
                //    {
                //        if (!FieldsAreValid(BasicConfiguration))
                //        {
                //            e.Cancel = true;
                //            return;
                //        }

                //        if (e.Tab.Index == 1)
                //        {
                //            otcQuotation.Tabs[1].Enabled = true;
                //        }
                //        else
                //        {
                //            otcQuotation.Tabs[2].Enabled = true;
                //        }
                //    }

                //    //Se validan los datos de la pestaña de Detalle de Cotización
                //    if (this.otcQuotation.ActiveTab.Index == 1 & e.Tab.Index == 3)
                //    {
                //        if (!FieldsAreValid(QuotationDetail))
                //        {
                //            e.Cancel = true;
                //            return;
                //        }
                //        otcQuotation.Tabs[2].Enabled = true;
                //    }

                //    CalcInternalConnTotal();

            }

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            if (QuotationMode == OperationType.Modification && blFDMPC.ProjectHasSale(nuProjectId))
            {
                utilities.DisplayErrorMessage("No es posible modificar la cotización: Ya existe una cotización pre-aprobada/aprobada");
                return;
            }

            if (FieldsAreValid(AllData))
            {
                SaveChanges(out error);
                if (error)
                {
                    utilities.DisplayErrorMessage("No es posible Guardar/Modificar la cotización");
                    return;
                }
            }

        }

        private void btnApprove_Click(object sender, EventArgs e)
        {
            if (blFDMPC.ProjectHasSale(nuProjectId))
            {
                utilities.DisplayErrorMessage("Ya existe una cotización pre-aprobada/aprobada");
                return;
            }

            if (FieldsAreValid(AllData))
            {
                if (tbQuotationValidityDate.TextBoxValue == null)
                {
                    utilities.DisplayErrorMessage("Debe ingresar la fecha de vigencia");
                    return;
                }

                try
                {
                    if (quotationBasicData.ValidityDate != Convert.ToDateTime(tbQuotationValidityDate.TextBoxObjectValue))
                    {
                        SetQuotationBasicData();
                        blFDRCC.UpdateValidityDate(quotationBasicData);
                    }
                    utilities.doCommit();
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                }

                if (string.IsNullOrEmpty(Convert.ToString(tbPromissoryNote.TextBoxValue)) & string.IsNullOrEmpty(Convert.ToString(tbContract.TextBoxValue)))
                {
                    DialogResult continueResult = ExceptionHandler.DisplayMessage(
                                        2741,
                                        "Recuerde que no ha ingresado ni el pagaré ni el contrato. Desea continuar con la pre-aprobación?",
                                        MessageBoxButtons.YesNo,
                                        MessageBoxIcon.Question);

                    if (continueResult == DialogResult.No)
                    {
                        return;

                    }
                }

                try
                {
                    using (FRNC frm = new FRNC(nuProjectId, nuQuotationConsecutive))
                    {
                        frm.ShowDialog();
                        if (frm.QuotationStatus == "P")
                        {
                            ocQuotationStatus.Value = frm.QuotationStatus;

                        }
                    }
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                    return;
                }
            }
        }

        private void btnCopyQuotation_Click(object sender, EventArgs e)
        {
            Int64 newQuotation = -1;
            if (FieldsAreValid(AllData))
            {
                try
                {
                    newQuotation = blFDRCC.CopyQuotation(nuProjectId, nuQuotationConsecutive);

                    if (newQuotation > 0)
                    {
                        utilities.doCommit();
                        utilities.DisplayInfoMessage("La copia se realizó exitosamente. El consecutivo de la nueva cotización es " + newQuotation);
                        return;
                    }
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                    return;
                }
            }
        }

        private void updatebsConsolidatedQuotation(Object ocValue, String taskTypeClassif)
        {
            if (ocValue != null)
            {
                Int64 taskTypeId = 0;
                //Caso 200-1640
                itemTaskType tmpItemTaskType = itemTaskTypeList.Find(delegate(itemTaskType it) { return it.ItemId == ocValue.ToString(); });//Convert.ToInt64(ocValue)

                if (tmpItemTaskType != null)
                {
                    ConsolidatedQuotation tmp = ConsolidatedQuotationList.Find(delegate(ConsolidatedQuotation cq) { return cq.TaskTypeAcron == taskTypeClassif;/*tmpItemTaskType.TaskType; */});
                    //Si el consolidado por el acrónimo ya existe, valido si el tipo de trabajo seleccionado es diferente al actual, si es el caso debo borrar el actual y luego 
                    //Crear el registro para el nuevo tipo de trabajo
                    //Si el consolidado por el acrónimo ya existe, y sólo se cambió la actividad, funciona como lo hace actualmente
                    //Si el consolidado por el acrónimo no existe, entonces se crea el nuevo registro

                    if (tmp == null)
                    {
                        CreateConsRecord(taskTypeClassif, tmpItemTaskType);
                    }
                    else
                    {
                        switch (taskTypeClassif)
                        {
                            case Constants.INTERNAL_CON_CLASS:
                                taskTypeId = nuInternalConnTaskType;
                                break;
                            case Constants.CHARGE_BY_CON_CLASS:
                                taskTypeId = nuChargeConnTaskType;
                                break;
                            case Constants.CERTIFICATION_CLASS:
                                taskTypeId = nuCertificationTaskType;
                                break;
                            default:
                                break;
                        }

                        if (tmpItemTaskType.TaskType == taskTypeId)
                        {
                            tmp.ItemdId = tmpItemTaskType.ItemId;
                            tmp.Operation = "U";
                        }
                        else
                        {
                            ResetItems(taskTypeClassif);
                            CreateConsRecord(taskTypeClassif, tmpItemTaskType);
                        }
                    }
                }
            }
            else
            {
                ResetItems(taskTypeClassif);
            }
        }

        private void CreateConsRecord(String taskTypeClassif, itemTaskType tmpItemTaskType)
        {
            ConsolidatedQuotation c = (ConsolidatedQuotation)this.bsConsolidatedQuotation.AddNew();
            c.TaskType = tmpItemTaskType.TaskType;
            c.ItemdId = tmpItemTaskType.ItemId;
            c.TaskTypeDesc = tmpItemTaskType.TaskTypeDesc;
            c.Project = nuProjectId;
            c.Operation = "R";
            c.TaskTypeAcron = taskTypeClassif;

            if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
            {
                c.Iva = GeneralVariables.InternConnIVA;
                nuInternalConnTaskType = tmpItemTaskType.TaskType;
            }
            else if (taskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
            {
                c.Iva = GeneralVariables.ChargeByConnIVA;
                nuChargeConnTaskType = tmpItemTaskType.TaskType;
            }
            else
            {
                c.Iva = GeneralVariables.CertificationIVA;
                nuCertificationTaskType = tmpItemTaskType.TaskType;
            }
        }

        private void ResetItems(String taskTypeClassif)
        {
            for (int i = 0; i < bsConsolidatedQuotation.Count; i++)
            {
                ConsolidatedQuotation a = (ConsolidatedQuotation)bsConsolidatedQuotation[i];
                if (a.TaskTypeAcron == taskTypeClassif)
                {
                    if (a.Operation == "N" || a.Operation == "U")
                    {
                        QuotationTaskType b = new QuotationTaskType(a);
                        b.Operation = "D";
                        taskTypeToDelete.Add(b);
                    }
                    bsConsolidatedQuotation.RemoveAt(i);
                    break;
                }
            }

            if (taskTypeClassif == Constants.INTERNAL_CON_CLASS)
            {
                ResetIntConnItems();
            }
            else if (taskTypeClassif == Constants.CHARGE_BY_CON_CLASS)
            {
                ResetChargConnItems();
            }
            CalSubtotalValues();
        }

        private void calculateCost(Int64 taskType)
        {
            Double totalCost = 0;
            Double SubtotalCost = 0;
            Double calculatedCost = 0;

            hasItems = false;

            foreach (PropPerFloorAndUnitType pisoTipo in bsItemsPropUnit)
            {
                SubtotalCost = 0;

                LengthPerFloorPerPropUnitType t = LengthPerFloorPerPropUnitTypeList.Find(delegate(LengthPerFloorPerPropUnitType lp)
                { return lp.Floor == pisoTipo.FloorId && lp.PropUnitTypeId == pisoTipo.PropUnitType; });

                foreach (QuotationItem item in pisoTipo.QuotationItemList)
                {
                    if (item.TaskType == taskType)
                    {
                        SubtotalCost = SubtotalCost + (item.TotalCost);
                    }

                    if (item.TaskType == nuInternalConnTaskType)
                    {
                        hasItems = true;
                    }
                    else if (item.TaskType == nuChargeConnTaskType)
                    {
                        hasChargConnItems = true;
                    }
                }

                if (t != null)
                {
                    SubtotalCost = SubtotalCost * t.AmountPropUnit;
                    totalCost = totalCost + SubtotalCost;
                }
            }

            int index = ConsolidatedQuotationList.FindIndex(delegate(ConsolidatedQuotation cq) { return cq.TaskType == taskType; });

            if (index >= 0)
            {
                ConsolidatedQuotation c = (ConsolidatedQuotation)bsConsolidatedQuotation[index];
                calculatedCost = Math.Round(totalCost / projectBasicData.UnitsPropTotal, 2);

                if (c.Operation == "N")
                {
                    c.Operation = "U";
                }
                c.Cost = calculatedCost;

                if (taskType == nuInternalConnTaskType)
                {
                    calculatedIntConnPrice = calculatedCost;
                }
                else if (taskType == nuChargeConnTaskType)
                {
                    calculatedCost = calculatedCost * (1 + (GeneralVariables.ChargeByConnIVACost / 100));
                    c.Cost = calculatedCost;

                    calculatedChargConnPrice = calculatedCost;
                }

                bsConsolidatedQuotation.EndEdit();
            }

            CalSubtotalValues();
            refreshConsolidatedQuotation();
        }

        public void refreshConsolidatedQuotation()
        {
            this.bsConsolidatedQuotation.ResetBindings(true);
            this.ugQuotationResult.Rows.Refresh(RefreshRow.ReloadData, true);
        }

        private void CalSubtotalValues()
        {
            Double priceByService = 0;
            Double totalPerService = 0;

            for (int i = 0; i < bsConsolidatedQuotation.Count; i++)
            {
                ConsolidatedQuotation t = (ConsolidatedQuotation)bsConsolidatedQuotation[i];
                priceByService = priceByService + t.TotalPrice;
            }

            tbPriceByPropUnit.TextBoxValue = Convert.ToString(priceByService);
            totalPerService = priceByService * projectBasicData.UnitsPropTotal;
            tbTotalPerServices.TextBoxValue = Convert.ToString(totalPerService);
            tbQuotedValue.TextBoxValue = Convert.ToString(totalPerService);
        }

        private bool QuotationConsolidateIsValid()
        {

            if (isPlanIntEsp.Equals("N"))
            {

                foreach (ConsolidatedQuotation item in bsConsolidatedQuotation)
                {
                    if (item.Price <= 0)
                    {
                        utilities.DisplayErrorMessage("El precio de los consolidados de la cotización debe ser mayor a cero");
                        return false;
                    }
                    if (item.Cost <= 0)
                    {
                        utilities.DisplayErrorMessage("El costo de los consolidados de la cotización debe ser mayor a cero");
                        return false;
                    }
                    if (item.IvaValue < 0)
                    {
                        utilities.DisplayErrorMessage("El valor del IVA debe ser mayor o igual a cero");
                        return false;
                    }
                    if (item.Cost > item.Price)
                    {
                        utilities.DisplayErrorMessage("El precio a cotizar por tipo de trabajo debe ser mayor al costo calculado");
                        return false;
                    }
                }
            }//inicio ca 200-2022
            else
            {
                foreach (ConsolidatedQuotation item in bsConsolidatedQuotation)
                {
                    if (item.Price > 0)
                    {
                        utilities.DisplayErrorMessage("El plan es Interna Especial, El precio de los consolidados de la cotización debe ser cero");
                        return false;
                    }
                    if (item.Cost > 0)
                    {
                        utilities.DisplayErrorMessage("El plan es Interna Especial, El costo de los consolidados de la cotización debe ser cero");
                        return false;
                    }
                    if (item.IvaValue > 0)
                    {
                        utilities.DisplayErrorMessage("El plan es Interna Especial, El valor del IVA debe ser Igual a cero");
                        return false;
                    }
                   
                }
                //fin ca 200-2022
            }

            return true;
        }

        private bool ItemsPerPropUnitIsValid()
        {
//inicio ca 200-2022
            if (isPlanIntEsp.Equals("N"))
            {
                foreach (PropPerFloorAndUnitType floor_UnitType in bsItemsPropUnit)
                {
                    foreach (QuotationItem a in floor_UnitType.QuotationItemList)
                    {
                        if (a.TotalCost <= 0)
                        {
                            utilities.DisplayErrorMessage("El costo total de cada ítem debe ser mayor a cero. Por favor verifique");
                            return false;
                        }
                    }
                }
            }
            else
            {
                foreach (PropPerFloorAndUnitType floor_UnitType in bsItemsPropUnit)
                {
                    foreach (QuotationItem a in floor_UnitType.QuotationItemList)
                    {
                        if (a.TotalCost > 0)
                        {
                            utilities.DisplayErrorMessage("El plan es Interna Especial, el costo total de cada ítem debe cero. Por favor verifique");
                            return false;
                        }
                    }
                }
            }
            //fin ca 200-2022

            return true;
        }

        private void ocQuotationStatus_ValueChanged(object sender, EventArgs e)
        {
            if (Convert.ToString(ocQuotationStatus.Value) != "R")
            {
                this.btnPrintPreCup.Enabled = true;
                this.btnSave.Enabled = false;
                this.btnApprove.Enabled = false;
            }
        }

        private void btnPrintPreCup_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbQuotationConsecutive.TextBoxValue))
            {
                using (POCI frm = new POCI(nuProjectId, nuQuotationConsecutive))
                {
                    frm.ShowDialog();
                }
            }
            else
            {
                utilities.DisplayErrorMessage("No existe una cotización válida para imprimir pre-cupón");
            }
        }

        private void btnPrevious_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[1];
        }



        private void ugItemsPerPropUnit_AfterRowActivate(object sender, EventArgs e)
        {
            if (this.ugItemsPerPropUnit.ActiveRow.Band.Index == 1)
            {
                if (Convert.ToString(this.ugItemsPerPropUnit.ActiveRow.Cells["ItemType"].Value) != "IU")
                {
                    ugItemsPerPropUnit.ActiveRow.Cells["itemDescription"].Activation = Activation.NoEdit;
                    ugItemsPerPropUnit.ActiveRow.Cells["Comment"].Activation = Activation.NoEdit;
                }
            }
        }

        private void btnPrev_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[2];
        }

        private void tbQuotationValidityDate_Validating(object sender, CancelEventArgs e)
        {
            if (Convert.ToDateTime(tbQuotationValidityDate.TextBoxValue).Date < OpenDate.getSysDateOfDataBase().Date)
            {
                utilities.DisplayErrorMessage("La fecha de vigencia debe ser mayor a la fecha actual");
            }
        }

        private void btnNext1_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[2];
        }

        private void btnPrevious1_Click(object sender, EventArgs e)
        {
            otcQuotation.SelectedTab = otcQuotation.Tabs[0];
        }

        private void ugQuotationResult_AfterRowActivate(object sender, EventArgs e)
        {
            if (this.ugQuotationResult.ActiveRow != null)
            {
                if (Convert.ToInt64(this.ugQuotationResult.ActiveRow.Cells["TaskType"].Value) == nuInternalConnTaskType
                    || Convert.ToInt64(this.ugQuotationResult.ActiveRow.Cells["TaskType"].Value) == nuChargeConnTaskType)
                {
                    ugQuotationResult.ActiveRow.Cells["Cost"].Activation = Activation.NoEdit;
                }
            }
        }

        //caso 200-1640
        String codUnitWork = "";
        String codListCost = "";
        //

        //Caso 200-1460
        private void cbx_unitwork_ValueChanged(object sender, EventArgs e)
        {
            //valido que no este iniciando el formulario
            if (!inicio)
            {
                //delValueListToGridColumn();
                //valido cuando el combo esta en nulo
                if (cbx_unitwork.Value == null)
                {
                    //si hay un codigo previamente seleccionado se retorna este valor
                    if (codUnitWork != "")
                    {
                        inicio = true;
                        //cbx_unitwork.Value = Int64.Parse(codUnitWork);
                        for (int i = 0; i <= cbx_unitwork.Rows.Count - 1; i++)
                        {
                            if (cbx_unitwork.Rows[i].Cells[0].Value.ToString() == codUnitWork)
                            {
                                cbx_unitwork.SelectedRow = cbx_unitwork.Rows[i];
                            }
                        }
                        //
                        inicio = false;
                    }
                    else
                    {
                        //llenado de combos
                        hlCostList.Value = null;
                        hlCostList.Select_Statement = "";
                    }
                }
                else
                {
                    //realizo la consulta basicas de generacion de listas a partir del codigo devuelto por el combo
                    //hlCostList.ValueChanged -= hlPriceList_ValueChanged;
                    //hlCostList.Value = null;
                    hlCostList.Select_Statement = string.Join(string.Empty, new string[] { 
                    " select   list_unitary_cost_id id, ",
                    "   description description,  ",
                    "   validity_start_date fecha_inicial_vigencia,  ",
                    "   validity_final_date fecha_final_vigencia  ",
                    " from ge_list_unitary_cost ",
                    "@where @",
                    "@operating_unit_id = " + cbx_unitwork.Value+" @",
                    "@validity_start_date <=sysdate @",
                    "@validity_final_date >=sysdate @",
                    "@list_unitary_cost_id like :id @",
                    "@upper(description) like :description @ "});
                    DataTable Datos = new DataTable();
                    String query = "select list_unitary_cost_id id from ge_list_unitary_cost where operating_unit_id = " + cbx_unitwork.Value + " and validity_start_date <=sysdate and validity_final_date >=sysdate";
                    Datos = blFDRCC.getValueList(query);
                    if (Datos.Rows.Count > 0)
                    {
                        hlCostList.Value = Int64.Parse(Datos.Rows[0].ItemArray[0].ToString());
                    }
                    else
                    {
                        hlCostList.Value = null;
                    }
                    codUnitWork = cbx_unitwork.Value.ToString();
                }
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
        public void fillCursorCombo(OpenCombo targetCombo, String Procedure, String campo = "", String tipo = "", String valor = "", Boolean aplica = false)
        {
            DataSet dsgeneral = new DataSet();
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

            if (aplica)
            {
                DataRow newCustomersRow = dsgeneral.Tables["tabla"].NewRow();

                newCustomersRow["ID"] = Int16.Parse(indice);
                newCustomersRow["DESCRIPTION"] = "Unidad por Defecto";

                dsgeneral.Tables["tabla"].Rows.Add(newCustomersRow);
            }
            targetCombo.DataSource = dsgeneral.Tables["tabla"];
            targetCombo.ValueMember = "ID";
            targetCombo.DisplayMember = "DESCRIPTION";
        }

        //caso 200-1640
        object codContractors = null;
        object tempContractors = null;
        object tempUnitWorks = null;
        object tempList = null;
        private void cbx_contractor_ValueChanged(object sender, EventArgs e)
        {
            if (!inicio)
            {
                if (pn_bloque1.Enabled && codContractors != null)
                {
                    tempContractors = codContractors;//cbx_contractors.Value;
                    tempUnitWorks = cbx_unitwork.Value;
                    tempList = hlCostList.Value;
                    //
                    if (bsFixedItemsPerProject_aux.Count > 0)
                    {
                        int tot = bsFixedItemsPerProject_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsFixedItemsPerProject_aux.RemoveAt(i);
                        }
                    }
                    if (bsFixedItemsPerProject.Count > 0)
                    {
                        foreach (QuotationItem fila in bsFixedItemsPerProject)
                        {
                            //MessageBox.Show(fila.Description);
                            bsFixedItemsPerProject_aux.Add(fila.Clone());
                        }
                    }
                    //
                    if (bsFixedItemsPerPropUnit_aux.Count > 0)
                    {
                        int tot = bsFixedItemsPerPropUnit_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsFixedItemsPerPropUnit_aux.RemoveAt(i);
                        }
                    }
                    if (bsFixedItemsPerPropUnit.Count > 0)
                    {
                        foreach (QuotationItem fila in bsFixedItemsPerPropUnit)
                        {
                            //MessageBox.Show(fila.Description);
                            bsFixedItemsPerPropUnit_aux.Add(fila.Clone());
                        }
                    }
                    //
                    if (bsItemsPerProjectChargConn_aux.Count > 0)
                    {
                        int tot = bsItemsPerProjectChargConn_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsItemsPerProjectChargConn_aux.RemoveAt(i);
                        }
                    }
                    if (bsItemsPerProjectChargConn.Count > 0)
                    {
                        foreach (QuotationItem fila in bsItemsPerProjectChargConn)
                        {
                            //MessageBox.Show(fila.Description);
                            bsItemsPerProjectChargConn_aux.Add(fila.Clone());
                        }
                    }
                    //
                    if (bsItemsPerPropUnitCharConn_aux.Count > 0)
                    {
                        int tot = bsItemsPerPropUnitCharConn_aux.Count - 1;
                        for (int i = tot; i >= 0; i--)
                        {
                            bsItemsPerPropUnitCharConn_aux.RemoveAt(i);
                        }
                    }
                    if (bsItemsPerPropUnitCharConn.Count > 0)
                    {
                        foreach (QuotationItem fila in bsItemsPerPropUnitCharConn)
                        {
                            //MessageBox.Show(fila.Description);
                            bsItemsPerPropUnitCharConn_aux.Add(fila.Clone());
                        }
                    }
                }
                //lista de valores para unidades de Trabajo. Caso 200-1640
                cbx_unitwork.DataSource = null;
                cbx_unitwork.Value = null;
                //se le quita el elemento por defecto  200-1640 : 09.07.18
                fillCursorCombo(cbx_unitwork, "LDC_FRFLISTOPERATINGUNITY", "inuContractor", "Int64", cbx_contractor.Value.ToString());//, true);
                Boolean entro = false;
                //se selecciona el primero por defecto 200-1640 : 09.07.18
                /*for (int i = 0; i <= cbx_unitwork.Rows.Count - 1; i++)
                {
                    if (cbx_unitwork.Rows[i].Cells[0].Value.ToString() == indice)
                    {
                        entro = true;
                        cbx_unitwork.SelectedRow = cbx_unitwork.Rows[i];
                        codUnitWork = indice;
                    }
                }*/
                if (cbx_unitwork.Rows.Count > 0)
                {
                    entro = true;
                    cbx_unitwork.SelectedRow = cbx_unitwork.Rows[0];
                    codUnitWork = cbx_unitwork.Rows[0].Cells[0].Value.ToString();
                }

                if (!entro)
                {
                    //inicio = false;

                    codUnitWork = "";

                    cbx_unitwork.Value = null;
                    //inicio = true;
                }
                //BLOQUEO DE BLOQUES Y BOTONES DE OPERACION
                if (ugFixedItemsPerProject.Rows.Count > 0 || ugFixedItemsPerPropUnit.Rows.Count > 0 || ugItemsPerProjectChargConn.Rows.Count > 0 || ugItemsPerPropUnitChargConn.Rows.Count > 0)
                {
                    pn_bloque1.Enabled = false;
                    pn_bloque2.Enabled = false;
                    pn_button.Visible = true;
                }
                codContractors = cbx_contractor.Value;
            }
        }

        private void ob_aceptar_Click(object sender, EventArgs e)
        {
            pn_bloque1.Enabled = true;
            pn_bloque2.Enabled = true;
            pn_button.Visible = false;
        }

        private void ob_cancelar_Click(object sender, EventArgs e)
        {
            //cbx_contractors.Value = tempContractors;
            for (int i = 0; i <= cbx_contractor.Rows.Count - 1; i++)
            {
                if (cbx_contractor.Rows[i].Cells[0].Value.ToString() == tempContractors.ToString())
                {
                    cbx_contractor.SelectedRow = cbx_contractor.Rows[i];
                }
            }
            codContractors = tempContractors;
            //
            //cbx_workunit.Value = tempUnitWorks;
            codListCost = tempList.ToString();
            //
            for (int i = 0; i <= cbx_unitwork.Rows.Count - 1; i++)
            {
                if (cbx_unitwork.Rows[i].Cells[0].Value.ToString() == tempUnitWorks.ToString())
                {
                    cbx_unitwork.SelectedRow = cbx_unitwork.Rows[i];
                }
            }
            codUnitWork = tempUnitWorks.ToString();
            //pest 1
            //
            while (ugFixedItemsPerProject.Rows.Count > 0)
            {
                ugFixedItemsPerProject.Rows[0].Activate();
                bsFixedItemsPerProject.RemoveCurrent();
            }
            if (bsFixedItemsPerProject_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsFixedItemsPerProject_aux)
                {
                    bsFixedItemsPerProject.Add(fila.Clone());
                }
            }
            //
            while (ugFixedItemsPerPropUnit.Rows.Count > 0)
            {
                ugFixedItemsPerPropUnit.Rows[0].Activate();
                bsFixedItemsPerPropUnit.RemoveCurrent();
            }
            if (bsFixedItemsPerPropUnit_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsFixedItemsPerPropUnit_aux)
                {
                    bsFixedItemsPerPropUnit.Add(fila.Clone());
                }
            }
            //
            while (ugItemsPerProjectChargConn.Rows.Count > 0)
            {
                ugItemsPerProjectChargConn.Rows[0].Activate();
                bsItemsPerProjectChargConn.RemoveCurrent();
            }
            if (bsItemsPerProjectChargConn_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsItemsPerProjectChargConn_aux)
                {
                    bsItemsPerProjectChargConn.Add(fila.Clone());
                }
            }
            //
            while (ugItemsPerPropUnitChargConn.Rows.Count > 0)
            {
                ugItemsPerPropUnitChargConn.Rows[0].Activate();
                bsItemsPerPropUnitCharConn.RemoveCurrent();
            }
            if (bsItemsPerPropUnitCharConn_aux.Count > 0)
            {
                foreach (QuotationItem fila in bsItemsPerPropUnitCharConn_aux)
                {
                    bsItemsPerPropUnitCharConn.Add(fila.Clone());
                }
            }
            //
            refreshConsolidatedQuotation();


            pn_bloque1.Enabled = true;
            pn_bloque2.Enabled = true;
            pn_button.Visible = false;
        }

        private void btImprCot_Click(object sender, EventArgs e)
        {
            if (nuQuotationConsecutive != 0)
            {
                blFDRCC.PrintCotizacion(nuProjectId, nuQuotationConsecutive, Convert.ToString(cbFormatoImp.Value));
            }

        }

        private void cbFormatoImp_ValueChanged(object sender, EventArgs e)
        {
            if (Convert.ToString(cbFormatoImp.Value) != null)
            {
                btImprCot.Enabled = true;
            }
            else
            {
                btImprCot.Enabled = false;
            }
        }

        private void pn_bloque2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void cbx_planComerEsp_Validating(object sender, CancelEventArgs e)
        {
            DataTable dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strChargeByConnItems); 
            //Se carga la lista de tipos de trabajo de cargo por conexión
            ocChargeByConnection.DataSource = dtItemsActivity;
            ocChargeByConnection.DisplayMember = "Description";
            ocChargeByConnection.ValueMember = "Id";

            dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strCertificationItems);

            //Se carga la lista de tipos de trabajo de certificación
            ocCertification.DataSource = dtItemsActivity;
            ocCertification.DisplayMember = "Description";
            ocCertification.ValueMember = "Id";


            if (cbx_planComerEsp.Value != null )
            {
                if (Convert.ToInt32(cbx_planComerEsp.Value) != -1)
                {
                    ActividadesPlanEsp act = blFDRCC.getActiviPlanespec(Convert.ToInt64(cbx_planComerEsp.Value));
                    dtItemsActivity = null;


                    if (act.Activicxc > 0)
                    {   //Se carga la lista de tipos de trabajo de cargo por conexión
                        dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strChargeByConnItems);
                    }

                    //Se carga la lista de tipos de trabajo de cargo por conexión
                    ocChargeByConnection.DataSource = dtItemsActivity;
                    ocChargeByConnection.DisplayMember = "Description";
                    ocChargeByConnection.ValueMember = "Id";

                    if (dtItemsActivity == null)
                    {
                        ocChargeByConnection.Value = "";
                    }

                    dtItemsActivity = null;

                    if (act.Activicert > 0)
                    {
                        //Se carga la lista de tipos de trabajo de certificación
                        dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strCertificationItems);
                    }


                    //Se carga la lista de tipos de trabajo de certificación
                    ocCertification.DataSource = dtItemsActivity;
                    ocCertification.DisplayMember = "Description";
                    ocCertification.ValueMember = "Id";

                    if (dtItemsActivity == null)
                    {
                        ocCertification.Value = "";
                    }
                }
            }
        }

        private void cbx_planComerEsp_ValueChanged(object sender, EventArgs e)
        {
            DataTable dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strChargeByConnItems);
            //Se carga la lista de tipos de trabajo de cargo por conexión
            ocChargeByConnection.DataSource = dtItemsActivity;
            ocChargeByConnection.DisplayMember = "Description";
            ocChargeByConnection.ValueMember = "Id";

            dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strCertificationItems);

            //Se carga la lista de tipos de trabajo de certificación
            ocCertification.DataSource = dtItemsActivity;
            ocCertification.DisplayMember = "Description";
            ocCertification.ValueMember = "Id";


            if (cbx_planComerEsp.Value != null)
            {
                if (Convert.ToInt32(cbx_planComerEsp.Value) != -1)
                {
                    ActividadesPlanEsp act = blFDRCC.getActiviPlanespec(Convert.ToInt64(cbx_planComerEsp.Value));
                    dtItemsActivity = null;

                    isPlanIntEsp = act.PlanIntEsp;

                    if (act.Activicxc > 0)
                    {   //Se carga la lista de tipos de trabajo de cargo por conexión
                        dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strChargeByConnItems);
                    }

                    //Se carga la lista de tipos de trabajo de cargo por conexión
                    ocChargeByConnection.DataSource = dtItemsActivity;
                    ocChargeByConnection.DisplayMember = "Description";
                    ocChargeByConnection.ValueMember = "Id";

                    if (dtItemsActivity == null)
                    {
                        ocChargeByConnection.Value = "";
                    }

                    dtItemsActivity = null;

                    if (act.Activicert > 0)
                    {
                        //Se carga la lista de tipos de trabajo de certificación
                        dtItemsActivity = utilities.getListOfValue(BLGeneralQueries.strCertificationItems);
                    }


                    //Se carga la lista de tipos de trabajo de certificación
                    ocCertification.DataSource = dtItemsActivity;
                    ocCertification.DisplayMember = "Description";
                    ocCertification.ValueMember = "Id";

                    if (dtItemsActivity == null)
                    {
                        ocCertification.Value = "";
                    }
                }

            }
            this.ocCertification.Size = new System.Drawing.Size(191, 22);
            this.ocChargeByConnection.Size = new System.Drawing.Size(183, 22);
        
        }

        private void otcQuotation_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {

        }

        
    }
}
