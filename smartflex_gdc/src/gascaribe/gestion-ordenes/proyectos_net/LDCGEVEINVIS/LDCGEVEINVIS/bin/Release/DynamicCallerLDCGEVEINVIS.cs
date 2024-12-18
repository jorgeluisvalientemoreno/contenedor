#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Gases del Caribe (c).                                                  
 *===========================================================================================================
 * Unidad        : DynamicCallerLDCGEVEINVIS
 * Descripción   : Clase dinámica para registrar en el giras
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor           Modificación                                                          
 * ===========  ======  ============    ======================================================================
 * 07-04-2017   991     eceron          Creación                                        
 * =========================================================================================================*/
#endregion Documentación
using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;

namespace LDCGEVEINVIS
{
    public class DynamicCallerLDCGEVEINVIS : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDCGEVEINVIS form = new LDCGEVEINVIS())
            {
                form.ShowDialog();
            }
        }
    }
}
