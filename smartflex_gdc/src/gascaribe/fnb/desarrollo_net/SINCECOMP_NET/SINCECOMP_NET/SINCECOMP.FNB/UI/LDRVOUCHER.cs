//using System;
//using System.Collections.Generic;
//using System.ComponentModel;
//using System.Data;
//using System.Drawing;
//using System.Text;
//using System.Windows.Forms;
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
    public partial class LDRVOUCHER : Form
    {

        String FindRequest;
        String Error;

        public LDRVOUCHER(String findRequest, Int64 inuVoucher)
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

            Pagare = general.getParam("PAGARE_VOUCHER_FIFAP", "String").ToString();

            //DLRPAGARE.Resources.Reporte crystalrpt = new DLRPAGARE.Resources.Reporte();

            if (Pagare == "DLRVOUCHERGDC")
            {
                DLRVOUCHERGDC.Resources.Reporte crystalrpt = new DLRVOUCHERGDC.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                crystalrpt.SetParameterValue("SOLICITUD", Convert.ToInt64(FindRequest));
                crystalrpt.SetParameterValue("VOUCHER", inuVoucher);

                crystalReportViewer1.ReportSource = crystalrpt;
            }
            else if (Pagare == "DLRVOUCHEREFG")
            {
                DLRVOUCHEREFG.Resources.Reporte crystalrpt = new DLRVOUCHEREFG.Resources.Reporte();
                crystalrpt.Load(crystalrpt.FileName);

                foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
                {
                    TableLogOnInfo logon = tbl.LogOnInfo;
                    logon.ConnectionInfo = ci;
                    tbl.ApplyLogOnInfo(logon);
                }

                crystalrpt.SetParameterValue("SOLICITUD", Convert.ToInt64(FindRequest));
                crystalrpt.SetParameterValue("VOUCHER", inuVoucher);

                crystalReportViewer1.ReportSource = crystalrpt;
            }

            //rptDLRPAGARE crystalrpt = new rptDLRPAGARE();
            crystalReportViewer1.Refresh();
        
        }
    }
}
