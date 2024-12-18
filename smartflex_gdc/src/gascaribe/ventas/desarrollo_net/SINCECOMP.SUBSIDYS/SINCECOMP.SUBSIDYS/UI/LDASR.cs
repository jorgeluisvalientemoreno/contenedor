using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDASR : OpenForm
    {
        public LDASR()
        {
            InitializeComponent();
        }

        BLGENERAL general = new BLGENERAL();

        private void btnImport_Click(object sender, EventArgs e)
        {
            ofdFile.ShowDialog();
            tbArchiveubication.TextBoxValue = ofdFile.FileName;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            
            if (general.validarPath(tbArchiveubication.TextBoxValue))
            {
                if (blLDASR.readFile(tbArchiveubication.TextBoxValue) == true)
                {
                    //Llamar a la forma que genera las cartas
                    LDLRA forma = new LDLRA();
                    forma.ShowDialog ();
                    
                }
                
            }
        }
    }
}