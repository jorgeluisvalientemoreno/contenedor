using System;
using System.Collections.Generic;
using System.Text;

namespace LDCAPLAC.Entities
{
    class LovItem
    {
        private string id;

        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        private string description;

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public LovItem(string Id, string Description)
        {
            this.id = Id;
            this.Description = Description;

        }
        public LovItem()
        {
            this.id = " ";
            this.Description = " ";

        }
    }
}
