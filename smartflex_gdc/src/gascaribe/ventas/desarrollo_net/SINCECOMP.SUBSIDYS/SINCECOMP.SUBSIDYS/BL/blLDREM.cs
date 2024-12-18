using System;
using System.Collections.Generic;
using System.Data;
using SINCECOMP.SUBSIDYS.DAL;
using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.BL
{
    class blLDREM
    {
        dalLDREM DLLDREM = new dalLDREM();

        public static List<subsidy> fcuSubsidy()
        {
            List<subsidy> Listsubsidy = new List<subsidy>();
            DataTable TBsubsidy = dalLDREM.getSubsidy();
            if (TBsubsidy != null)
            {
                foreach (DataRow row in TBsubsidy.Rows)
                {
                    subsidy vsubsidy = new subsidy(row);
                    Listsubsidy.Add(vsubsidy);
                }
            }
            return Listsubsidy;
        }

        public Boolean FblDistrRemainSubsidy(Int64 inuAsigSubsidyId, Int64 inValueDistributing, String inustate_delivery, Int64 onuErrorCode, String osbErrorMessage)
        {
            return DLLDREM.FblDistrRemainSubsidy(inuAsigSubsidyId, inValueDistributing, inustate_delivery, onuErrorCode, osbErrorMessage);
        }

        public void updSubsidyRemain(List<Int64> subsidyList, bool simulation)
        {
            foreach (Int64 subsidyId in subsidyList)
            {
                DLLDREM.updSubsidyRemain(subsidyId, simulation ? "SI" : "DI");
            }
        }

        public void persistSimulation()
        {
            DLLDREM.persistSimulation();
        }
    }
}
