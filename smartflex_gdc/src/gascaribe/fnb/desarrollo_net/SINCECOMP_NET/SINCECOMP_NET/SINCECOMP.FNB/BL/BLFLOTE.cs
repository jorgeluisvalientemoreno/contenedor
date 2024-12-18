using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using System.Data;
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.BL
{
    class BLFLOTE
    {
        DALFIFAP _DALFLOTE = new DALFIFAP();

        public static List<OrderFILOT> FcuFLOTE(Int64? inupackage, Int64? inuorder, Int64? inususccodi, DateTime idtdatemin, DateTime idtdatemax)
        {
            List<OrderFILOT> ListFLOTE = new List<OrderFILOT>();
            DataTable TBFLOTE = DALFLOTE.getOrder(inupackage, inuorder, inususccodi, idtdatemin, idtdatemax);
            if (TBFLOTE != null)
            {
                foreach (DataRow row in TBFLOTE.Rows)
                {
                    OrderFILOT vFLOTE = new OrderFILOT(row);
                    ListFLOTE.Add(vFLOTE);
                }
            }
            return ListFLOTE;
        }


        //Agordillo Cambio.6853 04-10-2015
        // Se agrega como parametro de entrada el Valor Real Venta
        public static void legalizeOrder(Int64 orderId, Int32 causalId, String activitiesChain, Int64 valorRealSale)
        {
            DALFLOTE.legalizeOrder(orderId, causalId, activitiesChain, valorRealSale); 
        }

        /* RNP156 */
        public static void commentDelOrder(Int64 orderId, String sbComment)
        {
            DALFLOTE.commentDelOrder(orderId, sbComment);
        }

        public string getParam(String sbParam)
        {
            return _DALFLOTE.getParam(sbParam);
        }

        public static void registerInvoice(Int64 orderId, String invoice)
        {
            DALFLOTE.registerInvoice(orderId, invoice);
        }

        //Agordillo Cambio.6853 04-10-2015
        //Obtiene el valor de la venta
        public Boolean fblOrdenMaterialSale(Int64 orderId)
        {
            return _DALFLOTE.fblOrdMaterialSale(orderId);
        }


        //Agordillo Cambio.6853 04-10-2015
        //Obtiene el valor de la venta
        public Int64 fnugetValorSale(Int64 orderID)
        {
            return _DALFLOTE.fnugetValueSale(orderID);
        }

        //CASO 200-1164
        public Int64 FNUORDENSEGUROVOLUNTARIO(Int64 nuorder_activity_id)
        {
            return _DALFLOTE.FNUORDENSEGUROVOLUNTARIO(nuorder_activity_id);
        }
        //CASO 200-1164

    }
    
}
