using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.BL
{
   class BLConsultas
   {
      #region A

      /// <summary>
      /// Aparece en: ldoa;
      /// Aprobacion de ordenes de venta
      /// </summary>
      public static String AprovedOrderSale = "LD_BOPORTAFOLIO.PROAPPROVESALEORDER";

      /// <summary>
      /// Aparece en: ldoa;
      /// CURSOR PARA RETORNAR LA LISTA DE ARTICULOS POR ORDENES
      /// </summary>
      public static String articleorderldoa = "LD_BOPORTAFOLIO.frfGetArticleOrder";

      /// <summary>
      /// Aparece en: ctrlGEC;
      /// Listado de todos los Articulos para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_article
      /// </summary>
      public static String Articulos = "select article_id Codigo, description Descripcion " +
          "from ld_article ";

      /// <summary>
      /// Aparece en: ctrlGEPPB, ctrlGEPPB;
      /// Consultas de todos los Articulos Aprobados para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_article;
      /// Observación: Diseñada para asignarle la condicion de el articulo asociado
      /// </summary>
      public static String ArticulosControlados = "select article_id Codigo, description Descripcion " +
          "From ld_article " +
          "Where price_control='Y' and Approved='Y' and Active='Y' ";

      #endregion

      #region C

      /// <summary>
      /// Aparece en: ctrlGEC, ctrlGEPPB, FIACE;
      /// Listado de los Canales de Venta para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: GE_RECEPTION_TYPE
      /// </summary>
      public static String CanalesdeVenta = "select reception_type_id Codigo, description Descripcion " +
          "from GE_RECEPTION_TYPE " +
          "WHERE REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('SALES_CHANNEL_FNB'), '(\\W|^)'|| reception_type_id ||'(\\W|$)') > 0 " +
          "Order By reception_type_id";

      /// <summary>
      /// Aparece en: FIACE;
      /// Listado de las Categorias para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: Categori
      /// </summary>
      public static String Categoria = "Select Catecodi Codigo, Catedesc Descripcion from Categori Where Catecodi != -1 Order by Catecodi";

      /// <summary>
      /// Aparece en: fnbcr;
      /// Listado de las Causales para Combos;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: cc_causal
      /// </summary>
      public static String CausalesDevolucionAnulacion = "select causal_id Codigo, description Descripcion from cc_causal order by causal_id";

      /// <summary>
      /// Aparece en: FIFAP;
      /// Listado de los diferentes Estados Civiles;
      /// Devuelve ID, DESCRIPCION
      /// Tablas: ge_civil_state
      /// </summary>
      /// 08-10-2014 KCienfuegos.NC2856
      public static String CivilState = "select civil_state_id id, description descripcion from ge_civil_state where civil_state_id<>-1";

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Listado de todos los Conceptos para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: concepto
      /// </summary>
      public static String Concepto = "Select Conccodi Codigo, Concdesc Descripcion " +
          "from concepto " +
          "Order by Conccodi";

      /// <summary>
      /// Aparece en: ctrlGEC;
      /// Listado de los Contratistas para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ge_contratista, or_operating_unit
      /// </summary>
      public static String Contratista = "SELECT /*+    use_nl(or_operating_unit ge_contratista) "+
          " index(or_operating_unit IX_OR_OPERATING_UNIT16) " +
          " index(or_operating_unit IDX_OR_OPERATING_UNIT10) " +
          " index(ge_contratista PK_GE_CONTRATISTA) */ "+
          "  distinct g.id_contratista Codigo,g.nombre_contratista Descripcion " +
          "FROM ge_contratista g, or_operating_unit o " +
          "WHERE o.oper_unit_classif_id = Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB') and g.id_contratista = o.contractor_id " +
          "order by g.id_contratista";

      /// <summary>
      /// Aparece en GELPPB;
      /// genera las copias de listas de precios apartir de la definida
      /// </summary>
      public static String copyList = "LD_BOPortafolio.bocopylist";

      #endregion

      #region D

      /// <summary>
      /// Aparece en: GEPBR;
      /// metodo para eliminar articulos
      /// </summary>
      public static String deleteArticle = "ld_boportafolio.DeleteArticle";

      /// <summary>
      /// Aparece en: GEC;
      /// metodo para eliminar comisiones
      /// </summary>
      public static String deleteComision = "ld_boportafolio.DeleteCommission";

      /// <summary>
      /// Aparece en: GEPPB;
      /// METODO PARA ELIMINAR DETALLES DE LISTA DE PRECIOS
      /// </summary>
      public static String deleteDetailPriceList = "ld_boportafolio.DeletePriceListDetail";

      /// <summary>
      /// Aparece en: GEPPB;
      /// metodo para eliminar listas de precios
      /// </summary>
      public static String deletePriceList = "ld_boportafolio.DeletePriceList";

      /// <summary>
      /// Aparece en: GEPBR;
      /// metodo para eliminar propiedades asociadas a un Articulo
      /// </summary>
      public static String deletePropertyArticle = "ld_boportafolio.DeletePropert_by_article";

      /// <summary>
      /// Aparece en: LDAPR;
      /// metodo para eliminar propiedades por articulo
      /// </summary>
      public static String deletePropertybyArticle = "ld_boportafolio.DeleteLD_Property";

      #endregion

      #region E

      public static String editPrommisory = "LDC_PKVENTAPAGOUNICO.EditPromissoryPUData";

      #endregion

      #region F

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Listado de los Financiadores para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: servicio
      /// </summary>
      public static String Financiador = "SELECT Servcodi Codigo, Servdesc Descripcion " +
          "FROM servicio " +
          "WHERE Regexp_instr(dald_parameter.fsbGetValue_Chain('COD_SERFINBRILLA'), Lpad(servcodi, 4, '0')) > 0 " +
          "Order by Servcodi";

      #endregion

      #region L

      /// <summary>
      /// Aparece en: ctrlGEC, FIACE;
      /// Listado de todas las Lineas Aprobadas para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_line
      /// </summary>
      public static String LineasControladas = "Select Line_id Codigo, Description Descripcion " +
          "from ld_line " +
          "where approved = 'Y' " +
          "Order By Line_id";

      /// <summary>
      /// Aparece en: ctrlGELPPB, ctrlGEPLPB;
      /// Listado de Lista de Precios Aprobadas para Combos;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_price_list;
      /// Observación: Diseñada para asignarle la condicion de la lista de precios asociada
      /// </summary>
      public static String ListadePreciosControladasC = "select a.price_list_id Codigo, a.description Descripcion " +
          "from ld_price_list a " +
          "where a.approved = 'Y' ";

      /// <summary>
      /// Aparece en: LDOA;
      /// Liatdo de Causlaes de decolucion en grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: cc_causal
      /// </summary>
      public static String ListadoCausal = "SELECT c.causal_id CODIGO, c.description DESCRIPCION FROM cc_causal c" +
         //public static String ListadoCausal = "SELECT c.causal_id CODIGO, c.description DESCRIPCION FROM cc_causal c" +
          " where c.causal_type_id = dald_parameter.fnuGetNumeric_Value('CAUS_TYPE_ORDER_APPROV')";//"SELECT to_char(c.causal_id) CODIGO, c.description DESCRIPCION FROM cc_causal c";

      /// <summary>
      /// Aparece en: FNBCR;
      /// Liatdo de Causlaes de decolucion en grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: cc_causal
      /// </summary>
      public static String ListadoCausalAD = "SELECT c.causal_id CODIGO, c.description DESCRIPCION FROM cc_causal c";

      /// <summary>
      /// Aparece en: ctrlGEPLPB;
      /// Listado de Contratistas para Combos;
      /// Devuelve: Identificacion, Nombre;
      /// Tablas: ge_contratista, or_operating_unit
      /// </summary>
      public static String ListadoContratistasC = "SELECT distinct g.id_contratista Identificacion, g.nombre_contratista Nombre " +
          "FROM ge_contratista g, or_operating_unit o " +
          "WHERE o.oper_unit_classif_id = Dald_parameter.fnuGetNumeric_Value('SUPPLIER_FNB') and " +
          "o.contractor_id = g.id_contratista " +
          "order by g.id_contratista";


      /// <summary>
      /// Aparece en: FIACE;
      /// Listado de todas las sublineas Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: Categori
      /// </summary>
      public static String ListadoSublineas = "Select Subline_id Codigo, Description Descripcion from ld_subline";

      /// <summary>
      /// Aparece en: FIACS;
      /// Listado de las ubicaciones geograficas con la descripcion del padre;
      /// Devuelve Codigo, Descripcion, padre;
      /// Tablas: GE_GEOGRA_LOCATION
      /// </summary>
      public static String ListadoUbicacionGeoPadre = "SELECT GEOGRAP_LOCATION_ID CODIGO, DESCRIPTION DESCRIPCION," +
          " CASE WHEN (GEO_LOCA_FATHER_ID is not null) then DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(GEO_LOCA_FATHER_ID) END PADRE " +
          " FROM GE_GEOGRA_LOCATION " +
          " ORDER BY DESCRIPTION";

      public static String ListadoOrigenes =
          "SELECT 1 ID, 'Cliente' DESCRIPTION FROM DUAL " +
          "UNION SELECT 2 ID, 'Área FNB' DESCRIPTION FROM DUAL " +
          "UNION SELECT 3 ID, 'Gran superficie' DESCRIPTION FROM DUAL " +
          "UNION SELECT 4 ID, 'Proveedor' DESCRIPTION FROM DUAL " +
          "UNION SELECT 5 ID, 'Contratista' DESCRIPTION FROM DUAL";

      #endregion

      #region M

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Listado de las Marcas Aprobadas para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_brand
      /// </summary>
      public static String Marcas = "Select Brand_id Codigo, Description Descripcion " +
          "from ld_brand " +
          "Where approved='Y' " +
          "order by Brand_id";

      #endregion

      #region N

      /// <summary>
      /// Aparece en: FIFAP;
      /// listado de los nivel educativos;
      /// Decuelve id, descripcion;
      /// Tablas: ge_school_degree
      /// </summary>
      public static String NivelEstudios = "select school_degree_id id, description descripción  from ge_school_degree";

      #endregion

      #region O

      /// <summary>
      /// Aparece en: FIACE;
      /// Listado de las Causales para Combos;
      /// Devuelve: Codigo;
      /// Tablas: or_order_activity;
      /// Observación: Diseñada para agregarle condición
      /// </summary>
      public static String OrderDelivery = "SELECT distinct d.order_id CODIGO " +
          "FROM   or_order_activity d " +
          "WHERE  d.activity_id = dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB') " +
          "AND    d.task_type_id = dald_Parameter.fnuGetNumeric_Value('CODI_TITR_EFNB') ";

      /// <summary>
      /// Aparece en: FNBCR;
      /// Operación ha realizar con las ordenes (anulacion o devolucion) (true devolucion) (false anulacion)
      /// </summary>
      public static String operationOrder = "Ld_bononbankfinancing.Fbllegalizeorder";

      #endregion

      #region P

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Parametro de Financiación Aplicados a los Articulos;
      /// Devuelve: numeric_value;
      /// Tablas: ld_parameter
      /// </summary>
      public static String ParametroFinanciacion = "select numeric_value " +
          "from ld_parameter " +
          "where parameter_id = 'FINANC_INITIALIZE_ARTICL'";

      /// <summary>
      /// Aparece en: LDOA;
      /// CURSOR PARA RETORNAR LA LISTA DE LAS ORDENES PENDIENTES POR APROBRACION
      /// </summary>
      public static String pendingorderldoa = "LD_BOPORTAFOLIO.frfGetPendingOrder";

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Listado de todas las Propiedades para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_property
      /// </summary>
      public static String Propiedades = "Select Property_Id Codigo, Description Descripcion " +
          "from ld_property " +
          "Order by Property_Id";

      /// <summary>
      /// Aparece en: ctrlGEC, ctrlGEPBR, ctrlGEPPB, FIACE;
      /// Consultas de Proveedores para Grillas;
      /// Devuelve: Identificacion, Nombre;
      /// Tablas: GE_CONTRATISTA
      /// </summary>
      public static String Proveedor = "SELECT /*+ index(GE_CONTRATISTA PK_GE_CONTRATISTA) */ " +  
          " ID_CONTRATISTA Identificacion, NOMBRE_CONTRATISTA Nombre " +
          "FROM GE_CONTRATISTA " +
          "WHERE ID_CONTRATISTA IN(SELECT /*+ index(or_operating_unit IX_OR_OPERATING_UNIT16) index(or_operating_unit IDX_OR_OPERATING_UNIT10) */ " +
          " CONTRACTOR_ID FROM OR_OPERATING_UNIT WHERE oper_unit_classif_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB') AND CONTRACTOR_ID = ID_CONTRATISTA) " +
          "Order by ID_CONTRATISTA";

      /// <summary>
      /// Aparece en: ctrlGELPPB;
      /// Consultas de Proveedores para Combos;
      /// Devuelve: Identificacion, Nombre;
      /// Tablas: GE_CONTRATISTA
      /// </summary>
      public static String ProveedorC = "SELECT ID_CONTRATISTA Identificacion, NOMBRE_CONTRATISTA Nombre " +
          "FROM GE_CONTRATISTA " +
          "WHERE ID_CONTRATISTA IN(SELECT CONTRACTOR_ID FROM OR_OPERATING_UNIT WHERE oper_unit_classif_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB') AND CONTRACTOR_ID = ID_CONTRATISTA) " +
          "Order by ID_CONTRATISTA";

        public static String ProveedorCV = "SELECT unique ID_CONTRATISTA Identificacion, NOMBRE_CONTRATISTA Nombre " +
          " FROM GE_CONTRATISTA , LD_CATALOG" +
          " WHERE ID_CONTRATISTA IN (SELECT CONTRACTOR_ID FROM OR_OPERATING_UNIT " +
              " WHERE oper_unit_classif_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB') AND CONTRACTOR_ID = ID_CONTRATISTA) " +
          " AND ID_CONTRATISTA = supplier_id ";

      public static String ProveedorC2 = "SELECT to_char(ID_CONTRATISTA) Identificacion, NOMBRE_CONTRATISTA Nombre " +
          "FROM GE_CONTRATISTA " +
          "WHERE ID_CONTRATISTA IN(SELECT CONTRACTOR_ID FROM OR_OPERATING_UNIT WHERE oper_unit_classif_id = DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB') AND CONTRACTOR_ID = ID_CONTRATISTA) " +
          "Order by ID_CONTRATISTA";

      #endregion

      #region Q

      /// <summary>
      /// Aparece en FIACS;
      /// consultar simulacion general
      /// </summary>
      public static String querySimulateGeneral = "LD_BOPORTAFOLIO.FRFGETRECORDS_FNBSIMULATEDQ";

      /// <summary>
      /// Aparece en FIACS;
      /// consultar simulacion resumen
      /// </summary>
      public static String querySimulateResume = "LD_BOPORTAFOLIO.FRFGETRECORDS_FNBSIMULATEDR";

      #endregion

      #region R

      public static String reportChanges = "LDC_PKVENTAPAGOUNICO.ChangesPromissoryPUData";

      #endregion

      #region S

      /// <summary>
      /// Aparece en: GEPBR;
      /// secuencia para los codigos de nuevos articulos
      /// </summary>
      public static String secuenceArticle = "ld_boportafolio.fnugetArticleId";

      /// <summary>
      /// Aparece en: GEC;
      /// secuencia para las comisiones
      /// </summary>
      public static String secuenceComision = "ld_boportafolio.fnugetCommissionId";

      /// <summary>
      /// Aparece en: GEPPB;
      /// secuencia para los detalles de las listas de Precios
      /// </summary>
      public static String secuenceDetailPriceList = "ld_boportafolio.fnugetPriceListDetaId";

      /// <summary>
      /// Aparece en: GEPPB;
      /// secuencia de las lista de precios
      /// </summary>
      public static String secuencePriceList = "ld_boportafolio.fnugetPriceListId";

      /// <summary>
      /// Aparece en: GEPBR;
      /// secuencia para los valores de las propiedades que se asociaran a un articulo
      /// </summary>
      public static String secuencePropertyArticle = "ld_boportafolio.fnugetPropertbyArtId";

      /// <summary>
      /// Aparece en: LDAPR;
      /// secuencia para las propiedades por articulos
      /// </summary>
      public static String secuencePropertybyArticle = "ld_boportafolio.fnugetPropertId";

      /// <summary>
      /// Aparece en: FIACS;
      /// Metodo para la Simulacion de Cuotas
      /// </summary>
      public static String SimulaciondeCuotas = "ld_bononbankfinancing.simulatequota";

      /// <summary>
      /// Aparece en: FIACE, FIFAP;
      /// Listado de las Sub-Categorias para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: SubCateg
      /// </summary>
      public static String SubCategoria = "Select Sucacodi Codigo, Sucadesc Descripcion from Subcateg";

      /// <summary>
      /// Aparece en: ctrlGEPBR;
      /// Listado de todas las Sub-Lineas Aprobadas y aplicadas a un Proveedor para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_subline, ld_segmen_supplier;
      /// Observación: Diseñada para asignarle la condicion de la linea asociada
      /// </summary>
      public static String Sublineas = "Select DISTINCT a.Subline_id Codigo, a.Description Descripcion, b.supplier_id " +
          "from ld_subline a, ld_segmen_supplier b " +
          "where a.subline_id = DECODE(b.subline_id, NULL, a.subline_id, b.subline_id) " +
          "AND a.line_id = b.line_id " +
          "and a.approved='Y' " +
          "Order BY a.Subline_id";

      /// <summary>
      /// Aparece en: ctrlGEC;
      /// Listado de todas las Sub-Lineas Aprobadas para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ld_subline;
      /// Observación: Diseñada para asignarle la condicion de la linea asociada
      /// </summary>
      public static String SublineasControladas = "Select Subline_id Codigo, Description Descripcion " +
          "from ld_subline " +
          "where approved = 'Y' ";

      #endregion

      #region T

      /// <summary>
      /// Aparece en: FIFAP;
      /// Listado de los diversos tipo de vivienda;
      /// devuelve id, descripcion;
      /// Tablas: ge_house_type
      /// </summary>
      public static String TipoCasa = "select house_type_id Id, description descripcion from ge_house_type";

      /// <summary>
      /// Aparece en: fnbcr, FIFAP;
      /// Listado de los Tipos de Documentos;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ge_identifica_type
      /// </summary>
      public static String TipoDocumentoC = "select to_char(ident_type_id) Codigo, to_char(description) Descripcion from ge_identifica_type";


      public static String TipoDocumentoChar = "select to_char(ident_type_id) Codigo, to_char(description) Descripcion from ge_identifica_type";


      /// <summary>
      /// Aparece en: FIFAP;
      /// Listado de los tipos de documentos;
      /// Devuelve Codigo, Descripcion;
      /// Tablas: LD_DOCUMENT_TYPE, GE_IDENTIFICA_TYPE
      /// </summary>
      public static String TiposDocumentos = "SELECT l.ident_type_id Codigo, g.description Descripcion FROM LD_DOCUMENT_TYPE l, GE_IDENTIFICA_TYPE g WHERE  l.ident_type_id = g.ident_type_id";

      /// <summary>
      /// Aparece en: LDAPB;
      /// Metodo para validar el Tipo de Usuario Conectado
      /// </summary>
      public static String TipoUsuarioConectado = "LD_BOPackageFNB.fsbGetTypeUser";

      #endregion

      #region U

      /// <summary>
      /// Aparece en: ctrlGEC, ctrlGEPPB, FIACE;
      /// Listado de las Ubicaciones Geograficas para Grillas;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ge_geogra_location, ge_geogra_loca_type
      /// </summary>
      public static String UbicacionGeografica = 
          "SELECT /*+ LEADING(ge_geogra_loca_type ge_geogra_location) " +
          "           INDEX(ge_geogra_location IDX_GE_GEOGRA_LOCATION_02) " +
          "           INDEX(ge_geogra_loca_type IX_GE_GEOGRA_LOCATION06) */"+
          "a.geograp_location_id Codigo, a.description descripcion " +
          "FROM ge_geogra_location a, ge_geogra_loca_type b " +
          "WHERE assign_level = 'Y' " +
          "AND a.geog_loca_area_type = b.geog_loca_area_type " +
          "AND (b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc OR b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionDpto) " +
          "Order by a.geograp_location_id";

      public static String UbicacionGeograficaTree = " SELECT id, node_text, parent_id, assign_level"
         + " FROM  ( select a.geograp_location_id id,"
         + " decode( a.description, null, '--',a.description) node_text,"
         + " decode(a.GEO_LOCA_FATHER_ID, null, -1,a.GEO_LOCA_FATHER_ID) parent_id,"
         + " a.assign_level"
         + " from ge_geogra_location a"
         + " where a.geograp_location_id  <> -1"
         + " AND a.geog_loca_area_type in ( ab_boConstants.fnuObtTipoUbicacionLoc,"
         + " ab_boConstants.fnuObtTipoUbicacionDpto, ab_boConstants.fnuobttipoubicacionpais,"
         + " ab_boConstants.fnuobttipoubicacionbarrio )"
         + " Order by a.geograp_location_id ) treeview_data ";

      public static String UbicacionGeografica2 = "SELECT to_char(a.geograp_location_id) Codigo, a.geograp_location_id Id, a.description descripcion " +
          "FROM ge_geogra_location a, ge_geogra_loca_type b " +
          "WHERE assign_level = 'Y' " +
          "AND a.geog_loca_area_type = b.geog_loca_area_type " +
          "AND (b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc OR b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionDpto) " +
          "Order by a.geograp_location_id";

      /// <summary>
      /// Aparece en: FIACS;
      /// Listado de las Ubicaciones Geograficas para Combos;
      /// Devuelve: Codigo, Descripcion;
      /// Tablas: ge_geogra_location, ge_geogra_loca_type
      /// </summary>
      public static String UbicacionGeograficaC = "SELECT geograp_location_id codigo, a.description descripcion " +
          "FROM ge_geogra_location a, ge_geogra_loca_type b " +
          "WHERE assign_level = 'Y' " +
          "AND a.geog_loca_area_type = b.geog_loca_area_type " +
          "AND (b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc OR b.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionDpto) " +
          "Order by geograp_location_id";

      #endregion

      #region V

      /// <summary>
      /// Aparece en: geppb;
      /// Metodo para validar los articulos en una lista
      /// </summary>
      public static String ValidarArticulosLista = "ld_bcportafolio.fnuarticleinpricelist";

      /// <summary>
      /// Aparece en: ctrlGEPLPB;
      /// Listado de las Versiones de Lista de Precios para Combos;
      /// Devuelve: version;
      /// Tablas: ld_price_list, ld_price_list_deta;
      /// Observación: Diseñada para asignarle la condicion de la lista de precios asociada
      /// </summary>
      public static String VersionListadePreciosC = "select distinct lpd.version " +
          "from ld_price_list lp, ld_price_list_deta lpd " +
          "where lp.price_list_id = lpd.price_list_id ";

      public static String validarEdicion = "LDC_PKVENTAPAGOUNICO.ValidEditDeudorCodeudorData";

      #endregion

      ///// <summary>
      ///// Aparece en: FIFAP;
      ///// Listado de los estratos Sociales;
      ///// Devuelve id, descripcion;
      ///// Tablas: subcateg
      ///// </summary>
      //public static String EstratoSocial = "select sucacodi id, sucadesc descripción from subcateg where subcateg.sucacate = 1";
   }
}
