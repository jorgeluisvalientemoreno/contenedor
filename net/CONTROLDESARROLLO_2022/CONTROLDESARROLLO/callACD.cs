using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using CONTROLDESARROLLO.UI;

namespace CONTROLDESARROLLO
{
    public class callACD : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (ACD form = new ACD())
            //using (CR form = new CR())
            {
                form.ShowDialog();
            }
        }

    }    
}
