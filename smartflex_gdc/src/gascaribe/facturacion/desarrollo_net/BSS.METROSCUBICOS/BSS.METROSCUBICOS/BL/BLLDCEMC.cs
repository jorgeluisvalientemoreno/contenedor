using System;
using System.Collections.Generic;
using System.Text;

//Libreria OPEN
using System.Data;
using BSS.METROSCUBICOS.DAL;

namespace BSS.METROSCUBICOS.BL
{
    class BLLDCEMC
    {
        DALLDCEMC general = new DALLDCEMC();

        //Servicio para ejecutar servicios y retornar DATA de cursor 
        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }

        //Servicio para ejecutar servicios tipo procedimiento
        public void executeService(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            general.executeService(Procedure, numField, Type, Campos, Values);
        }
    }
}
