using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.CONSTRUCTIONUNITS.UI;
using OpenSystems.Common.Interfaces;

namespace SINCECOMP.CONSTRUCTIONUNITS
{
    public class CALLLDEFC: IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDEFC form = new LDEFC())
            {
                form.ShowDialog();
            }
        }
    }
}
