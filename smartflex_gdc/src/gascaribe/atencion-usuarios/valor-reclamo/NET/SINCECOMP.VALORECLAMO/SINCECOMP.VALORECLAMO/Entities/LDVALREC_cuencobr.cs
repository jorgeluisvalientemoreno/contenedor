using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.VALORECLAMO.Entities
{
    public class LDVALREC_cuencobr
    {
        private String Ecuenta;

        //columna 1
        [DisplayName("Cuenta de Cobro")]
        public String cuenta
        {
            get { return Ecuenta; }
            set { Ecuenta = value; }
        }

        private String Emes;

        //columna 1
        [DisplayName("Mes")]
        public String mes
        {
            get { return Emes; }
            set { Emes = value; }
        }
    }
}
