using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Util;
using LDCAPLAC.Entities;
using LDCAPLAC.UI;
using LDCAPLAC.BL;

namespace LDCAPLAC
{
    public class callLDC_APLAC : IOpenExecutable
    {

        //public Int64 nuCode = 4; //1 //152 //60 cot 2 3 //150
        private BLLDC_APLAC blLDC_FCVC = new BLLDC_APLAC();
        private BLUtilities utilities = new BLUtilities();
        private LDC_APLAC ldAPLAC = new LDC_APLAC();

        public void Execute(Dictionary<string, object> parameters)
        {
            
            String UsuarioConect = ldAPLAC.ObtenerUsuarioConectado();
            
            if (UsuarioConect != "NotFind")
             {
                 using (LDC_APLAC frm = new LDC_APLAC())
                 {
                     frm.ShowDialog();
                 }
             }

             

        }

       // *////***
    }
}
