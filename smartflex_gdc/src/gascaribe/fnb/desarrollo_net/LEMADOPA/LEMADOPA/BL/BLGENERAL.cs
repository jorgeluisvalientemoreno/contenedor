using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.ExceptionHandler;
using System.Data;
//LIBRERIAS DEL PROYECTO
using LEMADOPA.DAL;

namespace LEMADOPA.BL
{
    class BLGENERAL
    {

        DALGENERAL general = new DALGENERAL();

        //MENSAJES DE ALERTA
        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }
        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }
        public void messageErrorException(Exception mesagge)
        {
            GlobalExceptionProcessing.ShowErrorException(mesagge);
        }
        //

        //CURSORES
        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }
        public DataTable getValueList(String Query)
        {
            return general.getValueList(Query);

        }
        //

        //FUNCIONES
        public Object valueReturn(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values, String TypeReturn)
        {
            return general.valueReturn(Procedure, numField, Type, Campos, Values, TypeReturn);
        }
        //

        public void doCommit()
        {
            general.doCommit();
        }

        //Incio CASO 200-1880
        //Servicio para obtener la clasificacion de la causal con la que se legalizara la OT entrega documento de PU
        public static Int64 BLFnuValidaCausal(Int64 InuCausal)
        {
            return DALGENERAL.DALFnuValidaCausal(InuCausal);
        }
        //Fin CASO 200-1880


    }
}
