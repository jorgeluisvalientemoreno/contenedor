using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
//
using System.Windows.Forms;

namespace SINCECOMP.FNB.DAL
{
    class DALDRSA
    {
        //nombre de funciones y procedimentos
        static String report = "ld_boliquidation.frfGetReport"; //REport
        static String parReport = "ld_boliquidation.ProcGetParameterRep"; //parametros reporte

        //comisiones
        public static DataTable getReport(String inuliquidationid, String inusubscription_id, String inupackageid, String inuinsuredid, String idtclaimdate, 
            String idtsinesterdate, Int64  inucoveragetype)
        {
            DataSet dsreport = new DataSet("LDreport");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(report))
            {
                //DateTime fecha = Convert .ToDateTime ("20/11/2012");
                if (String.IsNullOrEmpty(inuliquidationid))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuliquidationid", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuliquidationid", DbType.Int64, inuliquidationid);
                if (String.IsNullOrEmpty(inusubscription_id))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubscription_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubscription_id", DbType.Int64, inusubscription_id);
                if(String.IsNullOrEmpty(inupackageid))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackageid", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackageid", DbType.Int64, inupackageid);
                if(String.IsNullOrEmpty(inuinsuredid))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuinsuredid", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuinsuredid", DbType.Int64, inuinsuredid);
                if(idtclaimdate == "01/01/2001")
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtclaimdate", DbType.Date, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtclaimdate", DbType.Date, idtclaimdate);
                if(idtsinesterdate == "01/01/2001")
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtsinesterdate", DbType.Date, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtsinesterdate", DbType.Date, idtsinesterdate);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucoveragetype", DbType.Int64, inucoveragetype);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsreport, "LDreport");
            }
            return dsreport.Tables["LDreport"];
        }

        public static void parametersReport(out String T1, out String T2, out String T3, out String T4, out String T5, out String T6)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(parReport))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbidsigner", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbnamefun", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbheaderletter", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbreview", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbcity", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbuserfrm", DbType.String, 100);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                T1 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbidsigner"));
                T2 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbnamefun"));
                T3 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbheaderletter"));
                T4 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbreview"));
                T5 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbcity"));
                T6 = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "sbuserfrm"));
            }
        }

        
    }
}
