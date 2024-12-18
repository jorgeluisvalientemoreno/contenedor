using System;
using System.Collections.Generic;
using System.Text;

using Ludycom.Constructoras.DAL;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.BL
{
    class BLFGCPCM
    {
        DALFGCPCM general = new DALFGCPCM();

        public DataSet consultaCupones(String Procedure, Object[] Values)
        {
            return general.consultaCupones(Procedure, Values);
        }

        public Int64? GenerateCupon(Int64 project, Int64 consecutivo)
        {
            return general.GenerateCupon(project, consecutivo);
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        public void executeMethod(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            general.executeMethod(Procedure, numField, Type, Campos, Values);
        }


        //Manejo de Mensajes
        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        public void raiseERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.Raise(2741, msj);
        }

        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        public void messageErrorException(Exception mesagge)
        {
            GlobalExceptionProcessing.ShowErrorException(mesagge);
        }

    }
}
