CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_CM_VAVAFACO
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_CM_VAVAFACO </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 28-11-2024 </Fecha>
    <Descripcion> 
        Paquete primer nivel para la tabla CM_VAVAFACO
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="28-11-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/
	
	cnuSequence cm_vavafaco.vvfccons%type := SQ_CM_VAVAFACO_198733.nextval;
	
	CURSOR cuRecord(inuCodigo 		IN cm_vavafaco.vvfccons%type) 
	IS
		SELECT cm_vavafaco.*, 
			   cm_vavafaco.rowid
        FROM cm_vavafaco
       WHERE vvfccons = inuCodigo;

    SUBTYPE stycm_vavafaco  IS cuRecord%ROWTYPE;

    TYPE tytbcm_vavafaco IS TABLE OF stycm_vavafaco INDEX BY BINARY_INTEGER;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 29-11-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="29-11-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcInsRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 02-12-2024 </Fecha>
    <Descripcion> 
        Inserta el record de cm_vavafaco
    </Descripcion>
	<Parametros> 
		Entrada:
			ircRegistro		Record a insertar en CM_VAVAFACO 
		
		Salida:	
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="02-12-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prcInsRegistro(ircRegistro IN cm_vavafaco%ROWTYPE);
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> Procedimiento </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 29-11-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de vigencia
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCodigo				Identificador 
			idtFechafinalVigencia	Fecha final de vigencia
		
		Salida:	
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-11-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcActfechaFinalVigencia(inuCodigo  				IN cm_vavafaco.vvfccons%type,
									   idtFechafinalVigencia	IN cm_vavafaco.vvfcfefv%type
									   );
	
END PKG_CM_VAVAFACO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_CM_VAVAFACO
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_CM_VAVAFACO </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 29-11-2024 </Fecha>
    <Descripcion> 
        Paquete primer nivel para la tabla cargos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-11-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3725';
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
    <Fecha> 29-11-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-11-2024" Inc="OSF-3725" Empresa="GDC"> 
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
    <Unidad> prcInsRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 02-12-2024 </Fecha>
    <Descripcion> 
        Inserta el record de cm_vavafaco
    </Descripcion>
	<Parametros> 
		Entrada:
			ircRegistro		Record a insertar en CM_VAVAFACO 
		
		Salida:	
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="02-12-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prcInsRegistro(ircRegistro IN cm_vavafaco%ROWTYPE) 
	IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME||'prcInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
	
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
		
        INSERT INTO cm_vavafaco(VVFCCONS,
								VVFCVAFC,
								VVFCFEIV,
								VVFCFEFV,
								VVFCVALO,
								VVFCVAPR, 
								VVFCUBGE, 
								VVFCSESU
								)
        VALUES (ircRegistro.VVFCCONS,
				ircRegistro.VVFCVAFC,
				ircRegistro.VVFCFEIV,
				ircRegistro.VVFCFEFV,
				ircRegistro.VVFCVALO,
				ircRegistro.VVFCVAPR,
				ircRegistro.VVFCUBGE,
				ircRegistro.VVFCSESU
				);
		
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.Controlled_Error THEN
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
    END prcInsRegistro;
	
	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> Procedimiento </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 29-11-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de vigencia
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCodigo				Identificador 
			idtFechafinalVigencia	Fecha final de vigencia
		
		Salida:	
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-11-2024" Inc="OSF-3725" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcActfechaFinalVigencia(inuCodigo  				IN cm_vavafaco.vvfccons%type,
									   idtFechafinalVigencia	IN cm_vavafaco.vvfcfefv%type
									   )
    IS
	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'prcActfechaFinalVigencia';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuCodigo: ' 				|| inuCodigo || CHR(10) ||
						'idtFechafinalVigencia: ' 	|| idtFechafinalVigencia, cnuNVLTRC); 
						
		
		UPDATE cm_vavafaco
		SET vvfcfefv = idtFechafinalVigencia
		WHERE vvfccons = inuCodigo;

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
    END prcActfechaFinalVigencia;
	
END PKG_CM_VAVAFACO;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_CM_VAVAFACO'),'ADM_PERSON'); 
END;
/