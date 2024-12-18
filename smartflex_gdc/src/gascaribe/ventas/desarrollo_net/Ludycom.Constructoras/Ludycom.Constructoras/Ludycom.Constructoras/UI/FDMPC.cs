using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.ExceptionHandler;


namespace Ludycom.Constructoras
{
    public partial class FDMPC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFDMPC blFDMPC = new BLFDMPC();
        CustomerBasicData customerBasicData;
        ProjectBasicData projectBasicData;
        ProjectBasicData projectBasicDataToUpdate;
        DataTable dtAparmentDistribution;
        DataTable dtLengthPerAparmType;

        public static String PROJECT_LEVEL = "LDCPRC";

        private List<ListOfValues> PaymentModalityList = new List<ListOfValues>();
        private List<LengthPerFloor> lengthPerFloorList = new List<LengthPerFloor>();
        private List<LengthPerPropUnitType> lengthPerPropUnitTypeList = new List<LengthPerPropUnitType>();
        
        Int64 nuBuilding;
        Int64 nuGroupOfHouses;
        Int64 nuProjectId;
        Int64 nuSubscriberCode;
        Int64? nullValue = null;
        Int64 nuValueToAdd = 0;
        Int64 towers;
        Int64 unitTypes;
        Int64 floor;

        private bool loadingData = false;

        public FDMPC(Int64 projectId)
        {
            InitializeComponent();

            //Se inicializan los datos
            InitializeData(projectId);
        }

        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData(Int64 projectId)
        {
            nuProjectId = projectId;
            customerBasicData = new CustomerBasicData();

            nuBuilding = Convert.ToInt64(utilities.getParameterValue("TIPO_CONST_EDIF", "Int64").ToString());
            nuGroupOfHouses = Convert.ToInt64(utilities.getParameterValue("TIPO_CONST_CASAS", "Int64").ToString());

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Lista de Valores para el Tipo de Construcción
            DataTable dtBuildingType = utilities.getListOfValue(BLGeneralQueries.strBuildingType);
            ocBuildingType.DataSource = dtBuildingType;
            ocBuildingType.ValueMember = "CODIGO";
            ocBuildingType.DisplayMember = "DESCRIPCION";

            //Lista de Valores para los programas de vivienda
            DataTable dtTenement = utilities.getListOfValue(BLGeneralQueries.strTenementPrograms);
            ocTenementProgram.DataSource = dtTenement;
            ocTenementProgram.ValueMember = "CODIGO";
            ocTenementProgram.DisplayMember = "DESCRIPCION";

            //Se carga lista de forma de pago
            PaymentModalityList.Clear();
            PaymentModalityList.Add(new ListOfValues("CH", "Cheque"));
            PaymentModalityList.Add(new ListOfValues("CU", "Cuotas"));
            PaymentModalityList.Add(new ListOfValues("AV", "Avance de Obra"));
            ocPaymentModality.DataSource = PaymentModalityList;
            ocPaymentModality.ValueMember = "Id";
            ocPaymentModality.DisplayMember = "Description";

            //Lista pesada de Localidades
            hlGeograLocation.Select_Statement = string.Join(string.Empty, new string[]{
                " select   ge_geogra_location.geograp_location_id ID, ",
                "   ge_geogra_location.display_description Description  ",
                " from ge_geogra_location ",
                "@WHERE @",
                "@ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc @",
                "@geograp_location_id like :id @ ",
                "@upper(display_description) like :description @ "});

            //Se valida si el proyecto existe
            if (!blFDMPC.ProjectExists(projectId))
            {
                utilities.DisplayErrorMessage("El proyecto con código "+projectId+" no existe en el sistema");
                this.Dispose();
            }

            loadingData = true;

            //Se obtienen los datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

            //Se obtiene el metraje por tipo de unidad predial
            LoadLengthPerPropUnitType(nuProjectId);

            //Se obtiene el metraje por piso
            LoadLengthPerFloor(nuProjectId);

            //Obtener los datos de apartamentos por piso/tipo
            LoadPropUnitByFloorAndType();

            loadingData = false;
        }

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
            projectBasicData.ProjectId = nuProjectId;
            tbProjectName.TextBoxValue = projectBasicData.ProjectName;
            tbProjectComment.TextBoxValue = projectBasicData.Comment;
            projectBasicData.BuildingType = blFDMPC.GetBuildingType(projectId);
            ocBuildingType.Value = projectBasicData.BuildingType;
            ocTenementProgram.Value = projectBasicData.TenementType;

            if (projectBasicData.BuildingType==nuGroupOfHouses)
            {
                tbFloorsQuant.Enabled = false;
            }
            tbAddress.Address_id = Convert.ToString(projectBasicData.AddressId);
            hlGeograLocation.Value = projectBasicData.LocationId;
            tbProjectRegisterDate.TextBoxObjectValue = projectBasicData.RegisterDate;
            tbProjectModificationDate.TextBoxObjectValue = projectBasicData.LastModDate;
            tbTowerQuant.TextBoxValue = Convert.ToString(projectBasicData.Towers);
            tbFloorsQuant.TextBoxValue = Convert.ToString(projectBasicData.Floors);
            tbApartTypeQuant.TextBoxValue = Convert.ToString(projectBasicData.UnitsPropTypes);
            tbApartmentsQuant.TextBoxValue = Convert.ToString(projectBasicData.UnitsPropTotal);
            tbUnitsByTower.TextBoxValue = Convert.ToString(projectBasicData.UnitsPropTotal / projectBasicData.Towers);
            ocPaymentModality.Value = projectBasicData.PaymentModality;
            projectBasicDataToUpdate = projectBasicData;
            towers = projectBasicData.Towers;
            floor = projectBasicData.Floors;
            unitTypes = projectBasicData.UnitsPropTypes;
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
        /// Se cargan las unidades prediales por piso y 
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void LoadPropUnitByFloorAndType()
        {
            dtAparmentDistribution = new DataTable();
            Int32 nuLength = Convert.ToInt32(tbApartTypeQuant.TextBoxValue) + 2;
            String stExpression = "";
            String stFloorName = "";
            int id;
            bsAparmDistribution.DataSource = null;

            for (int i = 0; i < nuLength; i++)
            {
                if (i == 0)
                {
                    //Se crea columna para el ID
                    dtAparmentDistribution.Columns.Add("ID", typeof(Int64));
                    dtAparmentDistribution.Columns["ID"].ReadOnly = true;

                    //Se crea columna para el PISO
                    dtAparmentDistribution.Columns.Add("PISO", typeof(string));
                    dtAparmentDistribution.Columns["PISO"].ReadOnly = true;
                }
                else if (i == (nuLength - 1))
                {
                    //Se crea columna para el TOTAL DE UNIDADES PREDIAL
                    dtAparmentDistribution.Columns.Add("TOTAL_UNIDADES_PREDIALES", typeof(Int64));
                    dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].ReadOnly = false;
                    dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].DefaultValue = 0;
                    dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].Caption = "TOTAL DE UNIDADES PREDIALES";
                }
                else
                {
                    stFloorName = "TIPO_" + i;
                    //Se crea columna para el TIPO DE UNIDAD PREDIAL
                    dtAparmentDistribution.Columns.Add(stFloorName, typeof(Int64));
                    dtAparmentDistribution.Columns[stFloorName].DataType = typeof(Int64);
                    dtAparmentDistribution.Columns[stFloorName].DefaultValue = 0;
                    dtAparmentDistribution.Columns[stFloorName].AllowDBNull = false;
                    dtAparmentDistribution.Columns[stFloorName].Caption = "TIPO " + i;
                    stExpression = stExpression + "+ [" + stFloorName + "]";
                }
            }            

            //Se crean las filas
            for (int i = 0; i < Convert.ToInt32(tbFloorsQuant.TextBoxValue); i++)
            {
                id = i + 1;
                dtAparmentDistribution.Rows.Add(lengthPerFloorList[i].Floor, lengthPerFloorList[i].FloorDesc);
            }

            ugAparmentDist.DisplayLayout.Bands[0].Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
            bsAparmDistribution.DataSource = dtAparmentDistribution;
            ugAparmentDist.DisplayLayout.Bands[0].Columns["ID"].Hidden = true;

            int counter;
            int floor;
            for (int i = 0; i < ugAparmentDist.Rows.Count; i++)
            {
                counter = 0;
                floor = Convert.ToInt32(ugAparmentDist.Rows[i].Cells["ID"].Value);
                for (int j = 1; j <= Convert.ToInt32(tbApartTypeQuant.TextBoxValue); j++)
                {

                    ugAparmentDist.Rows[i].Cells["TIPO_" + j].Value = blFDMPC.GetPropUnitPerFloorAndUnitType(nuProjectId,floor, j);
                    counter++;
                }
                ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value = counter;
                
            }

            // Se establece el total de unidades prediales como sólo lectura y se setea la expresión a la columna totalizadora
            dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].ReadOnly = true;
            dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].Expression = stExpression;
        }

        private void LoadLengthPerPropUnitType(Int64 nuProjectId)
        {
            lengthPerPropUnitTypeList = blFDMPC.GetLengthPerPropUnitType(nuProjectId);
            bsLengthPerAparm.DataSource = lengthPerPropUnitTypeList;
        }

        private void LoadLengthPerFloor(Int64 nuProjectId)
        {
            lengthPerFloorList = blFDMPC.GetLengthPerFloor(nuProjectId);
            bsLengthPerFloors.DataSource = lengthPerFloorList;
        }

        /// <summary>
        /// Se valida que se hayan ingresado los datos obligatorios de la pestaña Datos Básicos del Proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 27-04-2017  KCienfuegos            2 - Se agrega la validación para el programa de vivienda
        /// 11-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private Boolean FieldsAreValid()
        {
            if (String.IsNullOrEmpty(tbProjectName.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Faltan datos requeridos, no ha ingresado el Nombre del Proyecto");
                return false;
            }
            else if (!(Convert.ToInt64(ocBuildingType.Value) > 0))
            {
                utilities.RaiseERROR("Faltan datos requeridos, no ha seleccionado el Tipo de construcción");
                return false;
            }
            else if (ocTenementProgram.Value == null)
            {
                utilities.RaiseERROR("Faltan datos requeridos, no ha seleccionado el Programa de Vivienda");
                return false;
            }
            else if (String.IsNullOrEmpty(tbTowerQuant.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Faltan datos requeridos, no ha digitado el Número de Torres/Etapas");
                return false;
            }
            else if (String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Faltan datos requeridos, no ha digitado el Número de Pisos");
                return false;
            }
            else if (String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Faltan datos requeridos, no ha digitado el Número de Tipos de Unidad ");
                return false;
            }
            else if (Convert.ToInt32(tbTowerQuant.TextBoxValue)<=0)
            {
                utilities.DisplayErrorMessage("La cantidad de Torres/Etapas no puede ser menor que cero");
                return false;
            }
            else if (Convert.ToInt32(tbFloorsQuant.TextBoxValue) <= 0)
            {
                utilities.DisplayErrorMessage("La cantidad de Pisos no puede ser menor que cero");
                return false;
            }
            else if (Convert.ToInt32(tbApartTypeQuant.TextBoxValue) <= 0)
            {
                utilities.DisplayErrorMessage("La cantidad de tipos de Apartamentos/Casas no puede ser menor que cero");
                return false;
            }
            else if (Convert.ToInt32(tbApartmentsQuant.TextBoxValue) <= 0)
            {
                utilities.DisplayErrorMessage("La cantidad de Apartamentos/Casas no puede ser menor que cero");
                return false;
            }
            else if (!string.IsNullOrEmpty(Convert.ToString(tbAddress.GeograpLocation)) && Convert.ToString(hlGeograLocation.Value)!=Convert.ToString(tbAddress.GeograpLocation))
            {
                utilities.DisplayErrorMessage("La localidad ingresada no coincide con la localidad de la dirección especificada");
                return false;
            }
            else if (!ValidApartmentDistribution())
            {
                utilities.DisplayErrorMessage("Debe digitar unidades prediales en todos los pisos especificados");
                return false;
            }
            return true;
        }

        private void btnNext_Click(object sender, EventArgs e)
        {
            //Se selecciona la pestaña Metraje
            otcProject.SelectedTab = otcProject.Tabs[1];
        }

        /// <summary>
        /// Se realiza la distribución de los apartamentos
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 12-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void DistributeAparments()
        {
            if (!loadingData)
            {
                dtAparmentDistribution = new DataTable();
                Int32 nuLength = Convert.ToInt32(tbApartTypeQuant.TextBoxValue)+2;
                String stExpression = "";
                String stFloorName = "";
                int id;
                bsAparmDistribution.DataSource = null;

                for (int i = 0; i < nuLength; i++)
                {
                    if (i == 0)
                    {
                        //Se crea columna para el ID
                        dtAparmentDistribution.Columns.Add("ID", typeof(Int64));
                        dtAparmentDistribution.Columns["ID"].ReadOnly = true;

                        //Se crea columna para el PISO
                        dtAparmentDistribution.Columns.Add("PISO", typeof(string));
                        dtAparmentDistribution.Columns["PISO"].ReadOnly = true;
                    }
                    else if (i == (nuLength - 1))
                    {
                        //Se crea columna para el TOTAL DE UNIDADES PREDIAL
                        dtAparmentDistribution.Columns.Add("TOTAL_UNIDADES_PREDIALES", typeof(Int64));
                        dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].ReadOnly = true;
                        dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].DefaultValue = 0;
                        dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].Caption = "TOTAL DE UNIDADES PREDIALES";
                    }
                    else
                    {
                        stFloorName = "TIPO_" + i;
                        //Se crea columna para el TIPO DE UNIDAD PREDIAL
                        dtAparmentDistribution.Columns.Add(stFloorName, typeof(Int64));
                        dtAparmentDistribution.Columns[stFloorName].DataType = typeof(Int64);
                        dtAparmentDistribution.Columns[stFloorName].DefaultValue = 0;
                        dtAparmentDistribution.Columns[stFloorName].AllowDBNull=false;
                        dtAparmentDistribution.Columns[stFloorName].Caption = "TIPO " + i;
                        stExpression = stExpression + "+ [" + stFloorName + "]";
                    } 
                }

                // Se asigna la expresión a la columna totalizadora
                dtAparmentDistribution.Columns["TOTAL_UNIDADES_PREDIALES"].Expression = stExpression;

                //Se crean las filas
                for (int i = 0; i < Convert.ToInt32(tbFloorsQuant.TextBoxValue); i++)
                {
                    id = i + 1;
                    dtAparmentDistribution.Rows.Add(id, "PISO " + id);
                }

                ugAparmentDist.DisplayLayout.Bands[0].Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
                bsAparmDistribution.DataSource = dtAparmentDistribution;
                ugAparmentDist.DisplayLayout.Bands[0].Columns["ID"].Hidden = true;
            }
        }

        /// <summary>
        /// Se construye la grilla para el metraje por tipo de unidad predial
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 12-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void BuildLengthPerFloor()
        {
            List<LengthPerFloor> lengthPerFloorList = new List<LengthPerFloor>();

            Int32 nuLength = Convert.ToInt32(tbFloorsQuant.TextBoxValue);
            int id;

            //Se crean las filas
            for (int i = 0; i < nuLength; i++)
            {
                LengthPerFloor tmpLengthPerFloor = new LengthPerFloor();
                id = i + 1;
                tmpLengthPerFloor.Floor = id;
                tmpLengthPerFloor.FloorDesc = "PISO " + (id);
                lengthPerFloorList.Add(tmpLengthPerFloor);
            }

            //Se indica el datasource del BindingSource
            bsLengthPerFloors.DataSource = lengthPerFloorList;
        }

        /// <summary>
        /// Se construye la grilla para el metraje por piso
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 12-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void BuildLengthPerAparmType()
        {
            List<LengthPerPropUnitType> lengthPerPropUnitTypeList = new List<LengthPerPropUnitType>();
            dtLengthPerAparmType = new DataTable();
            Int32 nuLength = Convert.ToInt32(tbApartTypeQuant.TextBoxValue);
            int id;

            //Se crean las filas
            for (int i = 0; i < nuLength; i++)
            {
                LengthPerPropUnitType tmpLengthPerPropUnitType = new LengthPerPropUnitType();
                id = i + 1;
                tmpLengthPerPropUnitType.PropUnitTypeId = id;
                tmpLengthPerPropUnitType.PropUnitType = "TIPO " + id;
                lengthPerPropUnitTypeList.Add(tmpLengthPerPropUnitType);
            }

            //Se indica el datasource del BindingSource
            bsLengthPerAparm.DataSource = lengthPerPropUnitTypeList;
        }

        private bool ValidApartmentDistribution()
        {
            Int32 value = 0;
            for (int i = 0; i < ugAparmentDist.Rows.Count; i++)
            {
                if (ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value != null)
                {
                    value = Convert.ToInt32(ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value);

                    if (value <= 0)
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        private void otcProject_ActiveTabChanging(object sender, Infragistics.Win.UltraWinTabControl.ActiveTabChangingEventArgs e)
        {
            if (e.Tab.Index == 1)
            {
                if (!FieldsAreValid())
                {
                    e.Cancel = true;
                }
                else
                {
                    otcProject.Tabs[1].Enabled = true;
                }
            }
        }

        private void btnPrevious_Click(object sender, EventArgs e)
        {
            otcProject.SelectedTab = otcProject.Tabs[0];
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }

        private void tbFloorsQuant_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue) && !loadingData)
            {
                utilities.DisplayInfoMessage("tbFloorsQuant" + sender.ToString());
                if ((Convert.ToInt64(tbFloorsQuant.TextBoxValue) < 1))
                {
                    utilities.RaiseERROR("El número de pisos no puede ser menor que 1");
                    return;
                }

                if (!loadingData)
                {
                    tbApartmentsQuant.TextBoxValue = "0";
                }

                BuildLengthPerFloor();

                if (!String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue))
                {
                    DistributeAparments();
                    tbApartmentsQuant.TextBoxValue = "";
                    tbUnitsByTower.TextBoxValue = "";
                }
            }
        }

        private void tbApartTypeQuant_TextBoxValueChanged(object sender, EventArgs e)
        {
            utilities.DisplayInfoMessage("tbApartTypeQuant " + tbFloorsQuant.TextBoxValue + sender.ToString());
            if ((Convert.ToInt64(tbFloorsQuant.TextBoxValue) < 1))
            {
                utilities.RaiseERROR("El número de tipos de vivienda no puede ser menor que 1");
                return;
            }

            if (!String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue) && !loadingData)
            {
                if (!loadingData)
                {
                    tbApartmentsQuant.TextBoxValue = "0";
                }
                
                BuildLengthPerAparmType();

                if (!String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue))
	            {
		            DistributeAparments();
                    tbApartmentsQuant.TextBoxValue = "";
                    tbUnitsByTower.TextBoxValue = "";
                }
            }
        }

        private void tbTowerQuant_TextBoxValueChanged(object sender, EventArgs e)
        {
            utilities.DisplayInfoMessage("Torres"+sender.ToString());
            if ((Convert.ToInt64(tbTowerQuant.TextBoxValue) < 1))
            {
                utilities.DisplayErrorMessage("El número de Torres/Etapas no puede ser menor que 1");
                return;
            }

            if (!String.IsNullOrEmpty(tbUnitsByTower.TextBoxValue) && !String.IsNullOrEmpty(tbTowerQuant.TextBoxValue) && !loadingData)
            {
                tbApartmentsQuant.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) * Convert.ToInt64(tbTowerQuant.TextBoxValue));
            }
        }

        private void tbApartmentsQuant_TextBoxValueChanged(object sender, EventArgs e)
        {
            if ((Convert.ToInt64(tbApartmentsQuant.TextBoxValue) < 1) && !loadingData)
            {
                utilities.DisplayErrorMessage("El número de apartamentos no puede ser menor que 1");
                return;
            }
        }

        private void ugAparmentDist_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            var value = e.Cell.Value;

            if (Convert.ToInt32(value) < 0)
            {
                utilities.DisplayErrorMessage("Por favor ingresar un valor positivo");
                e.Cell.CancelUpdate();
                e.Cell.Value = 0;
            }
            else
            {
                if (!loadingData)
                {
                    tbUnitsByTower.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) + nuValueToAdd);
                    tbApartmentsQuant.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) * Convert.ToInt64(tbTowerQuant.TextBoxValue));
                }
            }
        }

        private void ugAparmentDist_BeforeExitEditMode(object sender, Infragistics.Win.UltraWinGrid.BeforeExitEditModeEventArgs e)
        {
            if (this.ugAparmentDist.ActiveCell.Column.Index <= 1)
            {
                return;
            }

            if (e.CancellingEditOperation)
                return;

            int result;
            var value = this.ugAparmentDist.ActiveCell.Text;

            if (!int.TryParse(Convert.ToString(value), out result))
            {
                utilities.DisplayErrorMessage("Por favor ingresar sólo números");

                if (e.ForceExit)
                {
                    this.ugAparmentDist.ActiveCell.CancelUpdate();
                    return;
                }

                e.Cancel = true;
            }
        }

        private void ugLengthPerTyOfAparm_BeforeExitEditMode(object sender, Infragistics.Win.UltraWinGrid.BeforeExitEditModeEventArgs e)
        {
            if (this.ugLengthPerTyOfAparm.ActiveCell.Column.Index <= 1)
            {
                return;
            }

            if (e.CancellingEditOperation)
                return;

            Double result;
            var value = this.ugLengthPerTyOfAparm.ActiveCell.Value;

            if (!Double.TryParse(Convert.ToString(value), out result))
            {
                utilities.DisplayErrorMessage("Por favor ingresar sólo números");

                if (e.ForceExit)
                {
                    this.ugLengthPerTyOfAparm.ActiveCell.CancelUpdate();
                    return;
                }

                e.Cancel = true;
            }
            else if (Convert.ToDecimal(value) < 0)
            {
                utilities.DisplayErrorMessage("Por favor ingresar un valor positivo");
                if (e.ForceExit)
                {
                    this.ugLengthPerTyOfAparm.ActiveCell.CancelUpdate();
                    return;
                }

                e.Cancel = true;
            }
        }

        private void ugLengthPerFloors_BeforeExitEditMode(object sender, Infragistics.Win.UltraWinGrid.BeforeExitEditModeEventArgs e)
        {
            if (this.ugLengthPerFloors.ActiveCell.Column.Index <= 1)
            {
                return;
            }

            if (e.CancellingEditOperation)
                return;

            Double result;

            var value = this.ugLengthPerFloors.ActiveCell.Value;

            if (!Double.TryParse(Convert.ToString(value), out result))
            {
                utilities.DisplayErrorMessage("Por favor ingresar sólo números");

                if (e.ForceExit)
                {
                    this.ugLengthPerFloors.ActiveCell.CancelUpdate();
                    return;
                }

                e.Cancel = true;
            }
            else if (Convert.ToDecimal(value) < 0)
            {
                utilities.DisplayErrorMessage("Por favor ingresar un valor positivo");
                if (e.ForceExit)
                {
                    this.ugLengthPerFloors.ActiveCell.CancelUpdate();
                    return;
                }

                e.Cancel = true;
            }
        }

        private void tbTowerQuant_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbApartTypeQuant_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbFloorsQuant_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Int64? nuLocation = string.IsNullOrEmpty(Convert.ToString(hlGeograLocation.Value)) ? nullValue : Convert.ToInt64(Convert.ToString(hlGeograLocation.Value));
            Int64? nuAddress = string.IsNullOrEmpty(tbAddress.Address_id) ? nullValue : Convert.ToInt64(tbAddress.Address_id);

            if (ProjectDefinitionChanged())
            {
                if (blFDMPC.QuotationsExist(nuProjectId))
                {
                    if (MessageBox.Show("Debido a que ya existen cotizaciones creadas a partir de este proyecto, "+
                        "y se acaban de modificar datos de la definición del mismo, se procederá a registrar un nuevo proyecto "+ 
                        "con los datos recién ingresados. Desea continuar con la creación del nuevo proyecto?", "Mensaje Confirmación", 
                        MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                    {
                        return;
                    }
                    else
                    {
                        try
                        {
                           Int64? newProject =  RegisterProjectBasicData();
                           if (!string.IsNullOrEmpty(Convert.ToString(newProject)))
                            {
                                Int64 Project = (Int64)newProject;
                                RegisterPropUnits(Project);
                                RegisterLengthPerPropUnitType(Project);
                                RegisterLengthPerFloor(Project);
                                utilities.doCommit();
                                utilities.DisplayInfoMessage("Se creó el proyecto " + tbProjectName.TextBoxValue + " con código [" + newProject + "]");
                                this.Dispose();
                            }
                        }
                        catch (Exception ex)
                        {
                            utilities.doRollback();
                            GlobalExceptionProcessing.ShowErrorException(ex);
                        }
                    }
                }
                else
                {
                    try
                    {
                        UpdateProjectBasicData();
                        UpdateProjectDefinition();
                        blFDMPC.DeleteProjectData(nuProjectId);
                        RegisterProjectDefinition();
                        RegisterPropUnits(nuProjectId);
                        RegisterLengthPerPropUnitType(nuProjectId);
                        RegisterLengthPerFloor(nuProjectId);
                        utilities.doCommit();
                        utilities.DisplayInfoMessage("El proyecto fue actualizado exitosamente");
                        this.Dispose();
                    }
                    catch (Exception ex)
                    {
                        utilities.doRollback();
                        GlobalExceptionProcessing.ShowErrorException(ex);
                        this.Dispose();
                    }
                }
            }
            else
            {
                try
                {
                    UpdateProjectBasicData();
                    UpdateLengthPerPropUnitType(nuProjectId);
                    UpdateLengthPerFloor(nuProjectId);
                    utilities.doCommit();
                    utilities.DisplayInfoMessage("El proyecto fue actualizado exitosamente");
                    this.Dispose();
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                }
            }
        }

        private Int64? RegisterProjectBasicData()
        {
            Int64? project;
            Int64? nuLocation = string.IsNullOrEmpty(Convert.ToString(hlGeograLocation.Value)) ? nullValue : Convert.ToInt64(Convert.ToString(hlGeograLocation.Value));
            Int64? nuAddress = string.IsNullOrEmpty(tbAddress.Address_id) ? nullValue : Convert.ToInt64(tbAddress.Address_id);

            //Se registran los datos básicos del proyecto
            project = blFDCPC.RegisterProjectBasicData(tbProjectName.TextBoxValue, tbProjectComment.TextBoxValue, nuSubscriberCode,
                                                            Convert.ToInt64(ocBuildingType.Value), Convert.ToInt64(tbFloorsQuant.TextBoxValue), Convert.ToInt64(tbTowerQuant.TextBoxValue),
                                                            Convert.ToInt64(tbApartTypeQuant.TextBoxValue), nuLocation, nuAddress, null, Convert.ToInt64(ocTenementProgram.Value));

            return project;
        }

        private void RegisterPropUnits(Int64 project)
        {
            int nuIndex = 0;

            //Se registran las unidades prediales
            foreach (DataRow row in dtAparmentDistribution.Rows)
            {
                nuIndex = 0;
                for (int i = 2; i < dtAparmentDistribution.Columns.Count - 1; i++)
                {
                    nuIndex = nuIndex + 1;
                    blFDCPC.RegisterPropUnits(project, Convert.ToInt64(row["ID"]), Convert.ToInt64(tbTowerQuant.TextBoxValue), nuIndex, Convert.ToInt64(row[i]));
                }
            }
        }

        private void RegisterLengthPerPropUnitType(Int64 project)
        {
            foreach (LengthPerPropUnitType item in bsLengthPerAparm)
            {
                item.Project = project;
                blFDCPC.RegisterLengthPerPropUnitType(item);
            }
        }

        private void RegisterLengthPerFloor(Int64 project)
        {
            foreach (LengthPerFloor item in bsLengthPerFloors)
            {
                item.Project = project;
                blFDCPC.RegisterLengthPerFloor(item);
            }
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
            Int64? nullValue = null;
            bool result = false;

            if (projectBasicData.ProjectName !=tbProjectName.TextBoxValue)
            {
                projectBasicDataToUpdate.ProjectName = tbProjectName.TextBoxValue;
                result = true;
            }

            if (projectBasicData.PaymentModality != Convert.ToString(ocPaymentModality.Value))
            {
                projectBasicData.PaymentModality = Convert.ToString(ocPaymentModality.Value);
                result = true;
            }

            if (projectBasicData.TenementType != OpenConvert.ToLongNullable(ocTenementProgram.Value))
            {
                projectBasicData.TenementType = OpenConvert.ToLongNullable(ocTenementProgram.Value);
                result = true;
            }

            if (projectBasicData.Comment != tbProjectComment.TextBoxValue)
            {
                projectBasicDataToUpdate.Comment = tbProjectComment.TextBoxValue;
                result = true;
            }

            if (projectBasicData.LocationId != (Convert.ToString(hlGeograLocation.Value) == "" ? nullValue : Convert.ToInt64(hlGeograLocation.Value)))
            {
                projectBasicDataToUpdate.LocationId = (Convert.ToString(hlGeograLocation.Value) == "" ? nullValue : Convert.ToInt64(hlGeograLocation.Value));
                result = true;
            }
           
            if (projectBasicData.AddressId != (tbAddress.Address_id == "" ? nullValue : Convert.ToInt64(tbAddress.Address_id)))
            {
                projectBasicDataToUpdate.AddressId = (tbAddress.Address_id == "" ? nullValue : Convert.ToInt64(tbAddress.Address_id));
                result = true;
            }

            return result;
        }

        /// <summary>
        /// Método para validar si cambió la definición del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool ProjectDefinitionChanged()
        {
            if (projectBasicData.Floors!=Convert.ToInt64(tbFloorsQuant.TextBoxValue))
            {
                return true;
            }

            if (projectBasicData.UnitsPropTypes != Convert.ToInt64(tbApartTypeQuant.TextBoxValue))
            {
                return true;
            }

            if (projectBasicData.Towers != Convert.ToInt64(tbTowerQuant.TextBoxValue))
            {
                return true;
            }

            if (projectBasicData.UnitsPropTotal != (Convert.ToInt64(tbApartmentsQuant.TextBoxValue)))
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Método para validar si cambió la definición del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 23-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SetProjectDefinitionChanges()
        {
            if (projectBasicData.Floors != Convert.ToInt64(tbFloorsQuant.TextBoxValue))
            {
                projectBasicDataToUpdate.Floors = Convert.ToInt64(tbFloorsQuant.TextBoxValue);
            }

            if (projectBasicData.UnitsPropTypes != Convert.ToInt64(tbApartTypeQuant.TextBoxValue))
            {
                projectBasicDataToUpdate.UnitsPropTypes = Convert.ToInt64(tbApartTypeQuant.TextBoxValue);
            }

            if (projectBasicData.Towers != Convert.ToInt64(tbTowerQuant.TextBoxValue))
            {
                projectBasicDataToUpdate.Towers = Convert.ToInt64(tbTowerQuant.TextBoxValue);
            }

            if (projectBasicData.UnitsPropTotal != (Convert.ToInt64(tbApartmentsQuant.TextBoxValue)))
            {
                projectBasicDataToUpdate.UnitsPropTotal = Convert.ToInt64(tbApartmentsQuant.TextBoxValue);
            }
        }

        private void UpdateProjectBasicData()
        {
            if (ProjectBasicDataChanged())
            {
                blFDMPC.UpdateProjectBasicData(projectBasicDataToUpdate, Convert.ToInt64(ocTenementProgram.Value));
            }
        }

        private void UpdateProjectDefinition()
        {
            if (ProjectDefinitionChanged())
            {
                SetProjectDefinitionChanges();
                blFDMPC.UpdateProjectDefinition(projectBasicDataToUpdate);
            }   
        }

        private void RegisterProjectDefinition()
        {
            blFDMPC.RegisterProjectDefinition(projectBasicDataToUpdate);
        }

        private void UpdateLengthPerPropUnitType(Int64 project)
        {
            foreach (LengthPerPropUnitType item in bsLengthPerAparm)
            {
                if (item.Operation =="U")
                {
                    blFDMPC.ModifyLengthPerPropUnitType(item);
                }
            }
        }

        private void UpdateLengthPerFloor(Int64 project)
        {
            foreach (LengthPerFloor item in bsLengthPerFloors)
            {
                if (item.Operation == "U")
                {
                    blFDMPC.ModifyLengthPerFloor(item);
                }
            }
        }

        private void tbAddress_ValueChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(tbAddress.GeograpLocation)))
            {
                if (hlGeograLocation.Value != null)
                {
                    if (hlGeograLocation.Value != tbAddress.GeograpLocation)
                    {
                        hlGeograLocation.Value = tbAddress.GeograpLocation;
                    }
                }
            }
        }

        private void ugAparmentDist_AfterRowActivate(object sender, EventArgs e)
        {
            btnCloneData.Enabled = true;
        }

        private void btnCloneData_Click(object sender, EventArgs e)
        {
            int a = this.ugAparmentDist.DisplayLayout.Bands[0].Columns.Count - 1;

            tbApartmentsQuant.TextBoxValue = "0";
            tbUnitsByTower.TextBoxValue = "0";

            for (int i = 0; i < this.ugAparmentDist.Rows.Count; i++)
            {
                if (this.ugAparmentDist.Rows[i].Cells["ID"] != this.ugAparmentDist.ActiveRow.Cells["ID"])
                {
                    for (int o = 2; o < a; o++)
                    {
                        dtAparmentDistribution.Rows[i][o] = this.ugAparmentDist.ActiveRow.Cells[o].Value;
                    }
                    this.ugAparmentDist.UpdateData();
                }
                tbUnitsByTower.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) + Convert.ToInt64(this.ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value));	
            }

            tbApartmentsQuant.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) * Convert.ToInt64(tbTowerQuant.TextBoxValue));
        }

        private void ugAparmentDist_BeforeCellUpdate(object sender, Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventArgs e)
        {
            if (!loadingData)
            {
                nuValueToAdd = Convert.ToInt64(e.NewValue) - Convert.ToInt64(e.Cell.Value); 
            }
        }

        private void ugLengthPerTyOfAparm_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            LengthPerPropUnitType tmpLengthPerPropUnitType = (LengthPerPropUnitType)bsLengthPerAparm.Current;

            if (tmpLengthPerPropUnitType.Operation =="N")
            {
                tmpLengthPerPropUnitType.Operation = "U";
            }
        }

        private void ugLengthPerFloors_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            LengthPerFloor tmpLengthPerFloor = (LengthPerFloor)bsLengthPerFloors.Current;

            if (tmpLengthPerFloor.Operation =="N")
            {
                tmpLengthPerFloor.Operation = "U";
            }
        }

        private void tbFloorsQuant_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue))
            {
                if ((Convert.ToInt64(tbFloorsQuant.TextBoxValue) < 1))
                {
                    utilities.RaiseERROR("El número de pisos no puede ser menor que 1");
                    return;
                }

                if (Convert.ToInt64(tbFloorsQuant.TextBoxValue)!=floor)
                {
                    floor = Convert.ToInt64(tbFloorsQuant.TextBoxValue);
                    BuildLengthPerFloor();

                    if (!String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue))
                    {
                        DistributeAparments();
                        tbApartmentsQuant.TextBoxValue = "";
                        tbUnitsByTower.TextBoxValue = "";
                    }
                }
            }
        }

        private void tbApartTypeQuant_Leave(object sender, EventArgs e)
        {
            if ((Convert.ToInt64(tbApartTypeQuant.TextBoxValue) < 1))
            {
                utilities.RaiseERROR("El número de tipos de vivienda no puede ser menor que 1");
                return;
            }

            if (!String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue))
            {
                if (Convert.ToInt64(tbApartTypeQuant.TextBoxValue)!=unitTypes)
                {
                    unitTypes = Convert.ToInt64(tbApartTypeQuant.TextBoxValue);
                    BuildLengthPerAparmType();

                    if (!String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue))
                    {
                        DistributeAparments();
                        tbApartmentsQuant.TextBoxValue = "";
                        tbUnitsByTower.TextBoxValue = "";
                    }
                }
            }
        }

        private void tbTowerQuant_Leave(object sender, EventArgs e)
        {
            if ((Convert.ToInt64(tbTowerQuant.TextBoxValue) < 1))
            {
                utilities.DisplayErrorMessage("El número de Torres/Etapas no puede ser menor que 1");
                return;
            }

            if (!String.IsNullOrEmpty(tbUnitsByTower.TextBoxValue) && !String.IsNullOrEmpty(tbTowerQuant.TextBoxValue))
            {
                tbApartmentsQuant.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) * Convert.ToInt64(tbTowerQuant.TextBoxValue));
            }
        }

    }
}
