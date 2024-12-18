using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using LODPDT.UI;

namespace LODPDT
{
    public class CALLLODPDT : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (FRM_LODPDT frm = new FRM_LODPDT())
            {
                frm.ShowDialog();
            }
        }

    }
}
