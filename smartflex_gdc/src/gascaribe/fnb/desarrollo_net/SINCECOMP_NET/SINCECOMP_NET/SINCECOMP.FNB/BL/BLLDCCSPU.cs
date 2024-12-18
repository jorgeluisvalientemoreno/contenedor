using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;
using System.Data;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.BL
{
    class BLLDCCSPU
    {
        public static DataTable deudorSearch(Int64 searchId)
        {
            return DALLDCCSPU.FtrfPromissoryLDCCSPU(searchId, "D", "");
        }
        public static DataTable codeudorSearch(Int64 searchId)
        {
            return DALLDCCSPU.FtrfPromissoryLDCCSPU(searchId, "C", "");
        }
    }
}
