using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.CANCELLATION.Entities
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

        private Double unitValue;

        private Double totalValue;

        private Int32 amount;

        private Int64 activityId;

        private Int32 cancelationAmount;

        private Double iva;

        [DisplayName("IVA")]
        public Double Iva
        {
          get { return iva; }
          set { iva = value; }
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

        [Browsable(true)]
        [DisplayName("Actvidad Entrega")]
        public Int64 ActivityId
        {
            get { return activityId; }
        }

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


        private String accion;

        [Browsable(true)]
        public String Accion
        {
            get { return accion; }
            set { accion = value; }
        }

        private Int64 proveedor;

        [Browsable(true)]
        public Int64 Proveedor
        {
            get { return proveedor; }
            set { proveedor = value; }
        }

        private double returnValue;

        [DisplayName("Valor a devolver")]
        public double ReturnValue
        {
            get { return returnValue; }
        }

        private string group;

        [Browsable(true)]
        [DisplayName("Proveedor")]
        public String Group
        {
            get { return group; }
            set { group = value; }
        }


        private String nombreProveedor;

        [Browsable(false)]
        [DisplayName("Nombre")]
        public String NombreProveedor
        {
            get { return nombreProveedor; }
            set { nombreProveedor = value; }
        }


        public ArticleSaleCancelation(
            Int64 Article,
            String ArticleDescription,
            Int64 proveedor,
            String nombProveedor, 
            String Address, 
            Int32 Amount,
            Double UnitValue, 
            Double Iva,      
            Double TotalValue, 
            Int64 ActivityId,
            String accion            
            ) 
        
        {
            this.article = Article;
             this.articleDescription = ArticleDescription;
             this.address = Address;
             this.iva = Iva;                        
             this.unitValue = UnitValue;
             this.totalValue = TotalValue;
             this.amount = Amount;
             this.cancelationAmount = Amount;
             this.activityId = ActivityId;
             this.nombreProveedor = nombProveedor;

             this.accion = accion; 
            this.returnValue = this.amount * (this.unitValue + this.iva);    //KCienfuegos.NC3858 27-11-2014      
            this.proveedor = proveedor;
            this.group = nombProveedor + "(" + accion + ")";
        }




    }
}
