using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGEPLPB
    {
        public static DataTable getPrintPriceList(String inuCondition, String inuContractor, String inuSupplier)
        {
            return DALGEPLPB.getPrintPriceList(inuCondition, inuContractor, inuSupplier);
        }

        public static Int64? addPrintPriceList(Int64 nupricelistid)
        {
            return DALGEPLPB.addPrintPriceList(nupricelistid);
        }

        public static void Save()
        {
            DALGEPLPB.Save();
        }
    }
}
