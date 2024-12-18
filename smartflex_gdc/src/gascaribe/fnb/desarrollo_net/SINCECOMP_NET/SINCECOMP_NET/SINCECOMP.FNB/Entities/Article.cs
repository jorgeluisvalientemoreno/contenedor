#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : Article
 * Descripcion   : Clase para los atributos de los artículos
 * Autor         : 
 * Fecha         : 
 *
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ==============  =====================================================================
 * 27-Sep-2013  217614  lfernandez      1 - Se modifica para que la clase sea pública
 * 09-Sep-2013  216609  lfernandez      1 - <EditValue> Se adiciona método set
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    public class Article
    {
        private Int64 articleId;


        [Browsable(true)]
        [DisplayName("Identificador del Artículo")]
        public Int64 ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }

        private String articleDescription;

        [Browsable(false)]
        public String ArticleDescription
        {
            get { return articleDescription; }
            set { articleDescription = value; }
        }

        private String articleIdDescription;

        [Browsable(true)]
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
        }


        private Double valueArticle;

        [Browsable(true)]
        [DisplayName("Valor Unitario")]
        public Double ValueArticle
        {
            get { return this.valueArticle; }
            set
            {

                if (EditValue)
                {
                    this.valueArticle = value;
                    subTotal = amount * valueArticle;
                    taxValue = Math.Round(subTotal * (tax / 100),0);
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, "El precio de este artículo no puede ser modificado");

                }
            }
        }


        private Boolean editValue;

        [Browsable(false)]
        public Boolean EditValue
        {
            set { editValue = value; }
            get { return editValue; }

        }


        private Int32 amount;

        [Browsable(true)]
        [DisplayName("Cantidad")]
        public Int32 Amount
        {
            get { return amount; }
            set
            {

                if (value < 1)
                {
                    ExceptionHandler.DisplayMessage(2741, "La cantidad no puede ser inferior a cero");


                }
                else
                {


                    amount = value;
                    subTotal = amount * valueArticle;
                    taxValue = Math.Round(subTotal * (tax / 100),0);
                }
            }
        }

        private Double subTotal;

        [Browsable(true)]
        [DisplayName("Subtotal")]
        public Double SubTotal
        {
            get { return subTotal; }
        }


        private Int32 feedsNumberMin;

        [Browsable(false)]
        public Int32 FeedsNumberMin
        {
            get { return feedsNumberMin; }
        }

        private Int32 feedsNumberMax;

        [Browsable(false)]
        public Int32 FeedsNumberMax
        {
            get { return feedsNumberMax; }

        }

        /// <summary>
        /// Número de Cuotas. Mínimo es una (1).
        /// </summary>
        private Int32 feedsNumber = 1;

        [Browsable(true)]
        [DisplayName("Número de Cuotas")]
        public Int32 FeedsNumber
        {
            get { return feedsNumber; }
            set
            {

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

        private DateTime firstFeedDate;

        [Browsable(true)]
        [DisplayName("Fecha de próxima cuota")]
        public DateTime FirstFeedDate
        {
            get { return firstFeedDate; }
            set { firstFeedDate = value; }
        }


        

        private Int64 financingPlan;

        [Browsable(false)]
        public Int64 FinancingPlan
        {
            get { return financingPlan; }
        }

        private Double finanPercent;

        [Browsable(false)]
        public Double FinanPercent
        {
            get { return finanPercent; }
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
            get { return Math.Round(taxValue,0); }
        }

        private Int64 financierId;

        [Browsable(false)]
        public Int64 FinancierId
        {
            get { return financierId; }
            set { financierId = value; }
        }


        private Int64 lineId;
        [Browsable(false)]
        public Int64 LineId
        {
            get { return lineId; }
            set { lineId = value; }
        }

        private Int64 sublineId;
        [Browsable(false)]
        public Int64 SublineId
        {
            get { return sublineId; }
            set { sublineId = value; }
        }

        private Int64 supplierId;

        [Browsable(false)]
        public Int64 SupplierId
        {
            get { return supplierId; }
            set { supplierId = value; }
        }


        private Int64? extraQuotaId;

        [Browsable(false)]
        public Int64? ExtraQuotaId
        {
            get { return extraQuotaId; }
            set { extraQuotaId = value; }
        }

        private Double? usedExtraQuota;

        [Browsable(false)]
        public Double? UsedExtraQuota
        {
            get { return usedExtraQuota; }
            set { usedExtraQuota = value; }
        }

        private Boolean gracePeriod;
        [Browsable(false)]
        public Boolean GracePeriod
        {
            get { return gracePeriod; }
            set { gracePeriod = value; }
        }

        public Article(Int64 ArticleId, String ArticleDescription, String supplierName, Double valueArticle, Double tax, Int32 feedsNumberMin, Int32 feedsNumberMax, Int64 FinancingPlan, DateTime FirstFeedDate, Double FinanPercent, Int64 lineId, Int64 sublineId, Int64 supplierId, Int64 financierId)
        {
            this.articleId = ArticleId;
            this.articleDescription = ArticleDescription;
            this.articleIdDescription = ArticleDescription;
            this.supplierName = supplierName;
            this.valueArticle = valueArticle;
            this.tax = tax;
            this.feedsNumberMax = feedsNumberMax;
            this.feedsNumberMin = feedsNumberMin;
            this.financingPlan = FinancingPlan;
            this.firstFeedDate = FirstFeedDate;

            if (FeedsNumberMin <= 0)
                this.feedsNumber = 1;
            else
                this.feedsNumber = FeedsNumberMin;

            
            this.editValue = true;
      
            this.amount = 1;
            this.subTotal = this.valueArticle * this.amount;
            this.taxValue = Math.Round(this.subTotal * (this.tax / 100),0);
            this.finanPercent = FinanPercent;
            this.lineId = lineId;
            this.sublineId = sublineId;
            this.supplierId = supplierId;
            this.financierId = financierId;

            this.gracePeriod = false;

            if (this.firstFeedDate > DateTime.Now)
            {
                this.gracePeriod = true;
            }

        }

        public Article()
        {

        }
    }
}
