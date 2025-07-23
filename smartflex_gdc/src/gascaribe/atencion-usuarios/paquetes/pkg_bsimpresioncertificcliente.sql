CREATE OR REPLACE PACKAGE pkg_bsImpresionCertificCliente IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bsImpresionCertificCliente
    Autor       :   Jhon Soto - Horbath
    Fecha       :   01-07-2025
    Descripcion :   Paquete con los metodos para configurar servicios de consulta en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			01/07/2025	OSF-4730: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	

	PROCEDURE prcServConsultaDatosGenerales(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServConsultaUbiGeografica(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServDatosConstanciaPagos(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServFechasConstanciaPagos(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServDetalleConstanciaPagos(orfcursor OUT constants_per.tyRefCursor);
	
	PROCEDURE prcServDatosPazySalvo(orfcursor OUT constants_per.tyRefCursor);

	
	

END pkg_bsImpresionCertificCliente;
/

CREATE OR REPLACE PACKAGE BODY pkg_bsImpresionCertificCliente IS

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
    
	
PROCEDURE prcServConsultaDatosGenerales(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaDatosGenerales
  Descripcion    : procedimiento para extraer los datos generales del certificado de estado de cuenta
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbIdMotivo  		NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServConsultaDatosGenerales';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	sbIdMotivo := cc_bocertificate.fnuMotiveId;

	pkg_boImpresionCertificCliente.prcDatosGenCertEstadoCuenta(sbIdMotivo,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaDatosGenerales;


PROCEDURE prcServConsultaUbiGeografica(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServConsultaUbiGeografica
  Descripcion    : procedimiento para extraer la descripcion de la ubicacion geografica para certificado de estado de cuenta
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	nuIdMotivo  		NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServConsultaUbiGeografica';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	nuIdMotivo := cc_bocertificate.fnuMotiveId;
	
	pkg_boImpresionCertificCliente.prcDatoUbicacionGeografica(nuIdMotivo,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServConsultaUbiGeografica;


PROCEDURE prcServDatosConstanciaPagos(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServDatosConstanciaPagos
  Descripcion    : procedimiento para extraer los datos generales del formato
					de constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
	08/07/2025		jsoto				OSF-4730
****************************************************************************/
	nuIdMotivo  		NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServDatosConstanciaPagos';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	nuIdMotivo := cc_bocertificate.fnuMotiveId;
	
	pkg_boImpresionCertificCliente.prcDatosConstanciaPagos(nuIdMotivo,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServDatosConstanciaPagos;


PROCEDURE prcServFechasConstanciaPagos(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServFechasConstanciaPagos
  Descripcion    : procedimiento para obtener el detalle de los pagos del formato
					de constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
	08/07/2025		jsoto				OSF-4730
****************************************************************************/
	nuIdMotivo  		NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServFechasConstanciaPagos';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	nuIdMotivo := cc_bocertificate.fnuMotiveId;
	
	pkg_boImpresionCertificCliente.prcFechasConstanciaPagos(nuIdMotivo,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServFechasConstanciaPagos;

PROCEDURE prcServDetalleConstanciaPagos(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServDetalleConstanciaPagos
  Descripcion    : procedimiento para obtener el detalle de los pagos del formato
					de constancia de pagos
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
	08/07/2025		jsoto				OSF-4730
****************************************************************************/
	nuIdMotivo  		NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServDetalleConstanciaPagos';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	nuIdMotivo := cc_bocertificate.fnuMotiveId;
	
	pkg_boImpresionCertificCliente.prcDetalleConstanciaPagos(nuIdMotivo,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServDetalleConstanciaPagos;


PROCEDURE prcServDatosPazySalvo(orfcursor OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcServDatosPazySalvo
  Descripcion    : procedimiento para obtener el detalle de los pagos del formato
					de paz y salvo
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales para el certificado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
	08/07/2025		jsoto				OSF-4730
****************************************************************************/
	nuSolicitud			NUMBER;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(200) 	:= csbPqt_nombre||'prcServDatosPazySalvo';

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	nuSolicitud := cc_bocertificate.fnupackagesid;
	
	pkg_boImpresionCertificCliente.prcDatosCertPazySalvo(nuSolicitud,orfcursor);
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcServDatosPazySalvo;


END pkg_bsImpresionCertificCliente;
/

PROMPT Otorgando permisos de ejecución para pkg_bsImpresionCertificCliente
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BSIMPRESIONCERTIFICCLIENTE', 'OPEN');
END;
/

