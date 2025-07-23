CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcImpresionCertificCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bcImpresionCertificCliente
    Autor       :   Jhon Soto - Horbath
    Fecha       :   01-07-2025
    Descripcion :   Paquete con los metodos para logica de negocio para servicios de consulta en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			01/07/2025	OSF-4730: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

	PROCEDURE prcDatosGenCertEstadoCuenta(	inuIdMotivo	IN NUMBER,
											orfcursor OUT constants_per.tyRefCursor);
	

	PROCEDURE prcDatoUbicacionGeografica(	inuIdMotivo	IN NUMBER,
											isbDescLocalidad IN VARCHAR2,
											orfcursor OUT constants_per.tyRefCursor);
											
	PROCEDURE prcObtDatosConstanciaPagos(	inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
											isbNombreEmpresa	IN	empresa.nombre%TYPE,
											isbLocalidadEmpresa	IN	VARCHAR2,
											orfcursor 		OUT constants_per.tyRefCursor);
											
	PROCEDURE prcObtFechasConstanciaPagos(	inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
											orfcursor 		OUT constants_per.tyRefCursor);
											
    PROCEDURE prcObtDetalleConstanciaPagos(	inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
											orfcursor 		OUT constants_per.tyRefCursor);

END pkg_bcImpresionCertificCliente;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcImpresionCertificCliente IS

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
    jsoto  		03/06/2025  OSF-4730 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
	
PROCEDURE prcDatosGenCertEstadoCuenta(	inuIdMotivo	IN NUMBER,
										orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDatosGenCertEstadoCuenta
  Descripcion    : procedimiento para extraer los datos generales del certificado de estado de cuenta
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcDatosGenCertEstadoCuenta';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
    OPEN orfcursor FOR
      SELECT distinct pkg_boConsultaEmpresa.fsbObtNombreEmpresaContrato(susccodi) NOM_EMPRESA,
                      suscripc.susccodi CONTRATO,
                      fsbencriptadireccion(add_susc.address_parsed)DIRECCION,
                      geo_susc.description MUNICIPIO,
                      fsbencriptacadena(client.subscriber_name || ' ' ||
                      client.subs_last_name) NOMBRE_CLIENTE,
                      contact.subscriber_name || ' ' ||
                      contact.subs_last_name NOM_SOLICITANTE,
                      contact.identification DOC_SOLICITANTE,
                      mo_packages.request_date    FECHA,
                      mo_motive.prov_initial_date FECHA_INICIAL,
                      mo_motive.prov_final_date   FECHA_FINAL
        FROM mo_motive,
             mo_packages,
             suscripc,
             or_operating_unit,
             ab_address         add_susc,
             ge_geogra_location geo_susc,
             ge_subscriber      client,
             ge_subscriber      contact
       WHERE mo_motive.motive_id = inuIdMotivo
         AND mo_motive.package_id = mo_packages.package_id
         AND mo_motive.subscription_id = suscripc.susccodi
         AND suscripc.susciddi = add_susc.address_id
         AND add_susc.geograp_location_id = geo_susc.geograp_location_id
         AND suscripc.suscclie = client.subscriber_id
         AND mo_packages.contact_id = contact.subscriber_id
         AND mo_packages.pos_oper_unit_id = or_operating_unit.operating_unit_id;
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcDatosGenCertEstadoCuenta;


PROCEDURE prcDatoUbicacionGeografica(	inuIdMotivo	IN NUMBER,
										isbDescLocalidad IN VARCHAR2,
										orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDatoUbicacionGeografica
  Descripcion    : procedimiento para extraer la descripcion de ubicacion geográfica
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcDatoUbicacionGeografica';
	
BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	pkg_traza.trace('isbDescLocalidad: '||isbDescLocalidad);

    OPEN orfcursor FOR
     SELECT NVL(DECODE(REGEXP_COUNT(or_operating_unit.address,
                                     '.*?\' || ','),
                        0,
                        (isbDescLocalidad),
                        or_operating_unit.address),
                 NULL) CIUDAD
        FROM mo_motive, mo_packages, or_operating_unit
       WHERE mo_motive.motive_id = inuIdMotivo
         AND mo_motive.package_id = mo_packages.package_id
         AND mo_packages.pos_oper_unit_id =
             or_operating_unit.operating_unit_id;

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcDatoUbicacionGeografica;



/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtDatosConstanciaPagos
  Descripcion    : procedimiento para extraer los datos generales para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  isbNombreEmpresa	   Nombre de la empresa
  isbLocalidadEmpresa  localidad de la empresa

  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  Creacion
****************************************************************************/

    PROCEDURE prcObtDatosConstanciaPagos
    (
		inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
		isbNombreEmpresa	IN	empresa.nombre%TYPE,
		isbLocalidadEmpresa	IN	VARCHAR2,
        orfcursor 		OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
		csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcObtDatosConstanciaPagos';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    
		
		pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
		pkg_traza.trace('isbNombreEmpresa: '||isbNombreEmpresa);

		
		OPEN orfcursor FOR
		SELECT  isbNombreEmpresa NOM_EMPRESA,
				suscripc.susccodi               CONTRATO,
				fsbencriptadireccion(add_susc.address_parsed) DIRECCION,
				geo_susc.description            MUNICIPIO,
				fsbencriptacadena(client.subscriber_name) NOMBRE_CLIENTE,
				fsbencriptacadena(client.subs_last_name)  APELLIDO_CLIENTE,
				(SELECT contact.subscriber_name||' '||contact.subs_last_name
				FROM ge_subscriber contact WHERE mo_packages.contact_id= contact.subscriber_id) NOM_SOLICITANTE,
				(SELECT contact.identification
				FROM ge_subscriber contact WHERE mo_packages.contact_id= contact.subscriber_id)DOC_SOLICITANTE,
				(SELECT GE.description FROM or_operating_unit OP, ab_address DIR, ge_geogra_location GE
				WHERE OP.operating_unit_id=mo_packages.pos_oper_unit_id
				AND OP.starting_address=DIR.address_id
				AND DIR.geograp_location_id = GE.geograp_location_id) MUN_SOLICITANTE,
				TO_CHAR(mo_packages.request_date,'dd/mm/yyyy') FECHA,
				TO_CHAR(mo_packages.request_date,'DD') DIA,
				TO_CHAR(mo_packages.request_date,'MM') MES,
				TO_CHAR(mo_packages.request_date,'YYYY') ANO,
				isbLocalidadEmpresa MUNICIPIO_ATENCION
		FROM    mo_motive, 
				mo_packages, 
				suscripc, 
				ab_address add_susc, 
				ge_geogra_location  
				geo_susc,
				ge_subscriber client
		WHERE   mo_motive.motive_id         = inuIdMotivo
		AND     mo_motive.package_id        = mo_packages.package_id
		AND     mo_motive.subscription_id   = suscripc.susccodi
		AND     suscripc.susciddi           = add_susc.address_id
		AND     add_susc.geograp_location_id= geo_susc.geograp_location_id
		AND     suscripc.suscclie           = client.subscriber_id;
	

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcObtDatosConstanciaPagos;

/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtFechasConstanciaPagos
  Descripcion    : procedimiento para extraer las fechas para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4703  Creacion
****************************************************************************/

    PROCEDURE prcObtFechasConstanciaPagos
    (
		inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
        orfcursor 		OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
		csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcObtFechasConstanciaPagos';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    
		
		pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
		
		OPEN orfcursor FOR
			SELECT TO_CHAR(mo_motive.prov_initial_date,'DD/MM/YYYY') FECHAINI,
				   TO_CHAR(mo_motive.prov_final_date, 'DD/MM/YYYY') FECHAFIN,
				   TO_CHAR(prov_initial_date,'MON') MESINI,
				   TO_CHAR(prov_initial_date,'YYYY') ANOINI,
				   TO_CHAR(prov_final_date,'MON') MESFIN,
				   TO_CHAR(prov_final_date,'YYYY') ANOFIN
			FROM mo_motive
			WHERE mo_motive.motive_id = inuIdMotivo;
	

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcObtFechasConstanciaPagos;


/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtDetalleConstanciaPagos
  Descripcion    : procedimiento para obtener detalles para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4703  Creacion
****************************************************************************/

    PROCEDURE prcObtDetalleConstanciaPagos
    (
		inuIdMotivo		IN 	mo_motive.motive_id%TYPE,
        orfcursor 		OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcObtDetalleConstanciaPagos';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    
		
		pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
		
		OPEN orfcursor FOR
				SELECT 
					pkg_bcproducto.fnutipoproducto(cargnuse) tip_prod,
					pkg_servicio.fsbobtdescripcion(pkg_bcproducto.fnutipoproducto(cargnuse)) TIPOPRODUCTO,
					TO_CHAR(pkg_factura.fdtobtfactfege(cucofact),'DD/MM/YYYY')FECHAGENFAC,
					CASE WHEN cargcuco = (SELECT MAX(cargcuco) FROM cargos t WHERE t.cargsign = 'PA' AND t.cargcodo = pagocupo) THEN
					(SELECT SUM(cargvalo) FROM cargos t WHERE t.cargsign = 'PA' AND t.cargcodo = pagocupo)
					ELSE
					0
					END TOTALFACT,
					TO_CHAR(pagos.pagofepa, 'DD/MM/YYYY') FECHARECAUDO,
					cargcuco CUENTACOBROPAGO,
					cargvalo VALORRECAUDO,
					TO_CHAR(pagos.pagofegr, 'DD/MM/YYYY') FECHAAPLICACIONRECAUDO,
					(SELECT subanomb
					FROM sucubanc
					WHERE sucubanc.subabanc = pagos.pagobanc
					AND sucubanc.subacodi = pagos.pagosuba) ENTIDADRECAUDADORA
				FROM pagos, mo_motive, cargos, cuencobr
				where mo_motive.motive_id = inuIdMotivo
					AND mo_motive.subscription_id = pagos.pagosusc
					AND cargcodo = pagocupo
					AND TRUNC(pagos.pagofepa) >= mo_motive.prov_initial_date
					AND TRUNC(pagos.pagofepa) <= mo_motive.prov_final_date
					AND cargos.cargsign ='PA'
					AND cargos.cargcuco = cuencobr.cucocodi
				ORDER BY pagos.pagofepa, tip_prod ASC;
	

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcObtDetalleConstanciaPagos;
	
END pkg_bcImpresionCertificCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_bcImpresionCertificCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCIMPRESIONCERTIFICCLIENTE', 'PERSONALIZACIONES');
END;
/

