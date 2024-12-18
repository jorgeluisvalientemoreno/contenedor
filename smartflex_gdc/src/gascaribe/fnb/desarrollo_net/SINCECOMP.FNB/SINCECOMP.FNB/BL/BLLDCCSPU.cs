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

        public static void EditPromissory(Int64 package_id, String promissory_type, String debtorname, String last_name, Int64 forwardingplace, DateTime forwardingdate, DateTime birthdaydate, Int64 propertyphone_id, Int64 movilphone_id, String documento, Int64 pagare, out Int64 osberror, out String osbmsjError)
        {
            DALLDCCSPU.EditPromissory(package_id, promissory_type, debtorname, last_name, forwardingplace, forwardingdate, birthdaydate, propertyphone_id, movilphone_id, documento, pagare, out osberror, out osbmsjError);
        }

        public static void validEditPromissory(Int64 package_id, out Int64 osberror, out String osbmsjError)
        {
            DALLDCCSPU.validEditPromissory(package_id, out osberror, out osbmsjError);
        }
    }
}
