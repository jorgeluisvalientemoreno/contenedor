using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;
using SINCECOMP.SUBSIDYS.Entities;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDSRC : OpenForm
    {

        BLGENERAL general = new BLGENERAL();
        BLLDSRC blLRSCR = new BLLDSRC();
        BindingSource customerbinding = new BindingSource();

        public LDSRC()
        {
            InitializeComponent();
            Int64 total = 0;
            String[] p1 = new string[] { "Int64" };
            String[] p2 = new string[] { "inurecordcollect" };
            String[] p3 = new string[] { "1" };
            List<acta> ListSubsidy = new List<acta>();
            ListSubsidy = blLRSCR.FcuSubsidy("Ld_BcSubsidy.Frfgetsubsidytocollect", 1, p1, p2, p3, out total);
            customerbinding.DataSource = ListSubsidy;
            dgDatos.DataSource = customerbinding;
            //
            tbTotales.TextBoxValue  = total.ToString ();
            //
            dgDatos.DisplayLayout.Bands[0].Columns["Subsidy_Value"].Format = "$ #,##0.00";
            dgDatos.DisplayLayout.Bands[0].Columns["Subsidy_Value"].CellAppearance.TextHAlign = HAlign.Right;
            //
            dgDatos.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";
            dgDatos.DisplayLayout.Bands[0].Summaries.Clear();
            dgDatos.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDatos.DisplayLayout.Bands[0].Columns["Subsidy_Value"]);
            dgDatos.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDatos.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDatos.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            dgDatos.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "$ {0:N}";
            ////
        }

        private void LDSRC_Load(object sender, EventArgs e)
        {

        }

       

        
    }
}