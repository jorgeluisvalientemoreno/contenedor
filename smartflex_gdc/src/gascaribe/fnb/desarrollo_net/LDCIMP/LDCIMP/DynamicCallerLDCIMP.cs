using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.InstanceHandler;
using OpenSystems.Windows.Controls;

namespace LDCIMP
{
    public class DynamicCallerLDCIMP : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {            
            OpenHeaderTitles RegisterHeader = (parameters["Header"] as OpenHeaderTitles);

            Int64 nuSusc = Convert.ToInt64(parameters["NodeId"].ToString());

            using (LDCIMP form = new LDCIMP(nuSusc))
            {
                form.ShowDialog();
            }
        }
    }
}
