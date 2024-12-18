using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    public class ConsolidatedQuotation
    {
        private Int64 project;

        public Int64 Project
        {
            get { return project; }
            set { project = value; }
        }

        private Int64? quotation;

        public Int64? Quotation
        {
            get { return quotation; }
            set { quotation = value; }
        }

        private Int64 taskType;

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

        //Caso 200-1640
        private String itemdId;

        [DisplayName("Actividad")]
        public String ItemdId
        {
            get { return itemdId; }
            set { itemdId = value; }
        }

        private Double cost;

        [DisplayName("Costo")]
        public Double Cost
        {
            get { return cost; }
            set 
            {
                cost = value;
                markUp = Math.Round((price - cost),2);//

                if (price > 0)
                {
                    markUpPercentage = Math.Round((markUp / price) * 100,2);//
                }
                if (markUp == 0)
                {
                    markUpPercentage = 0;
                }
            }
        }

        private Double price;

        [DisplayName("Precio")]
        public Double Price
        {
            get { return price; }
            set 
            {
                price = Math.Round(value, 2);
                markUp = price - cost;
                totalPrice = price + ivaValue;

                if (price>0)
                {
                    markUpPercentage = Math.Round((markUp / price)*100,2); //
                    ivaValue = Math.Round((iva / 100 * price), 2);
                    totalPrice = Math.Round(price + ivaValue, 2); //
                }
                else
                {
                    ivaValue = 0;
                    totalPrice = 0;
                }
                if (markUp==0)
                {
                    markUpPercentage = 0;
                }
            }
        }

        private Double markUp = 0;

        [DisplayName("Margen")]
        public Double MarkUp
        {
            get { return markUp; }
            set { markUp = value; }
        }

        private Double markUpPercentage = 0;

        [DisplayName("Margen (%)")]
        public Double MarkUpPercentage
        {
            get { return markUpPercentage; }
            set { markUpPercentage = value; }
        }

        private Double iva = 0;

        [DisplayName("% Iva")]
        public Double Iva
        {
            get { return iva; }
            set {
                iva = value;
                ivaValue = Math.Round((iva / 100 * price), 2);
                totalPrice = Math.Round(price + ivaValue,2); //
            }
        }

        private Double ivaValue = 0;

        [DisplayName("Valor del Iva")]
        public Double IvaValue
        {
            get { return ivaValue; }
            set { ivaValue = value; }
        }

        private Double totalPrice = 0;

        [DisplayName("Precio Total")]
        public Double TotalPrice
        {
            get { return totalPrice; }
            set { totalPrice = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        private String taskTypeAcron;

        public String TaskTypeAcron
        {
            get { return taskTypeAcron; }
            set { taskTypeAcron = value; }
        }

        public ConsolidatedQuotation()
        {

        }

        public ConsolidatedQuotation(DataRow drConsolidatedQuotation)
        {
            this.Project = Convert.ToInt64(drConsolidatedQuotation["ID_PROYECTO"]);
            this.Quotation = Convert.ToInt64(drConsolidatedQuotation["ID_COTIZACION_DETALLADA"]);
            this.TaskType = Convert.ToInt64(drConsolidatedQuotation["ID_TIPO_TRABAJO"]);
            this.TaskTypeDesc = Convert.ToString(drConsolidatedQuotation["TIPO_TRAB_DESC"]);
            //Caso 200-1640
            this.ItemdId = Convert.ToString(drConsolidatedQuotation["ACTIVIDAD"]);
            this.Cost = Convert.ToDouble(drConsolidatedQuotation["COSTO"]);
            this.Price = Convert.ToDouble(drConsolidatedQuotation["PRECIO"]);
            this.MarkUp = Convert.ToDouble(drConsolidatedQuotation["MARGEN"]);
            this.Iva = Convert.ToDouble(drConsolidatedQuotation["IVA"]);
            this.TotalPrice = Convert.ToDouble(drConsolidatedQuotation["PRECIO_TOTAL"]);
            this.TaskTypeAcron = Convert.ToString(drConsolidatedQuotation["ACRONIMO"]);
            this.Operation = "N";   
        }
    }
}
