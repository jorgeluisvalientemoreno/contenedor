using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.DAL;
using System.Data;

namespace SINCECOMP.FNB.BL
{
    class BLLDOA
    {
        DALGENERAL general = new DALGENERAL();

        //carga de lista de ordenes pendientes
        public List<PendingOrdersLDOA> FcuPendingOrders(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            List<PendingOrdersLDOA> ListPendingOrders = new List<PendingOrdersLDOA>();
            DataTable TBPendingOrders = general .cursorProcedure (Procedure, numField, Type, Campos, Values);
            if (TBPendingOrders != null)
            {
                foreach (DataRow row in TBPendingOrders.Rows)
                {
                    PendingOrdersLDOA vPendingOrders = new PendingOrdersLDOA(row);
                    ListPendingOrders.Add(vPendingOrders);
                }
            }
            return ListPendingOrders;
        }

        //carga de lista de articulos por orden
        public List<ArticleOrderLDOA> FcuArticleOrders(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            List<ArticleOrderLDOA> ListArticleOrders = new List<ArticleOrderLDOA>();
            DataTable TBArticleOrders = general.cursorProcedure(Procedure, numField, Type, Campos, Values);
            if (TBArticleOrders != null)
            {
                foreach (DataRow row in TBArticleOrders.Rows)
                {
                    ArticleOrderLDOA vArticleOrders = new ArticleOrderLDOA(row);
                    ListArticleOrders.Add(vArticleOrders);
                }
            }
            return ListArticleOrders;
        }

        //aprobacion de ordenes de venta
        public void proapprovesaleorder(String Procedure, int numField, String[] Type, String[] Campos, String[] Values)
        {
            general.executeMethod(Procedure, numField, Type, Campos, Values);
        }
    }
}
