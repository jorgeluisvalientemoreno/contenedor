using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
//
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.BL
{
    class BLLDRSA
    {
        //guardar comisiones
        public static DataTable getReport(String inuliquidationid, String inusubscription_id, String inupackageid, String inuinsuredid, String idtclaimdate,
            String idtsinesterdate, Int64 inucoveragetype)
        {
            return DALDRSA.getReport(inuliquidationid, inusubscription_id, inupackageid, inuinsuredid, idtclaimdate, idtsinesterdate, inucoveragetype);
        }

        //PARAMETROS
        public static void parametersReport(out String T1, out String T2, out String T3, out String T4, out String T5, out String T6)
        {
            DALDRSA.parametersReport(out T1, out T2, out T3, out T4, out T5, out T6);
        }
    }
}
