using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.BL
{
    class blFIUTC
    {
        DALFIUTC _DALFIUTC = new DALFIUTC(); 
       
        public TransferQuota getTrasnferQuotaData(Int64 subscriptionId)
        {
            return _DALFIUTC.getTrasnferQuotaData(subscriptionId); 
        }

        public void RegisterTransferQuota(Int64 destinySubscripId, Int64 originSubcripId, Double trasnferValue, DateTime finalDate, Int64 PackegeId, String observation)
        {
            _DALFIUTC.RegisterTransferQuota(destinySubscripId, originSubcripId, trasnferValue, finalDate, observation);
        }

        public String AttendApprovalTransferQuote(Int64 OrderId, Boolean exito)
        {
            return _DALFIUTC.AttendApprovalTransferQuote(OrderId, exito);
        }

        public void validationsTrasferQuota(Int64 inuSuscripcAct, Double inuQuotaTransfer, Int64 inuSuscripCode, Int64 identTypeDebtor, String identDeudor, String isbSubsList)
        {
            _DALFIUTC.validationsTrasferQuota(inuSuscripcAct, inuQuotaTransfer, inuSuscripCode, identTypeDebtor, identDeudor, isbSubsList);
        }

        public void doCommit()
        {
            _DALFIUTC.doCommit();
        }

        public void clearCache()
        {
            _DALFIUTC.clearCache();

        }
        
        //Inicio 200-854
        public void PRGETINFOCODEUDOR(Int64 inuContratodeudor,
                                           Int64 inuContratoCodeudor,
                                           Int64 inuTipoIdentificacionCodeudor,
                                           String inuIdentificacionCodeudor,
                                           Int64 inuContratoFIUTC,
                                           out Int64 onucontatocodeudor,
                                           out Int64 onucodigoerror,
                                           out String osbmensaje)
        {
            _DALFIUTC.PROPAGAREUNICOTRASCUPO(inuContratodeudor, 
                                           inuContratoCodeudor,
                                           inuTipoIdentificacionCodeudor,
                                           inuIdentificacionCodeudor, 
                                           inuContratoFIUTC,
                                           out onucontatocodeudor,
                                           out onucodigoerror, 
                                           out osbmensaje);
        }
        //Fin 200-854

    }
}
