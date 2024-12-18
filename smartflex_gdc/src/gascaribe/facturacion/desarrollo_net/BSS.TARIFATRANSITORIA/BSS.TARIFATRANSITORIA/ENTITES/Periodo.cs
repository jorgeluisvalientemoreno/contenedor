using System;
using System.Collections.Generic;
using System.Text;

//Libreria OPEN
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace BSS.TARIFATRANSITORIA.ENTITES
{
    class Periodo
    {

        //columna A
        private String EAnno;
        [DisplayName("Año")]
        public String anno
        {
            get { return EAnno; }
            set { EAnno = value; }
        }

        //columna B
        private String EMes;
        [DisplayName("Periodo")]
        public String mes
        {
            get { return EMes; }
            set { EMes = value; }
        }

        //columna C
        private Int64 EM3;
        [DisplayName("M3")]
        public Int64 m3
        {
            get { return EM3; }
            set { EM3 = value; }
        }

    }
}
