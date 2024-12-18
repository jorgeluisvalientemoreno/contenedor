using System;
using System.Collections.Generic;
using System.Text;
using LDCAPLAC.DAL;
using LDCAPLAC.Entities;
using System.Data;
using System.IO;
using OpenSystems.Printing.Common;
using OpenSystems.Common.ExceptionHandler;
using System.Windows.Forms;


namespace LDCAPLAC.BL
{
    class BLLDC_APLAC
    {
        DALLDC_APLAC dalLDC_FCVC = new DALLDC_APLAC();
        DALUtilities dalUtilities = new DALUtilities();

        /// <summary>
        /// Se obtienen los tipos de trabajo cotizados
        /// </summary>
        /// <param name="quotationId">id de la cotización</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public List<GridDetaMedi> GetDatosMedidor(Int64 nuMulti)
        {
            
            DataTable dtGridDetaMedi;
            List<GridDetaMedi> GridDetaMediList = new List<GridDetaMedi>();
            dtGridDetaMedi = dalLDC_FCVC.GetDatosMedidor(nuMulti);

            foreach (DataRow item in dtGridDetaMedi.Rows)
            {
                GridDetaMedi tmpQuotationTaskType = new GridDetaMedi(item);
                GridDetaMediList.Add(tmpQuotationTaskType);

            }

            return GridDetaMediList;   
        }


        /// <summary>
        /// Se obtienen los items vigentes
        /// </summary>
        /// <returns>Retorna los items vigentes</returns>               
        public List<ComboCostList> getItemsNorm(Int64 OrdenTrabajo)
        {

            DataTable dtItemsList = dalLDC_FCVC.getItemsNorm(OrdenTrabajo);
            List<ComboCostList> itemsList = new List<ComboCostList>();

            foreach (DataRow item in dtItemsList.Rows)
            {
                ComboCostList tmpItem = new ComboCostList(item);
                itemsList.Add(tmpItem);
            }

            return itemsList;
        }



        /// <summary>
        /// Se obtienen los items cotizados
        /// </summary>
        /// <returns>Retorna los items cotizados</returns>               
        public List<ComboCostCoti> getItemsCoti(Int64 OrdenTrabajo)
        {

            DataTable dtItemsList = dalLDC_FCVC.getItemsCoti(OrdenTrabajo);
            List<ComboCostCoti> itemsList = new List<ComboCostCoti>();

            foreach (DataRow item in dtItemsList.Rows)
            {
                ComboCostCoti tmpItem = new ComboCostCoti(item);
                itemsList.Add(tmpItem);
            }

            return itemsList;
        }


        /// <summary>
        /// Se obtiene el precio del Item seleccionado
        /// </summary>
        /// <returns>Se obtiene el precio del Item seleccionado</returns>               
        public Int64 getItemPrecio(Int64 nuOrden, Int64 nuItem, DateTime FechaExeOrd)
        {
            return dalLDC_FCVC.getItemPrecio(nuOrden, nuItem, FechaExeOrd);
        }


        /// <summary>
        /// Se obtiene el usuario conectado
        /// </summary>
        /// <returns>Se obtiene el usuario conectado</returns>               
        public String getUserConect()
        {
            return dalLDC_FCVC.getUserConect();
        }


        /// <summary>
        /// Se envian los de la orden al procedimiento
        /// </summary>
        /// <returns>Actualiza listas</returns>               
        public void SaveDatosOrdenCont(Int64 nuOrder, Int64 nuContrato, Int64 nuProducto, Int64 Responsable,
                                       String OsbContratista, Int64 nuCausal, String nuStatusOrder, String OsbFuncionario, DateTime FechaIni,
                                       DateTime FechaFin, Int64 nuMultiFam, out Int64 onuErrorCode, out String osbErrorMessage)

        {
            dalLDC_FCVC.SaveDatosOrdenCont(nuOrder, nuContrato, nuProducto, Responsable, OsbContratista, nuCausal, 
                                           nuStatusOrder, OsbFuncionario, FechaIni, FechaFin, nuMultiFam, out onuErrorCode, out osbErrorMessage);

        }


        /// <summary>
        /// Se envian los datos de los medidores
        /// </summary>
        /// <returns>Actualiza listas</returns>               
        public void SaveDatosMedidores(Int64 nuOrder, String sbMedidor, Int64 nuContrato, String sbDireccion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.SaveDatosMedidores(nuOrder, sbMedidor, nuContrato, sbDireccion, out onuErrorCode, out osbErrorMessage);
        }


        // <summary>
        /// Se envian los de los Items
        /// </summary>
        /// <returns>Actualiza listas</returns>               
        public void SaveDatosItems(Int64 nuOrder, Int64 Item, String Descripcion, String TypeItems, Double Cantidad,
                                   Int64 Valor, Int64 ValorTotal, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.SaveDatosItems(nuOrder, Item, Descripcion, TypeItems, Cantidad, Valor, ValorTotal, out onuErrorCode, out osbErrorMessage);
        }



        /// <summary>
        /// Se obtienen los medidores en la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los medidores en la nueva tabla creada</returns> 
        public List<GridDetaMedi> GetDatosMediNew(Int64 Order_id)
        {

            DataTable dtGridDetaMedi;
            List<GridDetaMedi> GridDetaMediList = new List<GridDetaMedi>();
            dtGridDetaMedi = dalLDC_FCVC.GetDatosMediNew(Order_id);

            foreach (DataRow item in dtGridDetaMedi.Rows)
            {
                GridDetaMedi tmpQuotationTaskType = new GridDetaMedi(item);
                GridDetaMediList.Add(tmpQuotationTaskType);

            }

            return GridDetaMediList;
        }


        /// <summary>
        /// Se obtienen los items Normales en la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los Items Normales en la nueva tabla creada</returns> 
        public List<GridItemsLegal> GetDatosItemsNew(Int64 Order_id)
        {

            DataTable dtGridLegal;
            List<GridItemsLegal> GridDetaItemList = new List<GridItemsLegal>();
            dtGridLegal = dalLDC_FCVC.GetDatosItemsNew(Order_id);

            foreach (DataRow item in dtGridLegal.Rows)
            {
                GridItemsLegal tmpQuotationTaskType = new GridItemsLegal(item);
                GridDetaItemList.Add(tmpQuotationTaskType);

            }

            return GridDetaItemList;
        }


        /// <summary>
        /// Se obtienen los items Cotizados en la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los Items Cotizados en la nueva tabla creada</returns> 
        public List<GridItemsCoti> GetDatosItemsNewCoti(Int64 Order_id)
        {

            DataTable dtGridCoti;
            List<GridItemsCoti> GridItemListCoti = new List<GridItemsCoti>();
            dtGridCoti = dalLDC_FCVC.GetDatosItemsNewCoti(Order_id);

            foreach (DataRow item in dtGridCoti.Rows)
            {
                GridItemsCoti tmpQuotationTaskType = new GridItemsCoti(item);
                GridItemListCoti.Add(tmpQuotationTaskType);

            }

            return GridItemListCoti;
        }


        /// <summary>
        /// Funcionalidad del boton aprobar/Rechazar Orden
        /// </summary>
        /// <returns>Funcionalidad del boton aprobar/Rechazar Orden</returns>               
        public void AprobarRechazOrden_click(Int64 nuOrder, String isbEstado, String sbObservacion, DateTime inuFechaIni,
                                             DateTime inuFechaFinal, out Int64 onuErrorCode, out String osbErrorMessage)                                      
        {
            dalLDC_FCVC.AprobarRechazOrden_click(nuOrder, isbEstado, sbObservacion, inuFechaIni,  
                                                 inuFechaFinal, out  onuErrorCode, out  osbErrorMessage);

        }


        /// <summary>
        /// Se obtiene la clase de causal
        /// </summary>
        /// <returns>Se obtiene la clase de causalreturns>               
        public Int64 getClassCausal(Int64 nuCausal)
        {
            return dalLDC_FCVC.getClassCausal(nuCausal);
        }

        /// <summary>
        /// Envia notificacion por correo
        /// </summary>
        public void sendNotificationEmail(Int64 orderId, Int64 flagMess, String useParam)
        {
            dalLDC_FCVC.sendNotificationEmail(orderId, flagMess, useParam);
        }
        /// <summary>
        /// Valida si el estado de corte es facturable
        /// </summary>
        public String fsbEsFacturable(Int64 estadoCorte)
        {
            return dalLDC_FCVC.fsbEsFacturable(estadoCorte);
        }
        /// <summary>
        /// Obtiene cantidad multifamiliar
        /// </summary>
        /// <param name="nuOrder"></param>
        /// <param name="multi"></param>
        /// <param name="cantidad"></param>
        /// <param name="total"></param>
        public void getContratosMulti(Int64 nuOrder, Int64 multi, out Int64 cantidad, out Int64 total)
        {
            dalLDC_FCVC.getContratosMulti(nuOrder, multi, out cantidad, out total);
        }
        /// <summary>
        /// Obtiene garantias
        /// </summary>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public List<GridWarranty> getWarrantyByProduct(Int64 orderId)
        {

            DataTable dtGridWarranty;
            List<GridWarranty> gridWarranty = new List<GridWarranty>();
            dtGridWarranty = dalLDC_FCVC.getWarrantyByProduct(orderId);

            foreach (DataRow item in dtGridWarranty.Rows)
            {
                GridWarranty tmpWarranty = new GridWarranty(item);
                gridWarranty.Add(tmpWarranty);

            }

            return gridWarranty;
        }
        /// <summary>
        /// Genera ordenes de garantía
        /// </summary>
        /// <param name="orderId"></param>
        /// <param name="flag"></param>
        public void processWarranty(Int64 orderId, String flag)
        {
            dalLDC_FCVC.processWarranty(orderId, flag);
        }
              
        /// <summary>
        /// Se obtienen los items Cotizados en la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los Items Cotizados en la nueva tabla creada</returns> 
        public List<GridItemsCoti> GetDatosItemsNewCoti(Int64 Order_id, String flag)
        {

            DataTable dtGridCoti;
            List<GridItemsCoti> GridItemListCoti = new List<GridItemsCoti>();
            dtGridCoti = dalLDC_FCVC.GetDatosItemsNewCoti(Order_id, flag);

            foreach (DataRow item in dtGridCoti.Rows)
            {
                GridItemsCoti tmpQuotationTaskType = new GridItemsCoti(item);
                GridItemListCoti.Add(tmpQuotationTaskType);

            }

            return GridItemListCoti;
        }

        /// <summary>
        /// Se obtienen los items Normales en la nueva tabla creada
        /// </summary>
        /// <returns>Se obtienen los Items Normales en la nueva tabla creada</returns> 
        public List<GridItemsLegal> GetDatosItemsNew(Int64 Order_id, String flag)
        {

            DataTable dtGridLegal;
            List<GridItemsLegal> GridDetaItemList = new List<GridItemsLegal>();
            dtGridLegal = dalLDC_FCVC.GetDatosItemsNew(Order_id, flag);

            foreach (DataRow item in dtGridLegal.Rows)
            {
                GridItemsLegal tmpQuotationTaskType = new GridItemsLegal(item);
                GridDetaItemList.Add(tmpQuotationTaskType);

            }

            return GridDetaItemList;
        }
        /// <summary>
        /// Obtiene el flag de garantía de una orden
        /// </summary>
        /// <param name="Order_id"></param>
        /// <returns></returns>
        public String GetFlagByOrder(Int64 Order_id)
        {
            return dalLDC_FCVC.GetFlagByOrder(Order_id);
        }
        /// <summary>
        /// Inserta o actualiza el flag de garantía para una orden
        /// </summary>
        /// <param name="Order_id"></param>
        /// <param name="flag"></param>
        public void InsOrUpdByOrderWarranty(Int64 Order_id, String flag)
        {
            dalLDC_FCVC.InsOrUpdByOrderWarranty(Order_id, flag);
        }
    }
}
