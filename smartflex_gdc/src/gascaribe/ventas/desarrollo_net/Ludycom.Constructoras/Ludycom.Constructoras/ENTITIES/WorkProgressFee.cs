using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class WorkProgressFee
    {
        private Int64 taskType;

        public Int64 TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        private String taskTypeDesc;

        [Browsable(true)]
        [DisplayName("Tipo de Trabajo")]
        public String TaskTypeDesc
        {
            get { return taskTypeDesc; }
            set { taskTypeDesc = value; }
        }

        private Double price;

        [Browsable(true)]
        [DisplayName("Precio Unitario (con Iva)")]
        public Double Price
        {
            get { return price; }
            set { price = value; }
        }

        private Int32 amount;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Int32 Amount
        {
            get { return amount; }
            set
            {
                if (value<0)
                {
                    ExceptionHandler.DisplayMessage(2741, "La cantidad no puede ser menor a cero");
                    return;
                }

                amount = value;
                totalPrice = amount * price;
            }
        }

        private Double totalPrice;

        [Browsable(true)]
        [DisplayName("Precio Total")]
        public Double TotalPrice
        {
            get { return totalPrice; }
            set { totalPrice = value; }
        }

        public WorkProgressFee()
        {

        }

        public WorkProgressFee(DataRow drWorkProgressFee)
        {
            this.taskType = Convert.ToInt64(drWorkProgressFee["ID_TIPO_TRABAJO"]);
            this.TaskTypeDesc = Convert.ToString(drWorkProgressFee["TIPO_TRABAJO_DESC"]);
            this.Price = Convert.ToDouble(drWorkProgressFee["PRECIO_TOTAL"]);
            this.Amount = 0;
        }
    }
}
