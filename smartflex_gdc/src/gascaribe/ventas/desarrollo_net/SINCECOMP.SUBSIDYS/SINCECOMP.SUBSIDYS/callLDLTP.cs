using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.SUBSIDYS.UI;

namespace SINCECOMP.SUBSIDYS
{
    public class callLDLTP : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDLTP frm = new LDLTP())
            {
                frm.ShowDialog();
            }
        }
    }
}
