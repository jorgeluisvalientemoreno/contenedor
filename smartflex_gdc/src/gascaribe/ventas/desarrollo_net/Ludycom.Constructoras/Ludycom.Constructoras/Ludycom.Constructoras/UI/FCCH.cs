using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using OpenSystems.Windows.Controls;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class FCCH : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFGCHC blFGCHC = new BLFGCHC();

        private Int64 projectId;
        private Int64 previousCheckConsecutive;
        private String previousCheckNumber;
        private bool successfulExecution = false;

        public FCCH(Int64 project, Int64 previousCheckConsecutive, String previousCheckNumber)
        {
            InitializeComponent();
            InitializeData(project, previousCheckConsecutive, previousCheckNumber);
        }

        public bool SuccessfulExecution
        {
            get { return successfulExecution; }
            set { successfulExecution = value; }
        }

        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 08-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void InitializeData(Int64 project, Int64 checkConsecutive, String previousCheckNumber)
        {
            this.projectId = project;
            this.previousCheckConsecutive = checkConsecutive;
            this.previousCheckNumber = previousCheckNumber;

            //Se carga lista de bancos
            DataTable dtBanks = utilities.getListOfValue(BLGeneralQueries.strBank);
            ocBanks.DataSource = dtBanks;
            ocBanks.ValueMember = "CODIGO";
            ocBanks.DisplayMember = "DESCRIPCION";

            String strCheckNumber = Convert.ToString(previousCheckNumber);

            if (!string.IsNullOrEmpty(strCheckNumber))
            {
                tbPrevCheck.TextBoxValue = strCheckNumber;
            }
        }

        #endregion

        private bool ValidFields()
        {
            bool result = true;
            if (Convert.ToInt64(ocBanks.Value) == 0)
            {
                utilities.DisplayErrorMessage("Debe seleccionar la entidad bancaria");
                result = false;
            }
            else if (String.IsNullOrEmpty(tbAccount.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Debe digitar el número de la cuenta");
                result = false;
            }
            else if (String.IsNullOrEmpty(tbCheckNumber.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Debe digitar el número del cheque");
                result = false;
            }
            else if (tbCheckNumber.TextBoxValue == previousCheckNumber)
	        {
                utilities.DisplayErrorMessage("El número del cheque debe ser diferente al que va a cambiar");
                result = false;
	        }
            else if (String.IsNullOrEmpty(tbCheckValue.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Debe digitar el valor del cheque");
                result = false;
            }
            else if (Convert.ToDouble(tbCheckValue.TextBoxValue)<=0)
            {
                utilities.DisplayErrorMessage("El valor del cheque debe ser mayor a cero");
                result = false;
            }
            else if (String.IsNullOrEmpty(tbCheckDate.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Debe ingresar la fecha del cheque");
                result = false;
            }
            else if (String.IsNullOrEmpty(tbAlarmDate.TextBoxValue))
            {
                utilities.DisplayErrorMessage("Debe ingresar la de alarma");
                result = false;
            }
            else if (Convert.ToDateTime(tbAlarmDate.TextBoxValue).Date > Convert.ToDateTime(tbCheckDate.TextBoxValue).Date)
            {
                utilities.DisplayErrorMessage("La fecha de alarma no debe ser mayor a la fecha del cheque");
                result = false;
            }

            return result;
        }


        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidFields())
            {
                Check newCheck = new Check();
                newCheck.Account = tbAccount.TextBoxValue;
                newCheck.Bank = Convert.ToInt64(ocBanks.Value);
                newCheck.CheckNumber = tbCheckNumber.TextBoxValue;
                newCheck.CheckDate = Convert.ToDateTime(tbCheckDate.TextBoxValue);
                newCheck.AlarmDate = Convert.ToDateTime(tbAlarmDate.TextBoxValue);
                newCheck.CheckValue = Convert.ToDouble(tbCheckValue.TextBoxValue);

                try
                {
                    blFGCHC.ChangeCheck(projectId, newCheck, previousCheckConsecutive);
                    utilities.doCommit();
                    successfulExecution = true;
                    utilities.DisplayInfoMessage("El cambio de cheque fue realizado exitosamente");
                    this.Close();
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    successfulExecution = false;
                    GlobalExceptionProcessing.ShowErrorException(ex);
                }
                
            }
        }
    }
}
