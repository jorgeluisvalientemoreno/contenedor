using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls ;
//
using SINCECOMP.SUBSIDYS.BL;
using SINCECOMP.SUBSIDYS.Entities;
using Microsoft.Reporting.WinForms;
using System.IO;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDrptActa : OpenForm
    {
        String NumberActa;

        public LDrptActa(String numberActa)
        {
            InitializeComponent();
            NumberActa = numberActa;
        }

        BLGENERAL general = new BLGENERAL();
        BLLDSRC blLRSCR = new BLLDSRC();

        private void LDrptActa_Load(object sender, EventArgs e)
        {
            String[] p1 = new string[] { "Int64" };
            String[] p2 = new string[] { "inurecordcollect" };
            String[] p3 = new string[] { NumberActa };//{ "1" };
            Int64 total = 0;
            actaBindingSource.DataSource  = blLRSCR.FcuSubsidy("Ld_BcSubsidy.Frfgetsubsidytocollect", 1, p1, p2, p3, out total);
            //
            //List<ReportParameter> parameters = new List<ReportParameter>();
            //parameters.Add(new ReportParameter("nActa", NumberActa));
            //reportViewer1.ServerReport.SetParameters(parameters);
            //
            this.reportViewer1.RefreshReport();
            //reportViewer1 .co

            Warning[] warnings;
            string[] streamids;
            string mimeType;
            string encoding;
            string extension;

            byte[] bytes = reportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamids, out warnings);

            FileStream fs = new FileStream(@"D:\ReportOutput.pdf", FileMode.Create);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();

            Close();
        }
    }
}