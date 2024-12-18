using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLLDINS
    {
        //buscar notificaciones
        public static List<RequestLDINS> fcuNotification(Decimal inuseller, Decimal inupackage, Decimal inustatus, DateTime inuregisterdate,
            Decimal inunotificationid, Decimal inupackagetype)
        {
            List<RequestLDINS> ListNotification = new List<RequestLDINS>();
            DataTable TBNotification = DALLDINS.searchNotification(inuseller, inupackage, inustatus, inuregisterdate, inunotificationid, inupackagetype);
            if (TBNotification != null)
            {
                foreach (DataRow row in TBNotification.Rows)
                {
                    RequestLDINS vNotification = new RequestLDINS(row);
                    ListNotification.Add(vNotification);
                }
            }
            return ListNotification;
        }

    }
}
