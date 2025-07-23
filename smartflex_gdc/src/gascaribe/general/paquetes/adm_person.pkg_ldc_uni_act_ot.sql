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
        Modificaciones
        Fecha       Autor       Caso        Descrición
        17/03/2025  jpinedc     OSF-4123    * Se crea prBorrRegXSesYActa
                                            * Se modifica prInsRegistro
                                            * Se borran ftbObtRowIdsxCond,
                                            ftbObtRegistrosxCond, 
                                            prBorRegistroxCond
                                            * Se crea el cursor culdc_uni_act_ot
    ***************************************************************************/
    CURSOR culdc_uni_act_ot
    (
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    )
    IS
        SELECT tb.*
        FROM LDC_UNI_ACT_OT tb
        WHERE
        UNIDAD_OPERATIVA = inuUNIDAD_OPERATIVA AND
        ORDEN = inuORDEN AND
        ACTIVIDAD = inuACTIVIDAD AND
        ITEM = inuITEM;
        
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

    -- Obtiene un registro consultando con el rowid
    FUNCTION frcObtRegistroRId(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe un registro con la llave primaria
    FUNCTION fblExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    ) RETURN BOOLEAN;

    -- Eleva un mensaje de error si No existe un registro con la llave primaria 
    PROCEDURE prValExiste(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    );
 
    -- Inserta un registro en LDC_UNI_ACT_OT
    PROCEDURE prinsRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE );
 
    -- Borra el registro que tenga la llave primaria    
    PROCEDURE prBorRegistro(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
    );

    -- Borra el registro que tenga el RowId     
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
  
    -- Obtiene el valor de la columna NUSSESION
    FUNCTION fnuObtNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NUSSESION%TYPE;
 
    -- Obtiene el valor de la columna LIQUIDACION
    FUNCTION fsbObtLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.LIQUIDACION%TYPE;
 
    -- Obtiene el valor de la columna CANTIDAD_ITEM_LEGALIZADA
    FUNCTION fnuObtCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.CANTIDAD_ITEM_LEGALIZADA%TYPE;
 
    -- Obtiene el valor de la columna NRO_ACTA
    FUNCTION fnuObtNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.NRO_ACTA%TYPE;
 
    -- Obtiene el valor de la columna UNIDAD_OPERATIVA_PADRE
    FUNCTION fnuObtUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.UNIDAD_OPERATIVA_PADRE%TYPE;

    -- Obtiene el valor de la columna ZONA_OFERTADOS 
    FUNCTION fnuObtZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.ZONA_OFERTADOS%TYPE;

    -- Obtiene el valor de la columna IDENTIFICADOR_REG 
    FUNCTION fnuObtIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDENTIFICADOR_REG%TYPE;
 
    -- Obtiene el valor de la columna IDRANGOOFER 
    FUNCTION fnuObtIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER
        ) RETURN LDC_UNI_ACT_OT.IDRANGOOFER%TYPE;
 
    -- Actualiza el valor de la columna NUSSESION
    PROCEDURE prAcNUSSESION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNUSSESION    NUMBER
    );
 
    -- Actualiza el valor de la columna LIQUIDACION
    PROCEDURE prAcLIQUIDACION(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        isbLIQUIDACION    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CANTIDAD_ITEM_LEGALIZADA
    PROCEDURE prAcCANTIDAD_ITEM_LEGALIZADA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuCANTIDAD_ITEM_LEGALIZADA    NUMBER
    );

    -- Actualiza el valor de la columna NRO_ACTA 
    PROCEDURE prAcNRO_ACTA(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuNRO_ACTA    NUMBER
    );
 
    -- Actualiza el valor de la columna UNIDAD_OPERATIVA_PADRE
    PROCEDURE prAcUNIDAD_OPERATIVA_PADRE(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuUNIDAD_OPERATIVA_PADRE    NUMBER
    );
 
    -- Actualiza el valor de la columna ZONA_OFERTADOS
    PROCEDURE prAcZONA_OFERTADOS(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuZONA_OFERTADOS    NUMBER
    );
 
    -- Actualiza el valor de la columna IDENTIFICADOR_REG
    PROCEDURE prAcIDENTIFICADOR_REG(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDENTIFICADOR_REG    NUMBER
    );
 
    -- Actualiza el valor de la columna IDRANGOOFER
    PROCEDURE prAcIDRANGOOFER(
        inuUNIDAD_OPERATIVA    NUMBER,inuORDEN    NUMBER,inuACTIVIDAD    NUMBER,inuITEM    NUMBER,
        inuIDRANGOOFER    NUMBER
    );
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE);
    
    -- Borra registros por sesion  y acta
    PROCEDURE prBorRegxSesYacta( inuSesion NUMBER, inuActa NUMBER);    
 
END PKG_LDC_UNI_ACT_OT;
/

CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_UNI_ACT_OT AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Obtiene un registro consultando con el rowid 
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
 
    -- Retorna verdadero si existe un registro con la llave primaria
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
 
    -- Eleva un mensaje de error si No existe un registro con la llave primaria 
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
 
    -- Inserta un registro en LDC_UNI_ACT_OT
    PROCEDURE prInsRegistro( ircRegistro LDC_UNI_ACT_OT%ROWTYPE ) IS
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

    -- Borra el registro que tenga la llave primaria    
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

    -- Borra el registro que tenga el RowId    
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

    -- Obtiene el valor de la columna NUSSESION 
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

    -- Obtiene el valor de la columna LIQUIDACION 
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

    -- Obtiene el valor de la columna CANTIDAD_ITEM_LEGALIZADA 
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

    -- Obtiene el valor de la columna NRO_ACTA 
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
 
    -- Obtiene el valor de la columna UNIDAD_OPERATIVA_PADRE
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
 
    -- Obtiene el valor de la columna ZONA_OFERTADOS 
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

    -- Obtiene el valor de la columna IDENTIFICADOR_REG  
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

    -- Obtiene el valor de la columna IDRANGOOFER  
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
 
    -- Actualiza el valor de la columna NUSSESION
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

    -- Actualiza el valor de la columna LIQUIDACION 
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

    -- Actualiza el valor de la columna CANTIDAD_ITEM_LEGALIZADA 
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

    -- Actualiza el valor de la columna NRO_ACTA  
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

    -- Actualiza el valor de la columna UNIDAD_OPERATIVA_PADRE 
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

    -- Actualiza el valor de la columna ZONA_OFERTADOS 
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

    -- Actualiza el valor de la columna IDENTIFICADOR_REG 
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

    -- Actualiza el valor de la columna IDRANGOOFER 
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
 
    -- Actualiza las columnas con valor diferente al anterior
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
    
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro culdc_uni_act_ot%ROWTYPE) IS
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

    -- Borra registros por sesion  y acta
    PROCEDURE prBorRegxSesYacta( inuSesion NUMBER, inuActa NUMBER)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegxOrdActa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        DELETE ldc_uni_act_ot
        WHERE NUSSESION = inuSesion
        AND NRO_ACTA = inuActa;
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
    END prBorRegxSesYacta;    
 
END PKG_LDC_UNI_ACT_OT;
/

BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_UNI_ACT_OT'), UPPER('adm_person'));
END;
/

