CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_UNI_ACT_OT AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_UNI_ACT_OT%ROWTYPE INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : LDC_UNI_ACT_OT
        Caso  : OSF-2204
        Fecha : 12/07/2024 07:46:16
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_UNI_ACT_OT tb
        WHERE
        UNIDAD_OPERATIVA = inuUNIDAD_OPERATIVA AND
        ORDEN = inuORDEN AND
        ACTIVIDAD = inuACTIVIDAD AND
        ITEM = inuITEM;
     
    CURSOR cuRegistroRIdLock
    (
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_UNI_ACT_OT tb
        WHERE
        UNIDAD_OPERATIVA = inuUNIDAD_OPERATIVA AND
        ORDEN = inuORDEN AND
        ACTIVIDAD = inuACTIVIDAD AND
        ITEM = inuITEM
        FOR UPDATE NOWAIT;
     
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds;
    FUNCTION ftbObtRegistrosxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRegistros;
    FUNCTION frcObtRegistroRId(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    FUNCTION fblExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    ) RETURN BOOLEAN;
 
    PROCEDURE prValExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    );
 
    PROCEDURE prinsRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE, oRowId OUT ROWID);
 
    PROCEDURE prBorRegistro(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    );
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    );
 
    FUNCTION fnuObtNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NUSSESION%TYPE;
 
    FUNCTION fsbObtLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.LIQUIDACION%TYPE;
 
    FUNCTION fnuObtCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.CANTIDAD_ITEM_LEGALIZADA%TYPE;
 
    FUNCTION fnuObtNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NRO_ACTA%TYPE;
 
    FUNCTION fnuObtUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.UNIDAD_OPERATIVA_PADRE%TYPE;
 
    FUNCTION fnuObtZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.ZONA_OFERTADOS%TYPE;
 
    FUNCTION fnuObtIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDENTIFICADOR_REG%TYPE;
 
    FUNCTION fnuObtIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDRANGOOFER%TYPE;
 
    PROCEDURE prAcNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNUSSESION    NUMBER
    );
 
    PROCEDURE prAcLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        isbLIQUIDACION    VARCHAR2
    );
 
    PROCEDURE prAcCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuCANTIDAD_ITEM_LEGALIZADA    NUMBER
    );
 
    PROCEDURE prAcNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNRO_ACTA    NUMBER
    );
 
    PROCEDURE prAcUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuUNIDAD_OPERATIVA_PADRE    NUMBER
    );
 
    PROCEDURE prAcZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuZONA_OFERTADOS    NUMBER
    );
 
    PROCEDURE prAcIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDENTIFICADOR_REG    NUMBER
    );
 
    PROCEDURE prAcIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDRANGOOFER    NUMBER
    );
 
    PROCEDURE prActRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE);
 
END PKG_LDC_UNI_ACT_OT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_UNI_ACT_OT AS
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
        sbSentencia := 'SELECT tb.ROWID FROM LDC_UNI_ACT_OT tb WHERE ';
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
        sbSentencia := 'SELECT tb.* FROM LDC_UNI_ACT_OT tb WHERE ';
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
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
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
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.UNIDAD_OPERATIVA IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuUNIDAD_OPERATIVA||','||inuORDEN||','||inuACTIVIDAD||','||inuITEM||'] en la tabla[LDC_UNI_ACT_OT]');
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
 
    PROCEDURE prInsRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE, oRowId OUT ROWID) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_UNI_ACT_OT(
            UNIDAD_OPERATIVA,ACTIVIDAD,ORDEN,NUSSESION,ITEM,LIQUIDACION,CANTIDAD_ITEM_LEGALIZADA,NRO_ACTA,UNIDAD_OPERATIVA_PADRE,ZONA_OFERTADOS,IDENTIFICADOR_REG,IDRANGOOFER
        )
        VALUES (
            ircRegistro.UNIDAD_OPERATIVA,ircRegistro.ACTIVIDAD,ircRegistro.ORDEN,ircRegistro.NUSSESION,ircRegistro.ITEM,ircRegistro.LIQUIDACION,ircRegistro.CANTIDAD_ITEM_LEGALIZADA,ircRegistro.NRO_ACTA,ircRegistro.UNIDAD_OPERATIVA_PADRE,ircRegistro.ZONA_OFERTADOS,ircRegistro.IDENTIFICADOR_REG,ircRegistro.IDRANGOOFER
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
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_UNI_ACT_OT
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
            DELETE LDC_UNI_ACT_OT
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
    FUNCTION fnuObtNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NUSSESION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNUSSESION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NUSSESION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtNUSSESION;
 
    FUNCTION fsbObtLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.LIQUIDACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtLIQUIDACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LIQUIDACION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtLIQUIDACION;
 
    FUNCTION fnuObtCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.CANTIDAD_ITEM_LEGALIZADA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCANTIDAD_ITEM_LEGALIZADA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CANTIDAD_ITEM_LEGALIZADA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCANTIDAD_ITEM_LEGALIZADA;
 
    FUNCTION fnuObtNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NRO_ACTA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNRO_ACTA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NRO_ACTA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtNRO_ACTA;
 
    FUNCTION fnuObtUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.UNIDAD_OPERATIVA_PADRE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUNIDAD_OPERATIVA_PADRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UNIDAD_OPERATIVA_PADRE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtUNIDAD_OPERATIVA_PADRE;
 
    FUNCTION fnuObtZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.ZONA_OFERTADOS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtZONA_OFERTADOS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ZONA_OFERTADOS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtZONA_OFERTADOS;
 
    FUNCTION fnuObtIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDENTIFICADOR_REG%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtIDENTIFICADOR_REG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IDENTIFICADOR_REG;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtIDENTIFICADOR_REG;
 
    FUNCTION fnuObtIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDRANGOOFER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtIDRANGOOFER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IDRANGOOFER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtIDRANGOOFER;
 
    PROCEDURE prAcNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNUSSESION    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUSSESION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuNUSSESION,-1) <> NVL(rcRegistroAct.NUSSESION,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET NUSSESION=inuNUSSESION
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
    END prAcNUSSESION;
 
    PROCEDURE prAcLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        isbLIQUIDACION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLIQUIDACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(isbLIQUIDACION,'-') <> NVL(rcRegistroAct.LIQUIDACION,'-') THEN
            UPDATE LDC_UNI_ACT_OT
            SET LIQUIDACION=isbLIQUIDACION
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
    END prAcLIQUIDACION;
 
    PROCEDURE prAcCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuCANTIDAD_ITEM_LEGALIZADA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCANTIDAD_ITEM_LEGALIZADA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuCANTIDAD_ITEM_LEGALIZADA,-1) <> NVL(rcRegistroAct.CANTIDAD_ITEM_LEGALIZADA,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET CANTIDAD_ITEM_LEGALIZADA=inuCANTIDAD_ITEM_LEGALIZADA
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
    END prAcCANTIDAD_ITEM_LEGALIZADA;
 
    PROCEDURE prAcNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNRO_ACTA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNRO_ACTA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuNRO_ACTA,-1) <> NVL(rcRegistroAct.NRO_ACTA,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET NRO_ACTA=inuNRO_ACTA
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
    END prAcNRO_ACTA;
 
    PROCEDURE prAcUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuUNIDAD_OPERATIVA_PADRE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIDAD_OPERATIVA_PADRE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuUNIDAD_OPERATIVA_PADRE,-1) <> NVL(rcRegistroAct.UNIDAD_OPERATIVA_PADRE,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET UNIDAD_OPERATIVA_PADRE=inuUNIDAD_OPERATIVA_PADRE
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
    END prAcUNIDAD_OPERATIVA_PADRE;
 
    PROCEDURE prAcZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuZONA_OFERTADOS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcZONA_OFERTADOS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuZONA_OFERTADOS,-1) <> NVL(rcRegistroAct.ZONA_OFERTADOS,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET ZONA_OFERTADOS=inuZONA_OFERTADOS
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
    END prAcZONA_OFERTADOS;
 
    PROCEDURE prAcIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDENTIFICADOR_REG    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIDENTIFICADOR_REG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuIDENTIFICADOR_REG,-1) <> NVL(rcRegistroAct.IDENTIFICADOR_REG,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET IDENTIFICADOR_REG=inuIDENTIFICADOR_REG
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
    END prAcIDENTIFICADOR_REG;
 
    PROCEDURE prAcIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDRANGOOFER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIDRANGOOFER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuORDEN,inuACTIVIDAD,inuITEM,TRUE);
        IF NVL(inuIDRANGOOFER,-1) <> NVL(rcRegistroAct.IDRANGOOFER,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET IDRANGOOFER=inuIDRANGOOFER
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
    END prAcIDRANGOOFER;
 
    PROCEDURE prAcNUSSESION_RId(
        iRowId ROWID,
        inuNUSSESION_O    NUMBER,
        inuNUSSESION_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUSSESION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNUSSESION_O,-1) <> NVL(inuNUSSESION_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET NUSSESION=inuNUSSESION_N
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
    END prAcNUSSESION_RId;
 
    PROCEDURE prAcLIQUIDACION_RId(
        iRowId ROWID,
        isbLIQUIDACION_O    VARCHAR2,
        isbLIQUIDACION_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLIQUIDACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbLIQUIDACION_O,'-') <> NVL(isbLIQUIDACION_N,'-') THEN
            UPDATE LDC_UNI_ACT_OT
            SET LIQUIDACION=isbLIQUIDACION_N
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
    END prAcLIQUIDACION_RId;
 
    PROCEDURE prAcCANTIDAD_ITEM_LEGALIZADA_R(
        iRowId ROWID,
        inuCANTIDAD_ITEM_LEGALIZADA_O    NUMBER,
        inuCANTIDAD_ITEM_LEGALIZADA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCANTIDAD_ITEM_LEGALIZADA_R';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCANTIDAD_ITEM_LEGALIZADA_O,-1) <> NVL(inuCANTIDAD_ITEM_LEGALIZADA_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET CANTIDAD_ITEM_LEGALIZADA=inuCANTIDAD_ITEM_LEGALIZADA_N
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
    END prAcCANTIDAD_ITEM_LEGALIZADA_R;
 
    PROCEDURE prAcNRO_ACTA_RId(
        iRowId ROWID,
        inuNRO_ACTA_O    NUMBER,
        inuNRO_ACTA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNRO_ACTA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNRO_ACTA_O,-1) <> NVL(inuNRO_ACTA_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET NRO_ACTA=inuNRO_ACTA_N
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
    END prAcNRO_ACTA_RId;
 
    PROCEDURE prAcUNIDAD_OPERATIVA_PADRE_RId(
        iRowId ROWID,
        inuUNIDAD_OPERATIVA_PADRE_O    NUMBER,
        inuUNIDAD_OPERATIVA_PADRE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIDAD_OPERATIVA_PADRE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuUNIDAD_OPERATIVA_PADRE_O,-1) <> NVL(inuUNIDAD_OPERATIVA_PADRE_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET UNIDAD_OPERATIVA_PADRE=inuUNIDAD_OPERATIVA_PADRE_N
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
    END prAcUNIDAD_OPERATIVA_PADRE_RId;
 
    PROCEDURE prAcZONA_OFERTADOS_RId(
        iRowId ROWID,
        inuZONA_OFERTADOS_O    NUMBER,
        inuZONA_OFERTADOS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcZONA_OFERTADOS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuZONA_OFERTADOS_O,-1) <> NVL(inuZONA_OFERTADOS_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET ZONA_OFERTADOS=inuZONA_OFERTADOS_N
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
    END prAcZONA_OFERTADOS_RId;
 
    PROCEDURE prAcIDENTIFICADOR_REG_RId(
        iRowId ROWID,
        inuIDENTIFICADOR_REG_O    NUMBER,
        inuIDENTIFICADOR_REG_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIDENTIFICADOR_REG_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuIDENTIFICADOR_REG_O,-1) <> NVL(inuIDENTIFICADOR_REG_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET IDENTIFICADOR_REG=inuIDENTIFICADOR_REG_N
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
    END prAcIDENTIFICADOR_REG_RId;
 
    PROCEDURE prAcIDRANGOOFER_RId(
        iRowId ROWID,
        inuIDRANGOOFER_O    NUMBER,
        inuIDRANGOOFER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIDRANGOOFER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuIDRANGOOFER_O,-1) <> NVL(inuIDRANGOOFER_N,-1) THEN
            UPDATE LDC_UNI_ACT_OT
            SET IDRANGOOFER=inuIDRANGOOFER_N
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
    END prAcIDRANGOOFER_RId;
 
    PROCEDURE prActRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.UNIDAD_OPERATIVA,ircRegistro.ORDEN,ircRegistro.ACTIVIDAD,ircRegistro.ITEM,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcNUSSESION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NUSSESION,
                ircRegistro.NUSSESION
            );
 
            prAcLIQUIDACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LIQUIDACION,
                ircRegistro.LIQUIDACION
            );
 
            prAcCANTIDAD_ITEM_LEGALIZADA_R(
                rcRegistroAct.RowId,
                rcRegistroAct.CANTIDAD_ITEM_LEGALIZADA,
                ircRegistro.CANTIDAD_ITEM_LEGALIZADA
            );
 
            prAcNRO_ACTA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NRO_ACTA,
                ircRegistro.NRO_ACTA
            );
 
            prAcUNIDAD_OPERATIVA_PADRE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UNIDAD_OPERATIVA_PADRE,
                ircRegistro.UNIDAD_OPERATIVA_PADRE
            );
 
            prAcZONA_OFERTADOS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ZONA_OFERTADOS,
                ircRegistro.ZONA_OFERTADOS
            );
 
            prAcIDENTIFICADOR_REG_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IDENTIFICADOR_REG,
                ircRegistro.IDENTIFICADOR_REG
            );
 
            prAcIDRANGOOFER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IDRANGOOFER,
                ircRegistro.IDRANGOOFER
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
 
END PKG_LDC_UNI_ACT_OT;
/
BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_UNI_ACT_OT'), UPPER('adm_person'));
END;
/