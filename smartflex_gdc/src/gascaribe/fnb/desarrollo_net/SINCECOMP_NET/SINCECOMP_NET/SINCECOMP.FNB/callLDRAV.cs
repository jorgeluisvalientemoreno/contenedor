#region Documentaci�n
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : callLDRAV
 * Descripcion   : Llama LDRAV Reimpresi�n de archivo de ventas
 * Autor         : Sincecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificaci�n                                                          
 * ===========  ======  ============   ======================================================================
 * 09-09-2013   SAO212591 vhurtado     1 - Se modifica Execute para que si se llama a nivel de solicitud, tome el
 *                                      n�mero de la solicitud y ejecute as� la reimpresi�n.
*=========================================================================================================*/
#endregion Documentaci�n

using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;
using OpenSystems.Common.Util;


namespace SINCECOMP.FNB
{
    public class callLDRAV : IOpenExecutable
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
                    using (LDRAV frm = new LDRAV(packageId))
                      {
                          frm.ShowDialog();
                      }
                }
            }

            if (!requestLevel)
            {
                using (LDRAV frm = new LDRAV())
                {
                    frm.ShowDialog();
                }
            }
        }
    }
}
