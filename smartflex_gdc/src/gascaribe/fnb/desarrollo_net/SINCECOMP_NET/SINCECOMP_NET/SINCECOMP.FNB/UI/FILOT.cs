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
using SINCECOMP.FNB.Entities;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

namespace SINCECOMP.FNB.UI
{
    public partial class FILOT : OpenForm
    {

        public FILOT()
        {
            InitializeComponent();
           
            
        }

    

        private void openButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }


    }
}