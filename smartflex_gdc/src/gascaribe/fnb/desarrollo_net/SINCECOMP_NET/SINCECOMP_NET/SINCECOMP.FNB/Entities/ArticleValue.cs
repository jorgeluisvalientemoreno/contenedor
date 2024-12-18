using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    internal class ArticleValue
    {

        private Int64 articleId;

        [Browsable(true)]
        [DisplayName("ID")]
        public Int64 ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        } 


        private String articleDescription;

        [Browsable(true)]
        [DisplayName("Descripcion")]
        public String ArticleDescription
        {
            get { return articleDescription; }
            set { articleDescription = value; }
        }

        private Article articleObject;

        [Browsable(false)]
        public Article ArticleObject
        {
            get { return articleObject; }
            set { articleObject = value; }
        }

        public ArticleValue(Int64 ArticleId, String ArticleDescription, Article Article) 
        {
           this.articleDescription = ArticleDescription;
           this.articleId = ArticleId;
           this.articleObject = Article; 
        }
        public ArticleValue() { }


    }
}
