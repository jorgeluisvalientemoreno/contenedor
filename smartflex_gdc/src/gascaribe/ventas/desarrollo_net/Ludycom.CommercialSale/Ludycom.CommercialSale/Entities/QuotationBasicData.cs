using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.CommercialSale.Entities
{
    public class QuotationBasicData
    {
        private Int64? consecutive;

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

        private CustomerBasicData customer = new CustomerBasicData();

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

        private Int64? operatingSector;

        public Int64? OperatingSector
        {
            get { return operatingSector; }
            set { operatingSector = value; }
        }

        private Int64? nuFormulario;

        public Int64? NuFormulario
        {
            get { return nuFormulario; }
            set { nuFormulario = value; }
        }

        private Int64? operatingUnit;

        public Int64? OperatingUnit
        {
            get { return operatingUnit; }
            set { operatingUnit = value; }
        }

        private Int64? solicitudRed;

        public Int64? SolicitudRed
        {
            get { return solicitudRed; }
            set { solicitudRed = value; }
        }

        private QuotationTaskType chargeByConnTaskType = new QuotationTaskType();

        public QuotationTaskType ChargeByConnTaskType
        {
            get { return chargeByConnTaskType; }
            set { chargeByConnTaskType = value; }
        }

        private QuotationTaskType internalConnTaskType = new QuotationTaskType();

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
        }

        public QuotationBasicData()
        {

        }

        public QuotationBasicData(QuotationBasicData quotation)
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
            this.operatingSector = quotation.OperatingSector;
            this.nuFormulario = quotation.NuFormulario;
            //this.operatingUnit = quotation.OperatingUnit;
            this.solicitudRed = quotation.SolicitudRed;
            this.validityDate = quotation.ValidityDate;
            this.registerDate = quotation.RegisterDate;
        }

        public QuotationBasicData Clone(QuotationBasicData quotation)
        {
            return new QuotationBasicData(quotation);
        }
    }
}
