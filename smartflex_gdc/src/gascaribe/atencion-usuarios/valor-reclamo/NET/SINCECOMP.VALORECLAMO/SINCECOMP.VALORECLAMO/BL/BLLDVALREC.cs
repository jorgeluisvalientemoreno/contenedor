using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.VALORECLAMO.DAL;
using SINCECOMP.VALORECLAMO.Entities;

namespace SINCECOMP.VALORECLAMO.BL
{
    internal class BLLDVALREC
    {

        DALLDVALREC _DALLDVALREC = new DALLDVALREC();

        public dataLDVALREC getSubscriptionData(Int64 subcription)
        {
            return _DALLDVALREC.getSubscriptionData(subcription);
        }

        public Int64 getContract(String factura)
        {
            return _DALLDVALREC.getContract(factura);
        }

        public Int64 RegisterXML(String XML)
        {
            return _DALLDVALREC.RegisterXML(XML);
        }

        public Int64 SolicitudInteraccion(Int64 Solicitud)
        {
            return _DALLDVALREC.SolicitudInteraccion(Solicitud);
        }

        public void doCommit()
        {
            _DALLDVALREC.doCommit();
        }

    }
}
