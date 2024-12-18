using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.SUBSIDYS.BL;
using Microsoft.Reporting.WinForms;
using System.IO;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDDRC : OpenForm
    {
        BLGENERAL general = new BLGENERAL();

        public LDDRC()
        {
            InitializeComponent();
            String[] p1 = new string[] { "String" };
            String[] p2 = new string[] { "isbselect" };
            String[] p3 = new string[] { "Select distinct(l.record_collect) acta From ld_asig_subsidy l where l.record_collect is not null Order by l.record_collect" };
            cbRecordSelect.DataSource = general.cursorProcedure("ld_boconstans.frfSentence", 1, p1, p2, p3);
            //Select distinct(l.record_collect) acta From   ld_asig_subsidy l Order by l.record_collect
            //p1 = new string[] { "String" };
            //p2 = new string[] { "isbselect" };
            p3 = new string[] { "Select 'RPTACTACOBRO' Plantilla from dual" };
            ocbTemplatecode.DataSource = general.cursorProcedure("ld_boconstans.frfSentence", 1, p1, p2, p3);
        }

        BLLDSRC blLRSCR = new BLLDSRC();

        Boolean validar()
        {
            if (cbRecordSelect.Value == null || cbRecordSelect.SelectedRow == null)
            {                
                general.mensaje("Debe seleccionar un Acta de Cobro");
                return false;
            }
            if (ocbTemplatecode.SelectedRow == null)
            {
                general.mensaje("Debe seleccionar el Código de una Plantilla");
                return false;
            }
            if (tbArchiveubication.TextBoxValue  == "")
            {
                general.mensaje("Debe seleccionar un Directorio");
                return false;
            }
            return true;
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            if (validar())
            {
                //LDrptActa Forma = new LDrptActa(cbRecordSelect .Value.ToString ());
                //Forma.Show();
                String NumberActa = cbRecordSelect.Value.ToString();                
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

        private void btnFileSearch_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog foldDialog = new FolderBrowserDialog();
            foldDialog.Description = "Seleccione el directorio destino donde desea que se almacenen los archivos.";
            foldDialog.ShowDialog();
            tbArchiveubication.TextBoxValue = foldDialog.SelectedPath;
        }



    }
}