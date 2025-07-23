CREATE OR REPLACE PACKAGE personalizaciones.pkg_EXENCION_COBRO_FACTURA AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF EXENCION_COBRO_FACTURA%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuEXENCION_COBRO_FACTURA IS SELECT * FROM EXENCION_COBRO_FACTURA;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : felipe.valencia
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : EXENCION_COBRO_FACTURA
        Caso  : OSF-4171
        Fecha : 06/05/2025 14:40:04
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM EXENCION_COBRO_FACTURA tb
        WHERE
        SOLICITUD = inuSOLICITUD AND
        PRODUCTO = inuPRODUCTO;
     
    CURSOR cuRegistroRIdLock
    (
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM EXENCION_COBRO_FACTURA tb
        WHERE
        SOLICITUD = inuSOLICITUD AND
        PRODUCTO = inuPRODUCTO
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuEXENCION_COBRO_FACTURA%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna FECHA_INI_VIGENCIA
    FUNCTION fdtObtFECHA_INI_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
        ) RETURN EXENCION_COBRO_FACTURA.FECHA_INI_VIGENCIA%TYPE;
 
    -- Obtiene el valor de la columna FECHA_FIN_VIGENCIA
    FUNCTION fdtObtFECHA_FIN_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
        ) RETURN EXENCION_COBRO_FACTURA.FECHA_FIN_VIGENCIA%TYPE;
 
    -- Actualiza el valor de la columna FECHA_INI_VIGENCIA
    PROCEDURE prAcFECHA_INI_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER,
        idtFECHA_INI_VIGENCIA    DATE
    );
 
    -- Actualiza el valor de la columna FECHA_FIN_VIGENCIA
    PROCEDURE prAcFECHA_FIN_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER,
        idtFECHA_FIN_VIGENCIA    DATE
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuEXENCION_COBRO_FACTURA%ROWTYPE);

    -- Actualiza las exenciones vigentes por producto
    PROCEDURE prActExencionesVigentes
    ( 
        inuProducto     IN EXENCION_COBRO_FACTURA.PRODUCTO%TYPE
    );
END pkg_EXENCION_COBRO_FACTURA;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_EXENCION_COBRO_FACTURA AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuSOLICITUD,inuPRODUCTO);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuSOLICITUD,inuPRODUCTO);
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
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.SOLICITUD IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuSOLICITUD,inuPRODUCTO) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuSOLICITUD||','||inuPRODUCTO||'] en la tabla[EXENCION_COBRO_FACTURA]');
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
    PROCEDURE prInsRegistro( ircRegistro cuEXENCION_COBRO_FACTURA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO EXENCION_COBRO_FACTURA(
            SOLICITUD,PRODUCTO,FECHA_INI_VIGENCIA,FECHA_FIN_VIGENCIA
        )
        VALUES (
            ircRegistro.SOLICITUD,ircRegistro.PRODUCTO,ircRegistro.FECHA_INI_VIGENCIA,ircRegistro.FECHA_FIN_VIGENCIA
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
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE EXENCION_COBRO_FACTURA
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
            DELETE EXENCION_COBRO_FACTURA
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
 
    -- Obtiene el valor de la columna FECHA_INI_VIGENCIA
    FUNCTION fdtObtFECHA_INI_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
        ) RETURN EXENCION_COBRO_FACTURA.FECHA_INI_VIGENCIA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_INI_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_INI_VIGENCIA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_INI_VIGENCIA;
 
    -- Obtiene el valor de la columna FECHA_FIN_VIGENCIA
    FUNCTION fdtObtFECHA_FIN_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER
        ) RETURN EXENCION_COBRO_FACTURA.FECHA_FIN_VIGENCIA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_FIN_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_FIN_VIGENCIA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_FIN_VIGENCIA;
 
    -- Actualiza el valor de la columna FECHA_INI_VIGENCIA
    PROCEDURE prAcFECHA_INI_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER,
        idtFECHA_INI_VIGENCIA    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INI_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO,TRUE);
        IF NVL(idtFECHA_INI_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_INI_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE EXENCION_COBRO_FACTURA
            SET FECHA_INI_VIGENCIA=idtFECHA_INI_VIGENCIA
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
    END prAcFECHA_INI_VIGENCIA;
 
    -- Actualiza el valor de la columna FECHA_FIN_VIGENCIA
    PROCEDURE prAcFECHA_FIN_VIGENCIA(
        inuSOLICITUD    NUMBER,inuPRODUCTO    NUMBER,
        idtFECHA_FIN_VIGENCIA    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FIN_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuSOLICITUD,inuPRODUCTO,TRUE);
        IF NVL(idtFECHA_FIN_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_FIN_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE EXENCION_COBRO_FACTURA
            SET FECHA_FIN_VIGENCIA=idtFECHA_FIN_VIGENCIA
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
    END prAcFECHA_FIN_VIGENCIA;
 
    -- Actualiza por RowId el valor de la columna FECHA_INI_VIGENCIA
    PROCEDURE prAcFECHA_INI_VIGENCIA_RId(
        iRowId ROWID,
        idtFECHA_INI_VIGENCIA_O    DATE,
        idtFECHA_INI_VIGENCIA_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INI_VIGENCIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_INI_VIGENCIA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_INI_VIGENCIA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE EXENCION_COBRO_FACTURA
            SET FECHA_INI_VIGENCIA=idtFECHA_INI_VIGENCIA_N
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
    END prAcFECHA_INI_VIGENCIA_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_FIN_VIGENCIA
    PROCEDURE prAcFECHA_FIN_VIGENCIA_RId(
        iRowId ROWID,
        idtFECHA_FIN_VIGENCIA_O    DATE,
        idtFECHA_FIN_VIGENCIA_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FIN_VIGENCIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_FIN_VIGENCIA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_FIN_VIGENCIA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE EXENCION_COBRO_FACTURA
            SET FECHA_FIN_VIGENCIA=idtFECHA_FIN_VIGENCIA_N
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
    END prAcFECHA_FIN_VIGENCIA_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuEXENCION_COBRO_FACTURA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.SOLICITUD,ircRegistro.PRODUCTO,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcFECHA_INI_VIGENCIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_INI_VIGENCIA,
                ircRegistro.FECHA_INI_VIGENCIA
            );
 
            prAcFECHA_FIN_VIGENCIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_FIN_VIGENCIA,
                ircRegistro.FECHA_FIN_VIGENCIA
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

    -- Actualiza las exenciones vigentes por producto
    PROCEDURE prActExencionesVigentes
    ( 
        inuProducto     IN EXENCION_COBRO_FACTURA.PRODUCTO%TYPE
    ) 
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActExencionesVigentes';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE EXENCION_COBRO_FACTURA
        SET    FECHA_FIN_VIGENCIA = SYSDATE
        WHERE  PRODUCTO   = inuProducto
        AND     TRUNC(FECHA_INI_VIGENCIA ) <= TRUNC(SYSDATE)
        AND     TRUNC(FECHA_FIN_VIGENCIA ) > TRUNC(SYSDATE);

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
    END prActExencionesVigentes;
 
END pkg_EXENCION_COBRO_FACTURA;
/
BEGIN
    -- OSF-4171
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_EXENCION_COBRO_FACTURA'), UPPER('personalizaciones'));
END;
/
