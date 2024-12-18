using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.VALORECLAMO.UI;

namespace SINCECOMP.VALORECLAMO
{
    public class CALLLDREGREC : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 PackageId = 0;
            PackageId = Int64.Parse(parameters["NodeId"].ToString());
            using (LDREGREC frm = new LDREGREC(PackageId))
            {
                frm.ShowDialog();
            }
        }
    }
}
