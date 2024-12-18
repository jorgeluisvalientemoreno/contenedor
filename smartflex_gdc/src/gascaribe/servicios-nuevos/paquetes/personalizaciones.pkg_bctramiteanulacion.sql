CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCTRAMITEANULACION
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCTRAMITEANULACION </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Paquete de anulación de solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSolTerminacionContrato  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la solicitud 100262 - Terminación de contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuSolTerminacionContrato(inuSolicitudId	IN mo_packages.package_id%TYPE)
	RETURN mo_packages.package_id%TYPE;
	
END PKG_BCTRAMITEANULACION;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCTRAMITEANULACION
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_BCTRAMITEANULACION </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Paquete de anulación de solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2374';
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
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC"> 
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
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSolTerminacionContrato  </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la solicitud 100262 - Terminación de contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fnuSolTerminacionContrato(inuSolicitudId	IN mo_packages.package_id%TYPE)
	RETURN mo_packages.package_id%TYPE
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuSolTerminacionContrato ';

        nuError				NUMBER;  
		nuSolicitudId		mo_packages.package_id%type;
		sbmensaje   		VARCHAR2(1000);
        
		CURSOR cuSolTerminacionContrato IS
			SELECT mp.package_id 
			FROM mo_packages mp, mo_motive mm 
			WHERE mm.package_id = mp.package_id
			AND product_id 		IN (SELECT product_id
								   FROM mo_packages mp, mo_motive mm 
								   WHERE mp.package_id 	= inuSolicitudId
								   AND mm.package_id 	= mp.package_id
								  )
			AND package_type_id		= 100262
			AND rownum = 1
			ORDER BY request_date DESC;
		
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);
		
		IF (cuSolTerminacionContrato%ISOPEN) THEN
			CLOSE cuSolTerminacionContrato;
		END IF;
		
		OPEN cuSolTerminacionContrato;
        FETCH cuSolTerminacionContrato INTO nuSolicitudId;
		CLOSE cuSolTerminacionContrato;
		
		pkg_traza.trace('Solicitud terminación de contrato: ' || nuSolicitudId, cnuNVLTRC);
        
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSolicitudId;

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
        RETURN nuSolicitudId;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
		RETURN nuSolicitudId;
    END fnuSolTerminacionContrato ;
END PKG_BCTRAMITEANULACION;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BCTRAMITEANULACION'),'PERSONALIZACIONES'); 
END;
/