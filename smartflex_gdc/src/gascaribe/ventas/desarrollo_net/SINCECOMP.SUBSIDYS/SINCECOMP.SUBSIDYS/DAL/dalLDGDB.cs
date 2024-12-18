using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
//using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class dalLDGDB
    {

        public static Int64 FnugetError()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOSUBSIDY.Generatebilldata"))
            {
                String Error1;
                String Error2;
                OpenDataBase.db.AddOutParameter(cmdCommand, @"onuErrorCode", DbType.Int64, 20); //DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.AddOutParameter(cmdCommand, @"osbErrorMessage", DbType.String, 500);//DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Error1 = OpenDataBase.db.GetParameterValue(cmdCommand, @"onuErrorCode").ToString();
                Error2 = OpenDataBase.db.GetParameterValue(cmdCommand, @"osbErrorMessage").ToString();
                //if (!String.IsNullOrEmpty(Error1) && !String.IsNullOrEmpty(Error2))
                if (!String.IsNullOrEmpty(Error1))
                {
                    DALGENERAL general = new DALGENERAL();
                    general.mensaje("Error " + Error1 + " - " + Error2);
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
        }
     
        //Borrar clob temporales
        public static void deletetemp_clob_fact (Int64 nusesion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_BoSubsidy.deletetemp_clob_fact"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inusesion", DbType.Int64, nusesion);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
 
            }
        } 


    }
}
//Ld_BoSubsidy.deletetemp_clob_fact(inusesion)
