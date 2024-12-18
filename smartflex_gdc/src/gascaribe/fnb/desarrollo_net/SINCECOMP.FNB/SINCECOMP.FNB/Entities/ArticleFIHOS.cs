using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class ArticleFIHOS
    {
        
        private DateTime firstDatePay;

        [DisplayName("Fecha de Cobro Primera Cuota")]
        public DateTime FirstDatePay
        {
            get { return firstDatePay; }
            set { firstDatePay = value; }
        }

        private Decimal vAAMC;

        [DisplayName("Valor Aproximado Abono Mensual Capital")]
        public Decimal VAAMC
        {
            get { return vAAMC; }
            set { vAAMC = value; }
        }

        private Decimal vAIM;

        [DisplayName("Valor Aproximado Interes Mensual")]
        public Decimal VAIM
        {
            get { return vAIM; }
            set { vAIM = value; }
        }

        private Decimal vAMS;

        [DisplayName("Valor Aproximado Mensual Seguro")]
        public Decimal VAMS
        {
            get { return vAMS; }
            set { vAMS = value; }
        }

        private Decimal vACM;

        [DisplayName("Valor Aproximado Cuota Mensual")]
        public Decimal VACM
        {
            get { return vACM; }
            set { vACM = value; }
        }

        private Decimal vATC;

        [DisplayName("Valor Aproximado Total A Capital")]
        public Decimal VATC
        {
            get { return vATC; }
            set { vATC = value; }
        }

        private Decimal vATI;

        [DisplayName("Valor Aproximado Total Interes")]
        public Decimal VATI
        {
            get { return vATI; }
            set { vATI = value; }
        }

        private Decimal vATS;

        [DisplayName("Valor Aproximado Total Seguro")]
        public Decimal VATS
        {
            get { return vATS; }
            set { vATS = value; }
        }

        private Decimal vATAP;

        [DisplayName("Valor Aproximado Total A Pagar")]
        public Decimal VATAP
        {
            get { return vATAP; }
            set { vATAP = value; }
        }


        private String articleId;


        [Browsable(true)]
        [DisplayName("Artículo")]
        public String ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }

        private String articleDescription;

        //[Browsable(false)]
        public String ArticleDescription
        {
            get { return articleDescription; }
            set { articleDescription = value; }
        }

        private String articleIdDescription;

        //[Browsable(true)]
        [DisplayName("Descripción")]
        public String ArticleIdDescription
        {
            get { return articleIdDescription; }
            set { articleIdDescription = value; }
        } 
        
        private String supplierName;

        [Browsable(true)]
        [DisplayName("Proveedor")]
        public String SupplierName
        {
            get { return supplierName; }
            set
            {
                supplierName = value;
            }
        }


        private Double valueArticle;

        [Browsable(true)]
        [DisplayName("Valor Unitario")]
        public Double ValueArticle
        {
            get { return this.valueArticle; }
            set {

                this.valueArticle = value;
                subTotal = amount * valueArticle;
                taxValue = subTotal * (tax / 100);
                
            }
        }


        private Boolean editValue;

        [Browsable(false)]
        public Boolean EditValue
        {
            get { return editValue; }
           
        } 


        private Int32 amount;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Int32 Amount
        {
            get { return amount; }
            set { 

                if(value <1 ){
                    ExceptionHandler.DisplayMessage(2741, "La cantidad no puede ser inferior a cero"); 


                }else {


                amount = value;
                subTotal = amount * valueArticle;
                taxValue = subTotal * (tax/100);  
            }}
        }

        private Double subTotal;

        [Browsable(true)]
        [DisplayName("Subtotal")]
        public Double SubTotal
        {
            get { return subTotal; }
        }


        private Int32 feedsNumberMin;

        //[Browsable(false)]
        public Int32 FeedsNumberMin
        {
            get { return feedsNumberMin; }
            set
            {
                feedsNumberMin = value;
            }
        }

        private Int32 feedsNumberMax;

        //[Browsable(false)]
        public Int32 FeedsNumberMax
        {
            get { return feedsNumberMax; }
            set
            {
                feedsNumberMax = value;
            }

        }         
        
        private Int32 feedsNumber;

        [Browsable(true)]
        [DisplayName("Numero de Cuotas")]
        public Int32 FeedsNumber
        {
            get { return feedsNumber; }
            set {

                if (value < this.feedsNumberMin)
                {
                    ExceptionHandler.DisplayMessage(2741, "El Valor es inferior al número de cuotas mínimas para este artículo");

                }
                else if (value > this.feedsNumberMax)
                {
                    ExceptionHandler.DisplayMessage(2741, "El Valor es superior al número de cuotas máximas para este artículo");

                }
                else
                {

                    feedsNumber = value;
                }
            
            }
        }

        private Int64 financingPlan;

        [Browsable(false)]
        public Int64 FinancingPlan
        {
            get { return financingPlan; }
        }

        private Double finanPercent;

        //[Browsable(false)]
        [DisplayName("Interes %")]
        public Double FinanPercent
        {
            get { return finanPercent; }
            set
            {
                finanPercent = value;
            }
        } 


        private Double tax;

        [Browsable(false)]
        public Double Tax
        {
            get { return tax; }
        }

        private Double taxValue;

        [Browsable(true)]
        [DisplayName("Valor del Impuesto")]
        public Double TaxValue
        {
            get { return taxValue; }
        }

        public ArticleFIHOS(String ArticleId, String ArticleDescription, String supplierName, Double valueArticle, Double tax, Int32 feedsNumberMin, Int32 feedsNumberMax, Int64 FinancingPlan, DateTime FirstFeedDate, Double FinanPercent, Int64 plazo)
        {
            this.articleId = ArticleId;
            this.articleDescription = ArticleDescription;
            //this.articleIdDescription = ArticleId + " - " + ArticleDescription;
            this.supplierName = supplierName;
            this.valueArticle = valueArticle;
            //ExceptionHandler.DisplayMessage(2741, plazo.ToString());
            this.firstDatePay = DateTime .Today .AddMonths ( int.Parse ( plazo.ToString ()));
            //this.tax = tax;
            this.feedsNumberMax = feedsNumberMax;
            this.feedsNumberMin = feedsNumberMin;
            this.financingPlan = FinancingPlan;
            //this.firstFeedDate = FirstFeedDate;
            this.feedsNumber = FeedsNumberMin; 
            if (ValueArticle == 0)
            {
                this.editValue = true;
            }
            else
            {

                this.editValue = false; 
            }
            this.amount = 1;
            this.subTotal = this.valueArticle * this.amount;
            this.taxValue = this.subTotal * (this.tax / 100);
            this.finanPercent = FinanPercent; 

        }

        public ArticleFIHOS()
        {
            
        }
    }
}
