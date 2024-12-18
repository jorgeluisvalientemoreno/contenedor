using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    public class QuotationTaskType
    {
        private Int64 projectId;

        public Int64 Project
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64? quotationId;

        public Int64? QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private Int64 taskType;

        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        private String taskTypeClassif;

        public String TaskTypeClassif
        {
            get { return taskTypeClassif; }
            set { taskTypeClassif = value; }
        }

        //Caso 200-1640
        private String itemId;

        public String ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public QuotationTaskType(DataRow drQuotationTaskType)
        {
            this.Project = Convert.ToInt64(drQuotationTaskType["ID_PROYECTO"]);
            this.QuotationId = Convert.ToInt64(drQuotationTaskType["QUOTATION_ID"]);
            this.TaskType = Convert.ToInt64(drQuotationTaskType["TIPO_TRABAJO"]);
            this.TaskTypeClassif = Convert.ToString(drQuotationTaskType["TRABAJO_CLASIFICACION"]);
            //Caso 200-1640
            this.ItemId = Convert.ToString(drQuotationTaskType["ITEM_ID"]);
            this.Operation = Convert.ToString(drQuotationTaskType["OPERACION"]);
        }

        public QuotationTaskType(ConsolidatedQuotation consolidatedQuotation)
        {
            this.Project = consolidatedQuotation.Project;
            this.QuotationId = consolidatedQuotation.Quotation;
            this.TaskType = consolidatedQuotation.TaskType;
            this.TaskTypeClassif = consolidatedQuotation.TaskTypeAcron;
            this.ItemId = consolidatedQuotation.ItemdId;
            this.Operation = consolidatedQuotation.Operation;
        }
    }
}
