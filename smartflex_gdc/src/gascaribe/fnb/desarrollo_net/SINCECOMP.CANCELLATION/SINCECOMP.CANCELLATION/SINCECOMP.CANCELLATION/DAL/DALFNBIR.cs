using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace SINCECOMP.CANCELLATION.DAL
{
    class DALFNBIR
    {
        static String queryFNBIR = "LD_BONONBANKFINANCING.frcGetDataCancelReq"; //busqueda

        //CONSULTAR
        public static DataTable searchReport(String inupackagesale, String inupackageannu, String inuorder, String inucausal, Nullable<DateTime> idtminsaledate,
            Nullable<DateTime> idtmaxsaledate, Nullable<DateTime> idtmindateannu, Nullable<DateTime> idtmaxdateannu, String inuidenttype, String isbindentific, String inususccodi)
        {
            DataSet dsquery = new DataSet("LDQuery");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryFNBIR))
            {
                if (String.IsNullOrEmpty(inupackagesale))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackagesale", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackagesale", DbType.Int64, Convert.ToInt64(inupackagesale));
                
                if (String.IsNullOrEmpty(inupackageannu))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackageannu", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inupackageannu", DbType.Int64, Convert.ToInt64(inupackageannu));
                
                if (String.IsNullOrEmpty(inuorder))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, Convert.ToInt64(inuorder));
                
                if (String.IsNullOrEmpty(inucausal))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucausal", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucausal", DbType.Int64, Convert.ToInt64(inucausal));
                
                // Fecha mínima de venta
                if (idtminsaledate.GetHashCode() == 0)
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtminsaledate", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtminsaledate", DbType.DateTime, idtminsaledate.ToString());
                
                // Fecha máxima de venta
                if (idtmaxsaledate.GetHashCode() == 0)
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmaxsaledate", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmaxsaledate", DbType.DateTime, idtmaxsaledate.ToString());
                
                // Fecha mínimia de anulación
                if (idtmindateannu.GetHashCode() == 0)
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmindateannu", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmindateannu", DbType.DateTime, idtmindateannu.ToString());
                
                // Fecha máxima de anulación
                if (idtmaxdateannu.GetHashCode() == 0)
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmaxdateannu", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "idtmaxdateannu", DbType.DateTime, idtmaxdateannu.ToString());
                

                if (String.IsNullOrEmpty(inuidenttype))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuidenttype", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuidenttype", DbType.Int64, inuidenttype);
                
                if (String.IsNullOrEmpty(isbindentific))
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbindentific", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbindentific", DbType.String, isbindentific);
                
                if (String.IsNullOrEmpty(inususccodi))
                    OpenDataBase.db.AddInParameter(cmdCommand, "inususccodi", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inususccodi", DbType.Int64, Convert.ToInt64(inususccodi));
                
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsquery, "LDQuery");
            }
            return dsquery.Tables["LDQuery"];
        }

        /***************************************************************************
        Historia de Modificaciones
        Fecha            Autor         Modificacion
        =========       =========      ====================
        25/09/2014      Llozada        Se agrega el parámetro de observación
        ***************************************************************************/
        public static void LegAnnulmentOrder(Int64 orderId, Int64 opcion, String LegString, String Observation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.LegAnnulmentOrder"))
            {
                 
                OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuopcion", DbType.Int64, opcion);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbcad", DbType.String, LegString);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObservation", DbType.String, Observation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }


        public static void LegApplAnnulOrder(Int64 orderId, String LegString)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.LegApplAnnulOrder"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbcad", DbType.String, LegString);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }






    }
}
