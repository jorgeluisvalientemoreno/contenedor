using System;
using System.Collections.Generic;
using System.Text;

namespace KIOSKO.BL
{
    public class BLCONSULTAS
    {

        static String paquetePpal = "LDCI_PKFACTKIOSCO_GDC";

        public static String ConsultadeDatos = paquetePpal + ".PROCONSULTASUSCRIPC";

        public static String ConsultaFactura = paquetePpal + ".progenerafactgdc";

        public static String ConsultaMensajes = paquetePpal + ".mensajesForma";

        public static String AplicacionCargosConsumos = paquetePpal + ".AplicaNETrangosConsumos";

        public static String parametroCosto = "COBRO_POR_DUPLICADO";

        public static String parametroImpresion = "PRINTER_AUTOMATIC_KIOSCO";

        public static String codigoBarra = paquetePpal + ".fsbCaraCodiBarr128GRQ";

    }
}
