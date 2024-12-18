using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class FCUAD : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFDMPC blFDMPC = new BLFDMPC();
        BLFCUAD blFCUAD = new BLFCUAD();

        public static String PROJECT_LEVEL = "LDCPRC";

        private Int64 nuProjectId;
        private Int64 nuSubscriberCode;
        private Int64 feeId;
        private Int64 cupon;

        private Double cuponValue;

        private String feeType;

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;

        private List<WorkProgressFee> workProgressFeeList = new List<WorkProgressFee>();

        public FCUAD(Int64 project)
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
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData(Int64 project)
        {
            nuProjectId = project;

            feeType = "E";

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Se cargan los datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

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
        /// 09-06-2016  KCienfuegos            1 - creación                   
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
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectBasicData(Int64 projectId)
        {
            //Se obtiene Datos Básicos del Proyecto
            projectBasicData = blFDMPC.GetProjectBasicData(projectId);

            //Se setean los datos del proyecto
            tbProjectName.TextBoxValue = projectBasicData.ProjectName;
        }

        /// <summary>
        /// Se cargan los datos básicos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-06-2016  KCienfuegos            1 - creación                   
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
        /// Se cargan los datos del consolidado de la cotización para armar el detalle del acta
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void LoadConsolidatedQuotation()
        {
            try
            {
                workProgressFeeList = blFCUAD.GetActDetail(nuProjectId);
                bsWorkProgressFee.DataSource = workProgressFeeList;
            }
            catch (Exception ex)
            {
               utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
        }
        #endregion

        private void tbCuponValue_Validating(object sender, CancelEventArgs e)
        {
            if (!String.IsNullOrEmpty(tbCuponValue.TextBoxValue))
            {
                cuponValue = Convert.ToDouble(tbCuponValue.TextBoxValue);
                DefineCuponGeneration();
            }
            else
            {
                utilities.DisplayErrorMessage("Debe digitar un valor para el cupón");
            }
        }

        /// <summary>
        /// Método para validar el tipo de cuota seleccionada, y de acuerdo a esto define las acciones a ejecutar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void ValidateFeeTypeSelected()
        {
            if (rbExtraordinaryFee.Checked)
            {
                feeType = "E";
                tbCuponValue.Enabled = true;
                tbCuponValue.TextBoxValue = "0";
                DefineCuponGeneration();
                workProgressFeeList.Clear();
                bsWorkProgressFee.DataSource = workProgressFeeList;
                bsWorkProgressFee.ResetBindings(true);
                feeId = 0;
                cupon = 0;
                this.btnPrintAct.Enabled = false;
            }
            else
            {
                feeType = "A";
                tbCuponValue.Enabled = false;
                tbCuponValue.TextBoxValue = "0";
                feeId = 0;
                cupon = 0;
                DefineCuponGeneration();
                LoadConsolidatedQuotation();
            }
        }

        private void rbExtraordinaryFee_CheckedChanged(object sender, EventArgs e)
        {
            ValidateFeeTypeSelected();
        }

        private void rbConstructionProgress_CheckedChanged(object sender, EventArgs e)
        {
            ValidateFeeTypeSelected();
        }

        /// <summary>
        /// Se calcula el precio total de los trabajos, de acuerdo a las cantidades ingresadas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void CalcTotalPrice()
        {
            cuponValue = 0;

            foreach (WorkProgressFee item in bsWorkProgressFee)
            {
                cuponValue = cuponValue + item.TotalPrice;
            }
           
            tbCuponValue.TextBoxValue = Convert.ToString(cuponValue);
        }

        /// <summary>
        /// Se valida si se debe permitir generar cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void DefineCuponGeneration()
        {
            if (cuponValue > 0)
            {
                this.btnGenerateCupon.Enabled = true;
            }
            else
            {
                this.btnGenerateCupon.Enabled = false;
                this.btnPrintCupon.Enabled = false;
                this.btnPrintAct.Enabled = false;
            }
        }

        /// <summary>
        /// Método para registrar el detalle del acta
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 10-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void RegisterActDetail()
        {
            foreach (WorkProgressFee item in bsWorkProgressFee)
            {
                blFCUAD.RegisterActDetail(nuProjectId, feeId, item);
            }
        }

        private void ugMonthlyFee_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            CalcTotalPrice();
            DefineCuponGeneration();
        }

        private void tbCuponValue_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbCuponValue.TextBoxValue))
            {
                cuponValue = Convert.ToDouble(tbCuponValue.TextBoxValue);
            }
        }

        private void btnGenerateCupon_Click(object sender, EventArgs e)
        {
            if (cuponValue>0)
            {
                try
                {
                    IDictionary<String, Int64?> result = blFCUAD.GenerateCupon(nuProjectId, cuponValue, feeType);

                    if (result["CUPON"] != null && result["CUOTA"] != null)
	                {
                        feeId = Convert.ToInt64(result["CUOTA"]);
                        cupon = Convert.ToInt64(result["CUPON"]);

                        if (feeType == "A")
                        {
                            RegisterActDetail();
                            this.btnPrintAct.Enabled = true;
                        }

                        utilities.doCommit();
                        utilities.DisplayInfoMessage("Se generó el cupón exitosamente ");
                        this.btnGenerateCupon.Enabled = false;
                        this.btnPrintCupon.Enabled = true;
	                }
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                }
            }
        }

        private void btnPrintCupon_Click(object sender, EventArgs e)
        {
            if (cupon!=0)
            {
                try
                {
                    Cursor.Current = Cursors.WaitCursor;
                    blFCUAD.PrintCupon(cupon);
                    Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                    OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("PRINTPREV", parametersTemp, true);
                    Cursor.Current = Cursors.Default;
                }
                catch (Exception ex)
                {
                    GlobalExceptionProcessing.ShowErrorException(ex);
                }
            }
            else
            {
                utilities.DisplayErrorMessage("No está definida el cupón que se va a imprimir");
            }
        }

        private void btnPrintAct_Click(object sender, EventArgs e)
        {
            if (feeId != 0)
            {
                using (FIAC frm = new FIAC(nuProjectId, feeId))
                {
                    frm.ShowDialog();
                }
            }
            else
            {
                utilities.DisplayErrorMessage("No está definida el acta que se va a imprimir");
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }
    }
}
