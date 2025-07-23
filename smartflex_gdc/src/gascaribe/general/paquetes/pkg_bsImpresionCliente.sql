CREATE OR REPLACE PACKAGE pkg_bsImpresionCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bsImpresionCliente
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
	

	PROCEDURE prcConsultaNegociacionDeuda(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcConsultaCambioCondiciones(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcConsultaPagoParcial(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcConsultaPagoAnticipado(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcConsPagoDeposito(orfcursor OUT constants_per.tyRefCursor);
	

END pkg_bsImpresionCliente;
/

CREATE OR REPLACE PACKAGE BODY pkg_bsImpresionCliente IS

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
    jsoto  		03/06/2025  OSF-4616 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
	
PROCEDURE prcConsultaNegociacionDeuda(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcConsultaNegociacionDeuda
  Descripcion    : procedimiento para extraer los datos del cliente y el cupon 
				   para impresion de formato negociacion de deuda (LDC_PAGO_NEGOCIACION_DEUDA)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbNegociacion  		ge_boInstanceControl.stysbValue;
	sbCUpon  			ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcConsultaNegociacionDeuda';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbNegociacion := api_obtenervalorinstancia('GC_DEBT_NEGOTIATION','DEBT_NEGOTIATION_ID');
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('GC_DEBT_NEGOTIATION','COUPON_ID');
	END IF;

	pkg_boimpresioncliente.prcObtNegociacionDeuda(TO_NUMBER(sbNegociacion),TO_NUMBER(sbCupon),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcConsultaNegociacionDeuda;


PROCEDURE prcConsultaCambioCondiciones(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcConsultaCambioCondiciones
  Descripcion    : pprocedimiento para extraer los datos del cliente y el cupon 
				   para impresion de formato cambio de condiciones (LDC_CAMBIO_DE_CONDICIONES)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbFinanciacion  	ge_boInstanceControl.stysbValue;
	sbCupon  			ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcConsultaCambioCondiciones';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbFinanciacion := api_obtenervalorinstancia('CC_FINANCING_REQUEST','FINANCING_ID');
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	IF sbCupon IS NULL THEN
		sbCupon := api_obtenervalorinstancia('CC_FINANCING_REQUEST','COUPON_ID');
	END IF;

	pkg_boimpresioncliente.prcObtCambioCondiciones(TO_NUMBER(sbFinanciacion),TO_NUMBER(sbCupon),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcConsultaCambioCondiciones;


PROCEDURE prcConsultaPagoParcial(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcConsultaPagoParcial
  Descripcion    : pprocedimiento para extraer los datos del cliente y el cupon 
				   para impresion de formato pago parcial y anticipado (LDC_PAGO_PARCIAL)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbFinanciacion  	ge_boInstanceControl.stysbValue;
	sbCupon  			ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcConsultaPagoParcial';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	pkg_boimpresioncliente.prcObtPagoParcial(TO_NUMBER(sbCupon),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcConsultaPagoParcial;


PROCEDURE prcConsultaPagoAnticipado(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcConsultaPagoAnticipado
  Descripcion    : pprocedimiento para extraer los datos del cliente y el cupon 
				   para impresion de formato pago parcial y anticipado  (LDC_PAGO_ANTICIPADO)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCupon  			ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcConsultaPagoAnticipado';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCupon := api_obtenervalorinstancia('CUPON', 'CUPONUME');

	pkg_boimpresioncliente.prcObtPagoAnticipado(TO_NUMBER(sbCupon),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcConsultaPagoAnticipado;


PROCEDURE prcConsPagoDeposito(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcConsPagoDeposito
  Descripcion    : pprocedimiento para extraer los datos del cliente y el cupon 
				   para impresion de formato de anticipo (LDC_CUPON_DEPOSITO)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCotizacion  		ge_boInstanceControl.stysbValue;
	sbSolicitud  		ge_boInstanceControl.stysbValue;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcConsPagoDeposito';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbCotizacion := api_obtenervalorinstancia('CC_QUOTATION','QUOTATION_ID');
	
	sbSolicitud :=  api_obtenervalorinstancia('CC_QUOTATION','PACKAGE_ID');

	pkg_boimpresioncliente.prcObtPagoDeposito(TO_NUMBER(sbCotizacion),TO_NUMBER(sbSolicitud),orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcConsPagoDeposito;

END pkg_bsImpresionCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_bsImpresionCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BSIMPRESIONCLIENTE', 'OPEN');
END;
/
