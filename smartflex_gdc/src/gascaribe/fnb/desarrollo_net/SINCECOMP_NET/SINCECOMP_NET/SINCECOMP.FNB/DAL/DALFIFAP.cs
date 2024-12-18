#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : DALFIFAP
 * Descripcion   : Acceso a  la base de datos para la forma FIFAP
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ==============  =====================================================================
 * 20-Nov-2013  223765  SGomez          1 - Se modifica procedimiento <getDigitalPromisoryId> para cambiar forma
 *                                          de obtención de secuencia para pagaré digital. Ahora se invoca modelo 
 *                                          de numeración autorizada / distribución consecutivos.
*                                       2 - Se adiciona procedimiento <UpRequestNumberFNB> para actualización de
 *                                          número de pagaré y tipo de comprobante en la solicitud de venta.
 * 
 * 29-Oct-2013  221194  LDiuza          1 - Se crean los siguientes metodos para la funcionalidad de cupo parcial
 *                                          <GetPartialQuotaValidation>
 *                                          <GetSublinesAppliedToPartialQuota>
 *                                          <GetPartialQuota>
 * 25-Sep-2013  217737  lfernandez      1 - <RegisterDeudor> Se adiciona parámetro cliente
 * 09-Sep-2013  216609  lfernandez      1 - <getAvalibleArticles> La creación del objeto Article se pasa al
 *                                          método del BL
 * 05-Sep-2013  214195  mmira           1 - <getAvalibleArticles> Se modifica para consultar el precio del artículo
 *                                          de acuerdo a la fecha de venta.
 * 30-Ago-2013  211609  lfernandez      1 - <validateBill> Se modifican los parámetros de facturas y fechas
 *                                          para que puedan ser nulos
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
using OpenSystems.Common.ExceptionHandler;
using System.IO;
using OpenSystems.Common.Util;

namespace SINCECOMP.FNB.DAL
{
    internal class DALFIFAP
    {

        //GetSubcriptionData
        public DataFIFAP getSubscriptionData(Int64 subscription)
        {
            DataFIFAP dataFIFAP = new DataFIFAP();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getFIFAPInfo"))
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
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbSaleNameReport", DbType.String, 200);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbExeRulePostSale", DbType.String, 200);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbPostLegProcess", DbType.String, 2000);
               OpenDataBase.db.AddOutParameter(cmdCommand, "onuMinForDelivery", DbType.Int64, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "oblDelivInPoint", DbType.Boolean, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "oblEditPointDel", DbType.Boolean, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "oblLegDelivOrdeAuto", DbType.Boolean, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbTypePromissNote", DbType.String, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "onuInsuranceRate", DbType.Double, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "odtDate_Birth", DbType.DateTime, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbGender", DbType.String, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "odtPefeme", DbType.DateTime, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbValidateBill", DbType.String, 100);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbLocation", DbType.String, 200);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbdepartment", DbType.String, 200);
               OpenDataBase.db.AddOutParameter(cmdCommand, "osbEmail", DbType.String, 200);

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
               //EVESAN 04/Julio/2013
               dataFIFAP.SelectChanelSale = SelectChanelSale;
               //////////////////////////////////////////////                
               //dataFIFAP.RequiCosigGASProd = SelectChanelSale;EVESAN


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

               //vhurtado Se agrega campo EditPointDel
               Boolean EditPointDel = false;
               Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblEditPointDel").ToString(), out EditPointDel);
               dataFIFAP.EditPointDel = EditPointDel;  

               Boolean LegalizeOrder = false;
               Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblLegDelivOrdeAuto").ToString(), out LegalizeOrder);
               dataFIFAP.LegalizeOrder = LegalizeOrder;


               dataFIFAP.ClientBirthdat = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "odtDate_Birth").ToString()) ? valor2 : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "odtDate_Birth").ToString());

               dataFIFAP.ClientGender = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));


               dataFIFAP.BillingDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "odtPefeme").ToString()) ? valor2 : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "odtPefeme").ToString());

               string validateBill = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbValidateBill"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbValidateBill")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));



               dataFIFAP.Location = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbLocation"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbLocation")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));


               dataFIFAP.Departament = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbdepartment"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbdepartment")); //Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbGender"));

               dataFIFAP.Email = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbEmail"));

               if (validateBill.Equals("Y")) { dataFIFAP.ValidateBill = true; } else { dataFIFAP.ValidateBill = false; }


               return dataFIFAP;
            }
        }

        /// <summary>
        /// Obtiene próximo consecutivo para Pagaré Digital
        /// </summary>
        /// <param name="vouchType">Tipo comprobante</param>
        /// <param name="operUnit">Unidad operativa (No puede ser un valor nulo)</param>       
        /// <returns>Consecutivo</returns>
        public Int64 getDigitalPromisoryId(Int64? vouchType, Int64? operUnit)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("pkConsecutiveMgr.GetNextDistNumber"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoComp", DbType.Int64, vouchType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, operUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumRef", DbType.Int64, null);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSigNum", DbType.Int64, 16);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64 seq = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSigNum"));
                return seq;
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fblValidateBills"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuBill1", DbType.Int64, billId1);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBill1", DbType.DateTime, billDate1);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuBill2", DbType.Int64, billId2);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBill2", DbType.DateTime, billDate2);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        public List<ExtraQuote> getExtraQuote(Int64 subscriberId)
        {
            DataSet extraQuote = new DataSet("extraQuote");

            List<ExtraQuote> extraQuotes = new List<ExtraQuote>();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bononbankfinancing.frfgetExtraQuoteBySubs"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, subscriberId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, extraQuote, "extraQuote");
            }

            foreach (DataRow x in extraQuote.Tables["extraQuote"].Rows)
            {
                Int64? saleChanelId;
                Int64? supplierId;
                Int64? lineId;
                Int64? sublineId;


                saleChanelId = Convert.ToInt64(x[10].ToString());

                if (saleChanelId == 0)
                {
                    saleChanelId = null;

                }


                supplierId = Convert.ToInt64(x[9].ToString());

                if (supplierId == 0)
                {
                    supplierId = null;
                }


                sublineId = Convert.ToInt64(x[8].ToString());

                if (sublineId == 0)
                {
                    sublineId = null;

                }



                lineId = Convert.ToInt64(x[7].ToString());

                if (lineId == 0)
                {
                    lineId = null;

                }


                extraQuotes.Add(
                    new ExtraQuote(
                        x[0].ToString(), 
                        x[1].ToString(), 
                        x[2].ToString(), 
                        x[3].ToString(), 
                        Convert.ToDouble(x[4].ToString()), 
                        Convert.ToDateTime(x[6].ToString()), 
                        lineId, 
                        sublineId, 
                        supplierId, 
                        saleChanelId, 
                        Convert.ToInt64(x[11].ToString()) ));
            }

            return extraQuotes;
        }

        /// <summary>
        /// Registra el deudor
        /// </summary>
        /// <param name="subscriberId">Cliente de la suscripción</param>
        /// <param name="promissory">Información del deudor</param>
        public void RegisterDeudor(Int64? subscriberId, Promissory promissory)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegisterDeudorData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriberId", DbType.Int64, subscriberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPromissory_id", DbType.Int64, promissory.PromissoryId);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbHolder_Bill", DbType.String, promissory.HolderBill);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDebtorName", DbType.String, promissory.DebtorName);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, promissory.IdentType);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, promissory.Identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuForwardingPlace", DbType.Int64, promissory.ForwardingPlace);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtForwardingDate", DbType.DateTime, promissory.ForwardingDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbGender", DbType.String, promissory.Gender);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCivil_State_Id", DbType.Int64, promissory.CivilStateId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBirthdayDate", DbType.DateTime, promissory.BirthdayDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSchool_Degree_", DbType.Int64, promissory.SchoolDegree);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuAddress_Id", DbType.Int64, promissory.AddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPropertyPhone", DbType.Int64, promissory.PropertyPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDependentsNumber", DbType.Int64, promissory.DependentsNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingTypeId", DbType.Int64, promissory.HousingType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingMonth", DbType.Int64, promissory.HousingMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbHolderRelation", DbType.String, promissory.HolderRelation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOccupation", DbType.String, promissory.Occupation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbCompanyName", DbType.String, promissory.CompanyName);
                          


                Int64? addresscompany;

                if (!(promissory.CompanyAddressId == 0))
                {
                    addresscompany = promissory.CompanyAddressId;
                }
                else
                {
                    addresscompany = null;
                }

                OpenDataBase.db.AddInParameter(cmdCommand, "inuCompanyAddress_Id", DbType.Int64, addresscompany);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone1", DbType.Int64, promissory.Phone1);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone2", DbType.Int64, promissory.Phone2);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhone", DbType.Int64, promissory.MovilPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOldLabor", DbType.Int64, promissory.OldLabor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuActivityId", DbType.String, promissory.Activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMonthlyIncome", DbType.Double, promissory.MonthlyIncome);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuExpensesIncome", DbType.Double, promissory.ExpensesIncome);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbFamiliarReference", DbType.String, promissory.FamiliarReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhoneFamiRefe", DbType.String, promissory.PhoneFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMovilPhoFamiRefe", DbType.String, promissory.MovilPhoFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddressfamirefe", DbType.Int64, promissory.AddressFamiRef);

                Int64? addresspers;

                if (!(promissory.AddressPersRef == 0))
                {
                    addresspers = promissory.AddressPersRef;
                }
                else
                {
                    addresspers = null;
                }

                OpenDataBase.db.AddInParameter(cmdCommand, "isbPersonalReference", DbType.String, promissory.PersonalReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhonePersRefe", DbType.String, promissory.PhonePersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhoPersRefe", DbType.String, promissory.MovilPhoPersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddresspersrefe", DbType.Int64, addresspers);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbcommerreference", DbType.String, promissory.CommercialReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbphonecommrefe", DbType.String, promissory.PhoneCommRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbmovilphocommrefe", DbType.String, promissory.MovilPhoCommRefe);

                Int64? addresscom;

                if (!(promissory.AddressCommRef == 0))
                {
                    addresscom = promissory.AddressCommRef;
                }
                else
                {
                    addresscom = null;
                }
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddresscommrefe", DbType.Int64, addresscom);

                //Aecheverry 210972
                Int64? contractType = null ;
                if (!(promissory.ContractType == 0))
                {
                    contractType = promissory.ContractType;
                }                

                OpenDataBase.db.AddInParameter(cmdCommand, "isbEmail", DbType.String, promissory.Email);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage_Id", DbType.Int64, promissory.PackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCategoryId", DbType.Int64, promissory.CategoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcategoryId", DbType.Int64, promissory.SubcategoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractType", DbType.Int64, contractType);
                OpenDataBase.db.AddInParameter(cmdCommand, "isblastname", DbType.String, promissory.DebtorLastName);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDeudorSolidario", DbType.String, promissory.FlagDeudorSolidario);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCaulsalId", DbType.Int32, promissory.Causal);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /***********************************************************************************
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========     ===================   ===============================================
        04-10-2014    Llozada               RQ 1218: Se adiciona el parámetro Deudor Solidario
        ***********************************************************************************/
        public void RegisterCosigner(Promissory promissory)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegisterCosignerData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPromissory_id", DbType.Int64, promissory.PromissoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbHolder_Bill", DbType.String, promissory.HolderBill);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDebtorName", DbType.String, promissory.DebtorName);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, promissory.IdentType);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, promissory.Identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuForwardingPlace", DbType.Int64, promissory.ForwardingPlace);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtForwardingDate", DbType.DateTime, promissory.ForwardingDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbGender", DbType.String, promissory.Gender);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCivil_State_Id", DbType.Int64, promissory.CivilStateId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBirthdayDate", DbType.DateTime, promissory.BirthdayDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSchool_Degree_", DbType.Int64, promissory.SchoolDegree);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuAddress_Id", DbType.Int64, promissory.AddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPropertyPhone", DbType.Int64, promissory.PropertyPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDependentsNumber", DbType.Int64, promissory.DependentsNumber);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingTypeId", DbType.Int64, promissory.HousingType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuHousingMonth", DbType.Int64, promissory.HousingMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbHolderRelation", DbType.String, promissory.HolderRelation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOccupation", DbType.String, promissory.Occupation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbCompanyName", DbType.String, promissory.CompanyName);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCompanyAddress_Id", DbType.Int64, promissory.CompanyAddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone1", DbType.Int64, promissory.Phone1);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone2", DbType.Int64, promissory.Phone2);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhone", DbType.Int64, promissory.MovilPhone);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOldLabor", DbType.Int64, promissory.OldLabor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuActivityId", DbType.String, promissory.Activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMonthlyIncome", DbType.Double, promissory.MonthlyIncome);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuExpensesIncome", DbType.Double, promissory.ExpensesIncome);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbFamiliarReference", DbType.String, promissory.FamiliarReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhoneFamiRefe", DbType.String, promissory.PhoneFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMovilPhoFamiRefe", DbType.String, promissory.MovilPhoFamiRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddressfamirefe", DbType.Int64, promissory.AddressFamiRef);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbPersonalReference", DbType.String, promissory.PersonalReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPhonePersRefe", DbType.String, promissory.PhonePersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhoPersRefe", DbType.String, promissory.MovilPhoPersRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddresspersrefe", DbType.Int64, promissory.AddressPersRef);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbcommerreference", DbType.String, promissory.CommercialReference);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbphonecommrefe", DbType.String, promissory.PhoneCommRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbmovilphocommrefe", DbType.String, promissory.MovilPhoCommRefe);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuaddresscommrefe", DbType.Int64, promissory.AddressCommRef);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbEmail", DbType.String, promissory.Email);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage_Id", DbType.Int64, promissory.PackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCategoryId", DbType.Int64, promissory.CategoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcategoryId", DbType.Int64, promissory.SubcategoryId);
                //aecheverry
                Int64? contractType = null;
                if (promissory.ContractType != 0)
                {
                    contractType = promissory.ContractType;
                }
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractType", DbType.Int64, contractType);
                OpenDataBase.db.AddInParameter(cmdCommand, "isblastname", DbType.String, promissory.DebtorLastName);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDeudorSolidario", DbType.String, promissory.FlagDeudorSolidario);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCaulsalId", DbType.Int32, promissory.Causal);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.RegisterCosignerData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeCodeudor", DbType.String, IdentTypeCodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentification", DbType.String, IdentificationCodeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbFlagDeudorSolidario", DbType.String, FlagDeudorSolidario);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, PackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeDeudor", DbType.String, IdentTypeDeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentificationDeudor", DbType.String, IdentificationDeudor);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }     
        }

        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }

        public DataTable getAvalibleArticles(
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
            DataSet articleDataSet = new DataSet("Articles");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getAvalibleArticle"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inugeogra_location", DbType.Int64, geoLocation);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSale_Chanel_Id", DbType.Int64, chanelId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCategori_Id", DbType.Int64, categoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcateg_Id", DbType.Int64, subcategoryId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "ocuArtList");
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDate", DbType.DateTime, saleDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "ivaPlan_finan", DbType.String, flagCuotaFija);
                OpenDataBase.db.LoadDataSet(cmdCommand, articleDataSet, "Articles");
            }
            return articleDataSet.Tables["Articles"];
        }

        public Int64 RegisterSale(String XML)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("OS_RegisterRequestWithXML"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbrequestxml", DbType.String, XML);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onupackageid", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onumotiveid", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerrorcode", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberrormessage", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64 error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerrorcode"));
                String message = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberrormessage"));

                if (error == 0)
                {
                    return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onupackageid"));
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, message);
                    OpenDataBase.Transaction.Rollback();
                    return 0;
                }
            }
        }


        /// <summary>
        /// registro de las trasnferencias de cupo.Crea una orden por cada contrato origen (que ceden cupo) y
        /// realiza el registro en la entidad ld_quota_transfer.
        /// </summary>
        /// <param name="packageId"></param>
        public void registerQuotaTransfer(Int64 packageId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.registerQuotaTransfer"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackTransId", DbType.Int64, packageId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }

        }

        public String getParam(String sbParam)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (string)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        //aecheverry ddisponibilidad
        // jhinestroza [3743] 12/02/2015: se agrega parametro canal de venta
        public String fsbValAvailable
        (  
            Int64 subscriptionId, 
            Int64? nuAddressId,                    
            DateTime? dtSaleDate,
            String chanelSale
        )
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fsbValAvailability"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "subscriptionId", DbType.Int64, subscriptionId);
                    OpenDataBase.db.AddInParameter(cmdCommand, "nuAddressId", DbType.Int64, nuAddressId);
                    OpenDataBase.db.AddInParameter(cmdCommand, "dtSaleDate", DbType.DateTime, dtSaleDate);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbchanelSale", DbType.String, chanelSale);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    return (string)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                }
            }
            catch (Exception ex)
            {                           
                return ex.Message.ToString();                
            }
            
        }

        public Int64 getDocumentType(Int64 documentTypeId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bcdatacred.fbldocumenttypeid"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "sbdoctypedatacred", DbType.Int64, documentTypeId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public Boolean isValidForSaleFNB(Int64 documentTypeId, string identification, string lastName)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BODatacred.fboValidForSaleFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, documentTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbLastName", DbType.String, lastName);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public string processResponseWS(string response, Int64 identType, string identification, out Int64? ResConsId)
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BODatacred.processResponse"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbResponse", DbType.String, response);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, identType);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbOutput", DbType.String, 250);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuResConsId", DbType.Int64, 100);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    OpenDataBase.Transaction.Commit();

                    ResConsId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuResConsId"));

                    return OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbOutput"));
                }
            }
            catch (Exception ex)
            {
                ControlledException exCtrl = GlobalExceptionProcessing.CreateControlledException(ex);
                OpenDataBase.Transaction.Rollback();
                ResConsId = null;
                return exCtrl.Message;
            }
        }

        public String getConstantValue(string cName)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(" BEGIN");
            sb.Append(" SELECT " + cName + " constante INTO :1 FROM dual;");
            sb.Append(" END;");

            using (DbCommand cmdCommand = OpenDataBase.db.GetSqlStringCommand(sb.ToString()))
            {
                OpenDataBase.db.AddParameter(cmdCommand, ":1", DbType.String, ParameterDirection.Output, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (string)(OpenDataBase.db.GetParameterValue(cmdCommand, ":1"));
            }
        }

        public static DataTable FtrfPromissory(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            DataSet DSpromissory = new DataSet("promissory");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bcportafolio.ftrfpromissory"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                    OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                    OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                    OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                    OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory");
                }
           
            return DSpromissory.Tables["promissory"];
        }



        public static DataTable ValidateDocument(Int64 inuidenttype, String isbidentification, String isblastname)
        {
            DataSet DSvalidate = new DataSet("validate");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCDatacred.frcGetDataSubscriptorDataCred"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidenttype", DbType.Int64, inuidenttype);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbidentification", DbType.String, isbidentification);
                OpenDataBase.db.AddInParameter(cmdCommand, "isblastname", DbType.String, isblastname);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSvalidate, "validate");
            }

            return DSvalidate.Tables["validate"];
        }

        public static DataTable FtrfArticle(Int64 nuPackageId)
        {
            DataSet DSarticle = new DataSet("article");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bcportafolio.ftrfarticle"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSarticle, "article");
            }
            return DSarticle.Tables["article"];
        }


        public void UpRequestSetNumberFNB(Int64 RequestId, Int64 numberFNB, Int64 operatingUnit, Int64 productId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpRequestSetNumberFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRequestId", DbType.Int64, RequestId);                
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumero", DbType.Int64, numberFNB);                
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoProd", DbType.Int64, productId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, operatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oboGenePend", DbType.Boolean, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpRequestNumberFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, package);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuVouchTyp", DbType.Int64, vouchTyp);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, operUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumber", DbType.Int64, number);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


        public void UpRequestVoucherFNB(Int64 vouchTyp, Int64 operUnit, Int64 number)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpRequestVoucherFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuVouchTyp", DbType.Int64, vouchTyp);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, operUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumber", DbType.Int64, number);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


        public void AnnulReqVoucherFNB(Int64 vouchTyp, Int64 number)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.AnnulReqVoucherFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuVouchTyp", DbType.Int64, vouchTyp);               
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumber", DbType.Int64, number);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public void setConsultSale(Int64? ResConsId, Int64 SaleId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BODatacred.assignSale"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuResultConsultId", DbType.Int64, ResConsId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, SaleId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public void validateNumberFNB(Int64 numberFNB, Int64 operatingUnit, Int64 productId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.validateNumberFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuNumero", DbType.Int64, numberFNB);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperUnit", DbType.Int64, operatingUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoProd", DbType.Int64, productId);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public Boolean isSubscriberBlocked(Int64 documentTypeId, string identification)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuValidateSubsBlocked"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, documentTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);                
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public Boolean parcialQuota(Int64 subscriptionId, out Double transferQuotaValue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bononbankfinancing.GetPolicyHistoric"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblType", DbType.Boolean, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAssignedQuota", DbType.Int64, 100);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Double.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAssignedQuota").ToString(), out transferQuotaValue);

                Boolean TransferQuota = Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, "oblType"));
                return TransferQuota;

            }
        }

        public String getLineDescription(Int64 LineId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_line.fsbGetDescription"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuLINE_Id", DbType.Int64, LineId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE")).ToString();
            }
        }

        public void consultaDatacredito(Int64 identType, string identification, string sbApellido, out String sbresponse)
        {
            Int64 errorCode;
            string errorMsg;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCI_PKDATACREDITO.PROCONSULTADATACREDITO"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIIDENT", DbType.Int64, identType);
                    OpenDataBase.db.AddInParameter(cmdCommand, "ISBIDENTIFICACION", DbType.String, identification);
                    OpenDataBase.db.AddInParameter(cmdCommand, "ISBAPELLIDO", DbType.String, sbApellido);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "OSBRESPUESTA", DbType.Object, int.MaxValue);//SqlDbType.VarBinary, int.MaxValue);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 15);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 200);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    errorCode = long.Parse(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode").ToString());
                    errorMsg = OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage").ToString();
                                        
                    sbresponse = (String)OpenDataBase.db.GetParameterValue(cmdCommand, "OSBRESPUESTA");
                }
            }
            catch (Exception)
            {
                sbresponse = "99";
            }
        }

        public Int32 numberBill(Int64 subscriptionId)
        {
            Int32 number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuBillNumber"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscripc", DbType.Int32, subscriptionId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);

            }

            return number;

        }


        public void saveBillSlope(Int64 billId, Int64 packageId)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.registerBillPending"))
            {
                //aecheverry
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFact", DbType.Int64, billId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }



        public Int32 validateVisit(Int64 subscriptionId, DateTime date)
        {
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuValExiVisFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscripc", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtRegister", DbType.DateTime, date);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);


            }


            return number;
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
        /***********************************************************************************
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========     ===================   ===============================================
        04-10-2014    Llozada               RQ 1218: Se adiciona el parámetro Deudor Solidario
        ***********************************************************************************/
        public void saveDeudorData(
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpdDebCos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidtype", DbType.Int32, Ident);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbidentid", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "Isbtel", DbType.String, phone);
                OpenDataBase.db.AddInParameter(cmdCommand, "Isbname", DbType.String, name);
                OpenDataBase.db.AddInParameter(cmdCommand, "Isblastnam", DbType.String, lastName); 
                OpenDataBase.db.AddInParameter(cmdCommand, "isbmail", DbType.String, email);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuAddress", DbType.Int32, address);
                OpenDataBase.db.AddInParameter(cmdCommand, "IsbBirth", DbType.Date, Birth);
                OpenDataBase.db.AddInParameter(cmdCommand, "IsbGender", DbType.String, gender);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbCvSt", DbType.Int32, cvSt);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbSchool", DbType.Int32, school);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbProf", DbType.Int32, profession);
                OpenDataBase.db.AddInParameter(cmdCommand, "opcion", DbType.String, option);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


        public void UpdateOrderActivityPack(Int64 packageId, Int64 orderId)
        {


            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpdateOrderActivityPack"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuorder", DbType.Int64, orderId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }

        }

        public Promissory getLastCosigner(Int64 identType, String identification)
        {
            //ExceptionHandler.DisplayMessage(2741, "getLastCosigner");//c
            DataSet promissory = new DataSet("promissory");
            Promissory dataPromissory = new Promissory();
            //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, antes de traer la data de la bd");//c
            
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getLastCosigner"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inutypeid", DbType.Int64, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidentification", DbType.String, identification);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfcursorpromissory");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "promissory");
            }

            //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, DESPUES de traer la data de la bd, promissory.Tables[promissory].Rows.Count: "+promissory.Tables["promissory"].Rows.Count);//c

            if (promissory.Tables["promissory"].Rows.Count > 0)
            {
                DataRow x = promissory.Tables["promissory"].Rows[0];
                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, hay datos");//c

                dataPromissory.DebtorName = x["DEBTORNAME"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK DEBTORNAME<--");//c


                dataPromissory.DebtorLastName = x["LAST_NAME"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK LAST_NAME<--");//c


                dataPromissory.DependentsNumber = OpenConvert.ToInt64Nullable(x["DEPENDENTSNUMBER"]);
                //ExceptionHandler.DisplayMessage(2741, "--> OK DEPENDENTSNUMBER<--");//c


                dataPromissory.ForwardingPlace = OpenConvert.ToInt64Nullable(x["FORWARDINGPLACE"]);
                //ExceptionHandler.DisplayMessage(2741, "--> OK FORWARDINGPLACE<--");//c


                dataPromissory.ForwardingDate = DateTime.Parse(x["FORWARDINGDATE"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK FORWARDINGDATE<--");//c


                dataPromissory.IdentType = x["IDENT_TYPE_ID"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK IDENT_TYPE_ID<--");//c


                dataPromissory.Identification = x["IDENTIFICATION"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK IDENTIFICATION<--");//c


                dataPromissory.CivilStateId = OpenConvert.ToInt64Nullable(x["CIVIL_STATE_ID"]);
                //ExceptionHandler.DisplayMessage(2741, "--> OK CIVIL_STATE_ID<--");//c


                dataPromissory.BirthdayDate = DateTime.Parse(x["BIRTHDAYDATE"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK BIRTHDAYDATE<--");//c


                dataPromissory.Gender = x["GENDER"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK GENDER<--");//

                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae la dir");

                Int64 address = Int64.Parse(x["ADDRESS_ID"].ToString());

                if (address > 0)
                {
                    dataPromissory.AddressId = address;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK ADDRESS_ID<--");//

                dataPromissory.PropertyPhone = x["PROPERTYPHONE_ID"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PROPERTYPHONE_ID<--");//

                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.SchoolDegree = OpenConvert.ToInt64Nullable(x["SCHOOL_DEGREE_"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK SCHOOL_DEGREE_<--");//


                //ExceptionHandler.DisplayMessage(2741, "-->CATEGORY_ID: ["+x["CATEGORY_ID"].ToString() +"] <--");//
                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.CategoryId = OpenConvert.ToInt64Nullable(x["CATEGORY_ID"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK CATEGORY_ID<--");//

                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.SubcategoryId = OpenConvert.ToInt64Nullable(x["SUBCATEGORY_ID"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK SUBCATEGORY_ID<--");//

                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.HolderRelation = OpenConvert.ToInt64Nullable(x["HOLDERRELATION"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK HOLDERRELATION<--");//

                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.HousingType = OpenConvert.ToInt64Nullable(x["HOUSINGTYPE"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK HOUSINGTYPE<--");//

                // se agrega OpenConvert.ToInt64Nullable para remplazando Int64.Parse
                dataPromissory.HousingMonth = OpenConvert.ToInt64Nullable(x["HOUSINGMONTH"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK HOUSINGMONTH<--");//C

                
                dataPromissory.Occupation = x["OCCUPATION"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK OCCUPATION<--");//C


                dataPromissory.CompanyName = x["COMPANYNAME"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK COMPANYNAME<--");//C


                dataPromissory.Email = x["EMAIL"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK EMAIL<--");//C


                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae la company");

                Int64 companyAddress;

                if (Int64.TryParse(x["COMPANYADDRESS_ID"].ToString(), out companyAddress))
                {
                    dataPromissory.CompanyAddressId = companyAddress;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK COMPANYADDRESS_ID<--");//C

                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae la tipo contrto");
                Int64 contractType;

                if (Int64.TryParse(x["CONTRACT_TYPE_ID"].ToString(), out contractType))
                {
                    dataPromissory.ContractType = contractType;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK CONTRACT_TYPE_ID<--");//C


                dataPromissory.Phone1 = x["PHONE1_ID"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK EMAIL<--");//C


                dataPromissory.Phone2 = x["PHONE2_ID"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PHONE2_ID<--");//C


                dataPromissory.MovilPhone = x["MOVILPHONE_ID"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK MOVILPHONE_ID<--");//C


                dataPromissory.Activity = x["ACTIVITY"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK ACTIVITY<--");//C


                dataPromissory.OldLabor = OpenConvert.ToInt64Nullable(x["OLDLABOR"]);
                //ExceptionHandler.DisplayMessage(2741, "--> OK OLDLABOR<--");//C


                dataPromissory.MonthlyIncome = Double.Parse(x["MONTHLYINCOME"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK MONTHLYINCOME<--");//C


                dataPromissory.ExpensesIncome = Double.Parse(x["EXPENSESINCOME"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK EXPENSESINCOME<--");//C

                
                dataPromissory.CommercialReference = x["COMMERREFERENCE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK COMMERREFERENCE<--");//C


                dataPromissory.PhoneCommRefe = x["PHONECOMMREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PHONECOMMREFE<--");//C


                dataPromissory.MovilPhoCommRefe = x["MOVILPHOCOMMREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK MOVILPHOCOMMREFE<--");//C

                
                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae la dir comer");

                Int64 addressComm;

                if (Int64.TryParse(x["ADDRESSCOMMREFE"].ToString(), out addressComm))
                {
                    dataPromissory.AddressCommRef = addressComm;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK ADDRESSCOMMREFE<--");//C


                dataPromissory.FamiliarReference = x["FAMILIARREFERENCE"].ToString();
                // ExceptionHandler.DisplayMessage(2741, "--> OK FAMILIARREFERENCE<--");//C


                dataPromissory.PhoneFamiRefe = x["PHONEFAMIREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PHONEFAMIREFE<--");//C


                dataPromissory.MovilPhoFamiRefe = x["MOVILPHOFAMIREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK MOVILPHOFAMIREFE<--");//C


                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae las ref fami");
                Int64 addressFamiRefe;

                if (Int64.TryParse(x["ADDRESSFAMIREFE"].ToString(), out addressFamiRefe))
                {
                    dataPromissory.AddressFamiRef = addressFamiRefe;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK ADDRESSFAMIREFE<--");//C


                dataPromissory.PersonalReference = x["PERSONALREFERENCE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PERSONALREFERENCE<--");//C


                dataPromissory.PhonePersRefe = x["PHONEPERSREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK PHONEPERSREFE<--");//C


                dataPromissory.MovilPhoPersRefe = x["MOVILPHOPERSREFE"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK MOVILPHOPERSREFE<--");//C


                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, trae la dir ref");

                Int64 addressPersRefe;

                if (Int64.TryParse(x["ADDRESSPERSREFE"].ToString(), out addressPersRefe))
                {
                    dataPromissory.AddressPersRef = addressPersRefe;
                }
                //ExceptionHandler.DisplayMessage(2741, "--> OK ADDRESSPERSREFE<--");//C

                //ExceptionHandler.DisplayMessage(2741, "getLastCosigner, fin");

                dataPromissory.HolderBill = x["HOLDER_BILL"].ToString();
                //ExceptionHandler.DisplayMessage(2741, "--> OK HOLDER_BILL<--");//C

                
                dataPromissory.PackageId = Int64.Parse(x["PACKAGE_ID"].ToString());
                //ExceptionHandler.DisplayMessage(2741, "--> OK PACKAGE_ID<--");//C
            }
            return dataPromissory;
        }

        public Promissory getRecentPromissoryInfo(Int64 identType, String identification)
        {
            DataSet promissory = new DataSet("promissory");
            Promissory dataPromissory = new Promissory();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.IdeInfProm"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inutypeid", DbType.Int64, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidentification", DbType.String, identification);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfcursorpromissory");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "promissory");
            }

            if (promissory.Tables["promissory"].Rows.Count > 0)
            {
                DataRow x = promissory.Tables["promissory"].Rows[0];

                dataPromissory.DebtorName = x["DEBTORNAME"].ToString();
                dataPromissory.DebtorLastName = x["LAST_NAME"].ToString();
                dataPromissory.DependentsNumber = Int64.Parse(x["DEPENDENTSNUMBER"].ToString());
                dataPromissory.ForwardingPlace = Int64.Parse(x["FORWARDINGPLACE"].ToString());
                dataPromissory.ForwardingDate = DateTime.Parse(x["FORWARDINGDATE"].ToString());
                dataPromissory.IdentType = x["IDENT_TYPE_ID"].ToString();
                dataPromissory.Identification = x["IDENTIFICATION"].ToString();
                dataPromissory.CivilStateId = OpenConvert.ToInt64Nullable(x["CIVIL_STATE_ID"].ToString());
                dataPromissory.BirthdayDate = DateTime.Parse(x["BIRTHDAYDATE"].ToString());
                dataPromissory.Gender = x["GENDER"].ToString();
                
                Int64 address = Int64.Parse(x["ADDRESS_ID"].ToString());
                if (address > 0)
                {
                    dataPromissory.AddressId = address;
                }

                dataPromissory.PropertyPhone = x["PROPERTYPHONE_ID"].ToString();
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.SchoolDegree = OpenConvert.ToInt64Nullable(x["SCHOOL_DEGREE_"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.CategoryId = OpenConvert.ToInt64Nullable(x["CATEGORY_ID"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.SubcategoryId = OpenConvert.ToInt64Nullable(x["SUBCATEGORY_ID"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.HolderRelation = OpenConvert.ToInt64Nullable(x["HOLDERRELATION"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.HousingType = OpenConvert.ToInt64Nullable(x["HOUSINGTYPE"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion Int64.Parse por OpenConvert.ToInt64Nullable
                dataPromissory.HousingMonth = OpenConvert.ToInt64Nullable(x["HOUSINGMONTH"].ToString());
                
                dataPromissory.Occupation = x["OCCUPATION"].ToString();
                dataPromissory.CompanyName = x["COMPANYNAME"].ToString();
                dataPromissory.Email = x["EMAIL"].ToString();

                Int64 companyAddress;

                if (Int64.TryParse(x["COMPANYADDRESS_ID"].ToString(), out companyAddress))
                {
                    dataPromissory.CompanyAddressId = companyAddress;
                }

                Int64 contractType;

                if (Int64.TryParse(x["CONTRACT_TYPE_ID"].ToString(), out contractType))
                {
                    dataPromissory.ContractType = contractType;
                }
                dataPromissory.Phone1 = x["PHONE1_ID"].ToString();
                dataPromissory.Phone2 = x["PHONE2_ID"].ToString();
                dataPromissory.MovilPhone = x["MOVILPHONE_ID"].ToString();
                dataPromissory.Activity = x["ACTIVITY"].ToString();
                dataPromissory.OldLabor = OpenConvert.ToInt64Nullable(x["OLDLABOR"]);
                // jhinestroza:[incidente]: se cambia la validacion  Double.Parse por OpenConvert.ToDoubleNullable
                dataPromissory.MonthlyIncome = (Double) OpenConvert.ToDoubleNullable(x["MONTHLYINCOME"].ToString());
                // jhinestroza:[incidente]: se cambia la validacion  Double.Parse por OpenConvert.ToDoubleNullable
                dataPromissory.ExpensesIncome = (Double)OpenConvert.ToDoubleNullable(x["EXPENSESINCOME"].ToString());
                
                dataPromissory.CommercialReference = x["COMMERREFERENCE"].ToString();
                dataPromissory.PhoneCommRefe = x["PHONECOMMREFE"].ToString();
                dataPromissory.MovilPhoCommRefe = x["MOVILPHOCOMMREFE"].ToString();

                Int64 addressComm;

                if (Int64.TryParse(x["ADDRESSCOMMREFE"].ToString(), out addressComm))
                {
                    dataPromissory.AddressCommRef = addressComm;
                }

                dataPromissory.FamiliarReference = x["FAMILIARREFERENCE"].ToString();
                dataPromissory.PhoneFamiRefe = x["PHONEFAMIREFE"].ToString();
                dataPromissory.MovilPhoFamiRefe = x["MOVILPHOFAMIREFE"].ToString();
                
                Int64 addressFamiRefe;

                if (Int64.TryParse(x["ADDRESSFAMIREFE"].ToString(), out addressFamiRefe))
                {
                    dataPromissory.AddressFamiRef = addressFamiRefe;
                }

                dataPromissory.PersonalReference = x["PERSONALREFERENCE"].ToString();
                dataPromissory.PhonePersRefe = x["PHONEPERSREFE"].ToString();
                dataPromissory.MovilPhoPersRefe = x["MOVILPHOPERSREFE"].ToString();

                Int64 addressPersRefe;

                if (Int64.TryParse(x["ADDRESSPERSREFE"].ToString(), out addressPersRefe))
                {
                    dataPromissory.AddressPersRef = addressPersRefe;
                }
                
                dataPromissory.HolderBill = x["HOLDER_BILL"].ToString();
                dataPromissory.PackageId = Int64.Parse(x["PACKAGE_ID"].ToString());
            }
            return dataPromissory;
        }

        public Int32 validateAvailability(Int64 operatingUnit, Int64 subscriptionId)
        {
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuValExiVisFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "oper_unit", DbType.Int64, operatingUnit);
                OpenDataBase.db.AddInParameter(cmdCommand, "suscription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);

            }

            return number;
        }


        public Boolean validateCosigner(Int64 supplierId, String identification, Int32 identType)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.validateCosigner"))
            {
                //aecheverry 2109072 pto1
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSupplierId", DbType.Int64, supplierId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdent_Type_Id", DbType.Int32, identType);                
                OpenDataBase.db.AddOutParameter(cmdCommand, "blResult", DbType.Boolean, 10);


                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "blResult").ToString(), out result);

            }
            return result;
        }

        /*14-04-2014 HAltamiranda [RQ 6359]: Se crea el método que valida si el deudor tiene ventas previas*/
        public Boolean validateSalesDebtor(String identification, Int32 identType)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.LDC_prValidateSalesDebtor"))
            {
                //HAltamiranda RQ 6359
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTypeIdentification", DbType.Int32, identType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oboResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oboResult").ToString(), out result);
            }
            return result;
        }

        /*03-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor puede ser 
                                        deudor solidario*/
        public Boolean validateCosigner(String identification, Int32 identType)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.blValidateCodeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int32, identType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /*04-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor puede ser codeudor*/
        public Boolean validateCosigner(String identification, Int32 identType, String idenDeudor, Int32 idenTypeDeudor, String trasladoCupo)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.blValidateCodeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int32, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdenDeudor", DbType.String, idenDeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdenTypeDeudor", DbType.Int32, idenTypeDeudor);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTrasladoCupo", DbType.String, trasladoCupo);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /*04-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor puede ser codeudor*/
        public Boolean validateQuotaContract(Int64 subscriptionId)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.blQuotaContract"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /*05-10-2014 Llozada [RQ 1218]: Se crea el método que valida si el codeudor tiene cupo para respaldar la deuda*/
        public Boolean validateQuotaCosigner(String identification, Int32 identType, Double total)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.blValidQuotaCosigner"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeCodeudor", DbType.Int32, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentCodeudor",DbType.String , identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTotalVenta", DbType.Double, total);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /*07-10-2014 Llozada [RQ 1218]: Se crea el método que valida si hay una configuración para que No requiera
                                        codeudor*/
        public Boolean validateNoCosigner(Int32 identType, String identification, Int64 contrato)
        {
            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_codeudores.blValidNoCosigner"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeDeudor", DbType.Int32, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdenDeudor", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, contrato);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /// <summary>
        /// Obtiene la información del codeudor a partir del contrato ingresado
        /// </summary>
        /// <param name="cosignerContract">Contrato del codeudor</param>
        /// <returns></returns>
        public Promissory getCosignerBySusc(Int64 cosignerContract)
        {
            DataSet promissory = new DataSet("cosigner");
            Promissory dataPromissory = new Promissory();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("GetCosignerInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContract", DbType.Int64, cosignerContract);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfCosignerInfo");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "cosigner");
            }

            if (promissory.Tables["cosigner"].Rows.Count > 0)
            {
                DataRow row = promissory.Tables["cosigner"].Rows[0];

                /*Nombre de usuario, tipo de identificación, identificación, Sexo, Fecha de Nacimiento, 
                 * Numero de teléfono del predio*/
                dataPromissory.DebtorName = row["subscriber_name"].ToString();
                dataPromissory.DebtorLastName = row["subs_last_name"].ToString();
                dataPromissory.IdentType = row["ident_type_id"].ToString();
                dataPromissory.Identification = row["identification"].ToString();
                dataPromissory.Gender = row["gender"].ToString();

                dataPromissory.BirthdayDate =
                    String.IsNullOrEmpty(row["date_birth"].ToString()) ?
                    new DateTime() :
                    Convert.ToDateTime(row["date_birth"].ToString());
                //jrobayo
                //aesguerra se valida que la dirección no sea nula
                if (!string.IsNullOrEmpty(row["Address_Id"].ToString()))
                {
                    dataPromissory.AddressId = Convert.ToInt64(row["Address_Id"].ToString());
                } 
            }
            return dataPromissory;
        }

        public Promissory getSubscriberInfo(Int64 IdentTypeId, String identification)
        {
            DataSet promissory = new DataSet("cosigner");
            Promissory dataPromissory = new Promissory();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.GetSubscriberInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTypeId", DbType.Int64, IdentTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentification", DbType.String, identification);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfCursorPromissory");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "cosigner");
            }
            if (promissory.Tables["cosigner"].Rows.Count > 0)
            {
                DataRow row = promissory.Tables["cosigner"].Rows[0];

                /*Nombre de usuario, tipo de identificación, identificación, Sexo, Fecha de Nacimiento, 
                 * Numero de teléfono del predio*/
                dataPromissory.IdentType = Convert.ToString(IdentTypeId);
                dataPromissory.Identification = identification;
                dataPromissory.DebtorName = row["subscriber_name"].ToString();
                dataPromissory.DebtorLastName = row["subs_last_name"].ToString();
                dataPromissory.Gender = row["gender"].ToString();
                if (!string.IsNullOrEmpty(row["Address_Id"].ToString()))
                {
                    dataPromissory.AddressId = Convert.ToInt64(row["Address_Id"].ToString());
                }

                if (!String.IsNullOrEmpty(row["date_birth"].ToString()))
                {
                    dataPromissory.BirthdayDate = Convert.ToDateTime(row["date_birth"].ToString());
                }
            }
            return dataPromissory;
        }

        //EVESAN 18/Julio/2013
        public void UpdateAditionalValuesSalesFNB(Int64 packageId, Double QUOTA_APROX_MONTH, Double VALUE_APROX_INSURANCE, Double VALUE_TOTAL, String allowTransferQuota)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.UpdAditionalDataSaleFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage_id", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuquota_Aprox_Month", DbType.Double, QUOTA_APROX_MONTH);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue_aprox_insurance", DbType.Double, VALUE_APROX_INSURANCE);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue_total", DbType.Double, VALUE_TOTAL);
                OpenDataBase.db.AddInParameter(cmdCommand, "inutransfer", DbType.String, allowTransferQuota);
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }

        public void RegisterExtraQuotaFNB(Int64? nuExtraQuotaId, Int64  SubscriptionId, Double? usedQuota)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegisterExtraQuotaFNB"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuExtraQuotaId", DbType.Int64, nuExtraQuotaId);
                OpenDataBase.db.AddInParameter(cmdCommand, "SubscriptionId", DbType.Int64, SubscriptionId);
                OpenDataBase.db.AddInParameter(cmdCommand, "usedQuota", DbType.Double, usedQuota);                

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }

        /* SAO212016. Se crea método que consulta en la BD si el proveedor es Olímpica*/
        public bool isProvOlimpica(long? supplierId)
        {
            Boolean isOlimpic = false;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuBoIsProvOlimpica"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out isOlimpic);
            };
            return isOlimpic;
        }

        /* SAO212016. Se crea método que consulta en la BD si el proveedor es Éxito*/
        public bool isProvExito(long? supplierId)
        {
            Boolean isExito = false;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuBoIsProvExito"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out isExito);
            };
            return isExito;
        }

        /* SAO218364. Se crea método que obtiene la subcategoría para una dirección*/
        public Int64? getSubcategory(Int64? addressId)
        {
            Int64 subcategory;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ab_boaddress.fnugetsubcategory"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuAddressId", DbType.Int64, addressId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                if (string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString()))
                {
                    subcategory = 0;
                }
                else
                {
                    subcategory = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                }

                //subcategory = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return subcategory;
        }

        /*SAO219168 aesguerra*/
        public Int64 getCallCenterId(Int64 subscriptionId)
        {
            Int64 CallCenterId;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boflowfnbpack.fblHasCallCenterVisit"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscripcId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                CallCenterId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return CallCenterId;
        }

        /// <summary>
        /// Limpia Cache asociada a la Tabla PL de Quota de Transferencia 
        /// </summary>
        public void clearCache()
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.ClearCache"))
                {
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                }

            }
            catch (Exception)
            {

                throw;
            }

        }

        public string GetPartialQuotaValidation(Int64 subscriptionId)
        {
            string validation = string.Empty;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.fsbGetPartialQuotaValid"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                validation = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };

            return validation;
        }

        public DataTable GetSublinesAppliedToPartialQuota()
        {
            DataSet _dsReturn = new DataSet("GetSublinesAppliedToZeroQuota");
            
            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.fcuGetSublinesZeroCons"))
                {
                    OpenDataBase.db.AddReturnRefCursor(dbCommand);
                    OpenDataBase.db.LoadDataSet(dbCommand, _dsReturn, "SublinesAppliedToZeroQuota");
                }
            }
            catch (Exception ex)
            {
                OpenSystems.Common.ExceptionHandler.GlobalExceptionProcessing.ShowErrorException(ex);
            }
            return _dsReturn.Tables["SublinesAppliedToZeroQuota"];
        }

        public Double GetPartialQuota(Int64 subscriptionId)
        {
            Double partialCuota;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bononbankfinancing.fnuAllocatQuotaZeroCons"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                partialCuota = OpenConvert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return partialCuota;
        }

        public bool GetLock(Int64 inuSusccodi)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.LockSubscription"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, inuSusccodi);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        public void ReleaseLock(Int64 inuSusccodi)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.ReleaseSubscription"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, inuSusccodi);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
        }

        public DateTime FirstFeeDate(Int64 susccodi, DateTime billDate)
        {
            DateTime FeeDate;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.fdtGetFirstFeeDate"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, susccodi);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFactDate", DbType.Date, billDate);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Date, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                FeeDate = Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return FeeDate;
        }

        public void RegisterAdditionalFNBInformation(Int64 packageId, Int64? cosignerSubscriptionId, Double? aproxMonthInsurance)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegAditionalFNBInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageSale", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inCosigner_Subs_Id", DbType.Int64, cosignerSubscriptionId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuAproxMonthInsurance", DbType.Double, aproxMonthInsurance);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

            }
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
        /// 11-02-2014   AEcheverry.SAO232448  1 - creacion        
        ///                                 
        /// </changelog>
        public void ValidateValueToPay(long? subscriptionId, Decimal valueToPay)
        {
            using (System.Data.Common.DbCommand cmd = OpenDataBase.db.GetStoredProcCommand("FA_BOPoliticaRedondeo.ValPoliticaAjusteSusc"))
            {
                OpenDataBase.db.AddInParameter(cmd, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddInParameter(cmd, "inuValueToPay", DbType.Double, valueToPay);

                /* Ejecuta el comando */
                OpenDataBase.db.ExecuteNonQuery(cmd);
            }
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
            Double totalExtraQuote;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bononbankfinancing.fnugetTotalExtraQuote"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriptionId", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                totalExtraQuote = OpenConvert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return totalExtraQuote;
        }


        /// <summary>
        /// Registra la observación de la orden de registro de venta FNB
        /// </summary>
        /// <param name="packageId">Id del paquete</param>
        /// <param name="sbComment">Observación</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 13-08-2014  KCienfuegos.RNP54  1 - creación        
        ///                                 
        /// </changelog>
        public void RegCommentPackageSale(Int64 packageId, String sbComment)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegCommentPackageSale"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageSale", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbComment", DbType.String, sbComment);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
        public Promissory getRecentPromissoryInfobySusc(Int64 identType, String identification, Int64 subscriptionId)
        {
            DataSet promissory = new DataSet("promissory");
            Promissory dataPromissory = new Promissory();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.getInfPromisorybySusc"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inutypeid", DbType.Int64, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfcursorpromissory");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "promissory");
            }

            if (promissory.Tables["promissory"].Rows.Count > 0)
            {
                DataRow x = promissory.Tables["promissory"].Rows[0];

                dataPromissory.DebtorName = x["DEBTORNAME"].ToString();
                dataPromissory.DebtorLastName = x["LAST_NAME"].ToString();
                dataPromissory.DependentsNumber = Int64.Parse(x["DEPENDENTSNUMBER"].ToString());
                dataPromissory.ForwardingPlace = Int64.Parse(x["FORWARDINGPLACE"].ToString());
                dataPromissory.ForwardingDate = DateTime.Parse(x["FORWARDINGDATE"].ToString());
                dataPromissory.IdentType = x["IDENT_TYPE_ID"].ToString();
                dataPromissory.Identification = x["IDENTIFICATION"].ToString();
                dataPromissory.CivilStateId = Int64.Parse(x["CIVIL_STATE_ID"].ToString());
                dataPromissory.BirthdayDate = DateTime.Parse(x["BIRTHDAYDATE"].ToString());
                dataPromissory.Gender = x["GENDER"].ToString();

                Int64 address = Int64.Parse(x["ADDRESS_ID"].ToString());
                if (address > 0)
                {
                    dataPromissory.AddressId = address;
                }

                dataPromissory.PropertyPhone = x["PROPERTYPHONE_ID"].ToString();
                dataPromissory.SchoolDegree = Int64.Parse(x["SCHOOL_DEGREE_"].ToString());
                dataPromissory.CategoryId = Int64.Parse(x["CATEGORY_ID"].ToString());
                dataPromissory.SubcategoryId = Int64.Parse(x["SUBCATEGORY_ID"].ToString());
                dataPromissory.HolderRelation = Int64.Parse(x["HOLDERRELATION"].ToString());
                dataPromissory.HousingType = Int64.Parse(x["HOUSINGTYPE"].ToString());
                dataPromissory.HousingMonth = Int64.Parse(x["HOUSINGMONTH"].ToString());

                dataPromissory.Occupation = x["OCCUPATION"].ToString();
                dataPromissory.CompanyName = x["COMPANYNAME"].ToString();
                dataPromissory.Email = x["EMAIL"].ToString();

                Int64 companyAddress;

                if (Int64.TryParse(x["COMPANYADDRESS_ID"].ToString(), out companyAddress))
                {
                    dataPromissory.CompanyAddressId = companyAddress;
                }

                Int64 contractType;

                if (Int64.TryParse(x["CONTRACT_TYPE_ID"].ToString(), out contractType))
                {
                    dataPromissory.ContractType = contractType;
                }
                dataPromissory.Phone1 = x["PHONE1_ID"].ToString();
                dataPromissory.Phone2 = x["PHONE2_ID"].ToString();
                dataPromissory.MovilPhone = x["MOVILPHONE_ID"].ToString();
                dataPromissory.Activity = x["ACTIVITY"].ToString();
                dataPromissory.OldLabor = OpenConvert.ToInt64Nullable(x["OLDLABOR"]); ;
                dataPromissory.MonthlyIncome = Double.Parse(x["MONTHLYINCOME"].ToString());
                dataPromissory.ExpensesIncome = Double.Parse(x["EXPENSESINCOME"].ToString());

                dataPromissory.CommercialReference = x["COMMERREFERENCE"].ToString();
                dataPromissory.PhoneCommRefe = x["PHONECOMMREFE"].ToString();
                dataPromissory.MovilPhoCommRefe = x["MOVILPHOCOMMREFE"].ToString();

                Int64 addressComm;

                if (Int64.TryParse(x["ADDRESSCOMMREFE"].ToString(), out addressComm))
                {
                    dataPromissory.AddressCommRef = addressComm;
                }

                dataPromissory.FamiliarReference = x["FAMILIARREFERENCE"].ToString();
                dataPromissory.PhoneFamiRefe = x["PHONEFAMIREFE"].ToString();
                dataPromissory.MovilPhoFamiRefe = x["MOVILPHOFAMIREFE"].ToString();

                Int64 addressFamiRefe;

                if (Int64.TryParse(x["ADDRESSFAMIREFE"].ToString(), out addressFamiRefe))
                {
                    dataPromissory.AddressFamiRef = addressFamiRefe;
                }

                dataPromissory.PersonalReference = x["PERSONALREFERENCE"].ToString();
                dataPromissory.PhonePersRefe = x["PHONEPERSREFE"].ToString();
                dataPromissory.MovilPhoPersRefe = x["MOVILPHOPERSREFE"].ToString();

                Int64 addressPersRefe;

                if (Int64.TryParse(x["ADDRESSPERSREFE"].ToString(), out addressPersRefe))
                {
                    dataPromissory.AddressPersRef = addressPersRefe;
                }

                dataPromissory.HolderBill = x["HOLDER_BILL"].ToString();
                dataPromissory.PackageId = Int64.Parse(x["PACKAGE_ID"].ToString());
            }
            return dataPromissory;
        }

        /// <summary>
        /// Obtiene la información del cliente a partir de identificación, tipo de identificación y contrato.
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
        public Promissory getSubscriberInfoBySusc(Int64 IdentTypeId, String identification, Int64 subscriptionId)
        {
            DataSet promissory = new DataSet("cosigner");
            Promissory dataPromissory = new Promissory();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.GetSubscriberInfoBySusc"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTypeId", DbType.Int64, IdentTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentification", DbType.String, identification);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSuscription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orfCursorPromissory");
                OpenDataBase.db.LoadDataSet(cmdCommand, promissory, "cosigner");
            }
            if (promissory.Tables["cosigner"].Rows.Count > 0)
            {
                DataRow row = promissory.Tables["cosigner"].Rows[0];

                /*Nombre de usuario, tipo de identificación, identificación, Sexo, Fecha de Nacimiento, 
                 * Numero de teléfono del predio*/
                dataPromissory.IdentType = Convert.ToString(IdentTypeId);
                dataPromissory.Identification = identification;
                dataPromissory.DebtorName = row["subscriber_name"].ToString();
                dataPromissory.DebtorLastName = row["subs_last_name"].ToString();
                dataPromissory.Gender = row["gender"].ToString();
                if (!string.IsNullOrEmpty(row["Address_Id"].ToString()))
                {
                    dataPromissory.AddressId = Convert.ToInt64(row["Address_Id"].ToString());
                }

                if (!String.IsNullOrEmpty(row["date_birth"].ToString()))
                {
                    dataPromissory.BirthdayDate = Convert.ToDateTime(row["date_birth"].ToString());
                }
            }
            return dataPromissory;
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

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.HasSubscribersById"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdent_Type_Id", DbType.Int32, identType);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, identification);
                OpenDataBase.db.AddOutParameter(cmdCommand, "blResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "blResult").ToString(), out result);

            }
            return result;
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

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("DAMO_PACKAGES.updpos_oper_unit_id"))
            {
               
                OpenDataBase.db.AddInParameter(cmdCommand, "inupos_oper_unit_id", DbType.Int64, pointSale);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage_Id", DbType.Int64, packageId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
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
        public static void GetCommercialSegment(Int64 inuSubscription, out String osbSegment, out Int64 onuSegmentId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BCCOMMERCIALSEGMENTFNB.progetacronnamesegmbysusc"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSubscription);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSegmentId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSegment", DbType.String, 400);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onuSegmentId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSegmentId"));
                osbSegment = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSegment"));
                
            }
        }


        /// <summary>
        /// Validar si el proveedor está habilitado para realizar instalación de gasodoméstico.
        /// </summary> 
        /// <param name="identType">id del proveedor</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 14-10-2014  KCienfuegos.RNP1179  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean isActiveForInstalling(Int32 inuSupplierId)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.ActiveForInstalling"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSupplierId", DbType.Int32, inuSupplierId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /// <summary>
        /// Validar si la línea del artículo está configurada en el parámetro COD_LIN_ART
        /// </summary> 
        /// <param name="nuArticleId">id de la línea</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 14-10-2014  KCienfuegos.RNP1179  1 - creación        
        ///                                 
        /// </changelog>
        public Boolean ValidateArticlesLine(Int32 inuLineId)
        {

            Boolean result;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.ValidateArticleLine"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuLineId", DbType.Int32, inuLineId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "oblResult", DbType.Boolean, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, "oblResult").ToString(), out result);

            }
            return result;
        }

        /// <summary>
        /// Guarda el registro de la venta con instalación
        /// </summary> 
        /// <param name="packageId">id del paquete</param>
        /// <param name="inuSubscription">id del contrato</param>
        /// <param name="inuSupplierId">id del proveedor</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 14-10-2014  KCienfuegos.RNP1179  1 - creación        
        ///                                 
        /// </changelog>
        public void registerSaleInstall(Int64 packageId, Int64 inuSubscription, Int64 inuSupplierId)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegisterSaleInstall"))
            {
                
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSubscription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSupplierId", DbType.Int64, inuSupplierId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
            string validation = string.Empty;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOVentaEmpaquetada.fblValidInstallDate"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            };

        }


        /// <summary>
        /// Obtiene los artículos válidos para Venta empaquetada
        /// </summary> 
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 27-10-2014  KCienfuegos.RNP1808  1 - creación        
        ///                                 
        /// </changelog>
        public DataTable getArticlesGasApplSale(
                                            Int64 supplierId,
                                            Int64 chanelId,
                                            Int64 geoLocation,
                                            Int64 categoryId,
                                            Int64 subcategoryId,
                                            Boolean gracePeriod,
                                            DateTime dateBill,
                                            DateTime saleDate)  
        {
            DataSet articleDataSet = new DataSet("Articles");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOVentaEmpaquetada.getArticlesGasApplSale"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inugeogra_location", DbType.Int64, geoLocation);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSale_Chanel_Id", DbType.Int64, chanelId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCategori_Id", DbType.Int64, categoryId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcateg_Id", DbType.Int64, subcategoryId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "ocuArtList");
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDate", DbType.DateTime, saleDate);
                OpenDataBase.db.LoadDataSet(cmdCommand, articleDataSet, "Articles");
            }
            return articleDataSet.Tables["Articles"];
        }

        /// <summary>
        /// Actualiza el registro de venta fnb empaquetada
        /// </summary> 
        /// <param name="inuSubscription">id del contrato</param>
        /// <param name="packageId">id del paquete</param>
        /// <param name="isbFlag">Flag de venta empaquetada</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 28-10-2014  KCienfuegos.RNP1808  1 - creación        
        ///                                 
        /// </changelog>
        public void UpdateGasFNBSale(Int64 inuSubscription, Int64 packageId, String isbFlag)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOVentaEmpaquetada.UpdateGasFNBSale"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSubscription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbGasFnbSale", DbType.String, isbFlag);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
        public void registerDelivDate(Int64 packageId, String deliverDate)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOflowfnbpack.registerDelivDate"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDelivDate", DbType.String, deliverDate);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("fblValidNumFactMin"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            };
        }


        public void guardarDatosActualizar(Int64 packageId, String nombreActual, String nombreNuevo, String apellidoActual, String apellidoNuevo, String idActual, String idNuevo, String tipo_cambio, String tagname, String tagnamemot, String packtypeid, String idcliente, Int64 idcontato)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_REGISTER_DATOS_ACTUALIZAR"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "package_id", DbType.Int64, packageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "old_name", DbType.String, nombreActual);
                OpenDataBase.db.AddInParameter(cmdCommand, "nombreNuevo", DbType.String, nombreNuevo);
                OpenDataBase.db.AddInParameter(cmdCommand, "apellidoActual", DbType.String, apellidoActual);
                OpenDataBase.db.AddInParameter(cmdCommand, "apellidoNuevo", DbType.String, apellidoNuevo);
                OpenDataBase.db.AddInParameter(cmdCommand, "idActual", DbType.String, idActual);
                OpenDataBase.db.AddInParameter(cmdCommand, "idNuevo", DbType.String, idNuevo);
                OpenDataBase.db.AddInParameter(cmdCommand, "tipo_cambio", DbType.String, tipo_cambio);
                OpenDataBase.db.AddInParameter(cmdCommand, "tagname", DbType.String, tagname);
                OpenDataBase.db.AddInParameter(cmdCommand, "tagnamemot", DbType.String, tagnamemot);
                OpenDataBase.db.AddInParameter(cmdCommand, "packtypeid", DbType.String, packtypeid);
                OpenDataBase.db.AddInParameter(cmdCommand, "idcliente", DbType.String, idcliente);
                OpenDataBase.db.AddInParameter(cmdCommand, "idcontato", DbType.Int64, idcontato);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
            Int32 number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuExistSaleInProcess"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int32, subscriptionId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);

            }

            return number;

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
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Pktblplandife.Fnugetpldicuma"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPldicodi", DbType.Int64, PlandifeId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);

            }

            return number;
        }

        /*************************************************************************************************
        * Historia de Modificaciones        
        * CASO. Puerta a Puerta- Venta de Materiales
        * iblValMaterialSales: Valida si se puede ejecutar la venta de materiales FNB
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        29/09/2015    agordillo              Creación del metodo. Caso.6853
        **************************************************************************************************/
        public Boolean iblValMaterialSales()
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOPROCMATERIALSALES.fblValMaterialSales"))
            {
               
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));

            }
       }

      /*************************************************************************************************
      * Historia de Modificaciones        
      * CASO. Puerta a Puerta- Venta de Materiales
      * getAvalibleArtMaterial: Obtiene los articulos configurados para venta de Materiales
      *
      Fecha             Autor             Modificacion
      =========     ===================   ========================================================
      29/09/2015    agordillo              Creación del metodo. Caso.6853
      **************************************************************************************************/
      public DataTable getAvalibleArtMaterial(
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
          DataSet articleDataSet = new DataSet("Articles");

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOPROCMATERIALSALES.getAvalibleArtMaterial"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
              OpenDataBase.db.AddInParameter(cmdCommand, "inugeogra_location", DbType.Int64, geoLocation);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSale_Chanel_Id", DbType.Int64, chanelId);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuCategori_Id", DbType.Int64, categoryId);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSubcateg_Id", DbType.Int64, subcategoryId);
              OpenDataBase.db.AddParameterRefCursor(cmdCommand, "ocuArtList");
              OpenDataBase.db.AddInParameter(cmdCommand, "idtDate", DbType.DateTime, saleDate);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuPlan_finan", DbType.String, flagCuotaFija);
              OpenDataBase.db.LoadDataSet(cmdCommand, articleDataSet, "Articles");
          }
          return articleDataSet.Tables["Articles"];
      }


      /*************************************************************************************************
        * Historia de Modificaciones        
        * CASO. Puerta a Puerta- Venta de Materiales
        * fblOrdMaterialSale: Valida si la Orden Ingresada es Venta de Materiales
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        29/09/2015    agordillo              Creación del metodo. Caso.6853
        **************************************************************************************************/
      public Boolean fblOrdMaterialSale(Int64 orderId)
      {
          //Inicio CASO 200-85
          //Bloqueo de codigo ya qeu en EFIGAS y GDC no utilizan este paquete LDC_BOPROCMATERIALSALES
          //using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOPROCMATERIALSALES.fblOrdenMaterialSale"))
          //{

          //    OpenDataBase.db.AddInParameter(cmdCommand, "inuOrden", DbType.Int64, orderId);
          //    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
          //    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
          //    return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));

          //}
          //Fin CASO 200-85

          return false;

      }

      /*************************************************************************************************
        * Historia de Modificaciones        
        * CASO. Puerta a Puerta- Venta de Materiales
        * fnugetValueSale: Obtiene el valor de la venta
        *
        Fecha             Autor             Modificacion
        =========     ===================   ========================================================
        29/09/2015    agordillo              Creación del metodo. Caso.6853
        **************************************************************************************************/
      public Int64 fnugetValueSale(Int64 orderID)
      {
          Int64 nuValueSale;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOPROCMATERIALSALES.fnuValueSale"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuOrderID", DbType.Int64, orderID);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuValueSale = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuValueSale;
      }

      //Inicio CASO 200-85
      //Servicio para obtener si la gasera a la que se conecta esta forma FIFAP tiene parametro 
      //para autorizar el uso de la logica del desarrollo CA 200-85
      public Boolean DALFBLAplicaParaGDC(string sbParemtroGlobal)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_CONFIGURACIONRQ.aplicaParaGDC"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "sbParemtroGlobal", DbType.String, sbParemtroGlobal);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);

              return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
          }
      }

      public Boolean DALFBLAplicaParaEfigas(string sbParemtroGlobal)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_CONFIGURACIONRQ.aplicaParaEfigas"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "sbParemtroGlobal", DbType.String, sbParemtroGlobal);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);

              return OpenConvert.ToBool(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
          }
      }

      //Prcedimiento que permite identificar si la nueva identificacion ya existe en el sistema o que la anteior identificacion 
      //no tiene un codigo de cliente en el sistem.
      public static void PRGETINFOCODEUDOR(String isbIdentification_oldDAL, String isbIdentification_newDAL, out Int64 onuSubscriberId_oldDAL, out Int64 onuSubscriberId_newDAL, out Int64 onuCodigoErrorDAL, out String osbMensajeErrorDAL)
      {

          //public static void GetCommercialSegment(Int64 inuSubscription, out String osbSegment, out Int64 onuSegmentId)
          //{
          //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BCCOMMERCIALSEGMENTFNB.progetacronnamesegmbysusc"))
          //    {

          //        OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSubscription);
          //        OpenDataBase.db.AddOutParameter(cmdCommand, "onuSegmentId", DbType.Int64, 15);
          //        OpenDataBase.db.AddOutParameter(cmdCommand, "osbSegment", DbType.String, 400);
          //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);

          //        onuSegmentId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSegmentId"));
          //        osbSegment = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSegment"));

          //    }
          //}

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.LDC_PRGETINFOCODEUDOR"))
          {
              //ExceptionHandler.DisplayMessage(2741, "IDENTIFICACION  OLD [" + isbIdentification_oldDAL + "] - NEW [" + isbIdentification_newDAL + "]");

              OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification_old", DbType.String, isbIdentification_oldDAL);
              OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification_new", DbType.String, isbIdentification_newDAL);
              OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId_old", DbType.Int64, 15);
              OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId_new", DbType.Int64, 15);
              OpenDataBase.db.AddOutParameter(cmdCommand, "onuCodigoError", DbType.Int64, 15);
              OpenDataBase.db.AddOutParameter(cmdCommand, "osbMensajeError", DbType.String, 200);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);

              onuSubscriberId_oldDAL = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId_old"));
              onuSubscriberId_newDAL = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId_new"));
              onuCodigoErrorDAL = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCodigoError"));
              osbMensajeErrorDAL = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbMensajeError"));

              //ExceptionHandler.DisplayMessage(2741, "CODIGO CLIENTE OLD [" + onuSubscriberId_oldDAL.ToString() + "] - NEW [" + onuSubscriberId_newDAL.ToString() + "]");

              if (isbIdentification_oldDAL != isbIdentification_newDAL)
              {
                  if (onuCodigoErrorDAL != 0)
                  {
                      ExceptionHandler.DisplayMessage(2741, osbMensajeErrorDAL);
                      //OpenDataBase.Transaction.Rollback();                    
                  }
              }
              else
              {
                  onuCodigoErrorDAL = 0;
                  osbMensajeErrorDAL = "OK";
              }
          }
      }

      //Servicio para obtener VERDADERO si el contrto tiene uan cantidad mayor o igual de facturas generadas para porder realizar
      //una venta en FIFAP desde DATOS BASICOS
      public Boolean fblValidCanFact(Int64 subscriptionId)
      {

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.fblValidCanFact"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);

              return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
          };
      }

      //Fin CASO 200-85

      //Incio 200-310
      //Servicio para identificar si el CODEUDOR tiene ventas avaladas la scuales aun no esta canceladas en su totalidad
      public Int64 DALFNUCANTVENTSINCANC(Int64 inuIdentTypeCodeudor, String inuIdentCodeudor)
      {
          Int64 nuFNUCANTVENTSINCANC;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FNUCANTVENTSINCANC"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeCodeudor", DbType.Int64, inuIdentTypeCodeudor);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentCodeudor", DbType.Int64, inuIdentCodeudor);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuFNUCANTVENTSINCANC = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuFNUCANTVENTSINCANC;
      }
      //Fin 200-310

      //Incio 200-854
      //Servicio para identificar retornar el codigo del PAGARE UNICO asociado al contrato
      public Int64 DALFNUPAGAREUNICO(Int64 subscriptionId)
      {
          Int64 nuFNUPAGAREUNICO;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUPAGAREUNICO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuFNUPAGAREUNICO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuFNUPAGAREUNICO;
      }

      //Servicio para retornar el codigo de la solicitud de PAGARE UNICO - EN PROCESO asociado al contrato
      public Int64 DALFSOLICITUDNUPAGAREUNICO(Int64 subscriptionId)
      {
          Int64 nuSOLICITUDPAGAREUNICO;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUSOLICITUDPAGAREUNICO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuSOLICITUDPAGAREUNICO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuSOLICITUDPAGAREUNICO;
      }

      //Servicio para identificar el codigo del VOUCHER correspondiente al PAGARE UNICO
      public Int64 DALFNUVOUCHER(Int64 subscriptionId, Int64 NUPAGAREUNICO)
      {
          Int64 nuFNUVOUCHER;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUVOUCHER"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsription", DbType.Int64, subscriptionId);
              OpenDataBase.db.AddInParameter(cmdCommand, "NUPAGAREUNICO", DbType.Int64, NUPAGAREUNICO);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuFNUVOUCHER = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuFNUVOUCHER;
      }


      public static DataTable DALFtrfPromissoryPU(Int64 nuPackageId, String sbPromissoryType)
      {
          DataSet DSpromissory = new DataSet("promissory_pu");
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.ftrfpromissory"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
              OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryType", DbType.String, sbPromissoryType);
              OpenDataBase.db.AddReturnRefCursor(cmdCommand);
              OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory_pu");
          }
          return DSpromissory.Tables["promissory_pu"];
      }


      //servicio para relacionar la solicitud de venta y el VOUCHER del PAGARE UNICO
      public static void DALRegisterVentaFNBVoucher(Int64 inupackage_id, Int64 inupagare_id, Int64 inuvoucher, Double inutotal_financiar, Int64 inutotal_cuotas, Double inucuota_inicial, Double inucosto_seguro)
      {

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.RegisterVentaFNBVoucher"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
              OpenDataBase.db.AddInParameter(cmdCommand, "inupagare_id", DbType.String, inupagare_id);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuvoucher", DbType.String, inuvoucher);
              OpenDataBase.db.AddInParameter(cmdCommand, "inutotal_financiar", DbType.String, inutotal_financiar);
              OpenDataBase.db.AddInParameter(cmdCommand, "inutotal_cuotas", DbType.String, inutotal_cuotas);
              OpenDataBase.db.AddInParameter(cmdCommand, "inucuota_inicial", DbType.String, inucuota_inicial);
              OpenDataBase.db.AddInParameter(cmdCommand, "inucosto_seguro", DbType.String, inucosto_seguro);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
          }
      }

      public static void ConsultaSPUCodeudor(Int64 inupackage_id, Int64 inupagare_id, Int64 inususcription_id, out Int64 onususcription_codeudor_id, out String osbidentificacion_codeudor_OLD, out String osbidentificacion_codeudor_NEW)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.ConsultaSPUCodeudor"))
          {
              //ExceptionHandler.DisplayMessage(2741, "IDENTIFICACION  OLD [" + isbIdentification_oldDAL + "] - NEW [" + isbIdentification_newDAL + "]");

              OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
              OpenDataBase.db.AddInParameter(cmdCommand, "inupagare_id", DbType.Int64, inupagare_id);
              OpenDataBase.db.AddInParameter(cmdCommand, "inususcription_id", DbType.Int64, inususcription_id);
              OpenDataBase.db.AddOutParameter(cmdCommand, "onususcription_codeudor_id", DbType.Int64, 15);
              OpenDataBase.db.AddOutParameter(cmdCommand, "osbidentificacion_codeudor_OLD", DbType.String, 20);
              OpenDataBase.db.AddOutParameter(cmdCommand, "osbidentificacion_codeudor_NEW", DbType.String, 20);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);

              onususcription_codeudor_id = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onususcription_codeudor_id"));
              osbidentificacion_codeudor_OLD = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbidentificacion_codeudor_OLD"));
              osbidentificacion_codeudor_NEW = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbidentificacion_codeudor_NEW"));

          }
      }

      //Servicio para retornar si la OT de revision de documento de la solciitud de PAGARE UNICO fue legalizada con causal de EXITO o FALLO
      public Int64 DALFNUSOLICITUDPUATENDIDA(Int64 inuSoliciutd)
      {
          Int64 nuOTREVDOCEXITOFALLO;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUSOLICITUDPUATENDIDA"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuSoliciutd", DbType.Int64, inuSoliciutd);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuOTREVDOCEXITOFALLO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuOTREVDOCEXITOFALLO;
      }
        
      //Fin 200-854

      // CASO 200-850. Proveedor CENCOSUD
      public bool isProvCENCOSUD(long? supplierId)
      {
          Boolean isExito = false;
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnuBoIsCENCOSUD"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, supplierId);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              Boolean.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out isExito);
          };
          return isExito;
      }

      public void RegisterExtraQuotaFNBDeta(Int64? nuExtraQuotaId, Int64 SubscriptionId, Double? usedQuota, Int64 inuPackage_id)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.RegisterExtraQuotaFNBDeta"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "nuExtraQuotaId", DbType.Int64, nuExtraQuotaId);
              OpenDataBase.db.AddInParameter(cmdCommand, "SubscriptionId", DbType.Int64, SubscriptionId);
              OpenDataBase.db.AddInParameter(cmdCommand, "usedQuota", DbType.Double, usedQuota);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage_id", DbType.Int64, inuPackage_id);

              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
          }
      }
      public void ValidarExtraQuotaFNBDeta(Int64 inuPackage_id)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.ValidarExtraQuotaFNBDeta"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "inupackage", DbType.Int64, inuPackage_id);

              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
          }
      }
      //CASO 200-850. Proveedor CENCOSUD

      //CASO 200-468 Venta - Mantenimiento
      public Int64 FNUPROVEEDORVENTAMATERIALES(Int64? INSUPPLIER)
      {
          //1 - Existe el proveedor para venta de mantenimiento
          //0 - NO existe el proveedor para venta de mantenimiento
          Int64 nuSupplier;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FNUPROVEEDORVENTAMATERIALES"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "INSUPPLIER", DbType.Int64, INSUPPLIER);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuSupplier = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuSupplier;
      }

      public Int64 FNUARTISUBLPROV(Int64? INSUPPLIER, Int64 INARTICLE)
      {
          //1 - Existe el proveedor para venta de mantenimiento
          //0 - NO existe el proveedor para venta de mantenimiento
          Int64 nuSupplier;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FNUARTISUBLPROV"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "INSUPPLIER", DbType.Int64, INSUPPLIER);
              OpenDataBase.db.AddInParameter(cmdCommand, "INARTICLE", DbType.Int64, INARTICLE);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuSupplier = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuSupplier;
      }
      //CASO 200-468 Venta - Mantenimiento

      //CASO 200-750
      public Int64 FNUVALIDADIRECCION(Int64 NUADDRESS_ID)
      {
          //1 - Existe el codigo de la direccion en el paramatro de direcciones invalidas
          //0 - NO Existe el codigo de la direccion en el paramatro de direcciones invalidas
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FNUVALIDADIRECCION"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "INSUPPLIER", DbType.Int64, NUADDRESS_ID);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }
      //CASO 200-750

      //CASO 200-755
      public Int64 FNUCUPOMANUAL(Int64 SubscriptionId)
      {
          //1 - Para los contratos que tienen cupo manual
          //0 - Para los contratos que NO tienen cupo manual
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAFNB.FNUCUPOMANUAL"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "v_subscription_id", DbType.Int64, SubscriptionId);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }
      //CASO 200-755

      //CASO 200-1164
      public Int64 FNUSEGUROVOLUNTARIO(Int64 InuArticulo)
      {
          //1 - Para identificar si existe el articulo como seguro voluntario
          //0 - Para identificar si NO existe el articulo como seguro voluntario
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUSEGUROVOLUNTARIO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "InuArticulo", DbType.Int64, InuArticulo);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
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
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUEXISTESEGUROVOLUNTARIO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "InuSUSCCODI", DbType.Int64, InuSUSCCODI);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }

      public Int64 ldc_fnucomodato(Int64 InuSUSCCODI)
      {
          //Esta funcion definira si el suscriptor puede volver a utilizar el seguro voluntario en otra venta 
          //debido a que en este momento del CASO solo se autirza la venta de un solo seguro voluntario por 
          //parte de CARDIF.
          //(1) --> Para las subscripciones que estan registradas en la tabla LD_SUBS_COMO_DATO y estan dentro de un rango de fechas validos.
          //(0) --> Para aquellos que NO.
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_fnucomodato"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "InuSUSCCODI", DbType.Int64, InuSUSCCODI);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }

      public void PRREGISTROSEGUROVOLUNTARIO(Int64 InuSUSCCODI,Int64 InuPACKAGE_ID)
      {
          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.PRREGISTROSEGUROVOLUNTARIO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "InuSUSCCODI", DbType.Int64, InuSUSCCODI);
              OpenDataBase.db.AddInParameter(cmdCommand, "InuSUSCCODI", DbType.Int64, InuPACKAGE_ID);
              //OpenDataBase.db.AddInParameter(cmdCommand, "isbEmail", DbType.String, promissory.Email);              
          }
      }
      public Int64 FNUEDADVALIDASEGURO(String yearsDeudorSeguro)
      {
          //Retorna un valor indicado si la edad del deudor es valida para obtener el seguro          
          //0 - FALLO que NO es valido para utilizar el seguro
          //1 - EXITO que es valido para utilizar el seguro
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUEDADVALIDASEGURO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "yearsDeudorSeguro", DbType.String, yearsDeudorSeguro);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }

      public Int64 FNUORDENSEGUROVOLUNTARIO(Int64 nuorder_activity_id)
      {
          //Valida si la orden desplegada en FLOTE tiene o no un articulo 
          //de seguro voluntario en la venta BRILLA
          //0 - La orden NO tiene relacion con articulo de seguro volunatio
          //1 - La orden tiene relacion con articulo de seguro volunatio
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUORDENSEGUROVOLUNTARIO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "nuorder_activity_id", DbType.Int64, nuorder_activity_id);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }

      public Int64 LDC_FNUREALIZAVENTA(Int64 v_solicitud_id)
      {
          //(1) --> Si la solicitud ingresada es igual a la minima obtenida en el cursor
          //(0) --> Si la solicitud ingresada es diferente a la minima obtenida en el cursor.
          //        Si no se Obtienen resultados.
          //        Si ocurre un error.
          Int64 nuRetornaValor;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_FNUREALIZAVENTA"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "v_solicitud_id", DbType.Int64, v_solicitud_id);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuRetornaValor;
      }
      //CASO 200-1164


      //Comentariar hasta que se valide el tema el VOUCHER
      //Inicio CASO 200-1880
      //Servicio para identificar retornar el codigo del PAGARE UNICO asociado al contrato
      public Int64 DALFNUVALIDAPAGAREUNICO(Int64 InuPagareUnico)
      {
          Int64 nuFNUVALIDAPAGAREUNICO;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUVALIDAPAGAREUNICO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "InuPagareUnico", DbType.Int64, InuPagareUnico);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuFNUVALIDAPAGAREUNICO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuFNUVALIDAPAGAREUNICO;
      }

      //Identificar que el DEUDOR sea el 1er en un venta de FIFAP o Pagare Unico si el CODEUDOR es DEUDOR SOLIDARIO.
      public Int64 DALFNUDEUDORSOLIDARIO(String isbIdentification, Int64 inuIdentType, String isbIdenDeudor, Int64 inuIdenTypeDeudor)
      {
          Int64 nuFNUDEUDORSOLIDARIO;

          using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FNUDEUDORSOLIDARIO"))
          {
              OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, isbIdentification);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentType", DbType.Int64, inuIdentType);
              OpenDataBase.db.AddInParameter(cmdCommand, "isbIdenDeudor", DbType.String, isbIdenDeudor);
              OpenDataBase.db.AddInParameter(cmdCommand, "inuIdenTypeDeudor", DbType.Int64, inuIdenTypeDeudor);
              OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
              OpenDataBase.db.ExecuteNonQuery(cmdCommand);
              nuFNUDEUDORSOLIDARIO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
          };
          return nuFNUDEUDORSOLIDARIO;
      }

      //Validar si una cadena1 esta contenida en cadena2
      public Int64 DALFNUPARAMETROCADENA(String IsbCadena1, String IsbCadena2)
      {
          Int64 nuFNUVALIDARPARAMETRO = 0;

          //CASO 200-1880
          //Validar Si el codigo de la direccion existe en al parametro
          String sbCodigoDireccionCodeudor = IsbCadena1;
          String sbCOD_DIR_GEN_FIFAP = IsbCadena2;
          String sbSubCadena = string.Empty;
          //int NuposicionCadena = 0;
          for (int Nuposicion = 0; Nuposicion < sbCOD_DIR_GEN_FIFAP.Length; Nuposicion++)
          {
              if (sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1) == ",")
              {
                  if (sbSubCadena == sbCodigoDireccionCodeudor)
                  {
                      nuFNUVALIDARPARAMETRO = 1;
                  }
                  sbSubCadena = string.Empty;

              }
              else
              {
                  sbSubCadena = sbSubCadena + sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1);
              }
          }
          if (sbSubCadena == sbCodigoDireccionCodeudor)
          {
              nuFNUVALIDARPARAMETRO = 1;
          }
          //Fin variables y comparacion          

          return nuFNUVALIDARPARAMETRO;
      }


      //Fin CASO 200-1880

    }     
}