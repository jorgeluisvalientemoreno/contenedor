CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcImpresionCodigoBarras IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bcImpresionCodigoBarras
    Autor       :   Jhon Soto - Horbath
    Fecha       :   03-06-2025
    Descripcion :   Paquete con los metodos para gestion de cupon de pago
    Modificaciones  : 
    Autor       Fecha       Caso     Descripcion
  jsoto			03/06/2025	OSF-4574: Creacion
*******************************************************************************/

	csbEANGDGU CONSTANT VARCHAR(50) := pkg_parametros.fsbGetValorCadena('COD_EAN_CODIGO_BARRAS_GDGU');
	csbEANGDCA CONSTANT VARCHAR(50) := pkg_parametros.fsbGetValorCadena('COD_EAN_CODIGO_BARRAS_GDCA');
	

	CURSOR cuDatosCupon(inuNumCupon cupon.cuponume%TYPE,
						idtFechaVencimiento cupon.cupofech%TYPE,
						isbCodEmpresa empresa.codigo%TYPE)
	IS
	  SELECT codigo_1
			,codigo_2
			,codigo_3
			,codigo_4
        ,CASE
          WHEN codigo_3 IS NOT NULL THEN
                '(415)' || codigo_1 || '(8020)' || codigo_2 || '(3900)' ||
                 codigo_3 || '(96)' || codigo_4
          ELSE
           NULL
          END codigo_barras,
			'415' || codigo_1 ||'8020' || codigo_2 || chr(200) || '3900' ||
			codigo_3 || chr(200) || '96' ||	codigo_4 codigo_codificado
    FROM (
          SELECT CASE
					WHEN isbCodEmpresa = 'GDGU' THEN csbEANGDGU
					WHEN isbCodEmpresa = 'GDCA' THEN csbEANGDCA
				 END codigo_1
                ,lpad(cuponume, 10, '0') codigo_2
                ,lpad(round(cupovalo), 10, '0') codigo_3
                ,to_char(idtFechaVencimiento, 'yyyymmdd') codigo_4
            FROM cupon
           WHERE cuponume = inuNumCupon
           UNION
          SELECT NULL, ' ', NULL, ' ' FROM dual
         )
   WHERE rownum = 1;

	TYPE tytbDatosCodBarras           IS TABLE OF cuDatosCupon%ROWTYPE INDEX BY BINARY_INTEGER;
	
   FUNCTION ftbDatosCodigoBarras(inuCupon 				IN 	cupon.cuponume%TYPE,
							  idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
							  isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN tytbDatosCodBarras;

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;
	
	FUNCTION fsbObtCodigoDeBarras(inuCupon 			IN 	cupon.cuponume%TYPE,
							  idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
							  isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN VARCHAR2;
	
	FUNCTION fsbObtCadenaCodigoBarras(	inuCupon 				IN 	cupon.cuponume%TYPE,
										idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
										isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN VARCHAR2;

END pkg_bcImpresionCodigoBarras;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcImpresionCodigoBarras IS

    --------------------------------------------
    -- Identificador del ultimo caso que hizo cambios
    --------------------------------------------   
    csbVersion     VARCHAR2(15) := 'OSF-4574';

    --------------------------------------------
    -- Constantes para el control de la traza
    --------------------------------------------  
    csbPqt_nombre   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;
    
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
    
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftbDatosCodigoBarras
    Descripcion     : Obtiene los datos requeridos para generación del código de barras 
    Autor           : Jsoto
    Fecha           : 03-06-2025
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto     	03-05-2025  OSF-4574 Creacion
    ***************************************************************************/
	
   FUNCTION ftbDatosCodigoBarras(	inuCupon 				IN 	cupon.cuponume%TYPE,
									idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
									isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN tytbDatosCodBarras
    IS
	
	nuError			NUMBER;
	sbError			VARCHAR(4000);
    csbMetodo		VARCHAR2(70) 	:= csbPqt_nombre || '.ftbDatosCodigoBarras';
	
	tbDatosCodBarras  tytbDatosCodBarras;
	

    BEGIN
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);	
	pkg_traza.trace('inuCupon: '||inuCupon); 
	pkg_traza.trace('idtFechaVencimiento: '||idtFechaVencimiento); 
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa); 
	
	IF cuDatosCupon%ISOPEN THEN
		CLOSE cuDatosCupon;
	END IF;
	
	OPEN cuDatosCupon(inuCupon,idtFechaVencimiento,isbCodEmpresa);
	FETCH cuDatosCupon BULK COLLECT INTO tbDatosCodBarras;
	CLOSE cuDatosCupon;
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	RETURN tbDatosCodBarras;

    EXCEPTION
	WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
	END ftbDatosCodigoBarras;


	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtCodigoDeBarras
    Descripcion     : Obtiene los datos requeridos para generación del código de barras 
    Autor           : Jsoto
    Fecha           : 03-06-2025
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto     	03-06-2025  OSF-4574 Creacion
    ***************************************************************************/
	
   FUNCTION fsbObtCodigoDeBarras(	inuCupon 				IN 	cupon.cuponume%TYPE,
									idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
									isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN VARCHAR2
    IS
	
	nuError			NUMBER;
	sbError			VARCHAR(4000);
    csbMetodo		VARCHAR2(70) 	:= csbPqt_nombre || '.fsbObtCodigoDeBarras';
	
	tbDatosCodBarras  tytbDatosCodBarras;
	sbCodigoBarras	VARCHAR2(100);
	nuIndice 		NUMBER;
	

    BEGIN
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	pkg_traza.trace('inuCupon: '||inuCupon); 
	pkg_traza.trace('idtFechaVencimiento: '||idtFechaVencimiento); 
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa);
	
	tbDatosCodBarras := ftbDatosCodigoBarras(inuCupon,idtFechaVencimiento,isbCodEmpresa);
      
	nuIndice := tbDatosCodBarras.FIRST;    
	
	IF nuIndice IS NOT NULL THEN   

		sbCodigoBarras := tbDatosCodBarras(nuIndice).codigo_codificado;
		
        pkg_traza.trace('tbDatosCodBarras(nuIndice).codigo_codificado '||sbCodigoBarras); 
		
    END IF;


	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	RETURN sbCodigoBarras;

    EXCEPTION
	WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
	END fsbObtCodigoDeBarras;


	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtCadenaCodigoBarras
    Descripcion     : Obtiene los datos requeridos para generación del código de barras 
    Autor           : Jsoto
    Fecha           : 03-06-2025
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto     	03-06-2025  OSF-4616 Creacion
    ***************************************************************************/
	
   FUNCTION fsbObtCadenaCodigoBarras(	inuCupon 				IN 	cupon.cuponume%TYPE,
									idtFechaVencimiento 	IN	cupon.cupofech%TYPE,
									isbCodEmpresa			IN  VARCHAR2 DEFAULT 'GDCA')
	RETURN VARCHAR2
    IS
	
	nuError			NUMBER;
	sbError			VARCHAR(4000);
    csbMetodo		VARCHAR2(70) 	:= csbPqt_nombre || '.fsbObtCadenaCodigoBarras';
	
	tbDatosCodBarras  tytbDatosCodBarras;
	sbCodigoBarras	VARCHAR2(100);
	nuIndice 		NUMBER;
	

    BEGIN
	
	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
	pkg_traza.trace('inuCupon: '||inuCupon); 
	pkg_traza.trace('idtFechaVencimiento: '||idtFechaVencimiento); 
	pkg_traza.trace('isbCodEmpresa: '||isbCodEmpresa);
	
	tbDatosCodBarras := ftbDatosCodigoBarras(inuCupon,idtFechaVencimiento,isbCodEmpresa);
      
	nuIndice := tbDatosCodBarras.FIRST;    
	
	IF nuIndice IS NOT NULL THEN   

		sbCodigoBarras := tbDatosCodBarras(nuIndice).codigo_barras;
		
        pkg_traza.trace('tbDatosCodBarras(nuIndice).codigo_barras '||sbCodigoBarras); 
		
    END IF;


	pkg_traza.trace( csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	RETURN sbCodigoBarras;

    EXCEPTION
	WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(nuError||':'||sbError || csbMetodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);    
        RAISE pkg_error.controlled_error;
	END fsbObtCadenaCodigoBarras;
	

END pkg_bcImpresionCodigoBarras;
/

PROMPT Otorgando permisos de ejecución para PERSONALIZACIONES.pkg_bcImpresionCodigoBarras
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCIMPRESIONCODIGOBARRAS', 'PERSONALIZACIONES');
END;
/

