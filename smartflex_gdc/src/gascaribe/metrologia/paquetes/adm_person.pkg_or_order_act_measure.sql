CREATE OR REPLACE PACKAGE adm_person.pkg_or_order_act_measure AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_ORDER_ACT_MEASURE%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOR_ORDER_ACT_MEASURE IS SELECT * FROM OR_ORDER_ACT_MEASURE;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_ORDER_ACT_MEASURE
        Caso  : OSF-3911
        Fecha : 10/01/2025 08:57:38
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ACT_MEASURE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER_ACT_MEASURE tb
        WHERE
        ORDER_ACT_MEASURE_ID = inuORDER_ACT_MEASURE_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ACT_MEASURE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER_ACT_MEASURE tb
        WHERE
        ORDER_ACT_MEASURE_ID = inuORDER_ACT_MEASURE_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORDER_ACT_MEASURE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORDER_ACT_MEASURE_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuORDER_ACT_MEASURE_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_ORDER_ACT_MEASURE%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORDER_ACT_MEASURE_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ORDER_ID
    FUNCTION fnuObtORDER_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ORDER_ID%TYPE;
 
    -- Obtiene el valor de la columna VARIABLE_ID
    FUNCTION fnuObtVARIABLE_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.VARIABLE_ID%TYPE;
 
    -- Obtiene el valor de la columna MEASURE_NUMBER
    FUNCTION fnuObtMEASURE_NUMBER(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.MEASURE_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna PATTERN_VALUE
    FUNCTION fnuObtPATTERN_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.PATTERN_VALUE%TYPE;
 
    -- Obtiene el valor de la columna ITEM_VALUE
    FUNCTION fnuObtITEM_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ITEM_VALUE%TYPE;
 
    -- Obtiene el valor de la columna ERROR
    FUNCTION fnuObtERROR(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ERROR%TYPE;
 
    -- Obtiene el valor de la columna UNCERTAINTY
    FUNCTION fsbObtUNCERTAINTY(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.UNCERTAINTY%TYPE;
 
    -- Obtiene el valor de la columna ITEM_PATTERN_ID
    FUNCTION fnuObtITEM_PATTERN_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ITEM_PATTERN_ID%TYPE;
 
    -- Actualiza el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuORDER_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna VARIABLE_ID
    PROCEDURE prAcVARIABLE_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuVARIABLE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna MEASURE_NUMBER
    PROCEDURE prAcMEASURE_NUMBER(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuMEASURE_NUMBER    NUMBER
    );
 
    -- Actualiza el valor de la columna PATTERN_VALUE
    PROCEDURE prAcPATTERN_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuPATTERN_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna ITEM_VALUE
    PROCEDURE prAcITEM_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuITEM_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna ERROR
    PROCEDURE prAcERROR(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuERROR    NUMBER
    );
 
    -- Actualiza el valor de la columna UNCERTAINTY
    PROCEDURE prAcUNCERTAINTY(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        isbUNCERTAINTY    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ITEM_PATTERN_ID
    PROCEDURE prAcITEM_PATTERN_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuITEM_PATTERN_ID    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ORDER_ACT_MEASURE%ROWTYPE);
    
    FUNCTION fnuObtItemPatronPorOrden(inuOrden in or_order.order_id%type) 
    RETURN or_order_act_measure.item_pattern_id%TYPE;
	
	FUNCTION fnuObtValPorOtyVariable(	inuOrden 	IN or_order.order_id%type,
									inuVariable IN or_order_act_measure.variable_id%TYPE) 
	RETURN or_order_act_measure.pattern_value%TYPE;
 
END pkg_or_order_act_measure;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order_act_measure AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ACT_MEASURE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ACT_MEASURE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ACT_MEASURE_ID);
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
        inuORDER_ACT_MEASURE_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ORDER_ACT_MEASURE_ID IS NOT NULL;
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
        inuORDER_ACT_MEASURE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ACT_MEASURE_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ACT_MEASURE_ID||'] en la tabla[OR_ORDER_ACT_MEASURE]');
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
    PROCEDURE prInsRegistro( ircRegistro cuOR_ORDER_ACT_MEASURE%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_ORDER_ACT_MEASURE(
            ORDER_ACT_MEASURE_ID,ORDER_ID,VARIABLE_ID,MEASURE_NUMBER,PATTERN_VALUE,ITEM_VALUE,ERROR,UNCERTAINTY,ITEM_PATTERN_ID
        )
        VALUES (
            ircRegistro.ORDER_ACT_MEASURE_ID,ircRegistro.ORDER_ID,ircRegistro.VARIABLE_ID,ircRegistro.MEASURE_NUMBER,ircRegistro.PATTERN_VALUE,ircRegistro.ITEM_VALUE,ircRegistro.ERROR,ircRegistro.UNCERTAINTY,ircRegistro.ITEM_PATTERN_ID
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
        inuORDER_ACT_MEASURE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_ORDER_ACT_MEASURE
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
            DELETE OR_ORDER_ACT_MEASURE
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
 
    -- Obtiene el valor de la columna ORDER_ID
    FUNCTION fnuObtORDER_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ORDER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_ID;
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
    END fnuObtORDER_ID;
 
    -- Obtiene el valor de la columna VARIABLE_ID
    FUNCTION fnuObtVARIABLE_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.VARIABLE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVARIABLE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VARIABLE_ID;
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
    END fnuObtVARIABLE_ID;
 
    -- Obtiene el valor de la columna MEASURE_NUMBER
    FUNCTION fnuObtMEASURE_NUMBER(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.MEASURE_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtMEASURE_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MEASURE_NUMBER;
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
    END fnuObtMEASURE_NUMBER;
 
    -- Obtiene el valor de la columna PATTERN_VALUE
    FUNCTION fnuObtPATTERN_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.PATTERN_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPATTERN_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PATTERN_VALUE;
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
    END fnuObtPATTERN_VALUE;
 
    -- Obtiene el valor de la columna ITEM_VALUE
    FUNCTION fnuObtITEM_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ITEM_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtITEM_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ITEM_VALUE;
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
    END fnuObtITEM_VALUE;
 
    -- Obtiene el valor de la columna ERROR
    FUNCTION fnuObtERROR(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ERROR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtERROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ERROR;
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
    END fnuObtERROR;
 
    -- Obtiene el valor de la columna UNCERTAINTY
    FUNCTION fsbObtUNCERTAINTY(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.UNCERTAINTY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUNCERTAINTY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UNCERTAINTY;
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
    END fsbObtUNCERTAINTY;
 
    -- Obtiene el valor de la columna ITEM_PATTERN_ID
    FUNCTION fnuObtITEM_PATTERN_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER
        ) RETURN OR_ORDER_ACT_MEASURE.ITEM_PATTERN_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtITEM_PATTERN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ITEM_PATTERN_ID;
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
    END fnuObtITEM_PATTERN_ID;
 
    -- Actualiza el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuORDER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuORDER_ID,-1) <> NVL(rcRegistroAct.ORDER_ID,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ORDER_ID=inuORDER_ID
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
    END prAcORDER_ID;
 
    -- Actualiza el valor de la columna VARIABLE_ID
    PROCEDURE prAcVARIABLE_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuVARIABLE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVARIABLE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuVARIABLE_ID,-1) <> NVL(rcRegistroAct.VARIABLE_ID,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET VARIABLE_ID=inuVARIABLE_ID
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
    END prAcVARIABLE_ID;
 
    -- Actualiza el valor de la columna MEASURE_NUMBER
    PROCEDURE prAcMEASURE_NUMBER(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuMEASURE_NUMBER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMEASURE_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuMEASURE_NUMBER,-1) <> NVL(rcRegistroAct.MEASURE_NUMBER,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET MEASURE_NUMBER=inuMEASURE_NUMBER
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
    END prAcMEASURE_NUMBER;
 
    -- Actualiza el valor de la columna PATTERN_VALUE
    PROCEDURE prAcPATTERN_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuPATTERN_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPATTERN_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuPATTERN_VALUE,-1) <> NVL(rcRegistroAct.PATTERN_VALUE,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET PATTERN_VALUE=inuPATTERN_VALUE
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
    END prAcPATTERN_VALUE;
 
    -- Actualiza el valor de la columna ITEM_VALUE
    PROCEDURE prAcITEM_VALUE(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuITEM_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuITEM_VALUE,-1) <> NVL(rcRegistroAct.ITEM_VALUE,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ITEM_VALUE=inuITEM_VALUE
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
    END prAcITEM_VALUE;
 
    -- Actualiza el valor de la columna ERROR
    PROCEDURE prAcERROR(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuERROR    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcERROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuERROR,-1) <> NVL(rcRegistroAct.ERROR,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ERROR=inuERROR
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
    END prAcERROR;
 
    -- Actualiza el valor de la columna UNCERTAINTY
    PROCEDURE prAcUNCERTAINTY(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        isbUNCERTAINTY    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNCERTAINTY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(isbUNCERTAINTY,'-') <> NVL(rcRegistroAct.UNCERTAINTY,'-') THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET UNCERTAINTY=isbUNCERTAINTY
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
    END prAcUNCERTAINTY;
 
    -- Actualiza el valor de la columna ITEM_PATTERN_ID
    PROCEDURE prAcITEM_PATTERN_ID(
        inuORDER_ACT_MEASURE_ID    NUMBER,
        inuITEM_PATTERN_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_PATTERN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ACT_MEASURE_ID,TRUE);
        IF NVL(inuITEM_PATTERN_ID,-1) <> NVL(rcRegistroAct.ITEM_PATTERN_ID,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ITEM_PATTERN_ID=inuITEM_PATTERN_ID
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
    END prAcITEM_PATTERN_ID;
 
    -- Actualiza por RowId el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID_RId(
        iRowId ROWID,
        inuORDER_ID_O    NUMBER,
        inuORDER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_ID_O,-1) <> NVL(inuORDER_ID_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ORDER_ID=inuORDER_ID_N
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
    END prAcORDER_ID_RId;
 
    -- Actualiza por RowId el valor de la columna VARIABLE_ID
    PROCEDURE prAcVARIABLE_ID_RId(
        iRowId ROWID,
        inuVARIABLE_ID_O    NUMBER,
        inuVARIABLE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVARIABLE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVARIABLE_ID_O,-1) <> NVL(inuVARIABLE_ID_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET VARIABLE_ID=inuVARIABLE_ID_N
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
    END prAcVARIABLE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna MEASURE_NUMBER
    PROCEDURE prAcMEASURE_NUMBER_RId(
        iRowId ROWID,
        inuMEASURE_NUMBER_O    NUMBER,
        inuMEASURE_NUMBER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMEASURE_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuMEASURE_NUMBER_O,-1) <> NVL(inuMEASURE_NUMBER_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET MEASURE_NUMBER=inuMEASURE_NUMBER_N
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
    END prAcMEASURE_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna PATTERN_VALUE
    PROCEDURE prAcPATTERN_VALUE_RId(
        iRowId ROWID,
        inuPATTERN_VALUE_O    NUMBER,
        inuPATTERN_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPATTERN_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPATTERN_VALUE_O,-1) <> NVL(inuPATTERN_VALUE_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET PATTERN_VALUE=inuPATTERN_VALUE_N
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
    END prAcPATTERN_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna ITEM_VALUE
    PROCEDURE prAcITEM_VALUE_RId(
        iRowId ROWID,
        inuITEM_VALUE_O    NUMBER,
        inuITEM_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuITEM_VALUE_O,-1) <> NVL(inuITEM_VALUE_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ITEM_VALUE=inuITEM_VALUE_N
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
    END prAcITEM_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna ERROR
    PROCEDURE prAcERROR_RId(
        iRowId ROWID,
        inuERROR_O    NUMBER,
        inuERROR_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcERROR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuERROR_O,-1) <> NVL(inuERROR_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ERROR=inuERROR_N
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
    END prAcERROR_RId;
 
    -- Actualiza por RowId el valor de la columna UNCERTAINTY
    PROCEDURE prAcUNCERTAINTY_RId(
        iRowId ROWID,
        isbUNCERTAINTY_O    VARCHAR2,
        isbUNCERTAINTY_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNCERTAINTY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUNCERTAINTY_O,'-') <> NVL(isbUNCERTAINTY_N,'-') THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET UNCERTAINTY=isbUNCERTAINTY_N
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
    END prAcUNCERTAINTY_RId;
 
    -- Actualiza por RowId el valor de la columna ITEM_PATTERN_ID
    PROCEDURE prAcITEM_PATTERN_ID_RId(
        iRowId ROWID,
        inuITEM_PATTERN_ID_O    NUMBER,
        inuITEM_PATTERN_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_PATTERN_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuITEM_PATTERN_ID_O,-1) <> NVL(inuITEM_PATTERN_ID_N,-1) THEN
            UPDATE OR_ORDER_ACT_MEASURE
            SET ITEM_PATTERN_ID=inuITEM_PATTERN_ID_N
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
    END prAcITEM_PATTERN_ID_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ORDER_ACT_MEASURE%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ACT_MEASURE_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcORDER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_ID,
                ircRegistro.ORDER_ID
            );
 
            prAcVARIABLE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VARIABLE_ID,
                ircRegistro.VARIABLE_ID
            );
 
            prAcMEASURE_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MEASURE_NUMBER,
                ircRegistro.MEASURE_NUMBER
            );
 
            prAcPATTERN_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PATTERN_VALUE,
                ircRegistro.PATTERN_VALUE
            );
 
            prAcITEM_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ITEM_VALUE,
                ircRegistro.ITEM_VALUE
            );
 
            prAcERROR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ERROR,
                ircRegistro.ERROR
            );
 
            prAcUNCERTAINTY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UNCERTAINTY,
                ircRegistro.UNCERTAINTY
            );
 
            prAcITEM_PATTERN_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ITEM_PATTERN_ID,
                ircRegistro.ITEM_PATTERN_ID
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
    
  FUNCTION fnuObtItemPatronPorOrden(inuOrden in or_order.order_id%type) 
  RETURN or_order_act_measure.item_pattern_id%TYPE
  IS
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtItemPatronPorOrden
    Descripcion     : Retorna Id Item Patron por Orden de trabajo
    Autor           : Jhon Jairo Soto
    Fecha           : 10-01-2025
    
    Parametros de Entrada
    inuOrden       Numero de orden
    
    Parametros de Salida
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
  
    csbMetodo   VARCHAR2(100) := csbSP_NAME || '.fnuObtItemPatronPorOrden';
    nuError     NUMBER; -- se almacena codigo de error
    sbError     VARCHAR2(2000); -- se almacena descripcion del error
    nuItemPatt  ge_items_seriado.id_items_seriado%type;
	
      CURSOR cuItemPatt  IS
        SELECT m.item_pattern_id 
        FROM or_order_act_measure m
          WHERE ORDER_id = inuOrden
          AND rownum = 1;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
 
	OPEN cuItemPatt;
	FETCH cuItemPatt INTO nuItemPatt;
	CLOSE cuItemPatt;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN nuItemPatt;
  
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
   
  END fnuObtItemPatronPorOrden;


  FUNCTION fnuObtValPorOtyVariable(	inuOrden 	IN or_order.order_id%type,
									inuVariable IN or_order_act_measure.variable_id%TYPE) 
  RETURN or_order_act_measure.pattern_value%TYPE
  IS
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValPorOtyVariable
    Descripcion     : Retorna el valor de la variable para la orden
    Autor           : Jhon Jairo Soto
    Fecha           : 10-01-2025
    
    Parametros de Entrada
    inuOrden       Numero de orden
	inuVariable	   Variable de la cual se quiere obtener el valor
    
    Parametros de Salida
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
  
    csbMetodo   VARCHAR2(100) := csbSP_NAME || '.fnuObtValPorOtyVariable';
    nuError     NUMBER; -- se almacena codigo de error
    sbError     VARCHAR2(2000); -- se almacena descripcion del error
    nuValor		or_order_act_measure.pattern_value%TYPE;
	
	cursor cuV1 is
	   select pattern_value
	   from or_order_act_measure
	   where variable_id = inuVariable
	   and Order_id = inuOrden
	   and measure_number=1 ;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 
	OPEN cuV1;
	FETCH cuV1 INTO nuValor;
	CLOSE cuV1;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	RETURN nuValor;
  
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
   
  END fnuObtValPorOtyVariable;


 
END pkg_or_order_act_measure;
/
BEGIN

    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_or_order_act_measure'), UPPER('adm_person'));
END;
/
