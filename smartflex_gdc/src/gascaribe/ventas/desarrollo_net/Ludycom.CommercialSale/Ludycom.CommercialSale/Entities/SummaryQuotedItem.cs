using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace Ludycom.CommercialSale.Entities
{
    public class SummaryQuotedItem
    {
        private Int64 taskType;

        [Browsable(true)]
        [DisplayName("Tipo de Trabajo")]
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

        private Int64 activityId;

        [Browsable(true)]
        [DisplayName("Actividad")]
        public Int64 ActivityId
        {
            get { return activityId; }
            set { activityId = value; }
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

        private Decimal totalValue;

        [Browsable(true)]
        [DisplayName("Valor Total")]
        public Decimal TotalValue
        {
            get { return totalValue; }
            set { totalValue = value; }
        }

        private String taskTypeClass;

        public String TaskTypeClass
        {
            get { return taskTypeClass; }
            set { taskTypeClass = value; }
        }



        public SummaryQuotedItem()
        {

        }
    }
}
