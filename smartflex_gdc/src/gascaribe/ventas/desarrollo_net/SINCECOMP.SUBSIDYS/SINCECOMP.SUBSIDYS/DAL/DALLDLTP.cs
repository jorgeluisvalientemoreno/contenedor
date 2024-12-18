using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class DALLDLTP
    {
        static String functionQuery = "ld_bosubsidy.Fnusetdataandgettemplate";//"Ld_Bosubsidy.Fsbgettemplate";//

        //static String functionQuery_potential = "Ld_boPrintSubsidyLetter.Fsbcurrentpotencial"; //cartas a potenciales
        //Function Fnusetdataandgettemplate(inucoempadi ed_confexme.coemcodi%type)

        public String setandgetQuery(Int64 inucoempadi)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(functionQuery))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucoempadi", DbType.Int64, inucoempadi);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

    }
}
