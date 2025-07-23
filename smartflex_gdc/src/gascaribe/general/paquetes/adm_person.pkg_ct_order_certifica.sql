CREATE OR REPLACE PACKAGE adm_person.pkg_ct_order_certifica AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : CT_ORDER_CERTIFICA
        Caso  : OSF-2204
        Fecha : 08/07/2024 14:31:22
        Fecha       Autor       Caso        Descripción
        10/03/2025  jpinedc     OSF-4080    Se modifica prinsRegistro        
        10/03/2025  jpinedc     OSF-4042    Se crea fblExisteRegistroOrden
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM CT_ORDER_CERTIFICA tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        CERTIFICATE_ID = inuCERTIFICATE_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM CT_ORDER_CERTIFICA tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        CERTIFICATE_ID = inuCERTIFICATE_ID
        FOR UPDATE NOWAIT;
     
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds;
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    ) RETURN BOOLEAN;
 
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    );
 
    PROCEDURE prinsRegistro( ircRegistro CT_ORDER_CERTIFICA%ROWTYPE);
 
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    );
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    );
 
    FUNCTION fdtObtVERIFICATION_DATE(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
        ) RETURN CT_ORDER_CERTIFICA.VERIFICATION_DATE%TYPE;
 
    PROCEDURE prAcVERIFICATION_DATE(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER,
        idtVERIFICATION_DATE    DATE
    );
 
    PROCEDURE prActRegistro( ircRegistro CT_ORDER_CERTIFICA%ROWTYPE);
    
    -- Retorna verdadero si existe registro para la orden en CT_ORDER_CERTIFICA
    FUNCTION fblExisteRegistroOrden( inuOrden    CT_ORDER_CERTIFICA.order_id%TYPE)
    RETURN BOOLEAN;
 
END pkg_ct_order_certifica;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ct_order_certifica AS
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
        sbSentencia := 'SELECT tb.ROWID FROM CT_ORDER_CERTIFICA tb WHERE ';
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
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID,inuCERTIFICATE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID,inuCERTIFICATE_ID);
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
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID,inuCERTIFICATE_ID);
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
 
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID,inuCERTIFICATE_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||','||inuCERTIFICATE_ID||'] en la tabla[CT_ORDER_CERTIFICA]');
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
 
    PROCEDURE prInsRegistro( ircRegistro CT_ORDER_CERTIFICA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO CT_ORDER_CERTIFICA(
            ORDER_ID,CERTIFICATE_ID,VERIFICATION_DATE
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.CERTIFICATE_ID,ircRegistro.VERIFICATION_DATE
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
 
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuCERTIFICATE_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE CT_ORDER_CERTIFICA
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
            DELETE CT_ORDER_CERTIFICA
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
    FUNCTION fdtObtVERIFICATION_DATE(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER
        ) RETURN CT_ORDER_CERTIFICA.VERIFICATION_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtVERIFICATION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuCERTIFICATE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VERIFICATION_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtVERIFICATION_DATE;
 
    PROCEDURE prAcVERIFICATION_DATE(
        inuORDER_ID    NUMBER,inuCERTIFICATE_ID    NUMBER,
        idtVERIFICATION_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVERIFICATION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuCERTIFICATE_ID,TRUE);
        IF NVL(idtVERIFICATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.VERIFICATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CT_ORDER_CERTIFICA
            SET VERIFICATION_DATE=idtVERIFICATION_DATE
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
    END prAcVERIFICATION_DATE;
 
    PROCEDURE prAcVERIFICATION_DATE_RId(
        iRowId ROWID,
        idtVERIFICATION_DATE_O    DATE,
        idtVERIFICATION_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVERIFICATION_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtVERIFICATION_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtVERIFICATION_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE CT_ORDER_CERTIFICA
            SET VERIFICATION_DATE=idtVERIFICATION_DATE_N
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
    END prAcVERIFICATION_DATE_RId;
 
    PROCEDURE prActRegistro( ircRegistro CT_ORDER_CERTIFICA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,ircRegistro.CERTIFICATE_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcVERIFICATION_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VERIFICATION_DATE,
                ircRegistro.VERIFICATION_DATE
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
 

    -- Retorna verdadero si existe registro para la orden en CT_ORDER_CERTIFICA
    FUNCTION fblExisteRegistroOrden( inuOrden    CT_ORDER_CERTIFICA.order_id%TYPE)
    RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExisteRegistroOrden';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        blExisteRegistroOrden   BOOLEAN;
        
        nuCertificado       CT_ORDER_CERTIFICA.certificate_id%TYPE;
        
        CURSOR cuExisteRegistroOrden
        IS
        SELECT certificate_id
        FROM CT_ORDER_CERTIFICA oc
        WHERE oc.order_id = inuOrden;
        
        PROCEDURE prcCierraCursor
        IS
        BEGIN
        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
            IF cuExisteRegistroOrden%ISOPEN THEN
                CLOSE cuExisteRegistroOrden;
            END IF;
           
        END prcCierraCursor;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuExisteRegistroOrden;
        FETCH cuExisteRegistroOrden INTO nuCertificado;
        CLOSE  cuExisteRegistroOrden;

        blExisteRegistroOrden := nuCertificado IS NOT NULL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blExisteRegistroOrden;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN blExisteRegistroOrden;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN blExisteRegistroOrden;
    END fblExisteRegistroOrden;    
    
END pkg_ct_order_certifica;
/

BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ct_order_certifica'), UPPER('adm_person'));
END;
/

