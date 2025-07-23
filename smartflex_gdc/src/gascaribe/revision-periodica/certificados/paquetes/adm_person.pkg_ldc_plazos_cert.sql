CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_PLAZOS_CERT AS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Autor : jpinedc
    Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
    Tabla : LDC_PLAZOS_CERT
    Caso  : OSF-3828
    Fecha : 08/01/2025 11:20:17
    
    Modificaciones  :
    Autor       Fecha           Caso        Descripcion
    pacosta     13-05-2025      OSF-4336    Creacion metodo: fdtObtPlazoMaximoxProd 
***************************************************************************/
    -----------------------------------
    -- Tipos
    -----------------------------------
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_PLAZOS_CERT%ROWTYPE INDEX BY BINARY_INTEGER;
    
    -----------------------------------
    -- Cursores
    -----------------------------------                   
    CURSOR cuLDC_PLAZOS_CERT IS SELECT * FROM LDC_PLAZOS_CERT;
    
    CURSOR cuLDC_PLAZOS_CERT_PRODUCTO( inuProducto NUMBER) IS SELECT * FROM LDC_PLAZOS_CERT WHERE ID_PRODUCTO = inuProducto;

    CURSOR cuRegistroRId
    (
        inuPLAZOS_CERT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_PLAZOS_CERT tb
        WHERE
        PLAZOS_CERT_ID = inuPLAZOS_CERT_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuPLAZOS_CERT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_PLAZOS_CERT tb
        WHERE
        PLAZOS_CERT_ID = inuPLAZOS_CERT_ID
        FOR UPDATE NOWAIT;

    -----------------------------------
    -- Metodos
    -----------------------------------     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuPLAZOS_CERT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuPLAZOS_CERT_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuPLAZOS_CERT_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro IN OUT cuLDC_PLAZOS_CERT%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuPLAZOS_CERT_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ID_CONTRATO
    FUNCTION fnuObtID_CONTRATO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.ID_CONTRATO%TYPE;
 
    -- Obtiene el valor de la columna ID_PRODUCTO
    FUNCTION fnuObtID_PRODUCTO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.ID_PRODUCTO%TYPE;
 
    -- Obtiene el valor de la columna PLAZO_MIN_REVISION
    FUNCTION fdtObtPLAZO_MIN_REVISION(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MIN_REVISION%TYPE;
 
    -- Obtiene el valor de la columna PLAZO_MIN_SUSPENSION
    FUNCTION fdtObtPLAZO_MIN_SUSPENSION(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MIN_SUSPENSION%TYPE;
 
    -- Obtiene el valor de la columna PLAZO_MAXIMO
    FUNCTION fdtObtPLAZO_MAXIMO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MAXIMO%TYPE;
 
    -- Obtiene el valor de la columna IS_NOTIF
    FUNCTION fsbObtIS_NOTIF(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.IS_NOTIF%TYPE;
 
    -- Obtiene el valor de la columna VACIOINTERNO
    FUNCTION fsbObtVACIOINTERNO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.VACIOINTERNO%TYPE;
 
    -- Actualiza el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO(
        inuPLAZOS_CERT_ID    NUMBER,
        inuID_CONTRATO    NUMBER
    );
 
    -- Actualiza el valor de la columna ID_PRODUCTO
    PROCEDURE prAcID_PRODUCTO(
        inuPLAZOS_CERT_ID    NUMBER,
        inuID_PRODUCTO    NUMBER
    );
 
    -- Actualiza el valor de la columna PLAZO_MIN_REVISION
    PROCEDURE prAcPLAZO_MIN_REVISION(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MIN_REVISION    DATE
    );
 
    -- Actualiza el valor de la columna PLAZO_MIN_SUSPENSION
    PROCEDURE prAcPLAZO_MIN_SUSPENSION(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MIN_SUSPENSION    DATE
    );
 
    -- Actualiza el valor de la columna PLAZO_MAXIMO
    PROCEDURE prAcPLAZO_MAXIMO(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MAXIMO    DATE
    );
 
    -- Actualiza el valor de la columna IS_NOTIF
    PROCEDURE prAcIS_NOTIF(
        inuPLAZOS_CERT_ID    NUMBER,
        isbIS_NOTIF    VARCHAR2
    );
 
    -- Actualiza el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO(
        inuPLAZOS_CERT_ID    NUMBER,
        isbVACIOINTERNO    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_PLAZOS_CERT%ROWTYPE);
    
    -- Obtiene un nuevo identificador de la secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER;
    
    -- Obtiene el valor de la columna MAX_GRACE_DAYS mediante el id del producto
    FUNCTION fdtObtPlazoMaximoxProd(inuIdProducto IN NUMBER) 
    RETURN ldc_plazos_cert.plazo_maximo%TYPE;
    
END pkg_LDC_PLAZOS_CERT;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_PLAZOS_CERT AS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-4336';
    
    -- Constantes para el control de la traza
    csbPqt_nombre       CONSTANT VARCHAR2(35)       := $$PLSQL_UNIT||'.';       
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_err          CONSTANT VARCHAR2(35)       := pkg_traza.csbFin_err;
    
     --Variables generales     
    sbMensaje             VARCHAR2(4000);
    nuerror             NUMBER;

    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuPLAZOS_CERT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuPLAZOS_CERT_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuPLAZOS_CERT_ID);
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
        inuPLAZOS_CERT_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.PLAZOS_CERT_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuPLAZOS_CERT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuPLAZOS_CERT_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuPLAZOS_CERT_ID||'] en la tabla[LDC_PLAZOS_CERT]');
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
    PROCEDURE prInsRegistro( ircRegistro IN OUT cuLDC_PLAZOS_CERT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF ircRegistro.PLAZOS_CERT_ID IS NULL THEN 
            ircRegistro.PLAZOS_CERT_ID := fnuObtNuevoIdentificador;
        END IF;
        
        INSERT INTO LDC_PLAZOS_CERT(
            PLAZOS_CERT_ID,ID_CONTRATO,ID_PRODUCTO,PLAZO_MIN_REVISION,PLAZO_MIN_SUSPENSION,PLAZO_MAXIMO,IS_NOTIF,VACIOINTERNO
        )
        VALUES (
            ircRegistro.PLAZOS_CERT_ID,ircRegistro.ID_CONTRATO,ircRegistro.ID_PRODUCTO,ircRegistro.PLAZO_MIN_REVISION,ircRegistro.PLAZO_MIN_SUSPENSION,ircRegistro.PLAZO_MAXIMO,ircRegistro.IS_NOTIF,ircRegistro.VACIOINTERNO
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
        inuPLAZOS_CERT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_PLAZOS_CERT
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE LDC_PLAZOS_CERT
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
 
    -- Obtiene el valor de la columna ID_CONTRATO
    FUNCTION fnuObtID_CONTRATO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.ID_CONTRATO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
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
 
    -- Obtiene el valor de la columna ID_PRODUCTO
    FUNCTION fnuObtID_PRODUCTO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.ID_PRODUCTO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtID_PRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_PRODUCTO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_PRODUCTO;
 
    -- Obtiene el valor de la columna PLAZO_MIN_REVISION
    FUNCTION fdtObtPLAZO_MIN_REVISION(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MIN_REVISION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtPLAZO_MIN_REVISION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PLAZO_MIN_REVISION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtPLAZO_MIN_REVISION;
 
    -- Obtiene el valor de la columna PLAZO_MIN_SUSPENSION
    FUNCTION fdtObtPLAZO_MIN_SUSPENSION(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MIN_SUSPENSION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtPLAZO_MIN_SUSPENSION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PLAZO_MIN_SUSPENSION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtPLAZO_MIN_SUSPENSION;
 
    -- Obtiene el valor de la columna PLAZO_MAXIMO
    FUNCTION fdtObtPLAZO_MAXIMO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.PLAZO_MAXIMO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtPLAZO_MAXIMO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PLAZO_MAXIMO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtPLAZO_MAXIMO;
 
    -- Obtiene el valor de la columna IS_NOTIF
    FUNCTION fsbObtIS_NOTIF(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.IS_NOTIF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtIS_NOTIF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_NOTIF;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtIS_NOTIF;
 
    -- Obtiene el valor de la columna VACIOINTERNO
    FUNCTION fsbObtVACIOINTERNO(
        inuPLAZOS_CERT_ID    NUMBER
        ) RETURN LDC_PLAZOS_CERT.VACIOINTERNO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fsbObtVACIOINTERNO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VACIOINTERNO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtVACIOINTERNO;
 
    -- Actualiza el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO(
        inuPLAZOS_CERT_ID    NUMBER,
        inuID_CONTRATO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(inuID_CONTRATO,-1) <> NVL(rcRegistroAct.ID_CONTRATO,-1) THEN
            UPDATE LDC_PLAZOS_CERT
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
 
    -- Actualiza el valor de la columna ID_PRODUCTO
    PROCEDURE prAcID_PRODUCTO(
        inuPLAZOS_CERT_ID    NUMBER,
        inuID_PRODUCTO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcID_PRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(inuID_PRODUCTO,-1) <> NVL(rcRegistroAct.ID_PRODUCTO,-1) THEN
            UPDATE LDC_PLAZOS_CERT
            SET ID_PRODUCTO=inuID_PRODUCTO
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
    END prAcID_PRODUCTO;
 
    -- Actualiza el valor de la columna PLAZO_MIN_REVISION
    PROCEDURE prAcPLAZO_MIN_REVISION(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MIN_REVISION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MIN_REVISION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(idtPLAZO_MIN_REVISION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.PLAZO_MIN_REVISION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MIN_REVISION=idtPLAZO_MIN_REVISION
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
    END prAcPLAZO_MIN_REVISION;
 
    -- Actualiza el valor de la columna PLAZO_MIN_SUSPENSION
    PROCEDURE prAcPLAZO_MIN_SUSPENSION(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MIN_SUSPENSION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MIN_SUSPENSION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(idtPLAZO_MIN_SUSPENSION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.PLAZO_MIN_SUSPENSION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MIN_SUSPENSION=idtPLAZO_MIN_SUSPENSION
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
    END prAcPLAZO_MIN_SUSPENSION;
 
    -- Actualiza el valor de la columna PLAZO_MAXIMO
    PROCEDURE prAcPLAZO_MAXIMO(
        inuPLAZOS_CERT_ID    NUMBER,
        idtPLAZO_MAXIMO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MAXIMO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(idtPLAZO_MAXIMO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.PLAZO_MAXIMO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MAXIMO=idtPLAZO_MAXIMO
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
    END prAcPLAZO_MAXIMO;
 
    -- Actualiza el valor de la columna IS_NOTIF
    PROCEDURE prAcIS_NOTIF(
        inuPLAZOS_CERT_ID    NUMBER,
        isbIS_NOTIF    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcIS_NOTIF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(isbIS_NOTIF,'-') <> NVL(rcRegistroAct.IS_NOTIF,'-') THEN
            UPDATE LDC_PLAZOS_CERT
            SET IS_NOTIF=isbIS_NOTIF
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
    END prAcIS_NOTIF;
 
    -- Actualiza el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO(
        inuPLAZOS_CERT_ID    NUMBER,
        isbVACIOINTERNO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcVACIOINTERNO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPLAZOS_CERT_ID,TRUE);
        IF NVL(isbVACIOINTERNO,'-') <> NVL(rcRegistroAct.VACIOINTERNO,'-') THEN
            UPDATE LDC_PLAZOS_CERT
            SET VACIOINTERNO=isbVACIOINTERNO
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
    END prAcVACIOINTERNO;
 
    -- Actualiza por RowId el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO_RId(
        iRowId ROWID,
        inuID_CONTRATO_O    NUMBER,
        inuID_CONTRATO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcID_CONTRATO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_CONTRATO_O,-1) <> NVL(inuID_CONTRATO_N,-1) THEN
            UPDATE LDC_PLAZOS_CERT
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
 
    -- Actualiza por RowId el valor de la columna ID_PRODUCTO
    PROCEDURE prAcID_PRODUCTO_RId(
        iRowId ROWID,
        inuID_PRODUCTO_O    NUMBER,
        inuID_PRODUCTO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcID_PRODUCTO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_PRODUCTO_O,-1) <> NVL(inuID_PRODUCTO_N,-1) THEN
            UPDATE LDC_PLAZOS_CERT
            SET ID_PRODUCTO=inuID_PRODUCTO_N
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
    END prAcID_PRODUCTO_RId;
 
    -- Actualiza por RowId el valor de la columna PLAZO_MIN_REVISION
    PROCEDURE prAcPLAZO_MIN_REVISION_RId(
        iRowId ROWID,
        idtPLAZO_MIN_REVISION_O    DATE,
        idtPLAZO_MIN_REVISION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MIN_REVISION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtPLAZO_MIN_REVISION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtPLAZO_MIN_REVISION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MIN_REVISION=idtPLAZO_MIN_REVISION_N
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
    END prAcPLAZO_MIN_REVISION_RId;
 
    -- Actualiza por RowId el valor de la columna PLAZO_MIN_SUSPENSION
    PROCEDURE prAcPLAZO_MIN_SUSPENSION_RId(
        iRowId ROWID,
        idtPLAZO_MIN_SUSPENSION_O    DATE,
        idtPLAZO_MIN_SUSPENSION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MIN_SUSPENSION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtPLAZO_MIN_SUSPENSION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtPLAZO_MIN_SUSPENSION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MIN_SUSPENSION=idtPLAZO_MIN_SUSPENSION_N
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
    END prAcPLAZO_MIN_SUSPENSION_RId;
 
    -- Actualiza por RowId el valor de la columna PLAZO_MAXIMO
    PROCEDURE prAcPLAZO_MAXIMO_RId(
        iRowId ROWID,
        idtPLAZO_MAXIMO_O    DATE,
        idtPLAZO_MAXIMO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcPLAZO_MAXIMO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtPLAZO_MAXIMO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtPLAZO_MAXIMO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_PLAZOS_CERT
            SET PLAZO_MAXIMO=idtPLAZO_MAXIMO_N
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
    END prAcPLAZO_MAXIMO_RId;
 
    -- Actualiza por RowId el valor de la columna IS_NOTIF
    PROCEDURE prAcIS_NOTIF_RId(
        iRowId ROWID,
        isbIS_NOTIF_O    VARCHAR2,
        isbIS_NOTIF_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcIS_NOTIF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_NOTIF_O,'-') <> NVL(isbIS_NOTIF_N,'-') THEN
            UPDATE LDC_PLAZOS_CERT
            SET IS_NOTIF=isbIS_NOTIF_N
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
    END prAcIS_NOTIF_RId;
 
    -- Actualiza por RowId el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO_RId(
        iRowId ROWID,
        isbVACIOINTERNO_O    VARCHAR2,
        isbVACIOINTERNO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prAcVACIOINTERNO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVACIOINTERNO_O,'-') <> NVL(isbVACIOINTERNO_N,'-') THEN
            UPDATE LDC_PLAZOS_CERT
            SET VACIOINTERNO=isbVACIOINTERNO_N
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
    END prAcVACIOINTERNO_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_PLAZOS_CERT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.PLAZOS_CERT_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcID_CONTRATO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_CONTRATO,
                ircRegistro.ID_CONTRATO
            );
 
            prAcID_PRODUCTO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_PRODUCTO,
                ircRegistro.ID_PRODUCTO
            );
 
            prAcPLAZO_MIN_REVISION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PLAZO_MIN_REVISION,
                ircRegistro.PLAZO_MIN_REVISION
            );
 
            prAcPLAZO_MIN_SUSPENSION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PLAZO_MIN_SUSPENSION,
                ircRegistro.PLAZO_MIN_SUSPENSION
            );
 
            prAcPLAZO_MAXIMO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PLAZO_MAXIMO,
                ircRegistro.PLAZO_MAXIMO
            );
 
            prAcIS_NOTIF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_NOTIF,
                ircRegistro.IS_NOTIF
            );
 
            prAcVACIOINTERNO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VACIOINTERNO,
                ircRegistro.VACIOINTERNO
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

    -- Obtiene un nuevo identificador de la secuencia
    FUNCTION fnuObtNuevoIdentificador RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fnuObtNuevoIdentificador';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        nuNuevoIdentificador NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        nuNuevoIdentificador    := LDC_SEQ_PLAZOS_CERT.NEXTVAL;
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
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtRegistroRId
    Descripcion     : Obtiene el valor de la columna MAX_GRACE_DAYS mediante el id del producto
    Autor           : Paola Acosta
    Fecha           : 13-05-2025
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    pacosta     13-05-2025  OSF-4336 Creacion
    ***************************************************************************/
    FUNCTION fdtObtPlazoMaximoxProd(inuIdProducto IN NUMBER) 
    RETURN ldc_plazos_cert.plazo_maximo%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre||'fdtObtPlazoMaximoxProd'; 
        
        CURSOR cuPlazoMaxProd IS
        SELECT plazo_maximo
        FROM ldc_plazos_cert
        WHERE id_producto = inuIdProducto;
        
        dtPlazoMax  ldc_plazos_cert.plazo_maximo%TYPE;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        OPEN cuPlazoMaxProd;
        FETCH cuPlazoMaxProd INTO dtPlazoMax;
        CLOSE cuPlazoMaxProd;
               
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
        RETURN dtPlazoMax;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_erc);
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_err);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => '||sbMensaje, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fdtObtPlazoMaximoxProd;      
    
END pkg_LDC_PLAZOS_CERT;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_PLAZOS_CERT'), UPPER('adm_person'));
END;
/

