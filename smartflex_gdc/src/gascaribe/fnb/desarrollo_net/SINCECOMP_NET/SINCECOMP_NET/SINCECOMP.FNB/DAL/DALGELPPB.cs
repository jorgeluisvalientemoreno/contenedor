using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.DAL
{
    class DALGELPPB
    {
        static String getList = "DAld_price_list.frfGetRecords"; //lista de precios
        static String copyList = "LD_BOPortafolio.bocopylist"; //copia de lista

        public static DataTable getPriceList()
        {
            DataSet dspricelist = new DataSet("LDPricelist");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(getList))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dspricelist, "LDPricelist");
            }
            return dspricelist.Tables["LDPricelist"];
        }

        public static void procCopyList(Int64 inuprice_list_id, String isbdescription, DateTime idtinitial_date, DateTime idtfinal_date, Int64? insupplier_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(copyList))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbdescription", DbType.String, isbdescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtinitial_date", DbType.DateTime, idtinitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtfinal_date", DbType.DateTime, idtfinal_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "insupplier_id", DbType.Int64, insupplier_id);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Confirmar transacciones
        public static void Save()
        {
            OpenDataBase.Transaction.Commit();
        }
    }
}
