using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using SINCECOMP.VALORECLAMO.DAL;

namespace SINCECOMP.VALORECLAMO.BL
{
    class BLLDCAVR
    {
        DALLDCAVR general = new DALLDCAVR();

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

        public void prApplyValorReclamo(Int64 InuTipo, Int64 InuSolicitud, String IsbComentario, Int64 Inureclamosid, Double Inuvalorreclamo, out Int64 OnuErrorCode, out  String OsbErrorMessage)
        {
            general.prApplyValorReclamo(InuTipo, InuSolicitud, IsbComentario, Inureclamosid, Inuvalorreclamo, out OnuErrorCode, out  OsbErrorMessage);
        }
 

    }
}
