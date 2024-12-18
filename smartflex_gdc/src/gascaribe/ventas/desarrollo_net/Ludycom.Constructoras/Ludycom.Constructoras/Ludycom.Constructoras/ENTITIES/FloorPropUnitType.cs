using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class FloorPropUnitType
    {
        private Int64? FloorId;

        public Int64? FloorId1
        {
            get { return FloorId; }
            set { FloorId = value; }
        }

        private Int64? propUnitType;

        public Int64? PropUnitType
        {
            get { return propUnitType; }
            set { propUnitType = value; }
        }

        private Int64? id;

        public Int64? Id
        {
            get { return id; }
            set { id = value; }
        }

        private Int64 project;

        public Int64 Project
        {
            get { return project; }
            set { project = value; }
        }

        private String description;

        public String Description
        {
            get { return description; }
            set { description = value; }
        }

    }
}
