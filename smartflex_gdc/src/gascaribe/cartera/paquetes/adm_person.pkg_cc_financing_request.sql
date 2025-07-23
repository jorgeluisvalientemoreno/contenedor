CREATE OR REPLACE PACKAGE adm_person.pkg_CC_FINANCING_REQUEST AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF CC_FINANCING_REQUEST%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuCC_FINANCING_REQUEST IS SELECT * FROM CC_FINANCING_REQUEST;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : CC_FINANCING_REQUEST
        Caso  : OSF-XXXX
        Fecha : 05/12/2024 19:39:57
    ***************************************************************************/
	
    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;
	
    CURSOR cuRegistroRId
    (
        inuFINANCING_REQUEST_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM CC_FINANCING_REQUEST tb
        WHERE
        FINANCING_REQUEST_ID = inuFINANCING_REQUEST_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuFINANCING_REQUEST_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM CC_FINANCING_REQUEST tb
        WHERE
        FINANCING_REQUEST_ID = inuFINANCING_REQUEST_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuFINANCING_REQUEST_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuFINANCING_REQUEST_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuFINANCING_REQUEST_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuCC_FINANCING_REQUEST%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuFINANCING_REQUEST_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.PACKAGE_ID%TYPE;
 
    -- Obtiene el valor de la columna FINANCING_ID
    FUNCTION fnuObtFINANCING_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FINANCING_ID%TYPE;
 
    -- Obtiene el valor de la columna REQUEST_TYPE
    FUNCTION fsbObtREQUEST_TYPE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.REQUEST_TYPE%TYPE;
 
    -- Obtiene el valor de la columna FINANCING_PLAN_ID
    FUNCTION fnuObtFINANCING_PLAN_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FINANCING_PLAN_ID%TYPE;
 
    -- Obtiene el valor de la columna COMPUTE_METHOD_ID
    FUNCTION fnuObtCOMPUTE_METHOD_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.COMPUTE_METHOD_ID%TYPE;
 
    -- Obtiene el valor de la columna INTEREST_RATE_ID
    FUNCTION fnuObtINTEREST_RATE_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INTEREST_RATE_ID%TYPE;
 
    -- Obtiene el valor de la columna FIRST_PAY_DATE
    FUNCTION fdtObtFIRST_PAY_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FIRST_PAY_DATE%TYPE;
 
    -- Obtiene el valor de la columna INITIAL_PAYMENT
    FUNCTION fnuObtINITIAL_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INITIAL_PAYMENT%TYPE;
 
    -- Obtiene el valor de la columna PERCENT_TO_FINANCE
    FUNCTION fnuObtPERCENT_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.PERCENT_TO_FINANCE%TYPE;
 
    -- Obtiene el valor de la columna SPREAD
    FUNCTION fnuObtSPREAD(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SPREAD%TYPE;
 
    -- Obtiene el valor de la columna QUOTAS_NUMBER
    FUNCTION fnuObtQUOTAS_NUMBER(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.QUOTAS_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna QUOTA_VALUE
    FUNCTION fnuObtQUOTA_VALUE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.QUOTA_VALUE%TYPE;
 
    -- Obtiene el valor de la columna TAX_FINANCING_ONE
    FUNCTION fsbObtTAX_FINANCING_ONE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.TAX_FINANCING_ONE%TYPE;
 
    -- Obtiene el valor de la columna VALUE_TO_FINANCE
    FUNCTION fnuObtVALUE_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.VALUE_TO_FINANCE%TYPE;
 
    -- Obtiene el valor de la columna DOCUMENT_SUPPORT
    FUNCTION fsbObtDOCUMENT_SUPPORT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.DOCUMENT_SUPPORT%TYPE;
 
    -- Obtiene el valor de la columna WAIT_BY_SIGN
    FUNCTION fsbObtWAIT_BY_SIGN(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WAIT_BY_SIGN%TYPE;
 
    -- Obtiene el valor de la columna WAIT_BY_PAYMENT
    FUNCTION fsbObtWAIT_BY_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WAIT_BY_PAYMENT%TYPE;
 
    -- Obtiene el valor de la columna COUPON_ID
    FUNCTION fnuObtCOUPON_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.COUPON_ID%TYPE;
 
    -- Obtiene el valor de la columna WARRANTY_DOCUMENT
    FUNCTION fnuObtWARRANTY_DOCUMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WARRANTY_DOCUMENT%TYPE;
 
    -- Obtiene el valor de la columna INIT_PAY_EXPIRATION
    FUNCTION fdtObtINIT_PAY_EXPIRATION(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INIT_PAY_EXPIRATION%TYPE;
 
    -- Obtiene el valor de la columna INTEREST_PERCENT
    FUNCTION fnuObtINTEREST_PERCENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INTEREST_PERCENT%TYPE;
 
    -- Obtiene el valor de la columna SIGNED
    FUNCTION fsbObtSIGNED(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGNED%TYPE;
 
    -- Obtiene el valor de la columna SIGNED_DATE
    FUNCTION fdtObtSIGNED_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGNED_DATE%TYPE;
 
    -- Obtiene el valor de la columna SUBSCRIPTION_ID
    FUNCTION fnuObtSUBSCRIPTION_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SUBSCRIPTION_ID%TYPE;
 
    -- Obtiene el valor de la columna SIGN_FUNCTIONARY
    FUNCTION fsbObtSIGN_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGN_FUNCTIONARY%TYPE;
 
    -- Obtiene el valor de la columna SIGN_TERMINAL
    FUNCTION fsbObtSIGN_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGN_TERMINAL%TYPE;
 
    -- Obtiene el valor de la columna RECORD_FUNCTIONARY
    FUNCTION fsbObtRECORD_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_FUNCTIONARY%TYPE;
 
    -- Obtiene el valor de la columna RECORD_DATE
    FUNCTION fdtObtRECORD_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_DATE%TYPE;
 
    -- Obtiene el valor de la columna RECORD_TERMINAL
    FUNCTION fsbObtRECORD_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_TERMINAL%TYPE;
 
    -- Obtiene el valor de la columna RECORD_PROGRAM
    FUNCTION fsbObtRECORD_PROGRAM(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_PROGRAM%TYPE;
 
    -- Obtiene el valor de la columna ONLY_EXPIRED_ACC
    FUNCTION fsbObtONLY_EXPIRED_ACC(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.ONLY_EXPIRED_ACC%TYPE;
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna FINANCING_ID
    PROCEDURE prAcFINANCING_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuFINANCING_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna REQUEST_TYPE
    PROCEDURE prAcREQUEST_TYPE(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbREQUEST_TYPE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FINANCING_PLAN_ID
    PROCEDURE prAcFINANCING_PLAN_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuFINANCING_PLAN_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna COMPUTE_METHOD_ID
    PROCEDURE prAcCOMPUTE_METHOD_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuCOMPUTE_METHOD_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna INTEREST_RATE_ID
    PROCEDURE prAcINTEREST_RATE_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINTEREST_RATE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna FIRST_PAY_DATE
    PROCEDURE prAcFIRST_PAY_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtFIRST_PAY_DATE    DATE
    );
 
    -- Actualiza el valor de la columna INITIAL_PAYMENT
    PROCEDURE prAcINITIAL_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINITIAL_PAYMENT    NUMBER
    );
 
    -- Actualiza el valor de la columna PERCENT_TO_FINANCE
    PROCEDURE prAcPERCENT_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuPERCENT_TO_FINANCE    NUMBER
    );
 
    -- Actualiza el valor de la columna SPREAD
    PROCEDURE prAcSPREAD(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuSPREAD    NUMBER
    );
 
    -- Actualiza el valor de la columna QUOTAS_NUMBER
    PROCEDURE prAcQUOTAS_NUMBER(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuQUOTAS_NUMBER    NUMBER
    );
 
    -- Actualiza el valor de la columna QUOTA_VALUE
    PROCEDURE prAcQUOTA_VALUE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuQUOTA_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna TAX_FINANCING_ONE
    PROCEDURE prAcTAX_FINANCING_ONE(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbTAX_FINANCING_ONE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna VALUE_TO_FINANCE
    PROCEDURE prAcVALUE_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuVALUE_TO_FINANCE    NUMBER
    );
 
    -- Actualiza el valor de la columna DOCUMENT_SUPPORT
    PROCEDURE prAcDOCUMENT_SUPPORT(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbDOCUMENT_SUPPORT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna WAIT_BY_SIGN
    PROCEDURE prAcWAIT_BY_SIGN(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbWAIT_BY_SIGN    VARCHAR2
    );
 
    -- Actualiza el valor de la columna WAIT_BY_PAYMENT
    PROCEDURE prAcWAIT_BY_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbWAIT_BY_PAYMENT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna COUPON_ID
    PROCEDURE prAcCOUPON_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuCOUPON_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna WARRANTY_DOCUMENT
    PROCEDURE prAcWARRANTY_DOCUMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuWARRANTY_DOCUMENT    NUMBER
    );
 
    -- Actualiza el valor de la columna INIT_PAY_EXPIRATION
    PROCEDURE prAcINIT_PAY_EXPIRATION(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtINIT_PAY_EXPIRATION    DATE
    );
 
    -- Actualiza el valor de la columna INTEREST_PERCENT
    PROCEDURE prAcINTEREST_PERCENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINTEREST_PERCENT    NUMBER
    );
 
    -- Actualiza el valor de la columna SIGNED
    PROCEDURE prAcSIGNED(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGNED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SIGNED_DATE
    PROCEDURE prAcSIGNED_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtSIGNED_DATE    DATE
    );
 
    -- Actualiza el valor de la columna SUBSCRIPTION_ID
    PROCEDURE prAcSUBSCRIPTION_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuSUBSCRIPTION_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SIGN_FUNCTIONARY
    PROCEDURE prAcSIGN_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGN_FUNCTIONARY    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SIGN_TERMINAL
    PROCEDURE prAcSIGN_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGN_TERMINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna RECORD_FUNCTIONARY
    PROCEDURE prAcRECORD_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_FUNCTIONARY    VARCHAR2
    );
 
    -- Actualiza el valor de la columna RECORD_DATE
    PROCEDURE prAcRECORD_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtRECORD_DATE    DATE
    );
 
    -- Actualiza el valor de la columna RECORD_TERMINAL
    PROCEDURE prAcRECORD_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_TERMINAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna RECORD_PROGRAM
    PROCEDURE prAcRECORD_PROGRAM(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_PROGRAM    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ONLY_EXPIRED_ACC
    PROCEDURE prAcONLY_EXPIRED_ACC(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbONLY_EXPIRED_ACC    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuCC_FINANCING_REQUEST%ROWTYPE);
 
END pkg_CC_FINANCING_REQUEST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_CC_FINANCING_REQUEST AS
    
	 -- Identificador del ultimo caso que hizo cambios
    csbVersion          VARCHAR2(15) := 'OSF-3635';
	
	csbSP_NAME			CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    	CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
	
    -- Obtiene registro y RowId
    
	
	FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

	
	FUNCTION frcObtRegistroRId(
        inuFINANCING_REQUEST_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuFINANCING_REQUEST_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuFINANCING_REQUEST_ID);
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
        inuFINANCING_REQUEST_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.FINANCING_REQUEST_ID IS NOT NULL;
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
        inuFINANCING_REQUEST_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuFINANCING_REQUEST_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuFINANCING_REQUEST_ID||'] en la tabla[CC_FINANCING_REQUEST]');
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
    PROCEDURE prInsRegistro( ircRegistro cuCC_FINANCING_REQUEST%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO CC_FINANCING_REQUEST(
            FINANCING_REQUEST_ID,PACKAGE_ID,FINANCING_ID,REQUEST_TYPE,FINANCING_PLAN_ID,COMPUTE_METHOD_ID,INTEREST_RATE_ID,FIRST_PAY_DATE,INITIAL_PAYMENT,PERCENT_TO_FINANCE,SPREAD,QUOTAS_NUMBER,QUOTA_VALUE,TAX_FINANCING_ONE,VALUE_TO_FINANCE,DOCUMENT_SUPPORT,WAIT_BY_SIGN,WAIT_BY_PAYMENT,COUPON_ID,WARRANTY_DOCUMENT,INIT_PAY_EXPIRATION,INTEREST_PERCENT,SIGNED,SIGNED_DATE,SUBSCRIPTION_ID,SIGN_FUNCTIONARY,SIGN_TERMINAL,RECORD_FUNCTIONARY,RECORD_DATE,RECORD_TERMINAL,RECORD_PROGRAM,ONLY_EXPIRED_ACC
        )
        VALUES (
            ircRegistro.FINANCING_REQUEST_ID,ircRegistro.PACKAGE_ID,ircRegistro.FINANCING_ID,ircRegistro.REQUEST_TYPE,ircRegistro.FINANCING_PLAN_ID,ircRegistro.COMPUTE_METHOD_ID,ircRegistro.INTEREST_RATE_ID,ircRegistro.FIRST_PAY_DATE,ircRegistro.INITIAL_PAYMENT,ircRegistro.PERCENT_TO_FINANCE,ircRegistro.SPREAD,ircRegistro.QUOTAS_NUMBER,ircRegistro.QUOTA_VALUE,ircRegistro.TAX_FINANCING_ONE,ircRegistro.VALUE_TO_FINANCE,ircRegistro.DOCUMENT_SUPPORT,ircRegistro.WAIT_BY_SIGN,ircRegistro.WAIT_BY_PAYMENT,ircRegistro.COUPON_ID,ircRegistro.WARRANTY_DOCUMENT,ircRegistro.INIT_PAY_EXPIRATION,ircRegistro.INTEREST_PERCENT,ircRegistro.SIGNED,ircRegistro.SIGNED_DATE,ircRegistro.SUBSCRIPTION_ID,ircRegistro.SIGN_FUNCTIONARY,ircRegistro.SIGN_TERMINAL,ircRegistro.RECORD_FUNCTIONARY,ircRegistro.RECORD_DATE,ircRegistro.RECORD_TERMINAL,ircRegistro.RECORD_PROGRAM,ircRegistro.ONLY_EXPIRED_ACC
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
        inuFINANCING_REQUEST_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE CC_FINANCING_REQUEST
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
            DELETE CC_FINANCING_REQUEST
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
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.PACKAGE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
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
 
    -- Obtiene el valor de la columna FINANCING_ID
    FUNCTION fnuObtFINANCING_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FINANCING_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFINANCING_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FINANCING_ID;
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
    END fnuObtFINANCING_ID;
 
    -- Obtiene el valor de la columna REQUEST_TYPE
    FUNCTION fsbObtREQUEST_TYPE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.REQUEST_TYPE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtREQUEST_TYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REQUEST_TYPE;
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
    END fsbObtREQUEST_TYPE;
 
    -- Obtiene el valor de la columna FINANCING_PLAN_ID
    FUNCTION fnuObtFINANCING_PLAN_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FINANCING_PLAN_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFINANCING_PLAN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FINANCING_PLAN_ID;
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
    END fnuObtFINANCING_PLAN_ID;
 
    -- Obtiene el valor de la columna COMPUTE_METHOD_ID
    FUNCTION fnuObtCOMPUTE_METHOD_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.COMPUTE_METHOD_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOMPUTE_METHOD_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMPUTE_METHOD_ID;
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
    END fnuObtCOMPUTE_METHOD_ID;
 
    -- Obtiene el valor de la columna INTEREST_RATE_ID
    FUNCTION fnuObtINTEREST_RATE_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INTEREST_RATE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtINTEREST_RATE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.INTEREST_RATE_ID;
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
    END fnuObtINTEREST_RATE_ID;
 
    -- Obtiene el valor de la columna FIRST_PAY_DATE
    FUNCTION fdtObtFIRST_PAY_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.FIRST_PAY_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFIRST_PAY_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FIRST_PAY_DATE;
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
    END fdtObtFIRST_PAY_DATE;
 
    -- Obtiene el valor de la columna INITIAL_PAYMENT
    FUNCTION fnuObtINITIAL_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INITIAL_PAYMENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtINITIAL_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.INITIAL_PAYMENT;
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
    END fnuObtINITIAL_PAYMENT;
 
    -- Obtiene el valor de la columna PERCENT_TO_FINANCE
    FUNCTION fnuObtPERCENT_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.PERCENT_TO_FINANCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPERCENT_TO_FINANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PERCENT_TO_FINANCE;
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
    END fnuObtPERCENT_TO_FINANCE;
 
    -- Obtiene el valor de la columna SPREAD
    FUNCTION fnuObtSPREAD(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SPREAD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSPREAD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SPREAD;
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
    END fnuObtSPREAD;
 
    -- Obtiene el valor de la columna QUOTAS_NUMBER
    FUNCTION fnuObtQUOTAS_NUMBER(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.QUOTAS_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtQUOTAS_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.QUOTAS_NUMBER;
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
    END fnuObtQUOTAS_NUMBER;
 
    -- Obtiene el valor de la columna QUOTA_VALUE
    FUNCTION fnuObtQUOTA_VALUE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.QUOTA_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtQUOTA_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.QUOTA_VALUE;
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
    END fnuObtQUOTA_VALUE;
 
    -- Obtiene el valor de la columna TAX_FINANCING_ONE
    FUNCTION fsbObtTAX_FINANCING_ONE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.TAX_FINANCING_ONE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTAX_FINANCING_ONE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TAX_FINANCING_ONE;
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
    END fsbObtTAX_FINANCING_ONE;
 
    -- Obtiene el valor de la columna VALUE_TO_FINANCE
    FUNCTION fnuObtVALUE_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.VALUE_TO_FINANCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVALUE_TO_FINANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALUE_TO_FINANCE;
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
    END fnuObtVALUE_TO_FINANCE;
 
    -- Obtiene el valor de la columna DOCUMENT_SUPPORT
    FUNCTION fsbObtDOCUMENT_SUPPORT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.DOCUMENT_SUPPORT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDOCUMENT_SUPPORT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DOCUMENT_SUPPORT;
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
    END fsbObtDOCUMENT_SUPPORT;
 
    -- Obtiene el valor de la columna WAIT_BY_SIGN
    FUNCTION fsbObtWAIT_BY_SIGN(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WAIT_BY_SIGN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtWAIT_BY_SIGN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WAIT_BY_SIGN;
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
    END fsbObtWAIT_BY_SIGN;
 
    -- Obtiene el valor de la columna WAIT_BY_PAYMENT
    FUNCTION fsbObtWAIT_BY_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WAIT_BY_PAYMENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtWAIT_BY_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WAIT_BY_PAYMENT;
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
    END fsbObtWAIT_BY_PAYMENT;
 
    -- Obtiene el valor de la columna COUPON_ID
    FUNCTION fnuObtCOUPON_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.COUPON_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOUPON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
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
 
    -- Obtiene el valor de la columna WARRANTY_DOCUMENT
    FUNCTION fnuObtWARRANTY_DOCUMENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.WARRANTY_DOCUMENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtWARRANTY_DOCUMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WARRANTY_DOCUMENT;
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
    END fnuObtWARRANTY_DOCUMENT;
 
    -- Obtiene el valor de la columna INIT_PAY_EXPIRATION
    FUNCTION fdtObtINIT_PAY_EXPIRATION(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INIT_PAY_EXPIRATION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtINIT_PAY_EXPIRATION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.INIT_PAY_EXPIRATION;
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
    END fdtObtINIT_PAY_EXPIRATION;
 
    -- Obtiene el valor de la columna INTEREST_PERCENT
    FUNCTION fnuObtINTEREST_PERCENT(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.INTEREST_PERCENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtINTEREST_PERCENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.INTEREST_PERCENT;
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
    END fnuObtINTEREST_PERCENT;
 
    -- Obtiene el valor de la columna SIGNED
    FUNCTION fsbObtSIGNED(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGNED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSIGNED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
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
 
    -- Obtiene el valor de la columna SIGNED_DATE
    FUNCTION fdtObtSIGNED_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGNED_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtSIGNED_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SIGNED_DATE;
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
    END fdtObtSIGNED_DATE;
 
    -- Obtiene el valor de la columna SUBSCRIPTION_ID
    FUNCTION fnuObtSUBSCRIPTION_ID(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SUBSCRIPTION_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSUBSCRIPTION_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SUBSCRIPTION_ID;
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
    END fnuObtSUBSCRIPTION_ID;
 
    -- Obtiene el valor de la columna SIGN_FUNCTIONARY
    FUNCTION fsbObtSIGN_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGN_FUNCTIONARY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSIGN_FUNCTIONARY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SIGN_FUNCTIONARY;
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
    END fsbObtSIGN_FUNCTIONARY;
 
    -- Obtiene el valor de la columna SIGN_TERMINAL
    FUNCTION fsbObtSIGN_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.SIGN_TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSIGN_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
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
 
    -- Obtiene el valor de la columna RECORD_FUNCTIONARY
    FUNCTION fsbObtRECORD_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_FUNCTIONARY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtRECORD_FUNCTIONARY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RECORD_FUNCTIONARY;
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
    END fsbObtRECORD_FUNCTIONARY;
 
    -- Obtiene el valor de la columna RECORD_DATE
    FUNCTION fdtObtRECORD_DATE(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtRECORD_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RECORD_DATE;
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
    END fdtObtRECORD_DATE;
 
    -- Obtiene el valor de la columna RECORD_TERMINAL
    FUNCTION fsbObtRECORD_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtRECORD_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RECORD_TERMINAL;
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
    END fsbObtRECORD_TERMINAL;
 
    -- Obtiene el valor de la columna RECORD_PROGRAM
    FUNCTION fsbObtRECORD_PROGRAM(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.RECORD_PROGRAM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtRECORD_PROGRAM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RECORD_PROGRAM;
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
    END fsbObtRECORD_PROGRAM;
 
    -- Obtiene el valor de la columna ONLY_EXPIRED_ACC
    FUNCTION fsbObtONLY_EXPIRED_ACC(
        inuFINANCING_REQUEST_ID    NUMBER
        ) RETURN CC_FINANCING_REQUEST.ONLY_EXPIRED_ACC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtONLY_EXPIRED_ACC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ONLY_EXPIRED_ACC;
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
    END fsbObtONLY_EXPIRED_ACC;
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuPACKAGE_ID,-1) <> NVL(rcRegistroAct.PACKAGE_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza el valor de la columna FINANCING_ID
    PROCEDURE prAcFINANCING_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuFINANCING_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFINANCING_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuFINANCING_ID,-1) <> NVL(rcRegistroAct.FINANCING_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FINANCING_ID=inuFINANCING_ID
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
    END prAcFINANCING_ID;
 
    -- Actualiza el valor de la columna REQUEST_TYPE
    PROCEDURE prAcREQUEST_TYPE(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbREQUEST_TYPE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUEST_TYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbREQUEST_TYPE,'-') <> NVL(rcRegistroAct.REQUEST_TYPE,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET REQUEST_TYPE=isbREQUEST_TYPE
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
    END prAcREQUEST_TYPE;
 
    -- Actualiza el valor de la columna FINANCING_PLAN_ID
    PROCEDURE prAcFINANCING_PLAN_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuFINANCING_PLAN_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFINANCING_PLAN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuFINANCING_PLAN_ID,-1) <> NVL(rcRegistroAct.FINANCING_PLAN_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FINANCING_PLAN_ID=inuFINANCING_PLAN_ID
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
    END prAcFINANCING_PLAN_ID;
 
    -- Actualiza el valor de la columna COMPUTE_METHOD_ID
    PROCEDURE prAcCOMPUTE_METHOD_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuCOMPUTE_METHOD_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPUTE_METHOD_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuCOMPUTE_METHOD_ID,-1) <> NVL(rcRegistroAct.COMPUTE_METHOD_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET COMPUTE_METHOD_ID=inuCOMPUTE_METHOD_ID
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
    END prAcCOMPUTE_METHOD_ID;
 
    -- Actualiza el valor de la columna INTEREST_RATE_ID
    PROCEDURE prAcINTEREST_RATE_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINTEREST_RATE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINTEREST_RATE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuINTEREST_RATE_ID,-1) <> NVL(rcRegistroAct.INTEREST_RATE_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INTEREST_RATE_ID=inuINTEREST_RATE_ID
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
    END prAcINTEREST_RATE_ID;
 
    -- Actualiza el valor de la columna FIRST_PAY_DATE
    PROCEDURE prAcFIRST_PAY_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtFIRST_PAY_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFIRST_PAY_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(idtFIRST_PAY_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FIRST_PAY_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FIRST_PAY_DATE=idtFIRST_PAY_DATE
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
    END prAcFIRST_PAY_DATE;
 
    -- Actualiza el valor de la columna INITIAL_PAYMENT
    PROCEDURE prAcINITIAL_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINITIAL_PAYMENT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINITIAL_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuINITIAL_PAYMENT,-1) <> NVL(rcRegistroAct.INITIAL_PAYMENT,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INITIAL_PAYMENT=inuINITIAL_PAYMENT
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
    END prAcINITIAL_PAYMENT;
 
    -- Actualiza el valor de la columna PERCENT_TO_FINANCE
    PROCEDURE prAcPERCENT_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuPERCENT_TO_FINANCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERCENT_TO_FINANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuPERCENT_TO_FINANCE,-1) <> NVL(rcRegistroAct.PERCENT_TO_FINANCE,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET PERCENT_TO_FINANCE=inuPERCENT_TO_FINANCE
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
    END prAcPERCENT_TO_FINANCE;
 
    -- Actualiza el valor de la columna SPREAD
    PROCEDURE prAcSPREAD(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuSPREAD    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSPREAD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuSPREAD,-1) <> NVL(rcRegistroAct.SPREAD,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SPREAD=inuSPREAD
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
    END prAcSPREAD;
 
    -- Actualiza el valor de la columna QUOTAS_NUMBER
    PROCEDURE prAcQUOTAS_NUMBER(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuQUOTAS_NUMBER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcQUOTAS_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuQUOTAS_NUMBER,-1) <> NVL(rcRegistroAct.QUOTAS_NUMBER,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET QUOTAS_NUMBER=inuQUOTAS_NUMBER
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
    END prAcQUOTAS_NUMBER;
 
    -- Actualiza el valor de la columna QUOTA_VALUE
    PROCEDURE prAcQUOTA_VALUE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuQUOTA_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcQUOTA_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuQUOTA_VALUE,-1) <> NVL(rcRegistroAct.QUOTA_VALUE,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET QUOTA_VALUE=inuQUOTA_VALUE
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
    END prAcQUOTA_VALUE;
 
    -- Actualiza el valor de la columna TAX_FINANCING_ONE
    PROCEDURE prAcTAX_FINANCING_ONE(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbTAX_FINANCING_ONE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAX_FINANCING_ONE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbTAX_FINANCING_ONE,'-') <> NVL(rcRegistroAct.TAX_FINANCING_ONE,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET TAX_FINANCING_ONE=isbTAX_FINANCING_ONE
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
    END prAcTAX_FINANCING_ONE;
 
    -- Actualiza el valor de la columna VALUE_TO_FINANCE
    PROCEDURE prAcVALUE_TO_FINANCE(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuVALUE_TO_FINANCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE_TO_FINANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuVALUE_TO_FINANCE,-1) <> NVL(rcRegistroAct.VALUE_TO_FINANCE,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET VALUE_TO_FINANCE=inuVALUE_TO_FINANCE
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
    END prAcVALUE_TO_FINANCE;
 
    -- Actualiza el valor de la columna DOCUMENT_SUPPORT
    PROCEDURE prAcDOCUMENT_SUPPORT(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbDOCUMENT_SUPPORT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDOCUMENT_SUPPORT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbDOCUMENT_SUPPORT,'-') <> NVL(rcRegistroAct.DOCUMENT_SUPPORT,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET DOCUMENT_SUPPORT=isbDOCUMENT_SUPPORT
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
    END prAcDOCUMENT_SUPPORT;
 
    -- Actualiza el valor de la columna WAIT_BY_SIGN
    PROCEDURE prAcWAIT_BY_SIGN(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbWAIT_BY_SIGN    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWAIT_BY_SIGN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbWAIT_BY_SIGN,'-') <> NVL(rcRegistroAct.WAIT_BY_SIGN,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET WAIT_BY_SIGN=isbWAIT_BY_SIGN
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
    END prAcWAIT_BY_SIGN;
 
    -- Actualiza el valor de la columna WAIT_BY_PAYMENT
    PROCEDURE prAcWAIT_BY_PAYMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbWAIT_BY_PAYMENT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWAIT_BY_PAYMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbWAIT_BY_PAYMENT,'-') <> NVL(rcRegistroAct.WAIT_BY_PAYMENT,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET WAIT_BY_PAYMENT=isbWAIT_BY_PAYMENT
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
    END prAcWAIT_BY_PAYMENT;
 
    -- Actualiza el valor de la columna COUPON_ID
    PROCEDURE prAcCOUPON_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuCOUPON_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOUPON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuCOUPON_ID,-1) <> NVL(rcRegistroAct.COUPON_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza el valor de la columna WARRANTY_DOCUMENT
    PROCEDURE prAcWARRANTY_DOCUMENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuWARRANTY_DOCUMENT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWARRANTY_DOCUMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuWARRANTY_DOCUMENT,-1) <> NVL(rcRegistroAct.WARRANTY_DOCUMENT,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET WARRANTY_DOCUMENT=inuWARRANTY_DOCUMENT
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
    END prAcWARRANTY_DOCUMENT;
 
    -- Actualiza el valor de la columna INIT_PAY_EXPIRATION
    PROCEDURE prAcINIT_PAY_EXPIRATION(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtINIT_PAY_EXPIRATION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINIT_PAY_EXPIRATION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(idtINIT_PAY_EXPIRATION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.INIT_PAY_EXPIRATION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INIT_PAY_EXPIRATION=idtINIT_PAY_EXPIRATION
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
    END prAcINIT_PAY_EXPIRATION;
 
    -- Actualiza el valor de la columna INTEREST_PERCENT
    PROCEDURE prAcINTEREST_PERCENT(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuINTEREST_PERCENT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINTEREST_PERCENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuINTEREST_PERCENT,-1) <> NVL(rcRegistroAct.INTEREST_PERCENT,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INTEREST_PERCENT=inuINTEREST_PERCENT
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
    END prAcINTEREST_PERCENT;
 
    -- Actualiza el valor de la columna SIGNED
    PROCEDURE prAcSIGNED(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGNED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGNED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbSIGNED,'-') <> NVL(rcRegistroAct.SIGNED,'-') THEN
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza el valor de la columna SIGNED_DATE
    PROCEDURE prAcSIGNED_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtSIGNED_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGNED_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(idtSIGNED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.SIGNED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SIGNED_DATE=idtSIGNED_DATE
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
    END prAcSIGNED_DATE;
 
    -- Actualiza el valor de la columna SUBSCRIPTION_ID
    PROCEDURE prAcSUBSCRIPTION_ID(
        inuFINANCING_REQUEST_ID    NUMBER,
        inuSUBSCRIPTION_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIPTION_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(inuSUBSCRIPTION_ID,-1) <> NVL(rcRegistroAct.SUBSCRIPTION_ID,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SUBSCRIPTION_ID=inuSUBSCRIPTION_ID
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
    END prAcSUBSCRIPTION_ID;
 
    -- Actualiza el valor de la columna SIGN_FUNCTIONARY
    PROCEDURE prAcSIGN_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGN_FUNCTIONARY    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_FUNCTIONARY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbSIGN_FUNCTIONARY,'-') <> NVL(rcRegistroAct.SIGN_FUNCTIONARY,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET SIGN_FUNCTIONARY=isbSIGN_FUNCTIONARY
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
    END prAcSIGN_FUNCTIONARY;
 
    -- Actualiza el valor de la columna SIGN_TERMINAL
    PROCEDURE prAcSIGN_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbSIGN_TERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbSIGN_TERMINAL,'-') <> NVL(rcRegistroAct.SIGN_TERMINAL,'-') THEN
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza el valor de la columna RECORD_FUNCTIONARY
    PROCEDURE prAcRECORD_FUNCTIONARY(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_FUNCTIONARY    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_FUNCTIONARY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbRECORD_FUNCTIONARY,'-') <> NVL(rcRegistroAct.RECORD_FUNCTIONARY,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_FUNCTIONARY=isbRECORD_FUNCTIONARY
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
    END prAcRECORD_FUNCTIONARY;
 
    -- Actualiza el valor de la columna RECORD_DATE
    PROCEDURE prAcRECORD_DATE(
        inuFINANCING_REQUEST_ID    NUMBER,
        idtRECORD_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(idtRECORD_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.RECORD_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_DATE=idtRECORD_DATE
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
    END prAcRECORD_DATE;
 
    -- Actualiza el valor de la columna RECORD_TERMINAL
    PROCEDURE prAcRECORD_TERMINAL(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_TERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_TERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbRECORD_TERMINAL,'-') <> NVL(rcRegistroAct.RECORD_TERMINAL,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_TERMINAL=isbRECORD_TERMINAL
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
    END prAcRECORD_TERMINAL;
 
    -- Actualiza el valor de la columna RECORD_PROGRAM
    PROCEDURE prAcRECORD_PROGRAM(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbRECORD_PROGRAM    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_PROGRAM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbRECORD_PROGRAM,'-') <> NVL(rcRegistroAct.RECORD_PROGRAM,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_PROGRAM=isbRECORD_PROGRAM
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
    END prAcRECORD_PROGRAM;
 
    -- Actualiza el valor de la columna ONLY_EXPIRED_ACC
    PROCEDURE prAcONLY_EXPIRED_ACC(
        inuFINANCING_REQUEST_ID    NUMBER,
        isbONLY_EXPIRED_ACC    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcONLY_EXPIRED_ACC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFINANCING_REQUEST_ID,TRUE);
        IF NVL(isbONLY_EXPIRED_ACC,'-') <> NVL(rcRegistroAct.ONLY_EXPIRED_ACC,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET ONLY_EXPIRED_ACC=isbONLY_EXPIRED_ACC
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
    END prAcONLY_EXPIRED_ACC;
 
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
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza por RowId el valor de la columna FINANCING_ID
    PROCEDURE prAcFINANCING_ID_RId(
        iRowId ROWID,
        inuFINANCING_ID_O    NUMBER,
        inuFINANCING_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFINANCING_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuFINANCING_ID_O,-1) <> NVL(inuFINANCING_ID_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FINANCING_ID=inuFINANCING_ID_N
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
    END prAcFINANCING_ID_RId;
 
    -- Actualiza por RowId el valor de la columna REQUEST_TYPE
    PROCEDURE prAcREQUEST_TYPE_RId(
        iRowId ROWID,
        isbREQUEST_TYPE_O    VARCHAR2,
        isbREQUEST_TYPE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUEST_TYPE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbREQUEST_TYPE_O,'-') <> NVL(isbREQUEST_TYPE_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET REQUEST_TYPE=isbREQUEST_TYPE_N
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
    END prAcREQUEST_TYPE_RId;
 
    -- Actualiza por RowId el valor de la columna FINANCING_PLAN_ID
    PROCEDURE prAcFINANCING_PLAN_ID_RId(
        iRowId ROWID,
        inuFINANCING_PLAN_ID_O    NUMBER,
        inuFINANCING_PLAN_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFINANCING_PLAN_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuFINANCING_PLAN_ID_O,-1) <> NVL(inuFINANCING_PLAN_ID_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FINANCING_PLAN_ID=inuFINANCING_PLAN_ID_N
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
    END prAcFINANCING_PLAN_ID_RId;
 
    -- Actualiza por RowId el valor de la columna COMPUTE_METHOD_ID
    PROCEDURE prAcCOMPUTE_METHOD_ID_RId(
        iRowId ROWID,
        inuCOMPUTE_METHOD_ID_O    NUMBER,
        inuCOMPUTE_METHOD_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPUTE_METHOD_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOMPUTE_METHOD_ID_O,-1) <> NVL(inuCOMPUTE_METHOD_ID_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET COMPUTE_METHOD_ID=inuCOMPUTE_METHOD_ID_N
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
    END prAcCOMPUTE_METHOD_ID_RId;
 
    -- Actualiza por RowId el valor de la columna INTEREST_RATE_ID
    PROCEDURE prAcINTEREST_RATE_ID_RId(
        iRowId ROWID,
        inuINTEREST_RATE_ID_O    NUMBER,
        inuINTEREST_RATE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINTEREST_RATE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuINTEREST_RATE_ID_O,-1) <> NVL(inuINTEREST_RATE_ID_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INTEREST_RATE_ID=inuINTEREST_RATE_ID_N
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
    END prAcINTEREST_RATE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna FIRST_PAY_DATE
    PROCEDURE prAcFIRST_PAY_DATE_RId(
        iRowId ROWID,
        idtFIRST_PAY_DATE_O    DATE,
        idtFIRST_PAY_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFIRST_PAY_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFIRST_PAY_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFIRST_PAY_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET FIRST_PAY_DATE=idtFIRST_PAY_DATE_N
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
    END prAcFIRST_PAY_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna INITIAL_PAYMENT
    PROCEDURE prAcINITIAL_PAYMENT_RId(
        iRowId ROWID,
        inuINITIAL_PAYMENT_O    NUMBER,
        inuINITIAL_PAYMENT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINITIAL_PAYMENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuINITIAL_PAYMENT_O,-1) <> NVL(inuINITIAL_PAYMENT_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INITIAL_PAYMENT=inuINITIAL_PAYMENT_N
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
    END prAcINITIAL_PAYMENT_RId;
 
    -- Actualiza por RowId el valor de la columna PERCENT_TO_FINANCE
    PROCEDURE prAcPERCENT_TO_FINANCE_RId(
        iRowId ROWID,
        inuPERCENT_TO_FINANCE_O    NUMBER,
        inuPERCENT_TO_FINANCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERCENT_TO_FINANCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPERCENT_TO_FINANCE_O,-1) <> NVL(inuPERCENT_TO_FINANCE_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET PERCENT_TO_FINANCE=inuPERCENT_TO_FINANCE_N
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
    END prAcPERCENT_TO_FINANCE_RId;
 
    -- Actualiza por RowId el valor de la columna SPREAD
    PROCEDURE prAcSPREAD_RId(
        iRowId ROWID,
        inuSPREAD_O    NUMBER,
        inuSPREAD_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSPREAD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSPREAD_O,-1) <> NVL(inuSPREAD_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SPREAD=inuSPREAD_N
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
    END prAcSPREAD_RId;
 
    -- Actualiza por RowId el valor de la columna QUOTAS_NUMBER
    PROCEDURE prAcQUOTAS_NUMBER_RId(
        iRowId ROWID,
        inuQUOTAS_NUMBER_O    NUMBER,
        inuQUOTAS_NUMBER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcQUOTAS_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuQUOTAS_NUMBER_O,-1) <> NVL(inuQUOTAS_NUMBER_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET QUOTAS_NUMBER=inuQUOTAS_NUMBER_N
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
    END prAcQUOTAS_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna QUOTA_VALUE
    PROCEDURE prAcQUOTA_VALUE_RId(
        iRowId ROWID,
        inuQUOTA_VALUE_O    NUMBER,
        inuQUOTA_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcQUOTA_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuQUOTA_VALUE_O,-1) <> NVL(inuQUOTA_VALUE_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET QUOTA_VALUE=inuQUOTA_VALUE_N
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
    END prAcQUOTA_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna TAX_FINANCING_ONE
    PROCEDURE prAcTAX_FINANCING_ONE_RId(
        iRowId ROWID,
        isbTAX_FINANCING_ONE_O    VARCHAR2,
        isbTAX_FINANCING_ONE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAX_FINANCING_ONE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTAX_FINANCING_ONE_O,'-') <> NVL(isbTAX_FINANCING_ONE_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET TAX_FINANCING_ONE=isbTAX_FINANCING_ONE_N
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
    END prAcTAX_FINANCING_ONE_RId;
 
    -- Actualiza por RowId el valor de la columna VALUE_TO_FINANCE
    PROCEDURE prAcVALUE_TO_FINANCE_RId(
        iRowId ROWID,
        inuVALUE_TO_FINANCE_O    NUMBER,
        inuVALUE_TO_FINANCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE_TO_FINANCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALUE_TO_FINANCE_O,-1) <> NVL(inuVALUE_TO_FINANCE_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET VALUE_TO_FINANCE=inuVALUE_TO_FINANCE_N
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
    END prAcVALUE_TO_FINANCE_RId;
 
    -- Actualiza por RowId el valor de la columna DOCUMENT_SUPPORT
    PROCEDURE prAcDOCUMENT_SUPPORT_RId(
        iRowId ROWID,
        isbDOCUMENT_SUPPORT_O    VARCHAR2,
        isbDOCUMENT_SUPPORT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDOCUMENT_SUPPORT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbDOCUMENT_SUPPORT_O,'-') <> NVL(isbDOCUMENT_SUPPORT_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET DOCUMENT_SUPPORT=isbDOCUMENT_SUPPORT_N
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
    END prAcDOCUMENT_SUPPORT_RId;
 
    -- Actualiza por RowId el valor de la columna WAIT_BY_SIGN
    PROCEDURE prAcWAIT_BY_SIGN_RId(
        iRowId ROWID,
        isbWAIT_BY_SIGN_O    VARCHAR2,
        isbWAIT_BY_SIGN_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWAIT_BY_SIGN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbWAIT_BY_SIGN_O,'-') <> NVL(isbWAIT_BY_SIGN_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET WAIT_BY_SIGN=isbWAIT_BY_SIGN_N
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
    END prAcWAIT_BY_SIGN_RId;
 
    -- Actualiza por RowId el valor de la columna WAIT_BY_PAYMENT
    PROCEDURE prAcWAIT_BY_PAYMENT_RId(
        iRowId ROWID,
        isbWAIT_BY_PAYMENT_O    VARCHAR2,
        isbWAIT_BY_PAYMENT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWAIT_BY_PAYMENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbWAIT_BY_PAYMENT_O,'-') <> NVL(isbWAIT_BY_PAYMENT_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET WAIT_BY_PAYMENT=isbWAIT_BY_PAYMENT_N
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
    END prAcWAIT_BY_PAYMENT_RId;
 
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
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza por RowId el valor de la columna WARRANTY_DOCUMENT
    PROCEDURE prAcWARRANTY_DOCUMENT_RId(
        iRowId ROWID,
        inuWARRANTY_DOCUMENT_O    NUMBER,
        inuWARRANTY_DOCUMENT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWARRANTY_DOCUMENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuWARRANTY_DOCUMENT_O,-1) <> NVL(inuWARRANTY_DOCUMENT_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET WARRANTY_DOCUMENT=inuWARRANTY_DOCUMENT_N
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
    END prAcWARRANTY_DOCUMENT_RId;
 
    -- Actualiza por RowId el valor de la columna INIT_PAY_EXPIRATION
    PROCEDURE prAcINIT_PAY_EXPIRATION_RId(
        iRowId ROWID,
        idtINIT_PAY_EXPIRATION_O    DATE,
        idtINIT_PAY_EXPIRATION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINIT_PAY_EXPIRATION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtINIT_PAY_EXPIRATION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtINIT_PAY_EXPIRATION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INIT_PAY_EXPIRATION=idtINIT_PAY_EXPIRATION_N
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
    END prAcINIT_PAY_EXPIRATION_RId;
 
    -- Actualiza por RowId el valor de la columna INTEREST_PERCENT
    PROCEDURE prAcINTEREST_PERCENT_RId(
        iRowId ROWID,
        inuINTEREST_PERCENT_O    NUMBER,
        inuINTEREST_PERCENT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcINTEREST_PERCENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuINTEREST_PERCENT_O,-1) <> NVL(inuINTEREST_PERCENT_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET INTEREST_PERCENT=inuINTEREST_PERCENT_N
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
    END prAcINTEREST_PERCENT_RId;
 
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
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza por RowId el valor de la columna SIGNED_DATE
    PROCEDURE prAcSIGNED_DATE_RId(
        iRowId ROWID,
        idtSIGNED_DATE_O    DATE,
        idtSIGNED_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGNED_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtSIGNED_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtSIGNED_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SIGNED_DATE=idtSIGNED_DATE_N
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
    END prAcSIGNED_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna SUBSCRIPTION_ID
    PROCEDURE prAcSUBSCRIPTION_ID_RId(
        iRowId ROWID,
        inuSUBSCRIPTION_ID_O    NUMBER,
        inuSUBSCRIPTION_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIPTION_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSUBSCRIPTION_ID_O,-1) <> NVL(inuSUBSCRIPTION_ID_N,-1) THEN
            UPDATE CC_FINANCING_REQUEST
            SET SUBSCRIPTION_ID=inuSUBSCRIPTION_ID_N
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
    END prAcSUBSCRIPTION_ID_RId;
 
    -- Actualiza por RowId el valor de la columna SIGN_FUNCTIONARY
    PROCEDURE prAcSIGN_FUNCTIONARY_RId(
        iRowId ROWID,
        isbSIGN_FUNCTIONARY_O    VARCHAR2,
        isbSIGN_FUNCTIONARY_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSIGN_FUNCTIONARY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSIGN_FUNCTIONARY_O,'-') <> NVL(isbSIGN_FUNCTIONARY_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET SIGN_FUNCTIONARY=isbSIGN_FUNCTIONARY_N
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
    END prAcSIGN_FUNCTIONARY_RId;
 
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
            UPDATE CC_FINANCING_REQUEST
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
 
    -- Actualiza por RowId el valor de la columna RECORD_FUNCTIONARY
    PROCEDURE prAcRECORD_FUNCTIONARY_RId(
        iRowId ROWID,
        isbRECORD_FUNCTIONARY_O    VARCHAR2,
        isbRECORD_FUNCTIONARY_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_FUNCTIONARY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbRECORD_FUNCTIONARY_O,'-') <> NVL(isbRECORD_FUNCTIONARY_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_FUNCTIONARY=isbRECORD_FUNCTIONARY_N
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
    END prAcRECORD_FUNCTIONARY_RId;
 
    -- Actualiza por RowId el valor de la columna RECORD_DATE
    PROCEDURE prAcRECORD_DATE_RId(
        iRowId ROWID,
        idtRECORD_DATE_O    DATE,
        idtRECORD_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtRECORD_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtRECORD_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_DATE=idtRECORD_DATE_N
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
    END prAcRECORD_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna RECORD_TERMINAL
    PROCEDURE prAcRECORD_TERMINAL_RId(
        iRowId ROWID,
        isbRECORD_TERMINAL_O    VARCHAR2,
        isbRECORD_TERMINAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_TERMINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbRECORD_TERMINAL_O,'-') <> NVL(isbRECORD_TERMINAL_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_TERMINAL=isbRECORD_TERMINAL_N
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
    END prAcRECORD_TERMINAL_RId;
 
    -- Actualiza por RowId el valor de la columna RECORD_PROGRAM
    PROCEDURE prAcRECORD_PROGRAM_RId(
        iRowId ROWID,
        isbRECORD_PROGRAM_O    VARCHAR2,
        isbRECORD_PROGRAM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECORD_PROGRAM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbRECORD_PROGRAM_O,'-') <> NVL(isbRECORD_PROGRAM_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET RECORD_PROGRAM=isbRECORD_PROGRAM_N
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
    END prAcRECORD_PROGRAM_RId;
 
    -- Actualiza por RowId el valor de la columna ONLY_EXPIRED_ACC
    PROCEDURE prAcONLY_EXPIRED_ACC_RId(
        iRowId ROWID,
        isbONLY_EXPIRED_ACC_O    VARCHAR2,
        isbONLY_EXPIRED_ACC_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcONLY_EXPIRED_ACC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbONLY_EXPIRED_ACC_O,'-') <> NVL(isbONLY_EXPIRED_ACC_N,'-') THEN
            UPDATE CC_FINANCING_REQUEST
            SET ONLY_EXPIRED_ACC=isbONLY_EXPIRED_ACC_N
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
    END prAcONLY_EXPIRED_ACC_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuCC_FINANCING_REQUEST%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.FINANCING_REQUEST_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPACKAGE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PACKAGE_ID,
                ircRegistro.PACKAGE_ID
            );
 
            prAcFINANCING_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FINANCING_ID,
                ircRegistro.FINANCING_ID
            );
 
            prAcREQUEST_TYPE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REQUEST_TYPE,
                ircRegistro.REQUEST_TYPE
            );
 
            prAcFINANCING_PLAN_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FINANCING_PLAN_ID,
                ircRegistro.FINANCING_PLAN_ID
            );
 
            prAcCOMPUTE_METHOD_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPUTE_METHOD_ID,
                ircRegistro.COMPUTE_METHOD_ID
            );
 
            prAcINTEREST_RATE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.INTEREST_RATE_ID,
                ircRegistro.INTEREST_RATE_ID
            );
 
            prAcFIRST_PAY_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FIRST_PAY_DATE,
                ircRegistro.FIRST_PAY_DATE
            );
 
            prAcINITIAL_PAYMENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.INITIAL_PAYMENT,
                ircRegistro.INITIAL_PAYMENT
            );
 
            prAcPERCENT_TO_FINANCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PERCENT_TO_FINANCE,
                ircRegistro.PERCENT_TO_FINANCE
            );
 
            prAcSPREAD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SPREAD,
                ircRegistro.SPREAD
            );
 
            prAcQUOTAS_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.QUOTAS_NUMBER,
                ircRegistro.QUOTAS_NUMBER
            );
 
            prAcQUOTA_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.QUOTA_VALUE,
                ircRegistro.QUOTA_VALUE
            );
 
            prAcTAX_FINANCING_ONE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TAX_FINANCING_ONE,
                ircRegistro.TAX_FINANCING_ONE
            );
 
            prAcVALUE_TO_FINANCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE_TO_FINANCE,
                ircRegistro.VALUE_TO_FINANCE
            );
 
            prAcDOCUMENT_SUPPORT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DOCUMENT_SUPPORT,
                ircRegistro.DOCUMENT_SUPPORT
            );
 
            prAcWAIT_BY_SIGN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WAIT_BY_SIGN,
                ircRegistro.WAIT_BY_SIGN
            );
 
            prAcWAIT_BY_PAYMENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WAIT_BY_PAYMENT,
                ircRegistro.WAIT_BY_PAYMENT
            );
 
            prAcCOUPON_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COUPON_ID,
                ircRegistro.COUPON_ID
            );
 
            prAcWARRANTY_DOCUMENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WARRANTY_DOCUMENT,
                ircRegistro.WARRANTY_DOCUMENT
            );
 
            prAcINIT_PAY_EXPIRATION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.INIT_PAY_EXPIRATION,
                ircRegistro.INIT_PAY_EXPIRATION
            );
 
            prAcINTEREST_PERCENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.INTEREST_PERCENT,
                ircRegistro.INTEREST_PERCENT
            );
 
            prAcSIGNED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGNED,
                ircRegistro.SIGNED
            );
 
            prAcSIGNED_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGNED_DATE,
                ircRegistro.SIGNED_DATE
            );
 
            prAcSUBSCRIPTION_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBSCRIPTION_ID,
                ircRegistro.SUBSCRIPTION_ID
            );
 
            prAcSIGN_FUNCTIONARY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGN_FUNCTIONARY,
                ircRegistro.SIGN_FUNCTIONARY
            );
 
            prAcSIGN_TERMINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SIGN_TERMINAL,
                ircRegistro.SIGN_TERMINAL
            );
 
            prAcRECORD_FUNCTIONARY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RECORD_FUNCTIONARY,
                ircRegistro.RECORD_FUNCTIONARY
            );
 
            prAcRECORD_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RECORD_DATE,
                ircRegistro.RECORD_DATE
            );
 
            prAcRECORD_TERMINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RECORD_TERMINAL,
                ircRegistro.RECORD_TERMINAL
            );
 
            prAcRECORD_PROGRAM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RECORD_PROGRAM,
                ircRegistro.RECORD_PROGRAM
            );
 
            prAcONLY_EXPIRED_ACC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ONLY_EXPIRED_ACC,
                ircRegistro.ONLY_EXPIRED_ACC
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
 
END pkg_CC_FINANCING_REQUEST;
/
BEGIN
    -- OSF-XXXX
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_CC_FINANCING_REQUEST'), UPPER('adm_person'));
END;
/
