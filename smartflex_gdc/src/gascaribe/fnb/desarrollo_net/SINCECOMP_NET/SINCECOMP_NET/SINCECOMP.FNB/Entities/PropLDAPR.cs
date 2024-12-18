using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class PropLDAPR
    {
        private Int64 propertyId;

        [DisplayName("Codigo")]
        public Int64 PropertyId
        {
            get { return propertyId; }
            set { propertyId = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value.ToUpper(); }
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

        public PropLDAPR(DataRow row)
        {
            PropertyId = Convert.ToInt64(row["property_id"]);
            Description = Convert.ToString(row["description"]).ToUpper();
        }
    }
}
