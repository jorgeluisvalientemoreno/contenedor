#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : ctrlLaborInfo
 * Descripcion   : Control de Información Laboral
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 29-Ago-2013  214417  jaricapa       1 - Se actualiza el tamaño de los campos.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.Util;


namespace SINCECOMP.FNB.Controls
{
    /// <summary>
    /// Control de Información Laboral
    /// </summary>
    public partial class ctrlLaborInfo : UserControl
    {

        private List<ListOfVal> contractTypeList = new List<ListOfVal>();
        public string indepentOccupId = " ";
        public string employeeOccupId = " ";
        public string fnbOccupsIds = " ";

        private static BLFIFAP _blFIFAP = new BLFIFAP();
        BLGENERAL general = new BLGENERAL();


        public ctrlLaborInfo()
        {
            InitializeComponent();

            oabCompanyAddress.AutonomusTransaction = true;

            indepentOccupId = general.getParam("INDEPENDENT_OCCUPATION_ID", "String").ToString(); //_blFIFAP.getParam("INDEPENDENT_OCCUPATION_ID");

            try
            {

                employeeOccupId = general.getParam("EMPLOYEE_OCCUPATION_ID", "String").ToString(); //_blFIFAP.getParam("INDEPENDENT_OCCUPATION_ID");
            }
            catch
            {

            }

            try
            {
                ocOccupation.DataSource = general.getValueList("select profession_id Id, description description from ge_profession WHERE REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('FNB_OCCUPATIONS_IDS'), '(\\W|^)'|| profession_id ||'(\\W|$)') > 0 Order By profession_id");
            }
            catch
            {

            }

            ocOccupation.DisplayMember = "description";
            ocOccupation.ValueMember = "id";
            contractTypeList.Add(new ListOfVal("1", "1 - Indefinido"));
            contractTypeList.Add(new ListOfVal("2", "2 - Temporal"));
            contractTypeList.Add(new ListOfVal("3", "3 - Fijo"));
            contractTypeList.Add(new ListOfVal("4", "4 - Otro"));
            ocContractType.DataSource = contractTypeList;
            ocContractType.ValueMember = "id";
            ocContractType.DisplayMember = "description";            
        }

        private void ocOccupation_ValueChanged(object sender, EventArgs e)
        {
            if (OpenConvert.ToString(ocOccupation.Value).Equals(indepentOccupId))
            {
                opstbCompanyName.Required = 'N';
                oabCompanyAddress.Required = 'N';
                ocContractType.Required = 'N';
                ocContractType.Value = null;
                ocContractType.ReadOnly = true;
                ostbActivity.Required = 'Y';
                ostbActivity.ReadOnly = false;
                opstbCompanyName.ReadOnly = true;
                oabCompanyAddress.ReadOnly = true;
                opstbCompanyName.TextBoxValue = " ";
                oabCompanyAddress.Address_id = null;
                ostbOldLabor.ReadOnly = true;
                ostbOldLabor.TextBoxValue = "";
                ostbOldLabor.Required = 'N';
            }
            else if (OpenConvert.ToString(ocOccupation.Value).Equals(employeeOccupId))
            {
                ocContractType.Required = 'Y';
                ocContractType.ReadOnly = false;
                opstbCompanyName.Required = 'Y';
                oabCompanyAddress.Required = 'Y';
                ostbActivity.Required = 'N';
                ostbActivity.ReadOnly = true;
                ostbActivity.TextBoxValue = " ";
                opstbCompanyName.ReadOnly = false;
                oabCompanyAddress.ReadOnly = false;
                ostbOldLabor.ReadOnly = false;
                ostbOldLabor.Required = 'Y';

            }
            else
            {

                ostbActivity.Required = 'N';
                ostbActivity.ReadOnly = true;
                ostbActivity.TextBoxValue = " ";
                opstbCompanyName.Required = 'N';
                oabCompanyAddress.Required = 'N';
                ocContractType.Required = 'N';
                ocContractType.Value = null;
                ocContractType.ReadOnly = true;
                opstbCompanyName.ReadOnly = true;
                oabCompanyAddress.ReadOnly = true;
                opstbCompanyName.TextBoxValue = " ";
                oabCompanyAddress.Address_id = null;
                ostbOldLabor.ReadOnly = true;
                ostbOldLabor.TextBoxValue = "";
                ostbOldLabor.Required = 'N';
            }
        }

        private void ostbPhone2_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }

        }

        private void ostbCelPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbOldLabor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbMonthlyIncome_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbMonthlyExpenses_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }
        private void Validate_Phone(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "El número de teléfono debe tener 7 dígitos");
                    e.Cancel = true;
                }
            }
        }

        private void Validate_CellPhone(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "Número de teléfono celular debe tener 10 dígitos");
                    e.Cancel = true;
                }
            }
        }

        /// <summary>
        /// Limpia los campos del control
        /// </summary>
        public void ClearData()
        {
            ocOccupation.Value = null;
            opstbCompanyName.TextBoxValue = null;
            ostbEmail.TextBoxValue = null;
            oabCompanyAddress.Address_id = null;
            ocContractType.Value = null;
            ostbPhone.TextBoxValue = null;
            ostbPhone2.TextBoxValue = null;
            ostbCelPhone.TextBoxValue = null;
            ostbMonthlyIncome.TextBoxValue = null;
            ostbMonthlyExpenses.TextBoxValue = null;
            ostbActivity.TextBoxValue = null;
            ostbOldLabor.TextBoxValue = null;
        }
    }
}
