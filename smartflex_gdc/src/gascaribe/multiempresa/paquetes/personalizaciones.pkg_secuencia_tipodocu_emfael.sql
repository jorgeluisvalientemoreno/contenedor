CREATE OR REPLACE PACKAGE personalizaciones.pkg_secuencia_tipodocu_emfael AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF SECUENCIA_TIPODOCU_EMFAEL%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuSECUENCIA_TIPODOCU_EMFAEL IS SELECT * FROM SECUENCIA_TIPODOCU_EMFAEL;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : SECUENCIA_TIPODOCU_EMFAEL
        Caso  : OSF-4145
        Fecha : 01/04/2025 15:50:15
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM SECUENCIA_TIPODOCU_EMFAEL tb
        WHERE
        EMPRESA = isbEMPRESA AND
        TIPO_DOCUMENTO = inuTIPO_DOCUMENTO;
     
    CURSOR cuRegistroRIdLock
    (
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM SECUENCIA_TIPODOCU_EMFAEL tb
        WHERE
        EMPRESA = isbEMPRESA AND
        TIPO_DOCUMENTO = inuTIPO_DOCUMENTO
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuSECUENCIA_TIPODOCU_EMFAEL%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna NOMBRE_SECUENCIA
    FUNCTION fsbObtNOMBRE_SECUENCIA(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
        ) RETURN SECUENCIA_TIPODOCU_EMFAEL.NOMBRE_SECUENCIA%TYPE;
 
    -- Actualiza el valor de la columna NOMBRE_SECUENCIA
    PROCEDURE prAcNOMBRE_SECUENCIA(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER,
        isbNOMBRE_SECUENCIA    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuSECUENCIA_TIPODOCU_EMFAEL%ROWTYPE);
 
END pkg_secuencia_tipodocu_emfael;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_secuencia_tipodocu_emfael AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(isbEMPRESA,inuTIPO_DOCUMENTO);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(isbEMPRESA,inuTIPO_DOCUMENTO);
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
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(isbEMPRESA,inuTIPO_DOCUMENTO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.EMPRESA IS NOT NULL;
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
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(isbEMPRESA,inuTIPO_DOCUMENTO) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||isbEMPRESA||','||inuTIPO_DOCUMENTO||'] en la tabla[SECUENCIA_TIPODOCU_EMFAEL]');
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
    PROCEDURE prInsRegistro( ircRegistro cuSECUENCIA_TIPODOCU_EMFAEL%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO SECUENCIA_TIPODOCU_EMFAEL(
            EMPRESA,TIPO_DOCUMENTO,NOMBRE_SECUENCIA
        )
        VALUES (
            ircRegistro.EMPRESA,ircRegistro.TIPO_DOCUMENTO,ircRegistro.NOMBRE_SECUENCIA
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
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbEMPRESA,inuTIPO_DOCUMENTO, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE SECUENCIA_TIPODOCU_EMFAEL
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
            DELETE SECUENCIA_TIPODOCU_EMFAEL
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
 
    -- Obtiene el valor de la columna NOMBRE_SECUENCIA
    FUNCTION fsbObtNOMBRE_SECUENCIA(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER
        ) RETURN SECUENCIA_TIPODOCU_EMFAEL.NOMBRE_SECUENCIA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNOMBRE_SECUENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbEMPRESA,inuTIPO_DOCUMENTO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOMBRE_SECUENCIA;
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
    END fsbObtNOMBRE_SECUENCIA;
 
    -- Actualiza el valor de la columna NOMBRE_SECUENCIA
    PROCEDURE prAcNOMBRE_SECUENCIA(
        isbEMPRESA    VARCHAR2,inuTIPO_DOCUMENTO    NUMBER,
        isbNOMBRE_SECUENCIA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOMBRE_SECUENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbEMPRESA,inuTIPO_DOCUMENTO,TRUE);
        IF NVL(isbNOMBRE_SECUENCIA,'-') <> NVL(rcRegistroAct.NOMBRE_SECUENCIA,'-') THEN
            UPDATE SECUENCIA_TIPODOCU_EMFAEL
            SET NOMBRE_SECUENCIA=isbNOMBRE_SECUENCIA
            WHERE Rowid = rcRegistroAct.RowId;
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
    END prAcNOMBRE_SECUENCIA;
 
    -- Actualiza por RowId el valor de la columna NOMBRE_SECUENCIA
    PROCEDURE prAcNOMBRE_SECUENCIA_RId(
        iRowId ROWID,
        isbNOMBRE_SECUENCIA_O    VARCHAR2,
        isbNOMBRE_SECUENCIA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOMBRE_SECUENCIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNOMBRE_SECUENCIA_O,'-') <> NVL(isbNOMBRE_SECUENCIA_N,'-') THEN
            UPDATE SECUENCIA_TIPODOCU_EMFAEL
            SET NOMBRE_SECUENCIA=isbNOMBRE_SECUENCIA_N
            WHERE Rowid = iRowId;
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
    END prAcNOMBRE_SECUENCIA_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuSECUENCIA_TIPODOCU_EMFAEL%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.EMPRESA,ircRegistro.TIPO_DOCUMENTO,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcNOMBRE_SECUENCIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOMBRE_SECUENCIA,
                ircRegistro.NOMBRE_SECUENCIA
            );
 
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
    END prActRegistro;
 
END pkg_secuencia_tipodocu_emfael;
/
BEGIN
    -- OSF-4145
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_secuencia_tipodocu_emfael'), UPPER('personalizaciones'));
END;
/
