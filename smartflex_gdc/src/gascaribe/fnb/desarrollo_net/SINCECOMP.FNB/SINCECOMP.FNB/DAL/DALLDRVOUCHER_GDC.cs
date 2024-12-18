using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace SINCECOMP.FNB.DAL
{
    class DALLDRVOUCHER_GDC
    {

        public static DataTable FtrfAdicional(String FindRequest, Int64 CodeVoucher)
        {

            DataSet DSSaleFNB = new DataSet("Adicional");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKREPORTEFIFAP.frfDetalleVOUCHERDeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "SOLICITUD", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddInParameter(cmdCommand, "VOUCHER", DbType.Int64, CodeVoucher);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "Adicional");
            }

            return DSSaleFNB.Tables["Adicional"];

        }

        public static DataTable FtrfComando(String FindRequest)
        {

            DataSet DSSaleFNB = new DataSet("Comando");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKREPORTEFIFAP.frfDetalleVOUCHERCoDeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "SOLICITUD", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "Comando");
            }

            return DSSaleFNB.Tables["Comando"];

        }

    }
}
