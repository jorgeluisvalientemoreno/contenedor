using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    public class FixedValues
    {
        private static int INCREMENT = 0;
        //Caso 200-1640
        private /*Int64*/String consecutive;

        [Browsable(true)]
        [DisplayName("Consecutivo")]
        public /*Int64*/String Consecutive
        {
            get { return consecutive; }
            set { consecutive = value; }
        }

        private Int64 quotationId;

        [Browsable(true)]
        [DisplayName("Id Cotización")]
        public Int64 QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private Int64 projectId;

        [Browsable(true)]
        [DisplayName("Id Proyecto")]
        public Int64 ProjectId
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64 taskType;

        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        private String description;

        [Browsable(true)]
        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    ExceptionHandler.DisplayMessage(2741, "La descripción del valor no puede estar vacía");
                }
                else
                {
                    description = value;
                }
            }
        }

        private Double amount;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Double Amount
        {
            get { return amount; }
            set
            {
                if (value <= 0)
                {
                    ExceptionHandler.DisplayMessage(2741, "La cantidad no puede ser menor o igual a cero");
                }
                else
                {
                    amount = value;
                    totalCost = amount * cost;
                }
            }
        }

        private Double cost;

        [Browsable(true)]
        [DisplayName("Costo")]
        public Double Cost
        {
            get { return cost; }
            set
            {
                if (value > 0)
                {
                    cost = value;
                    totalCost = amount * cost;
                }
            }
        }

        private Double totalCost;

        [Browsable(true)]
        [DisplayName("Costo Total")]
        public Double TotalCost
        {
            get { return totalCost; }
            set { totalCost = value; }
        }

        private String itemType ="VF";

        public String ItemType
        {
            get { return itemType; }
            set { itemType = value; }
        }

        private String operation = "R";

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public FixedValues()
        {
            INCREMENT++;
            //Caso 200-1640
            this.Consecutive = INCREMENT.ToString();
            this.Amount = 1;
        }

        public FixedValues(DataRow drFixedValues)
        {
            //Caso 200-1640
            this.Consecutive = Convert.ToString(drFixedValues["ID"]);
            this.QuotationId = Convert.ToInt64(drFixedValues["QUOTATION_ID"]);
            this.ProjectId = Convert.ToInt64(drFixedValues["ID_PROYECTO"]);
            this.TaskType = Convert.ToInt64(drFixedValues["TIPO_TRABAJO"]);
            this.Description = Convert.ToString(drFixedValues["DESCRIPCION"]);
            this.Amount = Convert.ToInt16(drFixedValues["CANTIDAD"]);
            this.Cost = Convert.ToDouble(drFixedValues["PRECIO"]);
            this.ItemType = Convert.ToString(drFixedValues["TIPO_ITEM"]);
            this.Operation = Convert.ToString(drFixedValues["OPERACION"]);
        }

    }
}
