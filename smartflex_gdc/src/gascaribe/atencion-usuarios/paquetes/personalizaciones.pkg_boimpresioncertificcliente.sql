CREATE OR REPLACE PACKAGE personalizaciones.pkg_boImpresionCertificCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_boImpresionCertificCliente
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
											orfcursor 	OUT constants_per.tyRefCursor);
											
	PROCEDURE prcDatoUbicacionGeografica(	inuIdMotivo	IN NUMBER,
												orfcursor OUT constants_per.tyRefCursor);
												
	PROCEDURE prcDatosConstanciaPagos(	inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
										orfcursor 	OUT constants_per.tyRefCursor);
										
	PROCEDURE prcFechasConstanciaPagos(	inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
										orfcursor 	OUT constants_per.tyRefCursor);
										
	PROCEDURE prcDetalleConstanciaPagos(	inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
											orfcursor 	OUT constants_per.tyRefCursor);	

	PROCEDURE prcDatosCertPazySalvo (
										inuSolicitud	IN  NUMBER,
										orfcursor 		OUT constants_per.tyRefCursor
									);
	

END pkg_boImpresionCertificCliente;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boImpresionCertificCliente IS

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
										orfcursor 	OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDatosGenCertEstadoCuenta
  Descripcion    : procedimiento para extraer los datos generales del certificado de estado de cuenta
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		 id del Motivo
  orfcursor          Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcDatosGenCertEstadoCuenta';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	

	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	
	pkg_bcImpresionCertificCliente.prcDatosGenCertEstadoCuenta(inuIdMotivo,orfcursor);
	
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
										orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDatoUbicacionGeografica
  Descripcion    : procedimiento para extraer los datos generales del certificado de estado de cuenta
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
	
	nuSolicitud			NUMBER;
	nuContrato			NUMBER;
	sbCodEmpresa		VARCHAR2(10);
	nuLocalidad			NUMBER;
	sbDescLocalidad		VARCHAR2(200);
	rcEmpresa			empresa%ROWTYPE;

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	

	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	
	nuSolicitud := pkg_bcsolicitudes.fnuGetSolicitudDelMotivo(inuIdMotivo);
	
	nuContrato := pkg_bcsolicitudes.fnuGetContrato(nuSolicitud);
	
	sbCodEmpresa := pkg_boConsultaEmpresa.fsbObtEmpresaContrato(nuContrato);
	
	rcEmpresa := pkg_empresa.frcObtieneRegistro(sbCodEmpresa);
	
	nuLocalidad := rcEmpresa.localidad;
	
	sbDescLocalidad := INITCAP(pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(nuLocalidad));

	pkg_bcImpresionCertificCliente.prcDatoUbicacionGeografica(inuIdMotivo,sbDescLocalidad,orfcursor);

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

  UNID         : prcDatosConstanciaPagos
  Descripcion    : procedimiento para extraer los datos generales para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4730 Creacion
****************************************************************************/

    PROCEDURE prcDatosConstanciaPagos
    (
		inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
        orfcursor 	OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbPqt_nombre||'prcDatosConstanciaPagos';
		
		nuSolicitud			NUMBER;
		nuContrato			NUMBER;
		sbCodEmpresa		VARCHAR2(10);
		sbNombreEmpresa		VARCHAR2(200);
		nuLocalidadEmpresa	NUMBER;
		sbLocalidadEmpresa	VARCHAR2(200);
		rcEmpresa			empresa%ROWTYPE;

    BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	
	nuSolicitud := pkg_bcsolicitudes.fnuGetSolicitudDelMotivo(inuIdMotivo);
	
	nuContrato := pkg_bcsolicitudes.fnuGetContrato(nuSolicitud);
	
	sbCodEmpresa := pkg_boConsultaEmpresa.fsbObtEmpresaContrato(nuContrato);
	
	rcEmpresa := pkg_empresa.frcObtieneRegistro(sbCodEmpresa);	
	
	sbNombreEmpresa := rcEmpresa.nombre;
	
	nuLocalidadEmpresa := rcEmpresa.localidad;
	sbLocalidadEmpresa := pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(nuLocalidadEmpresa);


	pkg_bcImpresionCertificCliente.prcObtDatosConstanciaPagos(inuIdMotivo,sbNombreEmpresa,sbLocalidadEmpresa,orfcursor);
	
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcDatosConstanciaPagos;

/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcFechasConstanciaPagos
  Descripcion    : procedimiento para extraer los datos generales para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4730 Creacion
****************************************************************************/

    PROCEDURE prcFechasConstanciaPagos
    (
		inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
        orfcursor 	OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbPqt_nombre||'prcFechasConstanciaPagos';

    BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	
	pkg_bcImpresionCertificCliente.prcObtFechasConstanciaPagos(inuIdMotivo,orfcursor);
	
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcFechasConstanciaPagos;
	

/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDetalleConstanciaPagos
  Descripcion    : procedimiento para extraer los datos detalle de pagos para el formato 
				   certificado constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuIdMotivo		   Id del Motivo
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4730 Creacion
****************************************************************************/

    PROCEDURE prcDetalleConstanciaPagos
    (
		inuIdMotivo	IN 	mo_motive.motive_id%TYPE,
        orfcursor 	OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbPqt_nombre||'prcDetalleConstanciaPagos';

    BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

	pkg_traza.trace('inuIdMotivo: '||inuIdMotivo);
	
	pkg_bcImpresionCertificCliente.prcObtDetalleConstanciaPagos(inuIdMotivo,orfcursor);
	
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcDetalleConstanciaPagos;


/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcDatosCertPazySalvo
  Descripcion    : procedimiento para extraer los datos para el formato 
				   paz y salvo
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  inuSolicitud		   Id de la solicitud
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  08/07/2025		jsoto			  OSF-4730 Creacion
****************************************************************************/

    PROCEDURE prcDatosCertPazySalvo
    (
		inuSolicitud	IN  NUMBER,
        orfcursor 		OUT constants_per.tyRefCursor
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  			CONSTANT VARCHAR2(100) := csbPqt_nombre||'prcDatosCertPazySalvo';
		nuProducto 			NUMBER;
		nuContrato			NUMBER;
		sbCodEmpresa		empresa.codigo%TYPE;
		sbNombreEmpresa		empresa.nombre%TYPE;
		rcEmpresa			empresa%ROWTYPE;
		nuLocalidadEmpresa	empresa.localidad%TYPE;
		sbLocalidadEmpresa	VARCHAR2(200);
		nuCliente			NUMBER;
		sbNombresCliente	VARCHAR2(200);
		sbApellidosCliente	VARCHAR2(200);
		nuContacto			NUMBER;
		sbNombresContacto	VARCHAR2(200);
		sbApellidosContacto	VARCHAR2(200);
		sbIdentifContacto	VARCHAR2(200);
		nuTipoProducto		NUMBER;
		sbDescServicio		VARCHAR2(200);
		nuIdDireccion		NUMBER;
		sbDireccion			VARCHAR2(200);
		nuIdLocalidad		NUMBER;
		sbMunicipio			VARCHAR2(200);
		nuIdDepartamento	NUMBER;
		sbDepartamento		VARCHAR2(200);
		sbMensaje			VARCHAR2(4000);
		sbNumFormulario		VARCHAR2(200);
		
	
    BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

	pkg_traza.trace('inuSolicitud: '||inuSolicitud);
	
	nuProducto := pkg_bcsolicitudes.fnuGetProducto(inuSolicitud);
	nuTipoProducto := pkg_bcproducto.fnuTipoProducto(nuProducto);
	sbDescServicio := pkg_servicio.fsbObtDescripcion(nuTipoProducto);

	nuContrato := pkg_bcsolicitudes.fnuGetContrato(inuSolicitud);
	
	sbCodEmpresa := pkg_boConsultaEmpresa.fsbObtEmpresaProducto(nuProducto);
	rcEmpresa := pkg_empresa.frcObtieneRegistro(sbCodEmpresa);	
	sbNombreEmpresa := rcEmpresa.nombre;
	nuLocalidadEmpresa := rcEmpresa.localidad;
	sbLocalidadEmpresa := pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(nuLocalidadEmpresa);
	
	nuCliente := pkg_bcsolicitudes.fnuGetCliente(inuSolicitud);
	sbNombresCliente := pkg_bccliente.fsbNombres(nuCliente);
	sbApellidosCliente := pkg_bccliente.fsbApellidos(nuCliente);

	nuContacto := pkg_bcsolicitudes.fnuGetContacto(inuSolicitud);
	sbNombresContacto := pkg_bccliente.fsbNombres(nuContacto);
	sbApellidosContacto := pkg_bccliente.fsbApellidos(nuContacto);
	sbIdentifContacto := pkg_bccliente.fsbIdentificacion(nuContacto);
	
	nuIdDireccion := pkg_bcproducto.fnuIdDireccInstalacion(nuProducto);
	sbDireccion := pkg_bcdirecciones.fsbGetDireccion(nuIdDireccion);
	
	nuIdLocalidad := pkg_bcproducto.fnuObtenerLocalidad(nuProducto);
	sbMunicipio := pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(nuIdLocalidad);
	
	nuIdDepartamento := pkg_bcdirecciones.fnuGetDepartamento(nuIdDireccion);
	sbDepartamento := pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(nuIdDepartamento);
	
	
	IF nuTipoProducto =  pkg_bcld_parameter.fnuObtieneValorNumerico('COD_SERV_GAS') THEN
		sbMensaje := ' que el servicio ubicado en la dirección ' ||
					  sbDireccion || ' del municipio ' ||
					  sbMunicipio || ' con el contrato No. ' || nuContrato ||
					  ' a nombre de ' ||
					  sbNombresCliente || ' ' || sbApellidosCliente
						|| ' se encuentra a PAZ Y SALVO con la empresa por todo ' ||
					  'concepto del servicio de GAS NATURAL. Así mismo se dio por terminado el contrato de prestación de servicio público domiciliario de gas natural.';
			  
	ELSIF nuTipoProducto =  pkg_bcld_parameter.fnuObtieneValorNumerico('COD_PRODUCT_TYPE_BRILLA') THEN
	
		sbNumFormulario := ldc_fsbnumformulario(nuProducto);
		
		IF sbNumFormulario IS NULL THEN
				sbMensaje := ' que el servicio de BRILLA'
							|| 'se encuentra a PAZ Y SALVO con la empresa por los conceptos asociados en la misma. ';
			
		ELSE
				sbMensaje := ' que el servicio de BRILLA'
							||' correspondiente a la financiación no bancaria con numero de solicitud de crédito '
							||sbNumFormulario||', '
							|| 'se encuentra a PAZ Y SALVO con la empresa por los conceptos asociados en la misma. ';
		END IF;
		
	ELSIF nuTipoProducto =  pkg_bcld_parameter.fnuObtieneValorNumerico('COD_SERV_GNCV') THEN
         sbMensaje :=  ' que el servicio de financiacion del kit de gas natural vehicular correspondiente al vehiculo de placas No '
						||'PLACA XXXXXX'|| ', '|| 'se encuentra a PAZ Y SALVO con la empresa por todo concepto. ';

	END IF;
	
	  
		OPEN orfcursor FOR
			SELECT
			sbNombreEmpresa NOMEMPRESA,
			sbMensaje SERVICIOPUBLICO,
			sbDescServicio TIPOPRODUCTO,
			sbDireccion Direccion,
			sbMunicipio Municipio,
			nuContrato Contrato,
			sbNombresCliente||' '||sbApellidosCliente NombreCliente,
			sbNombresContacto||' '|| sbApellidosContacto NombreContacto,
			sbIdentifContacto ContactoId,
			to_char(sysdate, 'DD') Dia,
			to_char(sysdate, 'MM') Mes,
			to_char(sysdate, 'YYYY') Anno,
			sbDepartamento Departamento,
			INITCAP(sbLocalidadEmpresa) MF
			FROM DUAL;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
	WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError,sbError);
			pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
    END prcDatosCertPazySalvo;

END pkg_boImpresionCertificCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_boImpresionCertificCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOIMPRESIONCERTIFICCLIENTE', 'PERSONALIZACIONES');
END;
/

