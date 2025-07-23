CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_PLANSUSC
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_PLANSUSC </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-11-2024 </Fecha>
    <Descripcion> 
        Paquete primer nivel para la tabla plansusc
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-11-2024" Inc="OSF-3646" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/
	
	CURSOR cuRecord(inuCodigoPlan 		IN plansusc.plsucodi%type) 
	IS
		SELECT plansusc.*, 
			   plansusc.rowid
        FROM plansusc
       WHERE plsucodi = inuCodigoPlan;

    SUBTYPE styPlansusc  IS cuRecord%ROWTYPE;

    TYPE tytbPlanSusc IS TABLE OF styPlansusc INDEX BY BINARY_INTEGER;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-10-2024" Inc="OSF-3646" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtDescripcion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-10-2024 </Fecha>
    <Descripcion> 
        Actualiza el campo cargdoso a partir de cargcodo
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCodigoPlan		Identificador del plan de suscripcion
		
		Salida:
		sbDescripcion			Descripción del plan			
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-10-2024" Inc="OSF-3646" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbObtDescripcion(inuCodigoPlan 		IN plansusc.plsucodi%type)
	RETURN plansusc.plsudesc%TYPE;
	
END PKG_PLANSUSC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_PLANSUSC
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_PLANSUSC </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-10-2024 </Fecha>
    <Descripcion> 
        Paquete primer nivel para la tabla cargos
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-10-2024" Inc="OSF-3646" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3646';
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
    <Fecha> 27-10-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-10-2024" Inc="OSF-3646" Empresa="GDC"> 
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
    <Unidad> fsbObtDescripcion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-10-2024 </Fecha>
    <Descripcion> 
        Actualiza el campo cargdoso a partir de cargcodo
    </Descripcion>
	<Parametros> 
		Entrada:
			inuCodigoPlan		Identificador del plan de suscripcion
		
		Salida:
		sbDescripcion			Descripción del plan			
		
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="27-10-2024" Inc="OSF-3646" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbObtDescripcion(inuCodigoPlan 		IN plansusc.plsucodi%type)
	RETURN plansusc.plsudesc%TYPE
    IS
	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fsbObtDescripcion';
		
		nuError				NUMBER;  
		sbmensaje			VARCHAR2(1000);
		sbDescripcion		plansusc.plsudesc%type;
		
		CURSOR cuDescripcion(inuCodigoPlan IN plansusc.plsucodi%type) 
		IS
            SELECT plsudesc 
			FROM plansusc 
			WHERE plsucodi = inuCodigoPlan;

        PROCEDURE prcCierraCursorDescr
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.prcCierraCursorDescr';
        BEGIN

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

            IF (cuDescripcion%ISOPEN) THEN
                CLOSE cuDescripcion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END prcCierraCursorDescr;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuCodigoPlan: ' 	|| inuCodigoPlan, cnuNVLTRC); 
						
		prcCierraCursorDescr;
		
		OPEN cuDescripcion(inuCodigoPlan);
        FETCH cuDescripcion INTO sbDescripcion;
        CLOSE cuDescripcion;
		
		pkg_traza.trace('sbDescripcion: ' 	|| sbDescripcion, cnuNVLTRC); 

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbDescripcion;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			prcCierraCursorDescr;
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			prcCierraCursorDescr;
			RAISE pkg_Error.Controlled_Error;
    END fsbObtDescripcion;
	
END PKG_PLANSUSC;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_PLANSUSC'),'ADM_PERSON'); 
END;
/