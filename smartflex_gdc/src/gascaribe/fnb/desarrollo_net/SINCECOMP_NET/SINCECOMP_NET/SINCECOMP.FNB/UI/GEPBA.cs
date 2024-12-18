#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : GEPBA
 * Descripcion   : Portafolio por Archivo Plano
 * Autor         : Sicecomp
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 07-Sep-2013  216578  lfernandez     1 - <btnProcess_Click> Luego de llamar a readFile se actualiza el
 *                                         mensaje de error, ya que no se está exportando sino cargando el
 *                                         archivo
 * 30-Ago-2013  215138  jaricapa       1 - Se indica cual es el número de la línea del error.
 *                                     2 - Se mejora usabilidad.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.BL;
using System.IO;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.UI
{
    public partial class GEPBA : OpenForm
    {
        public GEPBA()
        {
            InitializeComponent();
        }



        private void btnProcess_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbArchiveubication.TextBoxValue))
            {
                string[] arrayMessage = {"Por favor seleccione un archivo válido." };
                ExceptionHandler.DisplayError(2741, arrayMessage);
                return;
            }

            if (!File.Exists(tbArchiveubication.TextBoxValue))
            {
                string[] arrayMessage = { "El archivo no existe. Por favor seleccione un archivo válido." };
                ExceptionHandler.DisplayError(2741, arrayMessage);
                return;
            }
            
            if (BLGEPBA.readFile(tbArchiveubication.TextBoxValue))
            {
                string[] arrayMessage = {"Proceso de Carga Exitosa." };
                ExceptionHandler.DisplayMessage(2741, arrayMessage);                
                tbArchiveubication.TextBoxValue = String.Empty;
            }
            else
            {
                ExceptionHandler.DisplayMessage(2741, "Proceso terminó con errores. Ver log.");
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            if (ofdFile.ShowDialog() == DialogResult.OK)
            {
                tbArchiveubication.TextBoxValue = ofdFile.FileName;
                btnProcess.Select();
            }            
        }

        /// <summary>
        /// Cierra la forma
        /// </summary>
        /// <param name="sender">Botón</param>
        /// <param name="e">Contiene datos del evento</param>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Ocurre cuando presiona una tecla.
        /// </summary>
        /// <param name="sender">Forma</param>
        /// <param name="e">Contiene datos del evento</param>
        private void GEPBA_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
            {
                this.Close();
            }
        }
    }
}