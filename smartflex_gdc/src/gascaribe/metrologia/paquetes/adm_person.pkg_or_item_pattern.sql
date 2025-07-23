 CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_OR_ITEM_PATTERN AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_ITEM_PATTERN%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOR_ITEM_PATTERN IS SELECT * FROM OR_ITEM_PATTERN;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_ITEM_PATTERN
        Caso  : OSF-3693
        Fecha : 17/12/2024 16:24:19
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuID_ITEMS_SERIADO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ITEM_PATTERN tb
        WHERE
        ID_ITEMS_SERIADO = inuID_ITEMS_SERIADO;
     
    CURSOR cuRegistroRIdLock
    (
        inuID_ITEMS_SERIADO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ITEM_PATTERN tb
        WHERE
        ID_ITEMS_SERIADO = inuID_ITEMS_SERIADO
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuID_ITEMS_SERIADO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuID_ITEMS_SERIADO    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuID_ITEMS_SERIADO    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_ITEM_PATTERN%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuID_ITEMS_SERIADO    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna TRACKING
    FUNCTION fsbObtTRACKING(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.TRACKING%TYPE;
 
    -- Obtiene el valor de la columna VALID_UNTIL
    FUNCTION fdtObtVALID_UNTIL(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.VALID_UNTIL%TYPE;
 
    -- Obtiene el valor de la columna OPERATING_UNIT_ID
    FUNCTION fnuObtOPERATING_UNIT_ID(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.OPERATING_UNIT_ID%TYPE;
		
		
	FUNCTION fnuObtID_ITEMS_SERIADO(
	inuID_ITEMS_SERIADO    NUMBER
	) RETURN OR_ITEM_PATTERN.OPERATING_UNIT_ID%TYPE;
 
    -- Actualiza el valor de la columna TRACKING
    PROCEDURE prAcTRACKING(
        inuID_ITEMS_SERIADO    NUMBER,
        isbTRACKING    VARCHAR2
    );
 
    -- Actualiza el valor de la columna VALID_UNTIL
    PROCEDURE prAcVALID_UNTIL(
        inuID_ITEMS_SERIADO    NUMBER,
        idtVALID_UNTIL    DATE
    );
 
    -- Actualiza el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuID_ITEMS_SERIADO    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ITEM_PATTERN%ROWTYPE);
 
END PKG_OR_ITEM_PATTERN;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_OR_ITEM_PATTERN AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuID_ITEMS_SERIADO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuID_ITEMS_SERIADO);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuID_ITEMS_SERIADO);
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
        inuID_ITEMS_SERIADO    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuID_ITEMS_SERIADO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ID_ITEMS_SERIADO IS NOT NULL;
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
        inuID_ITEMS_SERIADO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuID_ITEMS_SERIADO) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuID_ITEMS_SERIADO||'] en la tabla[OR_ITEM_PATTERN]');
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
    PROCEDURE prInsRegistro( ircRegistro cuOR_ITEM_PATTERN%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_ITEM_PATTERN(
            ID_ITEMS_SERIADO,TRACKING,VALID_UNTIL,OPERATING_UNIT_ID
        )
        VALUES (
            ircRegistro.ID_ITEMS_SERIADO,ircRegistro.TRACKING,ircRegistro.VALID_UNTIL,ircRegistro.OPERATING_UNIT_ID
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
        inuID_ITEMS_SERIADO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_ITEM_PATTERN
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
            DELETE OR_ITEM_PATTERN
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
 
    -- Obtiene el valor de la columna TRACKING
    FUNCTION fsbObtTRACKING(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.TRACKING%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTRACKING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TRACKING;
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
    END fsbObtTRACKING;
 
    -- Obtiene el valor de la columna VALID_UNTIL
    FUNCTION fdtObtVALID_UNTIL(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.VALID_UNTIL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtVALID_UNTIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALID_UNTIL;
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
    END fdtObtVALID_UNTIL;
 
    -- Obtiene el valor de la columna OPERATING_UNIT_ID
    FUNCTION fnuObtOPERATING_UNIT_ID(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.OPERATING_UNIT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATING_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERATING_UNIT_ID;
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
    END fnuObtOPERATING_UNIT_ID;

    -- Obtiene el valor de la columna OPERATING_UNIT_ID
    FUNCTION fnuObtID_ITEMS_SERIADO(
        inuID_ITEMS_SERIADO    NUMBER
        ) RETURN OR_ITEM_PATTERN.OPERATING_UNIT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_ITEMS_SERIADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_ITEMS_SERIADO;
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
    END fnuObtID_ITEMS_SERIADO;

 
    -- Actualiza el valor de la columna TRACKING
    PROCEDURE prAcTRACKING(
        inuID_ITEMS_SERIADO    NUMBER,
        isbTRACKING    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTRACKING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO,TRUE);
        IF NVL(isbTRACKING,'-') <> NVL(rcRegistroAct.TRACKING,'-') THEN
            UPDATE OR_ITEM_PATTERN
            SET TRACKING=isbTRACKING
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
    END prAcTRACKING;
 
    -- Actualiza el valor de la columna VALID_UNTIL
    PROCEDURE prAcVALID_UNTIL(
        inuID_ITEMS_SERIADO    NUMBER,
        idtVALID_UNTIL    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALID_UNTIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO,TRUE);
        IF NVL(idtVALID_UNTIL,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.VALID_UNTIL,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ITEM_PATTERN
            SET VALID_UNTIL=idtVALID_UNTIL
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
    END prAcVALID_UNTIL;
 
    -- Actualiza el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuID_ITEMS_SERIADO    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ITEMS_SERIADO,TRUE);
        IF NVL(inuOPERATING_UNIT_ID,-1) <> NVL(rcRegistroAct.OPERATING_UNIT_ID,-1) THEN
            UPDATE OR_ITEM_PATTERN
            SET OPERATING_UNIT_ID=inuOPERATING_UNIT_ID
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
    END prAcOPERATING_UNIT_ID;
 
    -- Actualiza por RowId el valor de la columna TRACKING
    PROCEDURE prAcTRACKING_RId(
        iRowId ROWID,
        isbTRACKING_O    VARCHAR2,
        isbTRACKING_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTRACKING_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTRACKING_O,'-') <> NVL(isbTRACKING_N,'-') THEN
            UPDATE OR_ITEM_PATTERN
            SET TRACKING=isbTRACKING_N
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
    END prAcTRACKING_RId;
 
    -- Actualiza por RowId el valor de la columna VALID_UNTIL
    PROCEDURE prAcVALID_UNTIL_RId(
        iRowId ROWID,
        idtVALID_UNTIL_O    DATE,
        idtVALID_UNTIL_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALID_UNTIL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtVALID_UNTIL_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtVALID_UNTIL_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ITEM_PATTERN
            SET VALID_UNTIL=idtVALID_UNTIL_N
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
    END prAcVALID_UNTIL_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID_RId(
        iRowId ROWID,
        inuOPERATING_UNIT_ID_O    NUMBER,
        inuOPERATING_UNIT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_UNIT_ID_O,-1) <> NVL(inuOPERATING_UNIT_ID_N,-1) THEN
            UPDATE OR_ITEM_PATTERN
            SET OPERATING_UNIT_ID=inuOPERATING_UNIT_ID_N
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
    END prAcOPERATING_UNIT_ID_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ITEM_PATTERN%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ID_ITEMS_SERIADO,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcTRACKING_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TRACKING,
                ircRegistro.TRACKING
            );
 
            prAcVALID_UNTIL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALID_UNTIL,
                ircRegistro.VALID_UNTIL
            );
 
            prAcOPERATING_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_UNIT_ID,
                ircRegistro.OPERATING_UNIT_ID
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
 
END PKG_OR_ITEM_PATTERN;
/
BEGIN

    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_OR_ITEM_PATTERN'), UPPER('ADM_PERSON'));
END;
/
