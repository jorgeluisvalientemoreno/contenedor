using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.CANCELLATION.UI;

namespace SINCECOMP.CANCELLATION
{
    public class callFNBIR : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (FNBIR frm = new FNBIR())
            {
                frm.ShowDialog();
            }
        }
    }
}
