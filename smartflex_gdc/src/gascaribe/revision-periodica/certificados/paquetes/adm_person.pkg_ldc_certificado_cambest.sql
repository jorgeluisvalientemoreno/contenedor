CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_CERTIFICADO_CAMBEST AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_CERTIFICADO_CAMBEST%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_CERTIFICADO_CAMBEST IS SELECT * FROM LDC_CERTIFICADO_CAMBEST;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_CERTIFICADO_CAMBEST
        Caso  : OSF-3828
        Fecha : 08/01/2025 10:39:12
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuID_CAESCERT    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_CERTIFICADO_CAMBEST tb
        WHERE
        ID_CAESCERT = inuID_CAESCERT;
     
    CURSOR cuRegistroRIdLock
    (
        inuID_CAESCERT    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_CERTIFICADO_CAMBEST tb
        WHERE
        ID_CAESCERT = inuID_CAESCERT
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuID_CAESCERT    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuID_CAESCERT    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuID_CAESCERT    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro IN OUT cuLDC_CERTIFICADO_CAMBEST%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuID_CAESCERT    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna CERTIFICADOS_OIA_ID
    FUNCTION fnuObtCERTIFICADOS_OIA_ID(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.CERTIFICADOS_OIA_ID%TYPE;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.USUARIO%TYPE;
 
    -- Obtiene el valor de la columna TERMINAL
    FUNCTION fsbObtTERMINAL(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.TERMINAL%TYPE;
 
    -- Obtiene el valor de la columna FECHA_CAMBIO
    FUNCTION fdtObtFECHA_CAMBIO(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.FECHA_CAMBIO%TYPE;
 
    -- Obtiene el valor de la columna ESTADO_INICIAL
    FUNCTION fsbObtESTADO_INICIAL(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.ESTADO_INICIAL%TYPE;
 
    -- Obtiene el valor de la columna ESTADO_FINAL
    FUNCTION fsbObtESTADO_FINAL(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.ESTADO_FINAL%TYPE;
 
    -- Obtiene el valor de la columna OBSERVACION
    FUNCTION fsbObtOBSERVACION(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.OBSERVACION%TYPE;
 
    -- Actualiza el valor de la columna CERTIFICADOS_OIA_ID
    PROCEDURE prAcCERTIFICADOS_OIA_ID(
        inuID_CAESCERT    NUMBER,
        inuCERTIFICADOS_OIA_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuID_CAESCERT    NUMBER,
        isbUSUARIO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna TERMINAL
    PROCEDURE prAcTERMINAL(
        inuID_CAESCERT    NUMBER,
        isbTERMINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_CAMBIO
    PROCEDURE prAcFECHA_CAMBIO(
        inuID_CAESCERT    NUMBER,
        idtFECHA_CAMBIO    DATE
    );
 
    -- Actualiza el valor de la columna ESTADO_INICIAL
    PROCEDURE prAcESTADO_INICIAL(
        inuID_CAESCERT    NUMBER,
        isbESTADO_INICIAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ESTADO_FINAL
    PROCEDURE prAcESTADO_FINAL(
        inuID_CAESCERT    NUMBER,
        isbESTADO_FINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna OBSERVACION
    PROCEDURE prAcOBSERVACION(
        inuID_CAESCERT    NUMBER,
        isbOBSERVACION    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_CERTIFICADO_CAMBEST%ROWTYPE);
    
    -- Obtiene nuevo identificador a partir de secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER;
 
END pkg_LDC_CERTIFICADO_CAMBEST;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_CERTIFICADO_CAMBEST AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuID_CAESCERT    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuID_CAESCERT);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuID_CAESCERT);
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
        inuID_CAESCERT    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuID_CAESCERT);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ID_CAESCERT IS NOT NULL;
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
        inuID_CAESCERT    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuID_CAESCERT) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuID_CAESCERT||'] en la tabla[LDC_CERTIFICADO_CAMBEST]');
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
    PROCEDURE prInsRegistro( ircRegistro IN OUT cuLDC_CERTIFICADO_CAMBEST%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF ircRegistro.ID_CAESCERT IS NULL THEN
            ircRegistro.ID_CAESCERT := fnuObtNuevoIdentificador;
        END IF;
        
        INSERT INTO LDC_CERTIFICADO_CAMBEST(
            ID_CAESCERT,CERTIFICADOS_OIA_ID,USUARIO,TERMINAL,FECHA_CAMBIO,ESTADO_INICIAL,ESTADO_FINAL,OBSERVACION
        )
        VALUES (
            ircRegistro.ID_CAESCERT,ircRegistro.CERTIFICADOS_OIA_ID,ircRegistro.USUARIO,ircRegistro.TERMINAL,ircRegistro.FECHA_CAMBIO,ircRegistro.ESTADO_INICIAL,ircRegistro.ESTADO_FINAL,ircRegistro.OBSERVACION
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
        inuID_CAESCERT    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_CERTIFICADO_CAMBEST
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
            DELETE LDC_CERTIFICADO_CAMBEST
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
 
    -- Obtiene el valor de la columna CERTIFICADOS_OIA_ID
    FUNCTION fnuObtCERTIFICADOS_OIA_ID(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.CERTIFICADOS_OIA_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCERTIFICADOS_OIA_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CERTIFICADOS_OIA_ID;
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
    END fnuObtCERTIFICADOS_OIA_ID;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.USUARIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
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
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
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
 
    -- Obtiene el valor de la columna FECHA_CAMBIO
    FUNCTION fdtObtFECHA_CAMBIO(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.FECHA_CAMBIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_CAMBIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
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
 
    -- Obtiene el valor de la columna ESTADO_INICIAL
    FUNCTION fsbObtESTADO_INICIAL(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.ESTADO_INICIAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtESTADO_INICIAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ESTADO_INICIAL;
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
    END fsbObtESTADO_INICIAL;
 
    -- Obtiene el valor de la columna ESTADO_FINAL
    FUNCTION fsbObtESTADO_FINAL(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.ESTADO_FINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtESTADO_FINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ESTADO_FINAL;
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
    END fsbObtESTADO_FINAL;
 
    -- Obtiene el valor de la columna OBSERVACION
    FUNCTION fsbObtOBSERVACION(
        inuID_CAESCERT    NUMBER
        ) RETURN LDC_CERTIFICADO_CAMBEST.OBSERVACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOBSERVACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OBSERVACION;
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
    END fsbObtOBSERVACION;
 
    -- Actualiza el valor de la columna CERTIFICADOS_OIA_ID
    PROCEDURE prAcCERTIFICADOS_OIA_ID(
        inuID_CAESCERT    NUMBER,
        inuCERTIFICADOS_OIA_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCERTIFICADOS_OIA_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(inuCERTIFICADOS_OIA_ID,-1) <> NVL(rcRegistroAct.CERTIFICADOS_OIA_ID,-1) THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET CERTIFICADOS_OIA_ID=inuCERTIFICADOS_OIA_ID
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
    END prAcCERTIFICADOS_OIA_ID;
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuID_CAESCERT    NUMBER,
        isbUSUARIO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(isbUSUARIO,'-') <> NVL(rcRegistroAct.USUARIO,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
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
        inuID_CAESCERT    NUMBER,
        isbTERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(isbTERMINAL,'-') <> NVL(rcRegistroAct.TERMINAL,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
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
 
    -- Actualiza el valor de la columna FECHA_CAMBIO
    PROCEDURE prAcFECHA_CAMBIO(
        inuID_CAESCERT    NUMBER,
        idtFECHA_CAMBIO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CAMBIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(idtFECHA_CAMBIO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_CAMBIO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
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
 
    -- Actualiza el valor de la columna ESTADO_INICIAL
    PROCEDURE prAcESTADO_INICIAL(
        inuID_CAESCERT    NUMBER,
        isbESTADO_INICIAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO_INICIAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(isbESTADO_INICIAL,'-') <> NVL(rcRegistroAct.ESTADO_INICIAL,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET ESTADO_INICIAL=isbESTADO_INICIAL
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
    END prAcESTADO_INICIAL;
 
    -- Actualiza el valor de la columna ESTADO_FINAL
    PROCEDURE prAcESTADO_FINAL(
        inuID_CAESCERT    NUMBER,
        isbESTADO_FINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO_FINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(isbESTADO_FINAL,'-') <> NVL(rcRegistroAct.ESTADO_FINAL,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET ESTADO_FINAL=isbESTADO_FINAL
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
    END prAcESTADO_FINAL;
 
    -- Actualiza el valor de la columna OBSERVACION
    PROCEDURE prAcOBSERVACION(
        inuID_CAESCERT    NUMBER,
        isbOBSERVACION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBSERVACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_CAESCERT,TRUE);
        IF NVL(isbOBSERVACION,'-') <> NVL(rcRegistroAct.OBSERVACION,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET OBSERVACION=isbOBSERVACION
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
    END prAcOBSERVACION;
 
    -- Actualiza por RowId el valor de la columna CERTIFICADOS_OIA_ID
    PROCEDURE prAcCERTIFICADOS_OIA_ID_RId(
        iRowId ROWID,
        inuCERTIFICADOS_OIA_ID_O    NUMBER,
        inuCERTIFICADOS_OIA_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCERTIFICADOS_OIA_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCERTIFICADOS_OIA_ID_O,-1) <> NVL(inuCERTIFICADOS_OIA_ID_N,-1) THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET CERTIFICADOS_OIA_ID=inuCERTIFICADOS_OIA_ID_N
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
    END prAcCERTIFICADOS_OIA_ID_RId;
 
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
            UPDATE LDC_CERTIFICADO_CAMBEST
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
            UPDATE LDC_CERTIFICADO_CAMBEST
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
            UPDATE LDC_CERTIFICADO_CAMBEST
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
 
    -- Actualiza por RowId el valor de la columna ESTADO_INICIAL
    PROCEDURE prAcESTADO_INICIAL_RId(
        iRowId ROWID,
        isbESTADO_INICIAL_O    VARCHAR2,
        isbESTADO_INICIAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO_INICIAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbESTADO_INICIAL_O,'-') <> NVL(isbESTADO_INICIAL_N,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET ESTADO_INICIAL=isbESTADO_INICIAL_N
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
    END prAcESTADO_INICIAL_RId;
 
    -- Actualiza por RowId el valor de la columna ESTADO_FINAL
    PROCEDURE prAcESTADO_FINAL_RId(
        iRowId ROWID,
        isbESTADO_FINAL_O    VARCHAR2,
        isbESTADO_FINAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO_FINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbESTADO_FINAL_O,'-') <> NVL(isbESTADO_FINAL_N,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET ESTADO_FINAL=isbESTADO_FINAL_N
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
    END prAcESTADO_FINAL_RId;
 
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
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOBSERVACION_O,'-') <> NVL(isbOBSERVACION_N,'-') THEN
            UPDATE LDC_CERTIFICADO_CAMBEST
            SET OBSERVACION=isbOBSERVACION_N
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
    END prAcOBSERVACION_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_CERTIFICADO_CAMBEST%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ID_CAESCERT,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcCERTIFICADOS_OIA_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CERTIFICADOS_OIA_ID,
                ircRegistro.CERTIFICADOS_OIA_ID
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
 
            prAcFECHA_CAMBIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_CAMBIO,
                ircRegistro.FECHA_CAMBIO
            );
 
            prAcESTADO_INICIAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ESTADO_INICIAL,
                ircRegistro.ESTADO_INICIAL
            );
 
            prAcESTADO_FINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ESTADO_FINAL,
                ircRegistro.ESTADO_FINAL
            );
 
            prAcOBSERVACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OBSERVACION,
                ircRegistro.OBSERVACION
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
    
    -- Obtiene nuevo identificador a partir de secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNuevoIdentificador';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuObtNuevoIdentificador NUMBER;    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        nuObtNuevoIdentificador := SEQ_LDC_CERTIFICADO_CAMBEST.NEXTVAL;         
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuObtNuevoIdentificador;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuObtNuevoIdentificador;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuObtNuevoIdentificador;
    END fnuObtNuevoIdentificador;       
 
END pkg_LDC_CERTIFICADO_CAMBEST;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_CERTIFICADO_CAMBEST'), UPPER('adm_person'));
END;
/

