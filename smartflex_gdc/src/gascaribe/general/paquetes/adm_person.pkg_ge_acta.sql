CREATE OR REPLACE PACKAGE adm_person.pkg_ge_acta AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : GE_ACTA
        Caso  : OSF-2204
        Fecha : 08/07/2024 14:30:10
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuID_ACTA    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM GE_ACTA tb
        WHERE
        ID_ACTA = inuID_ACTA;
     
    CURSOR cuRegistroRIdLock
    (
        inuID_ACTA    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM GE_ACTA tb
        WHERE
        ID_ACTA = inuID_ACTA
        FOR UPDATE NOWAIT;
     
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds;
    FUNCTION frcObtRegistroRId(
        inuID_ACTA    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    FUNCTION fblExiste(
        inuID_ACTA    NUMBER
    ) RETURN BOOLEAN;
 
    PROCEDURE prValExiste(
        inuID_ACTA    NUMBER
    );
 
    PROCEDURE prinsRegistro( ircRegistro GE_ACTA%ROWTYPE, oRowId OUT ROWID);
 
    PROCEDURE prBorRegistro(
        inuID_ACTA    NUMBER
    );
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    );
 
    FUNCTION fsbObtNOMBRE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.NOMBRE%TYPE;
 
    FUNCTION fnuObtID_TIPO_ACTA(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_TIPO_ACTA%TYPE;
 
    FUNCTION fnuObtVALOR_TOTAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALOR_TOTAL%TYPE;
 
    FUNCTION fdtObtFECHA_CREACION(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_CREACION%TYPE;
 
    FUNCTION fdtObtFECHA_CIERRE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_CIERRE%TYPE;
 
    FUNCTION fdtObtFECHA_INICIO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_INICIO%TYPE;
 
    FUNCTION fdtObtFECHA_FIN(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_FIN%TYPE;
 
    FUNCTION fsbObtESTADO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ESTADO%TYPE;
 
    FUNCTION fnuObtID_CONTRATO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_CONTRATO%TYPE;
 
    FUNCTION fnuObtID_BASE_ADMINISTRATIVA(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE;
 
    FUNCTION fnuObtID_PERIODO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_PERIODO%TYPE;
 
    FUNCTION fnuObtNUMERO_FISCAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.NUMERO_FISCAL%TYPE;
 
    FUNCTION fnuObtID_CONSECUTIVO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_CONSECUTIVO%TYPE;
 
    FUNCTION fdtObtFECHA_ULT_ACTUALIZAC(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_ULT_ACTUALIZAC%TYPE;
 
    FUNCTION fnuObtPERSON_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.PERSON_ID%TYPE;
 
    FUNCTION fnuObtIS_PENDING(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.IS_PENDING%TYPE;
 
    FUNCTION fnuObtCONTRACTOR_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.CONTRACTOR_ID%TYPE;
 
    FUNCTION fnuObtOPERATING_UNIT_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.OPERATING_UNIT_ID%TYPE;
 
    FUNCTION fnuObtVALUE_ADVANCE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALUE_ADVANCE%TYPE;
 
    FUNCTION fsbObtTERMINAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.TERMINAL%TYPE;
 
    FUNCTION fnuObtCOMMENT_TYPE_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.COMMENT_TYPE_ID%TYPE;
 
    FUNCTION fsbObtCOMMENT_(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.COMMENT_%TYPE;
 
    FUNCTION fdtObtEXTERN_PAY_DATE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.EXTERN_PAY_DATE%TYPE;
 
    FUNCTION fsbObtEXTERN_INVOICE_NUM(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.EXTERN_INVOICE_NUM%TYPE;
 
    FUNCTION fnuObtVALOR_LIQUIDADO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALOR_LIQUIDADO%TYPE;
 
    PROCEDURE prAcNOMBRE(
        inuID_ACTA    NUMBER,
        isbNOMBRE    VARCHAR2
    );
 
    PROCEDURE prAcID_TIPO_ACTA(
        inuID_ACTA    NUMBER,
        inuID_TIPO_ACTA    NUMBER
    );
 
    PROCEDURE prAcVALOR_TOTAL(
        inuID_ACTA    NUMBER,
        inuVALOR_TOTAL    NUMBER
    );
 
    PROCEDURE prAcFECHA_CREACION(
        inuID_ACTA    NUMBER,
        idtFECHA_CREACION    DATE
    );
 
    PROCEDURE prAcFECHA_CIERRE(
        inuID_ACTA    NUMBER,
        idtFECHA_CIERRE    DATE
    );
 
    PROCEDURE prAcFECHA_INICIO(
        inuID_ACTA    NUMBER,
        idtFECHA_INICIO    DATE
    );
 
    PROCEDURE prAcFECHA_FIN(
        inuID_ACTA    NUMBER,
        idtFECHA_FIN    DATE
    );
 
    PROCEDURE prAcESTADO(
        inuID_ACTA    NUMBER,
        isbESTADO    VARCHAR2
    );
 
    PROCEDURE prAcID_CONTRATO(
        inuID_ACTA    NUMBER,
        inuID_CONTRATO    NUMBER
    );
 
    PROCEDURE prAcID_BASE_ADMINISTRATIVA(
        inuID_ACTA    NUMBER,
        inuID_BASE_ADMINISTRATIVA    NUMBER
    );
 
    PROCEDURE prAcID_PERIODO(
        inuID_ACTA    NUMBER,
        inuID_PERIODO    NUMBER
    );
 
    PROCEDURE prAcNUMERO_FISCAL(
        inuID_ACTA    NUMBER,
        inuNUMERO_FISCAL    NUMBER
    );
 
    PROCEDURE prAcID_CONSECUTIVO(
        inuID_ACTA    NUMBER,
        inuID_CONSECUTIVO    NUMBER
    );
 
    PROCEDURE prAcFECHA_ULT_ACTUALIZAC(
        inuID_ACTA    NUMBER,
        idtFECHA_ULT_ACTUALIZAC    DATE
    );
 
    PROCEDURE prAcPERSON_ID(
        inuID_ACTA    NUMBER,
        inuPERSON_ID    NUMBER
    );
 
    PROCEDURE prAcIS_PENDING(
        inuID_ACTA    NUMBER,
        inuIS_PENDING    NUMBER
    );
 
    PROCEDURE prAcCONTRACTOR_ID(
        inuID_ACTA    NUMBER,
        inuCONTRACTOR_ID    NUMBER
    );
 
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuID_ACTA    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    );
 
    PROCEDURE prAcVALUE_ADVANCE(
        inuID_ACTA    NUMBER,
        inuVALUE_ADVANCE    NUMBER
    );
 
    PROCEDURE prAcTERMINAL(
        inuID_ACTA    NUMBER,
        isbTERMINAL    VARCHAR2
    );
 
    PROCEDURE prAcCOMMENT_TYPE_ID(
        inuID_ACTA    NUMBER,
        inuCOMMENT_TYPE_ID    NUMBER
    );
 
    PROCEDURE prAcCOMMENT_(
        inuID_ACTA    NUMBER,
        isbCOMMENT_    VARCHAR2
    );
 
    PROCEDURE prAcEXTERN_PAY_DATE(
        inuID_ACTA    NUMBER,
        idtEXTERN_PAY_DATE    DATE
    );
 
    PROCEDURE prAcEXTERN_INVOICE_NUM(
        inuID_ACTA    NUMBER,
        isbEXTERN_INVOICE_NUM    VARCHAR2
    );
 
    PROCEDURE prAcVALOR_LIQUIDADO(
        inuID_ACTA    NUMBER,
        inuVALOR_LIQUIDADO    NUMBER
    );
 
    PROCEDURE prActRegistro( ircRegistro GE_ACTA%ROWTYPE);
 
END pkg_ge_acta;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ge_acta AS
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
        sbSentencia := 'SELECT tb.ROWID FROM GE_ACTA tb WHERE ';
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
 
    FUNCTION frcObtRegistroRId(
        inuID_ACTA    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuID_ACTA);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuID_ACTA);
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
        inuID_ACTA    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ID_ACTA IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuID_ACTA    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuID_ACTA) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuID_ACTA||'] en la tabla[GE_ACTA]');
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
 
    PROCEDURE prInsRegistro( ircRegistro GE_ACTA%ROWTYPE, oRowId OUT ROWID) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO GE_ACTA(
            ID_ACTA,NOMBRE,ID_TIPO_ACTA,VALOR_TOTAL,FECHA_CREACION,FECHA_CIERRE,FECHA_INICIO,FECHA_FIN,ESTADO,ID_CONTRATO,ID_BASE_ADMINISTRATIVA,ID_PERIODO,NUMERO_FISCAL,ID_CONSECUTIVO,FECHA_ULT_ACTUALIZAC,PERSON_ID,IS_PENDING,CONTRACTOR_ID,OPERATING_UNIT_ID,VALUE_ADVANCE,TERMINAL,COMMENT_TYPE_ID,COMMENT_,EXTERN_PAY_DATE,EXTERN_INVOICE_NUM,VALOR_LIQUIDADO
        )
        VALUES (
            ircRegistro.ID_ACTA,ircRegistro.NOMBRE,ircRegistro.ID_TIPO_ACTA,ircRegistro.VALOR_TOTAL,ircRegistro.FECHA_CREACION,ircRegistro.FECHA_CIERRE,ircRegistro.FECHA_INICIO,ircRegistro.FECHA_FIN,ircRegistro.ESTADO,ircRegistro.ID_CONTRATO,ircRegistro.ID_BASE_ADMINISTRATIVA,ircRegistro.ID_PERIODO,ircRegistro.NUMERO_FISCAL,ircRegistro.ID_CONSECUTIVO,ircRegistro.FECHA_ULT_ACTUALIZAC,ircRegistro.PERSON_ID,ircRegistro.IS_PENDING,ircRegistro.CONTRACTOR_ID,ircRegistro.OPERATING_UNIT_ID,ircRegistro.VALUE_ADVANCE,ircRegistro.TERMINAL,ircRegistro.COMMENT_TYPE_ID,ircRegistro.COMMENT_,ircRegistro.EXTERN_PAY_DATE,ircRegistro.EXTERN_INVOICE_NUM,ircRegistro.VALOR_LIQUIDADO
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
        inuID_ACTA    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE GE_ACTA
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
            DELETE GE_ACTA
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
    FUNCTION fsbObtNOMBRE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.NOMBRE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNOMBRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOMBRE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNOMBRE;
 
    FUNCTION fnuObtID_TIPO_ACTA(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_TIPO_ACTA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_TIPO_ACTA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_TIPO_ACTA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_TIPO_ACTA;
 
    FUNCTION fnuObtVALOR_TOTAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALOR_TOTAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVALOR_TOTAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALOR_TOTAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtVALOR_TOTAL;
 
    FUNCTION fdtObtFECHA_CREACION(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_CREACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_CREACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_CREACION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_CREACION;
 
    FUNCTION fdtObtFECHA_CIERRE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_CIERRE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_CIERRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_CIERRE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_CIERRE;
 
    FUNCTION fdtObtFECHA_INICIO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_INICIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_INICIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_INICIO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_INICIO;
 
    FUNCTION fdtObtFECHA_FIN(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_FIN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_FIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_FIN;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_FIN;
 
    FUNCTION fsbObtESTADO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ESTADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtESTADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ESTADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtESTADO;
 
    FUNCTION fnuObtID_CONTRATO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_CONTRATO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_CONTRATO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_CONTRATO;
 
    FUNCTION fnuObtID_BASE_ADMINISTRATIVA(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_BASE_ADMINISTRATIVA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_BASE_ADMINISTRATIVA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_BASE_ADMINISTRATIVA;
 
    FUNCTION fnuObtID_PERIODO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_PERIODO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_PERIODO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_PERIODO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_PERIODO;
 
    FUNCTION fnuObtNUMERO_FISCAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.NUMERO_FISCAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNUMERO_FISCAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NUMERO_FISCAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtNUMERO_FISCAL;
 
    FUNCTION fnuObtID_CONSECUTIVO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.ID_CONSECUTIVO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_CONSECUTIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_CONSECUTIVO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_CONSECUTIVO;
 
    FUNCTION fdtObtFECHA_ULT_ACTUALIZAC(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.FECHA_ULT_ACTUALIZAC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_ULT_ACTUALIZAC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_ULT_ACTUALIZAC;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_ULT_ACTUALIZAC;
 
    FUNCTION fnuObtPERSON_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.PERSON_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPERSON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
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
 
    FUNCTION fnuObtIS_PENDING(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.IS_PENDING%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtIS_PENDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_PENDING;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtIS_PENDING;
 
    FUNCTION fnuObtCONTRACTOR_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.CONTRACTOR_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONTRACTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONTRACTOR_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCONTRACTOR_ID;
 
    FUNCTION fnuObtOPERATING_UNIT_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.OPERATING_UNIT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATING_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
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
 
    FUNCTION fnuObtVALUE_ADVANCE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALUE_ADVANCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVALUE_ADVANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALUE_ADVANCE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtVALUE_ADVANCE;
 
    FUNCTION fsbObtTERMINAL(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.TERMINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TERMINAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtTERMINAL;
 
    FUNCTION fnuObtCOMMENT_TYPE_ID(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.COMMENT_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOMMENT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMMENT_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCOMMENT_TYPE_ID;
 
    FUNCTION fsbObtCOMMENT_(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.COMMENT_%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCOMMENT_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMMENT_;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCOMMENT_;
 
    FUNCTION fdtObtEXTERN_PAY_DATE(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.EXTERN_PAY_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtEXTERN_PAY_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.EXTERN_PAY_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtEXTERN_PAY_DATE;
 
    FUNCTION fsbObtEXTERN_INVOICE_NUM(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.EXTERN_INVOICE_NUM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtEXTERN_INVOICE_NUM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.EXTERN_INVOICE_NUM;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtEXTERN_INVOICE_NUM;
 
    FUNCTION fnuObtVALOR_LIQUIDADO(
        inuID_ACTA    NUMBER
        ) RETURN GE_ACTA.VALOR_LIQUIDADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVALOR_LIQUIDADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALOR_LIQUIDADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtVALOR_LIQUIDADO;
 
    PROCEDURE prAcNOMBRE(
        inuID_ACTA    NUMBER,
        isbNOMBRE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOMBRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(isbNOMBRE,'-') <> NVL(rcRegistroAct.NOMBRE,'-') THEN
            UPDATE GE_ACTA
            SET NOMBRE=isbNOMBRE
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
    END prAcNOMBRE;
 
    PROCEDURE prAcID_TIPO_ACTA(
        inuID_ACTA    NUMBER,
        inuID_TIPO_ACTA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_TIPO_ACTA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuID_TIPO_ACTA,-1) <> NVL(rcRegistroAct.ID_TIPO_ACTA,-1) THEN
            UPDATE GE_ACTA
            SET ID_TIPO_ACTA=inuID_TIPO_ACTA
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
    END prAcID_TIPO_ACTA;
 
    PROCEDURE prAcVALOR_TOTAL(
        inuID_ACTA    NUMBER,
        inuVALOR_TOTAL    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_TOTAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuVALOR_TOTAL,-1) <> NVL(rcRegistroAct.VALOR_TOTAL,-1) THEN
            UPDATE GE_ACTA
            SET VALOR_TOTAL=inuVALOR_TOTAL
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
    END prAcVALOR_TOTAL;
 
    PROCEDURE prAcFECHA_CREACION(
        inuID_ACTA    NUMBER,
        idtFECHA_CREACION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CREACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtFECHA_CREACION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_CREACION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_CREACION=idtFECHA_CREACION
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
    END prAcFECHA_CREACION;
 
    PROCEDURE prAcFECHA_CIERRE(
        inuID_ACTA    NUMBER,
        idtFECHA_CIERRE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CIERRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtFECHA_CIERRE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_CIERRE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_CIERRE=idtFECHA_CIERRE
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
    END prAcFECHA_CIERRE;
 
    PROCEDURE prAcFECHA_INICIO(
        inuID_ACTA    NUMBER,
        idtFECHA_INICIO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INICIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtFECHA_INICIO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_INICIO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_INICIO=idtFECHA_INICIO
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
    END prAcFECHA_INICIO;
 
    PROCEDURE prAcFECHA_FIN(
        inuID_ACTA    NUMBER,
        idtFECHA_FIN    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtFECHA_FIN,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_FIN,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_FIN=idtFECHA_FIN
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
    END prAcFECHA_FIN;
 
    PROCEDURE prAcESTADO(
        inuID_ACTA    NUMBER,
        isbESTADO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(isbESTADO,'-') <> NVL(rcRegistroAct.ESTADO,'-') THEN
            UPDATE GE_ACTA
            SET ESTADO=isbESTADO
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
    END prAcESTADO;
 
    PROCEDURE prAcID_CONTRATO(
        inuID_ACTA    NUMBER,
        inuID_CONTRATO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuID_CONTRATO,-1) <> NVL(rcRegistroAct.ID_CONTRATO,-1) THEN
            UPDATE GE_ACTA
            SET ID_CONTRATO=inuID_CONTRATO
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
    END prAcID_CONTRATO;
 
    PROCEDURE prAcID_BASE_ADMINISTRATIVA(
        inuID_ACTA    NUMBER,
        inuID_BASE_ADMINISTRATIVA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_BASE_ADMINISTRATIVA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuID_BASE_ADMINISTRATIVA,-1) <> NVL(rcRegistroAct.ID_BASE_ADMINISTRATIVA,-1) THEN
            UPDATE GE_ACTA
            SET ID_BASE_ADMINISTRATIVA=inuID_BASE_ADMINISTRATIVA
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
    END prAcID_BASE_ADMINISTRATIVA;
 
    PROCEDURE prAcID_PERIODO(
        inuID_ACTA    NUMBER,
        inuID_PERIODO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_PERIODO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuID_PERIODO,-1) <> NVL(rcRegistroAct.ID_PERIODO,-1) THEN
            UPDATE GE_ACTA
            SET ID_PERIODO=inuID_PERIODO
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
    END prAcID_PERIODO;
 
    PROCEDURE prAcNUMERO_FISCAL(
        inuID_ACTA    NUMBER,
        inuNUMERO_FISCAL    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMERO_FISCAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuNUMERO_FISCAL,-1) <> NVL(rcRegistroAct.NUMERO_FISCAL,-1) THEN
            UPDATE GE_ACTA
            SET NUMERO_FISCAL=inuNUMERO_FISCAL
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
    END prAcNUMERO_FISCAL;
 
    PROCEDURE prAcID_CONSECUTIVO(
        inuID_ACTA    NUMBER,
        inuID_CONSECUTIVO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONSECUTIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuID_CONSECUTIVO,-1) <> NVL(rcRegistroAct.ID_CONSECUTIVO,-1) THEN
            UPDATE GE_ACTA
            SET ID_CONSECUTIVO=inuID_CONSECUTIVO
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
    END prAcID_CONSECUTIVO;
 
    PROCEDURE prAcFECHA_ULT_ACTUALIZAC(
        inuID_ACTA    NUMBER,
        idtFECHA_ULT_ACTUALIZAC    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_ULT_ACTUALIZAC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtFECHA_ULT_ACTUALIZAC,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_ULT_ACTUALIZAC,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_ULT_ACTUALIZAC=idtFECHA_ULT_ACTUALIZAC
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
    END prAcFECHA_ULT_ACTUALIZAC;
 
    PROCEDURE prAcPERSON_ID(
        inuID_ACTA    NUMBER,
        inuPERSON_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERSON_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuPERSON_ID,-1) <> NVL(rcRegistroAct.PERSON_ID,-1) THEN
            UPDATE GE_ACTA
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
 
    PROCEDURE prAcIS_PENDING(
        inuID_ACTA    NUMBER,
        inuIS_PENDING    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PENDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuIS_PENDING,-1) <> NVL(rcRegistroAct.IS_PENDING,-1) THEN
            UPDATE GE_ACTA
            SET IS_PENDING=inuIS_PENDING
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
    END prAcIS_PENDING;
 
    PROCEDURE prAcCONTRACTOR_ID(
        inuID_ACTA    NUMBER,
        inuCONTRACTOR_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTRACTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuCONTRACTOR_ID,-1) <> NVL(rcRegistroAct.CONTRACTOR_ID,-1) THEN
            UPDATE GE_ACTA
            SET CONTRACTOR_ID=inuCONTRACTOR_ID
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
    END prAcCONTRACTOR_ID;
 
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuID_ACTA    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuOPERATING_UNIT_ID,-1) <> NVL(rcRegistroAct.OPERATING_UNIT_ID,-1) THEN
            UPDATE GE_ACTA
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
 
    PROCEDURE prAcVALUE_ADVANCE(
        inuID_ACTA    NUMBER,
        inuVALUE_ADVANCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE_ADVANCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuVALUE_ADVANCE,-1) <> NVL(rcRegistroAct.VALUE_ADVANCE,-1) THEN
            UPDATE GE_ACTA
            SET VALUE_ADVANCE=inuVALUE_ADVANCE
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
    END prAcVALUE_ADVANCE;
 
    PROCEDURE prAcTERMINAL(
        inuID_ACTA    NUMBER,
        isbTERMINAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTERMINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(isbTERMINAL,'-') <> NVL(rcRegistroAct.TERMINAL,'-') THEN
            UPDATE GE_ACTA
            SET TERMINAL=isbTERMINAL
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
    END prAcTERMINAL;
 
    PROCEDURE prAcCOMMENT_TYPE_ID(
        inuID_ACTA    NUMBER,
        inuCOMMENT_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuCOMMENT_TYPE_ID,-1) <> NVL(rcRegistroAct.COMMENT_TYPE_ID,-1) THEN
            UPDATE GE_ACTA
            SET COMMENT_TYPE_ID=inuCOMMENT_TYPE_ID
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
    END prAcCOMMENT_TYPE_ID;
 
    PROCEDURE prAcCOMMENT_(
        inuID_ACTA    NUMBER,
        isbCOMMENT_    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(isbCOMMENT_,'-') <> NVL(rcRegistroAct.COMMENT_,'-') THEN
            UPDATE GE_ACTA
            SET COMMENT_=isbCOMMENT_
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
    END prAcCOMMENT_;
 
    PROCEDURE prAcEXTERN_PAY_DATE(
        inuID_ACTA    NUMBER,
        idtEXTERN_PAY_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXTERN_PAY_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(idtEXTERN_PAY_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.EXTERN_PAY_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET EXTERN_PAY_DATE=idtEXTERN_PAY_DATE
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
    END prAcEXTERN_PAY_DATE;
 
    PROCEDURE prAcEXTERN_INVOICE_NUM(
        inuID_ACTA    NUMBER,
        isbEXTERN_INVOICE_NUM    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXTERN_INVOICE_NUM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(isbEXTERN_INVOICE_NUM,'-') <> NVL(rcRegistroAct.EXTERN_INVOICE_NUM,'-') THEN
            UPDATE GE_ACTA
            SET EXTERN_INVOICE_NUM=isbEXTERN_INVOICE_NUM
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
    END prAcEXTERN_INVOICE_NUM;
 
    PROCEDURE prAcVALOR_LIQUIDADO(
        inuID_ACTA    NUMBER,
        inuVALOR_LIQUIDADO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_LIQUIDADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuID_ACTA,TRUE);
        IF NVL(inuVALOR_LIQUIDADO,-1) <> NVL(rcRegistroAct.VALOR_LIQUIDADO,-1) THEN
            UPDATE GE_ACTA
            SET VALOR_LIQUIDADO=inuVALOR_LIQUIDADO
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
    END prAcVALOR_LIQUIDADO;
 
    PROCEDURE prAcNOMBRE_RId(
        iRowId ROWID,
        isbNOMBRE_O    VARCHAR2,
        isbNOMBRE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOMBRE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNOMBRE_O,'-') <> NVL(isbNOMBRE_N,'-') THEN
            UPDATE GE_ACTA
            SET NOMBRE=isbNOMBRE_N
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
    END prAcNOMBRE_RId;
 
    PROCEDURE prAcID_TIPO_ACTA_RId(
        iRowId ROWID,
        inuID_TIPO_ACTA_O    NUMBER,
        inuID_TIPO_ACTA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_TIPO_ACTA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_TIPO_ACTA_O,-1) <> NVL(inuID_TIPO_ACTA_N,-1) THEN
            UPDATE GE_ACTA
            SET ID_TIPO_ACTA=inuID_TIPO_ACTA_N
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
    END prAcID_TIPO_ACTA_RId;
 
    PROCEDURE prAcVALOR_TOTAL_RId(
        iRowId ROWID,
        inuVALOR_TOTAL_O    NUMBER,
        inuVALOR_TOTAL_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_TOTAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALOR_TOTAL_O,-1) <> NVL(inuVALOR_TOTAL_N,-1) THEN
            UPDATE GE_ACTA
            SET VALOR_TOTAL=inuVALOR_TOTAL_N
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
    END prAcVALOR_TOTAL_RId;
 
    PROCEDURE prAcFECHA_CREACION_RId(
        iRowId ROWID,
        idtFECHA_CREACION_O    DATE,
        idtFECHA_CREACION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CREACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_CREACION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_CREACION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_CREACION=idtFECHA_CREACION_N
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
    END prAcFECHA_CREACION_RId;
 
    PROCEDURE prAcFECHA_CIERRE_RId(
        iRowId ROWID,
        idtFECHA_CIERRE_O    DATE,
        idtFECHA_CIERRE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_CIERRE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_CIERRE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_CIERRE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_CIERRE=idtFECHA_CIERRE_N
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
    END prAcFECHA_CIERRE_RId;
 
    PROCEDURE prAcFECHA_INICIO_RId(
        iRowId ROWID,
        idtFECHA_INICIO_O    DATE,
        idtFECHA_INICIO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INICIO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_INICIO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_INICIO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_INICIO=idtFECHA_INICIO_N
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
    END prAcFECHA_INICIO_RId;
 
    PROCEDURE prAcFECHA_FIN_RId(
        iRowId ROWID,
        idtFECHA_FIN_O    DATE,
        idtFECHA_FIN_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FIN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_FIN_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_FIN_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_FIN=idtFECHA_FIN_N
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
    END prAcFECHA_FIN_RId;
 
    PROCEDURE prAcESTADO_RId(
        iRowId ROWID,
        isbESTADO_O    VARCHAR2,
        isbESTADO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTADO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbESTADO_O,'-') <> NVL(isbESTADO_N,'-') THEN
            UPDATE GE_ACTA
            SET ESTADO=isbESTADO_N
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
    END prAcESTADO_RId;
 
    PROCEDURE prAcID_CONTRATO_RId(
        iRowId ROWID,
        inuID_CONTRATO_O    NUMBER,
        inuID_CONTRATO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONTRATO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_CONTRATO_O,-1) <> NVL(inuID_CONTRATO_N,-1) THEN
            UPDATE GE_ACTA
            SET ID_CONTRATO=inuID_CONTRATO_N
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
    END prAcID_CONTRATO_RId;
 
    PROCEDURE prAcID_BASE_ADMINISTRATIVA_RId(
        iRowId ROWID,
        inuID_BASE_ADMINISTRATIVA_O    NUMBER,
        inuID_BASE_ADMINISTRATIVA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_BASE_ADMINISTRATIVA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_BASE_ADMINISTRATIVA_O,-1) <> NVL(inuID_BASE_ADMINISTRATIVA_N,-1) THEN
            UPDATE GE_ACTA
            SET ID_BASE_ADMINISTRATIVA=inuID_BASE_ADMINISTRATIVA_N
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
    END prAcID_BASE_ADMINISTRATIVA_RId;
 
    PROCEDURE prAcID_PERIODO_RId(
        iRowId ROWID,
        inuID_PERIODO_O    NUMBER,
        inuID_PERIODO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_PERIODO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_PERIODO_O,-1) <> NVL(inuID_PERIODO_N,-1) THEN
            UPDATE GE_ACTA
            SET ID_PERIODO=inuID_PERIODO_N
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
    END prAcID_PERIODO_RId;
 
    PROCEDURE prAcNUMERO_FISCAL_RId(
        iRowId ROWID,
        inuNUMERO_FISCAL_O    NUMBER,
        inuNUMERO_FISCAL_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMERO_FISCAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNUMERO_FISCAL_O,-1) <> NVL(inuNUMERO_FISCAL_N,-1) THEN
            UPDATE GE_ACTA
            SET NUMERO_FISCAL=inuNUMERO_FISCAL_N
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
    END prAcNUMERO_FISCAL_RId;
 
    PROCEDURE prAcID_CONSECUTIVO_RId(
        iRowId ROWID,
        inuID_CONSECUTIVO_O    NUMBER,
        inuID_CONSECUTIVO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONSECUTIVO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_CONSECUTIVO_O,-1) <> NVL(inuID_CONSECUTIVO_N,-1) THEN
            UPDATE GE_ACTA
            SET ID_CONSECUTIVO=inuID_CONSECUTIVO_N
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
    END prAcID_CONSECUTIVO_RId;
 
    PROCEDURE prAcFECHA_ULT_ACTUALIZAC_RId(
        iRowId ROWID,
        idtFECHA_ULT_ACTUALIZAC_O    DATE,
        idtFECHA_ULT_ACTUALIZAC_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_ULT_ACTUALIZAC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_ULT_ACTUALIZAC_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_ULT_ACTUALIZAC_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET FECHA_ULT_ACTUALIZAC=idtFECHA_ULT_ACTUALIZAC_N
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
    END prAcFECHA_ULT_ACTUALIZAC_RId;
 
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
            UPDATE GE_ACTA
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
 
    PROCEDURE prAcIS_PENDING_RId(
        iRowId ROWID,
        inuIS_PENDING_O    NUMBER,
        inuIS_PENDING_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PENDING_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuIS_PENDING_O,-1) <> NVL(inuIS_PENDING_N,-1) THEN
            UPDATE GE_ACTA
            SET IS_PENDING=inuIS_PENDING_N
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
    END prAcIS_PENDING_RId;
 
    PROCEDURE prAcCONTRACTOR_ID_RId(
        iRowId ROWID,
        inuCONTRACTOR_ID_O    NUMBER,
        inuCONTRACTOR_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTRACTOR_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONTRACTOR_ID_O,-1) <> NVL(inuCONTRACTOR_ID_N,-1) THEN
            UPDATE GE_ACTA
            SET CONTRACTOR_ID=inuCONTRACTOR_ID_N
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
    END prAcCONTRACTOR_ID_RId;
 
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
            UPDATE GE_ACTA
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
 
    PROCEDURE prAcVALUE_ADVANCE_RId(
        iRowId ROWID,
        inuVALUE_ADVANCE_O    NUMBER,
        inuVALUE_ADVANCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALUE_ADVANCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALUE_ADVANCE_O,-1) <> NVL(inuVALUE_ADVANCE_N,-1) THEN
            UPDATE GE_ACTA
            SET VALUE_ADVANCE=inuVALUE_ADVANCE_N
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
    END prAcVALUE_ADVANCE_RId;
 
    PROCEDURE prAcTERMINAL_RId(
        iRowId ROWID,
        isbTERMINAL_O    VARCHAR2,
        isbTERMINAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTERMINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTERMINAL_O,'-') <> NVL(isbTERMINAL_N,'-') THEN
            UPDATE GE_ACTA
            SET TERMINAL=isbTERMINAL_N
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
    END prAcTERMINAL_RId;
 
    PROCEDURE prAcCOMMENT_TYPE_ID_RId(
        iRowId ROWID,
        inuCOMMENT_TYPE_ID_O    NUMBER,
        inuCOMMENT_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOMMENT_TYPE_ID_O,-1) <> NVL(inuCOMMENT_TYPE_ID_N,-1) THEN
            UPDATE GE_ACTA
            SET COMMENT_TYPE_ID=inuCOMMENT_TYPE_ID_N
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
    END prAcCOMMENT_TYPE_ID_RId;
 
    PROCEDURE prAcCOMMENT__RId(
        iRowId ROWID,
        isbCOMMENT__O    VARCHAR2,
        isbCOMMENT__N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOMMENT__O,'-') <> NVL(isbCOMMENT__N,'-') THEN
            UPDATE GE_ACTA
            SET COMMENT_=isbCOMMENT__N
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
    END prAcCOMMENT__RId;
 
    PROCEDURE prAcEXTERN_PAY_DATE_RId(
        iRowId ROWID,
        idtEXTERN_PAY_DATE_O    DATE,
        idtEXTERN_PAY_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXTERN_PAY_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEXTERN_PAY_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEXTERN_PAY_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE GE_ACTA
            SET EXTERN_PAY_DATE=idtEXTERN_PAY_DATE_N
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
    END prAcEXTERN_PAY_DATE_RId;
 
    PROCEDURE prAcEXTERN_INVOICE_NUM_RId(
        iRowId ROWID,
        isbEXTERN_INVOICE_NUM_O    VARCHAR2,
        isbEXTERN_INVOICE_NUM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXTERN_INVOICE_NUM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbEXTERN_INVOICE_NUM_O,'-') <> NVL(isbEXTERN_INVOICE_NUM_N,'-') THEN
            UPDATE GE_ACTA
            SET EXTERN_INVOICE_NUM=isbEXTERN_INVOICE_NUM_N
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
    END prAcEXTERN_INVOICE_NUM_RId;
 
    PROCEDURE prAcVALOR_LIQUIDADO_RId(
        iRowId ROWID,
        inuVALOR_LIQUIDADO_O    NUMBER,
        inuVALOR_LIQUIDADO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_LIQUIDADO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALOR_LIQUIDADO_O,-1) <> NVL(inuVALOR_LIQUIDADO_N,-1) THEN
            UPDATE GE_ACTA
            SET VALOR_LIQUIDADO=inuVALOR_LIQUIDADO_N
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
    END prAcVALOR_LIQUIDADO_RId;
 
    PROCEDURE prActRegistro( ircRegistro GE_ACTA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ID_ACTA,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcNOMBRE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOMBRE,
                ircRegistro.NOMBRE
            );
 
            prAcID_TIPO_ACTA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_TIPO_ACTA,
                ircRegistro.ID_TIPO_ACTA
            );
 
            prAcVALOR_TOTAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALOR_TOTAL,
                ircRegistro.VALOR_TOTAL
            );
 
            prAcFECHA_CREACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_CREACION,
                ircRegistro.FECHA_CREACION
            );
 
            prAcFECHA_CIERRE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_CIERRE,
                ircRegistro.FECHA_CIERRE
            );
 
            prAcFECHA_INICIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_INICIO,
                ircRegistro.FECHA_INICIO
            );
 
            prAcFECHA_FIN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_FIN,
                ircRegistro.FECHA_FIN
            );
 
            prAcESTADO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ESTADO,
                ircRegistro.ESTADO
            );
 
            prAcID_CONTRATO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_CONTRATO,
                ircRegistro.ID_CONTRATO
            );
 
            prAcID_BASE_ADMINISTRATIVA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_BASE_ADMINISTRATIVA,
                ircRegistro.ID_BASE_ADMINISTRATIVA
            );
 
            prAcID_PERIODO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_PERIODO,
                ircRegistro.ID_PERIODO
            );
 
            prAcNUMERO_FISCAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NUMERO_FISCAL,
                ircRegistro.NUMERO_FISCAL
            );
 
            prAcID_CONSECUTIVO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_CONSECUTIVO,
                ircRegistro.ID_CONSECUTIVO
            );
 
            prAcFECHA_ULT_ACTUALIZAC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_ULT_ACTUALIZAC,
                ircRegistro.FECHA_ULT_ACTUALIZAC
            );
 
            prAcPERSON_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PERSON_ID,
                ircRegistro.PERSON_ID
            );
 
            prAcIS_PENDING_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_PENDING,
                ircRegistro.IS_PENDING
            );
 
            prAcCONTRACTOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONTRACTOR_ID,
                ircRegistro.CONTRACTOR_ID
            );
 
            prAcOPERATING_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_UNIT_ID,
                ircRegistro.OPERATING_UNIT_ID
            );
 
            prAcVALUE_ADVANCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALUE_ADVANCE,
                ircRegistro.VALUE_ADVANCE
            );
 
            prAcTERMINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TERMINAL,
                ircRegistro.TERMINAL
            );
 
            prAcCOMMENT_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMMENT_TYPE_ID,
                ircRegistro.COMMENT_TYPE_ID
            );
 
            prAcCOMMENT__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMMENT_,
                ircRegistro.COMMENT_
            );
 
            prAcEXTERN_PAY_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXTERN_PAY_DATE,
                ircRegistro.EXTERN_PAY_DATE
            );
 
            prAcEXTERN_INVOICE_NUM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXTERN_INVOICE_NUM,
                ircRegistro.EXTERN_INVOICE_NUM
            );
 
            prAcVALOR_LIQUIDADO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALOR_LIQUIDADO,
                ircRegistro.VALOR_LIQUIDADO
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
 
END pkg_ge_acta;
/
BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ge_acta'), UPPER('adm_person'));
END;
/
