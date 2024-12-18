using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;
using Ludycom.Constructoras.BL;
using OpenSystems.Common.Util;

namespace Ludycom.Constructoras
{
    public class callFCUAD : IOpenExecutable
    {
        public Int64 projectId = 0;
        public String strLevel;
        BLUtilities utilities = new BLUtilities();
        BLFDMPC blFDMPC = new BLFDMPC();

        public void Execute(Dictionary<string, object> parameters)
        {
            strLevel = string.Empty;
            strLevel = "PROJECT";

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
                if (strLevel.Equals(FCUAD.PROJECT_LEVEL))
                {
                    //Se valida si el proyecto existe
                    if (!blFDMPC.ProjectExists(projectId))
                    {
                        utilities.DisplayErrorMessage("El proyecto con código " + projectId + " no existe en el sistema");
                        return;
                    }

                    //Se valida que el proyecto tenga venta registrada
                    if (!blFDMPC.ProjectHasSale(projectId))
                    {
                        utilities.DisplayErrorMessage("El proyecto con código " + projectId + " aún no tiene venta registrada");
                        return;
                    }

                    using (FCUAD frm = new FCUAD(projectId))
                    {
                        frm.ShowDialog();
                    }
                }
                else
                {
                    utilities.DisplayErrorMessage("Sólo se puede acceder a la pantalla, a nivel de proyecto");
                }
            }
        }
    }
}
