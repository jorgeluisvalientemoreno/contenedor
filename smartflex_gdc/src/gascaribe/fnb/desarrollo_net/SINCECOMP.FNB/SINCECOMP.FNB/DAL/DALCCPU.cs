using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace SINCECOMP.FNB.DAL
{
    class DALCCPU
    {

        public static DataTable FtrfChanges(Int64 nuPackageId)
        {
            DataSet DSchanges = new DataSet("changes");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(BL.BLConsultas.reportChanges))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSchanges, "changes");
            }
            return DSchanges.Tables["changes"];
        }

    }
}
