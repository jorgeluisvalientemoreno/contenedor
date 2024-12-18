using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class POCI : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDRCC blFDRCC = new BLFDRCC();

        private Int64 project;
        private Int64 quotation;

        public POCI(Int64 project, Int64 quotation)
        {
            InitializeComponent();
            this.project = project;
            this.quotation = quotation;
        }

        private void btnAccept_Click(object sender, EventArgs e)
        {
            Double valuePercentage;

            if (utilities.IsvalidPath(tbPath.TextBoxValue))
            {
                if (tbInitialFeePercentage.TextBoxValue != null)
                {
                    valuePercentage = Convert.ToDouble(tbInitialFeePercentage.TextBoxValue);

                    if (valuePercentage <= 0)
                    {
                        utilities.DisplayErrorMessage("Ha digitado un porcentaje no válido. Por favor verifique.");
                        return;
                    }
                    else
                    {

                        try
                        {
                            blFDRCC.UpdateInitialFeePercentage(project, valuePercentage);
                            utilities.doCommit();
                        }
                        catch (Exception ex)
                        {
                            utilities.doRollback();
                            GlobalExceptionProcessing.ShowErrorException(ex);
                            return;
                        }
                        
                        try
                        {
                            Cursor.Current = Cursors.WaitCursor;
                            blFDRCC.PrintPreCupon(project, quotation, tbPath.TextBoxValue);
                            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                            Cursor.Current = Cursors.Default;
                            this.Close();
                        }
                        catch (Exception ex)
                        {
                            GlobalExceptionProcessing.ShowErrorException(ex);
                            this.Close();
                            return;
                        }
                        utilities.DisplayInfoMessage("Se generó el precupón");
                        this.Close();
                    }
                }
                else
                {
                    utilities.DisplayErrorMessage("Debe ingresar un porcentaje");
                    return;
                }
            }
        }

        private void btnSelectPrecuponPath_Click(object sender, EventArgs e)
        {
            fbdPrecuponPath.ShowDialog();
            tbPath.TextBoxValue = fbdPrecuponPath.SelectedPath;
        }
    }
}
