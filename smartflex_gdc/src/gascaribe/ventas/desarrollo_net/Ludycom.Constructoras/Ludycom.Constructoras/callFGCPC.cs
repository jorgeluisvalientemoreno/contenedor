﻿using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using Ludycom.Constructoras;
using Ludycom.Constructoras.UI;
using OpenSystems.Common.Util;
using Ludycom.Constructoras.BL;

namespace Ludycom.Constructoras
{
    public class callFGCPC : IOpenExecutable
    {
        private Int64 projectId = 0;
        private String strLevel;
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

                    //Se valida la forma de pago establecida para el proyecto
                    if (blFDMPC.GetPaymentModality(projectId) != "CU")
                    {
                        utilities.DisplayErrorMessage("Para el proyecto con código " + projectId + " no se definió la forma de pagos por Cuotas");
                        return;
                    }

                    using (FGCPC frm = new FGCPC(projectId))
                    {
                        frm.ShowDialog();
                    }
                }
            }
        }
    }
}