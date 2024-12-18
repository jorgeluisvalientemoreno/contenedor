using System;
using System.Collections.Generic;
using System.Text;

using OpenSystems.Common.Interfaces;
using SINCECOMP.VALORECLAMO.UI;
using SINCECOMP.VALORECLAMO.BL;
using SINCECOMP.VALORECLAMO.Entities;
using System;
using System.Windows.Forms;

namespace SINCECOMP.VALORECLAMO
{
    public class CALLLDCAVR : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDCAVR frm = new LDCAVR())
            {
                frm.ShowDialog();
            }
        }
    }
}
