using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGELPPB
    {
        public static DataRow[] priceList(String userId, String typeUser, String ListId)
        {
            //String condition = "supplier_id=" + userId;
            String condition = "price_list_id=" + ListId;
            DataTable dataPriceList = DALGELPPB.getPriceList();
            
                return dataPriceList.Select(condition);
        }

        //procesar copia de lista
        public static void procCopyList(Int64 inuprice_list_id, String isbdescription, DateTime idtinitial_date, DateTime idtfinal_date, Int64? insupplier_id)
        {
            DALGELPPB.procCopyList(inuprice_list_id, isbdescription, idtinitial_date, idtfinal_date, insupplier_id);
        }

    }
}
