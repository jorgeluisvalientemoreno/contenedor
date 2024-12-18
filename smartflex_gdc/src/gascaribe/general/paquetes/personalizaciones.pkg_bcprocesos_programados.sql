CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCPROCESOS_PROGRAMADOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCPROCESOS_PROGRAMADOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Paquete de consulta de procesos programados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
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
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuExisteProgActiva </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Obtiene la cantidad de procesos activos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuExisteProgActiva(isbNombreEjecutable	IN sa_executable.name%TYPE,
								 isbParametros			IN ge_process_schedule.parameters_%TYPE
								 )
	RETURN NUMBER;
	
END PKG_BCPROCESOS_PROGRAMADOS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCPROCESOS_PROGRAMADOS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCPROCESOS_PROGRAMADOS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Paquete de consulta de procesos programados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2169';
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
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC"> 
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
    <Unidad> fnuExisteProgActiva </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Obtiene la cantidad de procesos activos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuExisteProgActiva(isbNombreEjecutable	IN sa_executable.name%TYPE,
								 isbParametros			IN ge_process_schedule.parameters_%TYPE
								 )
	RETURN NUMBER
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuExisteProgActiva';
		
		nuError				NUMBER;  
		nuPrograActivos		NUMBER;
		sbmensaje			VARCHAR2(1000);  
		
		CURSOR cuPrograActivos IS
			SELECT count(1) 
			FROM ge_process_schedule 
			WHERE executable_id = (SELECT EXECUTABLE_ID 
								   FROM SA_EXECUTABLE 
								   WHERE NAME = isbNombreEjecutable
								   ) 
			AND parameters_ = isbParametros 
			AND job > 0;  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('isbNombreEjecutable: ' || isbNombreEjecutable || chr(10) ||
						'isbParametros: ' 		|| isbParametros, cnuNVLTRC);
		
		IF (cuPrograActivos%ISOPEN) THEN
			CLOSE cuPrograActivos;
		END IF;
		
		OPEN cuPrograActivos;
		FETCH cuPrograActivos INTO nuPrograActivos;
		CLOSE cuPrograActivos;
		
		pkg_traza.trace('nuPrograActivos: ' || nuPrograActivos, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuPrograActivos;

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
    END fnuExisteProgActiva;
END PKG_BCPROCESOS_PROGRAMADOS;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BCPROCESOS_PROGRAMADOS'),'PERSONALIZACIONES'); 
END;
/