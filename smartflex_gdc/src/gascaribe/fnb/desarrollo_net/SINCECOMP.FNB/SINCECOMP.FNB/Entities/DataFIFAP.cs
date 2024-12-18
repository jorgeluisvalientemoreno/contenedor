using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    public class DataFIFAP
    {
        private String identType;

        public String IdentType
        {
            get { return identType; }
            set { identType = value; }
        }
        private String identification;

        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }
        private String subName;

        public String SubName
        {
            get { return subName; }
            set { subName = value; }
        }
        private String subLastname;

        public String SubLastname
        {
            get { return subLastname; }
            set { subLastname = value; }
        }

        private Int64? addressId;

        public Int64? AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        private String address;

        public String Address
        {
            get { return address; }
            set { address = value; }
        }

        private Int64? geoLocation;

        public Int64? GeoLocation
        {
            get { return geoLocation; }
            set { geoLocation = value; }
        }

        private String fullPhone;

        public String FullPhone
        {
            get { return fullPhone; }
            set { fullPhone = value; }
        }


        private Int64? categoryId;

        public Int64? CategoryId
        {
            get { return categoryId; }
            set { categoryId = value; }
        }

        private Int64? subcategoryId;

        public Int64? SubcategoryId
        {
            get { return subcategoryId; }
            set { subcategoryId = value; }
        }

        private String subCategory;

        public String SubCategory
        {
            get { return subCategory; }
            set { subCategory = value; }
        }

        private String category;

        public String Category
        {
            get { return category; }
            set { category = value; }
        }

        private String balance;

        public String Balance
        {
            get { return balance; }
            set { balance = value; }
        }
        private String assignedQuote;

        public String AssignedQuote
        {
            get { return assignedQuote; }
            set { assignedQuote = value; }
        }
        private String usedQuote;

        public String UsedQuote
        {
            get { return usedQuote; }
            set { usedQuote = value; }
        }
        private String avalibleQuota;

        public String AvalibleQuota
        {
            get { return avalibleQuota; }
            set { avalibleQuota = value; }
        }

        private Int64? billId1;

        public Int64? BillId1
        {
            get { return billId1; }
            set { billId1 = value; }
        }

        private Int64? billId2;

        public Int64? BillId2
        {
            get { return billId2; }
            set { billId2 = value; }
        }

        private DateTime? billDate1;

        public DateTime? BillDate1
        {
            get { return billDate1; }
            set { billDate1 = value; }
        }

        private DateTime? billDate2;

        public DateTime? BillDate2
        {
            get { return billDate2; }
            set { billDate2 = value; }
        }

        private Int64? supplierID;

        public Int64? SupplierID
        {
            get { return supplierID; }
            set { supplierID = value; }
        }

        private String supplierName;

        public String SupplierName
        {
            get { return supplierName; }
            set { supplierName = value; }
        }

        private String promissoryType;

        public String PromissoryType
        {
            get { return promissoryType; }
            set { promissoryType = value; }
        }


        private String chanelSaleName;

        public String ChanelSaleName
        {
            get { return chanelSaleName; }
            set { chanelSaleName = value; }
        }

        private Int64? sellerId;

        public Int64? SellerId
        {
            get { return sellerId; }
            set { sellerId = value; }
        }

        private String sellerName;

        public String SellerName
        {
            get { return sellerName; }
            set { sellerName = value; }
        }

        private DateTime? saleDate;

        public DateTime? SaleDate
        {
            get { return saleDate; }
            set { saleDate = value; }
        }

        private DateTime? registerDate;

        public DateTime? RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }
        private Boolean transferQuota;

        public Boolean TransferQuota
        {
            get { return transferQuota; }
            set { transferQuota = value; }
        }

        private Boolean gracePeriod;

        public Boolean GracePeriod
        {
            get { return gracePeriod; }
            set { gracePeriod = value; }
        }

        private Double? insuranceRate;


        public Double? InsuranceRate
        {
            get { return insuranceRate; }
            set { insuranceRate = value; }
        }


        private Int64? saleId;

        public Int64? SaleId
        {
            get { return saleId; }
            set { saleId = value; }
        }

        private Int64? deliveryAddress;

        public Int64? DeliveryAddress
        {
            get { return deliveryAddress; }
            set { deliveryAddress = value; }
        }

        private Boolean selectChanelSale;

        public Boolean SelectChanelSale
        {
            get { return selectChanelSale; }
            set { selectChanelSale = value; }
        }

        private Int64? defaultchanelSaleId;

        public Int64? DefaultchanelSaleId
        {
            get { return defaultchanelSaleId; }
            set { defaultchanelSaleId = value; }
        }

        private Boolean legalizeOrder;

        public Boolean LegalizeOrder
        {
            get { return legalizeOrder; }
            set { legalizeOrder = value; }
        }

        private Boolean pointDelivery;

        public Boolean PointDelivery
        {
            get { return pointDelivery; }
            set { pointDelivery = value; }
        }


        private Boolean editPointDel;

        public Boolean EditPointDel
        {
            get { return editPointDel; }
            set { editPointDel = value; }
        }


        private Double? minValue;

        public Double? MinValue
        {
            get { return minValue; }
            set { minValue = value; }
        }

        private Boolean subsequentLegalization;

        public Boolean SubsequentLegalization
        {
            get { return subsequentLegalization; }
            set { subsequentLegalization = value; }
        }

        /** Indica si es gran superficie o no... Y/N */
        private String postSaleRule;

        public String PostSaleRule
        {
            get { return postSaleRule; }
            set { postSaleRule = value; }
        }

        public Boolean isGranSuperficie()
        {
            return "Y".Equals(PostSaleRule);
        }

        private String saleReportName;

        public String SaleReportName
        {
            get { return saleReportName; }
            set { saleReportName = value; }
        }

        private Boolean requiresApprovalAnulation;

        public Boolean RequiresApprovalAnulation
        {
            get { return requiresApprovalAnulation; }
            set { requiresApprovalAnulation = value; }
        }

        private Boolean requiresApprovalDevolution;

        public Boolean RequiresApprovalDevolution
        {
            get { return requiresApprovalDevolution; }
            set { requiresApprovalDevolution = value; }
        }

        private Boolean allowTransferQuota;

        public Boolean AllowTransferQuota
        {
            get { return allowTransferQuota; }
            set { allowTransferQuota = value; }
        }

        private Boolean requiresCosigner;

        public Boolean RequiresCosigner
        {
            get { return requiresCosigner; }
            set { requiresCosigner = value; }
        }

        private Boolean requiCosigGASProd;

        public Boolean RequiCosigGASProd
        {
            get { return requiCosigGASProd; }
            set { requiCosigGASProd = value; }
        }

        private Int64? pointSaleId;

        public Int64? PointSaleId
        {
            get { return pointSaleId; }
            set { pointSaleId = value; }
        }

        private String pointSaleName;

        public String PointSaleName
        {
            get { return pointSaleName; }
            set { pointSaleName = value; }
        }

        private DataTable seller;

        public DataTable Seller
        {
            get { return seller; }
            set { seller = value; }
        }

        private DataTable chanelSales;

        public DataTable ChanelSales
        {
            get { return chanelSales; }
            set { chanelSales = value; }
        }

        private Double? payment;

        public Double? Payment
        {
            get { return payment; }
            set { payment = value; }
        }

        private Int64? subscriberId;

        public Int64? SubscriberId
        {
            get { return subscriberId; }
            set { subscriberId = value; }
        }

        private String description;

        public String Description
        {
            get { return description; }
            set { description = value; }
        }


        private Int64? financierId;

        public Int64? FinancierId
        {
            get { return financierId; }
            set { financierId = value; }
        }

        private String clientGender;

        public String ClientGender
        {
            get { return clientGender; }
            set { clientGender = value; }
        }


        private DateTime? clientBirthdat;

        public DateTime? ClientBirthdat
        {
            get { return clientBirthdat; }
            set { clientBirthdat = value; }
        }

        private Boolean parcialQuota;

        public Boolean ParcialQuota
        {
            get { return parcialQuota; }
            set { parcialQuota = value; }
        }

        private Double? parcialQuotaValue;

        public Double? ParcialQuotaValue
        {
            get { return parcialQuotaValue; }
            set { parcialQuotaValue = value; }
        }

        private DateTime? billingDate;

        public DateTime? BillingDate
        {
            get { return billingDate; }
            set { billingDate = value; }
        }


        private Boolean validateBill;

        public Boolean ValidateBill
        {
            get { return validateBill; }
            set { validateBill = value; }
        }

        private String location;

        public String Location
        {
            get { return location; }
            set { location = value; }
        }


        private String departament;

        public String Departament
        {
            get { return departament; }
            set { departament = value; }
        }        

        private String scoring;

        public String Scoring
        {
            get { return scoring; }
            set { scoring = value; }
        }

       private String email;

       public String Email
       {
          get { return email; }
          set { email = value; }
       }

       private Int64? voucherType; // Tipo comprobante (parámetro) para pagaré digital

       public Int64? VoucherType
       {
           get { return voucherType; }
           set { voucherType = value; }
       }

        public DataFIFAP()
        {
            this.registerDate = DateTime.MinValue;
            this.PromissoryType = "E";
            this.payment = 0;
            this.PointDelivery = true;
            this.validateBill = false;
            this.saleId = 0;

        }
    }
}
