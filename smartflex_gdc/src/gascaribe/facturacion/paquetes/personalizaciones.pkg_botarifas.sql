CREATE OR REPLACE PACKAGE personalizaciones.pkg_botarifas IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_botarifas
    Autor       :   Jhon Eduar Erazo Guachavez
    Fecha       :   15/07/2025
    Descripcion :   Paquete con los metodos para manejo de logica de tarifas

    Modificaciones  :
    Autor           Fecha           Caso        Descripcion
    jerazomvm		15/07/2025		OSF-4734	Creación						
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;
	
	-- Obtiene la tatifa actual por concepto
    FUNCTION fnuObtTarifaActualConcepto(inuTipoServicio		IN NUMBER,
										inuConcepto 		IN NUMBER,
										inuMercaRelev		IN NUMBER,
										inuCategoria		IN NUMBER,
										inuSubcategoria		IN NUMBER,
										inuPlanFacturacion	IN NUMBER,
										inuMetros			IN NUMBER
										)
	RETURN NUMBER;

END pkg_botarifas;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_botarifas IS

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
    <Fecha> 15/07/2025 </Fecha>
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
    <Unidad> fnuObtTarifaActualConcepto </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 15/07/2025 </Fecha>
    <Descripcion> 
		Obtiene la tatifa actual por concepto
    </Descripcion>
	<Parametros> 
        Entrada:
			inuTipoServicio		Tipo de servicio
			inuConcepto			Concepto
			inuMercaRelev		Mercado relevante
			inuCategoria		Categoria
			inuSubcategoria		Subcategoria
			inuPlanFacturacion	Plan de facturación
			inuMetros			Metros
		
		Salida:
			nuValorTarifa		Valor de la tarifa
			
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="15/07/2025" Inc="OSF-4734" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    FUNCTION fnuObtTarifaActualConcepto(inuTipoServicio		IN NUMBER,
										inuConcepto 		IN NUMBER,
										inuMercaRelev		IN NUMBER,
										inuCategoria		IN NUMBER,
										inuSubcategoria		IN NUMBER,
										inuPlanFacturacion	IN NUMBER,
										inuMetros			IN NUMBER
										)
	RETURN NUMBER
    IS
	
		csbMT_NAME  VARCHAR2(200) := csbSP_NAME || 'fnuObtTarifaActualConcepto';
		
		nuError				NUMBER; 
		nuValorTarifa		NUMBER;
		nuCodigoPais		NUMBER			:= NULL;
		nuCodigoEmpresa		NUMBER			:= NULL;
		nuCriteriosIdx		BINARY_INTEGER;
		nuTarifa			NUMBER;
		nuServicio			NUMBER;
		sbmensaje			VARCHAR2(1000); 
		sbCriterio01		VARCHAR2(50)	:= NULL;
		sbCriterio02		VARCHAR2(50)	:= NULL;
		sbCriterio03		VARCHAR2(50)	:= NULL;
		sbCriterio04		VARCHAR2(50)	:= NULL;		
		sbMetros			VARCHAR2(50)	:= NULL;
		sbSqlTarifas		VARCHAR2(4000);
		sbRango				VARCHAR2(10);
		dtFechaInicio		DATE;
		tbCriterios			pkg_bctarifas.tytbCriterios;
		cuTarifas        	constants_per.tyrefcursor;	
         
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuTipoServicio: ' 	|| inuTipoServicio  	|| CHR(10) ||
						'inuConcepto: '   		|| inuConcepto 			|| CHR(10) ||
						'inuMercaRelev: '		|| inuMercaRelev  		|| CHR(10) ||
						'inuCategoria: '  		|| inuCategoria			|| CHR(10) ||
						'inuSubcategoria: '  	|| inuSubcategoria		|| CHR(10) ||
						'inuPlanFacturacion: '	|| inuPlanFacturacion	|| CHR(10) ||
						'inuMetros: '  			|| inuMetros, cnuNVLTRC); 
						
		-- Obtiene el valor del parametro CODIGO_PAIS 
		nuCodigoPais 	:= pkg_parametros.fnuGetValorNumerico('CODIGO_PAIS');
		pkg_traza.trace('nuCodigoPais: ' || nuCodigoPais, cnuNVLTRC); 
		
		-- Obtiene el valor del parametro CODIGO_EMPRESA 
		nuCodigoEmpresa 	:= pkg_parametros.fnuGetValorNumerico('CODIGO_EMPRESA');
		pkg_traza.trace('nuCodigoEmpresa: ' || nuCodigoEmpresa, cnuNVLTRC); 
		
		-- Obtiene los criterios por concepto y tipo de servicio
		pkg_bctarifas.prcObtCriteriosxConcepServ(inuConcepto,
												 inuTipoServicio,
												 tbCriterios
											     );
												 
		nuCriteriosIdx := tbCriterios.first;
		
		WHILE nuCriteriosIdx IS NOT NULL LOOP
		
			pkg_traza.trace('Se obtiene el criterio ' || tbCriterios(nuCriteriosIdx).nuCriterios || ' - ' || tbCriterios(nuCriteriosIdx).sbdesc_criterio || 
							', prioridad ' || tbCriterios(nuCriteriosIdx).nuprioridad);
							
			-- Si el criterio es subcategoria
			IF (tbCriterios(nuCriteriosIdx).nuCriterios = 8) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || inuSubcategoria;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || inuSubcategoria;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || inuSubcategoria;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || inuSubcategoria;
				END IF;
			-- Si el criterio es Categoria
			ELSIF (tbCriterios(nuCriteriosIdx).nuCriterios = 7) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || inuCategoria;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || inuCategoria;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || inuCategoria;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || inuCategoria;
				END IF;
			-- Si el criterio es Mercado Relevante
			ELSIF (tbCriterios(nuCriteriosIdx).nuCriterios = 22) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || inuMercaRelev;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || inuMercaRelev;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || inuMercaRelev;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || inuMercaRelev;
				END IF;				
			-- Si el criterio es País del domicilio de instalación
			ELSIF (tbCriterios(nuCriteriosIdx).nuCriterios = 2) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || nuCodigoPais;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || nuCodigoPais;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || nuCodigoPais;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || nuCodigoPais;
				END IF;
			-- Si el criterio es Empresa
			ELSIF (tbCriterios(nuCriteriosIdx).nuCriterios = 1) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || nuCodigoEmpresa;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || nuCodigoEmpresa;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || nuCodigoEmpresa;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || nuCodigoEmpresa;
				END IF;
			-- Si el criterio es Plan de facturación
			ELSIF (tbCriterios(nuCriteriosIdx).nuCriterios = 9) THEN
				-- Si prioridad es 1
				IF (tbCriterios(nuCriteriosIdx).nuPrioridad = 1) THEN
					sbCriterio01 := 'AND tacocr01 = ' || inuPlanFacturacion;
				-- Si prioridad es 2
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 2) THEN
					sbCriterio02 := 'AND tacocr02 = ' || inuPlanFacturacion;
				-- Si prioridad es 3
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 3) THEN
					sbCriterio03 := 'AND tacocr03 = ' || inuPlanFacturacion;
				-- Si prioridad es 4
				ELSIF (tbCriterios(nuCriteriosIdx).nuPrioridad = 4) THEN
					sbCriterio04 := 'AND tacocr04 = ' || inuPlanFacturacion;
				END IF;
			END IF;		
								 
			nuCriteriosIdx := tbCriterios.NEXT(nuCriteriosIdx);
		
		END LOOP;
		
		-- Si los metros no son nulos
		IF (inuMetros IS NOT NULL) THEN
			sbMetros := 'AND ' || inuMetros || ' BETWEEN ravtliin AND ravtlisu';
		END IF;
			
		pkg_traza.trace('sbCriterio01: ' || sbCriterio01 || CHR(10) || 
						'sbCriterio02: ' || sbCriterio02 || CHR(10) || 
						'sbCriterio03: ' || sbCriterio03 || CHR(10) || 
						'sbCriterio04: ' || sbCriterio04 || CHR(10) ||
						'sbMetros: ' 	 || sbMetros, cnuNVLTRC); 
						
		-- Obtiene la consulta de las tarifas
		sbSqlTarifas := pkg_bctarifas.fsbObtConsultaTarifas(inuConcepto,
															inuTipoServicio,
															sbCriterio01,
															sbCriterio02,
															sbCriterio03,
															sbCriterio04,
															sbMetros
															);
		pkg_traza.trace('sbSqlTarifas: ' || sbSqlTarifas, cnuNVLTRC); 
		
		OPEN cuTarifas FOR sbSqlTarifas;
		FETCH cuTarifas INTO dtFechaInicio,
							 sbRango,
							 nuValorTarifa,
							 nuTarifa,
							 nuServicio;
		CLOSE cuTarifas;
		
		pkg_traza.trace('dtFechaInicio: '	|| dtFechaInicio	|| CHR(10) || 
						'sbRango: ' 		|| sbRango 			|| CHR(10) || 
						'nuValorTarifa: ' 	|| nuValorTarifa 	|| CHR(10) || 
						'nuTarifa: ' 		|| nuTarifa 		|| CHR(10) ||
						'nuServicio: ' 	 	|| nuServicio, cnuNVLTRC); 

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuValorTarifa;

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
    END fnuObtTarifaActualConcepto;
	
END pkg_botarifas;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_botarifas
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_botarifas'), 'PERSONALIZACIONES');
END;
/