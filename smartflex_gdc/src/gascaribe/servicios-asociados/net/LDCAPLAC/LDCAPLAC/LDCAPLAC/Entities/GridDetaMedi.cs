using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using LDCAPLAC.UI;

namespace LDCAPLAC.Entities
{
    public class GridDetaMedi
    {

        private String codMedidor;

        [Browsable(true)]
        [DisplayName("Serial Medidor")]
        public String CodMedidor
        {
            get { return codMedidor; }
            set { codMedidor = value; }
        }


        private String direccion;

        [Browsable(true)]
        [DisplayName("Dirección")]
        public String Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }


        private String contrato;

        [Browsable(true)]
        [DisplayName("Contrato")]
        public String Contrato  
        {
            get { return contrato; }
            set { contrato = value; }
        }


        private Boolean aplipro;

        [Browsable(true)]
        [DisplayName("Aplica Prorrateo")]
        public Boolean Aplipro
        {
            get { return aplipro; }
            set { aplipro = value; }
        }

        private String estadocorte;

        [Browsable(true)]
        [DisplayName("Estado Corte")]
        public String Estadocorte
        {
            get { return estadocorte; }
            set { estadocorte = value; }
        }

        private Int64 codigoEstadoCorte;

        [Browsable(true)]
        [DisplayName("Codigo Estado Corte")]
        public Int64 CodigoEstadoCorte
        {
            get { return codigoEstadoCorte; }
            set { codigoEstadoCorte = value; }
        }

        public GridDetaMedi()
        {

        }
        
        public const String LIST_ID_KEY = "ITEMID";

        public const String DESCRIPTION_KEY = "DESCRIPTION";

        public const String DESCRIPTION_2 = "DESCRIPTION_2";

        public const String AMOUNT_KEY = "AMOUNT";

        public const String OPTION_KEY = "OPTION";

        
        public GridDetaMedi(GridDetaMedi item)
        {
            this.codMedidor = item.CodMedidor;
            this.contrato = item.Contrato;
            this.direccion = item.Direccion;

        }

        
        public GridDetaMedi(DataRow drMedidorList)
        {
            this.codMedidor = Convert.ToString(drMedidorList["medidor"]);
            this.contrato = Convert.ToString(drMedidorList["contrato"]);
            this.direccion = Convert.ToString(drMedidorList["direccion"]);
            this.estadocorte = Convert.ToString(drMedidorList["estado_corte"]);
            this.codigoEstadoCorte = Convert.ToInt64(drMedidorList["codigo_estado_corte"]);
        }


        public GridDetaMedi Clone()
        {
            return new GridDetaMedi(this);
        }
    }
}
