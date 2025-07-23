CREATE OR REPLACE PACKAGE adm_person.pkg_ld_asig_subsidy AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_ld_asig_subsidy</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>03-06-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel pkg_ld_asig_subsidy
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="03-06-2025" Inc="OSF-4522" Empresa="GDC">
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
    CURSOR cuRegistroRId(inuIdSubsidio IN NUMBER)   
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM ld_asig_subsidy tb
    WHERE asig_subsidy_id = inuIdSubsidio;
    
    -- 
    CURSOR cuRegistroRIdLock(inuIdSubsidio IN NUMBER)
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM ld_asig_subsidy tb
    WHERE asig_subsidy_id = inuIdSubsidio
    FOR UPDATE NOWAIT;

    -----------------------------------
    -- Metodos
    ----------------------------------- 
                                           
    -- Retorna verdadero si existe subsidio para el contrato
    FUNCTION fblExisteSubsidioContrato
    (
        inuContrato      IN ld_asig_subsidy.susccodi%TYPE,
        isbTipo_Subsidio IN ld_asig_subsidy.type_subsidy%TYPE
    ) 
    RETURN BOOLEAN;                                    
 
END pkg_ld_asig_subsidy;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ld_asig_subsidy AS
    
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
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fblExisteSubsidioContrato </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 03-06-2025 </Fecha>
        <Descripcion> 
            Retorna verdadero si existe subsidio para el contrato
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="03-06-2025" Inc="OSF-4522" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fblExisteSubsidioContrato(inuContrato      IN ld_asig_subsidy.susccodi%TYPE,
                                       isbTipo_Subsidio IN ld_asig_subsidy.type_subsidy%TYPE) 
    RETURN BOOLEAN
    IS
        --Constantes
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fblExisteSubsidioContrato'; 
        
        --Variables
        nuExiste                NUMBER;
        blExisteSubsContrato    BOOLEAN;
        
        --cursores
        CURSOR cuExisteSubsContrato IS
        SELECT count(*)
        FROM  ld_asig_subsidy
        WHERE type_subsidy = isbTipo_Subsidio
          AND susccodi = inuContrato;
          
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        IF cuExisteSubsContrato%ISOPEN THEN
            CLOSE cuExisteSubsContrato;
        END IF;
        
        OPEN cuExisteSubsContrato;
        FETCH cuExisteSubsContrato INTO nuExiste;
        CLOSE cuExisteSubsContrato;
        
        IF nuExiste > 0 THEN
            blExisteSubsContrato := TRUE;
        ELSE
            blExisteSubsContrato := FALSE;
        END IF;            
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN blExisteSubsContrato;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc);
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, cnuNvlTrc );
            RAISE pkg_error.Controlled_Error;
    END fblExisteSubsidioContrato;    
    
END pkg_ld_asig_subsidy;
/
BEGIN
    -- OSF-4522
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ld_asig_subsidy'), UPPER('adm_person'));
END;
/
