CREATE OR REPLACE PACKAGE adm_person.pkg_gc_proycast IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   24-04-2025
		Descripcion :   Paquete con la logica para la entidad gc_proycast
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	24-04-2025	OSF-4170	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Inserta registros	
	PROCEDURE prcInserRegistro(idtFechaCreacion			IN gc_proycast.prcafecr%TYPE,
							   isbObservacion			IN gc_proycast.prcaobse%TYPE,
							   inuProductosCastigar		IN gc_proycast.prcaprpc%TYPE, 
							   inuSaldoCastigar			IN gc_proycast.prcasapc%TYPE,
							   inuProductosCastigados	IN gc_proycast.prcaprca%TYPE,
							   inuSaldoCastigado		IN gc_proycast.prcasaca%TYPE,
							   isbEstado				IN gc_proycast.prcaesta%TYPE,
							   inuTipoProducto			IN gc_proycast.prcaserv%TYPE,
							   isbNombre				IN gc_proycast.prcanomb%TYPE,
							   onuconseproycast			OUT gc_proycast.prcacons%TYPE
							   );
							   
	-- Actualiza el producto a castigar	
	PROCEDURE prcActProductoCastigar(inuConsecutivo 		IN gc_proycast.prcacons%TYPE,
									 inuProductosCastigar	IN gc_proycast.prcaprpc%TYPE
									);
									
	-- Actualiza el saldo a castigar	
	PROCEDURE prcActSaldoCastigar(inuConsecutivo 	IN gc_proycast.prcacons%TYPE,
								  inuSaldoCastigar	IN gc_proycast.prcasapc%TYPE
								  );
									
END pkg_gc_proycast;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_gc_proycast IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4170';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="24-04-2025" Inc="OSF-4170" Empresa="GDC"> 
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
    Programa        : prcInserRegistro
    Descripcion     : Inserta registros
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		idtFechaCreacion			Fecha de Creacion
		isbObservacion				Observación
		inuProductosCastigar		Productos a castigar
		inuSaldoCastigar			Saldo a castigar
		inuProductosCastigados		Productos castigados
		inuSaldoCastigado			Saldo Castigado
		isbEstado					Estado
		inuTipoProducto				Tipo de producto
		isbNombre					Nombre
	  
    Parametros de Salida	
		onuconseproycast			Consecutivo
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcInserRegistro(idtFechaCreacion			IN gc_proycast.prcafecr%TYPE,
							   isbObservacion			IN gc_proycast.prcaobse%TYPE,
							   inuProductosCastigar		IN gc_proycast.prcaprpc%TYPE, 
							   inuSaldoCastigar			IN gc_proycast.prcasapc%TYPE,
							   inuProductosCastigados	IN gc_proycast.prcaprca%TYPE,
							   inuSaldoCastigado		IN gc_proycast.prcasaca%TYPE,
							   isbEstado				IN gc_proycast.prcaesta%TYPE,
							   inuTipoProducto			IN gc_proycast.prcaserv%TYPE,
							   isbNombre				IN gc_proycast.prcanomb%TYPE,
							   onuconseproycast			OUT gc_proycast.prcacons%TYPE
							   )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcInserRegistro';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('idtFechaCreacion: ' 		|| idtFechaCreacion 		|| CHR(10) ||
						'isbObservacion: ' 			|| isbObservacion 			|| CHR(10) ||
						'inuProductosCastigar: ' 	|| inuProductosCastigar		|| CHR(10) ||
						'inuSaldoCastigar: ' 		|| inuSaldoCastigar 		|| CHR(10) ||
						'inuProductosCastigados: ' 	|| inuProductosCastigados	|| CHR(10) ||
						'inuSaldoCastigado: ' 		|| inuSaldoCastigado 		|| CHR(10) ||
						'isbEstado: ' 				|| isbEstado				|| CHR(10) ||
						'inuTipoProducto: ' 		|| inuTipoProducto 			|| CHR(10) ||
						'isbNombre: ' 				|| isbNombre, cnuNVLTRC);
		
		onuconseproycast := seq_gc_proycast_172026.NEXTVAL;
		pkg_traza.trace('onuconseproycast: ' || onuconseproycast, cnuNVLTRC);
		
		INSERT INTO gc_proycast(prcacons, prcafecr, 
								prcaobse, prcaprpc, 
								prcasapc, prcaprca, 
								prcasaca, prcaesta, 
								prcaserv, prcanomb
								)
		VALUES (onuconseproycast,
				idtFechaCreacion,
				isbObservacion,
				inuProductosCastigar,
				inuSaldoCastigar,
				inuProductosCastigados,
				inuSaldoCastigado,
				isbEstado,
				inuTipoProducto,
				isbNombre
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
	END prcInserRegistro;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActProductoCastigar
    Descripcion     : Actualiza el producto a castigar
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuConsecutivo			Consecutivo
		inuProductosCastigar	Productos a castigar
	  
    Parametros de Salida	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcActProductoCastigar(inuConsecutivo 		IN gc_proycast.prcacons%TYPE,
									 inuProductosCastigar	IN gc_proycast.prcaprpc%TYPE
									)
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcActProductoCastigar';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuConsecutivo: ' 			|| inuConsecutivo	|| CHR(10) ||
						'inuProductosCastigar: '	|| inuProductosCastigar, cnuNVLTRC);
		
		UPDATE gc_proycast h
		SET h.prcaprpc = inuProductosCastigar
		WHERE h.prcacons = inuConsecutivo;

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
	END prcActProductoCastigar;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActSaldoCastigar
    Descripcion     : Actualiza el saldo a castigar
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuConsecutivo		Consecutivo
		inuSaldoCastigar	Saldo a castigar
	  
    Parametros de Salida	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcActSaldoCastigar(inuConsecutivo 	IN gc_proycast.prcacons%TYPE,
								  inuSaldoCastigar	IN gc_proycast.prcasapc%TYPE
								  )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcActSaldoCastigar';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuConsecutivo: ' 		|| inuConsecutivo	|| CHR(10) ||
						'inuSaldoCastigar: '	|| inuSaldoCastigar, cnuNVLTRC);
		
		UPDATE gc_proycast h
		SET h.prcasapc = inuSaldoCastigar
		WHERE h.prcacons = inuConsecutivo;

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
	END prcActSaldoCastigar;

END pkg_gc_proycast;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_gc_proycast
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_gc_proycast'), 'adm_person');
END;
/