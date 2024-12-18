using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.CONSTRUCTIONUNITS.UI;

namespace SINCECOMP.CONSTRUCTIONUNITS
{
    public class CALLLDBEX:IOpenExecutable
    {
        public void Execute(Dictionary<string,object> parameters) 
        {
            using (LDBEX form = new LDBEX())
            {
                form.ShowDialog();
            }
        }

    }
}
