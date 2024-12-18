using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//
using OpenSystems.Windows.Controls;

namespace SINCECOMP.FNB.UI
{
    public partial class Form1 : OpenForm
    {

        private Int64 _packageId;
        private String _descPrinter;

        public Form1(Int64 packageId, String descPrinter)
        {
            _packageId = packageId;
            _descPrinter = descPrinter;
            InitializeComponent();
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            //PromissoryBindingSource.DataSource = BLFIFAP.FlistPromissoryPagare(_packageId, "D", "C", _descPrinter);            
            this.reportViewer1.RefreshReport();
        }
    }
}