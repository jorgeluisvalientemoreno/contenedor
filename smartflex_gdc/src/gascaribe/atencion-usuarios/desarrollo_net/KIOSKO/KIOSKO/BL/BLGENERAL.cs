using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.ExceptionHandler;
using KIOSKO.DAL;

namespace KIOSKO.BL
{
    class BLGENERAL
    {

        DAL.DALGENERAL general = new DAL.DALGENERAL();

        /// <summary>
        /// Metodo para obtener valores de un Parametro
        /// </summary>
        /// <param name="sbParam">Descripcion del parametro</param>
        /// <param name="tipo">Tipo de valor que Debe buscar</param>
        /// <returns>Valor del Parametro solicitado (Double)</returns>
        public Object getParam(String sbParam, String tipo)
        {
            Object valor = general.getParam(sbParam, tipo);
            if (!string.IsNullOrEmpty(valor.ToString()))
                return valor;
            else
            {
                mensajeERROR("El Parámetro: " + sbParam + ", no se encuentra configurado. Favor validar.");
                return valor;
            }
        }

        /// <summary>
        /// Devuelve un cursor con los datos de una funcion especifica
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <returns></returns>
        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve los valores de Salida
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="State">estado del Parametro In/Out</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <returns>Cursor con la funcion ejecutada (DataTable)</returns>
        public Object[] objetosProcedure(String Procedure, int numField, String[] Type, String[] State, String[] Campos, Object[] Values)
        {
            return general.objetosProcedure(Procedure, numField, Type, State, Campos, Values);
        }

        /// <summary>
        /// Mensajes de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }
        
        /// <summary>
        /// Mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve un valor con el dato Solicitado
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <param name="TypeReturn">Tipo de Valor que sera devuelto</param>
        /// <returns>Devuelve el valor enviado por la Funcion (Object)</returns>
        public Object valueReturn(String Procedure, int numField, String[] Type, String[] Campos, String[] Values, String TypeReturn)
        {
            return general.valueReturn(Procedure, numField, Type, Campos, Values, TypeReturn);
        }
        

    }
}
