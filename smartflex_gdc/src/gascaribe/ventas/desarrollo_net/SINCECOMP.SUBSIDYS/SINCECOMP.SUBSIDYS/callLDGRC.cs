using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.SUBSIDYS.UI;

namespace SINCECOMP.SUBSIDYS
{
    public class callLDGRC : IOpenExecutable 
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDGRC frm = new LDGRC())
            {
                frm.ShowDialog();
            }
        }
    }
}
