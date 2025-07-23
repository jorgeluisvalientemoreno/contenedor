CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_LOGERRLEGSERVNUEV AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_LOGERRLEGSERVNUEV%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_LOGERRLEGSERVNUEV IS SELECT * FROM LDC_LOGERRLEGSERVNUEV;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_LOGERRLEGSERVNUEV
        Caso  : OSF-3828
        Fecha : 08/01/2025 14:03:04
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_LOGERRLEGSERVNUEV tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        PROCESO = isbPROCESO AND
        FECHGENE = FECHGENE;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_LOGERRLEGSERVNUEV tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        PROCESO = isbPROCESO AND
        FECHGENE = FECHGENE
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    );
 
    -- Inserta un registro con transaccion autonoma
    PROCEDURE prinsRegistro( ircRegistro cuLDC_LOGERRLEGSERVNUEV%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ORDEPADRE
    FUNCTION fnuObtORDEPADRE(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.ORDEPADRE%TYPE;
 
    -- Obtiene el valor de la columna MENSERROR
    FUNCTION fsbObtMENSERROR(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.MENSERROR%TYPE;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.USUARIO%TYPE;
 
    -- Actualiza el valor de la columna ORDEPADRE
    PROCEDURE prAcORDEPADRE(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        inuORDEPADRE    NUMBER
    );
 
    -- Actualiza el valor de la columna MENSERROR
    PROCEDURE prAcMENSERROR(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        isbMENSERROR    VARCHAR2
    );
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        isbUSUARIO    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_LOGERRLEGSERVNUEV%ROWTYPE);
    
    -- Inserta un registro 
    PROCEDURE prInsRegistro
    ( 
        inuOrden            NUMBER,
        inuOrdenPadre       NUMBER,
        isbProceso          VARCHAR2,
        isbMensaje          VARCHAR2,
        idtFechaRegistro    DATE,
        isbUsuario          VARCHAR2
    );
 
END pkg_LDC_LOGERRLEGSERVNUEV;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_LOGERRLEGSERVNUEV AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID,isbPROCESO,FECHGENE);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE);
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
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE);
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
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID,isbPROCESO,FECHGENE) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||','||isbPROCESO||','||FECHGENE||'] en la tabla[LDC_LOGERRLEGSERVNUEV]');
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
 
    -- Inserta un registro con transaccion autonoma
    PROCEDURE prInsRegistro( ircRegistro cuLDC_LOGERRLEGSERVNUEV%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        PRAGMA           AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_LOGERRLEGSERVNUEV(
            ORDER_ID,ORDEPADRE,PROCESO,MENSERROR,FECHGENE,USUARIO
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.ORDEPADRE,ircRegistro.PROCESO,ircRegistro.MENSERROR,ircRegistro.FECHGENE,ircRegistro.USUARIO
        );
        COMMIT;
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
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_LOGERRLEGSERVNUEV
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
            DELETE LDC_LOGERRLEGSERVNUEV
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
 
    -- Obtiene el valor de la columna ORDEPADRE
    FUNCTION fnuObtORDEPADRE(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.ORDEPADRE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDEPADRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDEPADRE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtORDEPADRE;
 
    -- Obtiene el valor de la columna MENSERROR
    FUNCTION fsbObtMENSERROR(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.MENSERROR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtMENSERROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MENSERROR;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtMENSERROR;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE
        ) RETURN LDC_LOGERRLEGSERVNUEV.USUARIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE);
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
 
    -- Actualiza el valor de la columna ORDEPADRE
    PROCEDURE prAcORDEPADRE(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        inuORDEPADRE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDEPADRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE,TRUE);
        IF NVL(inuORDEPADRE,-1) <> NVL(rcRegistroAct.ORDEPADRE,-1) THEN
            UPDATE LDC_LOGERRLEGSERVNUEV
            SET ORDEPADRE=inuORDEPADRE
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
    END prAcORDEPADRE;
 
    -- Actualiza el valor de la columna MENSERROR
    PROCEDURE prAcMENSERROR(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        isbMENSERROR    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMENSERROR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE,TRUE);
        IF NVL(isbMENSERROR,'-') <> NVL(rcRegistroAct.MENSERROR,'-') THEN
            UPDATE LDC_LOGERRLEGSERVNUEV
            SET MENSERROR=isbMENSERROR
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
    END prAcMENSERROR;
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuORDER_ID    NUMBER,isbPROCESO    VARCHAR2,FECHGENE    DATE,
        isbUSUARIO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,isbPROCESO,FECHGENE,TRUE);
        IF NVL(isbUSUARIO,'-') <> NVL(rcRegistroAct.USUARIO,'-') THEN
            UPDATE LDC_LOGERRLEGSERVNUEV
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
 
    -- Actualiza por RowId el valor de la columna ORDEPADRE
    PROCEDURE prAcORDEPADRE_RId(
        iRowId ROWID,
        inuORDEPADRE_O    NUMBER,
        inuORDEPADRE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDEPADRE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDEPADRE_O,-1) <> NVL(inuORDEPADRE_N,-1) THEN
            UPDATE LDC_LOGERRLEGSERVNUEV
            SET ORDEPADRE=inuORDEPADRE_N
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
    END prAcORDEPADRE_RId;
 
    -- Actualiza por RowId el valor de la columna MENSERROR
    PROCEDURE prAcMENSERROR_RId(
        iRowId ROWID,
        isbMENSERROR_O    VARCHAR2,
        isbMENSERROR_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMENSERROR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbMENSERROR_O,'-') <> NVL(isbMENSERROR_N,'-') THEN
            UPDATE LDC_LOGERRLEGSERVNUEV
            SET MENSERROR=isbMENSERROR_N
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
    END prAcMENSERROR_RId;
 
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
            UPDATE LDC_LOGERRLEGSERVNUEV
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
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_LOGERRLEGSERVNUEV%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,ircRegistro.PROCESO,ircRegistro.FECHGENE,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcORDEPADRE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDEPADRE,
                ircRegistro.ORDEPADRE
            );
 
            prAcMENSERROR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MENSERROR,
                ircRegistro.MENSERROR
            );
 
            prAcUSUARIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USUARIO,
                ircRegistro.USUARIO
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
    
    -- Inserta un registro 
    PROCEDURE prInsRegistro
    ( 
        inuOrden            NUMBER,
        inuOrdenPadre       NUMBER,
        isbProceso          VARCHAR2,
        isbMensaje          VARCHAR2,
        idtFechaRegistro    DATE,
        isbUsuario          VARCHAR2
    ) 
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcLDC_LOGERRLEGSERVNUEV cuLDC_LOGERRLEGSERVNUEV%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        rcLDC_LOGERRLEGSERVNUEV.ORDER_ID    :=  inuOrden;
        rcLDC_LOGERRLEGSERVNUEV.ORDEPADRE   :=  inuOrdenPadre;
        rcLDC_LOGERRLEGSERVNUEV.PROCESO     :=  isbProceso;
        rcLDC_LOGERRLEGSERVNUEV.MENSERROR   :=  isbMensaje;
        rcLDC_LOGERRLEGSERVNUEV.FECHGENE    :=  idtFechaRegistro;
        rcLDC_LOGERRLEGSERVNUEV.USUARIO     :=  isbUsuario;
                                
        -- Llama al programa con transacción autónoma
        prInsRegistro( rcLDC_LOGERRLEGSERVNUEV );

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
END pkg_LDC_LOGERRLEGSERVNUEV;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_LOGERRLEGSERVNUEV'), UPPER('adm_person'));
END;
/

