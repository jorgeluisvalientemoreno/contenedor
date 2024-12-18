CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas
  
  Unidad         : PKG_BOCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : Jorge Valiene
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proRegistraAIUCotizacion
  Descripcion    : Metodo para registrar AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proRegistraAIUCotizacion(inuCotizacion    IN number,
                                     inuAIUPorcentaje IN number);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proModificaAIUCotizacion
  Descripcion    : Metodo para Modificar AIU a la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proModificaAIUCotizacion(inuCotizacion    IN number,
                                     inuAIUPorcentaje IN number);

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerAIUCotizacion
  Descripcion    : Metodo para Obtener AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerAIUCotizacion(inuCotizacion IN number) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuCalcularIVAPorcentaje
  Descripcion    : Metodo para Obtener Porcenta IVA del AIU
  Autor          : Jorge Valiente
  Fecha          : 10-11-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuCalcularIVAPorcentaje(inuAIUPorcentaje IN number) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerPorcentajeIVA
  Descripcion    : Metodo para Obtener Pocentaje IVA de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 15-11-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerPorcentajeIVA(inuCotizacion IN number) RETURN NUMBER;
  
END PKG_BOCOTIZACIONCOMERCIAL;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOCOTIZACIONCOMERCIAL IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas
  
  Unidad         : PKG_BOCOTIZACIONCOMERCIAL
  Descripcion    : Paquete que contiene la logica de negocio para las cotizaciones de
                   ventas comerciales e industriales.
  Autor          : Jorge Valiene
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  --Constantes

  csbNOMPKG CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.'; --constante nombre del paquete

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proRegistraAIUCotizacion
  Descripcion    : Metodo para registrar AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proRegistraAIUCotizacion(inuCotizacion    IN number,
                                     inuAIUPorcentaje IN number) IS
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'proRegistraAIUCotizacion'; --nombre del metodo
  
    nuPorcentjeIVA number;
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    --obtener porcentaje IVA del porcentaje AIU de la venta cotizacion
    nuPorcentjeIVA := fnuCalcularIVAPorcentaje(inuAIUPorcentaje);
  
    insert into DATOS_COTIZACION_COMERCIAL
      (ID_COT_COMERCIAL, AIU_PORCENTAJE, IVA_PORCENTAJE)
    values
      (inuCotizacion, inuAIUPorcentaje, nuPorcentjeIVA);

    pkg_traza.trace('Registra Cotizacion: ' || inuCotizacion ||
                    ' - Porcentaje AIU:' || inuAIUPorcentaje ||
                    ' - Porcentaje IVA:' || nuPorcentjeIVA,
                    pkg_traza.cnuNivelTrzDef);

    commit;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END proRegistraAIUCotizacion;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : proModificaAIUCotizacion
  Descripcion    : Metodo para Modificar AIU a la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  PROCEDURE proModificaAIUCotizacion(inuCotizacion    IN number,
                                     inuAIUPorcentaje IN number) IS
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'proModificaAIUCotizacion'; --nombre del metodo
  
    cursor cuNuParametro(iSbParametro varchar2) is
      select l.numeric_value
        from ld_parameter l
       where l.parameter_id = iSbParametro;
  
    cursor cuClasificacionIVA(nuTipoTrabajo number, nuActividad number) is
      SELECT t.id_cot_comercial id_cotizacion,
             t.tipo_trabajo,
             t.abreviatura,
             t.actividad,
             t.iva,
             t.aplica_desc
        FROM ldc_tipotrab_coti_com t
       WHERE t.id_cot_comercial = inuCotizacion
         and t.tipo_trabajo = nuTipoTrabajo
         and t.actividad = nuActividad;
  
    rfcuClasificacionIVA cuClasificacionIVA%rowtype;
  
    cursor cuAIUItems is
      select LICC.*
        from LDC_ITEMS_COTIZACION_COM LICC
       where LICC.ID_COT_COMERCIAL = inuCotizacion;
  
    rfcuAIUItems cuAIUItems%rowtype;
  
    nuCostoVenta         number;
    nuAIU                number;
    nuPrecioTotal        number;
    nuCantidad           number;
    nuIva                number;
    nuPorcUtilidadIvaCom number;
    nuPorcentjeIVA       number;

    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    --obtener porcentaje IVA del porcentaje AIU de la venta cotizacion
    nuPorcentjeIVA := fnuCalcularIVAPorcentaje(inuAIUPorcentaje);
    
    --Actualizar AIU de la cotizacicon
    update DATOS_COTIZACION_COMERCIAL
       set AIU_PORCENTAJE = inuAIUPorcentaje, IVA_PORCENTAJE = nuPorcentjeIVA
     where ID_COT_COMERCIAL = inuCotizacion;
  
    commit;
  
    open cuNuParametro('PORC_UTILIDAD_IVA_COM');
    fetch cuNuParametro
      into nuPorcUtilidadIvaCom;
    close cuNuParametro;
  
    for rfcuAIUItems in cuAIUItems loop
    
      nuCostoVenta  := rfcuAIUItems.Costo_Venta;
      nuCantidad    := rfcuAIUItems.Cantidad;
      nuAIU         := Round((nuCostoVenta * inuAIUPorcentaje) / 100 *
                             nuCantidad,
                             0);
      nuPrecioTotal := Round((nuCostoVenta * nuCantidad) + nuAIU, 0);
    
      open cuClasificacionIVA(rfcuAIUItems.Tipo_Trabajo,
                              rfcuAIUItems.Actividad);
      fetch cuClasificacionIVA
        into rfcuClasificacionIVA;
      if cuClasificacionIVA%found then
        if rfcuClasificacionIVA.Abreviatura = 'CE' then
          /*Constants.CERTIFICATION_CLASS*/
        
          nuIva := Round((nuPrecioTotal - rfcuAIUItems.Descuento) *
                         rfcuClasificacionIVA.Iva / 100,
                         0);
        
        elsif rfcuClasificacionIVA.Abreviatura = 'IN' then
          /*Constants.INTERNAL_CON_CLASS*/
        
          nuIva := Round((nuAIU * rfcuClasificacionIVA.Iva *
                         (nuPorcUtilidadIvaCom / 100)) / 100,
                         0);
          nuIva := Round(nuIva - (nuIva * rfcuAIUItems.Descuento / 100), 0);
        
        elsif rfcuClasificacionIVA.Abreviatura = 'CC' then
          /*Constants.INTERNAL_CON_CLASS*/
        
          nuIva := Round((nuAIU * rfcuClasificacionIVA.Iva *
                         (nuPorcUtilidadIvaCom / 100)) / 100,
                         0);
          nuIva := Round(nuIva - (nuIva * rfcuAIUItems.Descuento / 100), 0);
        
        end if;
      end if;
      close cuClasificacionIVA;
    
      pkg_traza.trace('*****************' || rfcuAIUItems.Id_Item,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Item: ' || rfcuAIUItems.Id_Item,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Costo Venta: ' || nuCostoVenta,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Valor AIU: ' || nuAIU, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Cantidad Item: ' || nuCantidad, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Precio Total: ' || nuPrecioTotal,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Iva: ' || nuIva, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('*****************' || rfcuAIUItems.Id_Item,
                      pkg_traza.cnuNivelTrzDef);
    
      update LDC_ITEMS_COTIZACION_COM LICC
         set LICC.AIU          = nuAIU,
             LICC.Precio_Total = nuPrecioTotal,
             LICC.IVA          = nuIva
       where LICC.ID_COT_COMERCIAL = inuCotizacion
         and LICC.Id_Item = rfcuAIUItems.Id_Item
         and LICC.Actividad = rfcuAIUItems.Actividad;
    
      commit;
    
    end loop;
  
    --Actualizar AIU de la cotizacicon en OPEN
    update cc_quotation cq
       set cq.aui_percentage = inuAIUPorcentaje
     where cq.package_id in
           (select lcc.sol_cotizacion
              from ldc_cotizacion_comercial lcc
             where lcc.id_cot_comercial = inuCotizacion);
  
    commit;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END proModificaAIUCotizacion;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerAIUCotizacion
  Descripcion    : Metodo para Obtener AIU de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 10-10-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerAIUCotizacion(inuCotizacion IN number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'fnuObtenerAIUCotizacion'; --nombre del metodo
  
    cursor cuAIU is
      select nvl(dcc.aiu_porcentaje, 0)
        from DATOS_COTIZACION_COMERCIAL dcc
       where ID_COT_COMERCIAL = inuCotizacion;
  
    nuAIUCotizacion number;
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    open cuAIU;
    fetch cuAIU
      into nuAIUCotizacion;
    close cuAIU;
  
    pkg_traza.trace('Obtener Porcentaje AIU:' || nuAIUCotizacion ||
                    ' de la Cotizacion: ' || inuCotizacion,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    return nvl(nuAIUCotizacion,0);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuCalcularIVAPorcentaje
  Descripcion    : Metodo para Calcular Porcenta IVA del porcentaje AIU
  Autor          : Jorge Valiente
  Fecha          : 10-11-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuCalcularIVAPorcentaje(inuAIUPorcentaje IN number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'fnuCalcularIVAPorcentaje'; --nombre del metodo
  
    cursor cuNuParametro(iSbParametro varchar2) is
      select l.numeric_value
        from ld_parameter l
       where l.parameter_id = iSbParametro;
  
    nuPorcUtilidadIVA    ld_parameter.numeric_value%type;
    nuPorcIVAInstInterna ld_parameter.numeric_value%type;
    nuPorcentjeIVA       number;
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    open cuNuParametro('PORC_UTILIDAD_IVA_COM');
    fetch cuNuParametro
      into nuPorcUtilidadIVA;
    close cuNuParametro;
  
    open cuNuParametro('PORC_IVA_INST_INT_VTA_COM');
    fetch cuNuParametro
      into nuPorcIVAInstInterna;
    close cuNuParametro;
  
    --Formula para calcular Porcentaje IVA = ((AIU%* 19%*50%)/(1+AIU%))/100
    nuPorcentjeIVA := ((inuAIUPorcentaje / 100) *
                      (nuPorcIVAInstInterna / 100) *
                      (nuPorcUtilidadIVA / 100) /
                      (1 + (inuAIUPorcentaje / 100))) * 100;
  
    pkg_traza.trace('Obtener Porcentaje IVA: ' || nuPorcentjeIVA ||
                    ' del porcentaje AIU:' || inuAIUPorcentaje,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    return nuPorcentjeIVA;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.
  
  Unidad         : fnuObtenerPorcentajeIVA
  Descripcion    : Metodo para Obtener Pocentaje IVA de la cotizacion
  Autor          : Jorge Valiente
  Fecha          : 15-11-2023
  Caso           : OSF-1492
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuObtenerPorcentajeIVA(inuCotizacion IN number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'fnuObtenerPorcentajeIVA'; --nombre del metodo
  
    cursor cuIVA is
      select nvl(dcc.iva_porcentaje, 0)
        from DATOS_COTIZACION_COMERCIAL dcc
       where ID_COT_COMERCIAL = inuCotizacion;
  
    nuPorcentajeIVA number;
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    open cuIVA;
    fetch cuIVA
      into nuPorcentajeIVA;
    close cuIVA;
  
    pkg_traza.trace('Obtener Porcentaje IVA:' || nuPorcentajeIVA ||
                    ' de la Cotizacion: ' || inuCotizacion,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    return nvl(nuPorcentajeIVA,0);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END;  
  

END PKG_BOCOTIZACIONCOMERCIAL;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOCOTIZACIONCOMERCIAL','PERSONALIZACIONES');
END;
/