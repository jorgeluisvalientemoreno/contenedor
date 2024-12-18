using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.BL
{
    class BLFIACM
    {

        public static void insertQuota(Int64 inumanual_quota_id, Int64 inusubscription_id, Int64 inuquotavalue, DateTime inuinitial_date,
            String inufinal_date, String inusupport_file, String inuobservation, String inuprint_in_bill)
        {
            DALFIACM.insertQuota(inumanual_quota_id, inusubscription_id, inuquotavalue, inuinitial_date, inufinal_date, inusupport_file, inuobservation, inuprint_in_bill);
        }

        public static Int64 consExtraQuota()
        {
            return DALFIACM.consManualQuota();
        }

        public static void Save()
        {
            DALFIACM.Save();
        }

        public static void getManualQuota(Int64 subscripcion, DateTime inInitial_date, String inFinal_date, out Double quota, out DateTime? initialDate, out DateTime? finalDate)
        {
            DALFIACM.getManualQuota(subscripcion, inInitial_date, inFinal_date, out quota, out initialDate, out finalDate);

        }
    }
}
