using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    class ListOfVal
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

        public ListOfVal(string Id, string Description) 
        {
            this.id = Id;
            this.Description = Description;
        
        }
        public ListOfVal()
        {
            this.id = " ";
            this.Description = " ";

        }

    }
}
