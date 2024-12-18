using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLCCPU
    {

        public static DataTable FtrfChanges(Int64 nuPackageId)
        {
            return DAL.DALCCPU.FtrfChanges(nuPackageId);
        }
    }
}
