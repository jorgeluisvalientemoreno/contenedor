using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callFIHOS : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 SubscriptionId = 355650;
            try
            {
                SubscriptionId = Convert.ToInt64(parameters["NodeId"].ToString());
            }
            catch { }
            using (FIHOS frm = new FIHOS(SubscriptionId))
            {
                frm.ShowDialog();
            }
        }
    }
}
