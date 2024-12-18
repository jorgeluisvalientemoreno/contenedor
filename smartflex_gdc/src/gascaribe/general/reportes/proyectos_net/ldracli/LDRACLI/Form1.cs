using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportSource;
using System.Data.Common;
using LDRACLI.Resources;
using ldrpass;

namespace LDRACLI
{
    public partial class Form1 : OpenForm
    {
        public Form1()
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
            database = database.Substring(database.IndexOf("=") + 1);

            ConnectionInfo ci = new ConnectionInfo();

            ci.ServerName = database;
            ci.DatabaseName = database;

            /*Recuperar String de conexion a DLL ldrpass*/
            Get_parameters Getdatos = new Get_parameters();

            ci.UserID = Getdatos.User();
            ci.Password = Getdatos.Password();



            Reporte crystalrpt = new Reporte();
            crystalrpt.Load(crystalrpt.FileName);

            //crystalrpt.SetDatabaseLogon(userName, passwd, database, database); //Deprecate

            foreach (CrystalDecisions.CrystalReports.Engine.Table tbl in crystalrpt.Database.Tables)
            {
                TableLogOnInfo logon = tbl.LogOnInfo;
                logon.ConnectionInfo = ci;
                tbl.ApplyLogOnInfo(logon);
            }

            crystalReportViewer1.ReportSource = crystalrpt;
            crystalReportViewer1.Refresh();
        }
    }
}
