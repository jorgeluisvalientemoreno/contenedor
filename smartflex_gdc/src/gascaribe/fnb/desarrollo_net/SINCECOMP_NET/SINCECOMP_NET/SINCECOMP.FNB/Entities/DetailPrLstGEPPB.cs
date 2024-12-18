using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class DetailPrLstGEPPB
    {
        private String articleId;

        [DisplayName("Descripción Artículo")]
        public String ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }

        [DisplayName("Código Artículo")]
        public Int64 IdArticle
        {
            get { return Convert.ToInt64(articleId); }
            set { articleId = Convert.ToString(value); }
        }

        private Decimal price;

        [DisplayName("Precio")]
        public Decimal Price
        {
            get { return price; }
            set {
                if(value <= 0)
                    ExceptionHandler.DisplayMessage(2741, "El Precio debe ser mayor a 0");
                else
                    price = value; 
            }
        }

        private Decimal priceAproved;

        [DisplayName("Precio Aprobado")]
        public Decimal PriceAproved
        {
            get { return priceAproved; }
            set { priceAproved = value; }
        }

        private String geograpLocationId;

        [DisplayName("Ubicación Geográfica")]
        public String GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }

        private String saleChanelId;

        [DisplayName("Canal de Venta")]
        public String SaleChanelId
        {
            get { return saleChanelId; }
            set { saleChanelId = value; }
        }

        private Int64 priceListId;

        //[DisplayName("")]
        public Int64 PriceListId
        {
            get { return priceListId; }
            set { priceListId = value; }
        }

        private Int64 priceListDetaId;

        //[DisplayName("Identificación")]
        public Int64 PriceListDetaId
        {
            get { return priceListDetaId; }
            set { priceListDetaId = value; }
        }

        private Int64 version;

        //[DisplayName("Versión")]
        public Int64 Version
        {
            get { return version; }
            set { version = value; }
        }

        private Int64 checkSave;

        public Int64 CheckSave
        {
            get { return checkSave; }
            set { checkSave = value; }
        }

        private Int64 checkModify;

        public Int64 CheckModify
        {
            get { return checkModify; }
            set { checkModify = value; }
        }



        public DetailPrLstGEPPB(DataRow row)
        {
            ArticleId = Convert.ToString(row["Article_Id"]);
            Price = Convert.ToInt64(row["Price"]);
            if (Convert.IsDBNull(row["Price_Aproved"]) != true)
                PriceAproved = Convert.ToInt64(row["Price_Aproved"]);
            if (Convert.IsDBNull(row["Geograp_Location_Id"]) != true)
                GeograpLocationId = Convert.ToString(row["Geograp_Location_Id"]);
            else
                GeograpLocationId = " ";
            if (Convert.IsDBNull(row["Sale_Chanel_Id"]) != true)
                SaleChanelId = Convert.ToString(row["Sale_Chanel_Id"]);
            else
                SaleChanelId = " ";
            PriceListId = Convert.ToInt64(row["Price_List_Id"]);
            PriceListDetaId = Convert.ToInt64(row["Price_List_Deta_Id"]);
            if (Convert.IsDBNull(row["Version"]) != true)
                Version = Convert.ToInt64(row["Version"]);
            else
                Version = 0;
        }
    }
}
