using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callCCPU : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 packageId = 0;
            try
            {
                packageId = Convert.ToInt64(parameters["NodeId"].ToString());
            }
            catch { }
            using (CCPU frm = new CCPU(packageId))
            {
                frm.ShowDialog();
            }
        }
    }
}
