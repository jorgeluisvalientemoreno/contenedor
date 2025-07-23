CREATE OR REPLACE PACKAGE personalizaciones.pkg_boImpresionEmpresa IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_boImpresionEmpresa
    Autor       :   Jhon Soto - Horbath
    Fecha       :   03-06-2025
    Descripcion :   Paquete con los metodos configurar en FCED
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			03/06/2025	OSF-4616: Creacion
*******************************************************************************/


    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	
	PROCEDURE prcObtEmpresaCupon(	inuCupon 	IN cupon.cuponume%TYPE,
									orfcursor	OUT constants_per.tyRefCursor);
	
									
END pkg_boImpresionEmpresa;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boImpresionEmpresa IS

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
    
	
PROCEDURE prcObtEmpresaCupon(	inuCupon 	IN cupon.cuponume%TYPE,
								orfcursor	OUT constants_per.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de Gases del Caribe.

  UNID         : prcObtEmpresaCupon
  Descripcion    : procedimiento para extraer los datos relacionados
                   a la empresa del cupon
  Autor          : Jsoto

  Parametros              Descripcion
  ============         ===================
  isbCupon				Código de cupon
  inuContrato			Código de Contrato
  orfcursor            	Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================

****************************************************************************/
	sbCodEmpresa		empresa.codigo%TYPE;
	nuError				NUMBER;
	sbError				VARCHAR(4000);
    csbMetodo			VARCHAR2(70) 	:= csbPqt_nombre||'prcObtEmpresaCupon';
	nuCiclo				NUMBER;
	rcEmpresa   		empresa%ROWTYPE;
	nuContrato			NUMBER;
	sbLineaSAC			VARCHAR2(200);
	sbLineaEmergencias	VARCHAR2(200);
	sbLineaGratuita		VARCHAR2(200);
	sbWhatsapp			VARCHAR2(200);
	

BEGIN

	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	
	pkg_traza.trace('inuCupon: '||inuCupon);

	nuContrato := pkg_cupon.fnuobtcuposusc(inuCupon);
	
	nuCiclo := pkg_bccontrato.fnuCicloFacturacion(nuContrato);
	
	sbCodEmpresa := pkg_boconsultaempresa.fsbObtEmpresaCiclo(nuCiclo);
	
	rcEmpresa := pkg_boConsultaEmpresa.frcObtInfoEmpresa(sbCodEmpresa);

	sbLineaEmergencias := pkg_atributos_empresa.fsbobtvalor(sbCodEmpresa,'LINEA_EMERGENCIAS');
	
	sbLineaGratuita := pkg_atributos_empresa.fsbobtvalor(sbCodEmpresa,'LINEA_GRATUITA');
	
	sbWhatsapp := pkg_atributos_empresa.fsbobtvalor(sbCodEmpresa,'WHATSAPP');
	
	sbLineaSAC := pkg_atributos_empresa.fsbobtvalor(sbCodEmpresa,'LINEA_SERVICIO_CLIENTE');
	
		pkg_traza.trace('rcEmpresa.codigo '||rcEmpresa.codigo);
		
		IF orfcursor%ISOPEN THEN
			CLOSE orfcursor;
		END IF;

		OPEN orfcursor FOR
		SELECT rcEmpresa.codigo CODIGO,
				rcEmpresa.nombre NOMBRE,
				rcEmpresa.nit NIT,
				rcEmpresa.direccion DIRECCION,	
				rcEmpresa.email_emisor EMAIL_EMISOR,
				rcEmpresa.telefono_emisor TELEFONO_EMISOR,
				rcEmpresa.fax_emisor FAX_EMISOR,
				sblineaEmergencias LINEA_EMERGENCIAS,
				sblineaGratuita LINEA_GRATUITA,
				sbwhatsapp WHATSAPP,
				sbLineaSAC LINEA_SAC
		FROM dual;

   pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
END prcObtEmpresaCupon;


END pkg_boImpresionEmpresa;
/

PROMPT Otorgando permisos de ejecución para PERSONALIZACIONES.pkg_boImpresionEmpresa
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOIMPRESIONEMPRESA', 'PERSONALIZACIONES');
END;
/

