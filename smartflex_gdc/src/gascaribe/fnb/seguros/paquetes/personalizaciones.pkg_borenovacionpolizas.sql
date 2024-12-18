CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BORENOVACIONPOLIZAS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BORENOVACIONPOLIZAS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Paquete de renovación de polizas
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
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidacionesLDRPC </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Realiza las validaciones del proceso LDRPC
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcValidacionesLDRPC(isbNombreEjecutable	IN sa_executable.name%TYPE,
								   isbParametros		IN ge_process_schedule.parameters_%TYPE,
								   onuCodigoError		OUT NUMBER,
								   osbMensajeError  	OUT VARCHAR2
								   );
	
END PKG_BORENOVACIONPOLIZAS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BORENOVACIONPOLIZAS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BORENOVACIONPOLIZAS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Paquete de renovación de polizas
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
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidacionesLDRPC </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 14-03-2024 </Fecha>
    <Descripcion> 
        Realiza las validaciones del proceso LDRPC
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="14-03-2024" Inc="OSF-2169" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcValidacionesLDRPC(isbNombreEjecutable	IN sa_executable.name%TYPE,
								   isbParametros		IN ge_process_schedule.parameters_%TYPE,
								   onuCodigoError		OUT NUMBER,
								   osbMensajeError  	OUT VARCHAR2
								   )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcValidacionesLDRPC';
		
		nuError				NUMBER;  
		nuPrograActivos		NUMBER;
		sbmensaje			VARCHAR2(1000);  
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('isbNombreEjecutable: ' || isbNombreEjecutable || chr(10) ||
						'isbParametros: ' 		|| isbParametros, cnuNVLTRC);
		
		-- Obtiene la cantidad de programas activos
		nuPrograActivos := pkg_bcprocesos_programados.fnuExisteProgActiva(isbNombreEjecutable,
																		 isbParametros
																		 ); 
		onuCodigoError := 0;																 
		
		IF (nuPrograActivos > 0) THEN
			onuCodigoError 	:= pkg_error.CNUGENERIC_MESSAGE;
			osbMensajeError := 'El proceso LDRPC ya se encuentra en ejecución con los mismos parámetros ingresados.';
		END IF;
		
		pkg_traza.trace('onuCodigoError: ' 	|| onuCodigoError || chr(10) ||
						'osbMensajeError: '	|| osbMensajeError, cnuNVLTRC);
        
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
    END prcValidacionesLDRPC;
END PKG_BORENOVACIONPOLIZAS;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BORENOVACIONPOLIZAS'),'PERSONALIZACIONES'); 
END;
/