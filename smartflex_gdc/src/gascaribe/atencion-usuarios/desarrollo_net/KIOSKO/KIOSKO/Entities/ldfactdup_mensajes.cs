using System;
using System.Collections.Generic;
using System.Text;

namespace KIOSKO.Entities
{
    public class ldfactdup_mensajes
    {
        private String Etitulo;

        public String titulo
        {
            get { return "► " + Etitulo; }
            set { Etitulo = value; }
        }
        private String Emensaje;

        public String mensaje
        {
            get { return Emensaje; }
            set { Emensaje = value; }
        }

        public ldfactdup_mensajes()
        {
            /*titulo = "";
            mensaje = "";*/
        }
    }
}
