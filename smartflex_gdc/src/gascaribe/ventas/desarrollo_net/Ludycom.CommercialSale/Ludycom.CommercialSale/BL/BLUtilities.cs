using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.CommercialSale.DAL;
using System.Data;

namespace Ludycom.CommercialSale.BL
{
    class BLUtilities
    {
        DALUtilities utilities = new DALUtilities();

        /// <summary>
        /// Se obtiene el resultado de una consulta para llenar un OpenCombo
        /// </summary>
        /// <param name="query">Consulta para obtener los datos necesarios para la LOV</param>
        /// <returns>Cursor con el resultado de la consulta(DataTable)</returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public DataTable getListOfValue(String query)
        {
            return utilities.GetListOfValue(query);
        }

        /// <summary>
        /// Se valida si el atributo se encuentra en la instancia
        /// </summary>
        /// <param name="instance">Nombre de la instancia</param>
        /// <param name="group">Nombre del grupo</param>
        /// <param name="entity">Nombre de la entidad</param>
        /// <param name="attribute">Nombre del atributo</param>
        /// <returns>Retorna un booleano indicando si el atributo está instanciado</returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public Boolean IsAttributeInInstance(String instance, String group, String entity, String attribute)
        {
            return utilities.IsAttributeInInstance(instance, group, entity, attribute);
        }

        /// <summary>
        /// Obtiene el valor del atributo instanciado
        /// </summary>
        /// <param name="instance">Nombre de la instancia</param>
        /// <param name="group">Nombre del grupo</param>
        /// <param name="entity">Nombre de la entidad</param>
        /// <param name="attribute">Nombre del atributo</param>
        /// <returns>Retorna el valor del atributo</returns>
        public String GetAttributeValue(String instance, String group, String entity, String attribute)
        {
            return utilities.GetAttributeValue(instance, group, entity, attribute);
        }

        /// <summary>
        /// Despliega mensaje de error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayErrorMessage(String mesagge)
        {
            utilities.DisplayErrorMessage(mesagge);
        }

        /// <summary>
        /// Elevar Mensaje de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void RaiseERROR(String mesagge)
        {
            utilities.RaiseERROR(mesagge);
        }

        /// <summary>
        /// Despliega mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayInfoMessage(String mesagge)
        {
            utilities.DisplayInfoMessage(mesagge);
        }

        /// <summary>
        /// Obtiene el valor de un parámetro en LD_PARAMETER
        /// </summary>
        /// <param name="parameterName">Nombre del parámetro</param>
        /// <param name="parameterType">Tipo del valor del parámetro</param>
        /// <returns>Valor del Parametro (Object: puede ser de tipo Cadena o Numérico)</returns>
        public Object getParameterValue(String parameterName, String parameterType)
        {
            Object valor = utilities.getParameterValue(parameterName, parameterType);

            if (!string.IsNullOrEmpty(Convert.ToString(valor)))
                return valor;
            else
            {
                utilities.DisplayErrorMessage("El Parámetro: " + parameterName + ", no se encuentra configurado. Por favor validar.");
                return valor;
            }
        }

        /// <summary>
        /// Verifica si la ruta es válida
        /// </summary>
        /// <param name="path">Ruta</param>
        /// <returns>Retorna un valor booleando indicando si la ruta es válida</returns>
        public Boolean IsvalidPath(String path)
        {
            if (path.Trim().ToString() == "")
            {
                utilities.DisplayErrorMessage("No ha indicado una Ruta Válida");
                return false;
            }
            return true;
        }

        /// <summary>
        /// Hace Commit en la BD
        /// </summary>
        public void doCommit()
        {
            utilities.doCommit();
        }

        /// <summary>
        /// Hace Rollback en la BD
        /// </summary>
        public void doRollback()
        {
            utilities.doRollback();
        }
    }
}
