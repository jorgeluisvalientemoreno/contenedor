using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.CONSTRUCTIONUNITS.DAL;
using SINCECOMP.CONSTRUCTIONUNITS.Entity;
// Librerías sistema
using System.Data;
using System.Data.Common;

// Librerías OpenSystems
using OpenSystems.Common.Data;

namespace SINCECOMP.CONSTRUCTIONUNITS.BL
{
    class BLLDEFC
    {
        public static List<LdCreg> FcuBLCreg(Int64 nuTypeQuery, Int64 nuYear, String sbDescrelevantmarket, String DescConstructUnit)
        {
            List<LdCreg> ListCreg = new List<LdCreg>();

            DataTable TBCREG = DALLDEFC.ExpressionReferenceRecordsProLDCreg(nuTypeQuery,nuYear,sbDescrelevantmarket,DescConstructUnit);

            if (TBCREG != null)
            {
                foreach (DataRow row in TBCREG.Rows)
                {
                    LdCreg vCREG = new LdCreg(row);
                    ListCreg.Add(vCREG);

                }
            }

            return ListCreg;
        }

        internal List<LdCreg> BLLdCreg()
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
