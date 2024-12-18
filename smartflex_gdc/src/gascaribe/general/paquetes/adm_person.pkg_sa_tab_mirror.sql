CREATE OR REPLACE PACKAGE adm_person.pkg_sa_tab_mirror AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF sa_tab_mirror%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cusa_tab_mirror IS SELECT * FROM sa_tab_mirror;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : sa_tab_mirror
        Caso  : OSF-3164
        Fecha : 28/10/2024 16:01:51
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM sa_tab_mirror tb
        WHERE
        TAB_NAME = isbTAB_NAME AND
        PROCESS_NAME = isbPROCESS_NAME AND
        APLICA_EXECUTABLE = isbAPLICA_EXECUTABLE;
     
    CURSOR cuRegistroRIdLock
    (
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM sa_tab_mirror tb
        WHERE
        TAB_NAME = isbTAB_NAME AND
        PROCESS_NAME = isbPROCESS_NAME AND
        APLICA_EXECUTABLE = isbAPLICA_EXECUTABLE
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cusa_tab_mirror%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna TAB_ID
    FUNCTION fnuObtTAB_ID(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.TAB_ID%TYPE;
 
    -- Obtiene el valor de la columna PARENT_TAB
    FUNCTION fsbObtPARENT_TAB(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.PARENT_TAB%TYPE;
 
    -- Obtiene el valor de la columna TYPE
    FUNCTION fsbObtTYPE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.TYPE%TYPE;
 
    -- Obtiene el valor de la columna SEQUENCE
    FUNCTION fnuObtSEQUENCE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.SEQUENCE%TYPE;
 
    -- Obtiene el valor de la columna ADDITIONAL_ATTRIBUTES
    FUNCTION fsbObtADDITIONAL_ATTRIBUTES(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.ADDITIONAL_ATTRIBUTES%TYPE;
 
    -- Obtiene el valor de la columna CONDITION
    FUNCTION fsbObtCONDITION(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.CONDITION%TYPE;
 
    -- Actualiza el valor de la columna TAB_ID
    PROCEDURE prAcTAB_ID(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        inuTAB_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PARENT_TAB
    PROCEDURE prAcPARENT_TAB(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbPARENT_TAB    VARCHAR2
    );
 
    -- Actualiza el valor de la columna TYPE
    PROCEDURE prAcTYPE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbTYPE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        inuSEQUENCE    NUMBER
    );
 
    -- Actualiza el valor de la columna ADDITIONAL_ATTRIBUTES
    PROCEDURE prAcADDITIONAL_ATTRIBUTES(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbADDITIONAL_ATTRIBUTES    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CONDITION
    PROCEDURE prAcCONDITION(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbCONDITION    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cusa_tab_mirror%ROWTYPE);
 
END pkg_sa_tab_mirror;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_sa_tab_mirror AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
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
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.TAB_NAME IS NOT NULL;
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
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||isbTAB_NAME||','||isbPROCESS_NAME||','||isbAPLICA_EXECUTABLE||'] en la tabla[sa_tab_mirror]');
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
    PROCEDURE prInsRegistro( ircRegistro cusa_tab_mirror%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO sa_tab_mirror(
            TAB_ID,TAB_NAME,PROCESS_NAME,APLICA_EXECUTABLE,PARENT_TAB,TYPE,SEQUENCE,ADDITIONAL_ATTRIBUTES,CONDITION
        )
        VALUES (
            ircRegistro.TAB_ID,ircRegistro.TAB_NAME,ircRegistro.PROCESS_NAME,ircRegistro.APLICA_EXECUTABLE,ircRegistro.PARENT_TAB,ircRegistro.TYPE,ircRegistro.SEQUENCE,ircRegistro.ADDITIONAL_ATTRIBUTES,ircRegistro.CONDITION
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
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE sa_tab_mirror
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
            DELETE sa_tab_mirror
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
 
    -- Obtiene el valor de la columna TAB_ID
    FUNCTION fnuObtTAB_ID(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.TAB_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTAB_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TAB_ID;
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
    END fnuObtTAB_ID;
 
    -- Obtiene el valor de la columna PARENT_TAB
    FUNCTION fsbObtPARENT_TAB(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.PARENT_TAB%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPARENT_TAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PARENT_TAB;
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
    END fsbObtPARENT_TAB;
 
    -- Obtiene el valor de la columna TYPE
    FUNCTION fsbObtTYPE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.TYPE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TYPE;
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
    END fsbObtTYPE;
 
    -- Obtiene el valor de la columna SEQUENCE
    FUNCTION fnuObtSEQUENCE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.SEQUENCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SEQUENCE;
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
    END fnuObtSEQUENCE;
 
    -- Obtiene el valor de la columna ADDITIONAL_ATTRIBUTES
    FUNCTION fsbObtADDITIONAL_ATTRIBUTES(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.ADDITIONAL_ATTRIBUTES%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtADDITIONAL_ATTRIBUTES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADDITIONAL_ATTRIBUTES;
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
    END fsbObtADDITIONAL_ATTRIBUTES;
 
    -- Obtiene el valor de la columna CONDITION
    FUNCTION fsbObtCONDITION(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2
        ) RETURN sa_tab_mirror.CONDITION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCONDITION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONDITION;
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
    END fsbObtCONDITION;
 
    -- Actualiza el valor de la columna TAB_ID
    PROCEDURE prAcTAB_ID(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        inuTAB_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAB_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(inuTAB_ID,-1) <> NVL(rcRegistroAct.TAB_ID,-1) THEN
            UPDATE sa_tab_mirror
            SET TAB_ID=inuTAB_ID
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
    END prAcTAB_ID;
 
    -- Actualiza el valor de la columna PARENT_TAB
    PROCEDURE prAcPARENT_TAB(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbPARENT_TAB    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPARENT_TAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(isbPARENT_TAB,'-') <> NVL(rcRegistroAct.PARENT_TAB,'-') THEN
            UPDATE sa_tab_mirror
            SET PARENT_TAB=isbPARENT_TAB
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
    END prAcPARENT_TAB;
 
    -- Actualiza el valor de la columna TYPE
    PROCEDURE prAcTYPE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbTYPE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(isbTYPE,'-') <> NVL(rcRegistroAct.TYPE,'-') THEN
            UPDATE sa_tab_mirror
            SET TYPE=isbTYPE
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
    END prAcTYPE;
 
    -- Actualiza el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        inuSEQUENCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(inuSEQUENCE,-1) <> NVL(rcRegistroAct.SEQUENCE,-1) THEN
            UPDATE sa_tab_mirror
            SET SEQUENCE=inuSEQUENCE
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
    END prAcSEQUENCE;
 
    -- Actualiza el valor de la columna ADDITIONAL_ATTRIBUTES
    PROCEDURE prAcADDITIONAL_ATTRIBUTES(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbADDITIONAL_ATTRIBUTES    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADDITIONAL_ATTRIBUTES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(isbADDITIONAL_ATTRIBUTES,'-') <> NVL(rcRegistroAct.ADDITIONAL_ATTRIBUTES,'-') THEN
            UPDATE sa_tab_mirror
            SET ADDITIONAL_ATTRIBUTES=isbADDITIONAL_ATTRIBUTES
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
    END prAcADDITIONAL_ATTRIBUTES;
 
    -- Actualiza el valor de la columna CONDITION
    PROCEDURE prAcCONDITION(
        isbTAB_NAME    VARCHAR2,isbPROCESS_NAME    VARCHAR2,isbAPLICA_EXECUTABLE    VARCHAR2,
        isbCONDITION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONDITION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(isbTAB_NAME,isbPROCESS_NAME,isbAPLICA_EXECUTABLE,TRUE);
        IF NVL(isbCONDITION,'-') <> NVL(rcRegistroAct.CONDITION,'-') THEN
            UPDATE sa_tab_mirror
            SET CONDITION=isbCONDITION
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
    END prAcCONDITION;
 
    -- Actualiza por RowId el valor de la columna TAB_ID
    PROCEDURE prAcTAB_ID_RId(
        iRowId ROWID,
        inuTAB_ID_O    NUMBER,
        inuTAB_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAB_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTAB_ID_O,-1) <> NVL(inuTAB_ID_N,-1) THEN
            UPDATE sa_tab_mirror
            SET TAB_ID=inuTAB_ID_N
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
    END prAcTAB_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PARENT_TAB
    PROCEDURE prAcPARENT_TAB_RId(
        iRowId ROWID,
        isbPARENT_TAB_O    VARCHAR2,
        isbPARENT_TAB_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPARENT_TAB_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPARENT_TAB_O,'-') <> NVL(isbPARENT_TAB_N,'-') THEN
            UPDATE sa_tab_mirror
            SET PARENT_TAB=isbPARENT_TAB_N
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
    END prAcPARENT_TAB_RId;
 
    -- Actualiza por RowId el valor de la columna TYPE
    PROCEDURE prAcTYPE_RId(
        iRowId ROWID,
        isbTYPE_O    VARCHAR2,
        isbTYPE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTYPE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTYPE_O,'-') <> NVL(isbTYPE_N,'-') THEN
            UPDATE sa_tab_mirror
            SET TYPE=isbTYPE_N
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
    END prAcTYPE_RId;
 
    -- Actualiza por RowId el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE_RId(
        iRowId ROWID,
        inuSEQUENCE_O    NUMBER,
        inuSEQUENCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEQUENCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSEQUENCE_O,-1) <> NVL(inuSEQUENCE_N,-1) THEN
            UPDATE sa_tab_mirror
            SET SEQUENCE=inuSEQUENCE_N
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
    END prAcSEQUENCE_RId;
 
    -- Actualiza por RowId el valor de la columna ADDITIONAL_ATTRIBUTES
    PROCEDURE prAcADDITIONAL_ATTRIBUTES_RId(
        iRowId ROWID,
        isbADDITIONAL_ATTRIBUTES_O    VARCHAR2,
        isbADDITIONAL_ATTRIBUTES_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADDITIONAL_ATTRIBUTES_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbADDITIONAL_ATTRIBUTES_O,'-') <> NVL(isbADDITIONAL_ATTRIBUTES_N,'-') THEN
            UPDATE sa_tab_mirror
            SET ADDITIONAL_ATTRIBUTES=isbADDITIONAL_ATTRIBUTES_N
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
    END prAcADDITIONAL_ATTRIBUTES_RId;
 
    -- Actualiza por RowId el valor de la columna CONDITION
    PROCEDURE prAcCONDITION_RId(
        iRowId ROWID,
        isbCONDITION_O    VARCHAR2,
        isbCONDITION_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONDITION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCONDITION_O,'-') <> NVL(isbCONDITION_N,'-') THEN
            UPDATE sa_tab_mirror
            SET CONDITION=isbCONDITION_N
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
    END prAcCONDITION_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cusa_tab_mirror%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.TAB_NAME,ircRegistro.PROCESS_NAME,ircRegistro.APLICA_EXECUTABLE,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcTAB_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TAB_ID,
                ircRegistro.TAB_ID
            );
 
            prAcPARENT_TAB_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PARENT_TAB,
                ircRegistro.PARENT_TAB
            );
 
            prAcTYPE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TYPE,
                ircRegistro.TYPE
            );
 
            prAcSEQUENCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SEQUENCE,
                ircRegistro.SEQUENCE
            );
 
            prAcADDITIONAL_ATTRIBUTES_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADDITIONAL_ATTRIBUTES,
                ircRegistro.ADDITIONAL_ATTRIBUTES
            );
 
            prAcCONDITION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONDITION,
                ircRegistro.CONDITION
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
 
END pkg_sa_tab_mirror;
/
BEGIN
    -- OSF-3164
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_sa_tab_mirror'), UPPER('adm_person'));
END;
/
