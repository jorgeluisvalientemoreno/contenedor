CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_REPORTE_OFERT_ESCALO AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_REPORTE_OFERT_ESCALO%ROWTYPE INDEX BY BINARY_INTEGER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GenereraPaqueteN1
        Tabla : LDC_REPORTE_OFERT_ESCALO
        Caso  : OSF-2204
        Fecha : 12/07/2024 08:00:15
        Modificaciones
        Fecha       Autor       Caso        Descrición
        17/03/2025  jpinedc     OSF-4123    * Se modifica prInsRegistro
                                            * Se borran ftbObtRowIdsxCond,
                                            ftbObtRegistrosxCond, 
                                            prBorRegistroxCond       
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_REPORTE_OFERT_ESCALO tb
        WHERE
        NUSESION = inuNUSESION AND
        NRO_ACTA = inuNRO_ACTA AND
        IDEN_REGI = inuIDEN_REGI;
     
    CURSOR cuRegistroRIdLock
    (
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_REPORTE_OFERT_ESCALO tb
        WHERE
        NUSESION = inuNUSESION AND
        NRO_ACTA = inuNRO_ACTA AND
        IDEN_REGI = inuIDEN_REGI
        FOR UPDATE NOWAIT;

    -- Obtiene el registro y su RowId
    FUNCTION frcObtRegistroRId(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe un registro con la llave primaria
    FUNCTION fblExiste(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    ) RETURN BOOLEAN;

    -- Eleva un mensaje de error si NO existe un registro con la llave primaria 
    PROCEDURE prValExiste(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    );
 
    -- Inserta un registro en LDC_REPORTE_OFERT_ESCALO
    PROCEDURE prinsRegistro( ircRegistro LDC_REPORTE_OFERT_ESCALO%ROWTYPE );
 
    -- Borra el registro que tenga la llave primaria
    PROCEDURE prBorRegistro(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    );
  
    -- Obtiene el valor de la columna UNIDAD_OPERATIVA_ESCA
    FUNCTION fnuObtUNIDAD_OPERATIVA_ESCA(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.UNIDAD_OPERATIVA_ESCA%TYPE;
 
    -- Obtiene el valor de la columna ACTIVIDAD_REP_ESCALONADO
    FUNCTION fnuObtACTIVIDAD_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.ACTIVIDAD_REP_ESCALONADO%TYPE;
 
    -- Obtiene el valor de la columna ITEM_REP_ESCALONADO
    FUNCTION fnuObtITEM_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.ITEM_REP_ESCALONADO%TYPE;

    -- Obtiene el valor de la columna RANGO_INICIAL 
    FUNCTION fnuObtRANGO_INICIAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.RANGO_INICIAL%TYPE;
        
    -- Obtiene el valor de la columna RANGO_FINAL
    FUNCTION fnuObtRANGO_FINAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.RANGO_FINAL%TYPE;

    -- Obtiene el valor de la columna CANTIDAD_ORDENES
    FUNCTION fnuObtCANTIDAD_ORDENES(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.CANTIDAD_ORDENES%TYPE;

    -- Obtiene el valor de la columna VALOR_LIQUIDAR
    FUNCTION fnuObtVALOR_LIQUIDAR(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.VALOR_LIQUIDAR%TYPE;

    -- Obtiene el valor de la columna TOTAL_AJUSTE
    FUNCTION fnuObtTOTAL_AJUSTE(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.TOTAL_AJUSTE%TYPE;
 
    -- Actualiza el valor de la columna UNIDAD_OPERATIVA_ESCA
    PROCEDURE prAcUNIDAD_OPERATIVA_ESCA(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuUNIDAD_OPERATIVA_ESCA    NUMBER
    );

    -- Actualiza el valor de la columna ACTIVIDAD_REP_ESCALONADO
    PROCEDURE prAcACTIVIDAD_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuACTIVIDAD_REP_ESCALONADO    NUMBER
    );

    -- Actualiza el valor de la columna ITEM_REP_ESCALONADO
    PROCEDURE prAcITEM_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuITEM_REP_ESCALONADO    NUMBER
    );
    
    -- Actualiza el valor de la columna RANGO_INICIAL
    PROCEDURE prAcRANGO_INICIAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuRANGO_INICIAL    NUMBER
    );

    -- Actualiza el valor de la columna RANGO_FINAL
    PROCEDURE prAcRANGO_FINAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuRANGO_FINAL    NUMBER
    );

    -- Actualiza el valor de la columna CANTIDAD_ORDENES
    PROCEDURE prAcCANTIDAD_ORDENES(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuCANTIDAD_ORDENES    NUMBER
    );

    -- Actualiza el valor de la columna VALOR_LIQUIDAR
    PROCEDURE prAcVALOR_LIQUIDAR(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuVALOR_LIQUIDAR    NUMBER
    );

    -- Actualiza el valor de la columna TOTAL_AJUSTE
    PROCEDURE prAcTOTAL_AJUSTE(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuTOTAL_AJUSTE    NUMBER
    );

    -- Actualiza las columnas cuyo valor haya cambiado 
    PROCEDURE prActRegistro( ircRegistro LDC_REPORTE_OFERT_ESCALO%ROWTYPE);
 
END PKG_LDC_REPORTE_OFERT_ESCALO;
/

CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_REPORTE_OFERT_ESCALO AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Obtiene el registro y su RowId    
    FUNCTION frcObtRegistroRId(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
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
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.NUSESION IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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

    -- Eleva un mensaje de error si NO existe un registro con la llave primaria  
    PROCEDURE prValExiste(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuNUSESION||','||inuNRO_ACTA||','||inuIDEN_REGI||'] en la tabla[LDC_REPORTE_OFERT_ESCALO]');
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

    -- Inserta un registro en LDC_REPORTE_OFERT_ESCALO 
    PROCEDURE prInsRegistro( ircRegistro LDC_REPORTE_OFERT_ESCALO%ROWTYPE ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_REPORTE_OFERT_ESCALO(
            NUSESION,NRO_ACTA,IDEN_REGI,UNIDAD_OPERATIVA_ESCA,ACTIVIDAD_REP_ESCALONADO,ITEM_REP_ESCALONADO,RANGO_INICIAL,RANGO_FINAL,CANTIDAD_ORDENES,VALOR_LIQUIDAR,TOTAL_AJUSTE
        )
        VALUES (
            ircRegistro.NUSESION,ircRegistro.NRO_ACTA,ircRegistro.IDEN_REGI,ircRegistro.UNIDAD_OPERATIVA_ESCA,ircRegistro.ACTIVIDAD_REP_ESCALONADO,ircRegistro.ITEM_REP_ESCALONADO,ircRegistro.RANGO_INICIAL,ircRegistro.RANGO_FINAL,ircRegistro.CANTIDAD_ORDENES,ircRegistro.VALOR_LIQUIDAR,ircRegistro.TOTAL_AJUSTE
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
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_REPORTE_OFERT_ESCALO
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

    -- Obtiene el valor de la columna UNIDAD_OPERATIVA_ESCA 
    FUNCTION fnuObtUNIDAD_OPERATIVA_ESCA(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.UNIDAD_OPERATIVA_ESCA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUNIDAD_OPERATIVA_ESCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UNIDAD_OPERATIVA_ESCA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtUNIDAD_OPERATIVA_ESCA;

    -- Obtiene el valor de la columna ACTIVIDAD_REP_ESCALONADO 
    FUNCTION fnuObtACTIVIDAD_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.ACTIVIDAD_REP_ESCALONADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtACTIVIDAD_REP_ESCALONADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ACTIVIDAD_REP_ESCALONADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtACTIVIDAD_REP_ESCALONADO;

    -- Obtiene el valor de la columna ITEM_REP_ESCALONADO
    FUNCTION fnuObtITEM_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.ITEM_REP_ESCALONADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtITEM_REP_ESCALONADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ITEM_REP_ESCALONADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtITEM_REP_ESCALONADO;
 
    -- Obtiene el valor de la columna RANGO_INICIAL
    FUNCTION fnuObtRANGO_INICIAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.RANGO_INICIAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtRANGO_INICIAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RANGO_INICIAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtRANGO_INICIAL;

    -- Obtiene el valor de la columna RANGO_FINAL 
    FUNCTION fnuObtRANGO_FINAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.RANGO_FINAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtRANGO_FINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RANGO_FINAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtRANGO_FINAL;
 
    -- Obtiene el valor de la columna CANTIDAD_ORDENES
    FUNCTION fnuObtCANTIDAD_ORDENES(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.CANTIDAD_ORDENES%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCANTIDAD_ORDENES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CANTIDAD_ORDENES;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCANTIDAD_ORDENES;
 
    -- Obtiene el valor de la columna VALOR_LIQUIDAR
    FUNCTION fnuObtVALOR_LIQUIDAR(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.VALOR_LIQUIDAR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtVALOR_LIQUIDAR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALOR_LIQUIDAR;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtVALOR_LIQUIDAR;

    -- Obtiene el valor de la columna TOTAL_AJUSTE
    FUNCTION fnuObtTOTAL_AJUSTE(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER
        ) RETURN LDC_REPORTE_OFERT_ESCALO.TOTAL_AJUSTE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTOTAL_AJUSTE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TOTAL_AJUSTE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtTOTAL_AJUSTE;

    -- Actualiza el valor de la columna UNIDAD_OPERATIVA_ESCA 
    PROCEDURE prAcUNIDAD_OPERATIVA_ESCA(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuUNIDAD_OPERATIVA_ESCA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIDAD_OPERATIVA_ESCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuUNIDAD_OPERATIVA_ESCA,-1) <> NVL(rcRegistroAct.UNIDAD_OPERATIVA_ESCA,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET UNIDAD_OPERATIVA_ESCA=inuUNIDAD_OPERATIVA_ESCA
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
    END prAcUNIDAD_OPERATIVA_ESCA;

    -- Actualiza el valor de la columna ACTIVIDAD_REP_ESCALONADO 
    PROCEDURE prAcACTIVIDAD_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuACTIVIDAD_REP_ESCALONADO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVIDAD_REP_ESCALONADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuACTIVIDAD_REP_ESCALONADO,-1) <> NVL(rcRegistroAct.ACTIVIDAD_REP_ESCALONADO,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET ACTIVIDAD_REP_ESCALONADO=inuACTIVIDAD_REP_ESCALONADO
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
    END prAcACTIVIDAD_REP_ESCALONADO;

    -- Actualiza el valor de la columna ITEM_REP_ESCALONADO 
    PROCEDURE prAcITEM_REP_ESCALONADO(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuITEM_REP_ESCALONADO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_REP_ESCALONADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuITEM_REP_ESCALONADO,-1) <> NVL(rcRegistroAct.ITEM_REP_ESCALONADO,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET ITEM_REP_ESCALONADO=inuITEM_REP_ESCALONADO
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
    END prAcITEM_REP_ESCALONADO;

    -- Actualiza el valor de la columna RANGO_INICIAL 
    PROCEDURE prAcRANGO_INICIAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuRANGO_INICIAL    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRANGO_INICIAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuRANGO_INICIAL,-1) <> NVL(rcRegistroAct.RANGO_INICIAL,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET RANGO_INICIAL=inuRANGO_INICIAL
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
    END prAcRANGO_INICIAL;

    -- Actualiza el valor de la columna RANGO_FINAL 
    PROCEDURE prAcRANGO_FINAL(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuRANGO_FINAL    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRANGO_FINAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuRANGO_FINAL,-1) <> NVL(rcRegistroAct.RANGO_FINAL,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET RANGO_FINAL=inuRANGO_FINAL
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
    END prAcRANGO_FINAL;

    -- Actualiza el valor de la columna CANTIDAD_ORDENES 
    PROCEDURE prAcCANTIDAD_ORDENES(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuCANTIDAD_ORDENES    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCANTIDAD_ORDENES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuCANTIDAD_ORDENES,-1) <> NVL(rcRegistroAct.CANTIDAD_ORDENES,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET CANTIDAD_ORDENES=inuCANTIDAD_ORDENES
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
    END prAcCANTIDAD_ORDENES;

    -- Actualiza el valor de la columna VALOR_LIQUIDAR 
    PROCEDURE prAcVALOR_LIQUIDAR(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuVALOR_LIQUIDAR    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_LIQUIDAR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuVALOR_LIQUIDAR,-1) <> NVL(rcRegistroAct.VALOR_LIQUIDAR,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET VALOR_LIQUIDAR=inuVALOR_LIQUIDAR
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
    END prAcVALOR_LIQUIDAR;

    -- Actualiza el valor de la columna TOTAL_AJUSTE 
    PROCEDURE prAcTOTAL_AJUSTE(
        inuNUSESION    NUMBER,inuNRO_ACTA    NUMBER,inuIDEN_REGI    NUMBER,
        inuTOTAL_AJUSTE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTOTAL_AJUSTE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuNUSESION,inuNRO_ACTA,inuIDEN_REGI,TRUE);
        IF NVL(inuTOTAL_AJUSTE,-1) <> NVL(rcRegistroAct.TOTAL_AJUSTE,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET TOTAL_AJUSTE=inuTOTAL_AJUSTE
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
    END prAcTOTAL_AJUSTE;
 
    PROCEDURE prAcUNIDAD_OPERATIVA_ESCA_RId(
        iRowId ROWID,
        inuUNIDAD_OPERATIVA_ESCA_O    NUMBER,
        inuUNIDAD_OPERATIVA_ESCA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIDAD_OPERATIVA_ESCA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuUNIDAD_OPERATIVA_ESCA_O,-1) <> NVL(inuUNIDAD_OPERATIVA_ESCA_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET UNIDAD_OPERATIVA_ESCA=inuUNIDAD_OPERATIVA_ESCA_N
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
    END prAcUNIDAD_OPERATIVA_ESCA_RId;
 
    PROCEDURE prAcACTIVIDAD_REP_ESCALONADO_R(
        iRowId ROWID,
        inuACTIVIDAD_REP_ESCALONADO_O    NUMBER,
        inuACTIVIDAD_REP_ESCALONADO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVIDAD_REP_ESCALONADO_R';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuACTIVIDAD_REP_ESCALONADO_O,-1) <> NVL(inuACTIVIDAD_REP_ESCALONADO_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET ACTIVIDAD_REP_ESCALONADO=inuACTIVIDAD_REP_ESCALONADO_N
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
    END prAcACTIVIDAD_REP_ESCALONADO_R;
 
    PROCEDURE prAcITEM_REP_ESCALONADO_RId(
        iRowId ROWID,
        inuITEM_REP_ESCALONADO_O    NUMBER,
        inuITEM_REP_ESCALONADO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_REP_ESCALONADO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuITEM_REP_ESCALONADO_O,-1) <> NVL(inuITEM_REP_ESCALONADO_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET ITEM_REP_ESCALONADO=inuITEM_REP_ESCALONADO_N
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
    END prAcITEM_REP_ESCALONADO_RId;
 
    PROCEDURE prAcRANGO_INICIAL_RId(
        iRowId ROWID,
        inuRANGO_INICIAL_O    NUMBER,
        inuRANGO_INICIAL_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRANGO_INICIAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuRANGO_INICIAL_O,-1) <> NVL(inuRANGO_INICIAL_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET RANGO_INICIAL=inuRANGO_INICIAL_N
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
    END prAcRANGO_INICIAL_RId;
 
    PROCEDURE prAcRANGO_FINAL_RId(
        iRowId ROWID,
        inuRANGO_FINAL_O    NUMBER,
        inuRANGO_FINAL_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRANGO_FINAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuRANGO_FINAL_O,-1) <> NVL(inuRANGO_FINAL_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET RANGO_FINAL=inuRANGO_FINAL_N
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
    END prAcRANGO_FINAL_RId;
 
    PROCEDURE prAcCANTIDAD_ORDENES_RId(
        iRowId ROWID,
        inuCANTIDAD_ORDENES_O    NUMBER,
        inuCANTIDAD_ORDENES_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCANTIDAD_ORDENES_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCANTIDAD_ORDENES_O,-1) <> NVL(inuCANTIDAD_ORDENES_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET CANTIDAD_ORDENES=inuCANTIDAD_ORDENES_N
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
    END prAcCANTIDAD_ORDENES_RId;
 
    PROCEDURE prAcVALOR_LIQUIDAR_RId(
        iRowId ROWID,
        inuVALOR_LIQUIDAR_O    NUMBER,
        inuVALOR_LIQUIDAR_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALOR_LIQUIDAR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuVALOR_LIQUIDAR_O,-1) <> NVL(inuVALOR_LIQUIDAR_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET VALOR_LIQUIDAR=inuVALOR_LIQUIDAR_N
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
    END prAcVALOR_LIQUIDAR_RId;
 
    PROCEDURE prAcTOTAL_AJUSTE_RId(
        iRowId ROWID,
        inuTOTAL_AJUSTE_O    NUMBER,
        inuTOTAL_AJUSTE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTOTAL_AJUSTE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTOTAL_AJUSTE_O,-1) <> NVL(inuTOTAL_AJUSTE_N,-1) THEN
            UPDATE LDC_REPORTE_OFERT_ESCALO
            SET TOTAL_AJUSTE=inuTOTAL_AJUSTE_N
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
    END prAcTOTAL_AJUSTE_RId;
 
    PROCEDURE prActRegistro( ircRegistro LDC_REPORTE_OFERT_ESCALO%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.NUSESION,ircRegistro.NRO_ACTA,ircRegistro.IDEN_REGI,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcUNIDAD_OPERATIVA_ESCA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UNIDAD_OPERATIVA_ESCA,
                ircRegistro.UNIDAD_OPERATIVA_ESCA
            );
 
            prAcACTIVIDAD_REP_ESCALONADO_R(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTIVIDAD_REP_ESCALONADO,
                ircRegistro.ACTIVIDAD_REP_ESCALONADO
            );
 
            prAcITEM_REP_ESCALONADO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ITEM_REP_ESCALONADO,
                ircRegistro.ITEM_REP_ESCALONADO
            );
 
            prAcRANGO_INICIAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RANGO_INICIAL,
                ircRegistro.RANGO_INICIAL
            );
 
            prAcRANGO_FINAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RANGO_FINAL,
                ircRegistro.RANGO_FINAL
            );
 
            prAcCANTIDAD_ORDENES_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CANTIDAD_ORDENES,
                ircRegistro.CANTIDAD_ORDENES
            );
 
            prAcVALOR_LIQUIDAR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALOR_LIQUIDAR,
                ircRegistro.VALOR_LIQUIDAR
            );
 
            prAcTOTAL_AJUSTE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TOTAL_AJUSTE,
                ircRegistro.TOTAL_AJUSTE
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
 
END PKG_LDC_REPORTE_OFERT_ESCALO;
/

BEGIN
    -- OSF-2204
    pkg_Utilidades.prAplicarPermisos( UPPER('PKG_LDC_REPORTE_OFERT_ESCALO'), UPPER('adm_person'));
END;
/

