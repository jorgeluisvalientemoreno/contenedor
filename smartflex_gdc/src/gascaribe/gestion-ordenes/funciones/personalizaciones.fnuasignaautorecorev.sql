CREATE OR REPLACE FUNCTION personalizaciones.fnuasignaautorecorev(isbDatosEntrada IN VARCHAR2)
  RETURN NUMBER IS
  /*****************************************************************
      Propiedad intelectual de Gases del Caribe
  
      Unidad         : fnuasignaautorecorev
      Descripcion    : Función que realiza la asignación de los productos
                       autoreconectados con marcar 101 y 103 UOBYSOL
      Autor          : felipe.valencia
      Fecha          : 19-03-2024
  
      Parámetros              Descripcion
      ============            ===================
      inuContrato             Número del contrato a validar
      
      Fecha           Autor               Modificación
      =========       =========           ====================
    19-03-2024      felipe.valencia     OSF-2443: Creación
    28/08/2024      Jore Valiente       OSF-2443: Agregar logica para validar marca de tipo de suspension 
                                                  del producto de la orden a ser asignada para establecer si 
                                                  tiene marca 101 o 103 con el parametro MAR_PROD_FNUASIGNAAUTORECOREV
  ******************************************************************/
  -- Constantes para el control de la traza
  csbMetodo     CONSTANT VARCHAR2(32) := $$PLSQL_UNIT; -- Constante para nombre de función    
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef; -- Nivel de traza para esta función. 
  csbInicio     CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO; -- Indica inicio de método
  csbFin        CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN; -- Indica Fin de método ok
  csbFin_Erc    CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN_ERC; -- Indica fin de método con error controlado
  csbFin_Err    CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN_ERR; -- Indica fin de método con error no controlado

  --Variables generales
  sberror VARCHAR2(4000);
  nuerror NUMBER;

  sbOrden     VARCHAR2(4000);
  sbSolicitud VARCHAR2(4000);
  sbActividad VARCHAR2(4000);
  sbContrato  VARCHAR2(4000);
  sbTrigger   VARCHAR2(4000);
  sbCategoria VARCHAR2(4000);

  nuOrden           or_order.order_id%TYPE;
  nuContrato        or_order_activity.subscription_id%TYPE;
  nuUnidadOperativa or_order.operating_unit_id%TYPE := -1;
  nuAnioPlazoMinimo NUMBER;
  nuMesPlazoMinimo  NUMBER;
  nuDireccion       or_order.external_address_id%TYPE;
  nuDepartamento    or_order.geograp_location_id%TYPE;
  nuSolicitud       NUMBER;

  nuUnidadPlazoMinimo or_order.operating_unit_id%TYPE;

  dtPlazoMinimo DATE;

  onuerrorcode    NUMBER;
  osberrormessage VARCHAR2(4000);

  CURSOR cuDatosEntrada(isbEntrada IN VARCHAR2) IS
    SELECT regexp_substr(isbEntrada, '[^|]+', 1, level) as column_value
      FROM dual
    connect by regexp_substr(isbEntrada, '[^|]+', 1, level) is not null;

  nuProducto      number;
  nuMarcaProducto number;

  cursor cuMarcaExiste(inuMarcaProducto number, sbParametro varchar2) is
    select count(1) cantidad
      from dual
     where inuMarcaProducto in
           (select to_number(regexp_substr(sbparametro, '[^,]+', 1, level)) as column_value
              from dual
            connect by regexp_substr(sbparametro, '[^,]+', 1, level) is not null);

  sbMARCAPRODUCTO ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('MAR_PROD_FNUASIGNAAUTORECOREV');
  nuMarcaExiste             number;

BEGIN

  pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
  pkg_traza.trace('isbDatosEntrada: ' || isbDatosEntrada, csbNivelTraza);

  IF (cuDatosEntrada%ISOPEN) THEN
    CLOSE cuDatosEntrada;
  END IF;

  FOR rcDatos IN cuDatosEntrada(isbDatosEntrada) LOOP
    IF sbOrden IS NULL THEN
      sbOrden := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbOrden: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    ELSIF sbSolicitud IS NULL THEN
      sbSolicitud := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbSolicitud: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    ELSIF sbActividad IS NULL THEN
      sbActividad := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbActividad: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    ELSIF sbContrato IS NULL THEN
      sbContrato := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbContrato: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    ELSIF sbTrigger IS NULL THEN
      sbTrigger := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbTrigger: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    ELSIF sbCategoria IS NULL THEN
      sbCategoria := rcDatos.column_value;
      pkg_traza.trace('rcDatos.column_value sbCategoria: ' ||
                      rcDatos.column_value,
                      csbNivelTraza);
    END IF;
  END LOOP;

  nuOrden     := TO_NUMBER(sbOrden);
  nuContrato  := TO_NUMBER(sbContrato);
  nuSolicitud := TO_NUMBER(sbSolicitud);

  --Obtiene le produto de la orden
  nuProducto := pkg_bcordenes.fnuObtieneProducto(nuOrden);
  --Obtiene la marca tipo de suspenssion del producto
  nuMarcaProducto := pkg_bcproducto.fnuObtieneMarcaProducto(nuProducto);
  open cuMarcaExiste(nuMarcaProducto, sbMARCAPRODUCTO);
  fetch cuMarcaExiste
    into nuMarcaExiste;
  close cuMarcaExiste;
  pkg_traza.trace('Existe la marca: ' || nuMarcaExiste, csbNivelTraza);

  --Valdia que la marca de tipo de suspension este configurada en el parametro
  if nuMarcaExiste > 0 then
  
    IF (nuOrden IS NOT NULL AND nuContrato IS NOT NULL) THEN
      dtPlazoMinimo := pkg_bcplazos_certificados.fdtplazominimo(nuContrato);
      IF (dtPlazoMinimo IS NOT NULL) THEN
        nuAnioPlazoMinimo := TO_NUMBER(EXTRACT(YEAR FROM dtPlazoMinimo));
      
        nuMesPlazoMinimo := TO_NUMBER(EXTRACT(MONTH FROM dtPlazoMinimo));
      
        nuDireccion := pkg_bcordenes.fnuObtieneDireccion(nuOrden);
      
        nuDepartamento := pkg_bcdirecciones.fnugetubicageopadre(pkg_bcdirecciones.fnugetlocalidad(nuDireccion));
      
        nuUnidadPlazoMinimo := pkg_bcplazos_certificados.fnuUnidadPlazominimo(nuAnioPlazoMinimo,
                                                                              nuMesPlazoMinimo,
                                                                              nuDepartamento);
      
        IF (nuUnidadPlazoMinimo IS NOT NULL) THEN
          nuUnidadOperativa := nuUnidadPlazoMinimo;
        
          BEGIN
          
            api_assign_order(nuOrden,
                             nuUnidadOperativa,
                             onuerrorcode,
                             osberrormessage);
          
            IF NVL(onuerrorcode, 0) = 0 THEN
              pkg_orden_uobysol.prcEliminarOrden(nuOrden);
            ELSE
              pkg_orden_uobysol.prcActualizaObservacion(nuOrden,osberrormessage);
              Pkg_Error.SetErrorMessage(isbMsgErrr => 'Error al asignar la orden ' ||
                                                      nuOrden || ' Error: ' ||
                                                      osberrormessage);
            END IF;
          
          EXCEPTION
            WHEN pkg_Error.Controlled_Error THEN
              pkg_Error.getError(nuError, sbError);
              pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
              pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            WHEN OTHERS THEN
              pkg_Error.setError;
              pkg_Error.getError(nuError, sbError);
              pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
              pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
          END;
        END IF;
      END IF;
    END IF;
  
  End if; --if nuMarcaExiste > 0 then 

  pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
  return nuUnidadOperativa;

EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
    return nuUnidadOperativa;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    return nuUnidadOperativa;
END fnuasignaautorecorev;
/
begin
  pkg_utilidades.prAplicarPermisos('FNUASIGNAAUTORECOREV',
                                   'PERSONALIZACIONES');
end;
/