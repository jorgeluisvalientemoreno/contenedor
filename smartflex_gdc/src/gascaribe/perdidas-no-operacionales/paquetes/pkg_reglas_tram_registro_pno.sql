CREATE OR REPLACE PACKAGE pkg_reglas_tram_registro_pno IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_reglas_tram_registro_pno
      Autor       : Jorge Valiente  
      Fecha       : 16/05/2025  
      Descripcion : Paquete de reglas para el tramite de registro de perdida no operacional
      
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion 
  *******************************************************************************/

  --proceso para validar actividad seleccionada en PNO y estabelcer si es reincidente
  PROCEDURE prcValida_Actividad;

  --proceso para validar direccion a nivel de motivo seleccionada en PNO
  PROCEDURE prcValida_Direccion_Motivo;

END pkg_reglas_tram_registro_pno;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_tram_registro_pno IS

  -- Constantes para el control de la traza
  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  sbInicio   CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;
  sbFin      CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcValida_Actividad
  Descripcion     : proceso para validar actividad seleccionada en PNO y estabelcer si es reincidente
  Autor           : Jorge Valiente
  Fecha           : 16/05/2025
  
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcValida_Actividad IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcValida_Actividad';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbInstance  VARCHAR2(4000);
    sbProducto  VARCHAR2(4000);
    sbActividad VARCHAR2(4000);
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, sbInicio);
  
    GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);
    pkg_traza.trace('Instancia: ' || sbInstance, cnuNVLTRC);
    PRC_OBTIENEVALORINSTANCIA(sbInstance,
                              null,
                              'MO_PROCESS',
                              'SERVICE_NUMBER',
                              sbProducto);
  
    pkg_traza.trace('Producto: ' || sbProducto, cnuNVLTRC);
  
    GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbActividad);
  
    pkg_traza.trace('Actividad a Gestionar: ' || sbActividad, cnuNVLTRC);
  
    IF sbProducto IS NOT NULL THEN
      pkg_boregistropno.prcValida_Actividad(TO_NUMBER(sbActividad),
                                            TO_NUMBER(sbProducto));
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, sbFin);
  
  EXCEPTION
  
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    --Validación de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcValida_Actividad;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcValida_Direccion_Motivo
  Descripcion     : proceso para validar direccion a nivel de motivo seleccionada en PNO
  Autor           : Jorge Valiente
  Fecha           : 16/05/2025
  
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcValida_Direccion_Motivo IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcValida_Direccion_Motivo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbAddressId         VARCHAR2(4000);
    nuAddressId         NUMBER;
    sbDireccion         VARCHAR2(4000);
    sbDireccionErrorPNO VARCHAR2(4000) := 'KR NO EXISTE CL NO EXISTE - 0';
  
    sbInstance VARCHAR2(4000);
    nuProducto NUMBER;

    nuCOD_SERVICIO_GAS NUMBER := CONSTANTS_PER.COD_SERVICIO_GAS;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, sbInicio);
  
    GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbAddressId);
    nuAddressId := TO_NUMBER(sbAddressId);
    pkg_traza.trace('Codigo Direccion: ' || nuAddressId, cnuNVLTRC);
  
    sbDireccion := PKG_BCDIRECCIONES.fsbGetDireccion(nuAddressId);
  
    IF (sbDireccion = sbDireccionErrorPNO) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'La direccion Dummy correcta es: KR GENERICA CL GENERICA - 0');
    END IF;
  
    pkg_traza.trace('Constante Codigo Servicio GAS: ' ||
                    nuCOD_SERVICIO_GAS,
                    cnuNVLTRC);

    nuProducto := pkg_bodirecciones.fnuProductoPorDireccion(nuAddressId,
                                                            nuCOD_SERVICIO_GAS);
                                                            
    pkg_traza.trace('Producto: ' || nuProducto, cnuNVLTRC);
  
    IF nuProducto IS NOT NULL THEN
    
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);
      pkg_traza.trace('Instancia: ' || sbInstance, cnuNVLTRC);
    
      GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,
                                                null,
                                                'MO_PROCESS',
                                                'SERVICE_NUMBER',
                                                nuProducto);
    
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, sbFin);
  
  EXCEPTION
  
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    --Validación de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcValida_Direccion_Motivo;

END pkg_reglas_tram_registro_pno;
/
