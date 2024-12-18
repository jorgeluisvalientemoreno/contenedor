using System;
using System.Collections.Generic;
using System.Text;

//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using Infragistics.Win;
using System.Data.OleDb;
using System.Windows.Forms;
using System.Reflection;
using OpenSystems.Windows.Controls;
using BSS.TARIFATRANSITORIA.DAL;

namespace BSS.TARIFATRANSITORIA.BL
{
    class BLGENERAL
    {
        DALGENERAL general = new DALGENERAL();

        public DataTable getValueList(String Query)
        {
            return general.getValueList(Query);
        }

    }
}
