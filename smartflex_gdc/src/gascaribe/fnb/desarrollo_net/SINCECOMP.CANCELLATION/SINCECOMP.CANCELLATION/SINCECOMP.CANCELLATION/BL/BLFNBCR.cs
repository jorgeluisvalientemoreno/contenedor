using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.CANCELLATION.DAL;
using SINCECOMP.CANCELLATION.Entities;
using System.Data;

namespace SINCECOMP.CANCELLATION.BL
{
    class BLFNBCR
    {
        DALFNBCR _DALFNBCR = new DALFNBCR();

        public BasicDataFNBCR getSubscriptionDataOld(Int64 subcription)
        {
            return _DALFNBCR.getBasicData(subcription);
        }

        public static List<ResgisterFNBCR> FcuFNBCR(Int64 inufindvalue)
        {
            List<ResgisterFNBCR> ListFNBCR = new List<ResgisterFNBCR>();
            DataTable TBFNBCR = DALFNBCR.getAnulDeta(inufindvalue);
            if (TBFNBCR != null)
            {
                foreach (DataRow row in TBFNBCR.Rows)
                {
                    ResgisterFNBCR vFNBCR = new ResgisterFNBCR(row);
                    ListFNBCR.Add(vFNBCR);
                }
            }
            return ListFNBCR;
        }

        public List<ArticleSaleCancelation> getSaleForCancelation(Int64 PackageId)//, Int64 Order)
        {
            return _DALFNBCR.getSaleForCancelation(PackageId);//, Order); 
        }

        public static Int64 consValue(Int64 inufindvalue)
        {
            return DALFNBCR.consValue(inufindvalue);
        }

        public DataFIFAP getSubscriptionData(Int64 PackageId)
        {
            return _DALFNBCR.getSubscriptionData(PackageId);
        }

        public Int64? registerXML(String cadenaXML)
        {
            return _DALFNBCR.registerXML(cadenaXML);
        }

        public Int32 validateAreaOrga()
        {
            return _DALFNBCR.validateAreaOrga();
        }

        public RequestFBNCR getRequestData(Int64? subscriberId)
        {
            return _DALFNBCR.getRequestData(subscriberId);
        }

        public Boolean validatedSolAnuDevPend(Int64 SaleRequestId)
        {
            return  _DALFNBCR.validatedSolAnuDevPend(SaleRequestId);
        }

        public Int32 validateAndCreateContact(Int64? contactId, String Name, String LastName, String Address, String Phone, Int64 IdentType, String Identification, Int64 Status, Int64? AddressId)
        {
            return _DALFNBCR.validateAndCreateContact(contactId, Name, LastName, Address, Phone, IdentType, Identification, Status, AddressId);
        }

        public RequestFBNCR Getsubscriber(Int64 IdentType, String Identification)
        {
            return _DALFNBCR.Getsubscriber(IdentType, Identification);
        }

        public void setArticlesDevGS(Int64? packageId)
        {
            _DALFNBCR.setArticlesDevGS(packageId);
        }

        /*****************************************************************
        Propiedad intelectual de PETI (c).

        Unidad         : validatePackageCancel
        Descripcion    : Retorna la solicitud de anulación/devolución registrada
                         de una venta FNB.
        Fecha          : 26/08/2015

        Historia de Modificaciones
        Fecha            Autor                 Modificacion
        =========        =========             ====================
        26-08-2015       MGarcia.SAO334713     Creacion.
        ******************************************************************/
        public Int32 validatePackageCancel(Int64 PackageId)
        {
            return _DALFNBCR.validatePackageCancel(PackageId);
        }

        //CASO 200-1164
        public Int64 FNUCAUSALANUDEV(Int64 nuCausal)
        {
            /*
            Valida si la causal es para identificar las ordenes de seguro voluntario existentes en FNBCR
            0 - La causal NO tiene relacion con articulo de seguro volunatio
            1 - La causal tiene relacion con articulo de seguro volunatio                  
             */
            return _DALFNBCR.FNUCAUSALANUDEV(nuCausal);
        }
        public Int64 FNUORDENSEGUROVOLUNTARIO(Int64 nuorder_activity_id)
        {
            /*
            Valida si la orden desplegada tiene o no un articulo de seguro voluntario en la venta BRILLA
            0 - La orden NO tiene relacion con articulo de seguro volunatio
            1 - La orden tiene relacion con articulo de seguro volunatio              
             */
            return _DALFNBCR.FNUORDENSEGUROVOLUNTARIO(nuorder_activity_id);
        }

        public void PRACTUALIZAVENTASEGUROS(Int64 InuPACKAGE_ID, String IsbEstado, Int64 InuActividad)
        {
            //Actualiza estado del artiuclo vendido en FIFAP de seguro voluntario
            _DALFNBCR.PRACTUALIZAVENTASEGUROS(InuPACKAGE_ID,IsbEstado,InuActividad);
        }
        //CASO 200-1164

        //Caso 200-2389
        public Int64 fnu_DifSeguroVoluntario(Int64 inuPackageId, Int64 inuArticleId)
        {
            return _DALFNBCR.fnu_DifSeguroVoluntario(inuPackageId, inuArticleId);
        }

        public Int64 fnu_CausalAplica(Int64 inuCausalId)
        {
            return _DALFNBCR.fnu_CausalAplica(inuCausalId);
        }

        public Int64 fnu_ArticuloSV(Int64 inuArticleId)
        {
            return _DALFNBCR.fnu_ArticuloSV(inuArticleId);
        }
        //
    
    }
}
