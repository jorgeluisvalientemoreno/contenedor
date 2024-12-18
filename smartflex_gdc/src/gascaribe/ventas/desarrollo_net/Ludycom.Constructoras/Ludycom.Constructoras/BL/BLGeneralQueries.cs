using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.BL
{
    class BLGeneralQueries
    {

        #region IdentificationTypeQuery
        /// <summary>
        /// Aparece en: FCMPC;
        /// Listado de los Tipos de Documentos;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: ge_identifica_type
        /// </summary>
        public static String strIdentificationType = "select to_char(ident_type_id) Codigo, to_char(description) Descripcion from ge_identifica_type";

        #endregion

        #region BuildingTypeQuery
        /// <summary>
        /// Aparece en: FCMPC;
        /// Listado de los Tipos de Construcción;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: ldc_tipo_construccion
        /// </summary>
        public static String strBuildingType = "select to_char(id_tipo_construccion) Codigo, to_char(desc_tipo_construcion) Descripcion from ldc_tipo_construccion";

        #endregion

        #region internalConnTaskType
        public static String strInternalConnTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_RED_INTERNA') ,'|')))";
        #endregion 
 
        #region internalConnItems
        public static String strInternalConnItems = "SELECT G.ITEMS_ID Id, G.DESCRIPTION Description FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G" +
                                                       " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_RED_INTERNA') ,'|')))";
        #endregion 

        #region strSpecialPlan
        public static String strSpecialPlan = "SELECT -1 id, '-------' Description from DUAL UNION ALL SELECT CODCONFPLCO id, DESCRIPTION Description from LDC_CONFPLCO WHERE CONFESTADO = 'A'";
        #endregion 


        #region ChargeByConnTaskType
        public static String strChargeByConnTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CARG_CONEX') ,'|')))";
        #endregion 

        #region ChargeByConnItems
        public static String strChargeByConnItems = "SELECT G.ITEMS_ID Id, G.DESCRIPTION Description FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G" +
                                                       " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CARG_CONEX') ,'|')))";
        #endregion
 
        #region CertificationTaskType
        public static String strCertificationTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CERTIF') ,'|')))";
        #endregion 

        #region CertificationItems
        public static String strCertificationItems = "SELECT G.ITEMS_ID Id, G.DESCRIPTION Description FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G" +
                                                       " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CERTIF') ,'|')))";
        #endregion 

        #region BanksQuery
        public static String strBank = "SELECT banccodi codigo, bancnomb descripcion FROM banco WHERE banctier = 1";

        #endregion

        #region Cycles
        public static String BuilderCycles = "SELECT CICLCODI ID, CICLDESC DESCRIPTION FROM CICLO" +
                                             " WHERE CICLCODI IN(SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('CICLO_CONSTRUCTORAS') ,'|')))";
        #endregion

        #region BuilderActivities
        public static String strBuilderActivities = "SELECT  a.items_id ID, b.description ||'"   +
                                                             "  MODALIDAD['||DECODE(a.pay_modality,1, '1-Antes de Hacer los Trabajos',"+
                                                                                                "2, '2-Al Finalizar los Trabajos'," +
                                                                                                "3, '3-Según Avance de Obra'," +
                                                                                                "4, '4-Sin Cotización')"+
                                                                         "||']    PRODUCTO['"+
                                                                         "||DECODE(a.product_type_id,"+
                                                                         "null, 'N/A',"+
                                                                         "pktblServicio.fsbGetDescription(a.product_type_id))"+
                                                                         "||']' DESCRIPTION "+
                                                                            "FROM    ps_engineering_activ a, ge_items b "+
                                                                            "WHERE   a.items_id = b.items_id "+
                                                                              "AND   a.pay_modality not in (4) "+
                                                                              "AND   a.items_id IN (SELECT TO_NUMBER(COLUMN_VALUE) "+
                                                                              "FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('ACTIV_VTAS_CONSTRUCT'),'|')))";
        #endregion

        #region TenementPrograms
        /// <summary>
        /// Aparece en: FDCPC, FDMPC;
        /// Listado de los programas de vivienda;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: ldc_programas_vivienda
        /// </summary>
        public static String strTenementPrograms = "select prog_viv_id Codigo, descripcion Descripcion from ldc_programas_vivienda ORDER BY Codigo";

        #endregion

        #region UndInstaladoraQuery
        public static String strUndInstaladora = " select opu.operating_unit_id CODIGO, " +
                                                 "  opu.name DESCRIPCION " +
                                                 "  from or_operating_unit opu where opu.unit_type_id in (SELECT TO_NUMBER(COLUMN_VALUE) " +
                                                 "  FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain('LD_OPER_UNIT_INST'),','))) " +
                                                 "  ORDER BY 1";

        #endregion


        #region UndCertificadoraQuery
        public static String strUndCertificadora = "select opu.operating_unit_id CODIGO, " +
                                                    " opu.name DESCRIPCION " +
                                                    " from or_operating_unit opu where opu.unit_type_id in " +
                                                    " (SELECT TO_NUMBER(COLUMN_VALUE) " +
                                                    " FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain('LD_OPER_UNIT_CERT'),','))) " +
                                                    " ORDER BY 1 ";

        #endregion

        #region lstProyectos
        public static String strProyectos = " SELECT ID_PROYECTO CODIGO, NOMBRE DESCRIPCION " +
                                            " FROM ldc_proyecto_constructora " +
                                            " ORDER BY 1";

        #endregion
        public static String dummyUnitWork = "LDC_UNITY_DUMMY_LIST"; //1766
    }
}
