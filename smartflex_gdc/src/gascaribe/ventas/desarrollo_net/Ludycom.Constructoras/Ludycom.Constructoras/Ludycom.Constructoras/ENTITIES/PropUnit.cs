using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class PropUnit
    {
        private Int64 id;

        public Int64 Id
        {
            get { return id; }
            set { id = value; }
        }

        private String description;

        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        public PropUnit(DataRow drPropUnit)
        {
            this.Id = Convert.ToInt64(drPropUnit["ID"]);
            this.Description = Convert.ToString(drPropUnit["DESCRIPTION"]);
        }
    }
}
