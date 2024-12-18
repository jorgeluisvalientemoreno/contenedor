using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLLDSALEREPORT
    {

        public static List<ReportSaleFNB> FlistSaleFNB(String FindRequest)//(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            //Boolean blControl = true;
            List<ReportSaleFNB> ListSaleFNB = new List<ReportSaleFNB>();
            DataTable TBSaleFNB = DALLDSALEREPORT .FtrfSaleFNB (FindRequest);//(nuPackageId, sbPromissoryTypeDebtor, sbPromissoryTypeCosigner);
            if (TBSaleFNB != null)
            {
                foreach (DataRow row in TBSaleFNB.Rows)
                {
                    ReportSaleFNB RowTBSaleFNB = new ReportSaleFNB(row);//, blControl); //blControl
                    ListSaleFNB.Add(RowTBSaleFNB);
                    //blControl = false;
                }
            }
            return ListSaleFNB;
        }
    }
}
