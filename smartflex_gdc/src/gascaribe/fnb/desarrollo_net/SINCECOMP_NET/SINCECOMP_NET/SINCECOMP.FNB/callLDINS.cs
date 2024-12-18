using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callLDINS : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            //using (LDINS  frm = new LDINS())
            //{
            //    frm.ShowDialog();
            //}
            Int64 Request = 0;
            try
            {
                Request = Convert.ToInt64(parameters["NodeId"].ToString());
            }
            catch { }
            using (LDINS frm = new LDINS(Request))
            {
                frm.ShowDialog();
            }
        }
    }
}
