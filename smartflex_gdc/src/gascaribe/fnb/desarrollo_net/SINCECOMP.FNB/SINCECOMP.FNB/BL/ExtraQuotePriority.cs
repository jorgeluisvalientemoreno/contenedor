#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : ExtraQuotePriority
 * Descripcion   : Representa la prioridad en cuotas extras.
 * Autor         : Jose Luis Aricapa M.
 * Fecha         : 28-Ago-2013
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 28-Ago-2013  211794  jaricapa       1 - Version Inicial.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.BL
{

    /// <summary>
    /// Representa la prioridad en cuotas extras.
    /// </summary>
    public class ExtraQuotePriority
    {
        //Campos o Atributos
        #region Campos o Atributos
        //Prioridad
        private Int32 prioriry;
                
        //Cuota Extra
        private ExtraQuote extraQuote;

       
        #endregion Campos o Atributos

        //Propiedades
        #region Propiedades

        /// <summary>
        /// Cuota Extra
        /// </summary>
        public ExtraQuote ExtraQuote
        {
            get 
            { 
                return extraQuote; 
            }
            set 
            { 
                extraQuote = value; 
            }
        }

        /// <summary>
        /// Prioridad
        /// </summary>
        public Int32 Prioriry
        {
            get 
            { 
                return prioriry; 
            }
            set 
            { 
                prioriry = value; 
            }
        }

        #endregion Propiedades

        //Constructores
        #region Constructores
        /// <summary>
        /// Constructor de la clase
        /// </summary>
        /// <param name="prioriry">Prioridad</param>
        /// <param name="extraQuote">Cuota Extra</param>
        public ExtraQuotePriority(Int32 prioriry, ExtraQuote extraQuote)
        {
            this.prioriry = prioriry;
            this.extraQuote = extraQuote;
        }
        #endregion Constructores

        //Eventos
        #region Eventos
        #endregion Eventos

        //Métodos
        #region Métodos

        //Públicos
        #region Publicos

        /// <summary>
        /// Compara dos prioridades de cuota extra.
        /// </summary>
        /// <param name="extraQuoteA">Prioridad 1</param>
        /// <param name="extraQuoteB">Prioridad 2</param>
        /// <returns>Si extraQuoteA es mayor = Valor Positivo
        ///          Si extraQuoteA es menor = Valor Negativo
        ///          Si son iguales = 0
        /// </returns>
        private static int Comparer(ExtraQuotePriority extraQuoteA, ExtraQuotePriority extraQuoteB)
        {
            Int32 priorityComp = extraQuoteA.prioriry.CompareTo(extraQuoteB.prioriry);

            if (priorityComp == 0)
            {
                //Prioridades Iguales. Se ordena porque el que tiene mayor cuota
                return extraQuoteB.extraQuote.Quote.CompareTo(extraQuoteA.extraQuote.Quote);
            }
            else
            {
                return priorityComp;
            }
        }

        

        /// <summary>
        /// Permite Ordenar la lista de cuotas extras por prioridad
        /// </summary>
        /// <param name="extraQuoteList">Lista de Cuotas extras con prioridad</param>
        /// <returns>Lista ordenada</returns>
        public static List<ExtraQuotePriority> Sort(List<ExtraQuotePriority> extraQuoteList)
        {
            extraQuoteList.Sort(Comparer);
            return extraQuoteList;
        } 

        #endregion Publicos

        //Privados
        #region Privados
        #endregion Privados

        #endregion Métodos    
      
    }
}
