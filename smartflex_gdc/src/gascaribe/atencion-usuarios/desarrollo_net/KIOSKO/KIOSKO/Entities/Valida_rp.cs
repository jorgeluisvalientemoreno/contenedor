using System;
using System.Collections.Generic;
using System.Text;

namespace KIOSKO.Entities
{
    public class Valida_rp
    {
        private Int64 Iresultado;

        public Int64 resultado
        {
            get { return  Iresultado; }
            set { Iresultado = value; }
        }
        private DateTime Ifechamax;

        public DateTime fechamax
        {
            get { return Ifechamax; }
            set { Ifechamax = value; }
        }

        public Valida_rp()
        {
            
        }

    }
}
