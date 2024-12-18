using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    class DetailArticle
    {
        private String article_id;

        public String Article_id
        {
            get { return article_id; }
            set { article_id = value; }
        }
        private String reference;

        public String Reference
        {
            get { return reference; }
            set { reference = value; }
        }
        private String description;

        public String Description
        {
            get { return description; }
            set { description = value; }
        }
        private String amount;

        public String Amount
        {
            get { return amount; }
            set { amount = value; }
        }
        private String unit_value;

        public String Unit_value
        {
            get { return unit_value; }
            set { unit_value = value; }
        }
        private String full_article;

        public String Full_article
        {
            get { return full_article; }
            set { full_article = value; }
        }
        private String number_shares;

        public String Number_shares
        {
            get { return number_shares; }
            set { number_shares = value; }
        }

        //public DetailArticle(DataRow row)
        //{
        //}
    }
}
