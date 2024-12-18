using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;

namespace SINCECOMP.FNB
{
    public class callLDAPB : IOpenExecutable  
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDAPB frm = new LDAPB())
            {
                frm.ShowDialog();
            }
        }
    }
}
