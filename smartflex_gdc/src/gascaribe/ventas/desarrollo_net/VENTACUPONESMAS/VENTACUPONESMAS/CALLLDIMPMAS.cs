using System;
using System.Collections.Generic;
using System.Text;
using VENTACUPONESMAS.UI;
using OpenSystems.Common.Interfaces;

namespace VENTACUPONESMAS
{
    public class CALLLDIMPMAS:IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDIMPMAS form = new LDIMPMAS())
            {
                form.ShowDialog();
            }
        }
    }
}