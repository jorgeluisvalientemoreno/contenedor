CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOLDCCFLOT IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   21-01-2025
		Descripcion :   Paquete con los metodos para el PB LDCCFLOT
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	21/01/2025	OSF-3871	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="27-01-2025" Inc="OSF-3871" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Procesa la ejecución del PB LDCCFLOT
	PROCEDURE prcProcesa(inuorder_id 		IN or_order.order_id%TYPE,
						 idtNuevaFechaLega	IN DATE,
						 isbComentario  	IN VARCHAR2
						 );
									
END PKG_BOLDCCFLOT;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOLDCCFLOT IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3871';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 21-01-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="21-01-2025" Inc="OSF-3871" Empresa="GDC"> 
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
    Programa        : prcProcesa
    Descripcion     : Procesa la ejecución del PB LDCCFLOT
    Autor           : Jhon Erazo
    Fecha           : 21-01-2025
  
    Parametros de Entrada
		inuorder_id			IdentIFicador de la orden
		idtNuevaFechaLega	Nueva fecha de legalización
		isbComentario		Observación
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/01/2025	OSF-3871	Creación
	***************************************************************************/	
	PROCEDURE prcProcesa(inuorder_id 		IN or_order.order_id%TYPE,
						 idtNuevaFechaLega	IN DATE,
						 isbComentario  	IN VARCHAR2
						)
	IS
	
		csbMETODO   		CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcProcesa';
		
		nuError				NUMBER;  
		nuEstadoOrden		or_order.order_status_id%TYPE;
		nuTipoTrabajoorden	or_order.task_type_id%TYPE;
		nuExisteTipoTrabajo	NUMBER;
		nuActaAsociada		NUMBER;
		sbmensaje   		VARCHAR2(1000);	
		sbPrograma          VARCHAR2(10);
		dtSysdate			DATE := ldc_boConsGenerales.fdtGetSysDate;
		dtFechaLegaliAntes	DATE;		

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuorder_id: '			|| inuorder_id 		 || CHR(10) ||
						'idtNuevaFechaLega: '	|| idtNuevaFechaLega || CHR(10) ||
						'isbComentario: '		|| isbComentario, cnuNVLTRC);
						
		--identIFica estado de la orden a modIFicar
		nuEstadoOrden := pkg_bcordenes.fnuobtieneestado(inuorder_id);
		pkg_traza.trace('nuEstadoOrden: ' || nuEstadoOrden, cnuNVLTRC);

		--si el estado es dIFerente a cerrada notIFica mensaje
		IF nuEstadoOrden != 8 THEN
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
									  'La Orden No está legalizada por favor, Verifique.');
		END IF;
	
		-- Obtiene el tipo de trabajo de la orden
		nuTipoTrabajoorden := pkg_bcordenes.fnuobtienetipotrabajo(inuorder_id);
		pkg_traza.trace('nuTipoTrabajoorden: ' || nuTipoTrabajoorden, cnuNVLTRC);
	
		-- Valida si el tipo de trabajo esta configurado en LDC_COTT_CFLO
		nuExisteTipoTrabajo := pkg_bcldccflot.fnuValConfigTipoTrab(nuTipoTrabajoorden);	
		pkg_traza.trace('nuExisteTipoTrabajo: ' || nuExisteTipoTrabajo, cnuNVLTRC);
	
		-- Si el tipo de trabajo no esta configurado en LDC_COTT_CFLO
		IF nuExisteTipoTrabajo = 0 THEN
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
									  'La Orden posee un tipo de trabajo,' || nuTipoTrabajoorden ||
									  ', que no está configurado en LDCCTCFLO, verifique');
		END IF;
  
		-- Valida si la orden tiene acta asociada
		nuActaAsociada := pkg_bcldccflot.fnuValOrdenActaAsociada(inuorder_id);
		pkg_traza.trace('nuActaAsociada: ' || nuActaAsociada, cnuNVLTRC);

		IF nuActaAsociada != 0 THEN
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
									 'La Orden se encuentra asociada a acta.');
		END IF;

		-- valida que la nueva fecha no supera fecha y hora actual
		IF idtNuevaFechaLega > TO_DATE(dtSysdate, ldc_boConsGenerales.fsbGetFormatoFecha) THEN
		
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
									  'La nueva fecha de legalización.' || TO_DATE(idtNuevaFechaLega, ldc_boConsGenerales.fsbGetFormatoFecha) ||
									  ', es mayor a la fecha y hora actual.' || TO_DATE(dtSysdate, ldc_boConsGenerales.fsbGetFormatoFecha)
									  );

		END IF;

		-- Se obtiene el programa
		sbPrograma := pkg_error.getApplication;	

		IF sbPrograma IS null OR sbPrograma = '' THEN
			sbPrograma := 'LDCCFLOT';
		END IF;
		pkg_traza.trace('sbPrograma: ' || sbPrograma, cnuNVLTRC);
	
		-- Obtiene la fecha de legalización antes de modificación
		dtFechaLegaliAntes := pkg_bcordenes.fdtobtienefechalegaliza(inuorder_id); 
		pkg_traza.trace('dtFechaLegaliAntes: ' || dtFechaLegaliAntes, cnuNVLTRC);
	
		-- Actualiza la fecha de legalización
		pkg_or_order.praclegalization_date(inuorder_id, idtNuevaFechaLega);

		-- registra tabla de auditoria
		pkg_ldc_au_cflot.prcInsRegistro(inuorder_id,
										dtFechaLegaliAntes,
										idtNuevaFechaLega,
										isbComentario,
										dtSysdate,
										pkg_session.getuser,
										pkg_session.fsbgetterminal,
										sbPrograma
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
	END prcProcesa;

END PKG_BOLDCCFLOT;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BOLDCCFLOT
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOLDCCFLOT', 'PERSONALIZACIONES');
END;
/
/