using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.SUBSIDYS.DAL;

namespace SINCECOMP.SUBSIDYS.BL
{
    class BLLDLTP
    {

        DALLDLTP queryDAL = new DALLDLTP ();

        public String setandgetQuery(Int64 inucoempadi)
        {
            return queryDAL.setandgetQuery(inucoempadi);
        }

    }
}
