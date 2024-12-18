#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : BLFIFAP
 * Descripcion   : Lógica de Negocio para FIFAP
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 20-Nov-2013  223765  SGomez          1 - Se modifica procedimiento <getDigitalPromisoryId> para cambiar forma
 *                                          de obtención de secuencia para pagaré digital. Ahora se invoca modelo 
 *                                          de numeración autorizada / distribución consecutivos.
 *                                      2 - Se adiciona procedimiento <UpRequestNumberFNB> para actualización de
 *                                          número de pagaré y tipo de comprobante en la solicitud de venta.
 * 
 * 29-Oct-2013  221194  LDiuza         1 - Se crean los siguientes metodos para la funcionalidad de cupo parcial
 *                                         <GetPartialQuotaValidation>
 *                                         <GetSublinesAppliedToPartialQuota>
 *                                         <GetPartialQuota>
 * 27-Sep-2013  217616  lfernandez     1 - <GetExtraQuote> Se pasa del FIFAP a acá para ser llamado también
 *                                         desde FIUTC y se adiciona condición que la cuota usada sea mayor a
 *                                         cero
 * 25-Sep-2013  217737  lfernandez     1 - <RegisterDeudor> Se adiciona parámetro cliente
 * 10-Sep-2013  216757  lfernandez     1 - <getAvalibleArticles> Se asigna valor a la propiedad EditValue
 * 09-Sep-2013  216609  lfernandez     1 - <getAvalibleArticles> La creación del objeto se pasa del método
 *                                         del DAL a este método y se hace filtro que los artículos obtenidos
 *                                         no hagan parte de los genéricos
 * 05-Sep-2013  214195  mmira          1 - <getAvalibleArticles> Se adiciona la fecha de venta como parámetro. 
 * 30-Ago-2013  211609  lfernandez     1 - <validateBill> Se modifican los parámetros de facturas y fechas
 *                                          para que puedan ser nulos
 * 30-Ago-2013  215374  jaricapa       1 - Se modifica «saveDeudorData» validando el resultado de la actualización de datos en ge_subscriber.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.ComponentModel.Extended;

using SINCECOMP.FNB.UI; //Agordillo

namespace SINCECOMP.FNB.BL
{
    /// <summary>
    /// Lógica de Negocio para FIFAP
    /// </summary>
    internal class BLFIFAP
    {
        DALFIFAP _DALFIFAP = new DALFIFAP();
        BLGENERAL _general = new BLGENERAL();
        IFIFAP ififap_; //Agordillo

        public DataFIFAP getSubscriptionData(Int64 subcription)
        {
            return _DALFIFAP.getSubscriptionData(subcription);
        }

        /// <summary>
        /// Valida las facturas y fechas
        /// </summary>
        /// <param name="subscriptionId">Suscripción</param>
        /// <param name="billId1">Factura 1</param>
        /// <param name="billId2">Factura 2</param>
        /// <param name="billDate1">Fecha factura 1</param>
        /// <param name="billDate2">Fecha factura 2</param>
        /// <returns>Es válido?</returns>
        public Boolean validateBill(
            Int64 subscriptionId, 
            Int64? billId1, 
            Int64? billId2, 
            DateTime? billDate1, 
            DateTime? billDate2)
        {
            return _DALFIFAP.validateBill(subscriptionId, billId1, billId2, billDate1, billDate2);
        }

        public List<ExtraQuote> getExtraQuotes(Int64 subcriptionId)
        {
            return _DALFIFAP.getExtraQuote(subcriptionId);
        }

        /// <summary>
        /// Registra el deudor
        /// </summary>
        /// <param name="subscriberId">Código del cliente de la suscripción</param>
        /// <param name="promissory">Información del deudor</param>
        public void RegisterDeudor(Int64? subscriberId, Promissory promissory)
        {
            _DALFIFAP.RegisterDeudor(subscriberId, promissory);
        }

        public void RegisterCosigner(Promissory promissory)
        {
            _DALFIFAP.RegisterCosigner(promissory);
        }

        /***********************************************************************************
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========     ===================   ===============================================
        04-10-2014    Llozada               RQ 1218: Creación.
        ***********************************************************************************/
        public void RegisterCosigner(String IdentTypeCodeudor, String IdentificationCodeudor, String FlagDeudorSolidario,
                                     long PackageId, String IdentTypeDeudor, String IdentificationDeudor)
        {
            _DALFIFAP.RegisterCosigner(IdentTypeCodeudor,IdentificationCodeudor, FlagDeudorSolidario, PackageId, IdentTypeDeudor, IdentificationDeudor);
        }

        public Int64 RegisterSale(String XML)
        {
            return _DALFIFAP.RegisterSale(XML);
        }

        public void registerQuotaTransfer(Int64 packageId)
        {
            _DALFIFAP.registerQuotaTransfer(packageId);
        }


        public List<ArticleValue> getAvalibleArticles(
            Int64 supplierId,
            Int64 chanelId,
            Int64 geoLocation,
            Int64 categoryId,
            Int64 subcategoryId,
            Boolean gracePeriod,
            DateTime dateBill,
            DateTime saleDate,
            String flagCuotaFija)
        {
            DataTable articleDataTable;
            List<ArticleValue> articleList = new List<ArticleValue>();
            DateTime dateBillGrace;
            String genericArticles;

            //  Obtiene la lista de artículos genéricos
            genericArticles = _DALFIFAP.getParam("COD_GENERIC_ITEMS");

            //  Le adiciona los separadores
            genericArticles = "," + genericArticles + ",";

            try
            {
                //Agordillo 29/09/2015 Cambio.6853
                //Si la venta es de Materiales se consultan los Articulos diponibles de este tipo
                if (ififap_.VentaMateriales)
                {
                    // Consultar el item materiales
                    articleDataTable = _DALFIFAP.getAvalibleArtMaterial(
                       supplierId,
                       chanelId,
                       geoLocation,
                       categoryId,
                       subcategoryId,
                       gracePeriod,
                       dateBill,
                       saleDate,
                       flagCuotaFija);

                }
                else
                {
                    //  Obtiene en una tabla los artículos disponibles
                    articleDataTable = _DALFIFAP.getAvalibleArticles(
                        supplierId,
                        chanelId,
                        geoLocation,
                        categoryId,
                        subcategoryId,
                        gracePeriod,
                        dateBill,
                        saleDate,
                        flagCuotaFija);
                }
            }
            catch 
            {
                //  Obtiene en una tabla los artículos disponibles
                articleDataTable = _DALFIFAP.getAvalibleArticles(
                    supplierId,
                    chanelId,
                    geoLocation,
                    categoryId,
                    subcategoryId,
                    gracePeriod,
                    dateBill,
                    saleDate,
                    flagCuotaFija);
            }

            foreach (DataRow row in articleDataTable.Rows)
            {
                //  Si el artículo no es un artículo genérico y tiene plan de financiación

                if (!genericArticles.Contains("," + row[0].ToString() + ",") &&
                    !String.IsNullOrEmpty(row[5].ToString()))
                {
                    String[] tmpFinanInfo = row[5].ToString().Split('|');


                    int days = Int32.Parse(tmpFinanInfo[4]);
                    if (days > 0)
                    {
                        gracePeriod = true;
                        dateBillGrace = DateTime.Now.AddDays(days);
                    }
                    else
                    {
                        dateBillGrace = DateTime.Now;
                    }

                    Double value = Double.Parse(row[4].ToString());

                    Double vat;

                    if (row[6] == null)
                    {
                        vat = 0;
                    }
                    else
                    {
                        vat = Double.Parse(row[6].ToString());
                    }

                    Double percent;

                    if (tmpFinanInfo[3] == null)
                    {
                        percent = 0;
                    }
                    else
                    {
                        percent = Double.Parse(tmpFinanInfo[3].ToString());
                    }

                    Article tmpArticle = new Article(
                        Convert.ToInt64(row[0]),
                        row[1].ToString(),
                        row[3].ToString(),
                        value,
                        vat,
                        Convert.ToInt32(tmpFinanInfo[1]),
                        Convert.ToInt32(tmpFinanInfo[2]),
                        Convert.ToInt32(tmpFinanInfo[0]),
                        dateBillGrace,
                        percent,
                        Convert.ToInt64(row[7]),
                        Convert.ToInt64(row[8]),
                        Convert.ToInt64(row[9]),
                        Convert.ToInt64(row[10]));

                    tmpArticle.EditValue = Convert.ToDouble(row[4]) == 0;

                    articleList.Add(new ArticleValue(tmpArticle.ArticleId, tmpArticle.ArticleDescription, tmpArticle));
                }
            }

            return articleList;
        }

        /// <summary>
        /// Obtiene próximo consecutivo para Pagaré Digital
        /// </summary>
        /// <param name="vouchType">Tipo comprobante</param>
        /// <param name="operUnit">Unidad operativa (No puede ser un valor nulo)</param>       
        /// <returns>Consecutivo</returns>
        public Int64 getDigitalPromisoryId(Int64? vouchType, Int64? operUnit)
        {
            return _DALFIFAP.getDigitalPromisoryId(vouchType, operUnit);
        }

        public string getParam(String sbParam)
        {
            return _DALFIFAP.getParam(sbParam);
        }

        public Int64 getDocumentType(Int64 documentTypeId)
        {
            return _DALFIFAP.getDocumentType(documentTypeId);
        }

        public Boolean isValidForSaleFNB(Int64 documentTypeId, string identification, string lastName)
        {
            return _DALFIFAP.isValidForSaleFNB(documentTypeId, identification, lastName);
        }

        public string processResponseWS(string response, Int64 identType, string identification, out Int64? resConsId)
        {
            return _DALFIFAP.processResponseWS(response, identType, identification,out resConsId);
        }

        public String getConstantValue(string cName)
        {
            return _DALFIFAP.getConstantValue(cName);
        }

        public static List<PromissoryPagare> FlistPromissoryPagare(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner, String descPrinter)
        {
            Boolean blControl = true;
            String[] ctrlReporte = descPrinter.Split('|');
            Int64 numCopy = Convert.ToInt64(ctrlReporte[0].ToString());
            List<PromissoryPagare> ListPromissory = new List<PromissoryPagare>();
            DataTable TBPromissory = DALFIFAP.FtrfPromissory(nuPackageId, sbPromissoryTypeDebtor, sbPromissoryTypeCosigner);
            if (TBPromissory != null)
            {
                for (Int64 i = 1; i <= numCopy; i++)
                {
                    foreach (DataRow row in TBPromissory.Rows)
                    {
                        PromissoryPagare RowTBPromissory = new PromissoryPagare(row, blControl, ctrlReporte[i].ToString()); //blControl
                        ListPromissory.Add(RowTBPromissory);
                        //blControl = false;
                    }
                }
            }

            return ListPromissory;
        }


        public void doCommit()
        {
            _DALFIFAP.doCommit();
        }

        public static DataTable ValidateDocument(Int64 inuidenttype, String isbidentification, String isblastname)
        {
            return DALFIFAP.ValidateDocument(inuidenttype, isbidentification, isblastname);
        }

        public static DataTable FtrfArticle(Int64 nuPackageId)
        {
            return DALFIFAP.FtrfArticle(nuPackageId);
        }

        public void UpRequestSetNumberFNB(Int64 RequestId, Int64 numberFNB, Int64 operatingUnit, Int64 ProductId)
        {
            _DALFIFAP.UpRequestSetNumberFNB(RequestId, numberFNB, operatingUnit, ProductId);
        }

        /// <summary>
        /// Actualiza número y tipo comprobante de pagaré digital
        /// </summary>
        /// <param name="package">Tipo comprobante</param>
        /// <param name="vouchTyp">Tipo comprobante</param>
        /// <param name="operUnit">Unidad operativa</param>       
        /// <param name="number">Número pagaré</param>
        public void UpRequestNumberFNB(Int64 package, Int64 vouchTyp, Int64 operUnit, Int64 number)
        {
            _DALFIFAP.UpRequestNumberFNB(package, vouchTyp, operUnit, number);
        }

        public void UpRequestVoucherFNB(Int64 vouchTyp, Int64 operUnit, Int64 number)
        {
            _DALFIFAP.UpRequestVoucherFNB(vouchTyp, operUnit, number);
        }

        public void AnnulReqVoucherFNB(Int64 vouchTyp, Int64 number)
        {
            _DALFIFAP.AnnulReqVoucherFNB(vouchTyp,  number);
        }

        public void setConsultSale(Int64? ResConsId, Int64 SaleId)
        {
            _DALFIFAP.setConsultSale(ResConsId, SaleId);
        }

        public void validateNumberFNB(Int64 numberFNB, Int64 operatingUnit, Int64 ProductId)
        {
            _DALFIFAP.validateNumberFNB(numberFNB, operatingUnit, ProductId);
        }

        public Boolean isSubscriberBlocked(Int64 documentTypeId, string identification)
        { 
            return _DALFIFAP.isSubscriberBlocked(documentTypeId, identification);
        }

        public Boolean parcialQuota(Int64 subscriptionId, out Double transferQuotaValue)
        {
            return _DALFIFAP.parcialQuota(subscriptionId, out transferQuotaValue);
        }

        public String getLineDescription(Int64 LineId)
        {
            return _DALFIFAP.getLineDescription(LineId);
        }

        public void consultaDatacredito(Int64 identType, string identification, string sbApellido, out String sbresponse)
        {
            _DALFIFAP.consultaDatacredito(identType, identification, sbApellido, out sbresponse);
        }

        public Int32 numberBill(Int64 subscriptionId)
        {
            return _DALFIFAP.numberBill(subscriptionId);
        }

        public void saveBillSlope(Int64 billId, Int64 packageId)
        {
            _DALFIFAP.saveBillSlope(billId, packageId);

        }

        public Int32 validateVisit(Int64 subscriptionId, DateTime date)
        {
            return _DALFIFAP.validateVisit(subscriptionId, date);
        }

        /// <summary>
        /// Crea/Actualiza datos del Susbcriptor (Ge_subscriber)
        /// </summary>
        /// <param name="Ident">Tipo Idetificación</param>
        /// <param name="name">Nombre</param>
        /// <param name="lastName">Apellido</param>
        /// <param name="phone">Teléfono</param>
        /// <param name="email">Correo</param>
        /// <param name="identification">Número Identificación</param>
        /// <param name="option">I =Datos Codeudor - D= Datos del Deudor </param>
        /// <returns>Resultado de la actualización</returns>
        public bool saveDeudorData(
            Int32 Ident,
            String identification,
            String phone,
            String name,
            String lastName,
            String email,
            Int32 address,
            DateTime Birth,
            String gender,
            Int32 cvSt,
            Int32 school,
            Int32 profession,
            String option)
        {
            try
            {
                _DALFIFAP.saveDeudorData(Ident, identification, phone, name, lastName, email, address, Birth, gender, cvSt, school, profession, option);
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
                return false;
            }
            return true;
        }

        public void UpdateOrderActivityPack(Int64 packageId, Int64 orderId)
        {

            _DALFIFAP.UpdateOrderActivityPack(packageId, orderId);
        }

        public Promissory getRecentPromissoryInfo(Int64 identType, String identification)
        {
            Promissory promissory = _DALFIFAP.getRecentPromissoryInfo(identType, identification);

            if (string.IsNullOrEmpty(promissory.Identification))
            {
                promissory = _DALFIFAP.getSubscriberInfo(identType, identification);
            }
            return promissory;
        }

        public Promissory getLastCosigner(Int64 identType, String identification)
        {
            return _DALFIFAP.getLastCosigner(identType, identification);
        }

        public Int32 validateAvailability(Int64 operatingUnit, Int64 subscriptionId)
        {
            return _DALFIFAP.validateAvailability(operatingUnit, subscriptionId);
        }


        public Boolean validateCosigner(Int64 supplierId, String identification, Int32 identType)
        {

           return _DALFIFAP.validateCosigner(supplierId, identification, identType);
        }

        /*14-04-2014 HAltamiranda [RQ 6359]: Se crea el método que valida si el deudor tiene ventas previas*/
        public Boolean validateSalesDebtor(String identification, Int32 identType)
        {

            return _DALFIFAP.validateSalesDebtor(identification, identType);
        }

        /*03-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor puede ser 
                                        deudor solidario*/
        public Boolean validateCosigner(String identification, Int32 identType)
        {

            return _DALFIFAP.validateCosigner(identification, identType);
        }

        /*03-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor puede ser codeudor*/
        public Boolean validateCosigner(String identification, Int32 identType, String idenDeudor, Int32 idenTypeDeudor, String TrasladoCupo)
        {
            return _DALFIFAP.validateCosigner(identification, identType, idenDeudor, idenTypeDeudor, TrasladoCupo);
        }

        /*05-11-2014 Llozada [RQ 1218]: Se crea el método que valida si el contrato tiene cupo*/
        public Boolean validateQuotaContract(Int64 subscriptionId)
        {
            return _DALFIFAP.validateQuotaContract(subscriptionId);
        }

        /*05-10-2014 Llozada [RQ 1218]: Se crea el método que valida el cupo disponible del codeudor*/
        public Boolean validateQuotaCosigner(String identification, Int32 identType, Double valorVenta)
        {

            return _DALFIFAP.validateQuotaCosigner(identification, identType, valorVenta);
        }

        /*07-10-2014 Llozada [RQ 1218]: Se crea el método que valida si hay una configuración para que No requiera
                                        codeudor*/
        public Boolean validateNoCosigner(Int32 identType,String identification, Int64 contrato)
        {

            return _DALFIFAP.validateNoCosigner(identType, identification, contrato);
        }

        /// <summary>
        /// Obtiene la información del codeudor a partir del contrato ingresado
        /// </summary>
        /// <param name="cosignerContract">Contrato del codeudor</param>
        /// <returns></returns>
        public Promissory getCosignerBySusc(Int64 cosignerContract)
        {
            Promissory promissory = new Promissory();
            try
            {
                promissory = _DALFIFAP.getCosignerBySusc(cosignerContract);
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
            return promissory;
        }
        /// <summary>
        /// Obtiene la información del cliente a partir del tipo de ID y el número de ID
        /// </summary>
        /// <param name="cosignerContract">Contrato del codeudor</param>
        /// <returns></returns>
        public Promissory getSubscriberInfo(Int64 IdentTypeId, String identification)
        {
            Promissory promissory = null;
            try
            {
                promissory = _DALFIFAP.getSubscriberInfo(IdentTypeId,identification);
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
            return promissory;
        }
        //EveSan 18/Julio/2013
        public void UpdateAditionalValuesSalesFNB(Int64 packageId, Double QUOTA_APROX_MONTH, Double VALUE_APROX_INSURANCE, Double VALUE_TOTAL, String allowTransferQuota)
        {
            _DALFIFAP.UpdateAditionalValuesSalesFNB(packageId, QUOTA_APROX_MONTH, VALUE_APROX_INSURANCE, VALUE_TOTAL, allowTransferQuota);
        }


        //aecheverry disponibilidad
        // jhinestroza [3743] 12/02/2015: se agrega parametro canal de venta
        public bool fblValAvailable
        (  
            Int64 subscriptionId, 
            Int64? nuAddressId,                        
            DateTime? dtSaleDate,
            String chanelSale
        )
        {
            String response = _DALFIFAP.fsbValAvailable(subscriptionId, nuAddressId, dtSaleDate, chanelSale);

            if(response=="Y")
                return true;

            if (response == "N")
            {
                response = "La unidad operativa no posee disponibilidad";
            }

            _general.mensajeERROR(response);

           return false;
        }

        public void RegisterExtraQuotaFNB(Int64? nuExtraQuotaId, String SubscriptionId, Double? usedQuota)
        {
            if (nuExtraQuotaId != null && nuExtraQuotaId > 0 && usedQuota != null && usedQuota > 0 && !String.IsNullOrEmpty(SubscriptionId))
            {
                _DALFIFAP.RegisterExtraQuotaFNB(nuExtraQuotaId,Convert.ToInt64(SubscriptionId), usedQuota);
            }
        }

        /* SAO212016. Se crea método que consulta en la BD si el proveedor es Olímpica*/
        public bool isProvOlimpica(long? supplierId)
        {
            return _DALFIFAP.isProvOlimpica(supplierId);
        }

        /* SAO212016. Se crea método que consulta en la BD si el proveedor es Éxito*/
        public bool isProvExito(long? supplierId)
        {
            return _DALFIFAP.isProvExito(supplierId);
        }

        /// <summary>
        /// Obtiene la cuota a aplicar según el artículo a comprar.
        /// </summary>
        /// <param name="article">Articulo a Comprar</param>
        /// <returns>Cuota Extra</returns>
        public ExtraQuote GetExtraQuote(Article article, List<ExtraQuote> _extraQuota, Int64? saleChannel)
        {
            ExtraQuote extraQuote;
            List<ExtraQuotePriority> extraPriorityList = new List<ExtraQuotePriority>();

            for (int i = 0; i < _extraQuota.Count; i++)
            {
                if (_extraQuota[i].UsedQuote > 0)
                {
                    extraQuote = _extraQuota[i];

                    if (article.LineId == extraQuote.LineId &&
                        article.SublineId == extraQuote.SubLineId &&
                        article.SupplierId == extraQuote.SupplierId &&
                        saleChannel == extraQuote.SaleChanelId
                       )
                    {
                        //1. {Línea,Sublínea, Proveedor,Canal de Venta}
                        extraPriorityList.Add(new ExtraQuotePriority(1, extraQuote));
                        break; // Es la cuota extra con mayor prioridad.
                    }
                    else if (article.SublineId == extraQuote.SubLineId &&
                             article.SupplierId == extraQuote.SupplierId &&
                            saleChannel == extraQuote.SaleChanelId)
                    {
                        //2. {Sublínea, Proveedor, Canal de Venta}
                        extraPriorityList.Add(new ExtraQuotePriority(2, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                             article.SupplierId == extraQuote.SupplierId &&
                       saleChannel == extraQuote.SaleChanelId &&
                        extraQuote.SubLineId == null)
                    {
                        //3. {Línea, Proveedor, Canal de Venta, cualquier sublinea} 
                        extraPriorityList.Add(new ExtraQuotePriority(3, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                             article.SublineId == extraQuote.SubLineId &&
                            saleChannel == extraQuote.SaleChanelId &&
                        extraQuote.SupplierId == null)
                    {
                        //4. {Línea, Sublínea, Canal de Venta, cualquier proveedor} 
                        extraPriorityList.Add(new ExtraQuotePriority(4, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                        article.SublineId == extraQuote.SubLineId &&
                        article.SupplierId == extraQuote.SupplierId &&
                        extraQuote.SaleChanelId == null)
                    {
                        //5. {Línea, Sublínea, Proveedor, cualquier canal de venta} 
                        extraPriorityList.Add(new ExtraQuotePriority(5, extraQuote));
                    }
                    else if (article.SupplierId == extraQuote.SupplierId &&
                            saleChannel == extraQuote.SaleChanelId &&
                            extraQuote.LineId == null && extraQuote.SubLineId == null)
                    {
                        //6. {Proveedor, Canal de Venta, cualquier linea sublinea} 
                        extraPriorityList.Add(new ExtraQuotePriority(6, extraQuote));
                    }
                    else if (article.SublineId == extraQuote.SubLineId &&
                            saleChannel == extraQuote.SaleChanelId &&
                            extraQuote.SupplierId == null)
                    {
                        //7. {Sublínea, Canal de Venta, cualquier proveedor}
                        extraPriorityList.Add(new ExtraQuotePriority(7, extraQuote));
                    }
                    else if (article.SublineId == extraQuote.SubLineId &&
                             article.SupplierId == extraQuote.SupplierId)
                    {
                        //8. {Sublínea, Proveedor} 
                        extraPriorityList.Add(new ExtraQuotePriority(8, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                            saleChannel == extraQuote.SaleChanelId &&
                        extraQuote.SubLineId == null)
                    {
                        //9. {Línea, Canal de Venta, cualquier sublinea}
                        extraPriorityList.Add(new ExtraQuotePriority(9, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                             article.SupplierId == extraQuote.SupplierId &&
                            extraQuote.SubLineId == null)
                    {
                        //10. {Línea, Proveedor, cualquier sublinea} 
                        extraPriorityList.Add(new ExtraQuotePriority(10, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                             article.SublineId == extraQuote.SubLineId &&
                                extraQuote.SupplierId == null &&
                            extraQuote.SaleChanelId == null)
                    {
                        //11. {Línea, Sublínea, cualquier proveedor, cualquier canal de venta}
                        extraPriorityList.Add(new ExtraQuotePriority(11, extraQuote));
                    }
                    else if (saleChannel == extraQuote.SaleChanelId &&
                       extraQuote.LineId == null &&
                        extraQuote.SubLineId == null &&
                        extraQuote.SupplierId == null)
                    {
                        //12. {Canal de Venta, cualquier linea/sublinea/proveedor}
                        extraPriorityList.Add(new ExtraQuotePriority(12, extraQuote));
                    }
                    else if (article.SupplierId == extraQuote.SupplierId && extraQuote.LineId == null
                        && extraQuote.SubLineId == null &&
                        extraQuote.SaleChanelId == null)
                    {
                        //13. {Proveedor, cualquier linea/sublinea/canal de venta}
                        extraPriorityList.Add(new ExtraQuotePriority(13, extraQuote));
                    }
                    else if (article.SublineId == extraQuote.SubLineId &&
                       extraQuote.SaleChanelId == null && extraQuote.SupplierId == null)
                    {
                        //14. {Sublínea, cualquier canal de venta cualquier proveedor}
                        extraPriorityList.Add(new ExtraQuotePriority(14, extraQuote));
                    }
                    else if (article.LineId == extraQuote.LineId &&
                            extraQuote.SubLineId == null &&
                            extraQuote.SaleChanelId == null &&
                            extraQuote.SupplierId == null)
                    {
                        //15. {Línea}
                        extraPriorityList.Add(new ExtraQuotePriority(15, extraQuote));
                    }
                    else if (extraQuote.LineId == null &&
                            extraQuote.SubLineId == null &&
                            extraQuote.SaleChanelId == null &&
                            extraQuote.SupplierId == null)
                    {
                        extraPriorityList.Add(new ExtraQuotePriority(16, extraQuote));
                    }

                }
            }

            extraQuote = null;

            if (extraPriorityList.Count == 1)
            {
                extraQuote = extraPriorityList[0].ExtraQuote;
            }
            else if (extraPriorityList.Count > 0)
            {
                //Se ordena la lista. El primero es el que tiene mayor prioridad.
                extraPriorityList = ExtraQuotePriority.Sort(extraPriorityList);
                extraQuote = extraPriorityList[0].ExtraQuote;
            }

            return extraQuote;
        }
        //SAO 218364. Se crea la función para retornar la subcategoría.
        public Int64? getSubcategory(Int64 addressId)
        {
            return _DALFIFAP.getSubcategory(addressId);
        }

        /*SAO219168 aesguerra - Valida si hay visitas de FNB con medio por el cual se entero = CallCenter*/
        public Int64 getCallCenterId(Int64 subscriptionId)
        {
            return _DALFIFAP.getCallCenterId(subscriptionId);
        }

        public void clearCache()
        {
            _DALFIFAP.clearCache();
        }

        public bool GetPartialQuotaValidation(Int64 subscriptionId)
        {
            return OpenSystems.Common.Util.OpenConvert.StringOpenToBool(_DALFIFAP.GetPartialQuotaValidation(subscriptionId));
        }

        public List<OpenPropertyByControlBase> GetSublinesAppliedToPartialQuota()
        {
            List<OpenPropertyByControlBase> lstSublines = new List<OpenPropertyByControlBase>();

            DataTable _dt = _DALFIFAP.GetSublinesAppliedToPartialQuota();

            foreach (DataRow _dr in _dt.Rows)
            {
                OpenPropertyByControlBase tmp = new OpenPropertyByControlBase();

                tmp.Key = OpenSystems.Common.Util.OpenConvert.ToString(_dr["SUBLINE_ID"]);
                tmp.Text = OpenSystems.Common.Util.OpenConvert.ToString(_dr["DESCRIPTION"]);
                lstSublines.Add(tmp);
            }
            return lstSublines;
        }

        public Double GetPartialQuota(Int64 subscriptionId)
        {
            return _DALFIFAP.GetPartialQuota(subscriptionId);        
        }

        public bool GetLock(Int64 inuSusccodi)
        {
            return _DALFIFAP.GetLock(inuSusccodi);
        }

        public void ReleaseLock(Int64 inuSusccodi)
        {
            _DALFIFAP.ReleaseLock(inuSusccodi);
        }

        public DateTime FirstFeeDate(Int64 susccodi, DateTime billDate)
        {
            return _DALFIFAP.FirstFeeDate(susccodi, billDate);
        }

        public void RegisterAdditionalFNBInformation(Int64 packageId, Int64? cosignerSubscriptionId, Double? aproxMonthInsurance)
        {
            _DALFIFAP.RegisterAdditionalFNBInformation(packageId, cosignerSubscriptionId, aproxMonthInsurance);
        }

        /// <summary>
        /// Valida que el valor a pagar cumpla con la política de ajuste definida para la suscripción
        /// </summary>
        /// <param name="subscriptionId">Identificador de la suscripción</param>
        /// <param name="valueToPay">Valor a pagar</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion
        /// =========   =========           =====================================
        /// 
        /// 11-02-2014  AEcheverry.SAO232448  1 - Creacion ValidateValueToPay
        /// </changelog>        
        public void ValidateValueToPay(long? subscriptionId, Decimal valueToPay)
        {
            /* Se ejecuta servicio que valida el valor a pagar especificado en las condiciones
             * de financiación */
            _DALFIFAP.ValidateValueToPay(subscriptionId, valueToPay);
        }


        /// <summary>
        /// Obtiene el valor total del cupo extra
        /// </summary>
        /// <param name="subscriptionId">Id de la suscripción</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 12-08-2014   KCienfuegos.NC492  1 - creación        
        ///                                 
        /// </changelog>
        public Double getTotalExtraQuote(Int64 subscriptionId)
        {
            return _DALFIFAP.getTotalExtraQuote(subscriptionId);
        }

        /// <summary>
        /// Registra la observación de la orden de registro de venta FNB
        /// </summary>
        /// <param name="subscriptionId">Id del paquete</param>
        /// <param name="subscriptionId">Observación</param>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 13-08-2014   KCienfuegos.RNP54  1 - creación        
        ///                                 
        /// </changelog>
        public void RegCommentPackageSale(Int64 packageId, String sbComment)
        {
            _DALFIFAP.RegCommentPackageSale(packageId, sbComment);
        }


        /// <summary>
        /// Obtiene la información de venta teniendo en cuenta la identificación, tipo de id y contrato
        /// </summary>
        /// <param name="identType">tipo de id</param>
        /// <param name="identification">Identificación</param>
        /// <param name="subscriptionId">id del contrato</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 03-09-2014  KCienfuegos.NC1920  1 - creación        
        ///                                 
        /// </changelog>
        public Promissory getRecentPromissoryInfoBySusc(Int64 identType, String identification, Int64 subscriptionId)
        {
            Promissory promissory = _DALFIFAP.getRecentPromissoryInfobySusc(identType, identification, subscriptionId);

            if (string.IsNullOrEmpty(promissory.Identification))
            {
                promissory = _DALFIFAP.getSubscriberInfoBySusc(identType, identification, subscriptionId);
            }
            return promissory;
        }


        /// <summary>
        /// Validar si existe más de un cliente con la misma identificación y tipo de identificación.
        /// </summary> 
        /// <param name="identType">tipo de id</param>
        /// <param name="identification">Identificación</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 03-09-2014  KCienfuegos.NC1920  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean SeveralsSubsWithSameId(String identification, Int32 identType)
        {
            return _DALFIFAP.SeveralsSubsWithSameId(identification, identType);
        }

        /// <summary>
        /// Actualiza el campo de sucursal.
        /// </summary> 
        /// <param name="identType">tipo de id</param>
        /// <param name="identification">Identificación</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 09-09-2014  KCienfuegos.RNP192  1 - creación        
        ///                                 
        /// </changelog>
        public void updatePointSale(Int64 packageId, Int64 pointSale)
        {
            _DALFIFAP.updatePointSale(packageId, pointSale);
        }

        public static void GetCommercialSegment(Int64 inususccodi, out String osbCommercSegment, out Int64 onuSegmentId)
        {
            String osbCommercSegm;
            Int64 onuSegmtId;
            DALFIFAP.GetCommercialSegment(inususccodi, out osbCommercSegm, out onuSegmtId);

            osbCommercSegment = osbCommercSegm;
            onuSegmentId = onuSegmtId;

        }

        /// <summary>
        /// Validar si el proveedor está habilitado para instalación de gasodomésticos.
        /// </summary> 
        /// <param name="inuSupplierId">id del proveedor</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 14-10-2014  KCienfuegos.RNP1179  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean isActiveForInstalling(Int32 inuSupplierId)
        {
            return _DALFIFAP.isActiveForInstalling(inuSupplierId);
        }

        /// <summary>
        /// Validar si la línea del artículo está configurada en el parámetro COD_LIN_ART.
        /// </summary> 
        /// <param name="inuLineId">id de la línea</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 14-10-2014  KCienfuegos.RNP1179  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean ValidateArticlesLine(Int32 inuLineId)
        {
            return _DALFIFAP.ValidateArticlesLine(inuLineId);
        }


        public void registerSaleInstall(Int64 inupackageId, Int64 inuSubscription, Int64 inuSupplierId)
        {

            _DALFIFAP.registerSaleInstall(inupackageId, inuSubscription, inuSupplierId);
        }

        /// <summary>
        /// Valida si tiene una venta empaquetada vigente
        /// </summary> 
        /// <param name="subscriptionId">id del contrato</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 27-10-2014  KCienfuegos.RNP1808  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean fblValidInstallDate(Int64 subscriptionId)
        {
            return _DALFIFAP.fblValidInstallDate(subscriptionId);
        }


        /// <summary>1.1
        /// Obtiene los artículos de venta válidos para Venta Empaquetada
        /// </summary> 
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 27-10-2014  KCienfuegos.RNP1808  1 - creación        
        ///                                 
        /// </changelog>
        public List<ArticleValue> getArticlesGasApplSale(
            Int64 supplierId,
            Int64 chanelId,
            Int64 geoLocation,
            Int64 categoryId,
            Int64 subcategoryId,
            Boolean gracePeriod,
            DateTime dateBill,
            DateTime saleDate)
        {
            DataTable articleDataTable;
            List<ArticleValue> articleList = new List<ArticleValue>();
            DateTime dateBillGrace;
            String genericArticles;

            //  Obtiene la lista de artículos genéricos
            genericArticles = _DALFIFAP.getParam("COD_GENERIC_ITEMS");

            //  Le adiciona los separadores
            genericArticles = "," + genericArticles + ",";

            //  Obtiene en una tabla los artículos disponibles
            articleDataTable = _DALFIFAP.getArticlesGasApplSale(
                supplierId,
                chanelId,
                geoLocation,
                categoryId,
                subcategoryId,
                gracePeriod,
                dateBill,
                saleDate);

            foreach (DataRow row in articleDataTable.Rows)
            {
                //  Si el artículo no es un artículo genérico y tiene plan de financiación
                if (!genericArticles.Contains("," + row[0].ToString() + ",") &&
                    !String.IsNullOrEmpty(row[5].ToString()))
                {
                    String[] tmpFinanInfo = row[5].ToString().Split('|');


                    int days = Int32.Parse(tmpFinanInfo[4]);
                    if (days > 0)
                    {
                        gracePeriod = true;
                        dateBillGrace = DateTime.Now.AddDays(days);
                    }
                    else
                    {
                        dateBillGrace = DateTime.Now;
                    }

                    Double value = Double.Parse(row[4].ToString());

                    Double vat;

                    if (row[6] == null)
                    {
                        vat = 0;
                    }
                    else
                    {
                        vat = Double.Parse(row[6].ToString());
                    }

                    Double percent;

                    if (tmpFinanInfo[3] == null)
                    {
                        percent = 0;
                    }
                    else
                    {
                        percent = Double.Parse(tmpFinanInfo[3].ToString());
                    }

                    Article tmpArticle = new Article(
                        Convert.ToInt64(row[0]),
                        row[1].ToString(),
                        row[3].ToString(),
                        value,
                        vat,
                        Convert.ToInt32(tmpFinanInfo[1]),
                        Convert.ToInt32(tmpFinanInfo[2]),
                        Convert.ToInt32(tmpFinanInfo[0]),
                        dateBillGrace,
                        percent,
                        Convert.ToInt64(row[7]),
                        Convert.ToInt64(row[8]),
                        Convert.ToInt64(row[9]),
                        Convert.ToInt64(row[10]));

                    tmpArticle.EditValue = Convert.ToDouble(row[4]) == 0;

                    articleList.Add(new ArticleValue(tmpArticle.ArticleId, tmpArticle.ArticleDescription, tmpArticle));
                }
            }

            return articleList;
        }


        public void UpdateGasFNBSale(Int64 inuSubscription, Int64 inupackageId, String isbFlag)
        {
            _DALFIFAP.UpdateGasFNBSale(inuSubscription, inupackageId, isbFlag);
        }

        /// <summary>
        /// Registra la fecha de entrega de la venta
        /// </summary> 
        /// <param name="packageId">id del paquete</param>
        /// <param name="deliverDate">fecha de entrega</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 20-01-2015  KCienfuegos.ARA5737  1 - creación        
        ///                                 
        /// </changelog>
        public void registerDelivDate(Int64 inupackageId, String deliverDate)
        {
            _DALFIFAP.registerDelivDate(inupackageId, deliverDate);
        }


        /// <summary>
        /// Valida si tiene el número de facturas mínimas
        /// </summary> 
        /// <param name="subscriptionId">id del contrato</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 03-02-2015  KCienfuegos.NC4820  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean fblValidNumFactMin(Int64 subscriptionId)
        {
            return _DALFIFAP.fblValidNumFactMin(subscriptionId);
        }

        /*******************************************************************************************
        Historia de Modificaciones        
        * Team 3821, 3822, 3823
        * fnuComparacionCadenas: Metodo que compara 2 cadenas retornando el procentaje de similitud
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        28-01-2015    edwardh               Creación del metodo.
        ********************************************************************************************/
        public int fnuComparacionCadenas(string s, string t, out double porcentaje)
        {
            porcentaje = 0;

            // d es una tabla con m+1 renglones y n+1 columnas
            int costo = 0;
            int m = s.Length;
            int n = t.Length;
            int[,] d = new int[m + 1, n + 1];

            // Verifica que exista algo que comparar
            if (n == 0) return m;
            if (m == 0) return n;

            // Llena la primera columna y la primera fila.
            for (int i = 0; i <= m; d[i, 0] = i++) ;
            for (int j = 0; j <= n; d[0, j] = j++) ;


            /// recorre la matriz llenando cada unos de los pesos.
            /// i columnas, j renglones
            for (int i = 1; i <= m; i++)
            {
                // recorre para j
                for (int j = 1; j <= n; j++)
                {
                    /// si son iguales en posiciones equidistantes el peso es 0
                    /// de lo contrario el peso suma a uno.
                    costo = (s[i - 1] == t[j - 1]) ? 0 : 1;
                    d[i, j] = System.Math.Min(System.Math.Min(d[i - 1, j] + 1,  //Eliminacion
                                  d[i, j - 1] + 1),                             //Inserccion 
                                  d[i - 1, j - 1] + costo);                     //Sustitucion
                }
            }

            /// Calculamos el porcentaje de cambios en la palabra.
            if (s.Length > t.Length)
                porcentaje = ((double)d[m, n] / (double)s.Length);
            else
                porcentaje = ((double)d[m, n] / (double)t.Length);
            return d[m, n];
        }

        public void guardarDatosActualizar(Int64 packageId, String nombreActual, String nombreNuevo, String apellidoActual, String apellidoNuevo, String idActual, String idNuevo, String tipo_cambio, String tagname, String tagnamemot, String packtypeid, String idcliente, Int64 idcontato)
        {
            _DALFIFAP.guardarDatosActualizar(packageId, nombreActual, nombreNuevo, apellidoActual, apellidoNuevo, idActual, idNuevo, tipo_cambio, tagname, tagnamemot, packtypeid, idcliente, idcontato);
        }

        /// <summary>
        /// Valida si tiene solicitud de venta Brilla cuya orden de registro de venta no ha sido generada.
        /// </summary> 
        /// <param name="subscriptionId">id del contrato</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 04-05-2015  KCienfuegos.SAO313402  1 - creación        
        ///                                 
        /// </changelog>
        public Int32 fnuPendingSaleOrder(Int64 subscriptionId)
        {
            return _DALFIFAP.fnuPendingSaleOrder(subscriptionId);
        }


        /*************************************************************************************************
        * Historia de Modificaciones        
        * SAO.334390 Cuota Fija
        * fnuGetMaxNumberFees: Funcion que retorna el numero Maximo de cuotas de un plan de financiacion
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        03/08/2015    edwardh               Creación del metodo.
        **************************************************************************************************/
        public Int32 fnuGetMaxNumberFees(Int64 PlandifeId)
        {
            return _DALFIFAP.fnuGetMaxNumberFees(PlandifeId);
        }

        /*************************************************************************************************
        * Historia de Modificaciones        
        * CASO. Puerta a Puerta- Venta de Materiales
        * iblValMaterialSales: Valida si se puede ejecutar la venta de materiales FNB
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        29/09/2015    agordillo              Creación del metodo.
        **************************************************************************************************/
        public Boolean fblValidMaterialSales()
        {
            return _DALFIFAP.iblValMaterialSales();
        }

        public void setIfifap(IFIFAP clase)
        {
            this.ififap_ = clase;
        }

        //Inicio CASO 200-85
        public Boolean BLFBLAplicaParaGDC(string sbParemtroGlobal)
        {
            return _DALFIFAP.DALFBLAplicaParaGDC(sbParemtroGlobal);
        }

        public Boolean BLFBLAplicaParaEfigas(string sbParemtroGlobal)
        {
            return _DALFIFAP.DALFBLAplicaParaEfigas(sbParemtroGlobal);
        }

        public static void PRGETINFOCODEUDOR(String isbIdentification_oldBL, String isbIdentification_newBL, out Int64 onuSubscriberId_oldBL, out Int64 onuSubscriberId_newBL, out Int64 onuCodigoErrorBL, out String osbMensajeErrorBL)
        {
            //Int64 onuSubscriberIdoldBL;
            //Int64 onuSubscriberIdnewBL;
            //Int64 onuCodigoError_BL;
            //String osbMensajeError_BL;

            DALFIFAP.PRGETINFOCODEUDOR(isbIdentification_oldBL, isbIdentification_newBL, out onuSubscriberId_oldBL, out onuSubscriberId_newBL, out onuCodigoErrorBL, out osbMensajeErrorBL);

            //onuSubscriberId_oldBL = onuSubscriberIdoldBL;
            //onuSubscriberId_newBL = onuSubscriberIdnewBL;
            //onuCodigoErrorBL = onuCodigoError_BL;
            //osbMensajeErrorBL = osbMensajeError_BL;

        }

        public Boolean fblValidCanFact(Int64 subscriptionId)
        {
            return _DALFIFAP.fblValidCanFact(subscriptionId);
        }
        //Fin CASO 200-85

        //Incio 200-310
        public Int64 BLDALFNUCANTVENTSINCANC(Int64 inuIdentTypeCodeudor, String inuIdentCodeudor)
        {
            return _DALFIFAP.DALFNUCANTVENTSINCANC(inuIdentTypeCodeudor, inuIdentCodeudor);
        }
        //Fin 200-310

        //Incio 200-854
        //Servicio para identificar retornar el codigo del PAGARE UNICO asociado al contrato
        public Int64 BLFNUPAGAREUNICO(Int64 subscriptionId)
        {
            return _DALFIFAP.DALFNUPAGAREUNICO(subscriptionId);
        }
        //Servicio para identificar el codigo del VOUCHER correspondiente al PAGARE UNICO
        public Int64 BLFSOLICITUDNUPAGAREUNICO(Int64 subscriptionId)
        {
            return _DALFIFAP.DALFSOLICITUDNUPAGAREUNICO(subscriptionId);
        }
        public Int64 BLFNUVOUCHER(Int64 subscriptionId, Int64 NUPAGAREUNICO)
        {
            return _DALFIFAP.DALFNUVOUCHER(subscriptionId, NUPAGAREUNICO);
        }
        //servicio para relacionar la solicitud de venta y el VOUCHER del PAGARE UNICO
        public static void BLRegisterVentaFNBVoucher(Int64 inupackage_id, Int64 inupagare_id, Int64 inuvoucher, Double inutotal_financiar, Int64 inutotal_cuotas, Double inucuota_inicial, Double inucosto_seguro)
        {
            DALFIFAP.DALRegisterVentaFNBVoucher(inupackage_id, inupagare_id, inuvoucher, inutotal_financiar, inutotal_cuotas, inucuota_inicial, inucosto_seguro);
        }

        public static void ConsultaSPUCodeudor(Int64 inupackage_id, Int64 inupagare_id, Int64 inususcription_id, out Int64 onususcription_codeudor_id, out String osbidentificacion_codeudor_OLD, out String osbidentificacion_codeudor_NEW)
        {
            DALFIFAP.ConsultaSPUCodeudor(inupackage_id, inupagare_id, inususcription_id, out onususcription_codeudor_id, out osbidentificacion_codeudor_OLD, out osbidentificacion_codeudor_NEW);
        }
        //Servicio para retornar si la OT de revision de documento de la solciitud de PAGARE UNICO fue legalizada con causal de EXITO o FALLO
        public Int64 BLFNUSOLICITUDPUATENDIDA(Int64 inuSoliciutd)
        {
            return _DALFIFAP.DALFNUSOLICITUDPUATENDIDA(inuSoliciutd);
        }
        //Fin 200-854    

        //Incio 200-850 Proveedor CENCOSUD
        public bool isProvCENCOSUD(long? supplierId)
        {
            return _DALFIFAP.isProvCENCOSUD(supplierId);
        }
        public void RegisterExtraQuotaFNBDeta(Int64? nuExtraQuotaId, String SubscriptionId, Double? usedQuota, Int64 inuPackage_id)
        {
            //if (nuExtraQuotaId != null && nuExtraQuotaId > 0 && usedQuota != null && usedQuota > 0 && !String.IsNullOrEmpty(SubscriptionId))
            //{
            _DALFIFAP.RegisterExtraQuotaFNBDeta(nuExtraQuotaId, Convert.ToInt64(SubscriptionId), usedQuota, inuPackage_id);
            //}
        }
        public void ValidarExtraQuotaFNBDeta(Int64 inuPackage_id)
        {
            _DALFIFAP.ValidarExtraQuotaFNBDeta(inuPackage_id);
        }        
        //Fin 200-850 Proveedor CENCOSUD 

        //CASO 200-468
        public Int64 FNUPROVEEDORVENTAMATERIALES(Int64? INSUPPLIER)
        {
            //1 - Existe el proveedor para venta de mantenimiento
            //0 - NO existe el proveedor para venta de mantenimiento
            return _DALFIFAP.FNUPROVEEDORVENTAMATERIALES(INSUPPLIER);
        }
        public Int64 FNUARTISUBLPROV(Int64? INSUPPLIER, Int64 INARTICLE)
        {
            //1 - Existe el proveedor para venta de mantenimiento
            //0 - NO existe el proveedor para venta de mantenimiento
            return _DALFIFAP.FNUARTISUBLPROV(INSUPPLIER, INARTICLE);
        }
        //CASO 200-468

        //CASO 200-750
        public Int64 FNUVALIDADIRECCION(Int64 NUADDRESS_ID)
        {
            //1 - Existe el proveedor para venta de mantenimiento
            //0 - NO existe el proveedor para venta de mantenimiento
            return _DALFIFAP.FNUVALIDADIRECCION(NUADDRESS_ID);
        }
        //CASO 200-750

        //CASO 200-755
        public Int64 FNUCUPOMANUAL(Int64 SubscriptionId)
        {
            //1 - Para los contratos que tienen cupo manual
            //0 - Para los contratos que NO tienen cupo manual
            return _DALFIFAP.FNUCUPOMANUAL(SubscriptionId);
        }
        //CASO 200-755

        //CASO 200-1164
        public Int64 FNUSEGUROVOLUNTARIO(Int64 InuArticulo)
        {
            //1 - Para identificar si existe el articulo como seguro voluntario
            //0 - Para identificar si NO existe el articulo como seguro voluntario
            return _DALFIFAP.FNUSEGUROVOLUNTARIO(InuArticulo);
        }

        public Int64 FNUEXISTESEGUROVOLUNTARIO(Int64 InuSUSCCODI)
        {
            //Esta funcion definira si el suscriptor puede volver a utilizar el seguro voluntario en otra venta 
            //debido a que en este momento del CASO solo se autirza la venta de un solo seguro voluntario por 
            //parte de CARDIF.
            //1 - Tiene un Seguro Voluntario asociado a un orden de entrega asignada aun sin legalizar. 
            //2 - Tiene un Seguro Voluntario asociado a un orden de entrega asignada legalizada y con diferido.
            //0 - No tiene ningun seguro voluntario asociado o en su defecto con diferidos pendienste.
            //-1 - Error se presento un inconvniente con el servicio.
            return _DALFIFAP.FNUEXISTESEGUROVOLUNTARIO(InuSUSCCODI);
        }
        public Int64 ldc_fnucomodato(Int64 InuSUSCCODI)
        {
            //Esta funcion definira si el suscriptor puede volver a utilizar el seguro voluntario en otra venta 
            //debido a que en este momento del CASO solo se autirza la venta de un solo seguro voluntario por 
            //parte de CARDIF.
            //(1) --> Para las subscripciones que estan registradas en la tabla LD_SUBS_COMO_DATO y estan dentro de un rango de fechas validos.
            //(0) --> Para aquellos que NO.
            return _DALFIFAP.ldc_fnucomodato(InuSUSCCODI);
        }
        public void PRREGISTROSEGUROVOLUNTARIO(Int64 InuSUSCCODI, Int64 InuPACKAGE_ID)
        {
            _DALFIFAP.PRREGISTROSEGUROVOLUNTARIO(InuSUSCCODI,InuPACKAGE_ID);
        }
        public Int64 FNUEDADVALIDASEGURO(String yearsDeudorSeguro)
        {
            //Retorna un valor indicado si la edad del deudor es valida para obtener el seguro          
            //0 - FALLO que NO es valido para utilizar el seguro
            //1 - EXITO que es valido para utilizar el seguro
            return _DALFIFAP.FNUEDADVALIDASEGURO(yearsDeudorSeguro);
        }

        public Int64 LDC_FNUREALIZAVENTA(Int64 v_solicitud_id)
        {
            //(1) --> Si la solicitud ingresada es igual a la minima obtenida en el cursor
            //(0) --> Si la solicitud ingresada es diferente a la minima obtenida en el cursor.
            //        Si no se Obtienen resultados.
            //        Si ocurre un error.
            return _DALFIFAP.LDC_FNUREALIZAVENTA(v_solicitud_id);
        }
        //CASO 200-1164

        //Comentariar hasta que se valide el tema el VOUCHER
        //Inicio CASO 200-1880
        //Servicio para identificar retornar el codigo del PAGARE UNICO asociado al contrato
        public Int64 BLFNUVALIDAPAGAREUNICO(Int64 InuPagareUnico)
        {
            return _DALFIFAP.DALFNUVALIDAPAGAREUNICO(InuPagareUnico);
        }

        //Identificar que el DEUDOR sea el 1er en un venta de FIFAP o Pagare Unico si el CODEUDOR es DEUDOR SOLIDARIO.
        public Int64 BLFNUDEUDORSOLIDARIO(String isbIdentification, Int64 inuIdentType, String isbIdenDeudor, Int64 inuIdenTypeDeudor)
        {
            return _DALFIFAP.DALFNUDEUDORSOLIDARIO(isbIdentification, inuIdentType, isbIdenDeudor, inuIdenTypeDeudor);
        }
        
        //Identificar que el DEUDOR sea el 1er en un venta de FIFAP o Pagare Unico si el CODEUDOR es DEUDOR SOLIDARIO.
        public Int64 BLFNUPARAMETROCADENA(String IsbCadena1, String IsbCadena2)
        {
            return _DALFIFAP.DALFNUPARAMETROCADENA(IsbCadena1, IsbCadena2);
        }

        //Fin CASO 200-1880

    }
}
