using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class ListSN
    {
        private string id;

        [DisplayName("Valor")]
        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        private string description;

        [DisplayName("Descripción")]
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public ListSN(string Id, string Description) 
        {
            this.id = Id;
            this.description = Description;
        
        }
    }
}
