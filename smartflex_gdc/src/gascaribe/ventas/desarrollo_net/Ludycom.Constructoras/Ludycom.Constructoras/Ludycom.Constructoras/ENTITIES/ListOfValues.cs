using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class ListOfValues
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

        public ListOfValues(string Id, string Description)
        {
            this.id = Id;
            this.Description = Description;

        }
        public ListOfValues()
        {
            this.id = " ";
            this.Description = " ";

        }
    }
}
