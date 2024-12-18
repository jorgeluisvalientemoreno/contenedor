using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class itemTaskType
    {
        private Int64 taskType;

        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        //Caso 200-1640
        private String itemId;

        public String ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String taskTypeDesc;

        public String TaskTypeDesc
        {
            get { return taskTypeDesc; }
            set { taskTypeDesc = value; }
        }

        public itemTaskType()
        {

        }

        public itemTaskType(DataRow drItemTaskType)
        {
            this.TaskType = Convert.ToInt64(drItemTaskType["TIPO_TRAB"]);
            //Caso 200-1640
            this.ItemId = Convert.ToString(drItemTaskType["ITEM_ID"]);
            this.TaskTypeDesc = Convert.ToString(drItemTaskType["TIPO_TRAB_DESC"]);
        }
    }
}
