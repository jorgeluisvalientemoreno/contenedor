using System;
using System.Collections.Generic;
using System.Text;

//librerias 
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using CONTROLDESARROLLO.DAL;

namespace CONTROLDESARROLLO.BL
{
    class BLGENERAL
    {
        DAGENERAL general = new DAGENERAL();

        public DataTable SQLGeneral(String Query)
        {
            return general.SQLGeneral(Query);
        }
    }
}
