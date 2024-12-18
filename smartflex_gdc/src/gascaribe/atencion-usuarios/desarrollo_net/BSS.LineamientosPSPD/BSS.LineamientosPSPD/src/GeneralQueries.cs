using System;
using System.Collections.Generic;
using System.Text;

namespace BSS.LineamientosPSPD.src
{
    class GeneralQueries
    {
        #region Tipo cargue

        public static String strTipoCargue = string.Join(string.Empty, new string[]{
                " SELECT null Codigo from dual ",
                " union ",
                " SELECT TRIM(column_value) Codigo ",
                "   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('LDC_PARTIPOCARGUE',NULL),',')) ",
                " order by Codigo desc "});

        #endregion

        #region Origen cargue

        public static String strOrigenCargue = string.Join(string.Empty, new string[]{
                " SELECT null Codigo from dual ",
                " union ",
                " SELECT TRIM(column_value) Codigo ",
                "   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('LDC_PARORIGENCARGUE',NULL),',')) ",
                " order by Codigo desc "});

        #endregion

        #region Documento Soporte

        public static String strDocSoporte = string.Join(string.Empty, new string[]{
                " SELECT null Codigo from dual ",
                " union ",
                " SELECT RESOLUCION ||' - '|| INI_VIGENCIA ||' - '|| ENTIDAD Codigo ",
                "   FROM LDC_RESOGURE ",
                " order by Codigo desc "});

        #endregion

        #region Motivo inclusion

        public static String strMotivInclusion = string.Join(string.Empty, new string[]{
                " SELECT null Codigo from dual ",
                " union ",
                " SELECT TRIM(column_value) Codigo ",
                "   FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('LDC_PARMOTIVOINCLU',NULL),',')) ",
                " order by Codigo desc "});

        #endregion
    }
}
