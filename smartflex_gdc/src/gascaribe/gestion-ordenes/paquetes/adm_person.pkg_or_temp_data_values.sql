CREATE OR REPLACE PACKAGE adm_person.pkg_OR_TEMP_DATA_VALUES AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_TEMP_DATA_VALUES%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOR_TEMP_DATA_VALUES IS SELECT * FROM OR_TEMP_DATA_VALUES;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_TEMP_DATA_VALUES
        Caso  : OSF-3828
        Fecha : 09/01/2025 11:32:33
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_TEMP_DATA_VALUES tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        ATTRIBUTE_ID = inuATTRIBUTE_ID AND
        ATTRIBUTE_NAME = isbATTRIBUTE_NAME;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_TEMP_DATA_VALUES tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        ATTRIBUTE_ID = inuATTRIBUTE_ID AND
        ATTRIBUTE_NAME = isbATTRIBUTE_NAME
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_TEMP_DATA_VALUES%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ATTRIBUTE_SET_ID
    FUNCTION fnuObtATTRIBUTE_SET_ID(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.ATTRIBUTE_SET_ID%TYPE;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.CONSECUTIVE%TYPE;
 
    -- Obtiene el valor de la columna CAPTURE_ORDER
    FUNCTION fnuObtCAPTURE_ORDER(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.CAPTURE_ORDER%TYPE;
 
    -- Obtiene el valor de la columna DATA_VALUE
    FUNCTION fsbObtDATA_VALUE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.DATA_VALUE%TYPE;
 
    -- Obtiene el valor de la columna IS_PERSISTENT
    FUNCTION fsbObtIS_PERSISTENT(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.IS_PERSISTENT%TYPE;
 
    -- Actualiza el valor de la columna ATTRIBUTE_SET_ID
    PROCEDURE prAcATTRIBUTE_SET_ID(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuATTRIBUTE_SET_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuCONSECUTIVE    NUMBER
    );
 
    -- Actualiza el valor de la columna CAPTURE_ORDER
    PROCEDURE prAcCAPTURE_ORDER(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuCAPTURE_ORDER    NUMBER
    );
 
    -- Actualiza el valor de la columna DATA_VALUE
    PROCEDURE prAcDATA_VALUE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        isbDATA_VALUE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna IS_PERSISTENT
    PROCEDURE prAcIS_PERSISTENT(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        isbIS_PERSISTENT    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_TEMP_DATA_VALUES%ROWTYPE);
 
END pkg_OR_TEMP_DATA_VALUES;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_OR_TEMP_DATA_VALUES AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
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
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ORDER_ID IS NOT NULL;
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
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||','||inuATTRIBUTE_ID||','||isbATTRIBUTE_NAME||'] en la tabla[OR_TEMP_DATA_VALUES]');
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
    PROCEDURE prInsRegistro( ircRegistro cuOR_TEMP_DATA_VALUES%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_TEMP_DATA_VALUES(
            ORDER_ID,ATTRIBUTE_SET_ID,ATTRIBUTE_ID,ATTRIBUTE_NAME,CONSECUTIVE,CAPTURE_ORDER,DATA_VALUE,IS_PERSISTENT
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.ATTRIBUTE_SET_ID,ircRegistro.ATTRIBUTE_ID,ircRegistro.ATTRIBUTE_NAME,ircRegistro.CONSECUTIVE,ircRegistro.CAPTURE_ORDER,ircRegistro.DATA_VALUE,ircRegistro.IS_PERSISTENT
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
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_TEMP_DATA_VALUES
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
            DELETE OR_TEMP_DATA_VALUES
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
 
    -- Obtiene el valor de la columna ATTRIBUTE_SET_ID
    FUNCTION fnuObtATTRIBUTE_SET_ID(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.ATTRIBUTE_SET_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtATTRIBUTE_SET_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ATTRIBUTE_SET_ID;
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
    END fnuObtATTRIBUTE_SET_ID;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.CONSECUTIVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONSECUTIVE;
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
    END fnuObtCONSECUTIVE;
 
    -- Obtiene el valor de la columna CAPTURE_ORDER
    FUNCTION fnuObtCAPTURE_ORDER(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.CAPTURE_ORDER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCAPTURE_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CAPTURE_ORDER;
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
    END fnuObtCAPTURE_ORDER;
 
    -- Obtiene el valor de la columna DATA_VALUE
    FUNCTION fsbObtDATA_VALUE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.DATA_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDATA_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DATA_VALUE;
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
    END fsbObtDATA_VALUE;
 
    -- Obtiene el valor de la columna IS_PERSISTENT
    FUNCTION fsbObtIS_PERSISTENT(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2
        ) RETURN OR_TEMP_DATA_VALUES.IS_PERSISTENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtIS_PERSISTENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_PERSISTENT;
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
    END fsbObtIS_PERSISTENT;
 
    -- Actualiza el valor de la columna ATTRIBUTE_SET_ID
    PROCEDURE prAcATTRIBUTE_SET_ID(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuATTRIBUTE_SET_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcATTRIBUTE_SET_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME,TRUE);
        IF NVL(inuATTRIBUTE_SET_ID,-1) <> NVL(rcRegistroAct.ATTRIBUTE_SET_ID,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET ATTRIBUTE_SET_ID=inuATTRIBUTE_SET_ID
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
    END prAcATTRIBUTE_SET_ID;
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuCONSECUTIVE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME,TRUE);
        IF NVL(inuCONSECUTIVE,-1) <> NVL(rcRegistroAct.CONSECUTIVE,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET CONSECUTIVE=inuCONSECUTIVE
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
    END prAcCONSECUTIVE;
 
    -- Actualiza el valor de la columna CAPTURE_ORDER
    PROCEDURE prAcCAPTURE_ORDER(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        inuCAPTURE_ORDER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCAPTURE_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME,TRUE);
        IF NVL(inuCAPTURE_ORDER,-1) <> NVL(rcRegistroAct.CAPTURE_ORDER,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET CAPTURE_ORDER=inuCAPTURE_ORDER
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
    END prAcCAPTURE_ORDER;
 
    -- Actualiza el valor de la columna DATA_VALUE
    PROCEDURE prAcDATA_VALUE(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        isbDATA_VALUE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDATA_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME,TRUE);
        IF NVL(isbDATA_VALUE,'-') <> NVL(rcRegistroAct.DATA_VALUE,'-') THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET DATA_VALUE=isbDATA_VALUE
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
    END prAcDATA_VALUE;
 
    -- Actualiza el valor de la columna IS_PERSISTENT
    PROCEDURE prAcIS_PERSISTENT(
        inuORDER_ID    NUMBER,inuATTRIBUTE_ID    NUMBER,isbATTRIBUTE_NAME    VARCHAR2,
        isbIS_PERSISTENT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PERSISTENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuATTRIBUTE_ID,isbATTRIBUTE_NAME,TRUE);
        IF NVL(isbIS_PERSISTENT,'-') <> NVL(rcRegistroAct.IS_PERSISTENT,'-') THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET IS_PERSISTENT=isbIS_PERSISTENT
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
    END prAcIS_PERSISTENT;
 
    -- Actualiza por RowId el valor de la columna ATTRIBUTE_SET_ID
    PROCEDURE prAcATTRIBUTE_SET_ID_RId(
        iRowId ROWID,
        inuATTRIBUTE_SET_ID_O    NUMBER,
        inuATTRIBUTE_SET_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcATTRIBUTE_SET_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuATTRIBUTE_SET_ID_O,-1) <> NVL(inuATTRIBUTE_SET_ID_N,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET ATTRIBUTE_SET_ID=inuATTRIBUTE_SET_ID_N
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
    END prAcATTRIBUTE_SET_ID_RId;
 
    -- Actualiza por RowId el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE_RId(
        iRowId ROWID,
        inuCONSECUTIVE_O    NUMBER,
        inuCONSECUTIVE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONSECUTIVE_O,-1) <> NVL(inuCONSECUTIVE_N,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET CONSECUTIVE=inuCONSECUTIVE_N
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
    END prAcCONSECUTIVE_RId;
 
    -- Actualiza por RowId el valor de la columna CAPTURE_ORDER
    PROCEDURE prAcCAPTURE_ORDER_RId(
        iRowId ROWID,
        inuCAPTURE_ORDER_O    NUMBER,
        inuCAPTURE_ORDER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCAPTURE_ORDER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCAPTURE_ORDER_O,-1) <> NVL(inuCAPTURE_ORDER_N,-1) THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET CAPTURE_ORDER=inuCAPTURE_ORDER_N
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
    END prAcCAPTURE_ORDER_RId;
 
    -- Actualiza por RowId el valor de la columna DATA_VALUE
    PROCEDURE prAcDATA_VALUE_RId(
        iRowId ROWID,
        isbDATA_VALUE_O    VARCHAR2,
        isbDATA_VALUE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDATA_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbDATA_VALUE_O,'-') <> NVL(isbDATA_VALUE_N,'-') THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET DATA_VALUE=isbDATA_VALUE_N
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
    END prAcDATA_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna IS_PERSISTENT
    PROCEDURE prAcIS_PERSISTENT_RId(
        iRowId ROWID,
        isbIS_PERSISTENT_O    VARCHAR2,
        isbIS_PERSISTENT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PERSISTENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_PERSISTENT_O,'-') <> NVL(isbIS_PERSISTENT_N,'-') THEN
            UPDATE OR_TEMP_DATA_VALUES
            SET IS_PERSISTENT=isbIS_PERSISTENT_N
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
    END prAcIS_PERSISTENT_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_TEMP_DATA_VALUES%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,ircRegistro.ATTRIBUTE_ID,ircRegistro.ATTRIBUTE_NAME,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcATTRIBUTE_SET_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ATTRIBUTE_SET_ID,
                ircRegistro.ATTRIBUTE_SET_ID
            );
 
            prAcCONSECUTIVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONSECUTIVE,
                ircRegistro.CONSECUTIVE
            );
 
            prAcCAPTURE_ORDER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CAPTURE_ORDER,
                ircRegistro.CAPTURE_ORDER
            );
 
            prAcDATA_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DATA_VALUE,
                ircRegistro.DATA_VALUE
            );
 
            prAcIS_PERSISTENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_PERSISTENT,
                ircRegistro.IS_PERSISTENT
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
 
END pkg_OR_TEMP_DATA_VALUES;
/
BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_OR_TEMP_DATA_VALUES'), UPPER('adm_person'));
END;
/
