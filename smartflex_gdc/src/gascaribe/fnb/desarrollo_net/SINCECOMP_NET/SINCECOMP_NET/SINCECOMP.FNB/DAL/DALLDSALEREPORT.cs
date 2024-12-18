using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{
    class DALLDSALEREPORT
    {
        public static DataTable FtrfSaleFNB(String FindRequest)//(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {

            DataSet DSSaleFNB = new DataSet("SaleFNB");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOPORTAFOLIO.frfGetSaleFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                //OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                //OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "SaleFNB");
            }

            return DSSaleFNB.Tables["SaleFNB"];

        }
    }
}
