using System;
using System.Collections.Generic;
using System.Text;

namespace LDC_APUSSOTECO.Entities
{
    public class ContratoBasicData
    {
        /*private Int64? consecutive;

        public Int64? Consecutive
        {
            get { return consecutive; }
            set { consecutive = value; }
        }

        private String status;

        public String Status
        {
            get { return status; }
            set { status = value; }
        }

       /* private CustomerBasicData customer = new CustomerBasicData();

        public CustomerBasicData Customer
        {
            get { return customer; }
            set { customer = value; }
        }

        private Int64? addressId;

        public Int64? AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        private DateTime? validityDate;

        public DateTime? ValidityDate
        {
            get { return validityDate; }
            set { validityDate = value; }
        }

        private Decimal? quotedValue;

        public Decimal? QuotedValue
        {
            get { return quotedValue; }
            set { quotedValue = value; }
        }

        private Decimal discount;

        public Decimal Discount
        {
            get { return discount; }
            set { discount = value; }
        }

        private Int64? quotationRequestId;

        public Int64? QuotationRequestId
        {
            get { return quotationRequestId; }
            set { quotationRequestId = value; }
        }

        private Int64? saleRequestId;

        public Int64? SaleRequestId
        {
            get { return saleRequestId; }
            set { saleRequestId = value; }
        }

        private String comment;

        public String Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        private DateTime? registerDate;

        public DateTime? RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }

        private DateTime? lastModDate;

        public DateTime? LastModDate
        {
            get { return lastModDate; }
            set { lastModDate = value; }
        }

       /* private GridDetaContrato chargeByConnTaskType = new GridDetaContrato();

        public GridDetaContrato ChargeByConnTaskType
        {
            get { return chargeByConnTaskType; }
            set { chargeByConnTaskType = value; }
        }*/


        private List<GridDetaContrato> itemsList = new List<GridDetaContrato>();

        public List<GridDetaContrato> ItemsList
        {
            get { return itemsList; }
            set { itemsList = value; }
        }


        /*private List<GridItemsLegal> itemsListNormal = new List<GridItemsLegal>();

        public List<GridItemsLegal> ItemsListNormal
        {
            get { return itemsListNormal; }
            set { itemsListNormal = value; }
        }


        private List<GridItemsCoti> itemsListCoti = new List<GridItemsCoti>();

        public List<GridItemsCoti> ItemsListCoti
        {
            get { return itemsListCoti; }
            set { itemsListCoti = value; }
        }


     /*   private QuotationTaskType internalConnTaskType = new QuotationTaskType();

        public QuotationTaskType InternalConnTaskType
        {
            get { return internalConnTaskType; }
            set { internalConnTaskType = value; }
        }

        private QuotationTaskType certificationTaskType = new QuotationTaskType();

        public QuotationTaskType CertificationTaskType
        {
            get { return certificationTaskType; }
            set { certificationTaskType = value; }
        }

        private List<QuotationTaskType> taskTypeList = new List<QuotationTaskType>();

        public List<QuotationTaskType> TaskTypeList
        {
            get { return taskTypeList; }
            set { taskTypeList = value; }
        }*/

        public ContratoBasicData()
        {

        }

       /* public ContratoBasicData(ContratoBasicData quotation)
        {
            this.addressId = quotation.AddressId;
            this.comment = quotation.Comment;
            this.consecutive = quotation.Consecutive;
            this.discount = quotation.Discount;
            this.quotationRequestId = quotation.QuotationRequestId;
            this.quotedValue = quotation.QuotedValue;
            this.saleRequestId = quotation.SaleRequestId;
            this.status = quotation.Status;
            this.lastModDate = quotation.LastModDate;
            this.validityDate = quotation.ValidityDate;
            this.registerDate = quotation.RegisterDate;
        }*/

       /* public ContratoBasicData Clone(ContratoBasicData quotation)
        {
            return new ContratoBasicData(quotation);
        }*/
    }
}
