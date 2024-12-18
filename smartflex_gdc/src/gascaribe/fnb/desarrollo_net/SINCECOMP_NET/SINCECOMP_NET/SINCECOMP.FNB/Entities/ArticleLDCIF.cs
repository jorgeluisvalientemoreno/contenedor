using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class ArticleLDCIF
    {
        /*private Decimal commisionPerCentPayContrat;

        [DisplayName("Porcentaje de comisión pagada al contratista")]
        public Decimal CommisionPerCentPayContrat
        {
            get { return commisionPerCentPayContrat; }
            set { commisionPerCentPayContrat = value; }
        }*/

        private Decimal commisionValuePayContrat;

        [DisplayName("Comisión pagada al contratista")]
        public Decimal CommisionValuePayContrat
        {
            get { return commisionValuePayContrat; }
            set { commisionValuePayContrat = value; }
        }

        /*private Decimal commisionValuePaySupplier;

        [DisplayName("Porcentaje de comisión cobrada al proveedor")]
        public Decimal CommisionValuePaySupplier
        {
            get { return commisionValuePaySupplier; }
            set { commisionValuePaySupplier = value; }
        }*/

        private Decimal commisionPaySupplier;

        [DisplayName("Comisión cobrada al proveedor")]
        public Decimal CommisionPaySupplier
        {
            get { return commisionPaySupplier; }
            set { commisionPaySupplier = value; }
        }

        private string financingRate;

        [DisplayName("Tasa de interés")]
        public string FinancingRate
        {
            get { return financingRate; }
            set { financingRate = value; }
        }

        private Int64 quoteNumber;

        [DisplayName("Número de cuotas")]
        public Int64 QuoteNumber
        {
            get { return quoteNumber; }
            set { quoteNumber = value; }
        }

        private String articleName;

        [DisplayName("Artículo")]
        public String ArticleName
        {
            get { return articleName; }
            set { articleName = value; }
        }

        private Int64 articleValue;

        [DisplayName("Valor Unitario")]
        public Int64 ArticleValue
        {
            get { return articleValue; }
            set { articleValue = value; }
        }

        private Int64 articleAmount;

        [DisplayName("Cantidad")]
        public Int64 ArticleAmount
        {
            get { return articleAmount; }
            set { articleAmount = value; }
        }

        private string conceptName;
        
        [DisplayName("Concepto")]
        public string ConceptName
        {
            get { return conceptName; }
            set { conceptName = value; }
        }

        private string address;

        [DisplayName("Dirección de entrega")]
        public string Address
        {
            get { return address; }
            set { address = value; }
        }

        private Int64 diasgarantia;

        [DisplayName("Días de garantía")]
        public Int64 Diasgarantia
        {
            get { return diasgarantia; }
            set { diasgarantia = value; }
        }

        private DateTime fingarantia;

        [DisplayName("Fecha final de garantía")]
        public DateTime Fingarantia
        {
            get { return fingarantia; }
            set { fingarantia = value; }
        }

        private Int64 iva;

        [DisplayName("IVA")]
        public Int64 Iva
        {
            get { return iva; }
            set { iva = value; }
        }

        private string supplierName;

        [DisplayName("Proveedor")]
        public string SupplierName
        {
            get { return supplierName; }
            set { supplierName = value; }
        }

        private string deliveryState;

        [DisplayName("Estado de la entrega")]
        public string DeliveryState
        {
            get { return deliveryState; }
            set { deliveryState = value; }
        }

        private Int64 totalValue;

        [DisplayName("Valor total")]
        public Int64 TotalValue
        {
            get { return totalValue; }
            set { totalValue = value; }
        }

        private Int64 numDife;

        [DisplayName("Número del diferido")]
        public Int64 NumDife
        {
            get { return numDife; }
            set { numDife = value; }
        }

        private Int64 valDife;

        [DisplayName("Valor del diferido")]
        public Int64 ValDife
        {
            get { return valDife; }
            set { valDife = value; }
        }


        /* 13-01-2015  KCienfuegos.RNP1224 */
        private string invoice;

        [DisplayName("Número de Factura")]
        public string Invoice
        {
            get { return invoice; }
            set { invoice = value; }
        }
        /************************************/

        public ArticleLDCIF(DataRow row)
        {
            ArticleName   = row["narticulo"].ToString();
            ArticleValue  = Convert.ToInt64 (row["valor"]);
            ArticleAmount = Convert.ToInt64 (row["cantidad"]);
            QuoteNumber   = Convert.ToInt64 (row["ncuotas"]);
            Address = row["direccion"].ToString();
            Diasgarantia = Convert.ToInt64(row["diasgarantia"]);
            Fingarantia = Convert.ToDateTime(row["fingarantia"]);
            Iva = Convert.ToInt64(row["iva"]);
            FinancingRate = row["tasainteres"].ToString();
            ConceptName = row["sbconcepto"].ToString();
            SupplierName = row["nproveedor"].ToString();
            DeliveryState = row["EstEnt"].ToString();
            TotalValue = Convert.ToInt64(row["ValTot"]);
            NumDife = Convert.ToInt64(row["nuDife"]);
            ValDife = Convert.ToInt64(row["valDife"]);
            Invoice = row["Invoice"].ToString(); //KCienfuegos.RNP1224 13-01-2015
            

            CommisionValuePayContrat = Convert.ToInt64(row["ValComPagCon"]);
            CommisionPaySupplier = Convert.ToInt64(row["ValCobComPro"]);


            //Validar
            //CommisionPerCentPayContrat = Convert.ToInt64(row["valor"]);
            //CommisionValuePaySupplier = Convert.ToInt64(row["valor"]);
            
        }
    }
}