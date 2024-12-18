using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callLDOA : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDOA frm = new LDOA())
            {
                frm.ShowDialog();
            }
        }
    }
}
