CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_DEFECTOS_OIA AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_DEFECTOS_OIA%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_DEFECTOS_OIA IS SELECT * FROM LDC_DEFECTOS_OIA;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_DEFECTOS_OIA
        Caso  : OSF-3828
        Fecha : 08/01/2025 11:31:14
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_DEFECTOS_OIA tb
        WHERE
        CERTIFICADOS_OIA_ID = inuCERTIFICADOS_OIA_ID AND
        DEFECT_ID = inuDEFECT_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_DEFECTOS_OIA tb
        WHERE
        CERTIFICADOS_OIA_ID = inuCERTIFICADOS_OIA_ID AND
        DEFECT_ID = inuDEFECT_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_DEFECTOS_OIA%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
    
    -- Obtiene el total de defectos
    FUNCTION fnuObtTotalDefectos(inuCERTIFICADOS_OIA_ID NUMBER) RETURN NUMBER;

    -- Obtiene el total de defectos no reparables 
    FUNCTION fnuObtTotalDefNoReparables(inuCERTIFICADOS_OIA_ID NUMBER) RETURN NUMBER;

END pkg_LDC_DEFECTOS_OIA;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_DEFECTOS_OIA AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCERTIFICADOS_OIA_ID,inuDEFECT_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCERTIFICADOS_OIA_ID,inuDEFECT_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    -- Retorna verdadero si el registro existe
    FUNCTION fblExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,inuDEFECT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.CERTIFICADOS_OIA_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fblExiste;
 
    -- Eleva error si el registro no existe
    PROCEDURE prValExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuCERTIFICADOS_OIA_ID,inuDEFECT_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuCERTIFICADOS_OIA_ID||','||inuDEFECT_ID||'] en la tabla[LDC_DEFECTOS_OIA]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prValExiste;
 
    -- Inserta un registro
    PROCEDURE prInsRegistro( ircRegistro cuLDC_DEFECTOS_OIA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_DEFECTOS_OIA(
            CERTIFICADOS_OIA_ID,DEFECT_ID
        )
        VALUES (
            ircRegistro.CERTIFICADOS_OIA_ID,ircRegistro.DEFECT_ID
        );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCERTIFICADOS_OIA_ID    NUMBER,inuDEFECT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,inuDEFECT_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_DEFECTOS_OIA
            WHERE 
            ROWID = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE LDC_DEFECTOS_OIA
            WHERE RowId = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistroxRowId;
 
    -- Obtiene el total de defectos
    FUNCTION fnuObtTotalDefectos(inuCERTIFICADOS_OIA_ID NUMBER) RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTotalDefectos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuTotalDefectos NUMBER;

        CURSOR cuObtTotalDefectos
        IS
        select  count(distinct defect_id)
        from    ldc_defectos_oia b
        where   b.certificados_oia_id = inuCERTIFICADOS_OIA_ID;
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtTotalDefectos;
        FETCH cuObtTotalDefectos INTO nuTotalDefectos;
        CLOSE cuObtTotalDefectos;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            
        RETURN nuTotalDefectos;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuTotalDefectos;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuTotalDefectos;      
    END fnuObtTotalDefectos;
 
    -- Obtiene el total de defectos no reparables
    FUNCTION fnuObtTotalDefNoReparables(inuCERTIFICADOS_OIA_ID NUMBER) RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTotalDefNoReparables';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        nuTotalDefNoReparables  NUMBER; 

        sbDefectsNoRepair       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_DEFECTOS_NO_REPARABLES');
                
        CURSOR cuObtTotalDefNoReparables
        IS
        select  count(1)
        FROM    ldc_defectos_oia b
        where   b.certificados_oia_id = inuCERTIFICADOS_OIA_ID
        and     b.defect_id IN  
        (
            SELECT to_number(regexp_substr(sbDefectsNoRepair,'[^,]+', 1,LEVEL))
            FROM dual
            CONNECT BY regexp_substr(sbDefectsNoRepair, '[^,]+', 1, LEVEL) IS NOT NULL
        );
                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtTotalDefNoReparables;
        FETCH cuObtTotalDefNoReparables INTO nuTotalDefNoReparables;
        CLOSE cuObtTotalDefNoReparables;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            
        RETURN nuTotalDefNoReparables;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuTotalDefNoReparables;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuTotalDefNoReparables;   
    END fnuObtTotalDefNoReparables;

END pkg_LDC_DEFECTOS_OIA;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_DEFECTOS_OIA'), UPPER('adm_person'));
END;
/

