using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{

    public class DALBINCENCOSUD
    {
        //CASO 200-850 Proveedor CENCOSUD
        public static DataSet FtrfBineCENCOSUD(String FindRequest)
        {
            DataSet DSineCENCOSUD = new DataSet("BineOlimpica");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOPortafolio.frfGetBineCENCOSUD"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrder", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSineCENCOSUD, "BineOlimpica");
            }

            return DSineCENCOSUD;
        }
        //CASO 200-850 Proveedor CENCOSUD

    }

}
