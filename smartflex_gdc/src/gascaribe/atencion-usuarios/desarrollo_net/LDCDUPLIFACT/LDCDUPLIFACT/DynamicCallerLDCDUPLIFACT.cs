using System;
using System.Collections.Generic;
//using System.Windows.Forms;
using System.Text;
using OpenSystems.Common.Interfaces;
using System.Windows.Forms;

namespace LDCDUPLIFACT
{
    public class DynamicCallerLDCDUPLIFACT : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {       
            using (Form1 form = new Form1())
            {
                form.ShowDialog();
            }
        }
    }
}
