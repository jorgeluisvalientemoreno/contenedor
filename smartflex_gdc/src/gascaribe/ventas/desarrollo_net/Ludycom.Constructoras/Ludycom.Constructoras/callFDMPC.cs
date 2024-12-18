using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras
{
    public class callFDMPC : IOpenExecutable
    {
        public Int64 projectId = 0;
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
                projectId = Convert.ToInt64(parameters["NodeId"].ToString());
            }

            if (projectId > 0)
            {
                if (strLevel.Equals(FDMPC.PROJECT_LEVEL))
                {
                    using (FDMPC frm = new FDMPC(projectId))
                    {
                        frm.Text = frm.Text + " [Proyecto: " + projectId + "]";
                        frm.ShowDialog();
                    }
                }
            }
        }
    }
}
