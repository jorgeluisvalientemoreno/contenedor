using System;
using System.Collections.Generic;
using System.Text;


//CASO 415
using System.Data;
using TARIFATRANSITORIA.DAL;

namespace TARIFATRANSITORIA.BL
{
    class BLLDCGCTT
    {
        DALLDCGCTT general = new DALLDCGCTT();

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

        public void PRGENTRAMCANTT(Int64 inuProducto, Int64 inuMedioRecep, String isObservacion, Double inuCliente, DateTime idtFecha, out Int64 OnuPackage_id, out  Int64 onuError, out  String osbError)
        {
            general.PRGENTRAMCANTT(inuProducto, inuMedioRecep, isObservacion, inuCliente, idtFecha, out OnuPackage_id, out  onuError, out  osbError);
        }

    }
}
