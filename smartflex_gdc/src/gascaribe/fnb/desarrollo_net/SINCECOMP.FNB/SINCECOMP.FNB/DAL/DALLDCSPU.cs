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
    internal class DALLDCSPU
    {
        public void RegisterDeudor(Int64? subscriberId, Promissory promissory)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.RegisterDeudorData"))
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
                Int64? contractType = null;
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


        public void RegisterCosigner(Promissory promissory)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.RegisterCosignerData"))
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

        public void RegisterSPUContrato(Int64? inupackage_id, Int64? inupagare_id, Int64? inususcription_id ,Int64? inuproduct_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.RegisterSPUContrato"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupagare_id", DbType.Int64, inupagare_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inususcription_id", DbType.String, inususcription_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproduct_id", DbType.String, inuproduct_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Datos adiconales para CODEUDOR desde PAGARE UNICO
        public void RegisterSPUCodeudor(Int64? inupackage_id, Int64? inupagare_id, Int64? inususcription_id, Int64? inususcription_codeudor_id, String isbidentificacion_codeudor_OLD, String isbidentificacion_codeudor_NEW)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.RegisterSPUCodeudor"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupackage_id", DbType.Int64, inupackage_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupagare_id", DbType.Int64, inupagare_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inususcription_id", DbType.Int64, inususcription_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inususcription_codeudor_id", DbType.Int64, inususcription_codeudor_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbidentificacion_codeudor_OLD", DbType.String, isbidentificacion_codeudor_OLD);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbidentificacion_codeudor_NEW", DbType.String, isbidentificacion_codeudor_NEW);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //CASO 200-1880
        //GetSubcriptionData
        public DataFIFAP getSubscriptionDataLDCSPU(Int64 subscription)
        {
            DataFIFAP dataFIFAP = new DataFIFAP();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.getFIFAPInfo"))
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
        //CASO 200-1880

    }
}
