using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.SUBSIDYS.DAL;
//using SINCECOMP.SUBSIDYS.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.SUBSIDYS.BL
{
    class BLLDISU
    {
        public static Boolean readFile(String locationFile)
        {
            return DALLDISU.readFile(locationFile);
        }
    }
}
