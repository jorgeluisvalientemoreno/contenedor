using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using Ludycom.CommercialSale.UI;

namespace Ludycom.CommercialSale.Entities
{
    public class QuotationItem
    {

        private Int64 consecutive;

        public Int64 Consecutive
        {
            get { return consecutive; }
            set { consecutive = value; }
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

        private Int64 activityId;

        public Int64 ActivityId
        {
            get { return activityId; }
            set { activityId = value; }
        }

        private Int64 listId;

        [Browsable(true)]
        [DisplayName("Id Lista")]
        public Int64 ListId
        {
            get { return listId; }
            set { listId = value; }
        }

        private Int64 itemId;

        [Browsable(true)]
        [DisplayName("Id de Item")]
        public Int64 ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private String description;

        [Browsable(true)]
        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private Decimal saleCost;

        [Browsable(true)]
        [DisplayName("Costo de Venta")]
        public Decimal SaleCost
        {
            get { return saleCost; }
            set 
            { 
              saleCost = value;
              aiu = Math.Round((saleCost * Convert.ToDecimal(LDC_FCVC.AIUpercentage)) / 100 * Convert.ToDecimal(amount), 0);
              totalPrice = Math.Round((saleCost * Convert.ToDecimal(amount)) + aiu, 0);
              discount = Math.Round(totalPrice * discountPercentage / 100,0);
              if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
              {
                  ivaValue = Math.Round((totalPrice - discount)*iva / 100);
              }
              else
              {
                  ivaValue = Math.Round((aiu * iva * (LDC_FCVC.valueToMultiplyIVA / 100)) / 100, 0);
                  ivaValue = Math.Round(ivaValue - (ivaValue * discountPercentage / 100),0);
              }
                
              totalValue = Math.Round(totalPrice + ivaValue - discount, 0);
            }
        }

        private Decimal aiu;

        [Browsable(true)]
        [DisplayName("AIU")]
        public Decimal Aiu
        {
            get { return aiu; }
            set { aiu = value; }
        }

        private Double amount;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Double Amount
        {
            get { return amount; }
            set { 
                
                amount = value;
                aiu = Math.Round((saleCost * Convert.ToDecimal(LDC_FCVC.AIUpercentage) )/ 100 * Convert.ToDecimal(amount),0);
                totalPrice = Math.Round((saleCost * Convert.ToDecimal(amount)) + aiu, 0);
                discount = Math.Round(totalPrice * discountPercentage / 100,0);
                if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                    ivaValue = Math.Round((totalPrice - discount) * iva/ 100,0);
                }
                else
                {
                    ivaValue = Math.Round((aiu * iva * (LDC_FCVC.valueToMultiplyIVA/100)) / 100, 0);
                    ivaValue = Math.Round(ivaValue - (ivaValue * discountPercentage / 100),0);
                }
                totalValue = Math.Round(totalPrice + ivaValue - discount,0);
            }
        }

        private Decimal discountPercentage;

        [Browsable(false)]
        public Decimal DiscountPercentage
        {
            get { return discountPercentage; }
            set 
            {
                discountPercentage = value;
                discount = Math.Round(totalPrice * discountPercentage / 100,0);
                if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                    ivaValue = Math.Round((totalPrice - discount) * iva / 100);
                }
                else
                {
                    ivaValue = Math.Round((aiu * iva * (LDC_FCVC.valueToMultiplyIVA / 100)) / 100, 0);
                    ivaValue = Math.Round(ivaValue - (ivaValue * discountPercentage / 100),0);
                }
                totalValue = Math.Round(totalPrice + ivaValue - discount, 0);
            }
        }

        private Decimal discount;

        [Browsable(true)]
        [DisplayName("Descuento")]
        public Decimal Discount
        {
            get { return discount; }
            set 
            { 
                discount = value;
                //totalValue = Math.Round(totalPrice + ivaValue - discount, 2);
            }
        }

        private Decimal totalPrice;

        [Browsable(true)]
        [DisplayName("Precio Total")]
        public Decimal TotalPrice
        {
            get { return totalPrice; }
            set { totalPrice = value; }
        }

        private Decimal iva;

        public Decimal Iva
        {
            get { return iva; }
            set 
            { 
                iva = value;
                if (taskTypeClassif == Constants.CERTIFICATION_CLASS)
                {
                    ivaValue = Math.Round((totalPrice - discount) * iva / 100);
                }
                else
                {
                    ivaValue = Math.Round((aiu * iva * (LDC_FCVC.valueToMultiplyIVA / 100)) / 100, 0);
                    ivaValue = Math.Round(ivaValue - (ivaValue * discountPercentage / 100));
                }

                totalValue = Math.Round(totalPrice + ivaValue - discount, 0);
            }
        }

        private Decimal ivaValue;

        [Browsable(true)]
        [DisplayName("Valor del IVA")]
        public Decimal IvaValue
        {
            get { return ivaValue; }
            set 
            { 
                ivaValue = value;
                totalValue = Math.Round(totalPrice + ivaValue - discount, 0);
            }
        }

        private Decimal totalValue;

        [Browsable(true)]
        [DisplayName("Valor Total")]
        public Decimal TotalValue
        {
            get { return totalValue; }
            set { totalValue = value; }
        }

        private String option;

        [DisplayName("Opción")]
        public String Option
        {
            get { return option; }
            set { option = value; }
        }

        private String taskTypeClassif;

        public String TaskTypeClassif
        {
            get { return taskTypeClassif; }
            set { taskTypeClassif = value; }
        }

        private String contratistaConstrucciones;

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
        }

        public QuotationItem()
        {
            this.Amount = 1;
            this.Option = Constants.REGISTER_OPTION;
        }

        public const String ITEM_ID_KEY = "ITEMID";

        public const String DESCRIPTION_KEY = "DESCRIPTION";

        public const String AMOUNT_KEY = "AMOUNT";

        public const String OPTION_KEY = "OPTION";

        public QuotationItem(QuotationItem item)
        {
            this.consecutive = item.Consecutive;
            this.quotationId = item.QuotationId;
            this.taskType = item.TaskType;
            this.activityId = item.ActivityId;
            this.listId = item.ListId;
            this.itemId = item.ItemId;
            this.description = item.Description;
            this.saleCost = item.SaleCost;
            this.aiu = item.Aiu;
            this.amount = item.Amount;
            this.discount = item.Discount;
            this.totalPrice = item.TotalPrice;
            this.ivaValue = item.IvaValue;
            this.iva = item.Iva;
            this.discountPercentage = item.DiscountPercentage;
            this.totalValue = item.TotalValue;
            this.option = item.Option;
            this.contratistaConstrucciones = "";
            this.unidadTrabajo = "";
        }

        public QuotationItem(DataRow drQuotationItem)
        {
            this.consecutive = Convert.ToInt64(drQuotationItem["CONSECUTIVO"]);
            this.quotationId = Convert.ToInt64(drQuotationItem["ID_COTIZACION"]);
            this.taskType = Convert.ToInt64(drQuotationItem["TIPO_TRABAJO"]);
            this.activityId = Convert.ToInt64(drQuotationItem["ACTIVIDAD"]);
            this.listId = Convert.ToInt64(drQuotationItem["ID_LISTA"]);
            this.itemId = Convert.ToInt64(drQuotationItem["ID_ITEM"]);
            this.description = Convert.ToString(drQuotationItem["DESCRIPCION"]);
            this.amount = Convert.ToDouble(drQuotationItem["CANTIDAD"]);
            this.saleCost = Convert.ToDecimal(drQuotationItem["COSTO_VENTA"]);
            this.aiu = Convert.ToDecimal(drQuotationItem["AIU"]);
            this.discount = Convert.ToDecimal(drQuotationItem["DESCUENTO"]);
            this.discountPercentage = Convert.ToDecimal(drQuotationItem["PORC_DESCUENTO"]);
            this.totalPrice = Convert.ToDecimal(drQuotationItem["PRECIO_TOTAL"]);
            this.taskTypeClassif = Convert.ToString(drQuotationItem["ABREVIATURA"]);
            this.iva = Convert.ToDecimal(drQuotationItem["IVA"]);
            this.IvaValue = Convert.ToDecimal(drQuotationItem["VALOR_IVA"]);
            this.option = Constants.NONE_OPTION;
            this.contratistaConstrucciones = "";
            this.unidadTrabajo = "";
        }

        public QuotationItem Clone()
        {
            return new QuotationItem(this);
        }
    }
}
