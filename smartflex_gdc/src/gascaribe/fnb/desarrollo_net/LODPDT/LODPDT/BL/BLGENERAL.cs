using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using LODPDT.DAL;
using OpenSystems.Common.ExceptionHandler;

namespace LODPDT.BL
{
    class BLGENERAL
    {

        DALGENERAL general = new DALGENERAL();

        public DataTable getValueList(String Query)
        {
            return general.getValueList(Query);
        }

        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }

        public void executeProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values, out String Valor, out String mensajeE)
        {
            general.executeProcedure(Procedure, numField, Type, Campos, Values, out Valor, out mensajeE);
        }

        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        public String ConsecutivoAgrupador()
        {
            return general.ConsecutivoAgrupador();
        }

    }
}
