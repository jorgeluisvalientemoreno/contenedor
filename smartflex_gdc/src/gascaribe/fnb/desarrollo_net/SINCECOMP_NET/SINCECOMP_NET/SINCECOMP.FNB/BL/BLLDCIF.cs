using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;
using System.Data;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.BL
{
    class BLLDCIF
    {
        public static DataTable deudorSearch(Int64 searchId)
        {
            return DALLDCIF.FtrfPromissory(searchId, "D", "");
        }
        public static DataTable codeudorSearch(Int64 searchId)
        {
            return DALLDCIF.FtrfPromissory(searchId, "C", "");
        }

        // ABaldovino RQ 6478
        /// Actualiza informacion del deudor
        /// </summary>
        /// <param name="subscriberId">Código del cliente de la suscripción</param>
        /// <param name="promissory">Información del deudor</param>
        public static void EditPromissory(Int64? packageId, Promissory promissory)
        {
            DALLDCIF.EditPromissory(packageId,  promissory);
        }

        // ABaldovino RQ 6478
        /// Valida contratista del punto de atencion actual
        /// </summary>
        /// <param name="package_Id">Solicitud</param>        
        public static Boolean fnuValidateContract(Int64? packageId)
        {
            Int64 nuContractPkg;

            nuContractPkg =  DALLDCIF.fnuValidateContract(packageId);

            if (nuContractPkg == 1)
            {
                return true;
            }
            else {
                return false;
            }
        }


        /*
        public static DataTable codeudorAditional(Int64 searchId)
        {
            return DALLDCIF.FtrfAditional(searchId, "D", "");
        }
        public static DataTable deudorAditional(Int64 searchId)
        {
            return DALLDCIF.FtrfAditional(searchId, "C", "");
        }*/

    }
}
