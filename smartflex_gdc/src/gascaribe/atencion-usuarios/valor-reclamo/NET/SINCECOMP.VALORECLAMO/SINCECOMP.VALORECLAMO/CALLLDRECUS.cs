using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.VALORECLAMO.UI;
using SINCECOMP.VALORECLAMO.BL;
using SINCECOMP.VALORECLAMO.Entities;
using System;

namespace SINCECOMP.VALORECLAMO
{
    public class CALLLDRECUS : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 SubscriptionId = 0;
            String callForm = parameters["NodeLevel"].ToString();
            BLLDVALREC _blLDVALREC = new BLLDVALREC();
            switch (callForm)
            {
                case "CONTRACT":
                    {
                        SubscriptionId = Int64.Parse(parameters["NodeId"].ToString()); //600851
                    }
                    break;
                case "BILLING_ACCOUNT":
                    {
                        SubscriptionId = _blLDVALREC.getContract(parameters["NodeId"].ToString()); //
                    }
                    break;
            }
            dataLDVALREC _dataLDVALREC = _blLDVALREC.getSubscriptionData(SubscriptionId);
            using (LDRECUS frm = new LDRECUS(SubscriptionId, _dataLDVALREC))
            {
                frm.ShowDialog();
            }
        }
    }
}