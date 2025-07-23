CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_AUDITORIA_MANOT
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   AUDITORIA_MANOT
    Descripción :   Paquete de primer nivel para la tabla AUDITORIA_MANOT
    Autor       :   jcatuche
    Fecha       :   29/11/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    29/11/2024    jcatuche      OSF-3332: Creación del paquete 
***************************************************************************/
    subtype styRegistro   is  AUDITORIA_MANOT%rowtype;   
    
    CURSOR cuRegistroRId
    (
        inuCODIGO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM AUDITORIA_MANOT tb
        WHERE
        CODIGO = inuCODIGO;
     
    CURSOR cuRegistroRIdLock
    (
        inuCODIGO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM AUDITORIA_MANOT tb
        WHERE
        CODIGO = inuCODIGO
        FOR UPDATE NOWAIT; 
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Inserta registro
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro);
    
    --Actualiza registro
    PROCEDURE prActRegistro( ircRegistro IN styRegistro);

END PKG_AUDITORIA_MANOT;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_AUDITORIA_MANOT
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
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	29/11/2024      jcatuche            OSF-3332: Creación
    ***************************************************************************/
    PROCEDURE prInsRegistro(ircRegistro IN styRegistro) IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInsRegistro';
        nuCodigo    NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        nuCodigo := SEQ_AUDITORIA_MANOT.nextval;
        
        INSERT INTO AUDITORIA_MANOT
        (
            CODIGO,
            NOVEDAD,
            USUARIO,
            FECHA,
            SOLICITUD,
            OBSERVACION,
            ERROR          
        )
        VALUES
        (
            nuCodigo,
            ircRegistro.NOVEDAD,          
            ircRegistro.USUARIO,
            ircRegistro.FECHA,
            ircRegistro.SOLICITUD,  
            ircRegistro.OBSERVACION,     
            ircRegistro.ERROR
        );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsRegistro;
    
    FUNCTION frcObtRegistroRId(
        inuCODIGO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCODIGO);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCODIGO);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN rcRegistroRId;
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
    END frcObtRegistroRId;
    
    -- Actualiza por RowId el valor de la columna NOVEDAD
    PROCEDURE prAcNOVEDAD_RId(
        iRowId ROWID,
        isbNOVEDAD_O    VARCHAR2,
        isbNOVEDAD_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOVEDAD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbNOVEDAD_O,'-') <> NVL(isbNOVEDAD_N,'-') THEN
            UPDATE AUDITORIA_MANOT
            SET NOVEDAD=isbNOVEDAD_N
            WHERE Rowid = iRowId;
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
    END prAcNOVEDAD_RId;
 
    -- Actualiza por RowId el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO_RId(
        iRowId ROWID,
        isbUSUARIO_O    VARCHAR2,
        isbUSUARIO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSUARIO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbUSUARIO_O,'-') <> NVL(isbUSUARIO_N,'-') THEN
            UPDATE AUDITORIA_MANOT
            SET USUARIO=isbUSUARIO_N
            WHERE Rowid = iRowId;
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
    END prAcUSUARIO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA
    PROCEDURE prAcFECHA_RId(
        iRowId ROWID,
        idtFECHA_O    DATE,
        idtFECHA_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(idtFECHA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE AUDITORIA_MANOT
            SET FECHA=idtFECHA_N
            WHERE Rowid = iRowId;
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
    END prAcFECHA_RId;
 
    -- Actualiza por RowId el valor de la columna SOLICITUD
    PROCEDURE prAcSOLICITUD_RId(
        iRowId ROWID,
        inuSOLICITUD_O    NUMBER,
        inuSOLICITUD_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSOLICITUD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(inuSOLICITUD_O,-1) <> NVL(inuSOLICITUD_N,-1) THEN
            UPDATE AUDITORIA_MANOT
            SET SOLICITUD=inuSOLICITUD_N
            WHERE Rowid = iRowId;
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
    END prAcSOLICITUD_RId;
 
    -- Actualiza por RowId el valor de la columna OBSERVACION
    PROCEDURE prAcOBSERVACION_RId(
        iRowId ROWID,
        isbOBSERVACION_O    VARCHAR2,
        isbOBSERVACION_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBSERVACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbOBSERVACION_O,'-') <> NVL(isbOBSERVACION_N,'-') THEN
            UPDATE AUDITORIA_MANOT
            SET OBSERVACION=isbOBSERVACION_N
            WHERE Rowid = iRowId;
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
    END prAcOBSERVACION_RId;
 
    -- Actualiza por RowId el valor de la columna ERROR
    PROCEDURE prAcERROR_RId(
        iRowId ROWID,
        isbERROR_O    VARCHAR2,
        isbERROR_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcERROR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        IF NVL(isbERROR_O,'-') <> NVL(isbERROR_N,'-') THEN
            UPDATE AUDITORIA_MANOT
            SET ERROR=isbERROR_N
            WHERE Rowid = iRowId;
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
    END prAcERROR_RId;
    
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro IN styRegistro) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.CODIGO,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcNOVEDAD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOVEDAD,
                ircRegistro.NOVEDAD
            );
 
            prAcUSUARIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USUARIO,
                ircRegistro.USUARIO
            );
 
            prAcFECHA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA,
                ircRegistro.FECHA
            );
 
            prAcSOLICITUD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SOLICITUD,
                ircRegistro.SOLICITUD
            );
 
            prAcOBSERVACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OBSERVACION,
                ircRegistro.OBSERVACION
            );
 
            prAcERROR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ERROR,
                ircRegistro.ERROR
            );
 
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
    END prActRegistro;
    
END PKG_AUDITORIA_MANOT;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PKG_AUDITORIA_MANOT
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_AUDITORIA_MANOT','PERSONALIZACIONES');
END;
/
