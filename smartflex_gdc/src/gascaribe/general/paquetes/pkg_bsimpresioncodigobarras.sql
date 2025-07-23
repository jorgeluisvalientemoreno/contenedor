CREATE OR REPLACE PACKAGE pkg_bsImpresionCodigoBarras IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bsImpresionCodigoBarras
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-06-2025
    Descripcion :   Paquete con los metodos para configurar servicios de consulta en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			09/06/2025	OSF-4574: Creacion
  jsoto			24/05/2025  OSF-4616  Se crea prcServConsultaCambCond
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

	PROCEDURE prcServConsultaCuotaIni(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServConsultaCotizacion(orfcursor OUT constants_per.tyRefCursor);

	PROCEDURE prcServConsultaNegDeuda(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServConsultaPagoAnticipado(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServConsultaCambCond(orfcursor OUT constants_per.tyRefCursor) ;
	
	PROCEDURE prcServConsultaPagoParcial(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServConsultaFactVentaRes(orfcursor OUT constants_per.tyRefCursor);


END pkg_bsImpresionCodigoBarras;
/

CREATE OR REPLACE PACKAGE BODY pkg_bsImpresionCodigoBarras IS

    --------------------------------------------
    -- Identificador del ultimo caso que hizo cambios
    --------------------------------------------   
    csbVersion     VARCHAR2(15) := 'OSF-4616';

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
    jsoto  		03/06/2025  OSF-4574 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
	
PROCEDURE prcServConsultaPagoAnticipado(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaPagoAnticipado
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon pago anticipado
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon  			ge_boInstanceControl.stysbValue;
	sbContrato  		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaPagoAnticipado';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');
	
	sbContrato := api_obtenervalorinstancia('CUPON', 'CUPOSUSC');
	
	pkg_boImpresionCodigoBarras.prcObtCodigoBarrasPagoAnticip(TO_NUMBER(sbCupon),TO_NUMBER(sbContrato), orfcursor);

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaPagoAnticipado;

PROCEDURE prcServConsultaPagoParcial(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaPagoParcial
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon pago anticipado
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon  			ge_boInstanceControl.stysbValue;
	sbContrato  		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaPagoParcial';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');
	
	sbContrato := api_obtenervalorinstancia('CUPON', 'CUPOSUSC');
	
	pkg_boImpresionCodigoBarras.prcObtCodigoBarrasPagoParcial(TO_NUMBER(sbCupon),TO_NUMBER(sbContrato), orfcursor);

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaPagoParcial;


PROCEDURE prcServConsultaNegDeuda(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaNegDeuda
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago negociacion de deuda
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon 	 		ge_boInstanceControl.stysbValue;
	sbIdSolicitud		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaNegDeuda';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('GC_DEBT_NEGOTIATION','COUPON_ID');
	END IF;

	sbIdSolicitud := api_obtenervalorinstancia('GC_DEBT_NEGOTIATION','PACKAGE_ID');
	
	pkg_boImpresionCodigoBarras.prcObtCodigoBarrasNegociacion(TO_NUMBER(sbCupon),TO_NUMBER(sbIdSolicitud),orfcursor);

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaNegDeuda;


PROCEDURE prcServConsultaCotizacion(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaCotizacion
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago de cotizacion
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbIdSolicitud			ge_boInstanceControl.stysbValue;
	dtFechaVencCotizacion	DATE;
	nuError					NUMBER;
	sbError					VARCHAR(4000);
    csbMetodo				VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaCotizacion';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbIdSolicitud := api_obtenervalorinstancia('CC_QUOTATION','PACKAGE_ID');

	dtFechaVencCotizacion := api_obtenervalorinstancia('CC_QUOTATION','END_DATE');
	
	pkg_boImpresionCodigoBarras.prcCodigoBarrasCotizacion(TO_NUMBER(sbIdSolicitud),dtFechaVencCotizacion,orfcursor);

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaCotizacion;



PROCEDURE prcServConsultaCuotaIni(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaCuotaIni
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago cuota inicial
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbIdFactura				ge_boInstanceControl.stysbValue;
	sbIdSolicitud			ge_boInstanceControl.stysbValue;
	dtFechaVencCotizacion	DATE;
	nuError					NUMBER;
	sbError					VARCHAR(4000);
    csbMetodo				VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaCuotaIni';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbIdFactura := api_obtenervalorinstancia('FACTURA','FACTCODI');
	sbIdSolicitud := api_obtenervalorinstancia('CC_FINANCING_REQUEST','PACKAGE_ID');

	dtFechaVencCotizacion := api_obtenervalorinstancia('CC_QUOTATION','END_DATE');
	
	pkg_boImpresionCodigoBarras.prcCodigoBarrasCuotaIni(TO_NUMBER(sbIdFactura),TO_NUMBER(sbIdSolicitud),orfcursor);

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaCuotaIni;


PROCEDURE prcServConsultaCambCond(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaCambCond
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago cambio de condiciones
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon 	 		ge_boInstanceControl.stysbValue;
	sbIdSolicitud		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaCambCond';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('CC_FINANCING_REQUEST','COUPON_ID');
	END IF;

	sbIdSolicitud := api_obtenervalorinstancia('CC_FINANCING_REQUEST','PACKAGE_ID');
	
	pkg_boImpresionCodigoBarras.prcObtCodigoBarrasCambCond(TO_NUMBER(sbCupon),TO_NUMBER(sbIdSolicitud),orfcursor);

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaCambCond;


PROCEDURE prcServConsultaFactVentaRes(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaFactVentaRes
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago Factura Venta Residencial
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbFactura 	 		ge_boInstanceControl.stysbValue;
	sbIdSolicitud		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcServConsultaFactVentaRes';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbFactura := api_obtenervalorinstancia('FACTURA','FACTCODI');

	pkg_boImpresionCodigoBarras.prcObtCodigoBarrasVentasResid(TO_NUMBER(sbFactura),orfcursor);

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaFactVentaRes;


END pkg_bsImpresionCodigoBarras;
/

PROMPT Otorgando permisos de ejecución para pkg_bsImpresionCodigoBarras
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BSIMPRESIONCODIGOBARRAS', 'OPEN');
END;
/

