using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

using OpenSystems.Common.ExceptionHandler;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.DAL
{
    class DALFIUTC
    {
        public TransferQuota getTrasnferQuotaData(Int64 subscriptionId)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.getTransferData"))
            {
               
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubscription", DbType.Int64, subscriptionId);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuId", DbType.Int64, 20);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbName", DbType.String, 300);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuQuota", DbType.Double, 20);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    Int64 id = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuId"));
                    String name = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbName"));
                    Double quota = Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "onuQuota"));

                    TransferQuota transfer = new TransferQuota(id, subscriptionId, name, quota);


                return transfer;
            }
        }

        public void RegisterTransferQuota(Int64 destinySubscripId, Int64 originSubcripId, Double trasnferValue, DateTime finalDate, String observation)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.addDataTransferQuota"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrigSubcripId", DbType.Int64, originSubcripId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDestSubscripId", DbType.Int64, destinySubscripId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtTransferDate", DbType.DateTime, finalDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtFinalDate", DbType.DateTime, finalDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTrasnferValue", DbType.Int64, trasnferValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObservation", DbType.String, observation);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }



        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }

        public String AttendApprovalTransferQuote(Int64 orderId, Boolean exito)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.AttendApprovalTransferQuote"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderId", DbType.Int64, orderId);
                OpenDataBase.db.AddInParameter(cmdCommand, "iblExito", DbType.Boolean, exito);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFlag", DbType.String,20 );
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

               return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFlag"));
            
            }
        }

        public void validationsTrasferQuota(Int64 inuSuscripcAct, Double inuQuotaTransfer, Int64 inuSuscripCode, Int64 identTypeCosigner, String identCosigner, String isbSubsList)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.validationsTrasferQuota"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscripcAct", DbType.Int64, inuSuscripcAct);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuQuotaTransfer", DbType.Double, inuQuotaTransfer);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscripCode", DbType.Int64, inuSuscripCode);
                OpenDataBase.db.AddInParameter(cmdCommand, "identTypeDebtor", DbType.Int64, identTypeCosigner);
                OpenDataBase.db.AddInParameter(cmdCommand, "identCosigner", DbType.Int64, identCosigner);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbSubsList", DbType.String, isbSubsList);        
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);                
            }
        }

        /// <summary>
        /// Limpia Cache asociada a la Tabla PL de Quota de Transferencia 
        /// </summary>
        public void clearCache()
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.ClearCache"))
                {
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                }

            }
            catch (Exception)
            {

                throw;
            }

        }


        //Inicio 200-854
        public void PROPAGAREUNICOTRASCUPO(Int64 inuContratodeudor, 
                                           Int64 inuContratoCodeudor,
                                           Int64 inuTipoIdentificacionCodeudor,
                                           String inuIdentificacionCodeudor, 
                                           Int64 inuContratoFIUTC,
                                           out Int64 onucontatocodeudor,
                                           out Int64 onucodigoerror, 
                                           out String osbmensaje)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.PROPAGAREUNICOTRASCUPO"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratodeudor", DbType.Int64, inuContratodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratoCodeudor", DbType.Int64, inuContratoCodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoIdentificacionCodeudor", DbType.Int64, inuTipoIdentificacionCodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentificacionCodeudor", DbType.Int64, inuIdentificacionCodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratoFIUTC", DbType.Int64, inuContratoFIUTC);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onucontatocodeudor", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onucodigoerror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbmensaje", DbType.String, 300);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onucontatocodeudor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onucontatocodeudor"));
                onucodigoerror = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onucodigoerror"));
                osbmensaje = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbmensaje"));
            }
        }
        //Fin 200-854

    }
}
