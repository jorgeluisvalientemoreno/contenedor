using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callLDCIF : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 SubscriptionId = 0;
            try
            {
                SubscriptionId = Convert.ToInt64(parameters["NodeId"].ToString());
            }
            catch { }
            using (LDCIF frm = new LDCIF(SubscriptionId))
            {
                frm.ShowDialog();
            }
        }
    }
}
