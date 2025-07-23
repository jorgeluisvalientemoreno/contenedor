CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_ordsinasigaut AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de EFG">
    <Unidad>pkg_ldc_ordsinasigaut</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>26-06-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel tabla ldc_ordsinasigaut
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-06-2025" Inc="OSF-4609" Empresa="EFG">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
    
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------

    -----------------------------------
    -- Cursores
    -----------------------------------
    --
    CURSOR cuRegistroRId(inuIdOrden IN NUMBER)   
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM ldc_ordsinasigaut tb
    WHERE order_id = inuIdOrden;
    
    -- 
    CURSOR cuRegistroRIdLock(inuIdOrden IN NUMBER)
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM ldc_ordsinasigaut tb
    WHERE order_id = inuIdOrden
    FOR UPDATE NOWAIT;

    -----------------------------------
    -- Metodos
    ----------------------------------- 
                                           
    --Inserta registro en la tabla ldc_ordsinasigaut
    PROCEDURE prcInsRegistroMedControl
    (
        inuIdOrden        IN ldc_ordsinasigaut.order_id%TYPE,
        inuIdSolicitud    IN ldc_ordsinasigaut.package_id%TYPE,                                       
        isbInconsistencia IN ldc_ordsinasigaut.inconsistencia%TYPE
    );                                    
 
END pkg_ldc_ordsinasigaut;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_ordsinasigaut AS
    
    --------------------------------------------
    -- Constantes 
    --------------------------------------------  
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
    cnuNvlTrc       CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_erc;  
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);    
    
    -----------------------------------
    -- Metodos
    -----------------------------------    
        
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de EFG>
    <Unidad>prcInsRegistroMedControl</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 26-06-2025 </Fecha>
    <Descripcion> 
        Permite registrar las inconsitencias generadas por la asignacion automatica.
        controlando el regsitro mediante el parametro LOG_ASIGNACION_CONTROL.
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="26-06-2025" Inc="OSF-4609" Empresa="EFG">
               Creacion
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcInsRegistroMedControl(inuIdOrden        IN ldc_ordsinasigaut.order_id%TYPE,
                                       inuIdSolicitud    IN ldc_ordsinasigaut.package_id%TYPE,                                       
                                       isbInconsistencia IN ldc_ordsinasigaut.inconsistencia%TYPE)
    IS
		csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prcInsRegistroMedControl';
        
        csbControlLog CONSTANT ld_parameter.value_chain%TYPE := NVL(pkg_bcld_parameter.fsbObtieneValorCadena('LOG_ASIGNACION_CONTROL'), 'N');
        
    BEGIN		
		pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);
		
		pkg_traza.trace('csbControlLog: ' ||csbControlLog||chr(10)||
                        'inuIdOrden: ' ||inuIdOrden||chr(10)||
                        'inuIdSolicitud: ' ||inuIdSolicitud, cnuNvlTrc);
        pkg_traza.trace('isbInconsistencia: ' ||isbInconsistencia, cnuNvlTrc);                        
						
        IF csbControlLog = 'S' THEN        

            INSERT INTO ldc_ordsinasigaut
                (package_id,
                 order_id,
                 created_date,
                 inconsistencia)
            VALUES
                (inuIdSolicitud,
                 inuIdOrden,
                 SYSDATE,
                 isbInconsistencia);
        END IF;

		pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prcInsRegistroMedControl;   
    
END pkg_ldc_ordsinasigaut;
/
BEGIN
    -- OSF-4609
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ldc_ordsinasigaut'), UPPER('adm_person'));
END;
/
