using System;
using System.Collections.Generic;
using System.Text;

//CASO 415
using System.ComponentModel;

namespace TARIFATRANSITORIA.Entity
{
    public class ResumenDetalle
    {

        //Concepto - 
        private String Econcepto;
        [DisplayName("Concepto")]
        public String concepto
        {
            get { return Econcepto; }
            set { Econcepto = value; }
        }

        //Valor - 
        private Double Evalornota;
        [DisplayName("Valor")]
        public Double valornota
        {
            get { return Evalornota; }
            set { Evalornota = value; }
        }

    }
}
