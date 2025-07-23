CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_ldc_log_pb
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   pkg_ldc_log_pb
    Descripción :   Paquete de primer nivel para la tabla ldc_log_pb
    Autor       :   jcatuche
    Fecha       :   23/12/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    23/12/2024    jcatuche      OSF-3810: Creación del paquete 
***************************************************************************/
    subtype styRegistro   is  ldc_log_pb%rowtype;   
    
    CURSOR cuRegistroRId
    (
        inuLDLPCONS    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_log_pb tb
        WHERE
        LDLPCONS = inuLDLPCONS;
     
    CURSOR cuRegistroRIdLock
    (
        inuLDLPCONS    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_log_pb tb
        WHERE
        LDLPCONS = inuLDLPCONS
        FOR UPDATE NOWAIT; 
    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Inserta registro
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro,onuLdlpcons OUT NUMBER);
    
    --Actualiza registro
    PROCEDURE prActRegistro( ircRegistro IN styRegistro);

END pkg_ldc_log_pb;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_ldc_log_pb
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
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro,onuLdlpcons OUT NUMBER) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistro';
        nuCodigo    NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        nuCodigo := SEQ_LDC_LOG_PB.nextval;
        
        INSERT INTO ldc_log_pb
        (
            LDLPCONS, 
            LDLPPROC, 
            LDLPUSER, 
            LDLPTERM, 
            LDLPFECH, 
            LDLPINFO
        )
        VALUES
        (
            nuCodigo,
            ircRegistro.LDLPPROC,
            NVL(ircRegistro.LDLPUSER,pkg_session.getUser),
            NVL(ircRegistro.LDLPTERM,pkg_session.fnuGetSesion), 
            NVL(ircRegistro.LDLPFECH,SYSDATE),     
            ircRegistro.LDLPINFO
        );
        
        onuLdlpcons := nuCodigo;
        
        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN DUP_VAL_ON_INDEX THEN
            sbError := 'El registro ['||nuCodigo||'] ya existe para la tabla LDC_LOG_PB';
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
        inuLDLPCONS    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuLDLPCONS);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuLDLPCONS);
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
    
    -- Actualiza por RowId el valor de la columna LDLPPROC
    PROCEDURE prLDLPPROC_RId(
        iRowId ROWID,
        isbLDLPPROC_O    VARCHAR2,
        isbLDLPPROC_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prLDLPPROC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbLDLPPROC_O,'-') <> NVL(isbLDLPPROC_N,'-') THEN
            UPDATE ldc_log_pb
            SET LDLPPROC=isbLDLPPROC_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prLDLPPROC_RId;
 
    -- Actualiza por RowId el valor de la columna LDLPUSER
    PROCEDURE prLDLPUSER_RId(
        iRowId ROWID,
        isbLDLPUSER_O    VARCHAR2,
        isbLDLPUSER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prLDLPUSER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbLDLPUSER_O,'-') <> NVL(isbLDLPUSER_N,'-') THEN
            UPDATE ldc_log_pb
            SET LDLPUSER=isbLDLPUSER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prLDLPUSER_RId;
 
    -- Actualiza por RowId el valor de la columna LDLPTERM
    PROCEDURE prAcLDLPTERM_RId(
        iRowId ROWID,
        isbLDLPTERM_O    VARCHAR2,
        isbLDLPTERM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLDLPTERM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbLDLPTERM_O,'-') <> NVL(isbLDLPTERM_N,'-') THEN
            UPDATE ldc_log_pb
            SET LDLPTERM=isbLDLPTERM_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prAcLDLPTERM_RId;
 
    -- Actualiza por RowId el valor de la columna LDLPFECH
    PROCEDURE prAcLDLPFECH_RId(
        iRowId ROWID,
        idtLDLPFECH_O    DATE,
        idtLDLPFECH_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLDLPFECH_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(idtLDLPFECH_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtLDLPFECH_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE ldc_log_pb
            SET LDLPFECH=idtLDLPFECH_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prAcLDLPFECH_RId;
 
    -- Actualiza por RowId el valor de la columna LDLPINFO
    PROCEDURE prAcLDLPINFO_RId(
        iRowId ROWID,
        isbLDLPINFO_O    VARCHAR2,
        isbLDLPINFO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLDLPINFO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbLDLPINFO_O,'-') <> NVL(isbLDLPINFO_N,'-') THEN
            UPDATE ldc_log_pb
            SET LDLPINFO=LDLPINFO||' '||isbLDLPINFO_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prAcLDLPINFO_RId;
 
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActRegistro
    Descripcion     : Actualización de registro
    
    Parametros de Entrada 
    ==================== 
        ircRegistro     Registro a actualizar
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	23/12/2024      jcatuche            OSF-3810: Creación
    ***************************************************************************/
    PROCEDURE prActRegistro( ircRegistro IN styRegistro) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        rcRegistroAct := frcObtRegistroRId(ircRegistro.LDLPCONS,TRUE);
        
        IF rcRegistroAct.RowId IS NOT NULL THEN
        
            prLDLPPROC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LDLPPROC,
                ircRegistro.LDLPPROC
            );
 
            prLDLPUSER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LDLPUSER,
                ircRegistro.LDLPUSER
            );
 
            prAcLDLPTERM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LDLPTERM,
                ircRegistro.LDLPTERM
            );
 
            prAcLDLPFECH_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LDLPFECH,
                ircRegistro.LDLPFECH
            );
 
            prAcLDLPINFO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LDLPINFO,
                ircRegistro.LDLPINFO
            );
 
        END IF;
        
        COMMIT;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
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
    END prActRegistro;
    
END pkg_ldc_log_pb;
/
PROMPT Otorga Permisos de Ejecución a ADM_PERSON.pkg_ldc_log_pb
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LDC_LOG_PB','ADM_PERSON');
END;
/
