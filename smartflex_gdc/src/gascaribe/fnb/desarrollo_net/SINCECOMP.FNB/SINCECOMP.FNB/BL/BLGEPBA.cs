using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
//using SINCECOMP.SUBSIDYS.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGEPBA
    {
        public static Boolean readFile(String locationFile)
        {
            return DALGEPBA.ReadFile(locationFile);
        }
    }
}
