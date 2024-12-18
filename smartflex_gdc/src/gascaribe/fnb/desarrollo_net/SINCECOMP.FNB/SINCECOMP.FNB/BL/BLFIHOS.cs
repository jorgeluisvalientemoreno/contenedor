#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : BLFIHOS
 * Descripcion   : Objeto de negocio para la ayuda de venta
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 05-Sep-2013  212246  lfernandez     1 - <getAvalibleArticles> Se modifica para que la lista de artículos
 *                                         no sea retornada con return sino como un parámetro de salida y
 *                                         también se devuelve el dataTable de artículos
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
//using SINCECOMP.FNB.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.BL
{
    class BLFIHOS
    {

        DALFIHOS _DALFIHOS = new DALFIHOS();

        public DataFIFAP getSubscriptionData(Int64 subcription)
        {
            return _DALFIHOS.getSubscriptionData(subcription);
        }

        BLGENERAL general = new BLGENERAL();

        public static void CreditQuotaData(Int64 inuidenttype, String inuidentification, out Int64 onususccodi, out Int64 onuasignedquote, out Int64 onuusedquote, out Int64 onuavaliblequote)
        {
            Int64 onususccodia, onuasignedquotea, onuusedquotea, onuavaliblequotea;
            DALFIHOS.CreditQuotaData(inuidenttype, inuidentification, out onususccodia, out onuasignedquotea, out onuusedquotea, out onuavaliblequotea);
            onususccodi=onususccodia;
            onuasignedquote = onuasignedquotea;
            onuusedquote = onuusedquotea;
            onuavaliblequote = onuavaliblequotea;

        }

        public void getAvalibleArticles(
            Int64 supplierId, 
            Int64 chanelId, 
            Int64 geoLocation, 
            Int64 categoryId, 
            Int64 subcategoryId,
            ref List<ArticleValue2> articleList,
            ref DataTable articleTable,
            String flagCuotaFija)
        {
          //  general.mensajeOk("El Valor del flag  en BLFIHOS es flagCuotaFija: " + flagCuotaFija);
            _DALFIHOS.getAvalibleArticles(
                supplierId, 
                chanelId, 
                geoLocation, 
                categoryId, 
                subcategoryId,
                ref articleList,
                ref articleTable,
                flagCuotaFija);
           // general.mensajeOk("tamaño articleList: " + articleList.Count);
        }

        /*18-02-2015 Llozada [RQ 1841]: Se crea función que trae los datos correspondientes al plan de financiación
                                        seleccionado en la forma de simulación*/
        public String getPlanFinanCF(long IdPlanDife)
        {
            return _DALFIHOS.getPlanFinanCF(IdPlanDife);
        }

        public static void GetCommercialSegment(Int64 inususccodi, out String osbCommercSegment, out Int64 onuSegmentId)
        {
            String osbCommercSegm;
            Int64 onuSegmtId;
            DALFIFAP.GetCommercialSegment(inususccodi, out osbCommercSegm, out onuSegmtId);

            osbCommercSegment = osbCommercSegm;
            onuSegmentId = onuSegmtId;
        }

        public static void SubscriptionQuotaData(Int64 inususccodi, out Int64 onuasignedquote, out Int64 onuusedquote, out Int64 onuavaliblequote)
        {
            Int64 onuasignedquotea, onuusedquotea, onuavaliblequotea;
            DALFIHOS.SubscriptionQuotaData(inususccodi, out onuasignedquotea, out onuusedquotea, out onuavaliblequotea);
            onuasignedquote = onuasignedquotea;
            onuusedquote = onuusedquotea;
            onuavaliblequote = onuavaliblequotea;
        }

    }
}
