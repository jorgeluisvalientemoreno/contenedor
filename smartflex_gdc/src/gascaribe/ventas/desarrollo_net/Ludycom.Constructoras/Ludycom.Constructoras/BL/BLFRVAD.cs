using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.BL
{
    class BLFRVAD
    {

        DALFRVAD dalFRVAD = new DALFRVAD();

        /// <summary>
        /// Método para registrar el valor adicional
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="Value">valor del cupón</param>
        /// <param name="feeType">tipo de cuota adicional</param>
        /// <returns>Retorna el número del cupón generado</returns>   
        public Int64? RegisterAdditionalValue(Int64 project, Double Value, Double Cost, String Comment, Int64? concepto)
        {   
            return dalFRVAD.RegisterAdditionalValue(project, Value, Cost, Comment, concepto);
        }

    }
}
