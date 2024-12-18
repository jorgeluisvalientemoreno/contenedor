using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using LDC_APUSSOTECO.UI;

namespace LDC_APUSSOTECO.Entities
{
    public class GridDetaContrato
    {

        private String codContrato;

        [Browsable(true)]
        [DisplayName("Contrato")]
        public String CodContrato
        {
            get { return codContrato; }
            set { codContrato = value; }
        }


        private Boolean aprobado;

        [Browsable(true)]
        [DisplayName("Aprobado")]
        public Boolean Aprobado
        {
            get { return aprobado; }
            set { aprobado = value; }
        }


        private Boolean rechazado;

        [Browsable(true)]
        [DisplayName("Rechazado")]
        public Boolean Rechazado
        {
            get { return rechazado; }
            set { rechazado = value; }
        }


        private String observacion;

        [Browsable(true)]
        [DisplayName("Observacion")]
        public String Observacion
        {
            get { return observacion; }
            set { observacion = value; }
        }


        public GridDetaContrato()
        {

        }
        
        public const String LIST_ID_KEY = "ITEMID";

        public const String DESCRIPTION_KEY = "DESCRIPTION";

        public const String DESCRIPTION_2 = "DESCRIPTION_2";

        public const String AMOUNT_KEY = "AMOUNT";

        public const String OPTION_KEY = "OPTION";

        
        public GridDetaContrato(GridDetaContrato item)
        {
            this.codContrato = item.CodContrato;

        }


        public GridDetaContrato(DataRow drContratoList)
        {
            this.codContrato = Convert.ToString(drContratoList["contrato"]);

        }


        public GridDetaContrato Clone()
        {
            return new GridDetaContrato(this);
        }
    }
}
