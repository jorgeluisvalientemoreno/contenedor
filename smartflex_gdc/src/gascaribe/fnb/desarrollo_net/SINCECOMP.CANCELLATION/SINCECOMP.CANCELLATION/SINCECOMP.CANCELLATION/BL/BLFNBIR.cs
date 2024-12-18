using System;
using System.Collections.Generic;
using System.Text;
//
using SINCECOMP.CANCELLATION.DAL;
using SINCECOMP.CANCELLATION.Entities ;
using System.Data;

namespace SINCECOMP.CANCELLATION.BL
{
    class BLFNBIR
    {
      
        public static List<GridDetailOneFNBIR> FcusearchReport(String inupackagesale, String inupackageannu, String inuorder, String inucausal, Nullable<DateTime> idtminsaledate,
            Nullable<DateTime> idtmaxsaledate, Nullable<DateTime> idtmindateannu, Nullable<DateTime> idtmaxdateannu, String inuidenttype, String isbindentific, String inususccodi)
        {
            List<GridDetailOneFNBIR> ListGrid = new List<GridDetailOneFNBIR>();
            DataTable TBGrid = DALFNBIR.searchReport(inupackagesale, inupackageannu, inuorder, inucausal, idtminsaledate, idtmaxsaledate, idtmindateannu, idtmaxdateannu, inuidenttype, isbindentific, inususccodi);
            //ordenar listado
            //DataView VistaDatos = new DataView(TBProperty);
            //VistaDatos.Sort = "propert_by_article_id";
            //TBProperty = VistaDatos.ToTable();
            if (TBGrid != null)
            {
                foreach (DataRow row in TBGrid.Rows)
                {
                    GridDetailOneFNBIR vGrid = new GridDetailOneFNBIR(row);
                    ListGrid.Add(vGrid);
                }
            }
            return ListGrid;
        }

        /***************************************************************************
        Historia de Modificaciones
        Fecha            Autor         Modificacion
        =========       =========      ====================
        25/09/2014      Llozada        Se agrega el parámetro de observación
        ***************************************************************************/
        public static void LegAnnulmentOrder(Int64 orderId, Int64 opcion, String LegString, String observation)
        {
            DALFNBIR.LegAnnulmentOrder(orderId, opcion, LegString, observation);
        }
        public static void LegApplAnnulOrder(Int64 orderId, String LegString)
        {
            DALFNBIR.LegApplAnnulOrder(orderId, LegString);
        }
    }
}
