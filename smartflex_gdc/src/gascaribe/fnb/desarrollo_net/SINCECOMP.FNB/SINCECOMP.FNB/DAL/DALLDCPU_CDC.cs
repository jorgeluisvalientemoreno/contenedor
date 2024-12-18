using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace SINCECOMP.FNB.DAL
{
    class DALLDCPU_CDC
    {

        public static DataTable FtrfDeudor(String FindRequest)
        {

            DataSet DSSaleFNB = new DataSet("Deudor");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKREPORTEFIFAP.frfDetallePUDeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Num_solicitud_D", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddInParameter(cmdCommand, "Contrato", DbType.Int64, -1);
                OpenDataBase.db.AddInParameter(cmdCommand, "Num_venta", DbType.Int64, -1);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "Deudor");
            }

            return DSSaleFNB.Tables["Deudor"];

        }

        public static DataTable FtrfCodeudor(String FindRequest)
        {

            DataSet DSSaleFNB = new DataSet("Codeudor");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKREPORTEFIFAP.frfDetallePUCoDeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "Num_solicitud_D", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddInParameter(cmdCommand, "Contrato", DbType.Int64, -1);
                OpenDataBase.db.AddInParameter(cmdCommand, "Num_venta", DbType.Int64, -1);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "Codeudor");
            }

            return DSSaleFNB.Tables["Codeudor"];

        }

    }
}
