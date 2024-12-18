
using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.SUBSIDYS.UI;

namespace SINCECOMP.SUBSIDYS
{
    public class callLDDRC : IOpenExecutable 
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDDRC frm = new LDDRC())
            {
                frm.ShowDialog();
            }
        }
    }
}
