#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : DALFIHOS
 * Descripcion   : Clase de acceso a la base de datos para la ayuda de venta
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 05-Sep-2013  212246  lfernandez     1 - <getAvalibleArticles> Se modifica para que devuelva la lista de
 *                                         artículos en un dataTable
 *                                     2 - <getAvalibleArticles2> Se elimina método
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
//using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.DAL
{
    class DALFIHOS
    {
        public static void CreditQuotaData(Int64 inuidenttype, String inuidentification, out Int64 onususccodi, out Int64 onuasignedquote, out Int64 onuusedquote, out Int64 onuavaliblequote)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.CreditQuotaData"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuidenttype", DbType.Int64, inuidenttype);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidentification", DbType.String, inuidentification);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onususccodi", DbType.Int64, 8);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuasignedquote", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuusedquote", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuavaliblequote", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onususccodi = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onususccodi"));
                onuasignedquote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuasignedquote"));
                onuusedquote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuusedquote"));
                onuavaliblequote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuavaliblequote"));
            }
        }

        /// <summary>
        /// Obtiene la lista de artículos disponibles como lista y dataTable
        /// </summary>
        /// <param name="supplierId">Contratista</param>
        /// <param name="chanelId">Canal de ventas</param>
        /// <param name="geoLocation">Ubicación geográfica</param>
        /// <param name="categoryId">Categoría</param>
        /// <param name="subcategoryId">Subcategoría</param>
        /// <param name="articleList">Lista de artículos</param>
        /// <param name="articleTable">Artículos en dataTable</param>
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
            DataSet articleDataSet = new DataSet("Articles");
            ArticleFIHOS tmpArticle;
            String[] tmpFinanInfo;
            BLGENERAL general = new BLGENERAL();

            articleList = new List<ArticleValue2>();
           // general.mensajeOk("El Valor del flag es en FIHOS flagCuotaFija: " + flagCuotaFija);

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getAvalibleArticle"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuplierId", DbType.Int64, supplierId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inugeogra_location", DbType.Int64, geoLocation);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSale_Chanel_Id", DbType.Int64, chanelId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCategori_Id", DbType.Int64, categoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcateg_Id", DbType.Int64, subcategoryId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "ocuArtList");
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDate", DbType.String, null);
                OpenDataBase.db.AddInParameter(cmdCommand, "ivaPlan_finan", DbType.String, flagCuotaFija);
                OpenDataBase.db.LoadDataSet(cmdCommand, articleDataSet, "Articles");
                
            }

            if (articleDataSet.Tables["Articles"] != null)
            {
                articleTable = articleDataSet.Tables["Articles"];
                //general.mensajeOk("tamaño articleTable: " + articleTable.Rows.Count);

                foreach (DataRow row in articleTable.Rows)
                {
                    //general.mensajeOk("tamaño row: " + row+":" + row[5].ToString());
                    if (!String.IsNullOrEmpty(row[5].ToString()))
                    {
                        tmpFinanInfo = row[5].ToString().Split('|');

                        tmpArticle = new ArticleFIHOS(
                            Convert.ToString(row[0]), 
                            row[1].ToString(), 
                            row[3].ToString(), 
                            Convert.ToDouble(row[4]), 
                            Convert.ToDouble(row[6]), 
                            Convert.ToInt32(tmpFinanInfo[1]), 
                            Convert.ToInt32(tmpFinanInfo[2]), 
                            Convert.ToInt32(tmpFinanInfo[0]), 
                            DateTime.Today, 
                            Convert.ToDouble(tmpFinanInfo[3]), 
                            Convert.ToInt64(tmpFinanInfo[4]));

                        articleList.Add(new ArticleValue2(
                            tmpArticle.ArticleId, 
                            tmpArticle.ArticleDescription, 
                            tmpArticle));
                    }
                }
               // general.mensajeOk("tamaño articleList: " + articleList.Count);
            }            
        }

        /*18-02-2015 Llozada [RQ 1841]: Se crea función que trae los datos correspondientes al plan de financiación
                                        seleccionado en la forma de simulación*/
        public String getPlanFinanCF(long IdPlanDife)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fsbInfoPlanDife"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPldicodi", DbType.Int64, IdPlanDife);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (string)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        //GetSubcriptionData
        public DataFIFAP getSubscriptionData(Int64 subscription)
        {
            DataFIFAP dataFIFAP = new DataFIFAP();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getFIHOSInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, subscription);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbIdentType", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbIdentification", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsLastName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbAddress", DbType.String, 300);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAddress_Id", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuGeoLocation", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFullPhone", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuCategory", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubcategory", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuRedBalance", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAssignedQuote", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuUsedQuote", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAvalibleQuote", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSupplierName", DbType.String, 300);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSupplierId", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbPointSaleName", DbType.String, 300);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuPointSaleId", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblTransferQuote", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblCosigner", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblConsignerGasProd", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblModiSalesChanel", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSalesChanel", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbPromissoryType", DbType.String, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblRequiApproAnnulm", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblRequiApproReturn", DbType.Boolean, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSaleNameReport", DbType.String, 2000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbExeRulePostSale", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbPostLegProcess", DbType.String, 2000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuMinForDelivery", DbType.Int64, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblDelivInPoint", DbType.Boolean, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblLegDelivOrdeAuto", DbType.Boolean, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbTypePromissNote", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuInsuranceRate", DbType.Double, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "odtDate_Birth", DbType.DateTime, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbGender", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "odtPefeme", DbType.DateTime, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbValidateBill", DbType.String, 100);



                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64? valor = null;
                Double? valor1 = null;
                DateTime? valor2 = null;

                dataFIFAP.IdentType = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentType"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentType"));  //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentType"));
                dataFIFAP.Identification = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"));
                dataFIFAP.SubName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsName"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsName")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"));
                dataFIFAP.SubLastname = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"));// Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"));
                dataFIFAP.Address = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress"));
                dataFIFAP.AddressId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddress_Id"))) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddress_Id")); //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddress_Id"));
                dataFIFAP.GeoLocation = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuGeoLocation"))) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuGeoLocation")); //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuGeoLocation"));
                dataFIFAP.FullPhone = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone"));
                dataFIFAP.SubCategory = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubCategory"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubCategory")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubCategory"));
                dataFIFAP.CategoryId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCategory"))) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCategory")); //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCategory"));
                dataFIFAP.SubcategoryId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubcategory"))) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubcategory")); //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubcategory"));
                dataFIFAP.Balance = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuRedBalance"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuRedBalance")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuRedBalance"));
                dataFIFAP.AssignedQuote = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAssignedQuote"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAssignedQuote")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAssignedQuote"));
                dataFIFAP.UsedQuote = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuUsedQuote"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuUsedQuote")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuUsedQuote"));
                dataFIFAP.AvalibleQuota = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAvalibleQuote"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAvalibleQuote")); Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAvalibleQuote"));
                dataFIFAP.SupplierName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSupplierName"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSupplierName")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSupplierName"));
                dataFIFAP.InsuranceRate = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInsuranceRate"))) ? valor1 : Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInsuranceRate")); //Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInsuranceRate"));
                dataFIFAP.Category = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbCategory"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbCategory")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbCategory"));
                dataFIFAP.SubscriberId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId"))) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId")); //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId"));

                dataFIFAP.SupplierID = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSupplierId").ToString()) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSupplierId").ToString());

                dataFIFAP.PointSaleName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPointSaleName"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPointSaleName")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPointSaleName"));

                dataFIFAP.PointSaleId = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuPointSaleId").ToString()) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuPointSaleId").ToString());

                Boolean TransferQuota = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblTransferQuote").ToString(), out TransferQuota);
                dataFIFAP.TransferQuota = TransferQuota;


                Boolean RequiresCosigner = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblCosigner").ToString(), out RequiresCosigner);
                dataFIFAP.RequiresCosigner = RequiresCosigner;

                Boolean RequiCosigGASProd = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblConsignerGasProd").ToString(), out RequiCosigGASProd);
                dataFIFAP.RequiCosigGASProd = RequiCosigGASProd;

                Boolean SelectChanelSale = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblModiSalesChanel").ToString(), out SelectChanelSale);
                dataFIFAP.RequiCosigGASProd = SelectChanelSale;


                dataFIFAP.DefaultchanelSaleId = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSalesChanel").ToString()) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSalesChanel").ToString());


                dataFIFAP.PromissoryType = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPromissoryType"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPromissoryType")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPromissoryType"));

                Boolean RequiresApprovalAnulation = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblRequiApproAnnulm").ToString(), out RequiresApprovalAnulation);
                dataFIFAP.RequiresApprovalAnulation = RequiresApprovalAnulation;

                Boolean RequiresApprovalDevolution = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblRequiApproReturn").ToString(), out RequiresApprovalDevolution);
                dataFIFAP.RequiresApprovalDevolution = RequiresApprovalDevolution;

                dataFIFAP.SaleReportName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSaleNameReport"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSaleNameReport")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSaleNameReport"));

                dataFIFAP.PostSaleRule = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPostLegProcess"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPostLegProcess")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbExeRulePostSale"));


                dataFIFAP.MinValue = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuMinForDelivery").ToString()) ? valor1 : Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "onuMinForDelivery").ToString());

                Boolean PointDelivery = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblDelivInPoint").ToString(), out PointDelivery);
                dataFIFAP.PointDelivery = PointDelivery;

                Boolean LegalizeOrder = false;
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblLegDelivOrdeAuto").ToString(), out LegalizeOrder);
                dataFIFAP.LegalizeOrder = LegalizeOrder;


                dataFIFAP.ClientBirthdat = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "odtDate_Birth").ToString()) ? valor2 : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "odtDate_Birth").ToString());

                dataFIFAP.ClientGender = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));


                dataFIFAP.BillingDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "odtPefeme").ToString()) ? valor2 : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "odtPefeme").ToString());

                string validateBill = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbValidateBill"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbValidateBill")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));

                if (validateBill.Equals("Y")) { dataFIFAP.ValidateBill = true; } else { dataFIFAP.ValidateBill = false; }


                return dataFIFAP;
            }
        }

        /// <summary>
        /// Obtiene segmentación comercial del contrato.
        /// </summary> 
        /// <param name="inuSubscription">Contrato</param>
        /// <param name="osbCommercSegment">Segmentación</param>
        /// <param name="onuSegmentId">Id Segmentación</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 25-09-2014  KCienfuegos.RNP198  1 - creación        
        ///                                 
        /// </changelog>
        public static void GetCommercialSegment(Int64 inuSubscription, out String osbCommercSegment, out Int64 onuSegmentId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BCCOMMERCIALSEGMENTFNB.proGetAcronNameSegmbySusc"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSubscription);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSegmentId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSegment", DbType.String, 400);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onuSegmentId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSegmentId"));
                osbCommercSegment = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSegment"));
            }
        }

        /// <summary>
        /// Obtiene de cupo del contrato.
        /// </summary> 
        /// <param name="inuSubscription">Contrato</param>
        /// <param name="onuasignedquote">Cupo Asignado</param>
        /// <param name="onuusedquote">Cupo Usado</param>
        /// <param name="onuavaliblequote">Cupo Disponible</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 13-03-2015  KCienfuegos.NC5002  1 - creación        
        ///                                 
        /// </changelog>
        public static void SubscriptionQuotaData(Int64 inususccodi, out Int64 onuasignedquote, out Int64 onuusedquote, out Int64 onuavaliblequote)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.subscriptionQuotaData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inususccodi", DbType.Int64, inususccodi);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuasignedquote", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuusedquote", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuavaliblequote", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onuasignedquote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuasignedquote"));
                onuusedquote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuusedquote"));
                onuavaliblequote = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuavaliblequote"));
            }
        }
    }
}
