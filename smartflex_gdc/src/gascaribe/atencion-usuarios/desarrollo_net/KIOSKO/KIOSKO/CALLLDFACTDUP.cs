using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;

using KIOSKO.UI;

namespace KIOSKO
{
    public class CALLLDFACTDUP : IOpenExecutable
    {

        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDFACTDUP frm = new LDFACTDUP())
            {
                frm.ShowDialog();
            }
        }

    }
}
