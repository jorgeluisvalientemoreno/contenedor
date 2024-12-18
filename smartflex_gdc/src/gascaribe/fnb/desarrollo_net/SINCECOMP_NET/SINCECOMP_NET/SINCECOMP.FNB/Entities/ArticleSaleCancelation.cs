using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class ArticleSaleCancelation
    {
        private Boolean selection;

        private Int64 article;

        [DisplayName("Artículo")]
        public Int64 Article
        {
            get { return article; }
            set { article = value; }
        }

        private String articleDescription;

        private String address;

        //private String status;

        private Double unitValue;

        private Double totalValue;

        private Int32 amount;

        //private Int64 activityId;

        private Int32 cancelationAmount;

        private String operationUnit;

        private Int32 iva;

        [DisplayName("IVA")]
        public Int32 Iva
        {
          get { return iva; }
          set { iva = value; }
        }


        [DisplayName("Unidad Operativa")]
        public String OperationUnit
        {
            get { return operationUnit; }
            set { operationUnit = value; }
        }


        [DisplayName(" ")]
        public Boolean Selection
        {
            get { return selection; }
            set { selection = value; }
        }

        [Browsable(true)]
        [DisplayName("Descripción del Artículo")]
        public String ArticleDescription
        {
            get { return articleDescription; }
        }

        [Browsable(true)]
        [DisplayName("Dirección de Entrega")]
        public String Address
        {
            get { return address; }    
        }

        private Int64 addressId;

        [Browsable(false)]
        public Int64 AddressId
        {
            get { return addressId; }
            set { addressId = value; }
        }

        //[Browsable(true)]
        //[DisplayName("Entregado")]
        //public String Status
        //{
        //    get { return status; }
        //    set { status = value; }
        //} 
  
        [Browsable(true)]
        [DisplayName("Valor Unitario")]
        public Double UnitValue
        {
            get { return unitValue; }      
        }

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Int32 Amount
        {
            get { return amount; }
        }

        [Browsable(true)]
        [DisplayName("Valor Total")]
        public Double TotalValue
        {
            get { return totalValue; }    
        }

        /*[Browsable(false)]
        public Int64 ActivityId
        {
            get { return activityId; }
        }*/

        [Browsable(true)]
        [DisplayName("Cantidad a Anular/Devolver")]
        public Int32 CancelationAmount
        {
            get { return cancelationAmount; }
            set
            {
                if (value <= 0)
                {
                    ExceptionHandler.DisplayMessage(2741, "La Cantidad a Anular/Devolver no puede ser inferior a uno");
                    //cancelationAmount = 1;
                }
                else
                {
                    if (value > Amount)
                    {
                        ExceptionHandler.DisplayMessage(2741, "La Cantidad a Anular/Devolver no puede ser mayor a la Cantidad registrada");
                    }
                    else
                    {
                        cancelationAmount = value;
                        this.returnValue = value * this.unitValue;
                    }
                }
            }
        }

        private String causal;

        [Browsable(false)]
        [DisplayName("Causal")]
        public String Causal
        {
            get { return causal; }
            set { causal = value; }
        }

        private Int64 orderId;

        [DisplayName("Orden de Entrega")]
        public Int64 OrderId
        {
            get { return orderId; }
            set { orderId = value; }
        }

        private Int64 orderIdR;

        public Int64 OrderIdR
        {
            get { return orderIdR; }
            set { orderIdR = value; }
        }

        private Double? difeValue;

        [Browsable(true)]
        public Double? DifeValue
        {
            get { return difeValue; }
            set { difeValue = value; }
        }

        private double returnValue;

        [DisplayName("Valor a devolver")]
        public double ReturnValue
        {
            get { return returnValue; }
        }







        public ArticleSaleCancelation(
            Int64 Article,
            String ArticleDescription,
            String OperationUnit,
            String Address, 
            Int32 Amount,
            Double UnitValue, 
            Int32 Iva,
            
            //String Status, 
            
            Double TotalValue, //,Int64 ActivityId
            Int64 OrderId,
            Double?  difeValue,
            Int64 AddressId
            ) 
        
        {
            this.article = Article;
             this.articleDescription = ArticleDescription;
             this.address = Address;
             this.iva = Iva;
             this.operationUnit = OperationUnit;
             //this.status = Status;
             this.unitValue = UnitValue;
             this.totalValue = TotalValue;
             this.amount = Amount;
             this.cancelationAmount = Amount;
             //this.activityId = ActivityId;
             this.orderId = OrderId;
             this.orderIdR = OrderId;
             this.difeValue = difeValue; 
            this.returnValue = this.amount * this.unitValue;
            this.addressId = AddressId;
        
        }




    }
}
