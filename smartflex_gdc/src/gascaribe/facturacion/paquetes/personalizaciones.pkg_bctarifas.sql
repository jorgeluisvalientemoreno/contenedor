CREATE OR REPLACE PACKAGE personalizaciones.pkg_bctarifas IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bctarifas
    Autor       :   Jhon Eduar Erazo Guachavez
    Fecha       :   15/07/2025
    Descripcion :   Paquete con los metodos para manejo de consultas de tarifas

    Modificaciones  :
    Autor           Fecha           Caso        Descripcion
    jerazomvm		15/07/2025		OSF-4734	Creación						
*******************************************************************************/

	-- Record de criterios
	TYPE tyrcCriterios IS RECORD(nuConsecutivo 			NUMBER,
							     nuConcepto 			NUMBER,
								 sbDesc_concepto		VARCHAR2(30),
								 nuServicio 			NUMBER,
								 dtCotcfein				DATE,
								 dtCotcfefi				DATE,
								 sbCotcvige				VARCHAR2(1),
								 nuAgrupador_criterios	NUMBER,	
								 sbDesc_agrupador		VARCHAR2(100),
							     nuCriterios			NUMBER,
								 sbDesc_criterio		VARCHAR2(100),
								 nuPrioridad			NUMBER
							    );

	-- Tipo tabla con los criterios por concepto y el tipo de producto
	TYPE tytbCriterios IS TABLE OF tyrcCriterios INDEX BY BINARY_INTEGER;

    -- Obtiene la version del paquete
	FUNCTION fsbVersion RETURN VARCHAR2;
	
	-- Obtiene los criterios por concepto y el tipo de producto
    PROCEDURE prcObtCriteriosxConcepServ(inuConcepto 			IN NUMBER,
										 inuTipoServicio		IN NUMBER,
										 otbCriteriosTarifa 	OUT tytbCriterios
										 );
										 
	-- Obtiene la consulta de tarifas
    FUNCTION fsbObtConsultaTarifas(inuConcepto		NUMBER,
								   inuTipoServicio	NUMBER,
								   isbCriterio01	VARCHAR2,
								   isbCriterio02	VARCHAR2,
								   isbCriterio03	VARCHAR2,
								   isbCriterio04	VARCHAR2,
								   isbMetros		VARCHAR2
								   )
	RETURN VARCHAR2;
	
END pkg_bctarifas;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bctarifas IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4734';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 4/02/2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="15/07/2025" Inc="OSF-4734" Empresa="GDC">
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
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcObtCriteriosxConcepServ </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 15/07/2025 </Fecha>
    <Descripcion> 
		Obtiene los criterios por concepto y el tipo de producto
    </Descripcion>
	<Parametros> 
        Entrada:
			inuConcepto			Concepto
			inuTipoServicio		Tipo de servicio
		
		Salida:
			otbCriteriosTarifa	Tabla con los criterios de las tarifas por
								concepto y tipo de servicio
			
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="15/07/2025" Inc="OSF-4734" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtCriteriosxConcepServ(inuConcepto 			IN NUMBER,
										 inuTipoServicio		IN NUMBER,
										 otbCriteriosTarifa 	OUT tytbCriterios
										 )
    IS
	
		csbMT_NAME  VARCHAR2(200) := csbSP_NAME || 'prcObtCriteriosxConcepServ';
		
		nuError		NUMBER;  
		sbmensaje	VARCHAR2(1000);  
		
		CURSOR cuCriterios
		IS
		WITH base AS(SELECT DA.DECTCONS,
							DA.DECTDESC,
							CO.COCTDECB,
							DE.DECBDESC,
							CO.COCTPRIO
					 FROM TA_DEFICRTA DA
						  INNER JOIN  TA_CONFCRTA CO ON CO.COCTDECT = DA.DECTCONS
						  INNER JOIN TA_DEFICRBT DE ON DE.DECBCONS  = CO.COCTDECB
					 ), 
			base2 AS(SELECT  t.cotccons consecutivo,
					 		 t.cotcconc concepto,
							 (SELECT concdesc 
							  FROM concepto co 
							  WHERE co.conccodi = t.cotcconc) desc_concepto,
							 t.cotcserv servicio,
							 t.cotcfein,
							 t.cotcfefi,
							 t.cotcvige,
							 base.dectcons agrupador_criterios,
							 base.dectdesc desc_agrupador,
							 COCTDECB criterios,
							 DECBDESC desc_criterio,
							 coctprio prioridad
					 FROM ta_conftaco t
						  LEFT JOIN base ON base.DECTCONS = t.COTCDECT
					 WHERE TRUNC(SYSDATE) BETWEEN cotcfein AND cotcfefi
					 AND cotcvige = 'S'
					 ORDER BY t.cotccons, coctprio
					 )
		SELECT *
		FROM base2
		WHERE concepto  = inuConcepto
		AND servicio 	= inuTipoServicio;	
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuConcepto: '   	|| inuConcepto || CHR(10) || 
						'inuTipoServicio: '	|| inuTipoServicio, cnuNVLTRC);
		
		IF (cuCriterios%ISOPEN) THEN
			CLOSE cuCriterios;
		END IF;
		
		OPEN cuCriterios;
		FETCH cuCriterios BULK COLLECT INTO otbCriteriosTarifa;
		CLOSE cuCriterios;

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcObtCriteriosxConcepServ;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtConsultaTarifas </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14/03/2025 </Fecha>
    <Descripcion> 
		Obtiene la consulta de tarifas
    </Descripcion>
	<Parametros> 
        Entrada:
			inuConcepto			Concepto
			inuTipoServicio		Tipo de servicio
			isbCriterio01		Filtro criterio 1
			isbCriterio02		Filtro criterio 2
			isbCriterio03		Filtro criterio 3
			isbCriterio04		Filtro criterio 4
			isbMetros			Filtro Metros
		
		Salida:
			otbCriterios	Tabla con los productos
			
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="15/07/2025" Inc="OSF-4734" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    FUNCTION fsbObtConsultaTarifas(inuConcepto		NUMBER,
								   inuTipoServicio	NUMBER,
								   isbCriterio01	VARCHAR2,
								   isbCriterio02	VARCHAR2,
								   isbCriterio03	VARCHAR2,
								   isbCriterio04	VARCHAR2,
								   isbMetros		VARCHAR2
								   )
	RETURN VARCHAR2
    IS
	
		csbMT_NAME  VARCHAR2(200) := csbSP_NAME || 'fsbObtConsultaTarifas';
		
		nuError				NUMBER; 
		sbmensaje			VARCHAR2(1000); 	
        sbSqlTarifas	VARCHAR2(4000);
		
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuConcepto: '		|| inuConcepto		|| CHR(10) ||
						'inuTipoServicio: '	|| inuTipoServicio	|| CHR(10) ||
						'isbCriterio01: '	|| isbCriterio01	|| CHR(10) ||
						'isbCriterio02: '   || isbCriterio02 	|| CHR(10) ||
						'isbCriterio03: '	|| isbCriterio03  	|| CHR(10) ||
						'isbCriterio04: '  	|| isbCriterio04	|| CHR(10) ||
						'isbMetros: '  		|| isbMetros, cnuNVLTRC); 
						
		sbSqlTarifas := 'SELECT d.vitcfein,' || CHR(10) ||
							  	'ravtliin || '' - '' || ravtlisu rango,' || CHR(10) ||
								'CASE' || CHR(10) ||
									'WHEN NVL(ravtvalo,0) != 0' || CHR(10) ||
										'THEN ravtvalo' || CHR(10) ||
									'ELSE' || CHR(10) ||
										'CASE' || CHR(10) ||
											'WHEN NVL(vitcvalo,0) != 0' || CHR(10) ||
												'THEN vitcvalo' || CHR(10) ||
											'ELSE' || CHR(10) ||
												'CASE' || CHR(10) ||
													'WHEN NVL(ravtporc,0) != 0' || CHR(10) ||
														'THEN ravtporc' || CHR(10) ||
													'ELSE vitcporc' || CHR(10) ||
											'END' || CHR(10) ||
										'END' || CHR(10) ||
								 'END VALOR,' || CHR(10) ||
								 'A.TACOCONS TARIFA,' || CHR(10) ||
								 'COTCSERV' || CHR(10) ||
						 'FROM ta_tariconc a' || CHR(10) ||
							   'LEFT OUTER JOIN ta_conftaco b ON (a.tacocotc = b.cotccons)' || CHR(10) ||
							   'LEFT OUTER JOIN ta_vigetaco d ON (d.vitctaco = a.tacocons)' || CHR(10) ||
							   'LEFT OUTER JOIN ta_rangvitc e ON (e.ravtvitc = d.vitccons)' || CHR(10) ||
						 'WHERE cotcconc = ' || inuConcepto || '' || CHR(10) ||
						 'AND COTCSERV = ' || inuTipoServicio || '';
		
		-- Si el criterio 1 no es nulo
		IF (isbCriterio01 IS NOT NULL) THEN
			sbSqlTarifas := sbSqlTarifas || CHR(10) || isbCriterio01;
		END IF;
		
		-- Si el criterio 2 no es nulo
		IF (isbCriterio02 IS NOT NULL) THEN
			sbSqlTarifas := sbSqlTarifas || CHR(10) || isbCriterio02;
		END IF;
		
		-- Si el criterio 3 no es nulo
		IF (isbCriterio03 IS NOT NULL) THEN
			sbSqlTarifas := sbSqlTarifas || CHR(10) || isbCriterio03;
		END IF;
		
		-- Si el criterio 4 no es nulo
		IF (isbCriterio04 IS NOT NULL) THEN
			sbSqlTarifas := sbSqlTarifas || CHR(10) || isbCriterio04;
		END IF;
		
		-- Si metros no es nulo
		IF (isbMetros IS NOT NULL) THEN
			sbSqlTarifas := sbSqlTarifas || CHR(10) || isbMetros;
		END IF;
		
		sbSqlTarifas := sbSqlTarifas || CHR(10) || 'ORDER BY d.vitcfein DESC';
							  
		pkg_traza.trace('sbSqlTarifas: ' || sbSqlTarifas, cnuNVLTRC); 
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbSqlTarifas;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fsbObtConsultaTarifas;
	
END pkg_bctarifas;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bctarifas
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bctarifas'), 'PERSONALIZACIONES');
END;
/