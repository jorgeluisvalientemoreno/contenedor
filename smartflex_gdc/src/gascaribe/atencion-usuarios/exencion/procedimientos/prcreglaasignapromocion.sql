CREATE OR REPLACE PROCEDURE prcReglaAsignaPromocion IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReglaAsignaPromocion
    Descripcion     : servicio para ampliar promosion de exencion asignada al producto.
    Autor           : Jorge Valiente
    Fecha           : 06-03-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    PAcosta     28/08/2024  OSF-3207   Se ajusta proceso para que se asigne el valor de 
                                       la fecha de registro de la solicitud a la variable dtFechaReg      
                                       en vez del sysdate.
  ***************************************************************************/

  csbMetodo   VARCHAR2(70) := 'prcReglaAsignaPromocion';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  nuPackageId      NUMBER;
  nuActionId       NUMBER;
  nuProductId      VARCHAR2(4000);
  nutribpromano    NUMBER;
  nuParamAttribute NUMBER;
  nuCodPromoespano NUMBER;
  nuCodPromo       NUMBER;
  dtFechaReg       VARCHAR2(4000);
  nuExisteExencion NUMBER;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  nuPackageId      := MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE;
  nuActionId       := GE_BOPARAMETER.FNUGET('ACTION_ATTEND', 'N');
  nuProductId      := PKG_BCSOLICITUDES.fnuGetProducto(nuPackageId);
  nutribpromano    := 5001542;
  nuParamAttribute := 5001392;
  nuCodPromoespano := UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(100267,
                                                                                        nutribpromano,
                                                                                        CONSTANTS_PER.GETTRUE));
  nuCodPromo       := UT_CONVERT.FNUCHARTONUMBER(PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(100267,
                                                                                        nuParamAttribute,
                                                                                        CONSTANTS_PER.GETTRUE));
  dtFechaReg       := PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO(nuPackageId);  
 
  nuExisteExencion := pkg_boexencion_contribucion.fnuValidaTipoExencionSolicitud(nuPackageId); 

  pkg_traza.trace('Producto: ' || nuProductId, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Promocion: ' || nuCodPromo, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Fecha: ' || dtFechaReg, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Solicitud: ' || nuPackageId, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Accion: ' || nuActionId, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Existe Tipo Exencion: ' || nuExisteExencion,
                  pkg_traza.cnuNivelTrzDef);

  IF (nuExisteExencion = 1) THEN
    pkg_boexencion.prcAmpliacionExencion(nuProductId,
                                         nuCodPromo,
                                         dtFechaReg,
                                         nuPackageId,
                                         nuActionId);
  END IF;

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
