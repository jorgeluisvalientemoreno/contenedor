#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Gases del Caribe (c).                                                  
 *===========================================================================================================
 * Unidad        : DynamicCallerLDCGALOM
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

namespace LDCGALOM
{
    public class callLDCGALOM : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDCGALOM form = new LDCGALOM())
            {
                form.ShowDialog();
            }
        }
    }
}
