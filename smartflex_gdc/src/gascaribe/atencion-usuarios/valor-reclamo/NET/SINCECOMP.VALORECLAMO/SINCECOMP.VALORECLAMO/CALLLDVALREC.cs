using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.VALORECLAMO.UI;
using SINCECOMP.VALORECLAMO.BL;
using SINCECOMP.VALORECLAMO.Entities;
using System;
using System.Windows.Forms;

namespace SINCECOMP.VALORECLAMO
{
    public class CALLLDVALREC : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            //MessageBox.Show("hola");
            Int64 SubscriptionId = 0;
            String callForm = parameters["NodeLevel"].ToString();
            BLLDVALREC _blLDVALREC = new BLLDVALREC();
            switch(callForm)
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
            using (LDVALREC frm = new LDVALREC(SubscriptionId, _dataLDVALREC))
            {
                frm.ShowDialog();
            }
        }
    }
}