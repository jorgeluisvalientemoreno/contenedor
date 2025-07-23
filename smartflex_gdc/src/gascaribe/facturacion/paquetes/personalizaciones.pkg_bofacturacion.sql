CREATE OR REPLACE PACKAGE personalizaciones.pkg_bofacturacion IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bofacturacion
    Autor       :   Jhon Erazo - MVM
    Fecha       :   15/05/2025
	
    Descripcion :   Paquete con los métodos para facturación
	
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	13/06/2025	OSF-4594	Se modifica el procedimiento prcGenerarOrdenRepartoFactura
    jerazomvm	15/05/2025	OSF-4480	Creacion
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Genera la orden de reparto de la factura
    PROCEDURE prcGenerarOrdenRepartoFactura(inuFactura		IN  factura.factcodi%TYPE,
											inuContrato		IN 	factura.factsusc%TYPE,
											osbOrdenReparto	OUT VARCHAR2
											);

END pkg_bofacturacion;
/

create or replace PACKAGE BODY   personalizaciones.pkg_bofacturacion IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4594';
    
    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc;    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Jhon Erazo - MVM
    Fecha           : 15/05/2025
	
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
    jerazomvm   15/05/2025	OSF-4480	Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcGenerarOrdenRepartoFactura
    Descripcion     : Genera la orden de reparto de la factura
	
    Autor           : Jhon Erazo - MVM
    Fecha           : 15/05/2025
	
    Parametros de Entrada
		inuFactura		Identificador de la factura
    Parametros de Salida
		osbOrdenReparto	Orden de reparto

    Modificaciones  :
    Autor       Fecha       Caso     	Descripcion
	jerazomvm	11/06/2025	OSF-4594	1. Se agrega el parametro de entrada inuContrato
										2. Se obtiene el ciclo del contrato y valida si existe en 
											el parametro, si no existe, obtiene el tipo de producto 
											facturable, si tiene tipo de producto facturable, genera 
											la orden de reparto
    jerazomvm   15/05/2025  OSF-4480	Creacion
    ***************************************************************************/
    PROCEDURE prcGenerarOrdenRepartoFactura(inuFactura		IN  factura.factcodi%TYPE,
											inuContrato		IN 	factura.factsusc%TYPE,
											osbOrdenReparto	OUT VARCHAR2
											)
    IS

        csbMT_NAME  VARCHAR2(70) := csbPqt_nombre || 'prcGenerarOrdenRepartoFactura';
		
        nuError     			NUMBER; 
		nuTipoProducto			servsusc.sesuserv%TYPE;
		nuCiclo					servsusc.sesucicl%TYPE;
		nuExisCicloEnParame		NUMBER;
		nuItemBarriosIguales    NUMBER := 4000803;
        nuItemBarriosDiferentes	NUMBER := 4000998;	
		sbMensaje				VARCHAR2(4000);
		
    BEGIN
	
        pkg_traza.trace(csbMT_NAME, cnuNvlTrc, csbInicio);
		
		pkg_traza.trace('inuFactura: ' 	|| inuFactura || CHR(10) ||
						'inuContrato: '	|| inuContrato, cnuNVLTRC);
						
		-- Obtiene el ciclo del contrato
		nuCiclo := pkg_bccontrato.fnuCicloFacturacion(inuContrato);
		pkg_traza.trace('nuCiclo: '	|| nuCiclo, cnuNVLTRC);
						
		-- Valida si el ciclo existe en parametro CICLOS_EXCL_ORDEN_REPARTO
		nuExisCicloEnParame := pkg_parametros.fnuValidaSiExisteCadena('CICLOS_EXCL_ORDEN_REPARTO',
																	  ',',
																	  nuCiclo
																	  );
		pkg_traza.trace('nuExisCicloEnParame: '	|| nuExisCicloEnParame, cnuNVLTRC);
			
		-- Si el ciclo no existe en el plarametro
		IF (nuExisCicloEnParame = 0) THEN
		
			-- Obtiene el tipo de producto y el ciclo facturable
			nuTipoProducto := pkg_bcfacturacion.fnuObtTipoProduFactura(inuFactura);
			pkg_traza.trace('nuTipoProducto: '	|| nuTipoProducto, cnuNVLTRC);
			
			-- Si la factura tiene un tipo de producto facturable
			IF (nuTipoProducto IS NOT NULL) THEN
				-- Se genera la orden de reparto
				osbOrdenReparto := pkg_bogestion_facturacion.fsbObtGenerarOrdenReparto(nuTipoProducto, 
																					   nuItemBarriosIguales, 
																					   nuItemBarriosDiferentes
																					   );
			END IF;
		END IF;
		
		pkg_traza.trace('osbOrdenReparto: ' || osbOrdenReparto, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNvlTrc, csbFin);

    EXCEPTION
		WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcGenerarOrdenRepartoFactura;

END pkg_bofacturacion;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bofacturacion
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bofacturacion'), 'PERSONALIZACIONES');
END;
/