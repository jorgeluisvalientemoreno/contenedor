using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;
//

namespace SINCECOMP.FNB.DAL
{
    class DALGEPLPB
    {
        static String printList = "LD_BOPortafolio.frfGetPrintPriceList";
        static String addPrintList = "LD_BCPortafolio.FnuAmountPrintOuts";

        public static DataTable getPrintPriceList(String inuCondition, String inuContractor, String inuSupplier)
        {
            DataSet dsprintpricelist = new DataSet("LDPriceList");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(printList))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCondition", DbType.String, inuCondition);
                OpenDataBase.db.AddInParameter(cmdCommand, "inContratista", DbType.String, inuContractor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProveedor", DbType.String, inuSupplier);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsprintpricelist, "LDPriceList");
            }
            return dsprintpricelist.Tables["LDPriceList"];
        }

        public static Int64? addPrintPriceList(Int64 nupricelistid)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(addPrintList))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nupricelistid", DbType.String, nupricelistid);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                if (Convert.IsDBNull(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"))==true)
                    return null;
                else
                    return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //guardar cambios
        public static void Save()
        {
            OpenDataBase.Transaction.Commit();
        }
    }
}
