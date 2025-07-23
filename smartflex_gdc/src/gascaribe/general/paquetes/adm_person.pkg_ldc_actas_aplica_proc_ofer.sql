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
        Modificaciones
        Fecha       Autor       Caso        Descrición
        17/03/2025  jpinedc     OSF-4123    * Se modifica prInsRegistro
                                            * Se borran ftbObtRowIdsxCond,
                                            ftbObtRegistrosxCond, 
                                            prBorRegistroxCond          
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

    -- Obtiene el registro y el RowID
    FUNCTION frcObtRegistroRId(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe un registro con la llave primaria
    FUNCTION fblExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    ) RETURN BOOLEAN;

    -- Eleva mensaje de error si NO existe un registro con la llave primaria 
    PROCEDURE prValExiste(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    );
 
    -- Inserta un registro en LDC_ACTAS_APLICA_PROC_OFERT
    PROCEDURE prinsRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE);

    -- Borra el registro que tenga la la llave primaria  
    PROCEDURE prBorRegistro(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
    );

    -- Borra el registro que tenga el RowId   
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna NOVGENERA
    FUNCTION fnuObtNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.NOVGENERA%TYPE;

    -- Obtiene el valor de la columna TOTAL_NOVE 
    FUNCTION fnuObtTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.TOTAL_NOVE%TYPE;
 
    -- Obtiene el valor de la columna USUARIO
    FUNCTION fsbObtUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.USUARIO%TYPE;

    -- Obtiene el valor de la columna FECHA
    FUNCTION fdtObtFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2
        ) RETURN LDC_ACTAS_APLICA_PROC_OFERT.FECHA%TYPE;
 
    -- Actualiza el valor de la columna NOVGENERA
    PROCEDURE prAcNOVGENERA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuNOVGENERA    NUMBER
    );
 
    -- Actualiza el valor de la columna TOTAL_NOVE
    PROCEDURE prAcTOTAL_NOVE(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        inuTOTAL_NOVE    NUMBER
    );
 
    -- Actualiza el valor de la columna USUARIO
    PROCEDURE prAcUSUARIO(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        isbUSUARIO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA
    PROCEDURE prAcFECHA(
        inuACTA    NUMBER,isbPROCEJEC    VARCHAR2,
        idtFECHA    DATE
    );
 
    -- Actualiza las columnas cuyo valor ha cambiado
    PROCEDURE prActRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE);
 
END PKG_LDC_ACTAS_APLICA_PROC_OFER;
/

CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_ACTAS_APLICA_PROC_OFER AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Obtiene el registro y el RowID
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

    -- Retorna verdadero si existe un registro con la llave primaria 
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
 
    -- Eleva mensaje de error si NO existe un registro con la llave primaria 
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

    -- Inserta un registro en LDC_ACTAS_APLICA_PROC_OFERT 
    PROCEDURE prInsRegistro( ircRegistro LDC_ACTAS_APLICA_PROC_OFERT%ROWTYPE ) IS
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

    -- Borra el registro que tenga la la llave primaria   
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

    -- Obtiene el valor de la columna NOVGENERA
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

    -- Obtiene el valor de la columna TOTAL_NOVE  
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

    -- Obtiene el valor de la columna USUARIO 
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

    -- Obtiene el valor de la columna FECHA 
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

    -- Actualiza el valor de la columna NOVGENERA 
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

    -- Actualiza el valor de la columna TOTAL_NOVE 
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

    -- Actualiza el valor de la columna USUARIO 
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

    -- Actualiza el valor de la columna FECHA 
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

    -- Actualiza las columnas cuyo valor ha cambiado 
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

