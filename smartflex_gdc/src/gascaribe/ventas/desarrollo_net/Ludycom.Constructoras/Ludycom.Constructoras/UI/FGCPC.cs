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
    public partial class FGCPC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFGCPC blFGCPC = new BLFGCPC();
        BLFDMPC blFDMPC = new BLFDMPC();

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;
        private MonthlyFee currentMonthlyFee;

        private Int64 nuProjectId;
        private Int64 nuSubscriberCode;

        private Double projectDebt;

        private bool pendingChanges = false;

        private List<MonthlyFee> monthlyFeeList = new List<MonthlyFee>();
        private List<MonthlyFee> monthlyFeeToDeleteList = new List<MonthlyFee>();
        private List<ListOfValues> feeStatusList = new List<ListOfValues>();

        OpenGridDropDown ocFeeStatus = new OpenGridDropDown();

        public FGCPC(Int64 project)
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
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData(Int64 project)
        {
            nuProjectId = project;

            bsMonthlyFee.DataSource = monthlyFeeList;

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Se carga lista de estados de las cuotas
            feeStatusList.Clear();
            feeStatusList.Add(new ListOfValues("R", "Registrada"));
            feeStatusList.Add(new ListOfValues("F", "Facturada"));
            feeStatusList.Add(new ListOfValues("P", "Pagada"));
            ocFeeStatus.DataSource = feeStatusList;
            ocFeeStatus.ValueMember = "Id";
            ocFeeStatus.DisplayMember = "Description";
            this.ugMonthlyFee.DisplayLayout.Bands[0].Columns["Status"].ValueList = ocFeeStatus;

            //Se cargan los datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

            //Se cargan las cuotas mensuales
            LoadMonthlyFee(nuProjectId);

            //Se obtiene la deuda del proyecto PENDIENTE
            LoadProjectDebt(nuProjectId);
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
        /// 07-06-2016  KCienfuegos            1 - creación                   
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
        /// 07-06-2016  KCienfuegos            1 - creación                   
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
        /// 07-06-2016  KCienfuegos            1 - creación                   
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
        /// Se cargan las cuotas mensuales
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadMonthlyFee(Int64 project)
        {
            //Se obtiene la lista de cuotas mensuales
            monthlyFeeList = blFGCPC.GetMonthlyFees(project);

            if (monthlyFeeList.Count>0)
            {
                bsMonthlyFee.DataSource = monthlyFeeList;
            }       
        }

        /// <summary>
        /// Se carga la deuda del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void LoadProjectDebt(Int64 project)
        {
            projectDebt = blFGCPC.GetProjectDebt(project);
            tbProjectDebt.TextBoxValue = Convert.ToString(projectDebt);
        }
        #endregion

        #region SaveOperations
        /// <summary>
        /// Método para guardar los cambios realizados en las cuotas (Creación/Modificación)
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveMonthlyFees()
        {
            foreach (MonthlyFee item in bsMonthlyFee)
            {
                if (item.Operation == "R")
                {
                    blFGCPC.RegisterMonthlyFee(nuProjectId, item);
                }
                if (item.Operation == "U")
                {
                    blFGCPC.ModifyMonthlyFee(nuProjectId, item);
                }
            }
        }
        #endregion

        #region DeleteOperations
        /// <summary>
        /// Método para eliminar las cuotas de la base de datos
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void DeleteMonthlyFees()
        {
            for (int i = 0; i < monthlyFeeToDeleteList.Count; i++)
            {
                blFGCPC.ModifyMonthlyFee(nuProjectId, monthlyFeeToDeleteList[i]);
            }
        }
        #endregion

        /// <summary>
        /// Método para validar si existen o no cambios pendientes por guardar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void ValidateChanges()
        {
            List<MonthlyFee> tmpMonthlyFeeList = (List<MonthlyFee>)bsMonthlyFee.List;

            bool blUpdatedFees = tmpMonthlyFeeList.Exists(delegate(MonthlyFee mf) { return mf.Operation == "U"; });
            bool blNewFees = tmpMonthlyFeeList.Exists(delegate(MonthlyFee mf) { return mf.Operation == "R"; });

            if (blUpdatedFees || blNewFees || monthlyFeeToDeleteList.Count > 0)
            {
                pendingChanges = true;
                EnableChangesSaving();
            }
            else
            {
                pendingChanges = false;
                DisableChangesSaving();
            }
        }

        /// <summary>
        /// Método para validar el total de la deuda del proyecto con el total de las cuotas ingresadas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void ValidateTotalFeeValue()
        {
            Double totalFeeValue = 0;
            foreach (MonthlyFee item in bsMonthlyFee)
            {
                totalFeeValue = totalFeeValue + item.FeeValue;
            }

            if (totalFeeValue > projectDebt)
            {
                utilities.DisplayInfoMessage("Se le informa que existe una inconsistencia en los datos ingresados, " + 
                                             "ya que el total de las cuotas sobrepasa el total de la deuda del proyecto");
            }
        }

        /// <summary>
        /// Método para habilitar el botón Guardar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void EnableChangesSaving()
        {
            if (!this.btnSave.Enabled)
            {
                this.btnSave.Enabled = true;
            }
        }

        /// <summary>
        /// Método para deshabilitar el botón Guardar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void DisableChangesSaving()
        {
            if (this.btnSave.Enabled)
            {
                this.btnSave.Enabled = false;
            }
        }

        private void bnMonthlyFeeAddNewItem_Click(object sender, EventArgs e)
        {
            if (validMonthlyFeeRow())
            {
                //Si la fila activa es válida, se crea nuevo registro
                MonthlyFee tmpMontlyFee = (MonthlyFee)bsMonthlyFee.AddNew();
                ValidateChanges();
            }
        }

        private void bnMonthlyFeeDeleteItem_Click(object sender, EventArgs e)
        {
            MonthlyFee tmpMonthlyFee = (MonthlyFee)bsMonthlyFee.Current;
            if (tmpMonthlyFee.Operation == "R" || tmpMonthlyFee.Status == "R")
            {
                if (tmpMonthlyFee.Operation != "R" )
                {
                    tmpMonthlyFee.Operation = "D";
                    monthlyFeeToDeleteList.Add(tmpMonthlyFee);
                }

                bsMonthlyFee.RemoveCurrent();
                ValidateChanges();
            }
            else
            {
                utilities.DisplayErrorMessage("Sólo es posible eliminar cuotas en estado Registrada");
            }
        }

        private void ugMonthlyFee_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            MonthlyFee tmpMonthlyFee = (MonthlyFee)bsMonthlyFee.Current;

            if (tmpMonthlyFee.Status!="R" && tmpMonthlyFee.Operation!="R")
            {
                utilities.DisplayErrorMessage("No se está permitido modificar una cuota que ya no se encuentra Registrada");
                e.Cancel = true;
            }
        }

        private void ugMonthlyFee_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key =="FeeValue" || e.Cell.Column.Key =="AlarmDate" || e.Cell.Column.Key =="BillingDate")
            {
                MonthlyFee tmpMonthlyFee = (MonthlyFee)bsMonthlyFee.Current;

                if (tmpMonthlyFee.Operation=="N")
                {
                    tmpMonthlyFee.Operation = "U";
                }
                ValidateChanges();
            }
        }

        private void ugMonthlyFee_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validMonthlyFeeRow())
            {
                e.Cancel = true;
            }
        }

        private void ugMonthlyFee_AfterRowActivate(object sender, EventArgs e)
        {
            currentMonthlyFee = (MonthlyFee)bsMonthlyFee.Current;

            if (currentMonthlyFee.Status == "R")
            {
                this.btnGenerateCupon.Enabled = true;
            }
            else
            {
                this.btnGenerateCupon.Enabled = false;
            }

            if (currentMonthlyFee.Cupon!=null)
	        {
		        this.btnPrintCupon.Enabled = true;
	        }
            else
	        {
                this.btnPrintCupon.Enabled = false;
	        }
        }

        #region Rowvalidation
        /// <summary>
        /// Método para validar la fila activa
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool validMonthlyFeeRow()
        {
            bool result = true;

            if (this.ugMonthlyFee.ActiveRow != null)
            {
                if (Convert.ToString(this.ugMonthlyFee.ActiveRow.Cells["Operation"].Value) == "R" & Convert.ToDateTime(this.ugMonthlyFee.ActiveRow.Cells["BillingDate"].Value) <= DateTime.Today)
                {
                    utilities.DisplayErrorMessage("La fecha de cobro no puede ser menor o igual a la fecha actual");
                    result = false;
                }
                else if (Convert.ToString(this.ugMonthlyFee.ActiveRow.Cells["Operation"].Value) == "R" & Convert.ToDateTime(this.ugMonthlyFee.ActiveRow.Cells["AlarmDate"].Value) <= DateTime.Today)
                {
                    utilities.DisplayErrorMessage("La fecha de alarma no puede ser menor o igual a la fecha actual");
                    result = false;
                }
                else if (Convert.ToDateTime(this.ugMonthlyFee.ActiveRow.Cells["AlarmDate"].Value) > Convert.ToDateTime(this.ugMonthlyFee.ActiveRow.Cells["BillingDate"].Value))
                {
                    utilities.DisplayErrorMessage("La fecha de alarma no debe ser mayor a la fecha pactada de cobro");
                    result = false;
                }
                else if (Convert.ToDouble(this.ugMonthlyFee.ActiveRow.Cells["FeeValue"].Value)==0.0)
                {
                    utilities.DisplayErrorMessage("El valor de la cuota debe ser mayor a cero");
                    result = false;
                }
            }

            return result;
        }
        #endregion

        /// <summary>
        /// Método para guardar los cambios
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!validMonthlyFeeRow())
            {
                return;
            }

            try
            {
                DeleteMonthlyFees();
                SaveMonthlyFees();
                LoadMonthlyFee(nuProjectId);
                utilities.doCommit();
                utilities.DisplayInfoMessage("Los cambios fueron guardados exitosamente");
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                return;
            }
            DisableChangesSaving();
            //ValidateTotalFeeValue();
        }

        /// <summary>
        /// Método para cancelar cancelar/cerrar la aplicación
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (pendingChanges)
            {
                DialogResult continueCancelling = ExceptionHandler.DisplayMessage(
                                    2741,
                                    "No han guardado todos los cambios. Desea cerrar la aplicación sin guardar los cambios?",
                                    MessageBoxButtons.YesNo,
                                    MessageBoxIcon.Question);

                if (continueCancelling == DialogResult.No)
                {
                    return;
                }
            }

            this.Close();
        }

        /// <summary>
        /// Método para generar el cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnGenerateCupon_Click(object sender, EventArgs e)
        {
            Int64? nuCupon;
            if (currentMonthlyFee!=null)
	        {
                try 
	            {	
                    //Se genera el cupón
		            nuCupon = blFGCPC.GenerateCupon(nuProjectId, currentMonthlyFee);

                    if (nuCupon!=null)
	                {
		                utilities.DisplayInfoMessage("Cupón generado exitosamente: ["+nuCupon+"]");
                        utilities.doCommit();

                        //Se cargan las cuotas actualizadas
                        LoadMonthlyFee(nuProjectId);
	                }
	            }
	            catch (Exception ex)
	            {
		            utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
	            }
	        }
        }

        /// <summary>
        /// Método para imprimir el cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnPrintCupon_Click(object sender, EventArgs e)
        {
            if (currentMonthlyFee!=null)
            {
                if (currentMonthlyFee.Cupon!=null)
                {
                    try
                    {
                        blFGCPC.PrintCupon(currentMonthlyFee.Cupon);
                        Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                        OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("PRINTPREV", parametersTemp, true);
                    }
                    catch (Exception ex)
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                }
            }
        }

        private void FGCPC_FormClosing(object sender, FormClosingEventArgs e)
        {
            ValidateTotalFeeValue();
        }

    }
}
