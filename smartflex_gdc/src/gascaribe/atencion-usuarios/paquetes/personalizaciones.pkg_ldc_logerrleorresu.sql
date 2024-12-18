CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_LDC_LOGERRLEORRESU
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_LDC_LOGERRLEORRESU </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión del log de errores de legalizacion de ordenes de reco y susp admin
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC">
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
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ins_ldc_logerrleorresu </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
       Proceso de inserción a la tabla ldc_logerrleorresu
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prc_ins_ldc_logerrleorresu(inuordenId			IN NUMBER,
										 inuOrdenPadre 		IN NUMBER,
										 isbProceso			IN VARCHAR2,
										 isbMensajeError	IN VARCHAR2,
										 idtFechaGene		IN DATE,
										 isbUsuario			IN VARCHAR2
										);
END PKG_LDC_LOGERRLEORRESU;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_LDC_LOGERRLEORRESU 
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_LDC_LOGERRLEORRESU </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
        Paquete de gestión del log de errores de legalizacion de ordenes de reco y susp admin
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2592';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
    -----------------------------------
    -- Variables privadas del package


    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC"> 
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
    <Unidad> prc_ins_ldc_logerrleorresu </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 06-02-2024 </Fecha>
    <Descripcion> 
       Proceso de inserción a la tabla ldc_logerrleorresu
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="06-02-2024" Inc="OSF-2199" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="Dsaltarinh" Fecha="29-05-2024" Inc="OSF-2592" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prc_ins_ldc_logerrleorresu(inuordenId			IN NUMBER,
										 inuOrdenPadre 		IN NUMBER,
										 isbProceso			IN VARCHAR2,
										 isbMensajeError	IN VARCHAR2,
										 idtFechaGene		IN DATE,
										 isbUsuario			IN VARCHAR2
										)
    IS
    PRAGMA AUTONOMOUS_TRANSACTION;
		csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'prc_ins_ldc_logerrleorresu';
		
		nuError		 	NUMBER;  
		sbmensaje	 	VARCHAR2(1000);
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuordenId: '		|| inuordenId  		|| chr(10) ||
						'inuOrdenPadre: ' 	|| inuOrdenPadre 	|| chr(10) ||
						'isbProceso: ' 		|| isbProceso		|| chr(10) ||
						'isbMensajeError: '	|| isbMensajeError	|| chr(10) ||
						'idtFechaGene: '	|| idtFechaGene 	|| chr(10) ||
						'isbUsuario: '		|| isbUsuario, cnuNVLTRC);
						
		INSERT INTO ldc_logerrleorresu(order_id,
									   ordepadre, 
									   proceso, 
									   menserror,
									   fechgene,
									   usuario
									   )
		VALUES (inuordenId,
				inuOrdenPadre,
				isbProceso,
				isbMensajeError,
				idtFechaGene,
				isbUsuario
			   );
        commit;
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prc_ins_ldc_logerrleorresu;
END PKG_LDC_LOGERRLEORRESU;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_LDC_LOGERRLEORRESU'),'PERSONALIZACIONES'); 
END;
/