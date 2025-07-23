CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcImpresionCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bcImpresionCliente
    Autor       :   Jhon Soto - Horbath
    Fecha       :   09-06-2025
    Descripcion :   Paquete BC con los metodos para Obtener detalle de informacion
					para cupones de pago
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			09/06/2025	OSF-4616: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

PROCEDURE prcInfoNegociacionDeuda(	inuNegociacion 	IN NUMBER, 
									isbCodEmpresa	IN empresa.codigo%TYPE,
									orfcursor 		OUT constants_per.tyRefCursor);	
									 
PROCEDURE prcInfoClienteCambioCond(	inuFinanciacion IN NUMBER, 
									isbCodEmpresa 	IN empresa.codigo%TYPE,
									orfcursor 		OUT constants_per.tyRefCursor);
								 
PROCEDURE prcInfoPagoParcial(inuCupon 		IN cupon.cuponume%TYPE, 
							 isbCodEmpresa 	IN empresa.codigo%TYPE,
							 orfcursor 		OUT constants_per.tyRefCursor);
								 

PROCEDURE prcInfoPagoAnticipado(inuCupon 		IN cupon.cuponume%TYPE, 
								isbCodEmpresa 	IN empresa.codigo%TYPE,
								orfcursor 		OUT constants_per.tyRefCursor);
										
PROCEDURE prcInfoPagoDeposito(	inuCupon 		IN cupon.cuponume%TYPE, 
								inuSolicitud	IN mo_packages.package_id%TYPE,
								inuCotizacion	IN cc_quotation.quotation_id%TYPE,
								isbCodEmpresa 	IN empresa.codigo%TYPE,
								orfcursor 		OUT constants_per.tyRefCursor);


END pkg_bcImpresionCliente;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcImpresionCliente IS

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
    
	
PROCEDURE prcInfoNegociacionDeuda(	inuNegociacion IN NUMBER, 
									isbCodEmpresa IN empresa.codigo%TYPE,
									orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcInfoNegociacionDeuda
  Descripcion    : procedimiento para extraer información detallada del cliente y cupon para el formato 
					de pago de una negociacion de deuda (LDC_PAGO_NEGOCIACION_DEUDA)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuNegociacion		Id de negociacion de deuda
  isbCodEmpresa			codigo de empresa del ciclo del cliente
  
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcInfoNegociacionDeuda';
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuNegociacion: '||inuNegociacion);
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;
	
	OPEN orfcursor FOR
		SELECT (  b.subscriber_name||' '||b.subs_last_name||' '||b.subs_second_last_name) CLIENTE
			, b.identification IDENTIFICACION
			,s.susccodi CONTRATO
			,(a.address ||'  '||
			  pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id)) DIRPROYECTO
			,pa.package_id SOLICITUD
			,cu.cupotipo TIPOCUPON
			,DECODE(cu.cuponume, NULL, 'NO SE HA GENERADO CUPON', cu.cuponume)CUPON
			,DECODE(cu.cupovalo, NULL, 'NO SE HA GENERADO CUPON', '$'||TO_CHAR(cu.cupovalo, 'fm999,999,999')) VALOR
			,'pago inmediato' VALIDOHASTA
			,'CUPON DE PAGO DE '|| (SELECT UPPER(description) FROM ps_package_type WHERE package_type_id = pa.package_type_id) TIPO_SOL
			,pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume, 
																pkg_bogestion_pagos.fdtfechavencimientoesperapago(neg.package_id),
																isbcodempresa) codigodebarras
		FROM gc_debt_negotiation neg
			 ,cupon cu
			 ,suscripc s 
			 ,ge_subscriber b
			 ,ab_address a 
			 ,mo_packages pa
		WHERE cu.cuponume = neg.coupon_id
			AND neg.package_id = pa.package_id
			AND s.susccodi = cu.cuposusc
			AND b.subscriber_id = s.suscclie
			AND a.address_id = s.susciddi
			AND neg.debt_negotiation_id =  inunegociacion
			AND cu.cupotipo = 'NG'
			AND ROWNUM = 1;


	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcInfoNegociacionDeuda;


	
PROCEDURE prcInfoClienteCambioCond(	inuFinanciacion IN NUMBER, 
									isbCodEmpresa IN empresa.codigo%TYPE,
									orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcInfoClienteCambioCond
  Descripcion    : procedimiento para extraer información detallada del cliente y cupon para el formato 
					de pago de un cambio de condiciones (LDC_CAMBIO_DE_CONDICIONES)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuFinanciacion		Id de la financiacion
  isbCodEmpresa			codigo de empresa del ciclo del cliente

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcInfoClienteCambioCond';
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuFinanciacion: '||inuFinanciacion);
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;
	

	OPEN orfcursor FOR
	SELECT (b.subscriber_name||' '||b.subs_last_name||' '||
			b.subs_second_last_name) CLIENTE
			, b.identification IDENTIFICACION
			,s.susccodi CONTRATO
			,(a.address ||'  '||
			 pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id))DIRPROYECTO
			,pa.package_id SOLICITUD
			,cu.cupotipo TIPOCUPON
			,decode(cu.cuponume, null, 'No se ha generado Cupon', cu.cuponume)CUPON
			,decode(cu.cupovalo, null, 'No se ha generado Cupon', '$'||to_char(cu.cupovalo, 'FM999,999,999'))VALOR
			,'Pago Inmediato' VALIDOHASTA
			,'CUPON DE PAGO DE '|| (SELECT UPPER(description) FROM ps_package_type WHERE package_type_id = pa.package_type_id) TIPO_SOL
			,pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume,pa.expect_atten_date,isbcodempresa) CODIGODEBARRAS
from    cc_financing_request fr
		,cupon cu
		, suscripc s
		, ge_subscriber b
		, ab_address a
		, mo_packages pa
WHERE   fr.financing_id = inuFinanciacion 
    AND fr.request_type IN('C','F')
    AND cu.cuponume = fr.coupon_id
    and cu.cupotipo = 'FI'
    and s.susccodi = cu.cuposusc
    and b.subscriber_id = s.suscclie
    and a.address_id = s.susciddi
    and fr.package_id = pa.package_id
    AND rownum = 1;

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcInfoClienteCambioCond;


PROCEDURE prcInfoPagoParcial(	inuCupon 		IN cupon.cuponume%TYPE, 
								isbCodEmpresa 	IN empresa.codigo%TYPE,
								orfcursor 		OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcInfoPagoParcial
  Descripcion    : procedimiento para extraer información detallada del cliente y cupon para el formato 
					de pago parcial (LDC_PAGO_PARCIAL)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon				Id del cupon
  isbCodEmpresa			codigo de empresa del ciclo del cliente

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcInfoPagoParcial';
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa);

	IF orfcursor%ISOPEN THEN
		CLOSE orfcursor;
	END IF;
	

	OPEN orfcursor FOR
	SELECT (b.subscriber_name||' '||b.subs_last_name||' '||
			b.subs_second_last_name) CLIENTE
			, b.identification IDENTIFICACION
			,s.susccodi CONTRATO
			,(a.address ||'  '||
			pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id))DIRPROYECTO
			,cu.cupotipo TIPOCUPON
			,DECODE(cu.cuponume, NULL, 'No se ha generado Cupon', cu.cuponume) CUPON
			,DECODE(fr.factvaap, NULL, 'No se ha generado Cupon', '$'||TO_CHAR(cu.cupovalo,'FM999,999,999,999')) VALOR
			, CASE                      
			  WHEN (pkg_bcproducto.fnuCategoria(se.sesunuse) <= 3 AND pkg_bcfacturacion.fnuContarCuentasConSaldo(se.sesunuse) >1) THEN
				'INMEDIATO'
			  ELSE TO_CHAR(pf.pefafepa,'DD-MON-YYYY') END  VALIDOHASTA
			,'CUPON DE PAGO PARCIAL' TIPO_SOL
			,pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume,pf.pefafepa,isbcodempresa) CODIGODEBARRAS
	FROM  suscripc s, servsusc se, ge_subscriber b
		 ,ab_address a, factura fr
		 ,cupon cu, perifact pf
	where cu.cupodocu = fr.factcodi
		AND s.susccicl = pf.pefacicl
		AND pf.pefaactu = 'S'
		AND s.susciddi = a.address_id
		AND s.suscclie = b.subscriber_id
		AND s.susccodi = cu.cuposusc
		AND se.sesususc = s.susccodi
		AND cu.cuponume = inuCupon
		AND rownum = 1;

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcInfoPagoParcial;


 
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcInfoPagoAnticipado
  Descripcion    : procedimiento para extraer información detallada del cliente y cupon para el formato 
					de pago anticipado (LDC_PAGO_ANTICIPADO)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon				Id del cupon
  isbCodEmpresa			codigo de empresa del ciclo del cliente

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
    PROCEDURE prcInfoPagoAnticipado(inuCupon 		IN cupon.cuponume%TYPE, 
									isbCodEmpresa 	IN empresa.codigo%TYPE,
									orfcursor 		OUT CONSTANTS_PER.tyRefCursor) AS

	nuTipoCupon         cupon.cupotipo%TYPE;
	csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcInfoPagoAnticipado';
	nuError				NUMBER;
	sbError				VARCHAR(4000);


    BEGIN
		
		pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	

        IF(inuCupon IS NOT NULL)THEN
           nuTipoCupon := pkg_cupon.fsbobtcupotipo(inuCupon);
        END IF;

		IF orfcursor%ISOPEN THEN
			CLOSE orfcursor;
		END IF;


        IF(nuTipoCupon =constants_per.csbtoken_cuenta) THEN
          OPEN orfcursor FOR
		  
            SELECT (b.subscriber_name || ' ' || b.subs_last_name || ' ' ||
                   b.subs_second_last_name) CLIENTE,
                   b.identification IDENTIFICACION,
                   s.susccodi CONTRATO,
                   (a.address || '  ' ||
					pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id))DIRPROYECTO,
                   cu.cupotipo TIPOCUPON,
                   decode(cu.cuponume, NULL, 'No se ha generado Cupon', cu.cuponume) CUPON,
                   '$' || to_char(cu.cupovalo, 'FM999,999,999') VALOR,
                   CASE
                     WHEN (pkg_bcproducto.fnuCategoria(se.sesunuse) <= 3 AND pkg_bcfacturacion.fnuContarCuentasConSaldo(se.sesunuse) >1) THEN
                      'INMEDIATO'
                     ELSE
                      to_char(pf.pefafepa, 'DD-MON-YYYY')
                   END VALIDOHASTA,
				   'CUPON DE PAGO ANTICIPADO' TIPO_SOL,
					pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume,pf.pefafepa,isbcodempresa) CODIGODEBARRAS
              FROM suscripc           s,
                   servsusc           se,
                   ge_subscriber      b,
                   ab_address         a,
                   cuencobr           cc,
                   cupon              cu,
                   perifact           pf
             WHERE cu.cupodocu = cc.cucocodi
               AND s.susccicl = pf.pefacicl
               AND pf.pefaactu = 'S'
               AND s.SUSCIDDI = a.address_id
               AND s.suscclie = b.subscriber_id
               AND s.susccodi = cu.cuposusc
               AND se.sesususc = s.susccodi
               AND cu.cuponume = inuCupon
               AND rownum = 1;
        ELSE
          OPEN orfcursor FOR
            SELECT (b.subscriber_name || ' ' || b.subs_last_name || ' ' ||
                   b.subs_second_last_name) CLIENTE,
                   b.identification IDENTIFICACION,
                   s.susccodi CONTRATO,
                   (a.address || '  ' ||
					pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id))DIRPROYECTO,
                   cu.cupotipo TIPOCUPON,
                   decode(cu.cuponume, NULL, 'No se ha generado Cupon', cu.cuponume) CUPON,
                   decode(fr.factvaap,
                          NULL,
                          'No se ha generado Cupon',
                          '$' || to_char(cu.cupovalo, 'FM999,999,999')) VALOR,
                   CASE
                     WHEN (pkg_bcproducto.fnuCategoria(se.sesunuse) <= 3 AND pkg_bcfacturacion.fnuContarCuentasConSaldo(se.sesunuse) >1) THEN
                      'INMEDIATO'
                     ELSE
                      to_char(pf.pefafepa, 'DD-MON-YYYY')
                   END VALIDOHASTA,
                   'CUPON DE PAGO ANTICIPADO' TIPO_SOL,
					pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume,pf.pefafepa,isbcodempresa) CODIGODEBARRAS
              FROM suscripc           s,
                   servsusc           se,
                   ge_subscriber      b,
                   ab_address         a,
                   factura            fr,
                   cupon              cu,
                   perifact           pf
             WHERE cu.cupodocu = fr.factcodi
               AND s.susccicl = pf.pefacicl
               AND pf.pefaactu = 'S'
               AND s.SUSCIDDI = a.address_id
               AND s.suscclie = b.subscriber_id
               AND s.susccodi = cu.cuposusc
               AND se.sesususc = s.susccodi
               AND cu.cuponume = inuCupon
               AND rownum = 1;
        END IF;

        pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin);

    EXCEPTION
	WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
    END prcInfoPagoAnticipado;


/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcInfoPagoDeposito
  Descripcion    : procedimiento para extraer información detallada del cliente y cupon para el formato 
					de pago anticipo (LDC_CUPON_DEPOSITO)
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuCupon				Id del cupon
  isbCodEmpresa			codigo de empresa del ciclo del cliente
  inuCotizacion			Id de cotizacion
  inuSolicitud			Id de solicitud

  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
    PROCEDURE prcInfoPagoDeposito(	inuCupon 		IN cupon.cuponume%TYPE, 
									inuSolicitud	IN mo_packages.package_id%TYPE,
									inuCotizacion	IN cc_quotation.quotation_id%TYPE,
									isbCodEmpresa 	IN empresa.codigo%TYPE,
									orfcursor 		OUT CONSTANTS_PER.tyRefCursor) AS

	csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcInfoPagoDeposito';
	nuError				NUMBER;
	sbError				VARCHAR(4000);
	sbNombreProyecto	VARCHAR2(500);
	nuContrato			NUMBER;
	sbDireccion			mo_address.address%TYPE;
	sbTipoSol			VARCHAR2(100);

	
    BEGIN

		pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
		
		IF orfcursor%ISOPEN THEN
			CLOSE orfcursor;
		END IF;

          OPEN orfcursor FOR
			SELECT  s.subscriber_name||' '|| subs_last_name CLIENTE,
					identification IDENTIFICACION,
					DECODE((select work_name FROM cc_quoted_work Where quotation_id = c.quotation_id),NULL,
					'No existe proyecto asociado',
					(SELECT work_name FROM cc_quoted_work WHERE quotation_id = c.quotation_id)) PROYECTO,
					(SELECT subscription_id FROM mo_motive mo WHERE mo.package_id = c.package_id) CONTRATO,
					(SELECT address FROM mo_address WHERE package_id = c.package_id) DIRPROYECTO,
					c.package_id SOLICITUD,
					c.quotation_id TIPOCUPON,
					decode((select cuponume from cupon where cupodocu = c.package_id and cupotipo = 'DE'),
					null, 'No se ha generado Cupón',
					(select cuponume from cupon where cupodocu = c.package_id and cupotipo = 'DE')) CUPON,
					'$                '||
					to_char(decode((select cupovalo from cupon where cupodocu = c.package_id and cupotipo = 'DE'),null,
				   'No se ha generado Cupón',
					(select cupovalo from cupon where cupodocu = c.package_id and cupotipo = 'DE')),'FM999,999,999') VALOR,
					to_char(c.end_date,'DD-MON-YYYY') VALIDOHASTA,
					 'CUPON DE PAGO DE ANTICIPO DE '||
					 (select upper(description) from ps_package_type ps where ps.package_type_id = p.package_type_id) TIPO_SOL,
					pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(inuCupon,c.end_date,isbCodEmpresa) CODIGODEBARRAS
			FROM cc_quotation c, ge_subscriber s, mo_packages p
			WHERE c.subscriber_id = s.subscriber_id and c.package_id = p.package_id
			AND c.quotation_id = inuCotizacion;

        pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFin);

    EXCEPTION
	WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
    END prcInfoPagoDeposito;

END pkg_bcImpresionCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_bcImpresionCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCIMPRESIONCLIENTE', 'PERSONALIZACIONES');
END;
/
