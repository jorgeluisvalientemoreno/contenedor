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
    class blLDGDB
    {

        public static Int64 FnugetError()
        {
            return dalLDGDB.FnugetError();
        }

        //Borrar clob temporales
        public static void deletetemp_clob_fact(Int64 nusesion)
        {
            dalLDGDB.deletetemp_clob_fact(nusesion);  
        }
    
    
    }
}
