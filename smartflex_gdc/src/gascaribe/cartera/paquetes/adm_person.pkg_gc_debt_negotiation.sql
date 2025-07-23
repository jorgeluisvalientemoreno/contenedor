CREATE OR REPLACE PACKAGE adm_person.pkg_GC_DEBT_NEGOTIATION AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF GC_DEBT_NEGOTIATION%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuGC_DEBT_NEGOTIATION IS SELECT * FROM GC_DEBT_NEGOTIATION;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : GC_DEBT_NEGOTIATION
        Caso  : OSF-XXXX
        Fecha : 02/12/2024 15:07:27
    ***************************************************************************/
	
    CURSOR cuRegistroRId
    (
        inuDEBT_NEGOTIATION_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM GC_DEBT_NEGOTIATION tb
        WHERE
        DEBT_NEGOTIATION_ID = inuDEBT_NEGOTIATION_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuDEBT_NEGOTIATION_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM GC_DEBT_NEGOTIATION tb
        WHERE
        DEBT_NEGOTIATION_ID = inuDEBT_NEGOTIATION_ID
        FOR UPDATE NOWAIT;
    
	FUNCTION fsbVersion RETURN VARCHAR2;
	
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOTIATION_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuDEBT_NEGOTIATION_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuDEBT_NEGOTIATION_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuGC_DEBT_NEGOTIATION%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuDEBT_NEGOTIATION_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PAYMENT_METHOD
    FUNCTION fsbObtPAYMENT_METHOD(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PAYMENT_METHOD%TYPE;
 
    -- Obtiene el valor de la columna PROCCONS
    FUNCTION fnuObtPROCCONS(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PROCCONS%TYPE;
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE;
 
    -- Obtiene el valor de la columna REQUIRE_SIGNING
    FUNCTION fsbObtREQUIRE_SIGNING(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.REQUIRE_SIGNING%TYPE;
 
    -- Obtiene el valor de la columna REQUIRE_PAYMENT
    FUNCTION fsbObtREQUIRE_PAYMENT(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.REQUIRE_PAYMENT%TYPE;
 
    -- Obtiene el valor de la columna COUPON_ID
    FUNCTION fnuObtCOUPON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.COUPON_ID%TYPE;
 
    -- Obtiene el valor de la columna SIGNED
    FUNCTION fsbObtSIGNED(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGNED%TYPE;
 
    -- Obtiene el valor de la columna SIGN_TERMINAL
    FUNCTION fsbObtSIGN_TERMINAL(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGN_TERMINAL%TYPE;
 
    -- Obtiene el valor de la columna SIGN_DATE
    FUNCTION fdtObtSIGN_DATE(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGN_DATE%TYPE;
 
    -- Obtiene el valor de la columna PERSON_ID
    FUNCTION fnuObtPERSON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PERSON_ID%TYPE;
 
    -- Obtiene el valor de la columna PAYM_AGREEM_PLAN_ID
    FUNCTION fnuObtPAYM_AGREEM_PLAN_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PAYM_AGREEM_PLAN_ID%TYPE;
 
    -- Actualiza el valor de la columna PAYMENT_METHOD
    PROCEDURE prAcPAYMENT_METHOD(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbPAYMENT_METHOD    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PROCCONS
    PROCEDURE prAcPROCCONS(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPROCCONS    NUMBER
    );
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna REQUIRE_SIGNING
    PROCEDURE prAcREQUIRE_SIGNING(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbREQUIRE_SIGNING    VARCHAR2
    );
 
    -- Actualiza el valor de la columna REQUIRE_PAYMENT
    PROCEDURE prAcREQUIRE_PAYMENT(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbREQUIRE_PAYMENT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna COUPON_ID
    PROCEDURE prAcCOUPON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuCOUPON_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SIGNED
    PROCEDURE prAcSIGNED(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbSIGNED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SIGN_TERMINAL
    PROCEDURE prAcSIGN_TERMINAL(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbSIGN_TERMINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SIGN_DATE
    PROCEDURE prAcSIGN_DATE(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        idtSIGN_DATE    DATE
    );
 
    -- Actualiza el valor de la columna PERSON_ID
    PROCEDURE prAcPERSON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPERSON_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PAYM_AGREEM_PLAN_ID
    PROCEDURE prAcPAYM_AGREEM_PLAN_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPAYM_AGREEM_PLAN_ID    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuGC_DEBT_NEGOTIATION%ROWTYPE);
	

END pkg_GC_DEBT_NEGOTIATION;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_GC_DEBT_NEGOTIATION AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
	csbVersion     VARCHAR2(200) := 'OSF-3635';
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuDEBT_NEGOTIATION_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuDEBT_NEGOTIATION_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuDEBT_NEGOTIATION_ID);
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
        inuDEBT_NEGOTIATION_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.DEBT_NEGOTIATION_ID IS NOT NULL;
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
        inuDEBT_NEGOTIATION_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuDEBT_NEGOTIATION_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuDEBT_NEGOTIATION_ID||'] en la tabla[GC_DEBT_NEGOTIATION]');
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
    PROCEDURE prInsRegistro( ircRegistro cuGC_DEBT_NEGOTIATION%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO GC_DEBT_NEGOTIATION(
            DEBT_NEGOTIATION_ID,PAYMENT_METHOD,PROCCONS,PACKAGE_ID,REQUIRE_SIGNING,REQUIRE_PAYMENT,COUPON_ID,SIGNED,SIGN_TERMINAL,SIGN_DATE,PERSON_ID,PAYM_AGREEM_PLAN_ID
        )
        VALUES (
            ircRegistro.DEBT_NEGOTIATION_ID,ircRegistro.PAYMENT_METHOD,ircRegistro.PROCCONS,ircRegistro.PACKAGE_ID,ircRegistro.REQUIRE_SIGNING,ircRegistro.REQUIRE_PAYMENT,ircRegistro.COUPON_ID,ircRegistro.SIGNED,ircRegistro.SIGN_TERMINAL,ircRegistro.SIGN_DATE,ircRegistro.PERSON_ID,ircRegistro.PAYM_AGREEM_PLAN_ID
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
        inuDEBT_NEGOTIATION_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE GC_DEBT_NEGOTIATION
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
            DELETE GC_DEBT_NEGOTIATION
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
	
	
	FUNCTION fsbVersion RETURN VARCHAR2 IS
		BEGIN
		RETURN csbVersion;
	END fsbVersion;

     -- Obtiene el valor de la columna PAYMENT_METHOD
    FUNCTION fsbObtPAYMENT_METHOD(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PAYMENT_METHOD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPAYMENT_METHOD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAYMENT_METHOD;
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
    END fsbObtPAYMENT_METHOD;
 
    -- Obtiene el valor de la columna PROCCONS
    FUNCTION fnuObtPROCCONS(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PROCCONS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPROCCONS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PROCCONS;
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
    END fnuObtPROCCONS;
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PACKAGE_ID;
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
    END fnuObtPACKAGE_ID;
 
    -- Obtiene el valor de la columna REQUIRE_SIGNING
    FUNCTION fsbObtREQUIRE_SIGNING(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.REQUIRE_SIGNING%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtREQUIRE_SIGNING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REQUIRE_SIGNING;
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
    END fsbObtREQUIRE_SIGNING;
 
    -- Obtiene el valor de la columna REQUIRE_PAYMENT
    FUNCTION fsbObtREQUIRE_PAYMENT(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.REQUIRE_PAYMENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtREQUIRE_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REQUIRE_PAYMENT;
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
    END fsbObtREQUIRE_PAYMENT;
 
    -- Obtiene el valor de la columna COUPON_ID
    FUNCTION fnuObtCOUPON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.COUPON_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOUPON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COUPON_ID;
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
    END fnuObtCOUPON_ID;
 
    -- Obtiene el valor de la columna SIGNED
    FUNCTION fsbObtSIGNED(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGNED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSIGNED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SIGNED;
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
    END fsbObtSIGNED;
 
    -- Obtiene el valor de la columna SIGN_TERMINAL
    FUNCTION fsbObtSIGN_TERMINAL(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGN_TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSIGN_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SIGN_TERMINAL;
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
    END fsbObtSIGN_TERMINAL;
 
    -- Obtiene el valor de la columna SIGN_DATE
    FUNCTION fdtObtSIGN_DATE(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.SIGN_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtSIGN_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SIGN_DATE;
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
    END fdtObtSIGN_DATE;
 
    -- Obtiene el valor de la columna PERSON_ID
    FUNCTION fnuObtPERSON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PERSON_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPERSON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PERSON_ID;
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
    END fnuObtPERSON_ID;
 
    -- Obtiene el valor de la columna PAYM_AGREEM_PLAN_ID
    FUNCTION fnuObtPAYM_AGREEM_PLAN_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER
        ) RETURN GC_DEBT_NEGOTIATION.PAYM_AGREEM_PLAN_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAYM_AGREEM_PLAN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAYM_AGREEM_PLAN_ID;
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
    END fnuObtPAYM_AGREEM_PLAN_ID;
 
    -- Actualiza el valor de la columna PAYMENT_METHOD
    PROCEDURE prAcPAYMENT_METHOD(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbPAYMENT_METHOD    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAYMENT_METHOD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(isbPAYMENT_METHOD,'-') <> NVL(rcRegistroAct.PAYMENT_METHOD,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PAYMENT_METHOD=isbPAYMENT_METHOD
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
    END prAcPAYMENT_METHOD;
 
    -- Actualiza el valor de la columna PROCCONS
    PROCEDURE prAcPROCCONS(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPROCCONS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCCONS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(inuPROCCONS,-1) <> NVL(rcRegistroAct.PROCCONS,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PROCCONS=inuPROCCONS
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
    END prAcPROCCONS;
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(inuPACKAGE_ID,-1) <> NVL(rcRegistroAct.PACKAGE_ID,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PACKAGE_ID=inuPACKAGE_ID
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
    END prAcPACKAGE_ID;
 
    -- Actualiza el valor de la columna REQUIRE_SIGNING
    PROCEDURE prAcREQUIRE_SIGNING(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbREQUIRE_SIGNING    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRE_SIGNING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(isbREQUIRE_SIGNING,'-') <> NVL(rcRegistroAct.REQUIRE_SIGNING,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET REQUIRE_SIGNING=isbREQUIRE_SIGNING
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
    END prAcREQUIRE_SIGNING;
 
    -- Actualiza el valor de la columna REQUIRE_PAYMENT
    PROCEDURE prAcREQUIRE_PAYMENT(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbREQUIRE_PAYMENT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRE_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(isbREQUIRE_PAYMENT,'-') <> NVL(rcRegistroAct.REQUIRE_PAYMENT,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET REQUIRE_PAYMENT=isbREQUIRE_PAYMENT
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
    END prAcREQUIRE_PAYMENT;
 
    -- Actualiza el valor de la columna COUPON_ID
    PROCEDURE prAcCOUPON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuCOUPON_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOUPON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(inuCOUPON_ID,-1) <> NVL(rcRegistroAct.COUPON_ID,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET COUPON_ID=inuCOUPON_ID
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
    END prAcCOUPON_ID;
 
    -- Actualiza el valor de la columna SIGNED
    PROCEDURE prAcSIGNED(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbSIGNED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGNED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(isbSIGNED,'-') <> NVL(rcRegistroAct.SIGNED,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGNED=isbSIGNED
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
    END prAcSIGNED;
 
    -- Actualiza el valor de la columna SIGN_TERMINAL
    PROCEDURE prAcSIGN_TERMINAL(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        isbSIGN_TERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(isbSIGN_TERMINAL,'-') <> NVL(rcRegistroAct.SIGN_TERMINAL,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGN_TERMINAL=isbSIGN_TERMINAL
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
    END prAcSIGN_TERMINAL;
 
    -- Actualiza el valor de la columna SIGN_DATE
    PROCEDURE prAcSIGN_DATE(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        idtSIGN_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(idtSIGN_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.SIGN_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGN_DATE=idtSIGN_DATE
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
    END prAcSIGN_DATE;
 
    -- Actualiza el valor de la columna PERSON_ID
    PROCEDURE prAcPERSON_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPERSON_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERSON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(inuPERSON_ID,-1) <> NVL(rcRegistroAct.PERSON_ID,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PERSON_ID=inuPERSON_ID
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
    END prAcPERSON_ID;
 
    -- Actualiza el valor de la columna PAYM_AGREEM_PLAN_ID
    PROCEDURE prAcPAYM_AGREEM_PLAN_ID(
        inuDEBT_NEGOTIATION_ID    NUMBER,
        inuPAYM_AGREEM_PLAN_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAYM_AGREEM_PLAN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuDEBT_NEGOTIATION_ID,TRUE);
        IF NVL(inuPAYM_AGREEM_PLAN_ID,-1) <> NVL(rcRegistroAct.PAYM_AGREEM_PLAN_ID,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PAYM_AGREEM_PLAN_ID=inuPAYM_AGREEM_PLAN_ID
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
    END prAcPAYM_AGREEM_PLAN_ID;
 
    -- Actualiza por RowId el valor de la columna PAYMENT_METHOD
    PROCEDURE prAcPAYMENT_METHOD_RId(
        iRowId ROWID,
        isbPAYMENT_METHOD_O    VARCHAR2,
        isbPAYMENT_METHOD_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAYMENT_METHOD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPAYMENT_METHOD_O,'-') <> NVL(isbPAYMENT_METHOD_N,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PAYMENT_METHOD=isbPAYMENT_METHOD_N
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
    END prAcPAYMENT_METHOD_RId;
 
    -- Actualiza por RowId el valor de la columna PROCCONS
    PROCEDURE prAcPROCCONS_RId(
        iRowId ROWID,
        inuPROCCONS_O    NUMBER,
        inuPROCCONS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCCONS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPROCCONS_O,-1) <> NVL(inuPROCCONS_N,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PROCCONS=inuPROCCONS_N
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
    END prAcPROCCONS_RId;
 
    -- Actualiza por RowId el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID_RId(
        iRowId ROWID,
        inuPACKAGE_ID_O    NUMBER,
        inuPACKAGE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPACKAGE_ID_O,-1) <> NVL(inuPACKAGE_ID_N,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PACKAGE_ID=inuPACKAGE_ID_N
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
    END prAcPACKAGE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna REQUIRE_SIGNING
    PROCEDURE prAcREQUIRE_SIGNING_RId(
        iRowId ROWID,
        isbREQUIRE_SIGNING_O    VARCHAR2,
        isbREQUIRE_SIGNING_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRE_SIGNING_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbREQUIRE_SIGNING_O,'-') <> NVL(isbREQUIRE_SIGNING_N,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET REQUIRE_SIGNING=isbREQUIRE_SIGNING_N
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
    END prAcREQUIRE_SIGNING_RId;
 
    -- Actualiza por RowId el valor de la columna REQUIRE_PAYMENT
    PROCEDURE prAcREQUIRE_PAYMENT_RId(
        iRowId ROWID,
        isbREQUIRE_PAYMENT_O    VARCHAR2,
        isbREQUIRE_PAYMENT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRE_PAYMENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbREQUIRE_PAYMENT_O,'-') <> NVL(isbREQUIRE_PAYMENT_N,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET REQUIRE_PAYMENT=isbREQUIRE_PAYMENT_N
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
    END prAcREQUIRE_PAYMENT_RId;
 
    -- Actualiza por RowId el valor de la columna COUPON_ID
    PROCEDURE prAcCOUPON_ID_RId(
        iRowId ROWID,
        inuCOUPON_ID_O    NUMBER,
        inuCOUPON_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOUPON_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOUPON_ID_O,-1) <> NVL(inuCOUPON_ID_N,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET COUPON_ID=inuCOUPON_ID_N
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
    END prAcCOUPON_ID_RId;
 
    -- Actualiza por RowId el valor de la columna SIGNED
    PROCEDURE prAcSIGNED_RId(
        iRowId ROWID,
        isbSIGNED_O    VARCHAR2,
        isbSIGNED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGNED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSIGNED_O,'-') <> NVL(isbSIGNED_N,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGNED=isbSIGNED_N
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
    END prAcSIGNED_RId;
 
    -- Actualiza por RowId el valor de la columna SIGN_TERMINAL
    PROCEDURE prAcSIGN_TERMINAL_RId(
        iRowId ROWID,
        isbSIGN_TERMINAL_O    VARCHAR2,
        isbSIGN_TERMINAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_TERMINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSIGN_TERMINAL_O,'-') <> NVL(isbSIGN_TERMINAL_N,'-') THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGN_TERMINAL=isbSIGN_TERMINAL_N
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
    END prAcSIGN_TERMINAL_RId;
 
    -- Actualiza por RowId el valor de la columna SIGN_DATE
    PROCEDURE prAcSIGN_DATE_RId(
        iRowId ROWID,
        idtSIGN_DATE_O    DATE,
        idtSIGN_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtSIGN_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtSIGN_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET SIGN_DATE=idtSIGN_DATE_N
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
    END prAcSIGN_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna PERSON_ID
    PROCEDURE prAcPERSON_ID_RId(
        iRowId ROWID,
        inuPERSON_ID_O    NUMBER,
        inuPERSON_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERSON_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPERSON_ID_O,-1) <> NVL(inuPERSON_ID_N,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PERSON_ID=inuPERSON_ID_N
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
    END prAcPERSON_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PAYM_AGREEM_PLAN_ID
    PROCEDURE prAcPAYM_AGREEM_PLAN_ID_RId(
        iRowId ROWID,
        inuPAYM_AGREEM_PLAN_ID_O    NUMBER,
        inuPAYM_AGREEM_PLAN_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAYM_AGREEM_PLAN_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAYM_AGREEM_PLAN_ID_O,-1) <> NVL(inuPAYM_AGREEM_PLAN_ID_N,-1) THEN
            UPDATE GC_DEBT_NEGOTIATION
            SET PAYM_AGREEM_PLAN_ID=inuPAYM_AGREEM_PLAN_ID_N
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
    END prAcPAYM_AGREEM_PLAN_ID_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuGC_DEBT_NEGOTIATION%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.DEBT_NEGOTIATION_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPAYMENT_METHOD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAYMENT_METHOD,
                ircRegistro.PAYMENT_METHOD
            );
 
            prAcPROCCONS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PROCCONS,
                ircRegistro.PROCCONS
            );
 
            prAcPACKAGE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PACKAGE_ID,
                ircRegistro.PACKAGE_ID
            );
 
            prAcREQUIRE_SIGNING_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REQUIRE_SIGNING,
                ircRegistro.REQUIRE_SIGNING
            );
 
            prAcREQUIRE_PAYMENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REQUIRE_PAYMENT,
                ircRegistro.REQUIRE_PAYMENT
            );
 
            prAcCOUPON_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COUPON_ID,
                ircRegistro.COUPON_ID
            );
 
            prAcSIGNED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGNED,
                ircRegistro.SIGNED
            );
 
            prAcSIGN_TERMINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGN_TERMINAL,
                ircRegistro.SIGN_TERMINAL
            );
 
            prAcSIGN_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGN_DATE,
                ircRegistro.SIGN_DATE
            );
 
            prAcPERSON_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PERSON_ID,
                ircRegistro.PERSON_ID
            );
 
            prAcPAYM_AGREEM_PLAN_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAYM_AGREEM_PLAN_ID,
                ircRegistro.PAYM_AGREEM_PLAN_ID
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
	
 
END pkg_GC_DEBT_NEGOTIATION;
/
BEGIN
    -- OSF-XXXX
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_GC_DEBT_NEGOTIATION'), UPPER('adm_person'));
END;
/
