using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
namespace ORCUO
{
    public class DynamicCallerORCUO : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (ORCUO form = new ORCUO())
            {                   
                form.ShowDialog();                
            }
        }
    }
}
