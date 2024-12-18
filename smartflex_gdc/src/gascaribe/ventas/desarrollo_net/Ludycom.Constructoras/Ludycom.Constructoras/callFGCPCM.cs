using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;
using OpenSystems.Common.Util;
using Ludycom.Constructoras.BL;

namespace Ludycom.Constructoras
{
    public class callFGCPCM : IOpenExecutable
    {
        BLUtilities utilities = new BLUtilities();
        BLFDMPC blFDMPC = new BLFDMPC();

        public void Execute(Dictionary<string, object> parameters)
        {           

                    using (FGCPCM frm = new FGCPCM())
                    {
                        frm.ShowDialog();
                    }
              
        }
    }
}
