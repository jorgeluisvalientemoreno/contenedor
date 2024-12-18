#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Gases del Caribe (c).                                                  
 *===========================================================================================================
 * Unidad        : LDCGALOM
 * Descripción   : Ejecutable encargado de crear vsi por archivo plano
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ============    ======================================================================
 * 07-04-2017   991     eceron          Creación                                        
 * =========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Util;
using OpenSystems.Component.Framework;
using OpenSystems.Windows.Controls;
using OpenSystems.Common;
using OpenSystems.Common.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;

namespace LDCGALOM
{
    public partial class LDCGALOM : OpenForm
    {
        #region Variables Globales
        int gvalResult = 0; /*0 - Indica que el proceso fue exitoso, -1 - Indica que hubo error en alguna de las lineas*/
        #endregion

        #region Inicialización
        public LDCGALOM()
        {
            InitializeComponent();
        }
        #endregion

        #region Métodos
        /// <summary>
        /// Evento del botón procesar
        /// </summary>
        private void btnProcess_Click(object sender, EventArgs e)
        {
            string sbPath = txtPath.Text;
            if (sbPath == "")
            {
                MessageBox.Show("Debe seleccionar un archivo.");
                return;
            }

            System.IO.StreamReader sr = new System.IO.StreamReader(opnFileDialog.FileName);
            string[] sbPaths = sbPath.Split('.');
            string sbExtension = null;

            sbExtension = sbPaths[sbPaths.Length - 1];

            if (sbExtension.ToUpper() != "TXT")
            {
                MessageBox.Show("Tipo de archivo inválido. Debe ser .txt");
                return;
            }

            int totalreg = 0;
            string line;

            while ((line = sr.ReadLine()) != null)
            {
                //ProcessLine(line);
                totalreg++;
            }
            this.Close();

             sr = new System.IO.StreamReader(opnFileDialog.FileName);
             sbPaths = sbPath.Split('.');

            if (totalreg > 0)
            {
                totalreg = totalreg - 1;
                //MessageBox.Show("Cantidad de Registros" + totalreg);
                int counter = 0;
                while ((line = sr.ReadLine()) != null)
                {
                   // MessageBox.Show("Ingreso" + totalreg);
                    if (counter > 0)
                    {
                        ProcessLine(line, counter, totalreg);
                    }
                    counter++;
                }

                if (this.gvalResult == 0)
                {
                    MessageBox.Show("Proceso ejecutado correctamente.");
                }
                else
                {
                    ExceptionHandler.EvaluateErrorCode(-1, "El proceso se ejecutó con inconsitencias. Favor revisar los resultados.");
                }
            }
                this.Close();              
     
        }
        /// <summary>
        /// Procesa cada linea del archivo de texto
        /// </summary>
        public void ProcessLine(string isbData, int cant, int totalreg)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGGENORDADMOVILES.PROCORDENADM"))
            {
                Int64 nuOK;
                String error;
                OpenDataBase.db.AddInParameter(cmdCommand, "sbCadena", DbType.String, isbData);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuLinea", DbType.Int64, cant);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCantReg", DbType.Int64, totalreg);
                OpenDataBase.db.AddOutParameter(cmdCommand, "nuOk", DbType.Int64, 1000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbError", DbType.String, 1000);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                OpenDataBase.db.GetParameterValue(cmdCommand, "nuOk");
                nuOK = (Int64)OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "nuOk"));
                error = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbError"));
                //MessageBox.Show("ingreso " + error);
                if (nuOK == -1)
                {
                    this.gvalResult = -1;
                }                
            }
        }
        /// <summary>
        /// Permite navegar dentro del explorador
        /// </summary>
        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if (opnFileDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtPath.Text = opnFileDialog.FileName;
            }
        }

        /// <summary>
        /// Acción del botón cancelar
        /// </summary>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        #endregion
    }
}
