CREATE OR REPLACE PACKAGE adm_person.pkg_cc_grace_period AS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad>pkg_cc_grace_period</Unidad>
    <Autor>Paola Acosta</Autor>
    <Fecha>13-05-2025</Fecha>
    <Descripcion> 
        Paquete de primer nivel pkg_cc_grace_period
    </Descripcion>
    <Historial>
           <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC">
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
    CURSOR cuRegistroRId(inuIdPeriodoGracia IN NUMBER)   
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM cc_grace_period tb
    WHERE grace_period_id = inuIdPeriodoGracia;
    
    -- 
    CURSOR cuRegistroRIdLock(inuIdPeriodoGracia IN NUMBER)
    IS
    SELECT tb.*, 
           tb.Rowid
    FROM cc_grace_period tb
    WHERE grace_period_id = inuIdPeriodoGracia
    FOR UPDATE NOWAIT;

    -----------------------------------
    -- Metodos
    ----------------------------------- 
    
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(inuIdPeriodoGracia IN NUMBER, 
                               iblBloquea         IN BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;
    
    -- Obtiene el valor de la columna MAX_GRACE_DAYS
    FUNCTION fnuObtNumMaxDiasGracia (inuIdPeriodoGracia IN NUMBER) 
    RETURN cc_grace_period.max_grace_days%TYPE;
    
    --Actualiza el campo MIN_GRACE_DAYS
    PROCEDURE prcActualizaDiasMinGracia(inuIdPeriodoGracia IN NUMBER,
                                       inuDiasMinGracia   IN NUMBER );
    
    --Actualiza el campo MAX_GRACE_DAYS
    PROCEDURE prcActualizaDiasMaxGracia(inuIdPeriodoGracia IN NUMBER,
                                       inuDiasMaxGracia   IN NUMBER);
 
END pkg_cc_grace_period;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_cc_grace_period AS
    
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
        <Unidad> frcObtRegistroRId </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Obtiene registro y RowId
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION frcObtRegistroRId(inuIdPeriodoGracia IN NUMBER, 
                               iblBloquea         IN BOOLEAN DEFAULT FALSE) 
    RETURN cuRegistroRId%ROWTYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'frcObtRegistroRId'; 
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuIdPeriodoGracia);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuIdPeriodoGracia);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN rcRegistroRId;
        
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
    END frcObtRegistroRId;    
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtNumMaxDiasGracia  </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Obtiene el valor de la columna MAX_GRACE_DAYS
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtNumMaxDiasGracia (inuIdPeriodoGracia IN NUMBER) 
    RETURN cc_grace_period.max_grace_days%TYPE
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtNumMaxDiasGracia ';
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        rcRegistroAct := frcObtRegistroRId(inuIdPeriodoGracia);
        
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);
        
        RETURN rcRegistroAct.max_grace_days;        
     
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
    END fnuObtNumMaxDiasGracia ;  
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> prcActualizaDiasMinGracia </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Actualiza el campo MIN_GRACE_DAYS
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    PROCEDURE prcActualizaDiasMinGracia(inuIdPeriodoGracia IN NUMBER,
                                       inuDiasMinGracia   IN NUMBER )
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActualizaDiasMinGracia';
        
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        UPDATE cc_grace_period
        SET min_grace_days = inuDiasMinGracia
        WHERE grace_period_id = inuIdPeriodoGracia;
        
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
    END prcActualizaDiasMinGracia;                                        
    

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> prcActualizaDiasMaxGracia </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Actualiza el campo MAX_GRACE_DAYS
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/      
    PROCEDURE prcActualizaDiasMaxGracia(inuIdPeriodoGracia IN NUMBER,
                                       inuDiasMaxGracia   IN NUMBER)
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcActualizaDiasMaxGracia';
        
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);
        
        UPDATE cc_grace_period
        SET max_grace_days = inuDiasMaxGracia
        WHERE grace_period_id = inuIdPeriodoGracia;
        
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
    END prcActualizaDiasMaxGracia;                                      
 
END pkg_cc_grace_period;
/
BEGIN
    -- OSF-4336
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_cc_grace_period'), UPPER('adm_person'));
END;
/
