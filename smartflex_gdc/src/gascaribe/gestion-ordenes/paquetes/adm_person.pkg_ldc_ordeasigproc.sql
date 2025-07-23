CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_ORDEASIGPROC AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_ORDEASIGPROC%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_ORDEASIGPROC IS SELECT * FROM LDC_ORDEASIGPROC;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_ORDEASIGPROC
        Caso  : OSF-3828
        Fecha : 08/01/2025 11:54:32
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ORDEASIGPROC tb
        WHERE
        ORAPORPA = inuORAPORPA AND
        ORAPSOGE = inuORAPSOGE;
     
    CURSOR cuRegistroRIdLock
    (
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ORDEASIGPROC tb
        WHERE
        ORAPORPA = inuORAPORPA AND
        ORAPSOGE = inuORAPSOGE
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_ORDEASIGPROC%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ORAOPELE
    FUNCTION fnuObtORAOPELE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOPELE%TYPE;
 
    -- Obtiene el valor de la columna ORAOUNID
    FUNCTION fnuObtORAOUNID(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOUNID%TYPE;
 
    -- Obtiene el valor de la columna ORAOCALE
    FUNCTION fnuObtORAOCALE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOCALE%TYPE;
 
    -- Obtiene el valor de la columna ORAOITEM
    FUNCTION fsbObtORAOITEM(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOITEM%TYPE;
 
    -- Obtiene el valor de la columna ORAOPROC
    FUNCTION fsbObtORAOPROC(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOPROC%TYPE;
 
    -- Actualiza el valor de la columna ORAOPELE
    PROCEDURE prAcORAOPELE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOPELE    NUMBER
    );
 
    -- Actualiza el valor de la columna ORAOUNID
    PROCEDURE prAcORAOUNID(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOUNID    NUMBER
    );
 
    -- Actualiza el valor de la columna ORAOCALE
    PROCEDURE prAcORAOCALE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOCALE    NUMBER
    );
 
    -- Actualiza el valor de la columna ORAOITEM
    PROCEDURE prAcORAOITEM(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        isbORAOITEM    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ORAOPROC
    PROCEDURE prAcORAOPROC(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        isbORAOPROC    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_ORDEASIGPROC%ROWTYPE);
 
END pkg_LDC_ORDEASIGPROC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_ORDEASIGPROC AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORAPORPA,inuORAPSOGE);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORAPORPA,inuORAPSOGE);
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
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ORAPORPA IS NOT NULL;
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
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORAPORPA,inuORAPSOGE) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORAPORPA||','||inuORAPSOGE||'] en la tabla[LDC_ORDEASIGPROC]');
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
    PROCEDURE prInsRegistro( ircRegistro cuLDC_ORDEASIGPROC%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_ORDEASIGPROC(
            ORAPORPA,ORAPSOGE,ORAOPELE,ORAOUNID,ORAOCALE,ORAOITEM,ORAOPROC
        )
        VALUES (
            ircRegistro.ORAPORPA,ircRegistro.ORAPSOGE,ircRegistro.ORAOPELE,ircRegistro.ORAOUNID,ircRegistro.ORAOCALE,ircRegistro.ORAOITEM,ircRegistro.ORAOPROC
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
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_ORDEASIGPROC
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
            DELETE LDC_ORDEASIGPROC
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
 
    -- Obtiene el valor de la columna ORAOPELE
    FUNCTION fnuObtORAOPELE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOPELE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORAOPELE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORAOPELE;
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
    END fnuObtORAOPELE;
 
    -- Obtiene el valor de la columna ORAOUNID
    FUNCTION fnuObtORAOUNID(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOUNID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORAOUNID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORAOUNID;
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
    END fnuObtORAOUNID;
 
    -- Obtiene el valor de la columna ORAOCALE
    FUNCTION fnuObtORAOCALE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOCALE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORAOCALE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORAOCALE;
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
    END fnuObtORAOCALE;
 
    -- Obtiene el valor de la columna ORAOITEM
    FUNCTION fsbObtORAOITEM(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOITEM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtORAOITEM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORAOITEM;
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
    END fsbObtORAOITEM;
 
    -- Obtiene el valor de la columna ORAOPROC
    FUNCTION fsbObtORAOPROC(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER
        ) RETURN LDC_ORDEASIGPROC.ORAOPROC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtORAOPROC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORAOPROC;
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
    END fsbObtORAOPROC;
 
    -- Actualiza el valor de la columna ORAOPELE
    PROCEDURE prAcORAOPELE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOPELE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOPELE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE,TRUE);
        IF NVL(inuORAOPELE,-1) <> NVL(rcRegistroAct.ORAOPELE,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOPELE=inuORAOPELE
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
    END prAcORAOPELE;
 
    -- Actualiza el valor de la columna ORAOUNID
    PROCEDURE prAcORAOUNID(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOUNID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOUNID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE,TRUE);
        IF NVL(inuORAOUNID,-1) <> NVL(rcRegistroAct.ORAOUNID,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOUNID=inuORAOUNID
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
    END prAcORAOUNID;
 
    -- Actualiza el valor de la columna ORAOCALE
    PROCEDURE prAcORAOCALE(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        inuORAOCALE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOCALE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE,TRUE);
        IF NVL(inuORAOCALE,-1) <> NVL(rcRegistroAct.ORAOCALE,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOCALE=inuORAOCALE
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
    END prAcORAOCALE;
 
    -- Actualiza el valor de la columna ORAOITEM
    PROCEDURE prAcORAOITEM(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        isbORAOITEM    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOITEM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE,TRUE);
        IF NVL(isbORAOITEM,'-') <> NVL(rcRegistroAct.ORAOITEM,'-') THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOITEM=isbORAOITEM
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
    END prAcORAOITEM;
 
    -- Actualiza el valor de la columna ORAOPROC
    PROCEDURE prAcORAOPROC(
        inuORAPORPA    NUMBER,inuORAPSOGE    NUMBER,
        isbORAOPROC    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOPROC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORAPORPA,inuORAPSOGE,TRUE);
        IF NVL(isbORAOPROC,'-') <> NVL(rcRegistroAct.ORAOPROC,'-') THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOPROC=isbORAOPROC
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
    END prAcORAOPROC;
 
    -- Actualiza por RowId el valor de la columna ORAOPELE
    PROCEDURE prAcORAOPELE_RId(
        iRowId ROWID,
        inuORAOPELE_O    NUMBER,
        inuORAOPELE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOPELE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORAOPELE_O,-1) <> NVL(inuORAOPELE_N,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOPELE=inuORAOPELE_N
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
    END prAcORAOPELE_RId;
 
    -- Actualiza por RowId el valor de la columna ORAOUNID
    PROCEDURE prAcORAOUNID_RId(
        iRowId ROWID,
        inuORAOUNID_O    NUMBER,
        inuORAOUNID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOUNID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORAOUNID_O,-1) <> NVL(inuORAOUNID_N,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOUNID=inuORAOUNID_N
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
    END prAcORAOUNID_RId;
 
    -- Actualiza por RowId el valor de la columna ORAOCALE
    PROCEDURE prAcORAOCALE_RId(
        iRowId ROWID,
        inuORAOCALE_O    NUMBER,
        inuORAOCALE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOCALE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORAOCALE_O,-1) <> NVL(inuORAOCALE_N,-1) THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOCALE=inuORAOCALE_N
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
    END prAcORAOCALE_RId;
 
    -- Actualiza por RowId el valor de la columna ORAOITEM
    PROCEDURE prAcORAOITEM_RId(
        iRowId ROWID,
        isbORAOITEM_O    VARCHAR2,
        isbORAOITEM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOITEM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbORAOITEM_O,'-') <> NVL(isbORAOITEM_N,'-') THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOITEM=isbORAOITEM_N
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
    END prAcORAOITEM_RId;
 
    -- Actualiza por RowId el valor de la columna ORAOPROC
    PROCEDURE prAcORAOPROC_RId(
        iRowId ROWID,
        isbORAOPROC_O    VARCHAR2,
        isbORAOPROC_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORAOPROC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbORAOPROC_O,'-') <> NVL(isbORAOPROC_N,'-') THEN
            UPDATE LDC_ORDEASIGPROC
            SET ORAOPROC=isbORAOPROC_N
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
    END prAcORAOPROC_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_ORDEASIGPROC%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORAPORPA,ircRegistro.ORAPSOGE,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcORAOPELE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORAOPELE,
                ircRegistro.ORAOPELE
            );
 
            prAcORAOUNID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORAOUNID,
                ircRegistro.ORAOUNID
            );
 
            prAcORAOCALE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORAOCALE,
                ircRegistro.ORAOCALE
            );
 
            prAcORAOITEM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORAOITEM,
                ircRegistro.ORAOITEM
            );
 
            prAcORAOPROC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORAOPROC,
                ircRegistro.ORAOPROC
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
 
END pkg_LDC_ORDEASIGPROC;
/
BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_ORDEASIGPROC'), UPPER('adm_person'));
END;
/
