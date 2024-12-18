using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlReference : UserControl
    {
        public ctrlReference()
        {
            InitializeComponent();
            oabCommercialAddress.AutonomusTransaction = true;
            oabFamiliarAddress.AutonomusTransaction = true;
            oabCommercialAddress.AutonomusTransaction = true;

        }

        private void ostbFamiliarPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }

        }

        private void ostbPersonalPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbCommercialPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbFamiliarCelPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbPersonalCelPhone_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {

                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void ostbComercialCelPhone_KeyUp(object sender, KeyEventArgs e)
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

        private void ostbFamiliarPhone_Leave(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Limpia los campos del control
        /// </summary>
        public void ClearData()
        {
            ostbFamiliarName.TextBoxValue = null;
            ostbFamiliarPhone.TextBoxValue = null;
            ostbFamiliarCelPhone.TextBoxValue = null;
            oabFamiliarAddress.Address_id = null;
            ostbPersonalName.TextBoxValue = null;
            ostbPersonalPhone.TextBoxValue = null;
            ostbPersonalCelPhone.TextBoxValue = null;
            oabPersonalAddress.Address_id = null;
            ostbCommercialName.TextBoxValue = null;
            ostbCommercialPhone.TextBoxValue = null;
            ostbComercialCelPhone.TextBoxValue = null;
            oabCommercialAddress.Address_id = null;
        }

        /// <summary>
        /// Valida que los campos hayan sido llenados correctamente
        /// </summary>
        /// <returns>Mensaje de resultado</returns>
        public string validateFields()
        {
            string message = string.Empty;

            if (string.IsNullOrEmpty(ostbFamiliarName.TextBoxValue) )
            {
                message = "Faltan datos requeridos, no ha digitado el nombre de la referencia familiar";
            }
            else if (string.IsNullOrEmpty(ostbFamiliarPhone.TextBoxValue) && string.IsNullOrEmpty(ostbFamiliarCelPhone.TextBoxValue))
            {
                message = "Faltan datos requeridos, se debe digitar un teléfono fijo o un teléfono celular para la referencia familiar";
            }
            
            if (!string.IsNullOrEmpty(ostbPersonalName.TextBoxValue) || 
                !string.IsNullOrEmpty(oabPersonalAddress.Address_id) ||
                !string.IsNullOrEmpty(ostbPersonalPhone.TextBoxValue) || 
                !string.IsNullOrEmpty(ostbPersonalCelPhone.TextBoxValue))
            {
                if (string.IsNullOrEmpty(ostbPersonalName.TextBoxValue))
                {
                    message = "Faltan datos requeridos, no ha digitado el nombre de la referencia personal";
                }
                else if (string.IsNullOrEmpty(ostbPersonalPhone.TextBoxValue)
              && string.IsNullOrEmpty(ostbPersonalCelPhone.TextBoxValue))
                {
                    message = "Faltan datos requeridos, se debe digitar un teléfono o un teléfono celular para la referencia personal";
                }
            }
            
            if (!string.IsNullOrEmpty(ostbCommercialName.TextBoxValue) ||
                !string.IsNullOrEmpty(oabCommercialAddress.Address_id) ||
                !string.IsNullOrEmpty(ostbCommercialPhone.TextBoxValue) || 
                !string.IsNullOrEmpty(ostbComercialCelPhone.TextBoxValue))
            {
                if (string.IsNullOrEmpty(ostbCommercialName.TextBoxValue))
                {
                    message = "Faltan datos requeridos, no ha digitado el nombre de la referencia comercial";
                }
                else if (string.IsNullOrEmpty(ostbCommercialPhone.TextBoxValue) && string.IsNullOrEmpty(ostbComercialCelPhone.TextBoxValue))
                {
                    message = "Faltan datos requeridos, se debe digitar un teléfono o un teléfono celular para la referencia comercial";
                }
            }
            return message;
        }
    }
}
