using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras.ENTITIES
{
    class OrdenesInternas
    {
        private Int64? OrdenOri;
               
        [DisplayName("Orden Interna 1")]
        public Int64? ordenOri
        {
            get { return OrdenOri; }
            set { OrdenOri = value; }
        }
        private Int64? OrdenDest;

        [DisplayName("Orden Interna 2")]
        public Int64? ordenDest
        {
            get { return OrdenDest; }
            set { OrdenDest = value; }
        }
        public OrdenesInternas()
        {
            this.OrdenDest = null;
            this.OrdenOri = null;
        }

            }
}
