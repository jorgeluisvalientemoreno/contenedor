CREATE OR REPLACE PACKAGE personalizaciones.pkg_LOG_INFO_ADICIONAL_SOLICIT AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLOG_INFO_ADICIONAL_SOLICITUD IS SELECT * FROM LOG_INFO_ADICIONAL_SOLICITUD;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jorge valiente
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LOG_INFO_ADICIONAL_SOLICITUD
        Caso  : OSF-3742
        Fecha : 12/12/2024 15:38:41
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LOG_INFO_ADICIONAL_SOLICITUD tb
        WHERE
        PACKAGE_ID = inuPACKAGE_ID AND
        DATO_ADICIONAL = isbDATO_ADICIONAL;
     
    CURSOR cuRegistroRIdLock
    (
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LOG_INFO_ADICIONAL_SOLICITUD tb
        WHERE
        PACKAGE_ID = inuPACKAGE_ID AND
        DATO_ADICIONAL = isbDATO_ADICIONAL
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna VALOR_ANTERIOR
    FUNCTION fsbObtVALOR_ANTERIOR(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.VALOR_ANTERIOR%TYPE;
 
    -- Obtiene el valor de la columna VALOR_NUEVO
    FUNCTION fsbObtVALOR_NUEVO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.VALOR_NUEVO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_CAMBIO
    FUNCTION fdtObtFECHA_CAMBIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.FECHA_CAMBIO%TYPE;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.USUARIO%TYPE;
 
    -- Obtiene el valor de la columna TERMINAL
    FUNCTION fsbObtTERMINAL(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.TERMINAL%TYPE;
 
    -- Obtiene el valor de la columna OPERACION
    FUNCTION fsbObtOPERACION(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.OPERACION%TYPE;
 
    -- Actualiza el valor de la columna VALOR_ANTERIOR
    PROCEDURE prAcVALOR_ANTERIOR(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbVALOR_ANTERIOR    VARCHAR2
    );
 
    -- Actualiza el valor de la columna VALOR_NUEVO
    PROCEDURE prAcVALOR_NUEVO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbVALOR_NUEVO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_CAMBIO
    PROCEDURE prAcFECHA_CAMBIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        idtFECHA_CAMBIO    DATE
    );
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbUSUARIO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna TERMINAL
    PROCEDURE prAcTERMINAL(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbTERMINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna OPERACION
    PROCEDURE prAcOPERACION(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbOPERACION    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE);
 
END pkg_LOG_INFO_ADICIONAL_SOLICIT;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_LOG_INFO_ADICIONAL_SOLICIT AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuPACKAGE_ID,isbDATO_ADICIONAL);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
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
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.PACKAGE_ID IS NOT NULL;
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
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuPACKAGE_ID,isbDATO_ADICIONAL) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuPACKAGE_ID||','||isbDATO_ADICIONAL||'] en la tabla[LOG_INFO_ADICIONAL_SOLICITUD]');
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
    PROCEDURE prInsRegistro( ircRegistro cuLOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LOG_INFO_ADICIONAL_SOLICITUD(
            PACKAGE_ID,DATO_ADICIONAL,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_CAMBIO,USUARIO,TERMINAL,OPERACION
        )
        VALUES (
            ircRegistro.PACKAGE_ID,ircRegistro.DATO_ADICIONAL,ircRegistro.VALOR_ANTERIOR,ircRegistro.VALOR_NUEVO,ircRegistro.FECHA_CAMBIO,ircRegistro.USUARIO,ircRegistro.TERMINAL,ircRegistro.OPERACION
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
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LOG_INFO_ADICIONAL_SOLICITUD
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
            DELETE LOG_INFO_ADICIONAL_SOLICITUD
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
 
    -- Obtiene el valor de la columna VALOR_ANTERIOR
    FUNCTION fsbObtVALOR_ANTERIOR(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.VALOR_ANTERIOR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtVALOR_ANTERIOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALOR_ANTERIOR;
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
    END fsbObtVALOR_ANTERIOR;
 
    -- Obtiene el valor de la columna VALOR_NUEVO
    FUNCTION fsbObtVALOR_NUEVO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.VALOR_NUEVO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtVALOR_NUEVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALOR_NUEVO;
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
    END fsbObtVALOR_NUEVO;
 
    -- Obtiene el valor de la columna FECHA_CAMBIO
    FUNCTION fdtObtFECHA_CAMBIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.FECHA_CAMBIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_CAMBIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_CAMBIO;
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
    END fdtObtFECHA_CAMBIO;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.USUARIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.USUARIO;
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
    END fsbObtUSUARIO;
 
    -- Obtiene el valor de la columna TERMINAL
    FUNCTION fsbObtTERMINAL(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TERMINAL;
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
    END fsbObtTERMINAL;
 
    -- Obtiene el valor de la columna OPERACION
    FUNCTION fsbObtOPERACION(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2
        ) RETURN LOG_INFO_ADICIONAL_SOLICITUD.OPERACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOPERACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERACION;
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
    END fsbObtOPERACION;
 
    -- Actualiza el valor de la columna VALOR_ANTERIOR
    PROCEDURE prAcVALOR_ANTERIOR(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbVALOR_ANTERIOR    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_ANTERIOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(isbVALOR_ANTERIOR,'-') <> NVL(rcRegistroAct.VALOR_ANTERIOR,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET VALOR_ANTERIOR=isbVALOR_ANTERIOR
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
    END prAcVALOR_ANTERIOR;
 
    -- Actualiza el valor de la columna VALOR_NUEVO
    PROCEDURE prAcVALOR_NUEVO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbVALOR_NUEVO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_NUEVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(isbVALOR_NUEVO,'-') <> NVL(rcRegistroAct.VALOR_NUEVO,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET VALOR_NUEVO=isbVALOR_NUEVO
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
    END prAcVALOR_NUEVO;
 
    -- Actualiza el valor de la columna FECHA_CAMBIO
    PROCEDURE prAcFECHA_CAMBIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        idtFECHA_CAMBIO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CAMBIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(idtFECHA_CAMBIO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_CAMBIO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET FECHA_CAMBIO=idtFECHA_CAMBIO
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
    END prAcFECHA_CAMBIO;
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbUSUARIO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(isbUSUARIO,'-') <> NVL(rcRegistroAct.USUARIO,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET USUARIO=isbUSUARIO
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
    END prAcUSUARIO;
 
    -- Actualiza el valor de la columna TERMINAL
    PROCEDURE prAcTERMINAL(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbTERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(isbTERMINAL,'-') <> NVL(rcRegistroAct.TERMINAL,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET TERMINAL=isbTERMINAL
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
    END prAcTERMINAL;
 
    -- Actualiza el valor de la columna OPERACION
    PROCEDURE prAcOPERACION(
        inuPACKAGE_ID    NUMBER,isbDATO_ADICIONAL    VARCHAR2,
        isbOPERACION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,isbDATO_ADICIONAL,TRUE);
        IF NVL(isbOPERACION,'-') <> NVL(rcRegistroAct.OPERACION,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET OPERACION=isbOPERACION
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
    END prAcOPERACION;
 
    -- Actualiza por RowId el valor de la columna VALOR_ANTERIOR
    PROCEDURE prAcVALOR_ANTERIOR_RId(
        iRowId ROWID,
        isbVALOR_ANTERIOR_O    VARCHAR2,
        isbVALOR_ANTERIOR_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_ANTERIOR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALOR_ANTERIOR_O,'-') <> NVL(isbVALOR_ANTERIOR_N,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET VALOR_ANTERIOR=isbVALOR_ANTERIOR_N
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
    END prAcVALOR_ANTERIOR_RId;
 
    -- Actualiza por RowId el valor de la columna VALOR_NUEVO
    PROCEDURE prAcVALOR_NUEVO_RId(
        iRowId ROWID,
        isbVALOR_NUEVO_O    VARCHAR2,
        isbVALOR_NUEVO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_NUEVO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALOR_NUEVO_O,'-') <> NVL(isbVALOR_NUEVO_N,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET VALOR_NUEVO=isbVALOR_NUEVO_N
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
    END prAcVALOR_NUEVO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_CAMBIO
    PROCEDURE prAcFECHA_CAMBIO_RId(
        iRowId ROWID,
        idtFECHA_CAMBIO_O    DATE,
        idtFECHA_CAMBIO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CAMBIO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_CAMBIO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_CAMBIO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET FECHA_CAMBIO=idtFECHA_CAMBIO_N
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
    END prAcFECHA_CAMBIO_RId;
 
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
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUSUARIO_O,'-') <> NVL(isbUSUARIO_N,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET USUARIO=isbUSUARIO_N
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
    END prAcUSUARIO_RId;
 
    -- Actualiza por RowId el valor de la columna TERMINAL
    PROCEDURE prAcTERMINAL_RId(
        iRowId ROWID,
        isbTERMINAL_O    VARCHAR2,
        isbTERMINAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTERMINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTERMINAL_O,'-') <> NVL(isbTERMINAL_N,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET TERMINAL=isbTERMINAL_N
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
    END prAcTERMINAL_RId;
 
    -- Actualiza por RowId el valor de la columna OPERACION
    PROCEDURE prAcOPERACION_RId(
        iRowId ROWID,
        isbOPERACION_O    VARCHAR2,
        isbOPERACION_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOPERACION_O,'-') <> NVL(isbOPERACION_N,'-') THEN
            UPDATE LOG_INFO_ADICIONAL_SOLICITUD
            SET OPERACION=isbOPERACION_N
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
    END prAcOPERACION_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLOG_INFO_ADICIONAL_SOLICITUD%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.PACKAGE_ID,ircRegistro.DATO_ADICIONAL,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcVALOR_ANTERIOR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALOR_ANTERIOR,
                ircRegistro.VALOR_ANTERIOR
            );
 
            prAcVALOR_NUEVO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALOR_NUEVO,
                ircRegistro.VALOR_NUEVO
            );
 
            prAcFECHA_CAMBIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_CAMBIO,
                ircRegistro.FECHA_CAMBIO
            );
 
            prAcUSUARIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USUARIO,
                ircRegistro.USUARIO
            );
 
            prAcTERMINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TERMINAL,
                ircRegistro.TERMINAL
            );
 
            prAcOPERACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERACION,
                ircRegistro.OPERACION
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
 
END pkg_LOG_INFO_ADICIONAL_SOLICIT;
/
BEGIN
    -- OSF-3742
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LOG_INFO_ADICIONAL_SOLICIT'), UPPER('personalizaciones'));
END;
/
