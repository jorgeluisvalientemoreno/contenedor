using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class PropArtGEPBR
    {
        private Int64 propertArtId;

        //[DisplayName("Id. Propiedad por Articulo")]
        public Int64 PropertArtId
        {
            get { return propertArtId; }
            set { propertArtId = value; }
        }

        private Int64 articleId;

        //[DisplayName("Articulo")]
        public Int64 ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }

        private String propertyId;

        [DisplayName("Propiedad")]
        public String PropertyId
        {
            get { return propertyId; }
            set { propertyId = value; }
        }

        private String value;

        [DisplayName("Valor")]
        public String Value
        {
            get { return this.value; }
            set { this.value = value; }
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

        public PropArtGEPBR(DataRow row)
        {
            PropertArtId = Convert.ToInt64(row["propert_by_article_id"]);
            ArticleId = Convert.ToInt64(row["article_id"]);
            PropertyId = Convert.ToString(row["property_id"]);
            Value = Convert.ToString(row["value"]);
        }
    }
}
