using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class ArticleValue2
    {

        private String articleId;

        [Browsable(true)]
        [DisplayName("ID")]
        public String ArticleId
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

        private ArticleFIHOS articleObject;

        [Browsable(false)]
        public ArticleFIHOS ArticleObject
        {
            get { return articleObject; }
            set { articleObject = value; }
        }

        public ArticleValue2(String ArticleId, String ArticleDescription, ArticleFIHOS Article) 
        {
           this.articleDescription = ArticleDescription;
           this.articleId = ArticleId;
           this.articleObject = Article; 
        }
        public ArticleValue2() { }


    }
}
