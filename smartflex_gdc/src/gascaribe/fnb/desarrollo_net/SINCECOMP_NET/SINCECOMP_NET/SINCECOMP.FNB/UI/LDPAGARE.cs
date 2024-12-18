using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using Microsoft.Reporting.WinForms;

namespace SINCECOMP.FNB.UI
{
    public partial class LDPAGARE : Form
    {
        private Int64 _packageId;
        private String _descPrinter;

        public LDPAGARE( Int64 packageId, String descPrinter)
        {
            _packageId = packageId;
            _descPrinter = descPrinter;
            InitializeComponent();
        }


        private void LDPAGARE_Load(object sender, EventArgs e)
        {
            PromissoryBindingSource.DataSource = BLFIFAP.FlistPromissoryPagare(_packageId, "D", "C", _descPrinter);            
            this.reportViewer1.RefreshReport();
        }
    }
}