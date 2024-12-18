using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace Ludycom.CommercialSale.Entities
{
    public class QuotationTaskType
    {
        private Int64? quotationId;

        public Int64? QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private Int64 taskType;

        [Browsable(true)]
        [DisplayName("Id Trabajo")]
        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        private String taskTypeDesc;

        [DisplayName("Tipo de Trabajo")]
        public String TaskTypeDesc
        {
            get { return taskTypeDesc; }
            set { taskTypeDesc = value; }
        }

        private Int64 activity;

        [Browsable(true)]
        [DisplayName("Actividad")]
        public Int64 Activity
        {
            get { return activity; }
            set { activity = value; }
        }

        private Decimal iva;

        public Decimal Iva
        {
            get { return iva; }
            set { iva = value; }
        }

        private Boolean applyDiscount;

        public Boolean ApplyDiscount
        {
            get { return applyDiscount; }
            set { applyDiscount = value; }
        }

        private Decimal aiu;

        [Browsable(true)]
        [DisplayName("AIU")]
        public Decimal Aiu
        {
            get { return aiu; }
            set { aiu = value; }
        }

        private Decimal subtotal;

        [Browsable(true)]
        [DisplayName("Subtotal")]
        public Decimal Subtotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }

        private Decimal discount;

        [Browsable(true)]
        [DisplayName("Descuento")]
        public Decimal Discount
        {
            get { return discount; }
            set { discount = value; }
        }

        private Decimal ivaValue;

        [Browsable(true)]
        [DisplayName("Valor del IVA")]
        public Decimal IvaValue
        {
            get { return ivaValue; }
            set { ivaValue = value; }
        }

        private Decimal totalValue;

        [Browsable(true)]
        [DisplayName("Valor Total")]
        public Decimal TotalValue
        {
            get { return totalValue; }
            set { totalValue = value; }
        }

        private String taskTypeClassif;

        [Browsable(true)]
        [DisplayName("Clasificación")]
        public String TaskTypeClassif
        {
            get { return taskTypeClassif; }
            set { taskTypeClassif = value; }
        }

        private List<QuotationItem> itemsList = new List<QuotationItem>();

        public List<QuotationItem> ItemsList
        {
            get { return itemsList; }
            set { itemsList = value; }
        }

        private String option;

        public String Option
        {
            get { return option; }
            set { option = value; }
        }

        public const String OPTION_KEY = "OPTION";

        public QuotationTaskType()
        {
            this.Option = Constants.REGISTER_OPTION;
        }

        public QuotationTaskType(QuotationTaskType taskType)
        {
            this.activity = taskType.Activity;
            this.quotationId = taskType.QuotationId;
            this.taskType = taskType.TaskType;
            this.taskTypeClassif = taskType.TaskTypeClassif;
            this.applyDiscount = taskType.ApplyDiscount;
            this.option = taskType.Option;
        }

        public QuotationTaskType(DataRow drQuotationTaskType)
        {
            this.QuotationId = Convert.ToInt64(drQuotationTaskType["ID_COTIZACION"]);
            this.TaskType = Convert.ToInt64(drQuotationTaskType["TIPO_TRABAJO"]);
            this.TaskTypeClassif = Convert.ToString(drQuotationTaskType["ABREVIATURA"]);
            this.Activity = Convert.ToInt64(drQuotationTaskType["ACTIVIDAD"]);
            this.ApplyDiscount = Convert.ToString(drQuotationTaskType["APLICA_DESCUENTO"]) == "S" ? true : false;
            this.Option = Constants.NONE_OPTION;
            this.ItemsList = new List<QuotationItem>();
        }

        public QuotationTaskType(SummaryQuotedItem summaryQuotedItem)
        {
            this.TaskType = summaryQuotedItem.TaskType;
            this.Activity = summaryQuotedItem.ActivityId;
        }

        public QuotationTaskType Clone()
        {
            return new QuotationTaskType(this);
        }
    }
}
