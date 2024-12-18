using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace LDCAPLAC.Entities
{
    public class ComboCostList
    {

        private String codigo;

        [Browsable(true)]
        [DisplayName("Codigo")]
        public String Codigo
        {
            get { return codigo; }
            set { codigo = value; }
        }

        private String codigolist;

        [Browsable(true)]
        [DisplayName("Codigo")]
        public String Codigolist
        {
            get { return codigolist; }
            set { codigolist = value; }
        }


        private String description;

        [Browsable(true)]
        [DisplayName("Description")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }


        public const String LIST_ID_KEY = "CODIGO";

        public const String LIST_DESCRIPTION_KEY = "CODIGOLIST";

        public const String LIST_DESCRIPTION_2 = "Description";

        public const String UND_OPERATIVA = "UNDOPERATIVA";

        public const String CONTRATISTA = "CONTRATISTA";

        public const String CONTRATO = "CONTRATO";

        public const String LOCALIDAD = "LOCALIDAD";

        public const String START_DATE = "FECHAINICIAL";

        public const String FINAL_DATE = "FECHAFINAL";

        public ComboCostList(DataRow drCostList)
        {
            this.Codigo = Convert.ToString(drCostList["codigo"]); // 'codigo' es el nombre del campo de la consulta del cursor
            this.Description = Convert.ToString(drCostList["Descripcion"]);
            this.Codigolist = Convert.ToString(this.Codigo);
        }

        public ComboCostList() { }


    }
}
