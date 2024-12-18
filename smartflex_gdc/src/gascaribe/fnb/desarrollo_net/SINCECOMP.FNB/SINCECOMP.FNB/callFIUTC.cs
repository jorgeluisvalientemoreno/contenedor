using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callFIUTC : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 SubscriptionId = 0;

            try
            {

                Convert.ToInt64(parameters["NodeId"].ToString());
            }
            catch { }            

            using (FIUTC frm = new FIUTC(SubscriptionId,0))
            {
                frm.ShowDialog();
            }
        }
    }
}
