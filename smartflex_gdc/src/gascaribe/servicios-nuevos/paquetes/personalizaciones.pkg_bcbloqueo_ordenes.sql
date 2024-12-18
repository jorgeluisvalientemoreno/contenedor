CREATE OR REPLACE PACKAGE personalizaciones.PKG_BcBloqueo_Ordenes IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfOrdenes
    Descripcion     : proceso que retorna informacion para PB PBBLOR
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 22-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-12-2023   OSF-2030    Creacion
  ***************************************************************************/
  FUNCTION frfOrdenes(inuTipoTrabajo number,
                      isbOrdenes     varchar2,
                      inuSolicitud   number) RETURN constants_per.tyrefcursor;

END PKG_BcBloqueo_Ordenes;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_BcBloqueo_Ordenes IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2030';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 22-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
      LJLB       11-11-2023   OSF-2030    Creacion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION frfOrdenes(inuTipoTrabajo NUMBER,
                      isbOrdenes     VARCHAR2,
                      inuSolicitud   NUMBER) RETURN constants_per.tyrefcursor IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : frfOrdenes
      Descripcion     : proceso que retorna informacion de ordenes para PB PBBLOR
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Parametros de Entrada
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    csbMT_NAME          VARCHAR2(70) := csbSP_NAME || '.frfOrdenes';
    nuError             NUMBER;
    sberror             VARCHAR2(4000);
    rfOrdenes           constants_per.tyrefcursor;
    sbSQLSelect         VARCHAR2(4000) := null;
    sbSQLFrom           VARCHAR2(1000) := null;
    sbSQLWhere          VARCHAR2(1000) := null;
    sbSQLWhereOrden     VARCHAR2(1000) := null;
    sbSQLWhereSolicitud VARCHAR2(1000) := null;
    sbESTREBLOOR        VARCHAR2(2000) := null;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Codigo Tipo de trabajo: ' || inuTipoTrabajo,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ordenes: ' || isbOrdenes, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    sbESTREBLOOR := dald_parameter.fsbgetvalue_chain('LDC_ESTREBLOOR',
                                                     NULL);
    pkg_traza.trace('sbESTREBLOOR: ' || sbESTREBLOOR,
                    pkg_traza.cnuNivelTrzDef);
  
    sbSQLSelect := 'SELECT DISTINCT or_order.order_id ORDEN,
                or_order.external_address_id || '' - '' || ab_address.ADDRESS_PARSED DIRECCION,
                (select ggld.geograp_location_id || '' - '' ||
                        ggld.description
                   from ge_geogra_location ggld
                  where ggld.geograp_location_id =
                        (select ggl.geo_loca_father_id
                           from ge_geogra_location ggl
                          where ggl.geograp_location_id =
                                ab_address.geograp_location_id
                            and rownum = 1)) DEPARTAMENTO,
                (select ggl.geograp_location_id || '' - '' || ggl.description
                   from ge_geogra_location ggl
                  where ggl.geograp_location_id =
                        ab_address.geograp_location_id
                    and rownum = 1) LOCALIDAD,
                (SELECT (select ccp.description
                           from CC_COMMERCIAL_PLAN ccp
                          where ccp.commercial_plan_id =
                                pr_product.commercial_plan_id)
                   FROM pr_product
                  WHERE pr_product.product_id = or_order_activity.product_id) PLAN_COMERCIAL,
                 (SELECT oou.operating_unit_id ||'' - ''|| oou.name from or_operating_unit oou 
                   where oou.operating_unit_id = or_order.operating_unit_id) UNIDAD_OPERATIVA';
  
    sbSQLFrom := ' FROM or_order
              JOIN or_order_activity
                ON or_order.order_id = or_order_activity.order_id
              LEFT JOIN mo_packages
                ON mo_packages.package_id = or_order_activity.package_id
              LEFT JOIN servsusc
                ON servsusc.sesunuse = or_order_activity.product_id
              LEFT JOIN ab_address
                ON ab_address.address_id = or_order.external_address_id
              JOIN OR_TASK_TYPE_CAUSAL oc
                ON oc.task_type_id = or_order.task_type_id';
  
    sbSQLWhere := ' WHERE or_order.task_type_id = ' || inuTipoTrabajo ||
                  ' and or_order.ORDER_STATUS_ID IN
                   (SELECT to_number(regexp_substr(''' ||
                  sbESTREBLOOR ||
                  ''', ''[^,]+'', 1, LEVEL)) AS estado
                      FROM dual
                    CONNECT BY regexp_substr(''' ||
                  sbESTREBLOOR || ''', ''[^,]+'', 1, LEVEL) IS NOT NULL)';
  
    if isbOrdenes is not null then
      sbSQLWhereOrden := ' and or_order.order_id in
       (SELECT to_number(regexp_substr(''' ||
                         isbOrdenes || ''', ''[^|]+'', 1, LEVEL)) AS orden
          FROM dual
        CONNECT BY regexp_substr(''' || isbOrdenes ||
                         ''', ''[^|]+'', 1, LEVEL) IS NOT NULL)';
    end if;
  
    if inuSolicitud is not null then
      sbSQLWhereSolicitud := ' and mo_packages.package_id = ' ||
                             inuSolicitud;
    end if;
  
    pkg_traza.trace('sbSQLSelect: ' || sbSQLSelect,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbSQLFrom: ' || sbSQLFrom, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbSQLWhere: ' || sbSQLWhere, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbSQLWhereOrden: ' || sbSQLWhereOrden,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbSQLWhereSolicitud: ' || sbSQLWhereSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN rfOrdenes FOR sbSQLSelect || sbSQLFrom || sbSQLWhere || sbSQLWhereOrden || sbSQLWhereSolicitud;
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN rfOrdenes;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END frfOrdenes;

END PKG_BcBloqueo_Ordenes;
/
