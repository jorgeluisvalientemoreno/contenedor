CREATE OR REPLACE PACKAGE pkg_reglas_tramitecambiodeuso AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Reglas para el manejo de funcionbalidades del tramite de cambio de uso
      Tabla : 
      Caso  : OSF-3674
      Fecha : 31/10/2024 11:06:35
  ***************************************************************************/

  -- logica de la regla POST configurada a nivel de motivo del EVE - POS - MO_MOTIVE del tramite de Cambio Uso de Servicio
  PROCEDURE prcPostMotivo;

  -- logica de la regla POST configurada a nivel de motivo del EVE - POS - MO_MOTIVE del tramite de Cambio Uso de Servicio
  PROCEDURE prcIniVisitaCampo;

END pkg_reglas_tramitecambiodeuso;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_tramitecambiodeuso AS

  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcPostMotivo
    Descripcion     : logica de la regla POST configurada a nivel de motivo del EVE - POS - MO_MOTIVE del tramite de Cambio Uso de Servicio
    Autor           : Jorge Valiente
    Fecha           : 01-11-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcPostMotivo IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcPostMotivo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    --Variables para obtener valores de instancia del tramite de cambio de uso
    sbInstanciaActual VARCHAR2(4000);
    sbPackageId       VARCHAR2(4000);
    sbOldUsoId        VARCHAR2(4000);
    sbNewUsoId        VARCHAR2(4000);
    sbOldEstratoId    VARCHAR2(4000);
    sbNewEstratoId    VARCHAR2(4000);
    sbResolucion      VARCHAR2(4000);
    nuBillDataId      NUMBER;
    sbMotiveId        NUMBER;
  
    --variables para obtener data de FLAG de visita de campo
    sbVisitaCampo VARCHAR2(4000);
  
    --registro insertar dato adicional solicitud
    sbREALIZO_VISITA_EN_CAMPO VARCHAR2(50) := 'REALIZO_VISITA_EN_CAMPO';
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstanciaActual);
    pkg_traza.trace('Instancia Actual: ' || sbInstanciaActual,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaActual,
                                              NULL,
                                              'MO_MOTIVE',
                                              'PACKAGE_ID',
                                              sbPackageId);
    pkg_traza.trace('Solicitud: ' || sbPackageId, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',
                                              NULL,
                                              'PR_PRODUCT',
                                              'CATEGORY_ID',
                                              sbOldUsoId);
    pkg_traza.trace('Categoria Anterior: ' || sbOldUsoId, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaActual,
                                              NULL,
                                              'MO_MOTIVE',
                                              'CATEGORY_ID',
                                              sbNewUsoId);
    pkg_traza.trace('Nueva Categoria: ' || sbNewUsoId, cnuNivelTraza);
  
    IF (sbOldUsoId is NULL) THEN
      sbOldUsoId := '-1';
    END IF;
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',
                                              NULL,
                                              'PR_PRODUCT',
                                              'SUBCATEGORY_ID',
                                              sbOldEstratoId);
    pkg_traza.trace('SubCategoria Anterior: ' || sbOldEstratoId,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaActual,
                                              NULL,
                                              'MO_MOTIVE',
                                              'SUBCATEGORY_ID',
                                              sbNewEstratoId);
    pkg_traza.trace('Nueva SubCategoria: ' || sbNewEstratoId,
                    cnuNivelTraza);
  
    IF (sbOldEstratoId is NULL) THEN
      sbOldEstratoId := '-1';
    END IF;
  
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaActual,
                                              NULL,
                                              'MO_PROCESS',
                                              'VARCHAR_2',
                                              sbResolucion);
    pkg_traza.trace('Resolucion: ' || sbResolucion, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.LOADENTITYATTRIBUTES(sbInstanciaActual,
                                              NULL,
                                              'MO_BILL_DATA_CHANGE',
                                              GE_BOCONSTANTS.GETTRUE,
                                              GE_BOCONSTANTS.GETTRUE);
  
    pkg_traza.trace('Agregar DATA en MO_BILL_DATA_CHANGE', cnuNivelTraza);
    nuBillDataId := MO_BOSEQUENCES.FNUGETSEQ_MO_BILL_DATA_CHANGE;
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'BILL_DATA_CHANGE_ID',
                                      nuBillDataId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Secuencia: ' || nuBillDataId, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'PACKAGE_ID',
                                      sbPackageId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Solicitud: ' || sbPackageId, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'MOTIVE_ID',
                                      sbMotiveId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Motivo: ' || sbMotiveId, cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'OLD_CATEGORY_ID',
                                      sbOldUsoId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Categoria(USO) Anterior: ' || sbOldUsoId,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'NEW_CATEGORY_ID',
                                      sbNewUsoId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Nueva Categoria(USO): ' || sbNewUsoId,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'OLD_SUBCATEGORY_ID',
                                      sbOldEstratoId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****SubCategoria(Estrato) Anterior: ' ||
                    sbOldEstratoId,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      null,
                                      'MO_BILL_DATA_CHANGE',
                                      'NEW_SUBCATEGORY_ID',
                                      sbNewEstratoId,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Nueva SubCategoria(Estrato): ' || sbNewEstratoId,
                    cnuNivelTraza);
  
    GE_BOINSTANCECONTROL.ADDATTRIBUTE(sbInstanciaActual,
                                      NULL,
                                      'MO_BILL_DATA_CHANGE',
                                      'RESTRAT_RESOLUTION',
                                      sbResolucion,
                                      GE_BOCONSTANTS.GETTRUE);
    pkg_traza.trace('*****Resolucion: ' || sbResolucion, cnuNivelTraza);
    pkg_traza.trace('***************************************************',
                    cnuNivelTraza);
  
    pkg_traza.trace('Obtener DATA de Visita a Campo', cnuNivelTraza);
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstanciaActual,
                                              NULL,
                                              'MO_PROCESS',
                                              'FLAG_1',
                                              sbVisitaCampo);
    pkg_traza.trace('Agregar DATA en INFO_ADICIONAL_SOLICITUD',
                    cnuNivelTraza);
    pkg_traza.trace('FLAG Visita a Campo: ' || sbVisitaCampo,
                    cnuNivelTraza);

    --Valida si ingresa Y para reemplazar por S
    IF UPPER(sbVisitaCampo) = 'Y' THEN 
      sbVisitaCampo := 'S';
    END IF;

    pkg_INFO_ADICIONAL_SOLICITUD.prInsertaRegistro(to_number(sbPackageId),
                                                   sbREALIZO_VISITA_EN_CAMPO,
                                                   sbVisitaCampo);
  
    pkg_traza.trace('***************************************************',
                    cnuNivelTraza);
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcPostMotivo;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcIniVisitaCampo
    Descripcion     : logica de la regla para inicializar FLAG visita a campo
    Autor           : Jorge Valiente
    Fecha           : 01-11-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcIniVisitaCampo IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcIniVisitaCampo';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbINICIO);
  
    GE_BOINSTANCECONTROL.SETENTITYATTRIBUTE('N');
  
    pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo, cnuNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcIniVisitaCampo;

END pkg_reglas_tramitecambiodeuso;
/
