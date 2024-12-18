using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    public class QuotationItem
    {
        private Int64? projectId;

        public Int64? ProjectId
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64? quotationId;

        [Browsable(true)]
        public Int64? QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private Int64? taskType;

        [Browsable(true)]
        [DisplayName("Tipo de Trab.")]
        public Int64? TaskType
        {
            get { return taskType; }
            set { taskType = value; }
        }

        //Caso 200-1640 Se cambio Int64 por String
        private String itemId;

        [Browsable(true)]
        [DisplayName("Id del Item")]
        public String ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String itemDescription;

        [Browsable(true)]
        [DisplayName("Descripción de Item")]
        public String ItemDescription
        {
            get { return itemDescription; }
            set { itemDescription = value; }
        }


        private String comment;

         [DisplayName("Descripción Valor Fijo")]
        public String Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        private Double amount = 1;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Double Amount
        {
            get { return amount; }
            set
            {
                if (value < 1 & ItemType!="IM")
                {
                    ExceptionHandler.DisplayMessage(2741, "La cantidad no puede ser menor a uno");
                }
                else
                {
                    amount = value;
                    totalCost = amount * cost;
                    totalPrice = amount * price;
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
                cost = Math.Round(value, 2);
                totalCost = amount * cost;
            }
        }

        private Double price;

        [Browsable(true)]
        [DisplayName("Precio")]
        public Double Price
        {
            get { return price; }
            set 
            {
              price = Math.Round(value, 2);
              totalPrice = amount * price;
            }
        }

        private Double totalPrice;

        [DisplayName("Precio total")]
        [Browsable(true)]
        public Double TotalPrice
        {
            get { return totalPrice; }
            set { totalPrice = value; }
        }

        private Double totalCost;

        [DisplayName("Costo total")]
        [Browsable(true)]
        public Double TotalCost
        {
            get { return totalCost; }
            set { totalCost = value; }
        }

        private Int32? floorId;

        public Int32? FloorId
        {
            get { return floorId; }
            set { floorId = value; }
        }

        private Int32? propUnitTypeId;

        public Int32? PropUnitTypeId
        {
            get { return propUnitTypeId; }
            set { propUnitTypeId = value; }
        }

        private String itemType;

        [DisplayName("Tipo de Item")]
        public String ItemType
        {
            get { return itemType; }
            set { itemType = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        /*private String contratistaConstrucciones;

        [Browsable(false)]
        public String ContratistaConstrucciones
        {
            get { return contratistaConstrucciones; }
            set { contratistaConstrucciones = value; }
        }
        private String unidadTrabajo;

        [Browsable(false)]
        public String UnidadTrabajo
        {
            get { return unidadTrabajo; }
            set { unidadTrabajo = value; }
        }*/

        public QuotationItem()
        {

        }

        //Caso 200-1640
        public QuotationItem(/*Int64*/String itemId, String itemDescription, Double cost, Double price, Int64? taskType)
        {
            this.itemId = itemId;
            this.itemDescription = itemDescription;
            this.cost = cost;
            this.price = price;
            this.taskType = taskType;
        }

        public QuotationItem(DataRow drQuotationItem)
        {
            this.QuotationId = Convert.ToInt64(drQuotationItem["QUOTATION_ID"]);
            this.ProjectId = Convert.ToInt64(drQuotationItem["ID_PROYECTO"]);
            /*Caso 200-1640 Int64*/
            this.ItemId = Convert.ToString(drQuotationItem["ID_ITEM"]);
            this.ItemDescription = Convert.ToString(drQuotationItem["ITEM_DESC"]);
            this.TaskType = Convert.ToInt64(drQuotationItem["TIPO_TRAB"]);
            this.Amount = Convert.ToDouble(drQuotationItem["CANTIDAD"]);
            this.Cost = Convert.ToDouble(drQuotationItem["COSTO"]);
            this.Price = Convert.ToDouble(drQuotationItem["PRECIO"]);
            this.Operation = Convert.ToString(drQuotationItem["OPERACION"]);
            this.ItemType = Convert.ToString(drQuotationItem["TIPO_ITEM"]);
        }

        public QuotationItem(QuotationItem quotationItem)
        {
            this.ProjectId = quotationItem.ProjectId;
            this.QuotationId = quotationItem.QuotationId;
            this.ItemId = quotationItem.ItemId;

            if (quotationItem.ItemType=="VF")
            {
                this.Comment = quotationItem.Comment;
            }
            
            this.ItemDescription = quotationItem.itemDescription;
            this.ItemType = quotationItem.ItemType;
            this.Amount = quotationItem.Amount;
            this.Cost = quotationItem.Cost;
            this.Price = quotationItem.Price;
            this.Operation = quotationItem.Operation;
            this.TaskType = quotationItem.TaskType;
            //this.contratistaConstrucciones = "";
            //this.unidadTrabajo = "";
        }

        //Caso 200-1640 se modifico FixedValues
        public QuotationItem(FixedValues fixedValue)
        {
            this.ProjectId = fixedValue.ProjectId;
            this.QuotationId = fixedValue.QuotationId;
            this.Cost = fixedValue.Cost;
            this.Amount = fixedValue.Amount;
            this.ItemType = fixedValue.ItemType;
            this.Comment = fixedValue.Description;
            this.TotalCost = fixedValue.TotalCost;
            this.ItemId = fixedValue.Consecutive;
            this.Operation = fixedValue.Operation;
            this.TaskType = fixedValue.TaskType;
            //this.contratistaConstrucciones = "";
            //this.unidadTrabajo = "";
        }

        //Caso 200-1640 se modifico ItemsPerLength
        public QuotationItem(ItemsPerLength itemPerLength)
        {
            this.ProjectId = itemPerLength.Project;
            this.QuotationId = itemPerLength.QuotationId;
            this.ItemId = itemPerLength.ItemId;
            this.ItemDescription = itemPerLength.ItemDescription;
            this.Price = itemPerLength.Price;
            this.Cost = itemPerLength.Cost;
            this.ItemType = itemPerLength.ItemType;
            this.Amount = 0;
            this.Operation = itemPerLength.Operation;
            //this.contratistaConstrucciones = "";
            //this.unidadTrabajo = "";
        }

        public QuotationItem Clone()
        {
            return new QuotationItem(this);
        }

    }
}
