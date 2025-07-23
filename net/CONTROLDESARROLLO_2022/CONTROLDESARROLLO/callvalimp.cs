using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using CONTROLDESARROLLO.UI;

namespace CONTROLDESARROLLO
{
    public class callvalimp : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {            
            using (valimp form = new valimp())
            {
                form.ShowDialog();
            }
        }

    }    
}
