using System;
using System.Collections.Generic;
//using System.Windows.Forms;
using System.Text;
using OpenSystems.Common.Interfaces;
using System.Windows.Forms;

namespace BSS.LineamientosPSPD
{
    public class callLDC_CARGINFO : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDC_CARGINFO form = new LDC_CARGINFO())
            {
                form.ShowDialog();
            }
        }
    }
}
