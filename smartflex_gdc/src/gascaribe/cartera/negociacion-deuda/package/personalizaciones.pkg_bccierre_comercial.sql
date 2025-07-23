CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bccierre_comercial IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   31-03-2025
		Descripcion :   Paquete con logica del cierre comercial
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	31/02/2025	OSF-4155	Creación
	*******************************************************************************/
	
	-- Record de datos de información del producto cierre comercial
	TYPE tyrcInfoCierreComer IS RECORD(nuProducto 			NUMBER,
									   nuLocalidad			NUMBER,
									   nuSegmento_predio	NUMBER,
									   nuDireccion			NUMBER,
									   nuCategoria			NUMBER,
									   nuSubcategoria		NUMBER,
									   nuEstado_corte		NUMBER,
									   nuPlan_comercial		NUMBER,	
									   nuNro_ctas_con_saldo	NUMBER,
									   sbEstado_financiero	VARCHAR2(1),
									   nuUltimo_plan_fina	NUMBER
									   );
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 31-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="Jhon.Erazo" Fecha="31-03-2025" Inc="OSF-4155" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Obtiene la fecha habil, del cierre comercial	
	PROCEDURE prcObtFechaHabil(inuProducto	IN NUMBER,
							   onuAno 		OUT NUMBER,
							   onuMes		OUT NUMBER
							   );
	
	-- Obtiene información del cierre comercial del producto	
	PROCEDURE prcObtInfoProducto(inuProducto		IN NUMBER,
								 inuAno 			IN NUMBER,
								 inuMes				IN NUMBER,
								 orcInfoProducto	OUT tyrcInfoCierreComer
								 );
									
END pkg_bccierre_comercial;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bccierre_comercial IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4155';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 31-03-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="31-03-2025" Inc="OSF-4155" Empresa="GDC"> 
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
    Programa        : prcObtFechaHabil
    Descripcion     : Obtiene la fecha habil, del cierre comercial
    Autor           : Jhon Erazo
    Fecha           : 31-03-2025
  
    Parametros de Entrada
		inuProducto		Producto
	  
    Parametros de Salida
		onuAno 			Año
		onuMes			Mes
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	31/03/2025	OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtFechaHabil(inuProducto	IN NUMBER,
							   onuAno 		OUT NUMBER,
							   onuMes		OUT NUMBER
							   )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtFechaHabil';
		
		nuError			NUMBER;  
		nuSpecialPlan	NUMBER;
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cuFechaHabil 
		IS
			SELECT cicoano, cicomes
			FROM (SELECT cicoano, cicomes
				  FROM ldc_ciercome
				  WHERE cicoesta = 'S'
				  AND EXISTS (SELECT 1
							  FROM ldc_osf_sesucier
							  WHERE producto = inuProducto
						      AND nuano 	 = cicoano
							  AND numes 	 = cicomes
							  )
				  ORDER BY cicofein DESC
                  )
			WHERE ROWNUM < 2;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);
		
		IF (cuFechaHabil%ISOPEN) THEN
			CLOSE cuFechaHabil;
		END IF;
		
		OPEN cuFechaHabil;
		FETCH cuFechaHabil INTO onuAno, onuMes;			  
		
		IF (cuFechaHabil%notfound) THEN
			onuAno   := NULL;
			onuMes   := NULL;
		END IF;
		
		CLOSE cuFechaHabil;
		
		pkg_traza.trace('onuAno: ' || onuAno || CHR(10) ||
						'onuMes: ' || onuMes, cnuNVLTRC);

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
	END prcObtFechaHabil;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtInfoProducto
    Descripcion     : Obtiene información del cierre comercial del producto
    Autor           : Jhon Erazo
    Fecha           : 31-03-2025
  
    Parametros de Entrada
		inuProducto		Producto
		inuAno 			Año
		inuMes			Mes
	  
    Parametros de Salida
		orcInfoProducto	Record con la información del producto
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	31/03/2025	OSF-4155	Creación
	***************************************************************************/	
	PROCEDURE prcObtInfoProducto(inuProducto		IN NUMBER,
								 inuAno 			IN NUMBER,
								 inuMes				IN NUMBER,
								 orcInfoProducto	OUT tyrcInfoCierreComer
								 )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtInfoProducto';
		
		nuError			NUMBER; 
		sbmensaje		VARCHAR2(1000);	
		
		CURSOR cuInfoProducto IS
			SELECT  ldc_osf_sesucier.producto,
					ldc_osf_sesucier.localidad,
					ldc_osf_sesucier.segmento_predio,
					(SELECT d.address_id 
					 FROM pr_product d 
					 WHERE d.product_id = ldc_osf_sesucier.producto
					) direccion,
					sesucate categoria,
					sesusuca subcategoria,
					sesuesco estado_corte,
					(SELECT d.commercial_plan_id 
					 FROM pr_product d 
					 WHERE d.product_id = ldc_osf_sesucier.producto
					) plan_comercial,
					(SELECT COUNT(1) 
					 FROM cuencobr 
					 WHERE cuconuse = producto 
					 AND cucosacu - cucovare - cucovrap > 0
					) nro_ctas_con_saldo,
				    sesuesfn estado_financiero,
					ldc_osf_sesucier.ultimo_plan_fina
			FROM ldc_osf_sesucier, 
				  servsusc
			WHERE producto 	= inuProducto
			AND sesunuse 	= producto
			AND nuano 		= inuAno
			AND numes 		= inuMes;
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProducto: '	|| inuProducto || CHR(10) ||
						'inuAno: ' 		|| inuAno	   || CHR(10) ||
						'inuMes: ' 		|| inuMes, cnuNVLTRC);
		
		IF (cuInfoProducto%ISOPEN) THEN
			CLOSE cuInfoProducto;
		END IF;
		
		OPEN cuInfoProducto;
		FETCH cuInfoProducto INTO orcInfoProducto;			  
		CLOSE cuInfoProducto;

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
	END prcObtInfoProducto;

END pkg_bccierre_comercial;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_bccierre_comercial
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_bccierre_comercial'), 'PERSONALIZACIONES');
END;
/