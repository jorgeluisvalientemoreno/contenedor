using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.CommercialSale.DAL;
using Ludycom.CommercialSale.Entities;
using System.Data;
using System.IO;
using OpenSystems.Printing.Common;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.CommercialSale.BL
{
    class BLLDC_FCVC
    {
        DALLDC_FCVC dalLDC_FCVC = new DALLDC_FCVC();
        DALUtilities dalUtilities = new DALUtilities();

        /// <summary>
        /// Se obtienen los datos básicos del cliente
        /// </summary>
        /// <param name="subscriber">Código del Cliente</param>
        /// <returns>Retorna una instancia de CustomerBasicData con los datos básicos del cliente</returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public CustomerBasicData GetCustomerBasicData(Int64 subscriber)
        {
            return dalLDC_FCVC.GetCustomerBasicData(subscriber);
        }

        /// <summary>
        /// Se obtienen los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna una instancia de QuotationBasicData con los datos básicos de la cotización/returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public QuotationBasicData GetQuotationBasicData(Int64 quotationId)
        {
            return dalLDC_FCVC.GetQuotationBasicData(quotationId);
        }

        /// <summary>
        /// Se obtiene el código del cliente dada la cotización
        /// </summary>
        /// <param name="quotationId">Código de la cotización</param>
        /// <returns>Retorna el id del cliente</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int64 GetQuotationCustomer(Int64? quotationId)
        {
            return dalLDC_FCVC.GetQuotationCustomer(quotationId);
        }

        /// <summary>
        /// Se valida si la cotización existe
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna un valor booleano indicando la existencia de la cotización</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Boolean QuotationExists(Int64 quotationId)
        {
            return dalLDC_FCVC.QuotationExists(quotationId);
        }

        /// <summary>
        /// Se obtiene la categoría de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la categoría de la dirección</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int16? GetCategory(Int64 addressId)
        {
            return dalLDC_FCVC.GetCategory(addressId);
        }

        /// <summary>
        /// Se obtiene la subcategoría de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la subcategoría de la dirección</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int16? GetSubcategory(Int64 addressId)
        {
            return dalLDC_FCVC.GetSubcategory(addressId);
        }

        /// <summary>
        /// Se obtiene la localidad de la dirección
        /// </summary>
        /// <param name="addressId">Id de la dirección</param>
        /// <returns>Retorna la localidad de la dirección</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int64 GetAdressLocation(Int64 addressId)
        {
            return dalLDC_FCVC.GetAdressLocation(addressId);
        }

        /// <summary>
        /// Se obtiene la localidad padre
        /// </summary>
        /// <param name="locationId">Id de la localidad</param>
        /// <returns>Retorna la localidad padre</returns>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 07-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int64 GetFatherLocation(Int64 locationId)
        {
            return dalLDC_FCVC.GetFatherLocation(locationId);
        }

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
        public List<QuotationTaskType> GetQuotedTaskType(Int64? quotationId)
        {
            DataTable dtquotationTaskType;
            List<QuotationTaskType> quotationTaskTypeList = new List<QuotationTaskType>();
            dtquotationTaskType = dalLDC_FCVC.GetQuotedTaskType(quotationId);

            foreach (DataRow item in dtquotationTaskType.Rows)
            {
                QuotationTaskType tmpQuotationTaskType = new QuotationTaskType(item);
                quotationTaskTypeList.Add(tmpQuotationTaskType);
            }

            return quotationTaskTypeList;   
        }

        /// <summary>
        /// Se obtienen items cotizados por tipos de trabajo
        /// </summary>
        /// <param name="quotationId">id de la cotización</param>
        /// <returns>Retorna los items cotizados por tipos de trabajo</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public List<QuotationItem> GetItemsByTaskType(Int64? quotationId, String taskTypeClass)
        {
            DataTable dtItemsTaskType;
            List<QuotationItem> quotationItemsList = new List<QuotationItem>();
            dtItemsTaskType = dalLDC_FCVC.GetItemsByTaskTypeClass(quotationId, taskTypeClass);

            foreach (DataRow item in dtItemsTaskType.Rows)
            {
                QuotationItem tmpQuotationItem = new QuotationItem(item);
                quotationItemsList.Add(tmpQuotationItem);
            }

            return quotationItemsList;  
        }

        /// <summary>
        /// Se obtienen las actividades de un tipo de trabajo
        /// </summary>
        /// <returns>Retorna las actividades válidas para cotizar</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public List<ActivityTaskType> GetActivitiesByTaskType(String query)
        {
            DataTable dtActivities;
            List<ActivityTaskType> activitiesList = new List<ActivityTaskType>();
            dtActivities = dalUtilities.GetListOfValue(query);

            foreach (DataRow item in dtActivities.Rows)
            {
                ActivityTaskType tmpActivity = new ActivityTaskType(item);
                activitiesList.Add(tmpActivity);
            }

            return activitiesList;
        }

        /// <summary>
        /// Se obtienen las actividades con los tipos de trabajo
        /// </summary>
        /// <returns>Retorna las actividades válidas para cotizar</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public List<ActivityTaskType> GetActivities()
        {
            DataTable dtActivities;
            List<ActivityTaskType> activitiesList = new List<ActivityTaskType>();
            dtActivities = dalLDC_FCVC.GetActivities();

            foreach (DataRow item in dtActivities.Rows)
            {
                ActivityTaskType tmpActivity = new ActivityTaskType(item);
                activitiesList.Add(tmpActivity);
            }

            return activitiesList;  
        }

        /// <summary>
        /// Se obtienen los items vigentes
        /// </summary>
        /// <returns>Retorna los items vigentes</returns>               
        public List<ItemCostList> getValidItems(Int64 costList)
        {
            DataTable dtItemsList = dalLDC_FCVC.getValidItems(costList);
            List<ItemCostList> itemsList = new List<ItemCostList>();

            foreach (DataRow item in dtItemsList.Rows)
            {
                ItemCostList tmpItem = new ItemCostList(item);
                itemsList.Add(tmpItem);
            }

            return itemsList;
        }

        /// <summary>
        /// Se registra la cotización
        /// </summary>
        /// <returns>Retorna el id de la cotización</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Int64 registerQuotationBasicData(QuotationBasicData quotationBasicData, Int64 customerId)
        {
            return dalLDC_FCVC.registerQuotationBasicData(quotationBasicData, customerId);
        }

        /// <summary>
        /// Se registran los tipos de trabajo por cotización
        /// </summary>
        /// <param name="quotationTaskType">instancia de QuotationTaskType</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void registerQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            dalLDC_FCVC.registerQuotationTaskType(quotationTaskType);
        }

        /// <summary>
        /// Se registra el nuevo item
        /// </summary>
        /// <param name="newItem">nuevo registro de ítem</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void registerItem(QuotationItem newItem)
        {
            dalLDC_FCVC.registerItem(newItem);
        }

        /// <summary>
        /// Se modifican datos básicos de la cotización
        /// </summary>
        /// <param name="quotationBasicData">Cotización a modificar</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void modifyQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            dalLDC_FCVC.modifyQuotationBasicData(quotationBasicData);
        }

        /// <summary>
        /// Se modifican los tipos de trabajo de la cotizacion
        /// </summary>
        /// <param name="quotationTaskType">Instancia de la clase QuotationTaskType</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void modifyQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            dalLDC_FCVC.modifyQuotationTaskType(quotationTaskType);
        }

        /// <summary>
        /// Se modifica el item
        /// </summary>
        /// <param name="item">item a modificar</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 21-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void modifyItem(QuotationItem item)
        {
            dalLDC_FCVC.modifyItem(item);
        }

        /// <summary>
        /// Se valida si el item existe
        /// </summary>
        /// <param name="itemId">Consecutivo del ítem</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 01-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Boolean ItemExists(Int64 itemId)
        {
            return dalLDC_FCVC.ItemExists(itemId);
        }

        /// <summary>
        /// Se envía cotización a OSF
        /// </summary>
        /// <param name="cotizacion">item a modificar</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void sendToOSF(QuotationBasicData cotizacion)
        {
            dalLDC_FCVC.sendToOSF(cotizacion);
        }

        /// <summary>
        /// Se marca el cliente especial
        /// </summary>
        /// <param name="customer">cliente</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 02-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void MarkSpecialCustomer(CustomerBasicData customer)
        {
            dalLDC_FCVC.MarkSpecialCustomer(customer);
        }

        /// <summary>
        /// Se imprime la cotización
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 09-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void PrintQuotation(Int64 quotationId)
        {
            string file = string.Empty;
            try
            {
                dalLDC_FCVC.PrintQuotation(quotationId);

                string path = Path.GetTempPath();

                file = DocumentGenerator.Instance.GeneratePDFFile(path, Entities.Constants.QUOTATION_PDF_NAME, true);

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

        /// <summary>
        /// Se imprime precupon
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 28/09/2018  josh                    1 - creación                   
        /// </changelog>
        public void PrintPreCupon(Int64 quotationId)
        {
            string file = string.Empty;
            try
            {
                dalLDC_FCVC.PrintPreCupon(quotationId);

                string path = Path.GetTempPath();

                file = DocumentGenerator.Instance.GeneratePDFFile(path, Entities.Constants.PRECUPON_PDF_NAME, true);

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

        /// <summary>
        /// Se actualiza cotizacion de OSF
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="deleteFinanCond">Indica si se deben borrar las condiciones de financiación</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 15-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void UpdateOSFQuotation(Int64 quotationId, Boolean deleteFinanCond)
        {
            dalLDC_FCVC.UpdateOSFQuotation(quotationId, deleteFinanCond);
        }

        /// <summary>
        /// Se valida si tiene condiciones de financiación
        /// </summary>
        /// <param name="quotationId">Id de la cotización</param>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 15-11-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Boolean HasFinancCondition(Int64 quotationId)
        {
            return dalLDC_FCVC.HasFinancCondition(quotationId);
        }

        //Caso 200-2000
        public Int64 AplicaEntrega(String nomEntrega)
        {
            Int64 val = 0;
            if (dalLDC_FCVC.AplicaEntregaxCAso(nomEntrega))
            {
                val = 1;
            }
            return val;
        }

        //Caso 200-1640
        public Object getParam(String sbParam, String tipo)
        {
            return dalLDC_FCVC.getParam(sbParam, tipo);
        }

        //12.07.18
        //Servicios Diseñados por el Ing. Sebastian Tapias para el Manejo de las nuevas condiciones de la Forma
        public void proRegistraComercial(Int64 inuPackageId, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proRegistraComercial(inuPackageId, inuContratista, inuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proRegistraComercialItem(Int64 inuPackageId, Int64 inuConsecutivo, Int64 inuIditem, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proRegistraComercialItem(inuPackageId, inuConsecutivo, inuIditem, isbClassItem, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaComercial(Int64 inuPackageId, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proActualizaComercial(inuPackageId, inuContratista, inuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        public void proActualizaComercialItem(Int64 inuConsecutivo, Int64 inuIditem, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proActualizaComercialItem(inuConsecutivo, inuIditem, isbClassItem, isbOperacion, out onuErrorCode, out osbErrorMessage);
        }

        public void proEliminaComercialItem(Int64 inuConsecutivo, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proEliminaComercialItem(inuConsecutivo, out onuErrorCode, out osbErrorMessage);
        }

        public void proCargaComercial(Int64 inuPackageId, out Int64 onuContratista, out Int64 onuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.proCargaComercial(inuPackageId, out onuContratista, out onuOperatingUnit, out onuErrorCode, out osbErrorMessage);
        }

        //Inicio OSF-1492
        public void registerAIUQuotation(Double InuQuotationId, Double InuAIUporcentate)
        {
            dalLDC_FCVC.registerAIUQuotation(InuQuotationId, InuAIUporcentate);
        }
        public void actualizaAIUQuotation(Double InuQuotationId, Double InuAIUporcentate)
        {
            dalLDC_FCVC.actualizaAIUQuotation(InuQuotationId, InuAIUporcentate);
        }
        public Double obtieneAIUQuotation(Double InuQuotationId)
        {
            return dalLDC_FCVC.obtieneAIUQuotation(InuQuotationId);
        }
        public Double numeroParametro(String isbNombreParametro)
        {
            return dalLDC_FCVC.numeroParametro(isbNombreParametro);
        }
        public String cadenaParametro(String isbNombreParametro)
        {
            return dalLDC_FCVC.cadenaParametro(isbNombreParametro);
        }
        //Fin OSF-1492

        //Inicio Servicios OSF-3104
        //Servicio para validar actividad de cargo por conexion industrial
        public Double ExisteActividadCargoConexionIndustrial(Double nuActividad)
        {
            return dalLDC_FCVC.ExisteActividadCargoConexionIndustrial(nuActividad);
        }

        //Servicio para validar actividad de inspeccion/certificacion industrial
        public Double ExisteActividadInspecCertificaIndustrial(Double nuActividad)
        {
            return dalLDC_FCVC.ExisteActividadInspecCertificaIndustrial(nuActividad);
        }
        //Fin Servicios OSF-3104

    }
}
