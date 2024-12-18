using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;
using OpenSystems.Common.Util;
using Ludycom.Constructoras.BL;

namespace Ludycom.Constructoras
{
    public class callFDRCC : IOpenExecutable
    {
        public Int64 nuCode = 0;
        public String strLevel;
        BLUtilities utilities = new BLUtilities();
        BLFDMPC blFDMPC = new BLFDMPC();

        public void Execute(Dictionary<string, object> parameters)
        {
            strLevel = string.Empty;

            if (parameters.ContainsKey("NodeLevel"))
            {
                strLevel = OpenConvert.ToString(parameters["NodeLevel"]);
            }

            if (parameters.ContainsKey("NodeId"))
            {
                nuCode = Convert.ToInt64(parameters["NodeId"].ToString());
            }

            if (nuCode > 0 & strLevel.Length>0)
            {
                if (strLevel.Equals(FDRCC.PROJECT_LEVEL))
                {
                    //Se valida si el proyecto existe
                    if (!blFDMPC.ProjectExists(nuCode))
                    {
                        utilities.DisplayErrorMessage("El proyecto con código " + nuCode + " no existe en el sistema");
                        return;
                    }

                    FDRCC.QuotationMode = OperationType.Register;
                }
                else
                {
                    FDRCC.QuotationMode = OperationType.Modification;
                }

                using (FDRCC frm = new FDRCC(nuCode))
                {
                    frm.ShowDialog();
                }
            }
        }
    }
}
