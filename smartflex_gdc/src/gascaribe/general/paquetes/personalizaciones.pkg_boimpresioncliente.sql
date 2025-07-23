CREATE OR REPLACE PACKAGE personalizaciones.pkg_boImpresionCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_boImpresionCliente
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-06-2025
    Descripcion :   Paquete BO con los metodos para implementar la logica de negocio
					para los formatos de cupones de pago en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			09/06/2025	OSF-4616: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

	PROCEDURE prcObtNegociacionDeuda(	inuNegociacion 	IN NUMBER, 
										inuCupon 		IN NUMBER,
										orfcursor 		OUT constants_per.tyRefCursor);
										
	PROCEDURE prcObtCambioCondiciones(	inuFinanciacion 	IN NUMBER, 
										inuCupon 		IN NUMBER,
										orfcursor 		OUT constants_per.tyRefCursor);

	PROCEDURE prcObtPagoParcial(	
									inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor);	
										
	PROCEDURE prcObtPagoAnticipado(	inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor);
									
PROCEDURE prcObtPagoDeposito	(inuCotizacion	IN cc_quotation.quotation_id%TYPE,
									inuSolicitud 	IN mo_packages.package_id%TYPE,
									orfcursor 		OUT constants_per.tyRefCursor);

END pkg_boImpresionCliente;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boImpresionCliente IS

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
    
	
PROCEDURE prcObtNegociacionDeuda(	inuNegociacion 	IN NUMBER, 
									inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNIDAD         : prcObtNegociacionDeuda
  Descripcion    : procedimiento para extraer los datos relacionados al cliente y cupon en el 
				   formato para pago de cuota inicial de negociacion de deuda (LDC_PAGO_NEGOCIACION_DEUDA)
                   
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuNegociacion		Id de Negociacion de deuda
  inuCupon				Id de cupon de pago
  
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtNegociacionDeuda';
	nuContrato			NUMBER;
	nuCiclo				NUMBER;
	sbCodEmpresa		VARCHAR2(4);

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuNegociacion: '||inuNegociacion);
	pkg_traza.trace('inuCupon: '||inuCupon);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	pkg_bcimpresioncliente.prcInfoNegociacionDeuda(inuNegociacion,sbCodEmpresa,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtNegociacionDeuda;

PROCEDURE prcObtCambioCondiciones(	inuFinanciacion 	IN NUMBER, 
									inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNIDAD         : prcObtCambioCondiciones
  Descripcion    : procedimiento para extraer los datos relacionados al cliente y cupon en el 
				   formato para pago de cuota inicial de financiacion cambio de condiciones
				   (LDC_CAMBIO_DE_CONDICIONES)
   Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuNegociacion		Id de Financiacion
  inuCupon				Id de cupon de pago

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCambioCondiciones';
	nuContrato			NUMBER;
	nuCiclo				NUMBER;
	sbCodEmpresa		VARCHAR2(4);

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuFinanciacion: '||inuFinanciacion);
	pkg_traza.trace('inuCupon: '||inuCupon);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	pkg_bcimpresioncliente.prcInfoClienteCambioCond(inuFinanciacion,sbCodEmpresa,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCambioCondiciones;


PROCEDURE prcObtPagoParcial(	
									inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNIDAD         : prcObtPagoParcial
  Descripcion    : procedimiento para extraer los datos relacionados al cliente y cupon en el 
				   formato para pago de parcial (LDC_PAGO_PARCIAL)
   Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon				Id de cupon de pago

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtPagoParcial';
	nuContrato			NUMBER;
	nuCiclo				NUMBER;
	sbCodEmpresa		VARCHAR2(4);

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	pkg_bcimpresioncliente.prcInfoPagoParcial(inuCupon,sbCodEmpresa,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtPagoParcial;



PROCEDURE prcObtPagoAnticipado(	
									inuCupon 		IN NUMBER,
									orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNIDAD         : prcObtPagoAnticipado
  Descripcion    : procedimiento para extraer los datos relacionados al cliente y cupon en el 
				   formato para pago anticipado  (LDC_PAGO_ANTICIPADO)
   Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon				Id de cupon de pago

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtPagoAnticipado';
	nuContrato			NUMBER;
	nuCiclo				NUMBER;
	sbCodEmpresa		VARCHAR2(4);

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	pkg_bcimpresioncliente.prcInfoPagoAnticipado(inuCupon,sbCodEmpresa,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtPagoAnticipado;


PROCEDURE prcObtPagoDeposito(inuCotizacion	IN cc_quotation.quotation_id%TYPE,
									inuSolicitud 	IN mo_packages.package_id%TYPE,
									orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNIDAD         : prcObtPagoDeposito
  Descripcion    : procedimiento para extraer los datos relacionados al cliente y cupon en el 
				   formato para pago de deposito por cotizaciones (LDC_CUPON_DEPOSITO)
   Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuSolicitud			Id de solicitud
  inuCotizacion			Id de la cotizacion

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtPagoDeposito';
	nuContrato			NUMBER;
	nuCiclo				NUMBER;
	sbCodEmpresa		empresa.codigo%TYPE;
	nuCupon				cupon.cuponume%TYPE;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	pkg_traza.trace('inuCotizacion: '||inuCotizacion);
	
	nuCupon := pkg_bcpagos.fnuObtCuponSolicitud(to_char(inuSolicitud));
	
	IF nuCupon IS NOT NULL THEN
		nuContrato := pkg_cupon.fnuobtcuposusc(nuCupon);
		nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
		sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	END IF;
	
	pkg_bcimpresioncliente.prcInfoPagoDeposito(nuCupon,inuSolicitud,inuCotizacion,sbCodEmpresa,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtPagoDeposito;


END pkg_boImpresionCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_boImpresionCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOIMPRESIONCLIENTE', 'PERSONALIZACIONES');
END;
/

