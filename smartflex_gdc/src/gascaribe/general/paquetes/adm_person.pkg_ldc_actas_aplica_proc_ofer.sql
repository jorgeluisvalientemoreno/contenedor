CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_ACTAS_APLICA_PROC_OFER AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : LDC_ACTAS_APLICA_PROC_OFERT
        Caso  : OSF-2204
        Fecha : 12/07/2024 08:02:38
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ACTAS_APLICA_PROC_OFERT tb
        WHERE
        ACTA = inuACTA AND
        PROCEJEC = isbPROCEJEC;
     
    CURSOR cuRegistroRIdLock
    (
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ACTAS_APLICA_PROC_OFERT tb
        WHERE
        ACTA = inuACTA AND
        PROCEJEC = isbPROCEJEC
        FOR UPDATE NOWAIT;
     
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds;
    FUNCTION ftbObtRegistrosxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRegistros;
    FUNCTION frcObtRegistroRId(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    FUNCTION fblExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    ) RETURN BOOLEAN;
 
    PROCEDURE prValExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    );
 
    PROCEDURE prinsRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE, oRowId OUT ROWID);
 
    PROCEDURE prBorRegistro(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    );
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    );
 
    FUNCTION fnuObtNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.NOVGENERA%TYPE;
 
    FUNCTION fnuObtTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.TOTAL_NOVE%TYPE;
 
    FUNCTION fsbObtUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.USUARIO%TYPE;
 
    FUNCTION fdtObtFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.FECHA%TYPE;
 
    PROCEDURE prAcNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuNOVGENERA    NUMBER
    );
 
    PROCEDURE prAcTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuTOTAL_NOVE    NUMBER
    );
 
    PROCEDURE prAcUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        isbUSUARIO    VARCHAR2
    );
 
    PROCEDURE prAcFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        idtFECHA    DATE
    );
 
    PROCEDURE prActRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE);
 
END PKG_LDC_ACTAS_APLICA_PROC_OFER;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_ACTAS_APLICA_PROC_OFER AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'ftbObtRowIdsxCond';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        tbRowIds tytbRowIds;
        sbSentencia VARCHAR2(32000);
        crfRowIds sys_refcursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        sbSentencia := 'SELECT tb.ROWID FROM LDC_ACTAS_APLICA_PROC_OFERT tb WHERE ';
        sbSentencia := sbSentencia ||isbCondicion;
        OPEN crfRowIds FOR sbSentencia;
        FETCH crfRowIds BULK COLLECT INTO tbRowIds;
        CLOSE crfRowIds;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN tbRowIds;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END ftbObtRowIdsxCond;
 
    FUNCTION ftbObtRegistrosxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRegistros IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'ftbObtRegistrosxCond';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        tbRegistros  tytbRegistros;
        sbSentencia VARCHAR2(32000);
        crfRegistros sys_refcursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        sbSentencia := 'SELECT tb.* FROM LDC_ACTAS_APLICA_PROC_OFERT tb WHERE ';
        sbSentencia := sbSentencia ||isbCondicion;
        OPEN crfRegistros FOR sbSentencia;
        FETCH crfRegistros BULK COLLECT INTO tbRegistros;
        CLOSE crfRegistros;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN tbRegistros;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END ftbObtRegistrosxCond;
 
    FUNCTION frcObtRegistroRId(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuACTA,isbPROCEJEC);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuACTA,isbPROCEJEC);
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
 
    FUNCTION fblExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuACTA,isbPROCEJEC);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ACTA IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
 
    PROCEDURE prValExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuACTA,isbPROCEJEC) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuACTA||','||isbPROCEJEC||'] en la tabla[LDC_ACTAS_APLICA_PROC_OFERT]');
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
 
    PROCEDURE prInsRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE, oRowId OUT ROWID) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_ACTAS_APLICA_PROC_OFERT(
            ACTA,PROCEJEC,NOVGENERA,TOTAL_NOVE,USUARIO,FECHA
        )
        VALUES (
            ircRegistro.ACTA,ircRegistro.PROCEJEC,ircRegistro.NOVGENERA,ircRegistro.TOTAL_NOVE,ircRegistro.USUARIO,ircRegistro.FECHA
        ) RETURNING ROWID INTO oRowId;
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
 
    PROCEDURE prBorRegistro(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_ACTAS_APLICA_PROC_OFERT
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
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE LDC_ACTAS_APLICA_PROC_OFERT
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
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxCond';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        tbRowIds tytbRowIds;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF isbCondicion IS NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'Debe proporcionarse una condición para el borrado');
        ELSE
            tbRowIds := ftbObtRowIdsxCond(isbCondicion);
            IF tbRowIds.COUNT > inuCantMaxima THEN
                pkg_error.setErrorMessage( isbMsgErrr => 'Se intentan borrar ['||tbRowIds.COUNT||']inuCantMaxima['||inuCantMaxima||']');
            ELSE
                FOR ind IN 1..tbRowIds.COUNT LOOP
                    prBorRegistroxRowId(tbRowIds(ind));
                END LOOP;
            END IF;
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
    END prBorRegistroxCond;
    FUNCTION fnuObtNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.NOVGENERA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNOVGENERA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOVGENERA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtNOVGENERA;
 
    FUNCTION fnuObtTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.TOTAL_NOVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTOTAL_NOVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TOTAL_NOVE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtTOTAL_NOVE;
 
    FUNCTION fsbObtUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.USUARIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC);
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
 
    FUNCTION fdtObtFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.FECHA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA;
 
    PROCEDURE prAcNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuNOVGENERA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOVGENERA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC,TRUE);
        IF NVL(inuNOVGENERA,-1) <> NVL(rcRegistroAct.NOVGENERA,-1) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET NOVGENERA=inuNOVGENERA
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
    END prAcNOVGENERA;
 
    PROCEDURE prAcTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuTOTAL_NOVE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTOTAL_NOVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC,TRUE);
        IF NVL(inuTOTAL_NOVE,-1) <> NVL(rcRegistroAct.TOTAL_NOVE,-1) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET TOTAL_NOVE=inuTOTAL_NOVE
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
    END prAcTOTAL_NOVE;
 
    PROCEDURE prAcUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        isbUSUARIO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSUARIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC,TRUE);
        IF NVL(isbUSUARIO,'-') <> NVL(rcRegistroAct.USUARIO,'-') THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
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
 
    PROCEDURE prAcFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        idtFECHA    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuACTA,isbPROCEJEC,TRUE);
        IF NVL(idtFECHA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET FECHA=idtFECHA
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
    END prAcFECHA;
 
    PROCEDURE prAcNOVGENERA_RId(
        iRowId ROWID,
        inuNOVGENERA_O    NUMBER,
        inuNOVGENERA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOVGENERA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNOVGENERA_O,-1) <> NVL(inuNOVGENERA_N,-1) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET NOVGENERA=inuNOVGENERA_N
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
    END prAcNOVGENERA_RId;
 
    PROCEDURE prAcTOTAL_NOVE_RId(
        iRowId ROWID,
        inuTOTAL_NOVE_O    NUMBER,
        inuTOTAL_NOVE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTOTAL_NOVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTOTAL_NOVE_O,-1) <> NVL(inuTOTAL_NOVE_N,-1) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET TOTAL_NOVE=inuTOTAL_NOVE_N
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
    END prAcTOTAL_NOVE_RId;
 
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
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
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
 
    PROCEDURE prAcFECHA_RId(
        iRowId ROWID,
        idtFECHA_O    DATE,
        idtFECHA_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_ACTAS_APLICA_PROC_OFERT
            SET FECHA=idtFECHA_N
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
    END prAcFECHA_RId;
 
    PROCEDURE prActRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ACTA,ircRegistro.PROCEJEC,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcNOVGENERA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOVGENERA,
                ircRegistro.NOVGENERA
            );
 
            prAcTOTAL_NOVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TOTAL_NOVE,
                ircRegistro.TOTAL_NOVE
            );
 
            prAcUSUARIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USUARIO,
                ircRegistro.USUARIO
            );
 
            prAcFECHA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA,
                ircRegistro.FECHA
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
 
END PKG_LDC_ACTAS_APLICA_PROC_OFER;
/
BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_ACTAS_APLICA_PROC_OFER'), UPPER('adm_person'));
END;
/
