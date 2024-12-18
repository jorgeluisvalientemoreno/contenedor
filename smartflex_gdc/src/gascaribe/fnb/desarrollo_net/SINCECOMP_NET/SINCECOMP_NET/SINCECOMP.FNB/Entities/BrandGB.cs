using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class BrandGB
    {
        private Int64 brandId;

        [DisplayName("Identificación")]
        public Int64 BrandId
        {
            get { return brandId; }
            set { brandId = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private String approved;

        [DisplayName("Aprobado")]
        public String Approved
        {
            get { return approved; }
            set { approved = value; }
        }

        private String conditionApproved;

        [DisplayName("Condición de Aprobación")]
        public String ConditionApproved
        {
            get { return conditionApproved; }
            set { conditionApproved = value; }
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

        public BrandGB(DataRow row)
        {
            BrandId = Convert.ToInt64(row["brand_id"]);
            Description = Convert.ToString(row["description"]);
            Approved = Convert.ToString(row["approved"]);
            ConditionApproved = Convert.ToString(row["condition_approved"]);
        }
    }
}
