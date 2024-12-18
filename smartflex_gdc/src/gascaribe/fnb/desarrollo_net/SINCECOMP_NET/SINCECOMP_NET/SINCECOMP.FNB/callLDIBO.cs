using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.UI;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Util;

namespace SINCECOMP.FNB
{
 
        public class callLDIBO : IOpenExecutable
        {
            public void Execute(Dictionary<string, object> parameters)
            {
                Boolean requestLevel = false;
                if (parameters.ContainsKey("NodeLevel"))
                {
                    String nodeLevel = OpenConvert.ToString(parameters["NodeLevel"]);
                    Int64 nodeId = 0;
                    Int64 packageId = 0;
                    if (parameters.ContainsKey("NodeId"))
                    {
                        nodeId = OpenConvert.ToLong(parameters["NodeId"]);
                    }
                    if ("REQUEST".Equals(nodeLevel))
                    {
                        requestLevel = true;
                        packageId = nodeId;
                        using (LDIBO frm = new LDIBO(packageId))
                        {
                            frm.ShowDialog();
                        }
                    }
                }

                if (!requestLevel)
                {
                    using (LDIBO frm = new LDIBO())
                    {
                        frm.ShowDialog();
                    }
                }
            }
        }

}
