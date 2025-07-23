using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

//librerias 
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using CONTROLDESARROLLO.DAL;

namespace CONTROLDESARROLLO.BL
{
    class BLGENERAL
    {
        DAGENERAL general = new DAGENERAL();

        public DataTable SQLGeneral(String Query)
        {
            return general.SQLGeneral(Query);
        }

        public String FsbEstructuraFuncion(String CbxEsquema, String TbxNombre, String CbxTipo, DataGridView DgvVariables, String sbAplicaPaquete)
        {
            return general.FsbEstructuraFuncion(CbxEsquema, TbxNombre, CbxTipo, DgvVariables, sbAplicaPaquete);
        }

        public String FsbEstructuraProcedimiento(String CbxEsquema, String TbxNombre, DataGridView DgvVariables, String sbAplicaPaquete)
        {
            return general.FsbEstructuraProcedimiento(CbxEsquema, TbxNombre, DgvVariables, sbAplicaPaquete);
        }

    }
}
