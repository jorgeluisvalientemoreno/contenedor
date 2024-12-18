using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;
using Microsoft.Reporting.WinForms;
using System.IO;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDGRC : OpenForm
    {
        public LDGRC()
        {
            InitializeComponent();
        }

        BLGENERAL general = new BLGENERAL();
        BLLDSRC blLRSCR = new BLLDSRC();

        private void btnprocess_Click(object sender, EventArgs e)
        {
            if (general.validarPath(tbArchiveubication.TextBoxValue))
            {
                String NumberActa = general.getConstantValue("Ld_bosubsidy.globalrecordcollect"); //cbRecordSelect.Value.ToString();
                String[] p1 = new string[] { "Int64" };
                String[] p2 = new string[] { "inurecordcollect" };
                String[] p3 = new string[] { NumberActa };//{ "1" };
                Int64 total = 0;
                actaBindingSource.DataSource = blLRSCR.FcuSubsidy("Ld_BcSubsidy.Frfgetsubsidytocollect", 1, p1, p2, p3, out total);
                this.reportViewer1.RefreshReport();
                Warning[] warnings;
                string[] streamids;
                string mimeType;
                string encoding;
                string extension;
                byte[] bytes = reportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamids, out warnings);
                FileStream fs = new FileStream(tbArchiveubication.TextBoxValue + @"\ActaCobro_" + NumberActa + "_" + DateTime.Now.ToString("dd.MM.yyyy") + ".pdf", FileMode.Create);
                fs.Write(bytes, 0, bytes.Length);
                fs.Close();
                general.mensajeOk("Reporte Generado");
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            fbdDirectory.ShowDialog();
            tbArchiveubication.TextBoxValue = fbdDirectory.SelectedPath;
        }



    }
}