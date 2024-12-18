CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_ASIGNA_UNIDAD_REV_PER AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_ASIGNA_UNIDAD_REV_PER%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_ASIGNA_UNIDAD_REV_PER IS SELECT * FROM LDC_ASIGNA_UNIDAD_REV_PER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_ASIGNA_UNIDAD_REV_PER
        Caso  : OSF-3532
        Fecha : 28/10/2024 14:41:10
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ASIGNA_UNIDAD_REV_PER tb
        WHERE
        UNIDAD_OPERATIVA = inuUNIDAD_OPERATIVA AND
        PRODUCTO = inuPRODUCTO AND
        TIPO_TRABAJO = isbTIPO_TRABAJO AND
        ORDEN_TRABAJO = inuORDEN_TRABAJO AND
        SOLICITUD_GENERADA = inuSOLICITUD_GENERADA;
     
    CURSOR cuRegistroRIdLock
    (
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_ASIGNA_UNIDAD_REV_PER tb
        WHERE
        UNIDAD_OPERATIVA = inuUNIDAD_OPERATIVA AND
        PRODUCTO = inuPRODUCTO AND
        TIPO_TRABAJO = isbTIPO_TRABAJO AND
        ORDEN_TRABAJO = inuORDEN_TRABAJO AND
        SOLICITUD_GENERADA = inuSOLICITUD_GENERADA
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_ASIGNA_UNIDAD_REV_PER%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
  
END pkg_LDC_ASIGNA_UNIDAD_REV_PER;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_ASIGNA_UNIDAD_REV_PER AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuUNIDAD_OPERATIVA,inuPRODUCTO,isbTIPO_TRABAJO,inuORDEN_TRABAJO,inuSOLICITUD_GENERADA);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuUNIDAD_OPERATIVA,inuPRODUCTO,isbTIPO_TRABAJO,inuORDEN_TRABAJO,inuSOLICITUD_GENERADA);
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
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuPRODUCTO,isbTIPO_TRABAJO,inuORDEN_TRABAJO,inuSOLICITUD_GENERADA);
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
 
    -- Eleva error si el registro no existe
    PROCEDURE prValExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuUNIDAD_OPERATIVA,inuPRODUCTO,isbTIPO_TRABAJO,inuORDEN_TRABAJO,inuSOLICITUD_GENERADA) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuUNIDAD_OPERATIVA||','||inuPRODUCTO||','||isbTIPO_TRABAJO||','||inuORDEN_TRABAJO||','||inuSOLICITUD_GENERADA||'] en la tabla[LDC_ASIGNA_UNIDAD_REV_PER]');
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
    PROCEDURE prInsRegistro( ircRegistro cuLDC_ASIGNA_UNIDAD_REV_PER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_ASIGNA_UNIDAD_REV_PER(
            UNIDAD_OPERATIVA,PRODUCTO,TIPO_TRABAJO,ORDEN_TRABAJO,SOLICITUD_GENERADA
        )
        VALUES (
            ircRegistro.UNIDAD_OPERATIVA,ircRegistro.PRODUCTO,ircRegistro.TIPO_TRABAJO,ircRegistro.ORDEN_TRABAJO,ircRegistro.SOLICITUD_GENERADA
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
        inuUNIDAD_OPERATIVA    NUMBER,inuPRODUCTO    NUMBER,isbTIPO_TRABAJO    VARCHAR2,inuORDEN_TRABAJO    NUMBER,inuSOLICITUD_GENERADA    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuUNIDAD_OPERATIVA,inuPRODUCTO,isbTIPO_TRABAJO,inuORDEN_TRABAJO,inuSOLICITUD_GENERADA, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_ASIGNA_UNIDAD_REV_PER
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
            DELETE LDC_ASIGNA_UNIDAD_REV_PER
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
  
END pkg_LDC_ASIGNA_UNIDAD_REV_PER;
/

BEGIN
    -- OSF-3532
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_ASIGNA_UNIDAD_REV_PER'), UPPER('adm_person'));
END;
/

