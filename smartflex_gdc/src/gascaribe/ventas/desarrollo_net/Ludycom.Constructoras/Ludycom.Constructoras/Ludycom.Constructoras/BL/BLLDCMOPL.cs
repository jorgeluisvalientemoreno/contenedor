using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.BL
{
    class BLLDCMOPL
    {
        DALDCMOPL dalLDCMOPL = new DALDCMOPL();

        public List<ListadoInternas> FrfOrdenInternas(Int64 inuProyecto)
        {
            List<ListadoInternas> EOrdenInternas = dalLDCMOPL.FrfOrdenInternas(inuProyecto);

            return EOrdenInternas;
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
