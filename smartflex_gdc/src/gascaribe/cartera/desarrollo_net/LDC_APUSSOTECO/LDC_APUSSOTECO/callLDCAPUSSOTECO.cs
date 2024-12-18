using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Util;
using LDC_APUSSOTECO.Entities;
using LDC_APUSSOTECO.UI;
using LDC_APUSSOTECO.BL;

namespace LDC_APUSSOTECO
{
    public class callLDCAPUSSOTECO : IOpenExecutable
    {

        //public Int64 nuCode = 4; //1 //152 //60 cot 2 3 //150
        private BLLDCAPUSSOTECO blLDC_FCVC = new BLLDCAPUSSOTECO();
        private BLUtilities utilities = new BLUtilities();
        private LDCAPUSSOTECO ldApusoteco = new LDCAPUSSOTECO();

        public void Execute(Dictionary<string, object> parameters)
        {

            String UsuarioConect = ldApusoteco.ObtenerUsuarioConectado();
            
            if (UsuarioConect != "NotFind")
             {
                 using (LDCAPUSSOTECO frm = new LDCAPUSSOTECO())
                 {
                     frm.ShowDialog();
                 }
             }

        }

    }
}
