create or replace PACKAGE PERSONALIZACIONES.PKG_BOLDICU AS

    /**************************************************************************
    Propiedad intelectual de Gases del Caribe

    Nombre del Paquete: PKG_BOLDICU
    Descripcion : PACKAGE para manejo ejecutable LDICU.

    Autor       : Jhon Jairo Soto
    Fecha       : 26 Noviembre de 2024

    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================

   **************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;

   PROCEDURE prcProcesaLDICU(
							  inuCupoNume  IN cupon.cuponume%type
							);

END PKG_BOLDICU;
/

 CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOLDICU AS
  /**************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: PERSONALIZACIONES.PKG_BOLDICU
    Descripcion : PACKAGE para manejo de PB LDICU.

    Autor       : Jhon Jairo Soto
    Fecha       : 18 noviembre de 2024

    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================

   **************************************************************************/


    -- Declaracion de variables y tipos globales privados del paquete

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3636';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';

    /*
      Funci?n que devuelve la versi?n del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
      RETURN csbVersion;
    END FSBVERSION;


   PROCEDURE prcProcesaLDICU(
							  inuCupoNume  IN cupon.cuponume%type
							)
   IS

     --  Variables para manejo de Errores
     sbErrorMessage              VARCHAR2(2000);
     nuErrorCode                 NUMBER;
     csbMT_NAME  				 VARCHAR2(200) := csbSP_NAME || 'prcProcesaLDICU';
	 nuConfexme 				 ld_parameter.numeric_value%type;
     fblexistecupon              BOOLEAN;


   BEGIN

	pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	nuConfexme := pkg_bcld_parameter.fnuobtienevalornumerico('EXTRACT_COUPON');
	
	pkg_traza.trace('inuCupoNume: '||inuCupoNume);

	pkg_traza.trace('nuConfexme: '||nuConfexme);
	
        -- Verifica que el cupon exista.
	fblexistecupon := pkg_cupon.fblExiste(inuCupoNume);

	IF NOT fblexistecupon THEN
			pkg_error.setErrorMessage(pkg_error.cnugeneric_message,
										'Cupon no existe'
									  );
	END IF;


	pkg_boimpresion_cupon.prcImprimirCupon(nuConfexme,inuCupoNume);

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuerrorcode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuerrorcode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;

   END prcProcesaLDICU;


END  PKG_BOLDICU;
/

PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOLDICU', 'PERSONALIZACIONES');
END;
/