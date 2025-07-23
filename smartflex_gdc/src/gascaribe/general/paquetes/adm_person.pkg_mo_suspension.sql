CREATE OR REPLACE PACKAGE adm_person.pkg_mo_suspension AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_mo_suspension</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>21-04-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel mo_suspension
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC">
               Creación
           </Modificacion>          
     </Historial>
     </Package>
    ******************************************************************/
    
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF mo_suspension%ROWTYPE INDEX BY BINARY_INTEGER;
    
    -----------------------------------
    -- Cursores
    -----------------------------------
    CURSOR cumo_suspension 
    IS 
    SELECT * 
    FROM mo_suspension;

    CURSOR cuRegistroRId(inuMotive_id IN NUMBER)
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM mo_suspension tb
    WHERE motive_id = inuMotive_id;
     
    CURSOR cuRegistroRIdLock(inuMotive_id IN NUMBER)
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM mo_suspension tb
    WHERE motive_id = inuMotive_id
    FOR UPDATE NOWAIT;
    
    -----------------------------------
    -- Metodos
    ----------------------------------- 
    
    /*****************************************************************
    Unidad      : prActFechaFinal
    Descripcion : Actualiza la fecha final de las suspensiones del motivo, mediante el 
                  tipo de suspensión, la fecha de registro y el id del motivo
    ******************************************************************/
    PROCEDURE prActFechaFinal(inuIdMotivo      IN mo_suspension.motive_id%TYPE,
                              inuTipoSusp      IN mo_suspension.suspension_type_id%TYPE,
                              idtFechaRegis    IN mo_suspension.register_date%tYPE,                              
                              idtNueFechaFinal IN mo_suspension.ending_date%TYPE); 
 
END pkg_mo_suspension;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_mo_suspension AS
    
    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVersion      CONSTANT VARCHAR2(10)  := 'OSF-4270';
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
    <Procedure Fuente="Propiedad Intelectual de GDC <Empresa>">
    <Unidad> prActFechaFinal </Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha> 21-04-2025 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de las suspensiones del motivo, 
        mediante el tipo de suspensión, la fecha de registro y el id del motivo
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-3857" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/   
    PROCEDURE prActFechaFinal(inuIdMotivo      IN mo_suspension.motive_id%TYPE,
                              inuTipoSusp      IN mo_suspension.suspension_type_id%TYPE,
                              idtFechaRegis    IN mo_suspension.register_date%tYPE,                              
                              idtNueFechaFinal IN mo_suspension.ending_date%TYPE) 
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prActFechaFinal';
        
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        UPDATE mo_suspension
        SET ending_date = idtNueFechaFinal
        WHERE suspension_type_id = inuTipoSusp
            AND TRUNC(register_date) = TRUNC(idtFechaRegis)
            AND motive_id = inuIdMotivo;
            
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
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
    END prActFechaFinal;
                               
 
END pkg_mo_suspension;
/
BEGIN
    -- OSF-4270
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_mo_suspension'), UPPER('adm_person'));
END;
/
