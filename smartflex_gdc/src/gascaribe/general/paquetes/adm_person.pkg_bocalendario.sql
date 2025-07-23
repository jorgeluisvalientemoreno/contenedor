CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOCALENDARIO
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOCALENDARIO </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Logica de calendario
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtDiasNoFestivos </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene los días habiles en un rango de fechas
    </Descripcion>
	<Parametros> 
		Entrada:
			idtFechaInicio 	Fecha inicio conteo de días habiles
			idtFechaFin 	Fecha fin conteo de días habiles
			
		Salida:
			nuDiasHabiles	Retorna la cantidad de días habiles del rango de fechas
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtDiasNoFestivos(idtFechaInicio	IN DATE,
								  idtFechaFin		IN DATE
								  )
	RETURN NUMBER;	
	
END PKG_BOCALENDARIO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOCALENDARIO
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BOCALENDARIO </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Logica de calendario
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3801';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
	
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtDiasNoFestivos </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene los días habiles en un rango de fechas
    </Descripcion>
	<Parametros> 
		Entrada:
			idtFechaInicio 	Fecha inicio conteo de días habiles
			idtFechaFin 	Fecha fin conteo de días habiles
			
		Salida:
			nuDiasHabiles	Retorna la cantidad de días habiles del rango de fechas
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtDiasNoFestivos(idtFechaInicio	IN DATE,
								  idtFechaFin		IN DATE
								  )
	RETURN NUMBER
    IS
	
		csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'fnuObtDiasNoFestivos';
		
		nuError			NUMBER; 
		nuDiasHabiles	NUMBER;
		sbmensaje		VARCHAR2(1000);
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('idtFechaInicio: '  || idtFechaInicio || CHR(10) || 
						'idtFechaFin: ' 	|| idtFechaFin, cnuNVLTRC); 
		
		-- Valida los días habiles que han pasado desde la fecha de vencimiento de la cuenta de cobro
		nuDiasHabiles := pkHolidayMgr.fnuGetNumOfDayNonHoliday(idtFechaInicio, 
															   idtFechaFin
															   );

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuDiasHabiles;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuDiasHabiles;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuDiasHabiles;
    END fnuObtDiasNoFestivos;
	
END PKG_BOCALENDARIO;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BOCALENDARIO'),'ADM_PERSON'); 
END;
/