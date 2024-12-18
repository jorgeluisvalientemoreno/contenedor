using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class LengthPerFloor
    {
        private Int64 projectId;

        public Int64 Project {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int32 floorId;

        public Int32 Floor {
            get { return floorId; }
            set { floorId = value; }
        }

        private String floorDesc;

        [Browsable(true)]
        [DisplayName("Piso")]
        public String FloorDesc
        {
            get { return floorDesc; }
            set { floorDesc = value; }
        }

        private Double longBaj;

        [Browsable(true)]
        [DisplayName("Longitud de Bajante")]
        public Double LongBaj {
            get { return longBaj; }
            set { longBaj = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public LengthPerFloor()
        {
        }

        public LengthPerFloor(DataRow drLengthPerFloor)
        {
            this.Floor = Convert.ToInt32(drLengthPerFloor["ID_PISO"]);
            this.FloorDesc = Convert.ToString(drLengthPerFloor["DESCRIPCION"]);
            this.LongBaj = Convert.ToDouble(drLengthPerFloor["LONG_BAJANTE"]);
            this.Project = Convert.ToInt64(drLengthPerFloor["ID_PROYECTO"]);
            this.Operation = "N";
        }
    }
}
