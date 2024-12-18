using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras
{
    public class callFDCPC : IOpenExecutable
    {
        public Int64 customerId = 0;
        public String strLevel;

        public void Execute(Dictionary<string, object> parameters)
        {
            strLevel = string.Empty;

            if (parameters.ContainsKey("NodeLevel"))
            {
                strLevel = OpenConvert.ToString(parameters["NodeLevel"]);
            }

            if (parameters.ContainsKey("NodeId"))
            {
                customerId = Convert.ToInt64(parameters["NodeId"].ToString());
            }

            if (customerId > 0)
            {
                if (strLevel.Equals(FDCPC.CUSTOMER_LEVEL))
                {
                    using (FDCPC frm = new FDCPC(customerId))
                    {
                        frm.ShowDialog();
                    }
                }
            }  
        }
    }
}