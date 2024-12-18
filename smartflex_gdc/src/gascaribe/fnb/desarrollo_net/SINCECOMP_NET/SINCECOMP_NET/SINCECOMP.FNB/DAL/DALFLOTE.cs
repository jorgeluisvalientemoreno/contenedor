using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Data;

namespace SINCECOMP.FNB.DAL
{
    class DALFLOTE
    {

        public static DataTable getOrder(Int64? inupackage, Int64? inuorder, Int64? inususccodi, DateTime idtdatemin, DateTime idtdatemax)
        {
            DataSet dsflote = new DataSet("LDQuery");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boflowfnbpack.frfgetdelarticlesleg"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage", DbType.Int64, inupackage);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, inuorder);
                OpenDataBase.db.AddInParameter(cmdCommand, "inususccodi", DbType.Int64, inususccodi);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtdatemin", DbType.DateTime, idtdatemin);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtdatemax", DbType.DateTime, idtdatemax);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsflote, "LDQuery");
            }
            return dsflote.Tables["LDQuery"];
        }

        //Agordillo Cambio.6853
        //Se agrega como parametro adicional el valor real de la venta
        public static void legalizeOrder(Int64 orderId, Int32 causalId, String activitiesChain, Int64 valorRealSale)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boflowfnbpack.LegDelOrder"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucausal", DbType.Int32, causalId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbcad", DbType.String, activitiesChain);
                //Inicio CASO 200-85
                //Bloqueado para no enviar este 4 paremtro debido a que en materiales se modifico el pquete pero en EFIGAS y GDC no existe este 4to parametro
                //OpenDataBase.db.AddInParameter(cmdCommand, "inuValorRealSale", DbType.Int64, valorRealSale);
                //Fin CASO 200-85
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /* RNP156 */
       public static void commentDelOrder(Int64 orderId, String sbComment)
       {
           using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boflowfnbpack.CommentDelOrder"))
           {
               OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
               OpenDataBase.db.AddInParameter(cmdCommand, "isbComment", DbType.String, sbComment);
               OpenDataBase.db.ExecuteNonQuery(cmdCommand);
           }
       }

       public String getParam(String sbParam)
       {
           using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
           {
               OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
               OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
               OpenDataBase.db.ExecuteNonQuery(cmdCommand);

               return (string)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
           }
       }

        // 13-01-2015 KCienfuegos.RNP1224 //
       public static void registerInvoice(Int64 orderId, String invoice)
       {
           using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boflowfnbpack.registerInvoice"))
           {
               OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
               OpenDataBase.db.AddInParameter(cmdCommand, "isbComment", DbType.String, invoice);
               OpenDataBase.db.ExecuteNonQuery(cmdCommand);
           }
       }

    }
}
