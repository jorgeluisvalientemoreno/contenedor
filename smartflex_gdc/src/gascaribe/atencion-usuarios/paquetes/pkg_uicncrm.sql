CREATE OR REPLACE PACKAGE PKG_UICNCRM IS 
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   11-02-2025
		Descripcion :   Paquete UI para el PI CNCRM
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	11/02/2025	OSF-3760	Creación
		fvalencia   14/05/2025  OSF-4171    Se agregan los procedimientos prcObtInfoExenciones
											y prcHIjoPadreInfoExenciones
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2025" Inc="OSF-3760" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	 
	--  Servicio de consulta del correo electronico
	PROCEDURE prcObtInfoFactuElectr(inucontrato IN suscripc.susccodi%type,
									 orfCursor	 OUT CONSTANTS_PER.TYREFCURSOR
									 );
									 
	-- Hijo de padre del contrato, para obtener el correo de facturación electronica
	PROCEDURE prcHIjoPadreInfoFactuElectr(inucontrato IN suscripc.susccodi%type,
										  orfCursor	 OUT CONSTANTS_PER.TYREFCURSOR
										  ); 

	--Servicio de consulta de información de excenciones de contribución
	PROCEDURE prcObtInfoExenciones
	(
		inuProducto 	IN 	servsusc.sesunuse%type,
		orfCursor	 	OUT constants_per.tyrefcursor
	);

	--Hijo de padre de la pestaña de exenciones
	PROCEDURE prcHIjoPadreInfoExenciones
	(
		inuProducto 	IN servsusc.sesunuse%type,
		orfCursor	 	OUT constants_per.tyrefcursor
	);
									
END PKG_UICNCRM;
/
CREATE OR REPLACE PACKAGE BODY PKG_UICNCRM IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3760';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 11-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="11-02-2025" Inc="OSF-3760" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtInfoFactuElectr
    Descripcion     : Servicio de consulta del correo electronico
    Autor           : Jhon Erazo
    Fecha           : 11-02-2025
  
    Parametros de Entrada
		inucontrato		Identificador del Contrato
	  
    Parametros de Salida
		orfCursor		Cursor	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	11/02/2025	OSF-3760	Creación
	***************************************************************************/	
	PROCEDURE prcObtInfoFactuElectr(inucontrato IN suscripc.susccodi%type,
									 orfCursor	 OUT CONSTANTS_PER.TYREFCURSOR
									 )
	IS
	
		csbMETODO	CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtInfoFactuElectr';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);	
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_bocncrm.prcObtInfoFactuElectr(inucontrato,
										   orfCursor
										   );

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcObtInfoFactuElectr;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcHIjoPadreInfoFactuElectr
    Descripcion     : Hijo de padre del contrato, para obtener el correo 
					  de facturación electronica
    Autor           : Jhon Erazo
    Fecha           : 11-02-2025
  
    Parametros de Entrada
		inucontrato		Identificador del Contrato
	  
    Parametros de Salida
		orfCursor		Cursor	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	11/02/2025	OSF-3760	Creación
	***************************************************************************/	
	PROCEDURE prcHIjoPadreInfoFactuElectr(inucontrato IN suscripc.susccodi%type,
										 orfCursor	 OUT CONSTANTS_PER.TYREFCURSOR
										 )
	IS
	
		csbMETODO	CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcHIjoPadreInfoFactuElectr';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);	
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_bocncrm.prcHIjoPadreInfoFactuElectr(inucontrato,
											   orfCursor
											   );

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcHIjoPadreInfoFactuElectr;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtInfoExenciones
    Descripcion     : Servicio de consulta de información de excenciones de
					  contribución
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 14-05-2025
  
    Parametros de Entrada
	  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	fvalencia	14/05/2025	OSF-4171	Creación
	***************************************************************************/	
	PROCEDURE prcObtInfoExenciones
	(
		inuProducto 	IN 	servsusc.sesunuse%type,
		orfCursor	 	OUT constants_per.tyrefcursor
	)
	IS
	
		csbMETODO	CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtInfoExenciones';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);	
		
	BEGIN
		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_bocncrm.prcObtInfoExenciones(inuProducto, orfCursor);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcObtInfoExenciones;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcHIjoPadreInfoExenciones
    Descripcion     : Hijo de padre de la pestaña de exenciones
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 14-05-2025
  
    Parametros de Entrada
		inucontrato		Identificador del Contrato
	  
    Parametros de Salida
		orfCursor		Cursor	
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	fvalencia	14/05/2025	OSF-4171	Creación
	***************************************************************************/	
	PROCEDURE prcHIjoPadreInfoExenciones
	(
		inuProducto 	IN servsusc.sesunuse%type,
		orfCursor	 	OUT constants_per.tyrefcursor
	)
	IS	
		csbMETODO	CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcHIjoPadreInfoExenciones';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);	
	BEGIN
		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_bocncrm.prcHIjoPadreInfoExenciones(inuProducto, orfCursor);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcHIjoPadreInfoExenciones;

END PKG_UICNCRM;
/
PROMPT Otorgando permisos de ejecución para PKG_UICNCRM
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UICNCRM', 'OPEN');
END;
/