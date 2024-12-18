using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.BL
{
    class BLLDCMDOINT
    {
        DALDCMDOINT dalDALDCMDOINT = new DALDCMDOINT();

        public DataTable FrfOrdenInternas(Int64 inuProyecto)
        {
            DataTable EOrdenInternas = dalDALDCMDOINT.FrfOrdenInternas(inuProyecto);

            return EOrdenInternas;
        }

        public String funProcesaOrden(Int64? ordenuno, Int64? ordendos)
        {
            return dalDALDCMDOINT.funProcesaOrden(ordenuno, ordendos);
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
