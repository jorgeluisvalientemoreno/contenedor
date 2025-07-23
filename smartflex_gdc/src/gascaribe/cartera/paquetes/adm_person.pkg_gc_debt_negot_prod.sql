CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_gc_debt_negot_prod
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   pkg_gc_debt_negot_prod
    Descripción :   Paquete de primer nivel para la tabla gc_debt_negot_prod
    Autor       :   jcatuche
    Fecha       :   23/12/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    23/12/2024    jcatuche      OSF-3810: Creación del paquete 
***************************************************************************/
    subtype styRegistro   is  gc_debt_negot_prod%rowtype; 
    
    CURSOR cuRegistroRId
    (
        inuDEBT_NEGOT_PROD_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM gc_debt_negot_prod tb
        WHERE
        DEBT_NEGOT_PROD_ID = inuDEBT_NEGOT_PROD_ID;  
        
        
    CURSOR cuRegistroRIdLock
    (
        inuDEBT_NEGOT_PROD_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM gc_debt_negot_prod tb
        WHERE
        DEBT_NEGOT_PROD_ID = inuDEBT_NEGOT_PROD_ID
        FOR UPDATE NOWAIT;  
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOT_PROD_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
    
    --Inserta registro
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro,onuCodigo OUT NUMBER);
    
    --Borra registro
    PROCEDURE prBorRegistro( inuDEBT_NEGOT_PROD_ID IN NUMBER);

END pkg_gc_debt_negot_prod;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_gc_debt_negot_prod
IS    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';          -- Constante para nombre de objeto    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsRegistro
    Descripcion     : Inserción de registro
    
    Parametros de Entrada 
    ==================== 
        ircRegistro     Registro a registrar
    
    Parametros de Salida
    ====================
        onuLdlpcons     Consecutivo insertado
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	23/12/2024      jcatuche            OSF-3810: Creación
    ***************************************************************************/
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro, onuCodigo OUT NUMBER) IS
        
        
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistro';
        nuCodigo    NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        IF ircRegistro.DEBT_NEGOT_PROD_ID IS NULL THEN
            nuCodigo := seq_gc_debt_negot_p_197149.nextval;
        ELSE
            nuCodigo := ircRegistro.DEBT_NEGOT_PROD_ID;
        END IF;
        
        INSERT INTO gc_debt_negot_prod
        (
            DEBT_NEGOT_PROD_ID,  
            DEBT_NEGOTIATION_ID,
            SESUNUSE,            
            LATE_CHARGE_LIQ_DATE,
            LATE_CHARGE_DAYS,    
            BILLED_LATE_CHARGE,  
            NOT_BILLED_LATE_CHA,
            NOT_BILLED_VALUE,    
            PENDING_BALANCE,     
            VALUE_TO_PAY,        
            EXONER_RECONN_CHARGE
        )
        VALUES
        (
            nuCodigo,
            ircRegistro.DEBT_NEGOTIATION_ID,
            ircRegistro.SESUNUSE,            
            ircRegistro.LATE_CHARGE_LIQ_DATE,
            ircRegistro.LATE_CHARGE_DAYS,    
            ircRegistro.BILLED_LATE_CHARGE,  
            ircRegistro.NOT_BILLED_LATE_CHA,
            ircRegistro.NOT_BILLED_VALUE,    
            ircRegistro.PENDING_BALANCE,     
            ircRegistro.VALUE_TO_PAY,        
            ircRegistro.EXONER_RECONN_CHARGE
        );
        
        onuCodigo := nuCodigo;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN DUP_VAL_ON_INDEX THEN
            sbError := 'El registro ['||nuCodigo||'] ya existe para la tabla GC_DEBT_NEGOT_PROD';
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsRegistro;
    
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOT_PROD_ID   NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuDEBT_NEGOT_PROD_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuDEBT_NEGOT_PROD_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorRegistro
    Descripcion     : Borra registro
    
    Parametros de Entrada 
    ==================== 
        inuDEBT_NEGOT_PROD_ID     Identificador del regsitro
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	23/12/2024      jcatuche            OSF-3810: Creación
    ***************************************************************************/
    PROCEDURE prBorRegistro( inuDEBT_NEGOT_PROD_ID IN NUMBER) IS        
        
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        rcRegistroBor   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        rcRegistroBor := frcObtRegistroRId(inuDEBT_NEGOT_PROD_ID,TRUE);
        
        IF rcRegistroBor.RowId IS NOT NULL THEN
        
            DELETE gc_debt_negot_prod
            WHERE
            ROWID = rcRegistroBor.RowId;
 
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
    
END pkg_gc_debt_negot_prod;
/
PROMPT Otorga Permisos de Ejecución a ADM_PERSON.pkg_gc_debt_negot_prod
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_GC_DEBT_NEGOT_PROD','ADM_PERSON');
END;
/
