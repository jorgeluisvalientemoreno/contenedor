CREATE OR REPLACE PACKAGE adm_person.pkg_or_related_order AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_RELATED_ORDER%ROWTYPE INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : OR_RELATED_ORDER
        Caso  : OSF-2204
        Fecha : 08/07/2024 15:00:51
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_RELATED_ORDER tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        RELATED_ORDER_ID = inuRELATED_ORDER_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_RELATED_ORDER tb
        WHERE
        ORDER_ID = inuORDER_ID AND
        RELATED_ORDER_ID = inuRELATED_ORDER_ID
        FOR UPDATE NOWAIT;
     
    FUNCTION ftbObtRowIdsxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRowIds;
    FUNCTION ftbObtRegistrosxCond(
        isbCondicion VARCHAR2
    ) RETURN tytbRegistros;
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    ) RETURN BOOLEAN;
 
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    );
 
    PROCEDURE prinsRegistro( ircRegistro OR_RELATED_ORDER%ROWTYPE, oRowId OUT ROWID);
 
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    );
 
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    PROCEDURE prBorRegistroxCond(
        isbCondicion VARCHAR2,
        inuCantMaxima NUMBER DEFAULT 10
    );
 
    FUNCTION fnuObtRELA_ORDER_TYPE_ID(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
        ) RETURN OR_RELATED_ORDER.RELA_ORDER_TYPE_ID%TYPE;
 
    PROCEDURE prAcRELA_ORDER_TYPE_ID(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER,
        inuRELA_ORDER_TYPE_ID    NUMBER
    );
 
    PROCEDURE prActRegistro( ircRegistro OR_RELATED_ORDER%ROWTYPE);

  --Funcion que retorna orden padre relacionada con al orden Hija
  FUNCTION fnuObtOrdenPadre(inuOrdenHija NUMBER)
    RETURN OR_RELATED_ORDER.ORDER_ID%TYPE;

END pkg_or_related_order;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_related_order AS
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
        sbSentencia := 'SELECT tb.ROWID FROM OR_RELATED_ORDER tb WHERE ';
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
        sbSentencia := 'SELECT tb.* FROM OR_RELATED_ORDER tb WHERE ';
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
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID,inuRELATED_ORDER_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID,inuRELATED_ORDER_ID);
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
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID,inuRELATED_ORDER_ID);
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
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID,inuRELATED_ORDER_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||','||inuRELATED_ORDER_ID||'] en la tabla[OR_RELATED_ORDER]');
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
 
    PROCEDURE prInsRegistro( ircRegistro OR_RELATED_ORDER%ROWTYPE, oRowId OUT ROWID) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_RELATED_ORDER(
            ORDER_ID,RELATED_ORDER_ID,RELA_ORDER_TYPE_ID
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.RELATED_ORDER_ID,ircRegistro.RELA_ORDER_TYPE_ID
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
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuRELATED_ORDER_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_RELATED_ORDER
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
            DELETE OR_RELATED_ORDER
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
    FUNCTION fnuObtRELA_ORDER_TYPE_ID(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER
        ) RETURN OR_RELATED_ORDER.RELA_ORDER_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtRELA_ORDER_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuRELATED_ORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RELA_ORDER_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtRELA_ORDER_TYPE_ID;
 
    PROCEDURE prAcRELA_ORDER_TYPE_ID(
        inuORDER_ID    NUMBER,inuRELATED_ORDER_ID    NUMBER,
        inuRELA_ORDER_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRELA_ORDER_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,inuRELATED_ORDER_ID,TRUE);
        IF NVL(inuRELA_ORDER_TYPE_ID,-1) <> NVL(rcRegistroAct.RELA_ORDER_TYPE_ID,-1) THEN
            UPDATE OR_RELATED_ORDER
            SET RELA_ORDER_TYPE_ID=inuRELA_ORDER_TYPE_ID
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
    END prAcRELA_ORDER_TYPE_ID;
 
    PROCEDURE prAcRELA_ORDER_TYPE_ID_RId(
        iRowId ROWID,
        inuRELA_ORDER_TYPE_ID_O    NUMBER,
        inuRELA_ORDER_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRELA_ORDER_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuRELA_ORDER_TYPE_ID_O,-1) <> NVL(inuRELA_ORDER_TYPE_ID_N,-1) THEN
            UPDATE OR_RELATED_ORDER
            SET RELA_ORDER_TYPE_ID=inuRELA_ORDER_TYPE_ID_N
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
    END prAcRELA_ORDER_TYPE_ID_RId;
 
    PROCEDURE prActRegistro( ircRegistro OR_RELATED_ORDER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,ircRegistro.RELATED_ORDER_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcRELA_ORDER_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RELA_ORDER_TYPE_ID,
                ircRegistro.RELA_ORDER_TYPE_ID
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

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Funcion     : fnuObtOrdenPadre
  Descripcion : Servicio que retorna orden padre relacionada con al orden Hija
  Autor       : Jorge Valiente
  Fecha       : 19-02-2025
  
  Parametros de Entrada
             inuOrdenHija  Orden Hija
  
  Parametros de Salida
             nuOrdenPadre  Orden Padre
                  
  Modificaciones  :
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************/
  FUNCTION fnuObtOrdenPadre(inuOrdenHija NUMBER)
    RETURN OR_RELATED_ORDER.ORDER_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtOrdenPadre';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    nuOrdenPadre NUMBER := NULL;
  
    CURSOR cuOrdenPadre IS
      SELECT tb.order_id
        FROM OR_RELATED_ORDER tb
       WHERE RELATED_ORDER_ID = inuOrdenHija;
  
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    OPEN cuOrdenPadre;
    FETCH cuOrdenPadre
      INTO nuOrdenPadre;
    CLOSE cuOrdenPadre;
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN nuOrdenPadre;
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RETURN nuOrdenPadre;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RETURN nuOrdenPadre;
  END fnuObtOrdenPadre;

END pkg_or_related_order;
/
BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_or_related_order'), UPPER('adm_person'));
END;
/
