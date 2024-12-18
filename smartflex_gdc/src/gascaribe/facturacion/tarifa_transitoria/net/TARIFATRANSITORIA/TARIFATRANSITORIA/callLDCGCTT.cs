using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;

//CASO 415
using OpenSystems.Common.Interfaces;
using TARIFATRANSITORIA.UI;

namespace TARIFATRANSITORIA
{
    public class callLDCGCTT : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {

            using (LDCGCTT frm = new LDCGCTT())
            {
                frm.ShowDialog();
            }
         
        }
    }
}
