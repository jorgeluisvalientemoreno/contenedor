using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras
{
    public class callLDCMDOINT : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {

            using (LDCMDOINT frm = new LDCMDOINT())
            {
                frm.ShowDialog();
            }

        }
    }
}
