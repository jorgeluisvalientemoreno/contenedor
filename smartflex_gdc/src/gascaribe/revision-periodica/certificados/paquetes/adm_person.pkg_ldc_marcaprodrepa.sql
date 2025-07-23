CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_MARCAPRODREPA AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_MARCAPRODREPA%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_MARCAPRODREPA IS SELECT * FROM LDC_MARCAPRODREPA;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_MARCAPRODREPA
        Caso  : OSF-3828
        Fecha : 08/01/2025 11:26:35
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuMARCA_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_MARCAPRODREPA tb
        WHERE
        MARCA_ID = inuMARCA_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuMARCA_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_MARCAPRODREPA tb
        WHERE
        MARCA_ID = inuMARCA_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuMARCA_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuMARCA_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuMARCA_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro IN OUT cuLDC_MARCAPRODREPA%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuMARCA_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PRODUCTO_ID
    FUNCTION fnuObtPRODUCTO_ID(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.PRODUCTO_ID%TYPE;
 
    -- Obtiene el valor de la columna ORDEN_ID
    FUNCTION fnuObtORDEN_ID(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.ORDEN_ID%TYPE;
 
    -- Obtiene el valor de la columna BLOQUEO
    FUNCTION fsbObtBLOQUEO(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.BLOQUEO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_BLOQUEO
    FUNCTION fdtObtFECHA_BLOQUEO(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.FECHA_BLOQUEO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_INACTIVACION
    FUNCTION fdtObtFECHA_INACTIVACION(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.FECHA_INACTIVACION%TYPE;
 
    -- Actualiza el valor de la columna PRODUCTO_ID
    PROCEDURE prAcPRODUCTO_ID(
        inuMARCA_ID    NUMBER,
        inuPRODUCTO_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ORDEN_ID
    PROCEDURE prAcORDEN_ID(
        inuMARCA_ID    NUMBER,
        inuORDEN_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna BLOQUEO
    PROCEDURE prAcBLOQUEO(
        inuMARCA_ID    NUMBER,
        isbBLOQUEO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_BLOQUEO
    PROCEDURE prAcFECHA_BLOQUEO(
        inuMARCA_ID    NUMBER,
        idtFECHA_BLOQUEO    DATE
    );
 
    -- Actualiza el valor de la columna FECHA_INACTIVACION
    PROCEDURE prAcFECHA_INACTIVACION(
        inuMARCA_ID    NUMBER,
        idtFECHA_INACTIVACION    DATE
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_MARCAPRODREPA%ROWTYPE);
    
    -- Obtiene nuevo identificador de secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER;
    
    -- Actualiza la fecha de Inactivacion y el flag de bloqueo
    PROCEDURE prAcFechInacBloqueo
    (
        inuProducto_Actual        NUMBER,
        isbBloqueo_Actual         VARCHAR2,
        idtFecha_Inactivacion     DATE,
        isbBloqueo_Nuevo          VARCHAR2
    );
    
    -- Retorna la cantidad de bloqueos que tiene el producto
    FUNCTION fnuCantidadBloqueos
    (
        inuProducto             NUMBER
    )
    RETURN NUMBER;        
 
END pkg_LDC_MARCAPRODREPA;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_MARCAPRODREPA AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuMARCA_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuMARCA_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuMARCA_ID);
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
        inuMARCA_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.MARCA_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuMARCA_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuMARCA_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuMARCA_ID||'] en la tabla[LDC_MARCAPRODREPA]');
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
    PROCEDURE prInsRegistro( ircRegistro IN OUT cuLDC_MARCAPRODREPA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF ircRegistro.MARCA_ID IS NULL THEN
            ircRegistro.MARCA_ID := fnuObtNuevoIdentificador;
        END IF;
        
        INSERT INTO LDC_MARCAPRODREPA(
            MARCA_ID,PRODUCTO_ID,ORDEN_ID,BLOQUEO,FECHA_BLOQUEO,FECHA_INACTIVACION
        )
        VALUES (
            ircRegistro.MARCA_ID,ircRegistro.PRODUCTO_ID,ircRegistro.ORDEN_ID,ircRegistro.BLOQUEO,ircRegistro.FECHA_BLOQUEO,ircRegistro.FECHA_INACTIVACION
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
        inuMARCA_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_MARCAPRODREPA
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
            DELETE LDC_MARCAPRODREPA
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
 
    -- Obtiene el valor de la columna PRODUCTO_ID
    FUNCTION fnuObtPRODUCTO_ID(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.PRODUCTO_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRODUCTO_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRODUCTO_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPRODUCTO_ID;
 
    -- Obtiene el valor de la columna ORDEN_ID
    FUNCTION fnuObtORDEN_ID(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.ORDEN_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDEN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDEN_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtORDEN_ID;
 
    -- Obtiene el valor de la columna BLOQUEO
    FUNCTION fsbObtBLOQUEO(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.BLOQUEO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtBLOQUEO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.BLOQUEO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtBLOQUEO;
 
    -- Obtiene el valor de la columna FECHA_BLOQUEO
    FUNCTION fdtObtFECHA_BLOQUEO(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.FECHA_BLOQUEO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_BLOQUEO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_BLOQUEO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_BLOQUEO;
 
    -- Obtiene el valor de la columna FECHA_INACTIVACION
    FUNCTION fdtObtFECHA_INACTIVACION(
        inuMARCA_ID    NUMBER
        ) RETURN LDC_MARCAPRODREPA.FECHA_INACTIVACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_INACTIVACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_INACTIVACION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_INACTIVACION;
 
    -- Actualiza el valor de la columna PRODUCTO_ID
    PROCEDURE prAcPRODUCTO_ID(
        inuMARCA_ID    NUMBER,
        inuPRODUCTO_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCTO_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID,TRUE);
        IF NVL(inuPRODUCTO_ID,-1) <> NVL(rcRegistroAct.PRODUCTO_ID,-1) THEN
            UPDATE LDC_MARCAPRODREPA
            SET PRODUCTO_ID=inuPRODUCTO_ID
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
    END prAcPRODUCTO_ID;
 
    -- Actualiza el valor de la columna ORDEN_ID
    PROCEDURE prAcORDEN_ID(
        inuMARCA_ID    NUMBER,
        inuORDEN_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDEN_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID,TRUE);
        IF NVL(inuORDEN_ID,-1) <> NVL(rcRegistroAct.ORDEN_ID,-1) THEN
            UPDATE LDC_MARCAPRODREPA
            SET ORDEN_ID=inuORDEN_ID
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
    END prAcORDEN_ID;
 
    -- Actualiza el valor de la columna BLOQUEO
    PROCEDURE prAcBLOQUEO(
        inuMARCA_ID    NUMBER,
        isbBLOQUEO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOQUEO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID,TRUE);
        IF NVL(isbBLOQUEO,'-') <> NVL(rcRegistroAct.BLOQUEO,'-') THEN
            UPDATE LDC_MARCAPRODREPA
            SET BLOQUEO=isbBLOQUEO
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
    END prAcBLOQUEO;
 
    -- Actualiza el valor de la columna FECHA_BLOQUEO
    PROCEDURE prAcFECHA_BLOQUEO(
        inuMARCA_ID    NUMBER,
        idtFECHA_BLOQUEO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_BLOQUEO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID,TRUE);
        IF NVL(idtFECHA_BLOQUEO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_BLOQUEO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_MARCAPRODREPA
            SET FECHA_BLOQUEO=idtFECHA_BLOQUEO
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
    END prAcFECHA_BLOQUEO;
 
    -- Actualiza el valor de la columna FECHA_INACTIVACION
    PROCEDURE prAcFECHA_INACTIVACION(
        inuMARCA_ID    NUMBER,
        idtFECHA_INACTIVACION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INACTIVACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuMARCA_ID,TRUE);
        IF NVL(idtFECHA_INACTIVACION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_INACTIVACION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_MARCAPRODREPA
            SET FECHA_INACTIVACION=idtFECHA_INACTIVACION
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
    END prAcFECHA_INACTIVACION;
 
    -- Actualiza por RowId el valor de la columna PRODUCTO_ID
    PROCEDURE prAcPRODUCTO_ID_RId(
        iRowId ROWID,
        inuPRODUCTO_ID_O    NUMBER,
        inuPRODUCTO_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCTO_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRODUCTO_ID_O,-1) <> NVL(inuPRODUCTO_ID_N,-1) THEN
            UPDATE LDC_MARCAPRODREPA
            SET PRODUCTO_ID=inuPRODUCTO_ID_N
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
    END prAcPRODUCTO_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ORDEN_ID
    PROCEDURE prAcORDEN_ID_RId(
        iRowId ROWID,
        inuORDEN_ID_O    NUMBER,
        inuORDEN_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDEN_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDEN_ID_O,-1) <> NVL(inuORDEN_ID_N,-1) THEN
            UPDATE LDC_MARCAPRODREPA
            SET ORDEN_ID=inuORDEN_ID_N
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
    END prAcORDEN_ID_RId;
 
    -- Actualiza por RowId el valor de la columna BLOQUEO
    PROCEDURE prAcBLOQUEO_RId(
        iRowId ROWID,
        isbBLOQUEO_O    VARCHAR2,
        isbBLOQUEO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOQUEO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbBLOQUEO_O,'-') <> NVL(isbBLOQUEO_N,'-') THEN
            UPDATE LDC_MARCAPRODREPA
            SET BLOQUEO=isbBLOQUEO_N
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
    END prAcBLOQUEO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_BLOQUEO
    PROCEDURE prAcFECHA_BLOQUEO_RId(
        iRowId ROWID,
        idtFECHA_BLOQUEO_O    DATE,
        idtFECHA_BLOQUEO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_BLOQUEO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_BLOQUEO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_BLOQUEO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_MARCAPRODREPA
            SET FECHA_BLOQUEO=idtFECHA_BLOQUEO_N
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
    END prAcFECHA_BLOQUEO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_INACTIVACION
    PROCEDURE prAcFECHA_INACTIVACION_RId(
        iRowId ROWID,
        idtFECHA_INACTIVACION_O    DATE,
        idtFECHA_INACTIVACION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INACTIVACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_INACTIVACION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_INACTIVACION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_MARCAPRODREPA
            SET FECHA_INACTIVACION=idtFECHA_INACTIVACION_N
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
    END prAcFECHA_INACTIVACION_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_MARCAPRODREPA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.MARCA_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPRODUCTO_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRODUCTO_ID,
                ircRegistro.PRODUCTO_ID
            );
 
            prAcORDEN_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDEN_ID,
                ircRegistro.ORDEN_ID
            );
 
            prAcBLOQUEO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.BLOQUEO,
                ircRegistro.BLOQUEO
            );
 
            prAcFECHA_BLOQUEO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_BLOQUEO,
                ircRegistro.FECHA_BLOQUEO
            );
 
            prAcFECHA_INACTIVACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_INACTIVACION,
                ircRegistro.FECHA_INACTIVACION
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

    -- Obtiene nuevo identificador de secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNuevoIdentificador';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuNuevoIdentificador  NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    

        nuNuevoIdentificador := SEQ_LDC_MARCAPRODREPA.NEXTVAL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuNuevoIdentificador;
        
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuNuevoIdentificador;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuNuevoIdentificador;
    END fnuObtNuevoIdentificador;
    
    -- Actualiza la fecha de Inactivacion y el flag de bloqueo
    PROCEDURE prAcFechInacBloqueo
    (
        inuProducto_Actual        NUMBER,
        isbBloqueo_Actual         VARCHAR2,
        idtFecha_Inactivacion     DATE,
        isbBloqueo_Nuevo          VARCHAR2
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFechInacBloqueo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        CURSOR cuAcFechInacBloqueo
        IS
        SELECT a.RowId  Rid
        FROM LDC_MARCAPRODREPA a
        WHERE a.producto_id = inuProducto_Actual
        AND a.bloqueo = isbBloqueo_Actual;
        
        rcAcFechInacBloqueo cuAcFechInacBloqueo%ROWTYPE;
    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuAcFechInacBloqueo;
        FETCH cuAcFechInacBloqueo INTO rcAcFechInacBloqueo;
        CLOSE cuAcFechInacBloqueo;
        
        IF rcAcFechInacBloqueo.RId IS NOT NULL THEN
            UPDATE LDC_MARCAPRODREPA
            SET Fecha_Inactivacion = idtFecha_Inactivacion,
            Bloqueo = isbBloqueo_Nuevo
            WHERE RowId = rcAcFechInacBloqueo.RId;
        ELSE
            pkg_traza.trace( 'No hay registro en LDC_MARCAPRODREPA con PRODUCT_ID[' || inuProducto_Actual || ']BLOQUEO[' || isbBloqueo_Actual || ']', csbNivelTraza );
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
    END prAcFechInacBloqueo;

    -- Retorna la cantidad de bloqueos que tiene el producto
    FUNCTION fnuCantidadBloqueos
    (
        inuProducto             NUMBER
    )
    RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuCantidadBloqueos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        CURSOR cuCantidadBloqueos
        IS
        SELECT count(1) CantidadBloqueos
        FROM LDC_MARCAPRODREPA a
        WHERE a.producto_id = inuProducto
        AND a.bloqueo = 'Y';
            
        nuCantidadBloqueos NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuCantidadBloqueos;
        FETCH cuCantidadBloqueos INTO nuCantidadBloqueos;
        CLOSE cuCantidadBloqueos;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuCantidadBloqueos;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuCantidadBloqueos;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            RETURN nuCantidadBloqueos;
    END fnuCantidadBloqueos;      
END pkg_LDC_MARCAPRODREPA;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_MARCAPRODREPA'), UPPER('adm_person'));
END;
/

