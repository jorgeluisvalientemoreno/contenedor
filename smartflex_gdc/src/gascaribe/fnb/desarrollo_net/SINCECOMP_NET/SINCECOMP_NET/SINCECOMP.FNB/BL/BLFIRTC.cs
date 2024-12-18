#region Documentaci�n
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : BLFIRTC
 * Descripcion   : L�gica de Negocio para BLFIRTC
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificaci�n                                                          
 * ===========  ======  ============   ======================================================================
 * 07-Sep-2013  212252  mmira          1 - Se adiciona <getConsecut>.
 *=========================================================================================================*/
#endregion Documentaci�n

using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
//
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.BL
{
    class BLFIRTC
    {
        DALFIRTC _DALFIRTC = new DALFIRTC();

        public static String[] getInformatioUser()
        {
            return DALFIRTC.getInformatioUser();
        }

        public List<ApprovalRequestFIRTC> getTrasnferOrder(int nuOrderApprovList)
        {
            return _DALFIRTC.getTrasnferOrder(nuOrderApprovList);
        }

        public List<TransferOrderInfo> getTrasnferOrderInfo(Int64 inuOrder)
        {
            return _DALFIRTC.getTrasnferOrderInfo(inuOrder); 
        }

        public void RegisterStatusChange(Int64 nuPackageId, Int32 nuStatus, String RequestObservation, String ReviewObservation)
        {
            _DALFIRTC.RegisterStatusChange(nuPackageId, nuStatus, RequestObservation, ReviewObservation); 
        }

        public String getConsecut(Int64 nuPackageId)
        {
            return _DALFIRTC.getConsecut(nuPackageId);
        }

       
    }
}
