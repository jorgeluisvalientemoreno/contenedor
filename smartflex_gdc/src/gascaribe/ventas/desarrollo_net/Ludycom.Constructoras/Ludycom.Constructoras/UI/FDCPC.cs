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
    public partial class FDCPC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();

        public static String CUSTOMER_LEVEL = "LDCCLC";
        public static String PROJECT_LEVEL = "PROJECT";

        CustomerBasicData customerBasicData;
        DataTable dtAparmentDistribution;
        DataTable dtLengthPerAparmType;
        Int64 nuBuilding;
        Int64 nuGroupOfHouses;
        Int64? nuProjectId;
        Int64 nuSubscriberCode;
        Int64? nullValue = null;
        Int64 nuValueToAdd = 0;

        private bool clonning = false;

        public FDCPC(Int64 nuCode)
        {
            InitializeComponent();

            //Se inicializan los datos necesarios
            InitializeData();
            InitializeDataForProjectRegister(nuCode);

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
        public void InitializeData()
        {
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


            //Lista pesada de Localidades
            hlGeograLocation.Select_Statement = string.Join(string.Empty, new string[]{
                " select   ge_geogra_location.geograp_location_id ID, ",
                "   ge_geogra_location.display_description Description  ",
                " from ge_geogra_location ",
                "@WHERE @",
                "@ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc @",
                "@geograp_location_id like :id @ ",
                "@upper(display_description) like :description @ "});
        }

        /// <summary>
        /// Se inicializan los datos para registro del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeDataForProjectRegister(Int64 subscriberCode)
        {
            nuSubscriberCode = subscriberCode;
            customerBasicData = new CustomerBasicData();

            //Inicializa la fecha de registro
            tbProjectRegisterDate.TextBoxObjectValue = OpenDate.getSysDateOfDataBase();

            //Se cargan los datos básicos del cliente
            LoadCustomerData(nuSubscriberCode);
        }

        /// <summary>
        /// Se cargan los datos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 19-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadCustomerData(Int64 nuSubscriberCode)
        {
            //Se obtienen los datos básicos del cliente
            customerBasicData = blFDCPC.GetCustomerBasicData(nuSubscriberCode);

            //Se setean los datos básicos del cliente en la pantalla
            ocIdentificationType.Value = customerBasicData.IdentificationType;
            tbCustomerId.TextBoxValue = customerBasicData.Identification;
            tbCustomerName.TextBoxValue = customerBasicData.CustomerName;
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
            else if (String.IsNullOrEmpty(tbApartmentsQuant.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Faltan datos requeridos, no ha definido la cantidad de unidades prediales por piso/tipo");
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
                utilities.DisplayErrorMessage("La cantidad de unidades prediales no puede ser menor que cero");
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

        private bool ValidApartmentDistribution()
        {
            Int32 value = 0;
            for (int i = 0; i < ugAparmentDist.Rows.Count; i++)
            {
                if (ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value!=null)
	            {
                    value = Convert.ToInt32(ugAparmentDist.Rows[i].Cells["TOTAL_UNIDADES_PREDIALES"].Value);

                    if (value<=0)
                    {
                        return false;
                    }
	            }
            }

            return true;
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
            if (!String.IsNullOrEmpty(tbFloorsQuant.TextBoxValue))
            {
                if ((Convert.ToInt64(tbFloorsQuant.TextBoxValue) < 1))
                {
                    utilities.RaiseERROR("El número de pisos no puede ser menor que 1");
                    return;
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
            if ((Convert.ToInt64(tbFloorsQuant.TextBoxValue) < 1))
            {
                utilities.RaiseERROR("El número de tipos de vivienda no puede ser menor que 1");
                return;
            }

            if (!String.IsNullOrEmpty(tbApartTypeQuant.TextBoxValue))
            {
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

        private void tbApartmentsQuant_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbApartmentsQuant.TextBoxValue))
            {
                if ((Convert.ToInt64(tbApartmentsQuant.TextBoxValue) < 1) && !clonning)
                {
                    utilities.DisplayErrorMessage("El número de apartamentos no puede ser menor que 1");
                    return;
                }
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
                tbUnitsByTower.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) + nuValueToAdd);
                tbApartmentsQuant.TextBoxValue = Convert.ToString(Convert.ToInt64(tbUnitsByTower.TextBoxValue) * Convert.ToInt64(tbTowerQuant.TextBoxValue));
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

        private void ocBuildingType_ValueChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(ocBuildingType.Value)))
            {
                dtAparmentDistribution = new DataTable();
                bsAparmDistribution.DataSource = null;
                bsAparmDistribution.DataSource = dtAparmentDistribution;

                if (Convert.ToInt64(ocBuildingType.Value) == nuGroupOfHouses)
                {
                    tbApartmentsQuant.Caption = "N° Total de Casas";
                    tbUnitsByTower.Caption = "N° de Casas por Etapa";
                    tbTowerQuant.Caption = "N° Etapas";
                    tbApartmentsQuant.TextBoxValue = "";
                    tbUnitsByTower.TextBoxValue = "";
                    tbTowerQuant.TextBoxValue = "1";
                    tbApartTypeQuant.Caption = "N° Tipos de Viviendas";
                    tbApartTypeQuant.TextBoxValue = "";
                    tbFloorsQuant.TextBoxValue = "1";
                    tbFloorsQuant.ReadOnly = true;
                }
                else
                {
                    tbApartmentsQuant.Caption = "N° Total de Aptos";
                    tbUnitsByTower.Caption = "N° de Aptos por Torre";
                    tbTowerQuant.Caption = "N° de Torres";
                    tbApartmentsQuant.TextBoxValue = "";
                    tbUnitsByTower.TextBoxValue = "";
                    tbTowerQuant.TextBoxValue = "1";
                    tbApartTypeQuant.TextBoxValue = "";
                    tbApartTypeQuant.Caption = "N° Tipos de Aptos";
                    tbFloorsQuant.ReadOnly = false;
                }
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

        private void tbFloorsQuant_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbApartTypeQuant_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        } 

        private void RegisterProjectBasicData()
        {
            Int64? nuLocation = string.IsNullOrEmpty(Convert.ToString(hlGeograLocation.Value)) ? nullValue : Convert.ToInt64(Convert.ToString(hlGeograLocation.Value));
            Int64? nuAddress = string.IsNullOrEmpty(tbAddress.Address_id) ? nullValue : Convert.ToInt64(tbAddress.Address_id);
            
            //Se registran los datos básicos del proyecto
            nuProjectId = blFDCPC.RegisterProjectBasicData(tbProjectName.TextBoxValue, tbProjectComment.TextBoxValue, nuSubscriberCode,
                                                            Convert.ToInt64(ocBuildingType.Value), Convert.ToInt64(tbFloorsQuant.TextBoxValue), Convert.ToInt64(tbTowerQuant.TextBoxValue),
                                                            Convert.ToInt64(tbApartTypeQuant.TextBoxValue), nuLocation, nuAddress, null, Convert.ToInt64(ocTenementProgram.Value));
        }

        private void RegisterPropUnits()
        {
            Int64 nuProject = (Int64)nuProjectId;
            int nuIndex = 0;

            //Se registran las unidades prediales
            foreach (DataRow row in dtAparmentDistribution.Rows)
            {
                nuIndex = 0;
                for (int i = 2; i < dtAparmentDistribution.Columns.Count - 1; i++)
                {
                    nuIndex = nuIndex + 1;
                    blFDCPC.RegisterPropUnits(nuProject, Convert.ToInt64(row["ID"]), Convert.ToInt64(tbTowerQuant.TextBoxValue), nuIndex, Convert.ToInt64(row[i]));
                }
            }
        }

        private void RegisterLengthPerPropUnitType()
        {
            Int64 nuProject = (Int64)nuProjectId;

            foreach (LengthPerPropUnitType item in bsLengthPerAparm)
            {
                item.Project = nuProject;
                blFDCPC.RegisterLengthPerPropUnitType(item);
            }
        }

        private void RegisterLengthPerFloor()
        {
            Int64 nuProject = (Int64)nuProjectId;

            foreach (LengthPerFloor item in bsLengthPerFloors)
            {
                item.Project = nuProject;
                blFDCPC.RegisterLengthPerFloor(item);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                RegisterProjectBasicData();
                if (!string.IsNullOrEmpty(Convert.ToString(nuProjectId)))
                {
                    RegisterPropUnits();
                    RegisterLengthPerPropUnitType();
                    RegisterLengthPerFloor();
                    utilities.doCommit();
                    utilities.DisplayInfoMessage("Se creó el proyecto " + tbProjectName.TextBoxValue + " con código [" + nuProjectId + "]");
                    this.Dispose();
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
        }

        private void tbAddress_ValueChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(tbAddress.GeograpLocation)))
            {
                hlGeograLocation.Value = tbAddress.GeograpLocation;
            }
        }

        private void ugAparmentDist_AfterRowActivate(object sender, EventArgs e)
        {
            btnCloneData.Enabled = true;
        }

        private void btnCloneData_Click(object sender, EventArgs e)
        {
            int a = this.ugAparmentDist.DisplayLayout.Bands[0].Columns.Count - 1;
            clonning = true;

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

            clonning = false;
        }

        private void ugAparmentDist_BeforeCellUpdate(object sender, Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventArgs e)
        {
            nuValueToAdd = Convert.ToInt64(e.NewValue) - Convert.ToInt64(e.Cell.Value);
        }

    }
}
