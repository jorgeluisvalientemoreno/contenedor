using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;

namespace Ludycom.Constructoras
{
    public class callFGCHC: IOpenExecutable
    {
        public Int64 nuCode = 0;

        public void Execute(Dictionary<string, object> parameters)
        {
            //if (parameters.ContainsValue("NodeId"))
            //{
            //    nuCode = Convert.ToInt64(parameters["NodeId"].ToString());
            //}

            using (FGCHC frm = new FGCHC(nuCode))
            {
                frm.ShowDialog();
            }
            
        }
    }
}
