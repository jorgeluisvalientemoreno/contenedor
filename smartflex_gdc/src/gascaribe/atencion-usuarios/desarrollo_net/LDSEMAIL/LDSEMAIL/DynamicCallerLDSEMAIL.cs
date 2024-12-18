#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Gases del Caribe (c).                                                  
 *===========================================================================================================
 * Unidad        : LDSEMAIL
 * Descripción   : Ejecutable encargado de enviar los cupones por correo
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ============    ======================================================================
 * 23-09-2020   505     Horbath          Creación                                        
 * =========================================================================================================*/
#endregion Documentación
using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;

namespace LDSEMAIL
{
    public class DynamicCallerLDSEMAIL : IOpenExecutable
    {        
        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 nuContractId = Convert.ToInt64(parameters["NodeId"].ToString());
            using (LDSEMAIL form = new LDSEMAIL(nuContractId))
            {
                form.ShowDialog();
            }
        }
    }
}
