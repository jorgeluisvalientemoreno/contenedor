CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOINSOLVENCIA_ECONOMICA IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   09/06/2025
		Descripcion :   Paquete con los metodos para el trigger TRG_VAL_TIPO_SOLI_INSOLVENCIA
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	09/06/2025	OSF-4544	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09/06/2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="09/06/2025" Inc="OSF-4544" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Valida el registro de la solicitud no esta bloqueada para contratos de insolvencia economica
	PROCEDURE prcValRegistroDeSolicitud(inuContrato 	IN suscripc.susccodi%TYPE,
										inuSolicitud	IN mo_motive.package_id%TYPE
										);
									
END PKG_BOINSOLVENCIA_ECONOMICA;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOINSOLVENCIA_ECONOMICA IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4544';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 09/06/2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="09/06/2025" Inc="OSF-4544" Empresa="GDC"> 
               Creación
           </ModIFicacion>
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
    Programa        : prcValRegistroDeSolicitud
    Descripcion     : Valida el registro de la solicitud no esta bloqueada para contratos de insolvencia economica
    Autor           : Jhon Erazo
    Fecha           : 09/06/2025
  
    Parametros de Entrada
		inuContrato			Identificador del contrato
		inuSolicitud		Identificador de la solicitud
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	09/06/2025	OSF-4544	Creación
	***************************************************************************/	
	PROCEDURE prcValRegistroDeSolicitud(inuContrato 	IN suscripc.susccodi%TYPE,
										inuSolicitud	IN mo_motive.package_id%TYPE
										)
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcValRegistroDeSolicitud';
		
		nuError				NUMBER;  
		nutipoContrato		suscripc.susctisu%TYPE;
		nuTipoContraInsol	suscripc.susctisu%TYPE := 42;
		nuTipoSolicitud		mo_packages.package_type_id%TYPE;
		nuExisteSolici		NUMBER;
		sbmensaje   		VARCHAR2(1000);	
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContrato: ' 	|| inuContrato || CHR(10) ||
						'inuSolicitud: ' 	|| inuSolicitud, cnuNVLTRC);
		
		-- Obtiene el tipo de contrato
		nutipoContrato := pkg_bccontrato.fnuTipoContrato(inuContrato);
		pkg_traza.trace('nutipoContrato: ' || nutipoContrato, cnuNVLTRC);
		
		-- el registro de la solicitud no esta bloqueada para contratos de insolvencia economica
		IF (nutipoContrato = nuTipoContraInsol) THEN
			-- Obtiene el tipo de solicitud
			nuTipoSolicitud	:= pkg_bcsolicitudes.fnuGetTipoSolicitud(inuSolicitud);
			pkg_traza.trace('nuTipoSolicitud: ' || nuTipoSolicitud, cnuNVLTRC);
			
			-- Valida si el tipo de solicitud esta configurado en el parametro TIPOSOLI_PERMITIDO_INSOLVENCIA
			nuExisteSolici := pkg_parametros.fnuValidaSiExisteCadena('TIPOSOLI_PERMITIDO_INSOLVENCIA',
																	 ',',
																	 nuTipoSolicitud
																	 );
			pkg_traza.trace('nuExisteSolici: ' || nuExisteSolici, cnuNVLTRC);
			
			-- Si el tipo de solicitud no existe en el parametro TIPOSOLI_PERMITIDO_INSOLVENCIA
			IF (nuExisteSolici =  0) THEN
				pkg_error.setErrorMessage(isbMsgErrr => 'El contrato ' || inuContrato || ' de tipo 42 - Ley de Insolvencia Económica, solo ' ||
														'puede registrar las solicitudes configuradas en el parámetro TIPOSOLI_PERMITIDO_INSOLVENCIA.'
										  );
			END IF;
		END IF;

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
	END prcValRegistroDeSolicitud;

END PKG_BOINSOLVENCIA_ECONOMICA;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BOINSOLVENCIA_ECONOMICA
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOINSOLVENCIA_ECONOMICA', 'PERSONALIZACIONES');
END;
/