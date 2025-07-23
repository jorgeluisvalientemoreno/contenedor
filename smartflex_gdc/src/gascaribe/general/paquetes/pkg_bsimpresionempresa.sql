CREATE OR REPLACE PACKAGE pkg_bsImpresionEmpresa IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bsImpresionEmpresa
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-06-2025
    Descripcion :   Paquete con los metodos para configurar servicios de consulta en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			09/06/2025	OSF-4616: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

	PROCEDURE prcServConsultaEmpresa(orfcursor OUT constants_per.tyRefCursor);
	

END pkg_bsImpresionEmpresa;
/

CREATE OR REPLACE PACKAGE BODY pkg_bsImpresionEmpresa IS

    --------------------------------------------
    -- Identificador del ultimo caso que hizo cambios
    --------------------------------------------   
    csbVersion     VARCHAR2(15) := 'OSF-4730';

    --------------------------------------------
    -- Constantes para el control de la traza
    --------------------------------------------  
    csbPqt_nombre   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);   

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           :jsoto
    Fecha           : 03/06/2025
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto  		03/06/2025  OSF-4616 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
	
PROCEDURE prcServConsultaEmpresa(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaEmpresa
  Descripcion    : procedimiento para extraer los datos relacionados
                   a la empresa
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon  			ge_boInstanceControl.stysbValue;
	sbSolicitud			ge_boInstanceControl.stysbValue;
	sbFactura			ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaEmpresa';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('GC_DEBT_NEGOTIATION','COUPON_ID');
	END IF;

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('CC_FINANCING_REQUEST','COUPON_ID');
	END IF;
	
	IF sbCupon IS NULL THEN
		sbSolicitud := api_obtenervalorinstancia('CC_QUOTATION','PACKAGE_ID');
		sbCupon := to_char(pkg_bcpagos.fnuObtCuponSolicitud(to_number(sbSolicitud)));
	END IF;
	
	IF sbCupon IS NULL THEN
		sbFactura := api_obtenervalorinstancia('FACTURA','FACTCODI');
		sbCupon := to_char(pkg_bcpagos.fnuObtCuponSolicitud(to_number(sbFactura)));
	END IF;

	pkg_boimpresionempresa.prcObtEmpresaCupon(TO_NUMBER(sbCupon),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaEmpresa;


END pkg_bsImpresionEmpresa;
/

PROMPT Otorgando permisos de ejecución para pkg_bsImpresionEmpresa
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BSIMPRESIONEMPRESA', 'OPEN');
END;
/

