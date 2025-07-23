CREATE OR REPLACE PACKAGE pkg_uicptcb IS

    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : pkg_uicptcb
      Descripcion     : Paquete para ui de la opción CPTCB	
                        LDC - Crear Producto para Traslado de Cartera FNB

    
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 12-12-2024
    
      Parametros de Entrada
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/

    PROCEDURE prcObjeto;

    PROCEDURE prcExpresionValContrato;

END pkg_uicptcb;
/
CREATE OR REPLACE PACKAGE BODY pkg_uicptcb IS

    -- Constantes para el control de la traza
    csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
    -- Identificador del ultimo caso que hizo cambios
    csbVersion VARCHAR2(15) := 'OSF-3738';

    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      CASO            : OSF-3738

      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 12-12-2024

      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS

    BEGIN
      RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : Objeto de procesamiento del PB CPTCB

    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 12-12-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    ===========================================================================
    Autor               Fecha         Caso        Descripcion
    felipe.valencia     12/12/2024    OSF-3738    Creación
    ***************************************************************************/
    PROCEDURE prcObjeto 
    IS

        -- Nombre de este metodo
        csbMT_NAME VARCHAR2(105) := csbSP_NAME || '.prcObjeto';

        sbContrato      ge_boinstancecontrol.stysbvalue;
        sbTipoProducto  ge_boinstancecontrol.stysbvalue;
        sbPlanComercial ge_boinstancecontrol.stysbvalue;

        nuErrorCode     NUMBER;
        sbErrorMessage  VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);


        sbContrato := ge_boinstancecontrol.fsbgetfieldvalue('SUSCRIPC', 'SUSCCODI');

        sbTipoProducto := ge_boinstancecontrol.fsbgetfieldvalue('PR_PRODUCT', 'PRODUCT_TYPE_ID');

        sbPlanComercial := ge_boinstancecontrol.fsbgetfieldvalue('CC_COMMERCIAL_PLAN', 'COMMERCIAL_PLAN_ID');

        pkg_traza.trace('sbContrato: ' || sbContrato, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('sbTipoProducto: ' || sbTipoProducto, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('sbPlanComercial: ' || sbPlanComercial, pkg_traza.cnuNivelTrzDef);

		IF (sbContrato IS NULL) THEN
			pkg_traza.trace('El atributo Contrato no puede ser nulo', pkg_traza.cnuNivelTrzDef);
			Pkg_Error.SetErrorMessage(2126, 'Contrato');
		END IF;

		IF (sbTipoProducto IS NULL) THEN
			pkg_traza.trace('El atributo Tipo Producto no puede ser nulo', pkg_traza.cnuNivelTrzDef);
			Pkg_Error.SetErrorMessage(2126, 'Tipo Producto');
		END IF;

        IF (sbTipoProducto = '7055' AND sbPlanComercial IS NULL) THEN
            pkg_traza.trace('El atributo Plan Comercial no puede ser nulo', pkg_traza.cnuNivelTrzDef);
			Pkg_Error.SetErrorMessage(2126, 'Plan Comercial');
        END IF;

        pkg_bocptcb.prcObjetoCreaProducto(sbContrato,sbTipoProducto,sbPlanComercial);
 
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            raise pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            raise pkg_error.CONTROLLED_ERROR;
    END prcObjeto;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcExpresionValContrato
    Descripcion     : Objeto de validación de campo contrato del PB CPTCB

    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 12-12-2024

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    ===========================================================================
    Autor               Fecha         Caso        Descripcion
    felipe.valencia     12/12/2024    OSF-3738    Creación
    ***************************************************************************/
    PROCEDURE prcExpresionValContrato 
    IS

        -- Nombre de este metodo
        csbMT_NAME VARCHAR2(105) := csbSP_NAME || '.prcExpresionValContrato';

        sbContrato      ge_boinstancecontrol.stysbvalue;
        sbTipoProducto  ge_boinstancecontrol.stysbvalue;
        sbPlanComercial ge_boinstancecontrol.stysbvalue;

        nuErrorCode     NUMBER;
        sbErrorMessage  VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_bocptcb.prcExpresionValContrato;
 
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            raise pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace('Error: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            raise pkg_error.CONTROLLED_ERROR;
    END prcExpresionValContrato;

END pkg_uicptcb;
/
BEGIN
  pkg_utilidades.prAplicarPermisos(upper('pkg_uicptcb'), 'OPEN');
END;
/