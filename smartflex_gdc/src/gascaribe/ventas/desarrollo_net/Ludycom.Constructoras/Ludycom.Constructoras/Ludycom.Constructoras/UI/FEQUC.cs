using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class FEQUC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFEQUC blFEQUC = new BLFEQUC();
        BLFDRCC blFDRCC = new BLFDRCC();
        BLFDMPC blFDMPC = new BLFDMPC();

        public static String PROJECT_LEVEL = "LDCPRC";

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;
        private RequestBasicData requestBasicData;

        private Int64 nuProjectId;
        private Int64 nuSubscriberCode;

        OpenGridDropDown ocPropUnits = new OpenGridDropDown();

        List<PropUnit> propUnitList = new List<PropUnit>();
        List<PropUnitEquivalence> propUnitEquivalencesList = new List<PropUnitEquivalence>();

        public FEQUC(Int64 project)
        {
            InitializeComponent();
            InitializeData(project);
        }

        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData(Int64 project)
        {
            nuProjectId = project;

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Se obtienen las unidades prediales del proyecto
            LoadPropUnitList();

            ocPropUnits.ValueMember = "ID";
            ocPropUnits.DisplayMember = "DESCRIPTION";
            ocPropUnits.DropDownWidth = 300;
            ocPropUnits.DisplayLayout.Bands[0].Columns[0].Width = 70;
            ocPropUnits.DisplayLayout.Bands[0].Columns[1].Width = 210;
            this.ugPropUnits.DisplayLayout.Bands[0].Columns["PropUnitId"].ValueList = ocPropUnits;
            this.ocPropUnits.RowSelected += new RowSelectedEventHandler(ocPropUnit_RowSelected);

            //Se cargan los datos a mostrar en pantalla
            LoadProjectAndCustomerBasicData(nuProjectId);
            LoadRequestBasicData(nuProjectId);
            LoadAddressData(); 
            
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
        /// 02-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectAndCustomerBasicData(Int64 projectId)
        {
            //Se inicializan datos básicos del proyecto
            LoadProjectBasicData(projectId);

            //Se obtiene el código del cliente
            nuSubscriberCode = blFDMPC.GetProjectCustomer(projectId);

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
        /// 02-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectBasicData(Int64 projectId)
        {
            //Se obtiene Datos Básicos del Proyecto
            projectBasicData = blFDMPC.GetProjectBasicData(projectId);

            //Se setean los datos básicos del proyecto en la patalla
            tbAddress.Address_id = Convert.ToString(projectBasicData.AddressId);
            tbAddress.ReadOnly = true;
        }

        /// <summary>
        /// Se cargan los datos básicos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-06-2016  KCienfuegos            1 - creación                   
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
        /// Se cargan los datos básicos de la solicitud de venta
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadRequestBasicData(Int64 projectId)
        {
            //Se obtiene Datos Básicos de la solicitud de venta
            requestBasicData = blFEQUC.GetRequestBasicData(projectId);

            //Se setean los datos básicos de la solicitud
            tbRequestId.TextBoxValue = Convert.ToString(requestBasicData.RequestId);
            tbRequestRegisterDate.TextBoxObjectValue = requestBasicData.RegisterDate;
        }

        /// <summary>
        /// Se cargan los datos de las unidades prediales
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 03-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadAddressData()
        {
            propUnitEquivalencesList = blFEQUC.GetAddresses(requestBasicData.RequestId); //2990286   PRUEBA
            bsPropUnitEquivalence.DataSource = propUnitEquivalencesList;
        }

        /// <summary>
        /// Se carga la lista de unidades prediales
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 04-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadPropUnitList()
        {
            //Se obtienen las unidades prediales del proyecto
            propUnitList = blFEQUC.GetPropUnits(nuProjectId);

            //Se construye la lista de valores
            ocPropUnits.DataSource = propUnitList;
        }
        #endregion

        void ocPropUnit_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown udLista = ((UltraDropDown)sender);
                if (udLista.SelectedRow != null)
                {
                    int Index = bsPropUnitEquivalence.Position;
                    PropUnitEquivalence currentPropUnitEquivalence = (PropUnitEquivalence)bsPropUnitEquivalence[Index];
                    PropUnitEquivalence tmpPropUnitEquivalence = propUnitEquivalencesList.Find(delegate(PropUnitEquivalence i)
                    { return i.PropUnitId == Convert.ToInt64(udLista.SelectedRow.Cells[0].Value); });

                    if (tmpPropUnitEquivalence != null)
                    {
                        if (tmpPropUnitEquivalence.Address != currentPropUnitEquivalence.Address)
                        {
                            utilities.DisplayInfoMessage("La unidad seleccionada ya está indicada para otra dirección");
                            ugPropUnits.ActiveRow.Cells["PropUnitId"].Value = 0;
                        }
                    }
                }
            }
        }

        private void chkAll_CheckedChanged(object sender, EventArgs e)
        {
            List<PropUnitEquivalence> src = (List<PropUnitEquivalence>)(ugPropUnits.DataSource as BindingSource).List;

            foreach (PropUnitEquivalence row in src)
            {
                row.Selected = chkAll.Checked;
            }
            ugPropUnits.Refresh();
        }

        /// <summary>
        /// Se procesan los registros seleccionados en pantalla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 03-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void Process()
        {
            bool processedOk = false;
            int rowsAmount = 0;

            foreach (PropUnitEquivalence item in bsPropUnitEquivalence)
            {
                if (item.Selected & item.PropUnitId!=0)
                {
                    try
                    {
                        rowsAmount = 1;
                        blFEQUC.SetPropUnitEquivalence(requestBasicData.RequestId, item);
                        utilities.doCommit();
                        processedOk = true;
                    }
                    catch (Exception ex)
                    {
                        processedOk = false;
                        utilities.doRollback();
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                }
            }

            if (processedOk)
            {
                utilities.DisplayInfoMessage("Proceso ejecutado exitosamente!");
                Clean();
                LoadAddressData();
                LoadPropUnitList();
            }
            else if (bsPropUnitEquivalence.Count<=0)
            {
                utilities.DisplayInfoMessage("No hay registros que procesar!");
            }
            else if (!processedOk & rowsAmount == 0)
            {
                utilities.DisplayErrorMessage("No se seleccionaron registros válidos para procesar");
            }
        }

        /// <summary>
        /// Se limpia la grilla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 03-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void Clean()
        {
            bsPropUnitEquivalence.Clear();
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            Process();
        }
    }
}
