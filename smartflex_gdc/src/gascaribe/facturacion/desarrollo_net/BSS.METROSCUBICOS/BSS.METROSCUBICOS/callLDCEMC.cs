using System;
using System.Collections.Generic;
using System.Text;

//Libreias OPEN
using OpenSystems.Common.Interfaces;
using BSS.METROSCUBICOS.UI;

namespace BSS.METROSCUBICOS 
{
    public class callLDCEMC : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {

            using (LDCEMC frm = new LDCEMC())
            {
                frm.ShowDialog();
            }
        }
    }
}
