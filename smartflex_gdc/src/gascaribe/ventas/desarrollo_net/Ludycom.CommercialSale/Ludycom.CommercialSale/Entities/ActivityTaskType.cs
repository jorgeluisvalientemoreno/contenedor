using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.CommercialSale.Entities
{
    public class ActivityTaskType
    {
        private Int64 activity;

        [DisplayName("Id Actividad")]
        public Int64 Activity
        {
            get { return activity; }
            set { activity = value; }
        }

        private String activityDescription;

        [DisplayName("Nombre Actividad")]
        public String ActivityDescription
        {
            get { return activityDescription; }
            set { activityDescription = value; }
        }

        private Int64 taskType;

        [DisplayName("Id Tipo Trabajo")]
        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        private String taskTypeDescription;

        [DisplayName("Descripcion Tipo Trabajo")]
        public String TaskTypeDescription
        {
            get { return taskTypeDescription; }
            set { taskTypeDescription = value; }
        }

        private short? discountConcept;

        public short? DiscountConcept
        {
            get { return discountConcept; }
            set { discountConcept = value; }
        }

        public const String ACTIVITY_KEY = "ACTIVITY";

        public const String ACTIVITY_DESCRIPTION_KEY = "ACTIVITYDESCRIPTION";

        public const String DISCOUNT_CONCEPT_KEY = "DISCOUNTCONCEPT";

        public ActivityTaskType()
        {
        }

        public ActivityTaskType(DataRow drQuotationTaskType)
        {
            this.TaskType = Convert.ToInt64(drQuotationTaskType["ID_TIPO_TRABAJO"]);
            this.TaskTypeDescription = Convert.ToString(drQuotationTaskType["TIPO_TRABAJO"]);
            this.Activity = Convert.ToInt64(drQuotationTaskType["ID_ACTIVIDAD"]);
            this.ActivityDescription = Convert.ToString(drQuotationTaskType["ACTIVIDAD"]);
            this.DiscountConcept = String.IsNullOrEmpty(Convert.ToString(drQuotationTaskType["DISCOUNT_CONCEPT"])) ? (new Int16?()) : Convert.ToInt16(drQuotationTaskType["DISCOUNT_CONCEPT"]);
        }
    }
}
