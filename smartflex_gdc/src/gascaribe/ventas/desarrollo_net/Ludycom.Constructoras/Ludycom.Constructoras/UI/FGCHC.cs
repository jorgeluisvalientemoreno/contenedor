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
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.UI
{
    public partial class FGCHC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFDMPC blFDMPC = new BLFDMPC();
        BLFGCHC blFGCHC = new BLFGCHC();
        BLFGCPC blFGCPC = new BLFGCPC();

        public static FormExecutionMode ExecutionMode;

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;
        private Check currentCheck;

        private Int64 nuProjectId;
        private Int64 nuSubscriberCode;

        private Double projectDebt;

        private bool blPendingChanges = false;
        private bool blCustomerServiceAuth = false;
        private bool blExchequerAuth = false;
        private bool blPortfolioAuth = false;

        private List<Check> checksList = new List<Check>();
        private List<Check> checksToDeleteList = new List<Check>();
        private List<ListOfValues> checkStatusList = new List<ListOfValues>();

        OpenGridDropDown ocCheckStatus = new OpenGridDropDown();
        OpenGridDropDown ocBanks = new OpenGridDropDown();

        public FGCHC(Int64 project)
        {
            InitializeComponent();

            InitializeData();

            if (project!=0)
            {
                ExecutionMode = FormExecutionMode.Embedded_Execution;
                InitializeDataByProject(project);   
            }
            else
            {
                ExecutionMode = FormExecutionMode.Direct_execution;
                tbProjectId.ReadOnly = false;
                btnClear.Visible = true;
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
        /// 07-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData()
        {
            bsCheck.DataSource = checksList;

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Se carga lista de estados de los cheques
            checkStatusList.Clear();
            checkStatusList.Add(new ListOfValues("R", "Registrado"));
            checkStatusList.Add(new ListOfValues("A", "Anulado"));
            checkStatusList.Add(new ListOfValues("C", "Consignado"));
            checkStatusList.Add(new ListOfValues("D", "Devuelto"));
            checkStatusList.Add(new ListOfValues("L", "Liberado"));
            checkStatusList.Add(new ListOfValues("E", "Eliminado"));
            ocCheckStatus.DataSource = checkStatusList;
            ocCheckStatus.ValueMember = "Id";
            ocCheckStatus.DisplayMember = "Description";
            this.ugChecks.DisplayLayout.Bands[0].Columns["Status"].ValueList = ocCheckStatus;

            //Se carga lista de bancos
            DataTable dtBanks = utilities.getListOfValue(BLGeneralQueries.strBank);
            ocBanks.DataSource = dtBanks;
            ocBanks.ValueMember = "CODIGO";
            ocBanks.DisplayMember = "DESCRIPCION";
            this.ugChecks.DisplayLayout.Bands[0].Columns["Bank"].ValueList = ocBanks;

            //Se definen los permisos
            setAuthorization();

        }

        private void setAuthorization()
        {
            if (blFGCHC.IsAuthorized("ATEN_CLIENTE"))
            {
                blCustomerServiceAuth = true;
                this.btnGenerateCupon.Enabled = true;
                this.btnPrintCupon.Enabled = true;
                this.btnChangeCheck.Enabled = true;
                this.btnSave.Enabled = true;
                return;
            }
            else if (blFGCHC.IsAuthorized("CARTERA"))
            {
                blPortfolioAuth = true;
                this.btnReturnCheck.Enabled = true;
            }
            else if (blFGCHC.IsAuthorized("TESORERIA"))
            {
                blExchequerAuth = true;
                this.btnLiberateCheck.Enabled = true;
            }
            //this.ugChecks.DisplayLayout.Bands[0].Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            this.ugChecks.DisplayLayout.Bands[0].Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.bnCheckAddNewItem.Enabled = false;
            this.bnCheckDeleteItem.Enabled = false;

        }

        private void InitializeDataByProject(Int64 project)
        {
            nuProjectId = project;

            //Se valida si el proyecto existe
            if (!blFDMPC.ProjectExists(nuProjectId))
            {
                utilities.DisplayErrorMessage("El proyecto con código " + nuProjectId + " no existe en el sistema");
                if (ExecutionMode == FormExecutionMode.Embedded_Execution)
                {
                    this.Close();
                }
                else
                {
                    this.tbProjectId.TextBoxValue = "";
                }
                return;
            }

            //Se valida la forma de pago establecida para el proyecto
            if (blFDMPC.GetPaymentModality(nuProjectId)!="CH")
            {
                utilities.DisplayErrorMessage("Para el proyecto con código "+ nuProjectId + " no se definió la modalidad de pago Cheques");
                this.tbProjectId.TextBoxValue = "";
                return;
            }

            //Se cargan los datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);

            //Se cargan los cheques
            LoadChecks(nuProjectId);

            //Se obtiene la deuda del proyecto
            LoadProjectDebt(nuProjectId);

            //Se valida el modo de ejecución
            if (ExecutionMode == FormExecutionMode.Direct_execution)
            {
                this.btnClear.Visible = true;
                this.tbProjectId.ReadOnly = true;
            }
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

            //obtener el contrato
            tbSubscription.TextBoxValue = Convert.ToString(blFDMPC.GetProjectSubscription(projectId));

            //Se setean los datos del proyecto
            tbProjectId.TextBoxValue = Convert.ToString(projectId);
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
        /// Se cargan los cheques
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadChecks(Int64 project)
        {
            //Se obtiene la lista de cheques
            checksList = blFGCHC.GetChecks(project);

            if (checksList.Count > 0)
            {
                bsCheck.DataSource = checksList;
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
        /// Método para guardar los cambios realizados en los cheques (Creación/Modificación)
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void SaveChecks()
        {
            foreach (Check item in bsCheck)
            {
                if (item.Operation == "R")
                {
                    blFGCHC.RegisterCheck(nuProjectId, item);
                }
                if (item.Operation == "U")
                {
                    blFGCHC.ModifyCheck(nuProjectId, item);
                }
            }
        }
        #endregion

        #region DeleteOperations
        /// <summary>
        /// Método para eliminar los cheques de la base de datos
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void DeleteChecks()
        {
            for (int i = 0; i < checksToDeleteList.Count; i++)
            {
                blFGCHC.ModifyCheck(nuProjectId, checksToDeleteList[i]);
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
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void ValidateChanges()
        {
            List<Check> tmpChecksList = (List<Check>)bsCheck.List;

            bool blUpdatedChecks = tmpChecksList.Exists(delegate(Check c) { return c.Operation == "U"; });
            bool blNewChecks = tmpChecksList.Exists(delegate(Check c) { return c.Operation == "R"; });

            if (blUpdatedChecks || blNewChecks || checksToDeleteList.Count > 0)
            {
                blPendingChanges = true;
                EnableChangesSaving();
            }
            else
            {
                blPendingChanges = false;
                DisableChangesSaving();
            }
        }

        /// <summary>
        /// Método para validar el total de la deuda del proyecto con el total de los cheques ingresados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void ValidateTotalChecksValue()
        {
            Double totalChecksValue = 0;
            foreach (Check item in bsCheck)
            {
                if (item.Status == "R")
                {
                    totalChecksValue = totalChecksValue + item.CheckValue;
                }
            }

            if (totalChecksValue > projectDebt)
            {
                utilities.DisplayInfoMessage("Se le informa que existe una inconsistencia en los datos ingresados, " +
                                            "ya que el total de los cheques sobrepasa el total de la deuda del proyecto");
            }
            else if (totalChecksValue < projectDebt)
            {
                utilities.DisplayInfoMessage("Se le informa que existe una inconsistencia en los datos ingresados, " +
                                            "ya que el total de los cheques registrados no cubre el total de la deuda del proyecto");
            }
        }

        /// <summary>
        /// Método para limpiar datos de la pantalla
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void Clean()
        {
            tbProjectId.TextBoxValue = "";
            tbProjectName.TextBoxValue = "";
            tbCustomerId.TextBoxValue = "";
            tbCustomerName.TextBoxValue = "";
            nuProjectId = 0;
            customerBasicData = null;
            projectBasicData = null;
            currentCheck = null;
            projectDebt = 0;
            blPendingChanges = false;
            checksList = new List<Check>();
            checksToDeleteList = new List<Check>();
            bsCheck.DataSource = checksList;
            tbProjectId.ReadOnly = false;
        }

        /// <summary>
        /// Método para habilitar el botón Guardar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
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
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void DisableChangesSaving()
        {
            if (this.btnSave.Enabled)
            {
                this.btnSave.Enabled = false;
            }
        }

        /// <summary>
        /// Método para agregar un nuevo registro de cheque
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void bnCheckAddNewItem_Click(object sender, EventArgs e)
        {
            if (validCheckRow())
            {
                //Si la fila activa es válida, se crea nuevo registro
                Check tmpCheck = (Check)bsCheck.AddNew();
                ValidateChanges();
            }
        }

        /// <summary>
        /// Método para borrar un registro de cheque
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void bnCheckDeleteItem_Click(object sender, EventArgs e)
        {
            Check tmpCheck = (Check)bsCheck.Current;
            if (tmpCheck.Operation == "R" || tmpCheck.Status == "R")
            {
                if (tmpCheck.Operation != "R")
                {
                    tmpCheck.Operation = "D";
                    checksToDeleteList.Add(tmpCheck);
                }

                bsCheck.RemoveCurrent();
                ValidateChanges();
            }
            else
            {
                utilities.DisplayInfoMessage("Sólo es posible eliminar cheques en estado Registrado");
            }
        }

        private void ugChecks_BeforeCellUpdate(object sender, Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventArgs e)
        {
            Check tmpCheck = (Check)bsCheck.Current;

            if (tmpCheck.Status != "R" && tmpCheck.Operation != "R")
            {
                utilities.DisplayInfoMessage("No se está permitido modificar un cheque que ya no se encuentra en estado Registrado");
                e.Cancel = true;
            }
        }

        private void ugChecks_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            Check tmpCheck = (Check)bsCheck.Current;

            if (tmpCheck.Operation == "N")
            {
                tmpCheck.Operation = "U";
            }

            ValidateChanges();
        }

        private void ugChecks_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!validCheckRow())
            {
                e.Cancel = true;
            }
        }

        private void ugChecks_AfterRowActivate(object sender, EventArgs e)
        {
            currentCheck = (Check)bsCheck.Current;
            DateTime today = OpenDate.getSysDateOfDataBase();

            if (currentCheck.Status == "R")
            {
                if (currentCheck.CheckDate.Date == today.Date & blCustomerServiceAuth)
                {
                    this.btnGenerateCupon.Enabled = true;
                }
                if (blCustomerServiceAuth)
                {
                    this.btnChangeCheck.Enabled = true;
                }
            }
            else
            {
                this.btnGenerateCupon.Enabled = false;
                this.btnChangeCheck.Enabled = false;
            }

            if (currentCheck.Cupon != null & currentCheck.Status == "C" & blCustomerServiceAuth)
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
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private bool validCheckRow()
        {
            bool result = true;

            if (this.ugChecks.ActiveRow != null)
            {
                if (Convert.ToInt64(this.ugChecks.ActiveRow.Cells["Bank"].Value) == 0)
                {
                    utilities.DisplayErrorMessage("Debe seleccionar una entidad bancaria");
                    result = false;
                }
                else if (String.IsNullOrEmpty(Convert.ToString(this.ugChecks.ActiveRow.Cells["Account"].Value)))
                {
                    utilities.DisplayErrorMessage("Debe ingresar el número de la cuenta");
                    result = false;
                }
                else if (String.IsNullOrEmpty(Convert.ToString(this.ugChecks.ActiveRow.Cells["CheckNumber"].Value)))
                {
                    utilities.DisplayErrorMessage("Debe ingresar el número del cheque");
                    result = false;
                }
                else if (Convert.ToDouble(this.ugChecks.ActiveRow.Cells["CheckValue"].Value) == 0.0)
                {
                    utilities.DisplayErrorMessage("El valor del cheque debe ser mayor a cero");
                    result = false;
                }
                else if (Convert.ToString(this.ugChecks.ActiveRow.Cells["Operation"].Value) == "R" & Convert.ToDateTime(this.ugChecks.ActiveRow.Cells["CheckDate"].Value).Date < DateTime.Today.Date)
                {
                    utilities.DisplayErrorMessage("La fecha del cheque debe ser mayor a la fecha actual");
                    result = false;
                }
                //else if (Convert.ToString(this.ugChecks.ActiveRow.Cells["Operation"].Value) == "R" & Convert.ToDateTime(this.ugChecks.ActiveRow.Cells["AlarmDate"].Value).Date <= DateTime.Today.Date)
                //{
                //    utilities.DisplayErrorMessage("La fecha de alarma debe ser mayor a la fecha actual");
                //    result = false;
                //}
                else if (Convert.ToDateTime(this.ugChecks.ActiveRow.Cells["AlarmDate"].Value).Date > Convert.ToDateTime(this.ugChecks.ActiveRow.Cells["CheckDate"].Value).Date)
                {
                    utilities.DisplayErrorMessage("La fecha de alarma debe ser menor a la fecha del cheque");
                    result = false;
                }
            }

            return result;
        }
        #endregion

        private void tbProjectId_Validating(object sender, CancelEventArgs e)
        {
            if (!String.IsNullOrEmpty(tbProjectId.TextBoxValue))
            {
                Int64 tmpProjectId = Convert.ToInt64(tbProjectId.TextBoxValue);
                InitializeDataByProject(tmpProjectId);
            }
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
            if (blPendingChanges)
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
        /// Método para guardar los cambios
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!validCheckRow())
            {
                return;
            }

            try
            {
                DeleteChecks();
                SaveChecks();
                LoadChecks(nuProjectId);
                utilities.doCommit();
                utilities.DisplayInfoMessage("Los cambios fueron guardados exitosamente");

                //Se vacía la lista de cheques a borrar
                checksToDeleteList.Clear();
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                return;
            }
            
            
            ValidateChanges();
            DisableChangesSaving();
            
        }

        /// <summary>
        /// Método para generar el cupón
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnGenerateCupon_Click(object sender, EventArgs e)
        {
            Int64? nuCupon;

            if (blPendingChanges)
            {
                utilities.DisplayInfoMessage("Guarde los cambios pendientes antes de generar el cupón");
                return;
            }

            if (currentCheck != null)
            {
                try
                {
                    //Se genera el cupón
                    nuCupon = blFGCHC.GenerateCupon(nuProjectId, currentCheck);

                    if (nuCupon != null)
                    {
                        utilities.DisplayInfoMessage("Cupón generado exitosamente: [" + nuCupon + "]");
                        utilities.doCommit();

                        //Se cargan los cheques actualizados
                        LoadChecks(nuProjectId);
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
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnPrintCupon_Click(object sender, EventArgs e)
        {
            if (currentCheck != null)
            {
                if (currentCheck.Cupon != null)
                {
                    try
                    {
                        blFGCHC.PrintCupon(currentCheck.Cupon);
                        Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                        OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("PRINTPREV", parametersTemp, true);
                    }
                    catch (Exception ex)
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);
                        return;
                    }
                }
            }
        }

        /// <summary>
        /// Método para cambiar un cheque
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnChangeCheck_Click(object sender, EventArgs e)
        {
            if (blPendingChanges)
            {
                utilities.DisplayInfoMessage("Guarde los cambios pendientes antes de cambiar un cheque");
                return;
            }
            
            try
            {
                if (currentCheck != null)
                {
                    if (currentCheck.CheckNumber != null & currentCheck.Consecutive!=0)
                    {
                        if (currentCheck.Status == "R")
                        {
                            using (FCCH frm = new FCCH(nuProjectId, currentCheck.Consecutive, currentCheck.CheckNumber))
                            {
                                frm.ShowDialog();
                                if (frm.SuccessfulExecution)
                                {
                                    LoadChecks(nuProjectId);
                                }
                            }
                        }
                        else
                        {
                            utilities.DisplayInfoMessage("Solo se pueden cambiar cheques en estado Registrado ");
                            return;
                        }
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

        /// <summary>
        /// Método para devolver un cheque
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnReturnCheck_Click(object sender, EventArgs e)
        {
            try
            {
                if (blPortfolioAuth)
                {
                    if (currentCheck != null)
                    {
                        if (currentCheck.Status == "C")
                        {
                            blFGCHC.ReturnCheck(nuProjectId, currentCheck);
                            utilities.doCommit();
                            LoadChecks(nuProjectId);
                            utilities.DisplayInfoMessage("El cheque fue devuelto exitosamente");
                        }
                        else
                        {
                            utilities.DisplayInfoMessage("Solo se pueden devolver cheques en estado Consignado ");
                            return;
                        }
                    }   
                }
                else
                {
                    utilities.DisplayInfoMessage("No está autorizado para devolver el cheque!");
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                return;
            }
        }

        /// <summary>
        /// Método para liberar un cheque
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        private void btnLiberateCheck_Click(object sender, EventArgs e)
        {
            try
            {
                if (blExchequerAuth)
                {
                    if (currentCheck != null)
                    {
                        if (currentCheck.Status == "C")
                        {
                            blFGCHC.LiberateCheck(nuProjectId, currentCheck);
                            utilities.doCommit();
                            LoadChecks(nuProjectId);
                            utilities.DisplayInfoMessage("El cheque fue liberado exitosamente");
                        }
                        else
                        {
                            utilities.DisplayInfoMessage("Solo se pueden liberar cheques en estado Consignado ");
                            return;
                        }
                    }
                }
                else
                {
                    utilities.DisplayInfoMessage("No está autorizado para liberar el cheque ");
                }
            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
                
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clean();
        }

        private void FGCHC_FormClosing(object sender, FormClosingEventArgs e)
        {
            ValidateTotalChecksValue();
        }
    }
}
