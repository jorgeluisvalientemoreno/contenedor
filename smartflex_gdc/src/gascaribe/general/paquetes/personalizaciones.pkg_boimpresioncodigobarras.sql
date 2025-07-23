CREATE OR REPLACE PACKAGE personalizaciones.pkg_boImpresionCodigoBarras IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_boImpresionCodigoBarras
    Autor       :   Jhon Soto - Horbath
    Fecha       :   03-06-2025
    Descripcion :   Paquete BO con los metodos para logica de negocio para el codigo de barras 
					en la impresion de formatos de cupon de pago
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			03/06/2025	OSF-4574: Creacion
  jsoto			24/06/2025  OSF-4616  Se hicieron algunos ajustes a las consultas y
									  Se crea objeto prcObtCodigoBarrasCambCond y
									  prcObtCodigoBarrasVentasResid
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	
	PROCEDURE prcObtCodigoBarrasPagoAnticip(	inuCupon 	IN cupon.cuponume%TYPE,
										inuContrato IN cupon.cuposusc%TYPE,
										orfcursor	OUT constants_per.tyRefCursor);
										
	PROCEDURE prcObtCodigoBarrasPagoParcial(inuCupon 	IN cupon.cuponume%TYPE,
											inuContrato IN cupon.cuposusc%TYPE,
											orfcursor	OUT constants_per.tyRefCursor);
	
	PROCEDURE prcObtCodigoBarrasNegociacion(	inuCupon  IN cupon.cuponume%TYPE,
												inuSolicitud	IN mo_packages.package_id%TYPE,
												orfcursor 		OUT constants_per.tyRefCursor);

	PROCEDURE prcCodigoBarrasCotizacion(	inuSolicitud		IN mo_packages.package_id%TYPE,
											idtFechaVencimiento	IN DATE,
											orfcursor 			OUT constants_per.tyRefCursor);

	PROCEDURE prcCodigoBarrasCuotaIni(	inuSolicitud		IN mo_packages.package_id%TYPE,
										inuFactura			IN factura.factcodi%TYPE,
										orfcursor 			OUT constants_per.tyRefCursor);
										
	PROCEDURE prcObtCodigoBarrasCambCond(	inuCupon  		IN cupon.cuponume%TYPE,
											inuSolicitud	IN mo_packages.package_id%TYPE,
											orfcursor 		OUT constants_per.tyRefCursor);
											
	PROCEDURE prcObtCodigoBarrasVentasResid(	inuFactura 	IN cupon.cuponume%TYPE,
												orfcursor	OUT constants_per.tyRefCursor);


									
END pkg_boImpresionCodigoBarras;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boImpresionCodigoBarras IS

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
    
	
PROCEDURE prcObtCodigoBarrasPagoAnticip(	inuCupon 	IN cupon.cuponume%TYPE,
									inuContrato IN cupon.cuposusc%TYPE,
									orfcursor	OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtCodigoBarrasPagoAnticip
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon  y pago anticipado
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  isbCupon				Código de cupon
  inuContrato			Código de Contrato
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	dtFechaVencFactura	DATE;
	sbCodEmpresa		empresa.codigo%TYPE;
	sbCodigoBarras		VARCHAR2(200);
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCodigoBarrasPagoAnticip';
	nuCiclo				NUMBER;
    rcPeriodoActual     perifact%ROWTYPE;
	nuPeriodoActual		NUMBER;
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	pkg_traza.trace('inuContrato: '||inuContrato);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(inuContrato);
	
	rcPeriodoActual := pkg_bogestionperiodos.frcObtPeriodoFacturacionActual(nuCiclo);
	
    nuPeriodoActual := rcPeriodoActual.pefacodi;

	dtFechaVencFactura 	:= rcPeriodoActual.pefafepa;
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	sbCodigoBarras	:= pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(inuCupon,dtFechaVencFactura,sbCodEmpresa);
	
	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCodigoBarrasPagoAnticip;


PROCEDURE prcObtCodigoBarrasPagoParcial(inuCupon 	IN cupon.cuponume%TYPE,
									inuContrato IN cupon.cuposusc%TYPE,
									orfcursor	OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtCodigoBarrasPagoParcial
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon pago parcial
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  isbCupon				Código de cupon
  inuContrato			Código de Contrato
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	dtFechaVencFactura	DATE;
	sbCodigoBarras		VARCHAR2(200);
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCodigoBarrasPagoParcial';
	nuCiclo				NUMBER;
    rcPeriodoActual     perifact%ROWTYPE;
	nuPeriodoActual		NUMBER;
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	pkg_traza.trace('inuContrato: '||inuContrato);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(inuContrato);
	
	rcPeriodoActual := pkg_bogestionperiodos.frcObtPeriodoFacturacionActual(nuCiclo);
	
    nuPeriodoActual := rcPeriodoActual.pefacodi;

	dtFechaVencFactura 	:= rcPeriodoActual.pefaffmo;
	
	sbCodEmpresa 		:= pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	sbCodigoBarras		:= pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(inuCupon,dtFechaVencFactura,sbCodEmpresa);
	
	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);
	
	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;


	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCodigoBarrasPagoParcial;


PROCEDURE prcObtCodigoBarrasNegociacion(	inuCupon  		IN cupon.cuponume%TYPE,
											inuSolicitud	IN mo_packages.package_id%TYPE,
											orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtCodigoBarrasNegociacion
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago negociacion de deuda
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	dtFechaVencCupon	DATE;
	sbCodigoBarras 		VARCHAR2(200);
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCodigoBarrasNegociacion';
	nuCiclo				NUMBER;
	nuContrato			suscripc.susccodi%TYPE;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	
	BEGIN
		dtFechaVencCupon := pkg_bogestion_pagos.fdtFechaVencimientoEsperaPago(inuSolicitud);
	EXCEPTION
	WHEN OTHERS THEN
		dtFechaVencCupon := SYSDATE;
	END;
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);

	sbCodigoBarras := pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(inuCupon,dtFechaVencCupon,sbCodEmpresa);


	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);
	
	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;
				

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCodigoBarrasNegociacion;


PROCEDURE prcCodigoBarrasCotizacion(	inuSolicitud		IN mo_packages.package_id%TYPE,
										idtFechaVencimiento	IN DATE,
										orfcursor 			OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcCodigoBarrasCotizacion
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de Cotizacion
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuSolicitud			Código de la solicitud
  idtFechaVencimiento	Fecha de vigencia de la cotizacion
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCodEmpresa		empresa.codigo%TYPE;
	sbCodigoBarras 		VARCHAR2(200);
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcCodigoBarrasCotizacion';
	nuCiclo				NUMBER;
	nuContrato			NUMBER;
	nuCupon				cupon.cuponume%TYPE;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	pkg_traza.trace('idtFechaVencimiento: '||idtFechaVencimiento);
	
	nuCupon := pkg_bcpagos.fnuObtCuponSolicitud(inuSolicitud);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(nuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);

	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	sbCodigoBarras := pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(nuCupon,idtFechaVencimiento,sbCodEmpresa);

	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcCodigoBarrasCotizacion;


PROCEDURE prcCodigoBarrasCuotaIni(	inuSolicitud		IN mo_packages.package_id%TYPE,
									inuFactura			IN factura.factcodi%TYPE,
									orfcursor 			OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcCodigoBarrasCuotaIni
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de Cotizacion
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuSolicitud			Código de la solicitud
  inuFactura			Id de Factura
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbCodigoBarras		VARCHAR2(200);
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcCodigoBarrasCuotaIni';
	nuCiclo				NUMBER;
	nuContrato			NUMBER;
	nuCupon				cupon.cuponume%TYPE;
	dtFechaVencimiento	DATE;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	pkg_traza.trace('inuFactura: '||inuFactura);
	
	nuCupon := pkg_bcpagos.fnuObtCuponSolicitud(inuSolicitud);
	
	nuContrato := pkg_cupon.fnuobtcuposusc(nuCupon);
	
	dtFechaVencimiento := pkg_cupon.fdtobtcupofech(nuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);

	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	sbCodigoBarras :=  pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(nuCupon,dtFechaVencimiento,sbCodEmpresa);
	
	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;
				
   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcCodigoBarrasCuotaIni;

PROCEDURE prcObtCodigoBarrasCambCond(	inuCupon  		IN cupon.cuponume%TYPE,
										inuSolicitud	IN mo_packages.package_id%TYPE,
										orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtCodigoBarrasCambCond
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para cupon de pago cambio de condiciones
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon			   Numero de cupon de pago
  inuSolicitud		   Id de la solicitud de cambio de condiciones

  orfcursor            Retorna los datos generales del código de barras.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	dtFechaVencCupon	DATE;
	sbCodigoBarras 		VARCHAR2(200);
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCodigoBarrasCambCond';
	nuCiclo				NUMBER;
	nuContrato			suscripc.susccodi%TYPE;
	rcSolicitud			pkg_bcsolicitudes.stySolicitudes;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	
	rcSolicitud := pkg_bcsolicitudes.frcGetRecord(inuSolicitud);
	
	BEGIN
		dtFechaVencCupon := rcSolicitud.expect_atten_date;
	EXCEPTION
	WHEN OTHERS THEN
		dtFechaVencCupon := SYSDATE;
	END;
	
	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);

	sbCodigoBarras := pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(inuCupon,dtFechaVencCupon,sbCodEmpresa);

	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;
				

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCodigoBarrasCambCond;


PROCEDURE prcObtCodigoBarrasVentasResid(inuFactura 	IN cupon.cuponume%TYPE,
									orfcursor	OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtCodigoBarrasVentasResid
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para facturas de venta residencial
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuFactura			Código de factura
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	dtFechaVencFactura	DATE;
	sbCodigoBarras		VARCHAR2(200);
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtCodigoBarrasVentasResid';
	nuCiclo				NUMBER;
    rcPeriodo     		pkg_perifact.sbtRegPeriodofact;
	nuPeriodo			NUMBER;
	nuContrato			NUMBER;
	nuCupon				NUMBER;
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuFactura: '||inuFactura);
	
	nuContrato := pkg_factura.fnuobtfactsusc(inuFactura);
	
	nuPeriodo := pkg_factura.fnuobtfactpefa(inuFactura);
	
	rcPeriodo := pkg_perifact.frcObtInfoPeriodo(nuPeriodo);

	dtFechaVencFactura 	:= rcPeriodo.pefafepa;
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	nuCupon := pkg_bcpagos.fnuObtCuponSolicitud(to_char(inuFactura));
	
	sbCodigoBarras := pkg_bcImpresionCodigoBarras.fsbObtCodigoDeBarras(nuCupon,dtFechaVencFactura,sbCodEmpresa);
	
	pkg_traza.trace('sbCodigoBarras '||sbCodigoBarras);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;

	OPEN orfcursor FOR
	SELECT sbCodigoBarras code, NULL image
	FROM dual;
				
   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtCodigoBarrasVentasResid;

END pkg_boImpresionCodigoBarras;
/

PROMPT Otorgando permisos de ejecución para PERSONALIZACIONES.pkg_boImpresionCodigoBarras
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOIMPRESIONCODIGOBARRAS', 'PERSONALIZACIONES');
END;
/

