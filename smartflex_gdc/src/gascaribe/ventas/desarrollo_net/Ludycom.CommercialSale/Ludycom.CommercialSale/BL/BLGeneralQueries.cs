using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.CommercialSale.BL
{
    class BLGeneralQueries
    {

        #region IdentificationTypeQuery
        public static String strIdentificationType = "select to_char(ident_type_id) Codigo, to_char(description) Descripcion from ge_identifica_type";

        #endregion

        #region geoFatherLocation
        public static String strGeoFatherLocation = "SELECT ge_geogra_location.geograp_location_id CODIGO, ge_geogra_location.description DESCRIPCION " +
                                                      "FROM ge_geogra_location "+
                                                     "WHERE ge_geogra_location.geog_loca_area_type = ab_boConstants.Fnuobttipoubicaciondpto";
        #endregion

        #region geoLocation
        public static String strGeolocation = "SELECT ge_geogra_location.geograp_location_id CODIGO, ge_geogra_location.description DESCRIPCION " +
                                                "FROM ge_geogra_location " +
                                               "WHERE ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc";
        #endregion

        #region Category
        public static String strCategory = "SELECT CATECODI CODIGO, CATEDESC DESCRIPCION FROM CATEGORI";
        #endregion

        #region Subcategory
        public static String strSubcategory = "SELECT SUCACATE||SUCACODI CODIGO, SUCADESC DESCRIPCION  FROM SUBCATEG WHERE SUCACATE<>-1";
        #endregion

        #region internalConnTaskType
        public static String strInternalConnTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INT_COM_IND') ,'|')))";
        #endregion

        #region internalConnActivities
        public static String strInternalConnActivities = "SELECT G.ITEMS_ID ID_ACTIVIDAD, G.DESCRIPTION ACTIVIDAD, T.TASK_TYPE_ID ID_TIPO_TRABAJO, TT.DESCRIPTION TIPO_TRABAJO, DISCOUNT_CONCEPT FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G, OR_TASK_TYPE TT" +
                                                         " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INT_COM_IND') ,'|'))) " +
                                                         " AND T.TASK_TYPE_ID = TT.TASK_TYPE_ID"+
                                                         " AND G.ITEMS_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_INT_COM_IND') ,'|')))";
        #endregion

        #region ChargeByConnTaskType
        public static String strChargeByConnTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CXC_COM_IND') ,'|')))";
        #endregion

        #region ChargeByConnActivities
        public static String strChargeByConnActivities = "SELECT G.ITEMS_ID ID_ACTIVIDAD, G.DESCRIPTION ACTIVIDAD, T.TASK_TYPE_ID ID_TIPO_TRABAJO, TT.DESCRIPTION TIPO_TRABAJO, DISCOUNT_CONCEPT FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G, OR_TASK_TYPE TT" +
                                                         " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_CXC_COM_IND') ,'|'))) "+
                                                         " AND T.TASK_TYPE_ID = TT.TASK_TYPE_ID" +
                                                         " AND G.ITEMS_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_CXC_COM_IND') ,'|')))";
        #endregion

        #region CertificationTaskType
        public static String strCertificationTaskType = "SELECT T.TASK_TYPE_ID Id, T.DESCRIPTION Description FROM OR_TASK_TYPE T" +
                                                       " WHERE T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INSP_COM_IND') ,'|')))";
        #endregion

        #region CertificationActivities
        public static String strCertificationActivities = "SELECT G.ITEMS_ID ID_ACTIVIDAD, G.DESCRIPTION ACTIVIDAD, T.TASK_TYPE_ID ID_TIPO_TRABAJO, TT.DESCRIPTION TIPO_TRABAJO, DISCOUNT_CONCEPT FROM OR_TASK_TYPES_ITEMS T, GE_ITEMS G, OR_TASK_TYPE TT" +
                                                         " WHERE G.ITEMS_ID = T.ITEMS_ID AND G.ITEM_CLASSIF_ID = 2 AND T.TASK_TYPE_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('TIPO_TRAB_INSP_COM_IND') ,'|'))) " +
                                                         " AND T.TASK_TYPE_ID = TT.TASK_TYPE_ID" +
                                                         " AND G.ITEMS_ID IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('ACT_INSP_COM_IND') ,'|')))";
        #endregion

        #region strSectorOperativo
        public static String strSectorOperativo = "SELECT COMERCIAL_SECTOR_ID CODIGO, DESCRIPTION DESCRIPCION " +
                                                      "FROM LDC_SECTOR_COMERCIAL";
        #endregion

        #region strUnidadOperativa
        public static String strUnidadOperativa = "SELECT OPERATING_UNIT_ID CODIGO, NAME DESCRIPCION "+
                                                   "FROM OR_OPERATING_UNIT WHERE OPERATING_UNIT_ID IN (select To_Number(column_value) " +
                                                              "from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAROPERUNITVENTA'), ',')))";
        #endregion

        /// Metodos para desarrollo del caso 200-1640
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 17-01-2018  Daniel Valiente        1 - creación   
        public static String queryContractors = "LDC_FRFLISTCONTRACTOR";

        public static String queryUnitWork = "LDC_FRFLISTOPERATINGUNITY";

        public static String dummyUnitWork = "LDC_UNITY_DUMMY_LIST"; //1766
    }

}
