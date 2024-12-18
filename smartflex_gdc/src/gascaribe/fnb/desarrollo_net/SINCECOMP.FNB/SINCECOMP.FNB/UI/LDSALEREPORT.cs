using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.BL;

namespace SINCECOMP.FNB.UI
{
    public partial class LDSALEREPORT : Form
    {

        String FindRequest;
        BLGENERAL general = new BLGENERAL();

        public LDSALEREPORT(String findRequest)
        {
            InitializeComponent();
            FindRequest = findRequest;
        }

        private void LDSALEREPORT_Load(object sender, EventArgs e)
        {
            ReportSaleFNBBindingSource.DataSource = BLLDSALEREPORT.FlistSaleFNB (FindRequest);
            if (ReportSaleFNBBindingSource.Count == 0)
            {
                general.mensajeERROR("No existe ninguna Solicitud asociada a este consecutivo");
                this.Close();
            }
            else
            {
                this.reportViewer1.RefreshReport();
            }
        }
    }
}