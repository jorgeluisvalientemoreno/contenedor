using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.FNB.BL;
using Microsoft.Reporting.WinForms;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.UI
{
    public partial class LDRVOUCHER_GDC : Form
    {

        String FindRequest;
        Int64 CodeVoucher;
        BLGENERAL general = new BLGENERAL();

        public LDRVOUCHER_GDC(String findRequest, Int64 codeVoucher)
        {
            InitializeComponent();
            FindRequest = findRequest;
            CodeVoucher = codeVoucher;
        }

        private void LDRVOUCHER_GDC_Load(object sender, EventArgs e)
        {
            String edad = "0";
            String deudor = "";
            String codeudor = "";
            String a0 = "";
            String a1 = "";
            String a2 = "";
            String a3 = "";
            String a4 = "";
            String a5 = "";
            String a6 = "";
            String a7 = "";
            String a8 = "";
            String a9 = "";
            String a10 = "";
            String a11 = "";
            String a12 = "";
            String a13 = "";
            String a14 = "";
            String a15 = "";
            String a16 = "";
            String a17 = "";
            String a18 = "";
            String a19 = "";
            String a20 = "";
            String a21 = "";
            String a22 = "";
            String a23 = "";
            String c0 = "";
            String c1 = "";
            String c2 = "";
            String c3 = "";
            datosAdicionalBindingSource.DataSource = BLLDRVOUCHER_GDC.FtrfAdicional(FindRequest, CodeVoucher, out edad, out deudor, out a0, out a1, out a2, out a3, out a4, out a5, out a6, out a7, out a8, out a9, out a10, out a11, out a12, out a13, out a14, out a15, out a16, out a17, out a18, out a19, out a20, out a21, out a22, out a23);
            if (datosAdicionalBindingSource.Count == 0)
            {
                general.mensajeERROR("No existe ninguna Solicitud asociada a este consecutivo");
                this.Close();
            }
            else
            {
                datosComandoBindingSource.DataSource = BLLDRVOUCHER_GDC.FtrfComando(FindRequest, out codeudor, out c0, out c1, out c2, out c3);
                //
                ReportParameter[] parametro = new ReportParameter[29]; 
                //
                if (Int64.Parse(edad) <= 75)
                {
                    parametro[0] = new ReportParameter("rpt_nombre", deudor, false); 
                    //general.mensajeERROR(edad + " " + deudor);
                }
                else
                {
                    parametro[0] = new ReportParameter("rpt_nombre", codeudor, false); 
                    //general.mensajeERROR(edad + " " + codeudor);
                }
                //
                parametro[1] = new ReportParameter("rpt_0", a0, false);
                parametro[2] = new ReportParameter("rpt_1", a1, false);
                parametro[3] = new ReportParameter("rpt_2", a2, false);
                parametro[4] = new ReportParameter("rpt_3", a3, false);
                parametro[5] = new ReportParameter("rpt_4", a4, false);
                parametro[6] = new ReportParameter("rpt_5", a5, false);
                parametro[7] = new ReportParameter("rpt_6", a6, false);
                parametro[8] = new ReportParameter("rpt_7", a7, false);
                parametro[9] = new ReportParameter("rpt_8", a8, false);
                parametro[10] = new ReportParameter("rpt_9", a9, false);
                parametro[11] = new ReportParameter("rpt_10", a10, false);
                parametro[12] = new ReportParameter("rpt_11", a11, false);
                parametro[13] = new ReportParameter("rpt_12", a12, false);
                parametro[14] = new ReportParameter("rpt_13", a13, false);
                parametro[15] = new ReportParameter("rpt_14", a14, false);
                parametro[16] = new ReportParameter("rpt_15", a15, false);
                parametro[17] = new ReportParameter("rpt_16", a16, false);
                parametro[18] = new ReportParameter("rpt_17", a17, false);
                parametro[19] = new ReportParameter("rpt_18", a18, false);
                parametro[20] = new ReportParameter("rpt_19", a19, false);
                parametro[21] = new ReportParameter("rpt_20", a20, false);
                parametro[22] = new ReportParameter("rpt_21", a21, false);
                parametro[23] = new ReportParameter("rpt_22", a22, false);
                parametro[24] = new ReportParameter("rpt_23", a23, false);
                parametro[25] = new ReportParameter("rpt_c0", c0, false);
                parametro[26] = new ReportParameter("rpt_c1", c1, false);
                parametro[27] = new ReportParameter("rpt_c2", c2, false);
                parametro[28] = new ReportParameter("rpt_c3", c3, false); 
                //
                this.reportViewer1.LocalReport.SetParameters(parametro);
                //
                this.reportViewer1.RefreshReport();
            }
        }



    }
}
