using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
namespace SINCECOMP.FNB.DAL
{
    class DALLDCCSPU
    {
        public static DataTable FtrfPromissoryLDCCSPU(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            DataSet DSpromissory = new DataSet("promissory");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FtrfPromissoryLDCCSPU"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory");
            }
            return DSpromissory.Tables["promissory"];
        }

        public static DataTable FRTDATOSSOLICITUPAGAREUNICO(String FindRequest)
        {
            DataSet DSSaleFNB = new DataSet("GeneralFNB");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FRTDATOSSOLICITUPAGAREUNICO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "GeneralFNB");
            }
            return DSSaleFNB.Tables["GeneralFNB"];
        }

        public static DataTable FRTPAGUNIDAT(String FindRequest)
        {
            DataSet DSAGUNIDAT = new DataSet("LDCPAGUNIDAT");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FRTPAGUNIDAT"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSAGUNIDAT, "LDCPAGUNIDAT");
            }
            return DSAGUNIDAT.Tables["LDCPAGUNIDAT"];
        }

    }
}
