using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportSource;
using System.Data.Common;
using OpenSystems.Common.Data;
using ldrpass;
using SINCECOMP.FNB.BL;

namespace SINCECOMP.FNB.UI
{
    public partial class LDRPAGARE : Form
    {
        String FindRequest;
        String Error;

        public LDRPAGARE(String findRequest)
        {
            InitializeComponent();

            /*Recuperar String de conexion a DB OPEN*/
            string connectionString = OpenDataBase.ConnectionString;
            char[] separador = new char[1];
            separador[0] = ';';
            string[] connectStringValues = connectionString.Split(separador);
            string userName = connectStringValues[0];
            userName = userName.Substring(userName.IndexOf("=") + 1);
            string passwd = connectStringValues[1];
            passwd = passwd.Substring(passwd.IndexOf("=") + 1);
            string database = connectStringValues[2];
            string Pagare;
            database = database.Substring(database.IndexOf("=") + 1);
            FindRequest = findRequest;
            ConnectionInfo ci = new ConnectionInfo();
            BLGENERAL general = new BLGENERAL();

            ci.ServerName = database;
            ci.DatabaseName = database;

            /*Recuperar String de conexion a DLL ldrpass*/
            Get_parameters Getdatos = new Get_parameters();

            ci.UserID = Getdatos.User();
            ci.Password = Getdatos.Password();

            Pagare = general.getParam("NOMBRE_PAGARE_FNB", "String").ToString();

            //DLRPAGARE.Resources.Reporte crystalrpt = new DLRPAGARE.Resources.Reporte();

            if (Pagare == "DLRPAGAREGDC")
            {
                DLRPAGAREGDC.Resources.Reporte crystalrpt = new DLRPAGAREGDC.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                //CASO 200-1564
                //crystalrpt.SetParameterValue("Tipo_Pagare", 6);
                //CASO 200-1564

                crystalrpt.SetParameterValue("Num_Solicitud_D", FindRequest);
                crystalrpt.SetParameterValue("Contrato", -1);
                crystalrpt.SetParameterValue("Num_venta", -1);

                crystalReportViewer1.ReportSource = crystalrpt;
            }
            else if (Pagare == "DLRPAGAREEFG")
            {
                DLRPAGAREEFG.Resources.Reporte crystalrpt = new DLRPAGAREEFG.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                //CASO 200-1564
                //crystalrpt.SetParameterValue("Tipo_Pagare", 6);
                //CASO 200-1564

                crystalrpt.SetParameterValue("Num_Solicitud_D", FindRequest);
                crystalrpt.SetParameterValue("Contrato", -1);
                crystalrpt.SetParameterValue("Num_venta", -1);

                crystalReportViewer1.ReportSource = crystalrpt;
            }
            else if (Pagare == "DLRPAGARESUR")
            {
                DLRPAGARESUR.Resources.Reporte crystalrpt = new DLRPAGARESUR.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                crystalrpt.SetParameterValue("Num_Solicitud_D", FindRequest);
                crystalrpt.SetParameterValue("Contrato", -1);
                crystalrpt.SetParameterValue("Num_venta", -1);

                crystalReportViewer1.ReportSource = crystalrpt;
            }
            else
            {
                DLRPAGARE.Resources.Reporte crystalrpt = new DLRPAGARE.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                crystalrpt.SetParameterValue("Num_Solicitud_D", FindRequest);
                crystalrpt.SetParameterValue("Contrato", -1);
                crystalrpt.SetParameterValue("Num_venta", -1);

                crystalReportViewer1.ReportSource = crystalrpt;
            };
           
            //rptDLRPAGARE crystalrpt = new rptDLRPAGARE();
            crystalReportViewer1.Refresh();
            

            //crystalrpt.PrintOptions.PaperSize = PaperSize.Paper10x14;
            //crystalrpt.PrintOptions.PaperSource = PaperSource.Auto;
            
            /*Se setean los margenes*/
            //PageMargins margins;
            //margins = crystalrpt.PrintOptions.PageMargins;
            //margins.bottomMargin = 90;
            //margins.leftMargin = 70;
            //margins.rightMargin = 70;
            //margins.topMargin = 200;
            //crystalrpt.PrintOptions.ApplyPageMargins(margins);

            /*Se indica el reporte del crviewer*/
            
            //crystalReportViewer1.Width = 1500;
        }
    }
}
