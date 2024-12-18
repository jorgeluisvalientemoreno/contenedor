using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

using KIOSKO.DAL;
using KIOSKO.Entities;

namespace KIOSKO.BL
{
    class BLLDFACTDUP
    {

        public DataTable consultaFacturas(String Procedure, Object[] Values)
        {
            return DALLDFACTDUP.consultaFacturas(Procedure, Values);
        }

        public resp_facturacion consultaFactura(String Procedure, Object[] Values)
        {
            return DALLDFACTDUP.consultaFactura(Procedure, Values);
        }

        public ldfactdup_mensajes consultaMensajes(String Procedure)
        {
            return DALLDFACTDUP.consultaMensajes(Procedure);
        }

        public String ConsultaAlertas(String Procedure, Object[] Values)
        {
            return DALLDFACTDUP.ConsultaAlertas(Procedure, Values);
        }

        public Valida_rp PrValidaAptorp(Int64 inuContrato)
        {
            return DALLDFACTDUP.PrValidaAptorp(inuContrato);
        }

        public  void PrRegGesac(Int64 icontrato, String itelefono)
        {
            DALLDFACTDUP.PrRegGesac(icontrato, itelefono);
        }

        

    }
}
