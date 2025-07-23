CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_LDC_DOCUORDER AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_DOCUORDER%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_DOCUORDER IS SELECT * FROM LDC_DOCUORDER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : PKG_LDC_DOCUORDER
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_DOCUORDER
        Caso  : OSF-3576
        Fecha : 12/11/2024 10:49:37
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_DOCUORDER tb
        WHERE
        ORDER_ID = inuORDER_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_DOCUORDER tb
        WHERE
        ORDER_ID = inuORDER_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_DOCUORDER%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna STATUS_DOCU
    FUNCTION fsbObtSTATUS_DOCU(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.STATUS_DOCU%TYPE;
 
    -- Obtiene el valor de la columna LEGALIZATION_DATE
    FUNCTION fdtObtLEGALIZATION_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.LEGALIZATION_DATE%TYPE;
 
    -- Obtiene el valor de la columna RECEPTION_DATE
    FUNCTION fdtObtRECEPTION_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.RECEPTION_DATE%TYPE;
 
    -- Obtiene el valor de la columna FILE_DATE
    FUNCTION fdtObtFILE_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.FILE_DATE%TYPE;
 
    -- Actualiza el valor de la columna STATUS_DOCU
    PROCEDURE prAcSTATUS_DOCU(
        inuORDER_ID    NUMBER,
        isbSTATUS_DOCU    VARCHAR2
    );
 
    -- Actualiza el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE(
        inuORDER_ID    NUMBER,
        idtLEGALIZATION_DATE    DATE
    );
 
    -- Actualiza el valor de la columna RECEPTION_DATE
    PROCEDURE prAcRECEPTION_DATE(
        inuORDER_ID    NUMBER,
        idtRECEPTION_DATE    DATE
    );
 
    -- Actualiza el valor de la columna FILE_DATE
    PROCEDURE prAcFILE_DATE(
        inuORDER_ID    NUMBER,
        idtFILE_DATE    DATE
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_DOCUORDER%ROWTYPE);
    
    
    PROCEDURE prActEstado(inuORDER_ID   NUMBER,
                        isbSTATUS_DOCU  VARCHAR2,
                        idtFILE_DATE    DATE);
END pkg_LDC_DOCUORDER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_LDC_DOCUORDER AS
    csbSP_NAME		 CONSTANT VARCHAR2(35)  := $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID);
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
        inuORDER_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID);
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
        inuORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||'] en la tabla[LDC_DOCUORDER]');
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
    PROCEDURE prInsRegistro( ircRegistro cuLDC_DOCUORDER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_DOCUORDER(
            ORDER_ID,STATUS_DOCU,LEGALIZATION_DATE,RECEPTION_DATE,FILE_DATE
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.STATUS_DOCU,ircRegistro.LEGALIZATION_DATE,ircRegistro.RECEPTION_DATE,ircRegistro.FILE_DATE
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
        inuORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_DOCUORDER
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
            DELETE LDC_DOCUORDER
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
 
    -- Obtiene el valor de la columna STATUS_DOCU
    FUNCTION fsbObtSTATUS_DOCU(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.STATUS_DOCU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSTATUS_DOCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.STATUS_DOCU;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSTATUS_DOCU;
 
    -- Obtiene el valor de la columna LEGALIZATION_DATE
    FUNCTION fdtObtLEGALIZATION_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.LEGALIZATION_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtLEGALIZATION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LEGALIZATION_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtLEGALIZATION_DATE;
 
    -- Obtiene el valor de la columna RECEPTION_DATE
    FUNCTION fdtObtRECEPTION_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.RECEPTION_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtRECEPTION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RECEPTION_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtRECEPTION_DATE;
 
    -- Obtiene el valor de la columna FILE_DATE
    FUNCTION fdtObtFILE_DATE(
        inuORDER_ID    NUMBER
        ) RETURN LDC_DOCUORDER.FILE_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFILE_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FILE_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFILE_DATE;
 
    -- Actualiza el valor de la columna STATUS_DOCU
    PROCEDURE prAcSTATUS_DOCU(
        inuORDER_ID    NUMBER,
        isbSTATUS_DOCU    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTATUS_DOCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbSTATUS_DOCU,'-') <> NVL(rcRegistroAct.STATUS_DOCU,'-') THEN
            UPDATE LDC_DOCUORDER
            SET STATUS_DOCU=isbSTATUS_DOCU
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
    END prAcSTATUS_DOCU;
 
    -- Actualiza el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE(
        inuORDER_ID    NUMBER,
        idtLEGALIZATION_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZATION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtLEGALIZATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.LEGALIZATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET LEGALIZATION_DATE=idtLEGALIZATION_DATE
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
    END prAcLEGALIZATION_DATE;
 
    -- Actualiza el valor de la columna RECEPTION_DATE
    PROCEDURE prAcRECEPTION_DATE(
        inuORDER_ID    NUMBER,
        idtRECEPTION_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECEPTION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtRECEPTION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.RECEPTION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET RECEPTION_DATE=idtRECEPTION_DATE
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
    END prAcRECEPTION_DATE;
 
    -- Actualiza el valor de la columna FILE_DATE
    PROCEDURE prAcFILE_DATE(
        inuORDER_ID    NUMBER,
        idtFILE_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFILE_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtFILE_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FILE_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET FILE_DATE=idtFILE_DATE
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
    END prAcFILE_DATE;
 
    -- Actualiza por RowId el valor de la columna STATUS_DOCU
    PROCEDURE prAcSTATUS_DOCU_RId(
        iRowId ROWID,
        isbSTATUS_DOCU_O    VARCHAR2,
        isbSTATUS_DOCU_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTATUS_DOCU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSTATUS_DOCU_O,'-') <> NVL(isbSTATUS_DOCU_N,'-') THEN
            UPDATE LDC_DOCUORDER
            SET STATUS_DOCU=isbSTATUS_DOCU_N
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
    END prAcSTATUS_DOCU_RId;
 
    -- Actualiza por RowId el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE_RId(
        iRowId ROWID,
        idtLEGALIZATION_DATE_O    DATE,
        idtLEGALIZATION_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZATION_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtLEGALIZATION_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtLEGALIZATION_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET LEGALIZATION_DATE=idtLEGALIZATION_DATE_N
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
    END prAcLEGALIZATION_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna RECEPTION_DATE
    PROCEDURE prAcRECEPTION_DATE_RId(
        iRowId ROWID,
        idtRECEPTION_DATE_O    DATE,
        idtRECEPTION_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRECEPTION_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtRECEPTION_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtRECEPTION_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET RECEPTION_DATE=idtRECEPTION_DATE_N
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
    END prAcRECEPTION_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna FILE_DATE
    PROCEDURE prAcFILE_DATE_RId(
        iRowId ROWID,
        idtFILE_DATE_O    DATE,
        idtFILE_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFILE_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFILE_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFILE_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_DOCUORDER
            SET FILE_DATE=idtFILE_DATE_N
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
    END prAcFILE_DATE_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_DOCUORDER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcSTATUS_DOCU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.STATUS_DOCU,
                ircRegistro.STATUS_DOCU
            );
 
            prAcLEGALIZATION_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGALIZATION_DATE,
                ircRegistro.LEGALIZATION_DATE
            );
 
            prAcRECEPTION_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RECEPTION_DATE,
                ircRegistro.RECEPTION_DATE
            );
 
            prAcFILE_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FILE_DATE,
                ircRegistro.FILE_DATE
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

    PROCEDURE prActEstado(inuORDER_ID   NUMBER,
                        isbSTATUS_DOCU  VARCHAR2,
                        idtFILE_DATE    DATE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActEstado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
            UPDATE LDC_DOCUORDER
            SET STATUS_DOCU = isbSTATUS_DOCU,
                FILE_DATE   = idtFILE_DATE
            WHERE ORDER_ID  = inuORDER_ID;
       
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
    END prActEstado;    
 
END PKG_LDC_DOCUORDER;
/
BEGIN
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_DOCUORDER'), UPPER('adm_person'));
END;
/
