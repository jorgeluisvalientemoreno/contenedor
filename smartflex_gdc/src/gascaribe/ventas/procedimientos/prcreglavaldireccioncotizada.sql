CREATE OR REPLACE PROCEDURE prcReglaValDireccionCotizada IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReglaValDireccionCotizada
    Descripcion     : servicio para validar datos de la direccion relacionada a la venta de gas cotizada.
    Autor           : Jorge Valiente
    Fecha           : 06-11-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  csbMetodo   VARCHAR2(70) := 'prcReglaValDireccionCotizada';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  sbInstance   VARCHAR2(4000);
  inuAddressID VARCHAR2(4000);
  nuCiclo      NUMBER;
  nuCotiza     VARCHAR2(4000);

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);
  pkg_traza.trace('Nombre Instancia: ' || sbInstance,
                  pkg_traza.cnuNivelTrzDef);

  GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuAddressID);
  pkg_traza.trace('Codigo Direccion: ' || inuAddressID,
                  pkg_traza.cnuNivelTrzDef);

  CF_BORegisterRulesCrm.LoadAddress(sbInstance, inuAddressID);
  pkg_traza.trace('Ejecutar servicio CF_BORegisterRulesCrm.LoadAddress',
                  pkg_traza.cnuNivelTrzDef);

  nuCiclo := pkg_bodirecciones.fnuObtieneCicloVentas(inuAddressID);
  pkg_traza.trace('Ciclo Obtenido: ' || nuCiclo, pkg_traza.cnuNivelTrzDef);

  GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,
                                            null,
                                            'SUSCRIPC',
                                            'SUSCCICL',
                                            nuCiclo);
  pkg_traza.trace('Asignar valor[' || nuCiclo || '] al atributo SUSCCICL' ||
                  sbInstance,
                  pkg_traza.cnuNivelTrzDef);

  GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,
                                            null,
                                            'SUSCRIPC',
                                            'SUSCIDDI',
                                            inuAddressID);
  pkg_traza.trace('Asignar valor[' || inuAddressID ||
                  '] al atributo SUSCIDDI' || sbInstance,
                  pkg_traza.cnuNivelTrzDef);

  GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,
                                            null,
                                            'MO_PACKAGES_ASSO',
                                            'PACKAGE_ID_ASSO',
                                            nuCotiza);
  pkg_traza.trace('Obtener valor[' || nuCotiza ||
                  '] del atributo PACKAGE_ID_ASSO' || sbInstance,
                  pkg_traza.cnuNivelTrzDef);

  CC_BOQUOTATIONMGR.VALIDATEADDRESSQUOTATION(nuCotiza, inuAddressID);
  pkg_traza.trace('Ejecucion del servicio CC_BOQUOTATIONMGR.VALIDATEADDRESSQUOTATION',
                  pkg_traza.cnuNivelTrzDef);

  LDC_BOINFOADDRESS.VALINFOPREMISE(inuAddressID);
  pkg_traza.trace('Ejecucion del servicio LDC_BOINFOADDRESS.VALINFOPREMISE',
                  pkg_traza.cnuNivelTrzDef);

  pkg_boinfopredio.prcValidaPredioCastigado(inuAddressID);
  pkg_traza.trace('Ejecucion del servicio pkg_boinfopredio.prcValidaPredioCastigado',
                  pkg_traza.cnuNivelTrzDef);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
  
END;
/
