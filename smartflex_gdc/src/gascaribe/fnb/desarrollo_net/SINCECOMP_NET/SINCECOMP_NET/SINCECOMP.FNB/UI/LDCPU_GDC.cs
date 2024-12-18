using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.BL;
using Microsoft.Reporting.WinForms;

namespace SINCECOMP.FNB.UI
{
    public partial class LDCPU_GDC : Form
    {

        String FindRequest;
        Int64 CodeVoucher;
        BLGENERAL general = new BLGENERAL();

        public LDCPU_GDC(String findRequest)
        {
            InitializeComponent();
            FindRequest = findRequest;
        }

        private void LDCPU_GDC_Load(object sender, EventArgs e)
        {

            String[] D = BLDCPU_GDC.FtrfDeudor(FindRequest);

            int contador = 0;
            for (int i = 1; i <= 30; i++)
            {
                if (D[i] == "")
                    contador++;
            }

            if (contador == 30)
            {
                general.mensajeERROR("No existe ninguna Solicitud asociada a este consecutivo");
                this.Close();
            }
            else
            {

                String[] C = BLDCPU_GDC.FtrfCodeudor(FindRequest);
                //
                ReportParameter[] parametro = new ReportParameter[54];
                //
                int cont = 1;
                for (int i = 0; i <= 29; i++)
                {
                    parametro[i] = new ReportParameter("D" + cont, D[cont], false);
                    cont++;
                }
                cont = 1;
                for (int i = 30; i <= 53; i++)
                {
                    parametro[i] = new ReportParameter("C" + cont, C[cont], false);
                    cont++;
                }
                //
                this.reportViewer1.LocalReport.SetParameters(parametro);
                //
                this.reportViewer1.RefreshReport();
                this.reportViewer1.SetDisplayMode(DisplayMode.PrintLayout);
            }
        }
    }
}