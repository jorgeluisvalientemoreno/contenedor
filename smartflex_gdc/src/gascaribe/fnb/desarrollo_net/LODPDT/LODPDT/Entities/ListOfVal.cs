using System;
using System.Collections.Generic;
using System.Text;

namespace LODPDT.Entities
{
    class ListOfVal
    {
        private string id;

        public string Id
        {
            get { return id; }
            set { id = value; }
        }
        private string descripcion;

        public string Descripcion
        {
            get { return descripcion; }
            set { descripcion = value; }
        }

        public ListOfVal(string Id, string Descripcion)
        {
            this.id = Id;
            this.descripcion = Descripcion;

        }
        public ListOfVal()
        {
            this.id = " ";
            this.descripcion = " ";

        }
    }
}
