CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_gc_debt_negot_charge
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   pkg_gc_debt_negot_charge
    Descripción :   Paquete de primer nivel para la tabla gc_debt_negot_charge
    Autor       :   jcatuche
    Fecha       :   23/12/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    23/12/2024    jcatuche      OSF-3810: Creación del paquete 
***************************************************************************/
    subtype styRegistro   is  gc_debt_negot_charge%rowtype; 
    
    CURSOR cuRegistroRId
    (
        inuDEBT_NEGOT_CHARGE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM gc_debt_negot_charge tb
        WHERE
        DEBT_NEGOT_CHARGE_ID = inuDEBT_NEGOT_CHARGE_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuDEBT_NEGOT_CHARGE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM gc_debt_negot_charge tb
        WHERE
        DEBT_NEGOT_CHARGE_ID = inuDEBT_NEGOT_CHARGE_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
    
    -- Obtiene el registro 
    FUNCTION frcObtRegistro(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN styRegistro;
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Inserta registro
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro,onuCodigo OUT NUMBER);
    
    -- Obtiene el valor de la columna BILLED_VALUE
    FUNCTION fnuObtBILLED_VALUE(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER
        ) RETURN gc_debt_negot_charge.BILLED_VALUE%TYPE;
    
    -- Actualiza el valor de la columna BILLED_VALUE
    PROCEDURE prAcBILLED_VALUE(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER,
        inuBILLED_VALUE    NUMBER
    );
    
    --Borra registro
    PROCEDURE prBorRegistro( inuDEBT_NEGOT_CHARGE_ID IN NUMBER);
    

END pkg_gc_debt_negot_charge;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_gc_debt_negot_charge
IS    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';          -- Constante para nombre de objeto    
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
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
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro,onuCodigo OUT NUMBER) IS
        
        
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistro';
        nuCodigo    NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        
        IF ircRegistro.DEBT_NEGOT_CHARGE_ID IS NULL THEN
            nuCodigo := seq_gc_debt_negot_c_197160.nextval;
        ELSE
            nuCodigo := ircRegistro.DEBT_NEGOT_CHARGE_ID;
        END IF;
        
        INSERT INTO gc_debt_negot_charge
        (
            DEBT_NEGOT_CHARGE_ID,  
            DEBT_NEGOT_PROD_ID,
            CONCCODI,            
            BILLED_UNITS,        
            BILLED_VALUE,        
            BILLED_BASE_VALUE,  
            CREATION_DATE,      
            SUPPORT_DOCUMENT,  
            DOCUMENT_CONSECUTIVE,
            CALL_CONSECUTIVE,
            USER_ID,      
            SIGNCODI,         
            PEFACODI,        
            CUCOCODI,     
            CACACODI,      
            IS_DISCOUNT 
        )        
        VALUES
        (
            nuCodigo,
            ircRegistro.DEBT_NEGOT_PROD_ID,
            ircRegistro.CONCCODI,           
            ircRegistro.BILLED_UNITS,       
            ircRegistro.BILLED_VALUE,       
            ircRegistro.BILLED_BASE_VALUE,  
            ircRegistro.CREATION_DATE,      
            ircRegistro.SUPPORT_DOCUMENT,  
            ircRegistro.DOCUMENT_CONSECUTIVE,
            ircRegistro.CALL_CONSECUTIVE,
            ircRegistro.USER_ID,      
            ircRegistro.SIGNCODI,         
            ircRegistro.PEFACODI,        
            ircRegistro.CUCOCODI,     
            ircRegistro.CACACODI,      
            ircRegistro.IS_DISCOUNT
        );
        
        onuCodigo := nuCodigo;
        
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN DUP_VAL_ON_INDEX THEN
            sbError := 'El registro ['||nuCodigo||'] ya existe para la tabla gc_debt_negot_charge';
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Erc);
            pkg_error.setErrorMessage( isbMsgErrr => sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsRegistro;
    
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuDEBT_NEGOT_CHARGE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuDEBT_NEGOT_CHARGE_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
    
    -- Obtiene el registro 
    FUNCTION frcObtRegistro(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN styRegistro IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
        rcRegistro      styRegistro;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuDEBT_NEGOT_CHARGE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuDEBT_NEGOT_CHARGE_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        
        rcRegistro.DEBT_NEGOT_CHARGE_ID := rcRegistroRId.DEBT_NEGOT_CHARGE_ID;
        rcRegistro.DEBT_NEGOT_PROD_ID   := rcRegistroRId.DEBT_NEGOT_PROD_ID; 
        rcRegistro.CONCCODI             := rcRegistroRId.CONCCODI;           
        rcRegistro.BILLED_UNITS         := rcRegistroRId.BILLED_UNITS;        
        rcRegistro.BILLED_VALUE         := rcRegistroRId.BILLED_VALUE;        
        rcRegistro.BILLED_BASE_VALUE    := rcRegistroRId.BILLED_BASE_VALUE;   
        rcRegistro.CREATION_DATE        := rcRegistroRId.CREATION_DATE;       
        rcRegistro.SUPPORT_DOCUMENT     := rcRegistroRId.SUPPORT_DOCUMENT;    
        rcRegistro.DOCUMENT_CONSECUTIVE := rcRegistroRId.DOCUMENT_CONSECUTIVE;
        rcRegistro.CALL_CONSECUTIVE     := rcRegistroRId.CALL_CONSECUTIVE;    
        rcRegistro.USER_ID              := rcRegistroRId.USER_ID;             
        rcRegistro.SIGNCODI             := rcRegistroRId.SIGNCODI;            
        rcRegistro.PEFACODI             := rcRegistroRId.PEFACODI;            
        rcRegistro.CUCOCODI             := rcRegistroRId.CUCOCODI;            
        rcRegistro.CACACODI             := rcRegistroRId.CACACODI;            
        rcRegistro.IS_DISCOUNT          := rcRegistroRId.IS_DISCOUNT;         
        
        RETURN rcRegistro;
        
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END frcObtRegistro;
    
    -- Obtiene el valor de la columna BILLED_VALUE
    FUNCTION fnuObtBILLED_VALUE(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER
        ) RETURN gc_debt_negot_charge.BILLED_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtBILLED_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOT_CHARGE_ID);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFIN);
        RETURN rcRegistroAct.BILLED_VALUE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza,csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtBILLED_VALUE;
    
    -- Actualiza el valor de la columna BILLED_VALUE
    PROCEDURE prAcBILLED_VALUE(
        inuDEBT_NEGOT_CHARGE_ID    NUMBER,
        inuBILLED_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBILLED_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOT_CHARGE_ID,TRUE);
        IF NVL(inuBILLED_VALUE,-1) <> NVL(rcRegistroAct.BILLED_VALUE,-1) THEN
            UPDATE gc_debt_negot_charge
            SET BILLED_VALUE=inuBILLED_VALUE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcBILLED_VALUE;
 
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorRegistro
    Descripcion     : Borra registro
    
    Parametros de Entrada 
    ==================== 
        inuDEBT_NEGOT_CHARGE_ID     Identificador del regsitro
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	23/12/2024      jcatuche            OSF-3810: Creación
    ***************************************************************************/
    PROCEDURE prBorRegistro( inuDEBT_NEGOT_CHARGE_ID IN NUMBER) IS        
        
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        rcRegistroBor   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        
        rcRegistroBor := frcObtRegistroRId(inuDEBT_NEGOT_CHARGE_ID,TRUE);
        
        IF rcRegistroBor.RowId IS NOT NULL THEN
        
            DELETE gc_debt_negot_charge
            WHERE
            ROWID = rcRegistroBor.RowId;
 
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
    
END pkg_gc_debt_negot_charge;
/
PROMPT Otorga Permisos de Ejecución a ADM_PERSON.pkg_gc_debt_negot_charge
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_GC_DEBT_NEGOT_CHARGE','ADM_PERSON');
END;
/
