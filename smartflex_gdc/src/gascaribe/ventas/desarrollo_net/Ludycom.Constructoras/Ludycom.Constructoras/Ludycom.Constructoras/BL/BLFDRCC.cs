using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Printing.Common;
using System.IO;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.BL
{
    class BLFDRCC
    {
        DALFDRCC dalFDRCC = new DALFDRCC();
        DALUtilities dalUtilities = new DALUtilities();

        /// <summary>
        /// Se obtienen los ítems de la lista de precios
        /// </summary>
        /// <param name="listPriceId">Id de la lista de precios</param>
        /// <returns>Retorna lista con los ítems</returns>               
        public List<LovItem> GetPriceListItems(Int64 listPriceId) 
        {
            DataTable dtItems;
            List<LovItem> itemList = new List<LovItem>();
            Double cost;
            Double price;
            Int64? nuInternalConnTaskType;

            nuInternalConnTaskType = Convert.ToInt64(dalUtilities.getParameterValue("TIPO_TRAB_RED_INTERNA", "Int64").ToString()); 
            dtItems = dalFDRCC.GetPriceListItems(listPriceId);

            foreach (DataRow row in dtItems.Rows)
            {
                if (row["ITEM_PRECIO"] == null)
                {
                    price = 0;
                }
                else
                {
                    price = Convert.ToDouble(row["ITEM_PRECIO"]);
                }

                if (row["ITEM_COSTO"] == null)
                {
                    cost = 0;
                }
                else
                {
                    cost = Convert.ToDouble(row["ITEM_COSTO"]);
                }

                //Caso 200-1640
                QuotationItem quotationItem = new QuotationItem(Convert.ToString(row["ITEMS_ID"]), Convert.ToString(row["ITEM_DESCRIPCION"]), cost, price, nuInternalConnTaskType);
                itemList.Add(new LovItem(quotationItem.ItemId, Convert.ToString(row["ITEM_DESCRIPCION"]), quotationItem));

            }

            return itemList;
        }

        /// <summary>
        /// Se obtienen los ítems de la lista de precios
        /// </summary>
        /// <returns>Retorna una tabla de datos con los items por tipo de trabajo</returns>               
        public List<itemTaskType> GetItemsByTaskType()
        {
            List<itemTaskType> itemTaskTypeList = new List<itemTaskType>();
            DataTable dtItemsTaskType;

            dtItemsTaskType = dalFDRCC.GetItemsByTaskType();

            foreach (DataRow item in dtItemsTaskType.Rows)
            {
                itemTaskType tmpItemTaskType = new itemTaskType(item);

                itemTaskTypeList.Add(tmpItemTaskType);
            }

            return itemTaskTypeList;
        }

        /// <summary>
        /// Se valida si la cotización existe
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna un valor booleano indicando la existencia de la cotización</returns>
        public Boolean QuotationExists(Int64 quotationId)
        {
            return dalFDRCC.QuotationExists(quotationId);
        }

        /// <summary>
        /// Se obtiene el proyecto asociado a la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna el id del proyecto</returns>
        public Int64 GetProjectOfQuotation(Int64 quotationId)
        {
            return dalFDRCC.GetProjectOfQuotation(quotationId);
        }

        /// <summary>
        /// Se obtiene el porcentaje de IVA de la instalación interna
        /// </summary>
        /// <returns>Retorna el porcentaje de IVA de la instalación interna</returns>
        public Double GetPercentIntInstallation()
        {
            return dalFDRCC.GetPercentIntInstallation();
        }

        /// <summary>
        /// Se obtienen los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna una instancia de QuotationBasicData con los datos básicos de la cotización/returns>
        public QuotationBasicData GetQuotationBasicData(Int64 quotationId)
        {
            return dalFDRCC.GetQuotationBasicData(quotationId);
        }

        /// <summary>
        /// Se registran los datos básicos de la cotizacion
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public Int64 RegisterQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            return dalFDRCC.RegisterQuotationBasicData(quotationBasicData);
        }

        /// <summary>
        /// Se actualizan los datos básicos de la cotizacion
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public void UpdateQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            dalFDRCC.UpdateQuotationBasicData(quotationBasicData);
        }

         /// <summary>
        /// Se actualizan los datos básicos del proyecto
        /// </summary>
        /// <param name="projectBasicData">Instancia de la clase ProjectBasicData</param>
        public void UpdateProjectData(ProjectBasicData projectBasicData)
        {
            dalFDRCC.UpdateProjectData(projectBasicData);
        }

        /// <summary>
        /// Se actualiza la fecha de vigencia
        /// </summary>
        /// <param name="quotation">Instancia de la clase QuotationBasicData</param>
        public void UpdateValidityDate(QuotationBasicData quotation)
        {
            dalFDRCC.UpdateValidityDate(quotation);
        }

        /// <summary>
        /// Se registran los tipos de trabajo por cotización
        /// </summary>
        /// <param name="taskTypeInfo">instancia de ConsolidatedQuotation</param>
        public void RegisterQuotationTaskType(ConsolidatedQuotation taskTypeInfo)
        {
            dalFDRCC.RegisterQuotationTaskType(taskTypeInfo);
        }

        /// <summary>
        /// Se actualizan los tipos de trabajo de la cotización
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public void UpdateQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            dalFDRCC.UpdateQuotationTaskType(quotationTaskType);
        }

        /// <summary>
        /// Se registran los items fijos
        /// </summary>
        /// <param name="quotationId">Secuencia de la cotización</param>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="itemId">Id del ítem</param>
        /// <param name="amount">Cantidad</param>
        /// <param name="price">Precio</param>
        /// <param name="itemType">Tipo de ítem FP:Fijos por Proyecto FU:Fijos por unidad predial</param>
        /// <param name="taskType">Tipo de trabajo</param>
        public void RegisterFixedItems(QuotationItem fixedItem)
        {
            dalFDRCC.RegisterFixedItems(fixedItem);
        }

        /// <summary>
        /// Se registran los valores fijos
        /// </summary>
        /// <param name="consecutive">consecutivo del registro</param>
        /// <param name="quotationId">Secuencia de la cotización</param>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="description">Descripción</param>
        /// <param name="amount">Cantidad</param>
        /// <param name="price">Precio</param>
        public void RegisterFixedValues(FixedValues fixedValue)
        {
            dalFDRCC.RegisterFixedValues(fixedValue);
        }

        /// <summary>
        /// Se obtiene el metraje por tipo y piso a nivel de proyecto ó cotización dependiendo de la opción
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con el metraje por tipo y piso</returns>               
        public List<LengthPerFloorPerPropUnitType> GetLengthPerFloorPerPropUnitType(Int64 projectId, Int64? nuQuotationConsecutive, OperationType QuotationMode)
        {
            DataTable dtLenthPerFloorPropUnitType;
            List<LengthPerFloorPerPropUnitType> LengthPerFloorPerPropUnitTypeList = new List<LengthPerFloorPerPropUnitType>();
            if (QuotationMode == OperationType.Register)
            {
                dtLenthPerFloorPropUnitType = dalFDRCC.GetLengthPerFloorPerPropUnitType(projectId);
            }
            else
            {
                dtLenthPerFloorPropUnitType = dalFDRCC.GetLengthPerFloorPerPropUnitTypeQuot(projectId, nuQuotationConsecutive); 
            }

            foreach (DataRow item in dtLenthPerFloorPropUnitType.Rows)
            {
                LengthPerFloorPerPropUnitType tmpLengthPerFloorPerPropUnitType = new LengthPerFloorPerPropUnitType(item);
                LengthPerFloorPerPropUnitTypeList.Add(tmpLengthPerFloorPerPropUnitType);
            }

            return LengthPerFloorPerPropUnitTypeList;
        }

        /// <summary>
        /// Se registran el metraje por piso y tipo
        /// </summary>
        /// <param name="lengthPerFloorPropUnitTypeObj">Instancia de la clase LengthPerFloorPerPropUnitType</param>
        public void RegisterLengthPerFloorPropUnitType(LengthPerFloorPerPropUnitType lengthPerFloorPropUnitTypeObj)
        {
            dalFDRCC.RegisterLengthPerFloorPropUnitType(lengthPerFloorPropUnitTypeObj);
        }

        /// <summary>
        /// Se registran los ítems por metraje
        /// </summary>
        /// <param name="lengthPerFloorPropUnitTypeObj">Instancia de la clase ItemsPerLength</param>
        /// <param name="taskType">Tipo de trabajo</param>
        public void RegisterItemsPerLength(ItemsPerLength itemsPerLengthObj, Int64 taskType)
        {
            dalFDRCC.RegisterItemsPerLength(itemsPerLengthObj, taskType);
        }

        /// <summary>
        /// Se obtienen los tipos de trabajo por cotización
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>               
        public List<QuotationTaskType> GetQuotationTaskType(Int64 projectId, Int64 quotationId)
        {
            DataTable dtquotationTaskType;
            List<QuotationTaskType> quotationTaskTypeList = new List<QuotationTaskType>();
            dtquotationTaskType = dalFDRCC.GetQuotationTaskType(projectId, quotationId);

            foreach (DataRow item in dtquotationTaskType.Rows)
            {
                QuotationTaskType tmpQuotationTaskType = new QuotationTaskType(item);
                quotationTaskTypeList.Add(tmpQuotationTaskType);
            }

            return quotationTaskTypeList;   
        }

        /// <summary>
        /// Se obtiene los ítems fijos por proyecto/unidad predial
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="itemType">Tipo de ítem</param>
        /// <returns>Retorna una lista con los items fijos</returns>               
        public List<QuotationItem> GetFixedItems(Int64 projectId, Int64 nuQuotationId, String itemType, Int64 taskTypeId)
        {
            DataTable dtFixedItems;
            List<QuotationItem> fixedItemList = new List<QuotationItem>();
            dtFixedItems = dalFDRCC.GetFixedItems(projectId, nuQuotationId, itemType, taskTypeId);

            foreach (DataRow item in dtFixedItems.Rows)
            {
                QuotationItem tmpFixedItems = new QuotationItem(item);
                fixedItemList.Add(tmpFixedItems);
            }

            return fixedItemList;
        }


        /// <summary>
        /// Se obtienen los valores fijos
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="nuQuotationId">Id de la cotización</param>
        /// <param name="taskType">Tipo de trabajo</param>
        /// <returns>Retorna una lista con los valores fijos</returns>               
        public List<FixedValues> GetFixedValues(Int64 projectId, Int64 nuQuotationId, Int64 taskType)
        {
            DataTable dtFixedValues;
            List<FixedValues> fixedValueList = new List<FixedValues>();
            dtFixedValues = dalFDRCC.GetFixedValues(projectId, nuQuotationId, taskType);

            foreach (DataRow item in dtFixedValues.Rows)
            {
                FixedValues tmpFixedItems = new FixedValues(item);
                fixedValueList.Add(tmpFixedItems);
            }

            return fixedValueList;
        }


        /// <summary>
        /// Se obtienen los ítems por metraje
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <returns>Retorna una lista con los ítems por metraje</returns>               
        public List<ItemsPerLength> GetItemsPerLength(Int64 projectId, Int64 nuQuotationId)
        {
            DataTable dtItemsPerLength;
            List<ItemsPerLength> ItemsPerLengthList = new List<ItemsPerLength>();
            dtItemsPerLength = dalFDRCC.GetItemsPerLength(projectId, nuQuotationId);

            foreach (DataRow item in dtItemsPerLength.Rows)
            {
                ItemsPerLength tmpItemsPerLength = new ItemsPerLength(item);
                ItemsPerLengthList.Add(tmpItemsPerLength);
            }

            return ItemsPerLengthList;
        }

        /// <summary>
        /// Se obtienen los pisos y tipos de unidad predial por projecto
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <returns>Retorna lista de pisos y tipos de trabajo por proyecto</returns>               
        public List<PropPerFloorAndUnitType> GetFloorPropUnitType(Int64 projectId)
        {
            List<PropPerFloorAndUnitType> propPerFloorAndUnitTypeList = new List<PropPerFloorAndUnitType>();
            List<QuotationItem> quotationItemList = new List<QuotationItem>();
            DataTable dtPropPerFloorAndUnitType = dalFDRCC.GetFloorPropUnitType(projectId);

            foreach (DataRow item in dtPropPerFloorAndUnitType.Rows)
            {
                PropPerFloorAndUnitType tmpPropPerFloorAndUnitType = new PropPerFloorAndUnitType(item);
                tmpPropPerFloorAndUnitType.QuotationItemList = quotationItemList;
                propPerFloorAndUnitTypeList.Add(tmpPropPerFloorAndUnitType);
            }

            return propPerFloorAndUnitTypeList;
        }

        /// <summary>
        /// Se obtiene los ítems fijos por unidad predial
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="itemType">Tipo de ítem</param>
        /// <param name="taskTypeId">Tipo de Trabajo</param>
        /// <returns>Retorna una tabla de datos con los items</returns>               
        public List<QuotationItem> GetItemsPerPropUnit(Int64 projectId, Int64 nuQuotationId, String itemType, Int64 taskTypeId)
        {
            DataTable dtItemsPerPropUnit;
            List<QuotationItem> PropUnitItemList = new List<QuotationItem>();
            dtItemsPerPropUnit = dalFDRCC.GetItemsPerPropUnit(projectId, nuQuotationId, itemType, taskTypeId);

            foreach (DataRow item in dtItemsPerPropUnit.Rows)
            {
                QuotationItem tmpItemPerPropUnit = new QuotationItem(item);
                tmpItemPerPropUnit.FloorId = Convert.ToInt32(item["ID_PISO"]);
                tmpItemPerPropUnit.PropUnitTypeId = Convert.ToInt32(item["ID_TIPO_UNID_PRED"]);
                PropUnitItemList.Add(tmpItemPerPropUnit);
            }

            return PropUnitItemList;
        }


        /// <summary>
        /// Método para obtener el consolidado de la cotización
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <returns>Retorna una tabla de datos con el consolidado</returns>               
        public List<ConsolidatedQuotation> GetConsolidatedQuotation(Int64 projectId, Int64 nuQuotationId)
        {
            List<ConsolidatedQuotation> consolidatedQuotationList = new List<ConsolidatedQuotation>();
            DataTable dtConsolidatedQuotation = dalFDRCC.GetConsolidatedQuotation(projectId, nuQuotationId);

            foreach (DataRow item in dtConsolidatedQuotation.Rows)
            {
                ConsolidatedQuotation tmpConsolidatedQuotation = new ConsolidatedQuotation(item);
                consolidatedQuotationList.Add(tmpConsolidatedQuotation);
            }

            return consolidatedQuotationList;
        }

        /// <summary>
        /// Se actualizan los items fijos
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void UpdateFixedItems(QuotationItem quotationItem)
        {
            dalFDRCC.UpdateFixedItems(quotationItem);
        }

        /// <summary>
        /// Se actualizan los valores fijos
        /// </summary>
        /// <param name="fixedValue">Instancia de la clase FixedValues</param>
        public void UpdateFixedValues(FixedValues fixedValue)
        {
            dalFDRCC.UpdateFixedValues(fixedValue);
        }

        /// <summary>
        /// Se actualizan los ítems por metraje
        /// </summary>
        /// <param name="itemsPerLength">Instancia de la clase ItemsPerLength</param>
        public void UpdateItemsPerLength(ItemsPerLength itemsPerLength)
        {
            dalFDRCC.UpdateItemsPerLength(itemsPerLength);
        }

        /// <summary>
        /// Se actualiza el metraje por piso y tipo
        /// </summary>
        /// <param name="lengthPerFloorPerPropUnitType">Instancia de la clase LengthPerFloorPerPropUnitType</param>
        public void UpdateLengthPerFloorPerPropUnitType(LengthPerFloorPerPropUnitType lengthPerFloorPerPropUnitType)
        {
            dalFDRCC.UpdateLengthPerFloorPerPropUnitType(lengthPerFloorPerPropUnitType);
        }

        /// <summary>
        /// Se actualizan los items por unidad
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void UpdateItemsPerPropUnit(QuotationItem quotationItem)
        {
            dalFDRCC.UpdateItemsPerPropUnit(quotationItem);
        }

        /// <summary>
        /// Método para modificar el consolidado de la cotización
        /// </summary>
        /// <param name="consolidatedQuotation">Instancia de la clase ConsolidatedQuotation</param>
        public void UpdateConsolidatedQuotation(ConsolidatedQuotation consolidatedQuotation)
        {
            dalFDRCC.UpdateConsolidatedQuotation(consolidatedQuotation);
        }

        /// <summary>
        /// Se copia la cotización detallada
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        public Int64 CopyQuotation(Int64 projectId, Int64 quotation)
        {
            return dalFDRCC.CopyQuotation(projectId, quotation);
        }

        /// <summary>
        /// Se preaprueba la cotización detallada
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        /// <param name="address">Dirección de cobro</param>
        public void PreApproveQuotation(Int64 projectId, Int64 quotation, Int64 address, Int64 activity, Int32 cycle)
        {
            dalFDRCC.PreApproveQuotation(projectId, quotation, address, activity, cycle);
        }

        /// <summary>
        /// Se imprime pre-cupón
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        /// <param name="path">Ruta del archivo</param>
        public void PrintPreCupon(Int64 projectId, Int64 quotation, String path)
        {
            dalFDRCC.PrintPreCupon(projectId, quotation, path, "PRECUPON_"+projectId+quotation);
        }

        /// <summary>
        /// Se actualiza el porcentaje de cuota inicial
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="percentage">Porcentaje de la cuota inicial</param>
        public void UpdateInitialFeePercentage(Int64 projectId, Double percentage)
        {
            dalFDRCC.UpdateInitialFeePercentage(projectId, percentage);
        }

        /// <summary>
        /// Se registran los ítems por unidad predial
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void RegisterItemsPerPropUnit(QuotationItem quotationItem)
        {
            dalFDRCC.RegisterItemsPerPropUnit(quotationItem);
        }

        /// <summary>
        /// Se registra el consolidado de la cotización
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void RegisterConsolidatedQuotation(ConsolidatedQuotation consolidatedQuotation)
        {
            dalFDRCC.RegisterConsolidatedQuotation(consolidatedQuotation);
        }

        public DataTable getValueList(String Query)
        {
            return dalFDRCC.getValueList(Query);
        }

        //Caso 200-1640
        public Object getParam(String sbParam, String tipo)
        {
            return dalFDRCC.getParam(sbParam, tipo);
        }

        //12.07.18
        //modificados 18/07/18
        //Servicios Diseñados por el Ing. Sebastian Tapias para el Manejo de las nuevas condiciones de la Forma
        /*public void proRegistraComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proRegistraComercial(InuPackageID, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proActualizaComercial(InuPackageID, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proCargaComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proCargaComercial(InuPackageID, InuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }*/

        //Caso 200-1640
        //18.07.18
        public void proRegistraConstructora(Int64 inuPackageId, Int64 inuProyecto, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proRegistraConstructora(inuPackageId, inuProyecto, inuContratista, inuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proRegistraConstructoraItem(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbTipoItem, Int64 inuTipoTrab, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proRegistraConstructoraItem(inuPackageId, inuProyecto, inuIditem, isbTipoItem, inuTipoTrab, isbClassItem, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaConstructora(Int64 inuPackageId, Int64 inuProyecto, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proActualizaConstructora(inuPackageId, inuProyecto, inuContratista, inuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaConstructoraItem(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbTipoItem, Int64 inuTipoTrab, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proActualizaConstructoraItem(inuPackageId, inuProyecto, inuIditem, isbTipoItem, inuTipoTrab, isbClassItem, isbOperacion, out onuErrorCode, out osbErrorMessage);
        }

        public void proCargaConstructora(Int64 inuPackageId, Int64 inuProyecto, out Int64 onuContratista, out Int64 onuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proCargaConstructora(inuPackageId, inuProyecto, out onuContratista, out onuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proRegistraItemValFijos(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, Int64 inuTipoTrab, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proRegistraItemValFijos(inuPackageId, inuProyecto, inuIditem, inuTipoTrab, isbClassItem, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaItemValFijos(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, Int64 inuTipoTrab, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proActualizaItemValFijos(inuPackageId, inuProyecto, inuIditem, inuTipoTrab, isbClassItem, isbOperacion, out onuErrorCode, out osbErrorMessage);
        }

        public void proRegistraItemMetraje(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proRegistraItemMetraje(inuPackageId, inuProyecto, inuIditem, isbClassItem, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaItemMetraje(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalFDRCC.proActualizaItemMetraje(inuPackageId, inuProyecto, inuIditem, isbClassItem, isbOperacion, out onuErrorCode, out osbErrorMessage);
        }

        //INICIO 200-2022

        public ActividadesPlanEsp getActiviPlanespec(Int64 inuPlanEspecial)
        {
            return dalFDRCC.getActiviPlanespec(inuPlanEspecial);
        }
        //FIN CA 200-2022


        /// <summary>
        /// Se imprime cotizacion
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion 
        /// =========   =========              =====================================
        /// 25/10/2018  josh                    1 - creación                   
        /// </changelog>
        public void PrintCotizacion(Int64 inuProyecto, Int64 quotationId, String sTipoImpresion)
        {
            string file = string.Empty;
            try
            {
                dalFDRCC.PrintCotizacion(inuProyecto, quotationId, sTipoImpresion);

                string path = Path.GetTempPath();

                file = DocumentGenerator.Instance.GeneratePDFFile(path, ENTITIES.Constants.PRECUPON_PDF_NAME, true);

                if (file.Length > 0 && File.Exists(file))
                {
                    DocumentGenerator.Instance.OpenFile(file);
                }
            }
            catch (Exception exception)
            {
                GlobalExceptionProcessing.ShowErrorException(exception);
            }
        }
    }
}
