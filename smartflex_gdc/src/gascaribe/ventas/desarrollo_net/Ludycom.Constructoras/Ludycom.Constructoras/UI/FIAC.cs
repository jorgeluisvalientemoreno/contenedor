using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Ludycom.Constructoras.BL;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class FIAC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFCUAD blFCUAD = new BLFCUAD();

        private Int64 feeId;
        private Int64 project;
        private bool instance = false;

        public FIAC(Int64 project, Int64 feeId)
        {
            InitializeComponent();
            this.feeId = feeId;
            this.project = project;
        }

        public FIAC()
        {
            instance = true;
            InitializeComponent();
        }

        private void btnSelectActPath_Click(object sender, EventArgs e)
        {
            fbActPath.ShowDialog();
            tbPath.TextBoxValue = fbActPath.SelectedPath;
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (utilities.IsvalidPath(tbPath.TextBoxValue))
            {
                
                if ((feeId != 0 && !instance) || (feeId == 0 && instance))
                {
                    try
                    {
                        Cursor.Current = Cursors.WaitCursor;
                        blFCUAD.PrintWorkProgressAct(project, feeId, tbPath.TextBoxValue);
                        Dictionary<string, object> parametersTemp = new Dictionary<string, object>();
                        OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("EXME", parametersTemp, true);
                        Cursor.Current = Cursors.Default;
                        this.Close();
                    }
                    catch (Exception ex)
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                }
                else
                {
                    utilities.DisplayErrorMessage("No está definida el acta que se va a imprimir");
                }
            }
        }
    }
}
