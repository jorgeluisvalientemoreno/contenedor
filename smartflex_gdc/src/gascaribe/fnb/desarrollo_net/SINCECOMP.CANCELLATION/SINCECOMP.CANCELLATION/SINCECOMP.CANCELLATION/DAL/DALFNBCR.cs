using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.CANCELLATION.Entities;
using OpenSystems.Common.Util;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.CANCELLATION.DAL
{
    class DALFNBCR
    {
        static String queryValue = "LD_BONONBANKFINANCING.frfGetRecords_fnbcr"; //consultar la informacion
        static String queryContrat = "LD_BONONBANKFINANCING.fnugetContratid"; //informacion contarto
        static String queryBasicData = "LD_BONONBANKFINANCING.GetSubscriptionBasicData";//suscripcion 

        //condulta datos grilla
        public static DataTable getAnulDeta(Int64 inufindvalue)
        {
            DataSet dsfnbcr = new DataSet("LDQuery");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryValue))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, inufindvalue);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsfnbcr, "LDQuery");
            }
            return dsfnbcr.Tables["LDQuery"];
        }

        //numero contrato
        public static Int64 consValue(Int64 inufindvalue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryContrat))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, inufindvalue);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //datos basicos
        public BasicDataFNBCR getBasicData(Int64 subscription)
        {
            BasicDataFNBCR dataFNBCR = new BasicDataFNBCR();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryBasicData))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, subscription);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuIdentType", DbType.Int64 , 4);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbIdentification", DbType.String, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsLastName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbAddress", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAddress_Id", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuGeoLocation", DbType.Int64, 6);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFullPhone", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuCategory", DbType.Int64, 2);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubcategory", DbType.Int64, 2);
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64? dato = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuIdentType"));
                if (dato == null)
                    dataFNBCR.IdentType = 0;
                else
                    dataFNBCR.IdentType = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuIdentType"));
                Object Texto = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"));
                if (Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"))==null)
                    dataFNBCR.Identification = "";
                else
                dataFNBCR.Identification = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"));
                if(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsName"))==null)
                    dataFNBCR.SubName = "";
                else
                dataFNBCR.SubName = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsName"));
                if(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"))==null)
                    dataFNBCR.SubLastname = "";
                else
                dataFNBCR.SubLastname = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"));
                if(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress"))==null)
                    dataFNBCR.Address = "";
                else
                dataFNBCR.Address = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress"));
                //dataFNBCR.AddressId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddress_Id"));
                //dataFNBCR.GeoLocation = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuGeoLocation"));
                if (Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone"))==null)
                    dataFNBCR.FullPhone = "";
                else
                dataFNBCR.FullPhone = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone"));
                //dataFNBCR.SubCategory = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubCategory"));
                //dataFNBCR.CategoryId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCategory"));
                //dataFNBCR.SubcategoryId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubcategory"));
                //dataFNBCR.Category = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbCategory"));
                //dataFNBCR.SubscriberId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId"));
                return dataFNBCR;
            }
        }
      

        public List<ArticleSaleCancelation> getSaleForCancelation(Int64 PackageId)
        {
            DataSet ArticleCancelation = new DataSet("saleCancelation");
            List<ArticleSaleCancelation> ListArticleCancelation = new List<ArticleSaleCancelation>();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.getSaleForCancelation"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, PackageId);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, ArticleCancelation, "saleCancelation");
            }

            foreach (DataRow x in ArticleCancelation.Tables["saleCancelation"].Rows)
            {

                
                
                //pendiente orden de entrega adolfo acuña
                ListArticleCancelation.Add(new ArticleSaleCancelation(Convert.ToInt64(x[0]), //articulo
                                                                      x[1].ToString(), //descripcion
                                                                      Convert.ToInt64(x[2].ToString()), //proveedor
                                                                      Convert.ToString(x[3]), //nombre proveedor
                                                                      Convert.ToString(x[4]),//direccion
                                                                      int.Parse (x[5].ToString()), //cantidad
                                                                      Convert.ToDouble(x[6]), //valor unitario
                                                                      Convert.ToDouble(x[7]), //iva
                                                                      Convert.ToDouble(x[8]), //valor total
                                                                      Convert.ToInt64(x[9]), //actividad de venta
                                                                      Convert.ToString(x[10]))); 
            }

            return ListArticleCancelation;
        }


        public DataFIFAP getSubscriptionData(Int64 packageId)
        {
            DataFIFAP dataFIFAP = new DataFIFAP();
            
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.GetSubDataBySalePack"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, packageId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscription", DbType.Int64, 100);

                OpenDataBase.db.AddOutParameter(cmdCommand, "osbIdentType", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbIdentification", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId", DbType.Int64, 20);
            
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubsLastName", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbAddress", DbType.String, 300);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAddress_Id", DbType.Int64, 20);

                //OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuGeoLocation", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFullPhone", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSubCategory", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuCategory", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubcategory", DbType.Int64, 20);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuPersonId", DbType.Int64, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbPersonName", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuPointSaleId", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbPointSaleName", DbType.String, 200);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuScoring", DbType.Int64, 200);
          
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);                

                dataFIFAP.IdentType = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentType"));
                dataFIFAP.Identification = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbIdentification"));
                dataFIFAP.ContractId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscription"));
                dataFIFAP.SubscriberId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId"));
                dataFIFAP.SubName = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsName"));
                dataFIFAP.SubLastname = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubsLastName"));
                dataFIFAP.Address = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbAddress"));
                try
                {
                    //SINCECOMP.FNB.BL.BLGENERAL.mensaje(cmdCommand.Parameters["onuAddress_Id"].Value.ToString());
                    dataFIFAP.AddressId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddress_Id"));
                }
                catch{
                    ;
                }
                try
                {
                    dataFIFAP.GeoLocation = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuGeoLocation"));
                }
                catch
                {
                    ;
                }
                dataFIFAP.FullPhone = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFullPhone"));
                dataFIFAP.SubCategory = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbSubCategory"));
                try
                {
                    dataFIFAP.CategoryId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuCategory"));
                }
                catch
                {
                    ;
                }
                try
                {
                    dataFIFAP.SubcategoryId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubcategory"));
                }
                catch
                {
                    ;
                }

                dataFIFAP.PointSaleId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuPointSaleId"));
                dataFIFAP.PointSaleName = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPointSaleName"));
                dataFIFAP.SellerId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuPersonId"));
                dataFIFAP.SellerName = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbPersonName"));

                dataFIFAP.Scoring = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuScoring"));
               
                return dataFIFAP;
            }
        }

        public Int64? registerXML(String cadenaXML)
        {
            Int64? packageId = null;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("OS_RegisterRequestWithXML"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "sbRequestXML", DbType.String, cadenaXML);
                OpenDataBase.db.AddOutParameter(cmdCommand, "nuPackageId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "nuMotiveId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "nuErrorCode", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "sbErrorMessage", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                ExceptionHandler.EvaluateErrorCode
                (
                   OpenDataBase.db.GetParameterValue(cmdCommand, "nuErrorCode"),
                   OpenDataBase.db.GetParameterValue(cmdCommand, "sbErrorMessage")
                );

                packageId = OpenConvert.ToLongNullable(OpenDataBase.db.GetParameterValue(cmdCommand, "nuPackageId"));
            }

            return packageId;
        }

        public Int32 validateAreaOrga()
        {
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.fnuvalidAreaOrga"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);
            }

            Int32 retorno = number;

            return retorno;
        }

        internal RequestFBNCR getRequestData(Int64? subscriberId)
        {
            RequestFBNCR requestFBNCR = new RequestFBNCR();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOUtilCancellations.GetInteractionData"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscriberId", DbType.Int64, subscriberId);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuInteractionId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuAddressId", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuReceptionType", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuContactId", DbType.Int64, 15); 
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuIdentTypeContact", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuIdentContact", DbType.String, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuNameContact", DbType.String, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuLastNameContact", DbType.String, 4000);

                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                requestFBNCR = new RequestFBNCR();

                requestFBNCR.InterationId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInteractionId"));
                requestFBNCR.DeliveryAddressId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuAddressId"));
                requestFBNCR.ReceptionTypeId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuReceptionType"));
                requestFBNCR.ContactId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuContactId"));
                requestFBNCR.IdentTypeContact = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuIdentTypeContact"));
                requestFBNCR.IdentContact = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuIdentContact"));
                requestFBNCR.NameContact = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuNameContact"));
                requestFBNCR.LastNameContact = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuLastNameContact"));  
            }

            return requestFBNCR;
        }


        public Boolean validatedSolAnuDevPend(Int64 SaleRequestId)
        {
            try{

            
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.validatedSolAnuDevPend"))            
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "SaleRequestId", DbType.Int64, SaleRequestId);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);                            
                }                  
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
                return false;
            }

            return true;
        }

        public Int32 validateAndCreateContact(Int64? contactId, String Name, String LastName, String Address, String Phone, Int64 IdentType, String Identification, Int64 Status, Int64? AddressId)
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("GE_BOSubscriber.CreateContact"))
                {
                    OpenDataBase.db.AddParameter(cmdCommand, "ionuContactId", DbType.Int64, ParameterDirection.InputOutput, string.Empty, DataRowVersion.Default, contactId);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbSubscriberName", DbType.String, Name);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbSubsLastName", DbType.String, LastName);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbAddress", DbType.String, Address);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbPhone", DbType.String, Phone);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeId", DbType.Int64, IdentType);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, Identification);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuSubStatusId", DbType.Int64, Status);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuAddressId", DbType.Int64, AddressId);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    return OpenConvert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "ionuContactId"));
                }
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
                return 0;
            }
        }

        public RequestFBNCR Getsubscriber(Int64 IdentType, String Identification)
        {
            RequestFBNCR subscriberInfo = new RequestFBNCR();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.getInfoSubscriber"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIdentTypeId", DbType.Int64, IdentType);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentification", DbType.String, Identification);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubscriberId", DbType.Int64, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubsName", DbType.String, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuSubsLastName", DbType.String, 4000);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                subscriberInfo.ContactId = OpenConvert.ToInt64Nullable(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubscriberId"));
                subscriberInfo.NameContact = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubsName"));
                subscriberInfo.LastNameContact = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuSubsLastName"));
            }

            return subscriberInfo;
        }


        public void setArticlesDevGS(Int64? packageId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.setArticlesDevGS"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, packageId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }            
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
        public Int32 validatePackageCancel(Int64 packageId)
        {
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.fnuGetPackageCancel"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, packageId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);
            }

            Int32 retorno = number;

            return retorno;
        }

        //*****************************************************************
        //200-1164
        public Int64 FNUCAUSALANUDEV(Int64 nuCausal)
        {
            /*
            Valida si la causal es para identificar las ordenes de seguro voluntario existentes en FNBCR
            0 - La causal NO tiene relacion con articulo de seguro volunatio
            1 - La causal tiene relacion con articulo de seguro volunatio                  
             */
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUCAUSALANUDEV"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCausal", DbType.Int64, nuCausal);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);
            }

            Int32 retorno = number;

            return retorno;
        }

        public Int64 FNUORDENSEGUROVOLUNTARIO(Int64 nuorder_activity_id)
        {
            /*
            Valida si la orden desplegada tiene o no un articulo de seguro voluntario en la venta BRILLA
            0 - La orden NO tiene relacion con articulo de seguro volunatio
            1 - La orden tiene relacion con articulo de seguro volunatio              
             */
            int number;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.FNUORDENSEGUROVOLUNTARIO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuorder_activity_id ", DbType.Int64, nuorder_activity_id);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int32.TryParse(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString(), out number);
            }

            Int32 retorno = number;

            return retorno;
        }

        public void PRACTUALIZAVENTASEGUROS(Int64 InuPACKAGE_ID, String IsbEstado, Int64 InuActividad)
        {
            //MessageBox.Show("InuPACKAGE_ID[" + InuPACKAGE_ID + "] - IsbEstado[" + IsbEstado + "] - InuActividad[" + InuActividad + "]");
                                            
            //Actualiza estado del artiuclo vendido en FIFAP de seguro voluntario
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTASEGUROVOLUNTARIO.PRACTUALIZAVENTASEGURO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuPACKAGE_ID", DbType.Int64, InuPACKAGE_ID);
                OpenDataBase.db.AddInParameter(cmdCommand, "IsbEstado", DbType.String, IsbEstado);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuActividad", DbType.Int64, InuActividad);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //CASO 200-1164

        //Caso 200-2389
        public Int64 fnu_DifSeguroVoluntario(Int64 inuPackageId, Int64 inuArticleId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.fnu_DifSeguroVoluntario"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuArticleId", DbType.Int64, inuArticleId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public Int64 fnu_CausalAplica(Int64 inuCausalId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.fnu_CausalAplica"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCausalId", DbType.Int64, inuCausalId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public Int64 fnu_ArticuloSV(Int64 inuArticleId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOcancellations.fnu_ArticuloSV"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuArticleId", DbType.Int64, inuArticleId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }
        //

    }
}
