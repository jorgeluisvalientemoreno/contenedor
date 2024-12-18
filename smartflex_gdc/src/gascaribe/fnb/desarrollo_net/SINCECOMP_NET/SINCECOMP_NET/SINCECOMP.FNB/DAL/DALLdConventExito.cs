using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{
    public class DALLdConventExito
    {
        public static DataSet FtrfBineExito(String FindRequest)
        {
            DataSet DSineExito = new DataSet("BineOlimpica");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOPortafolio.frfGetBineExito"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrder", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSineExito, "BineOlimpica");
            }

            return DSineExito;
        }

    }
}
