CREATE OR REPLACE PACKAGE adm_person.pkg_cupon AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF cupon%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cucupon IS SELECT * FROM cupon;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : cupon
        Caso  : OSF-3636
        Fecha : 08/11/2024 14:05:32
        Modificaciones
        Fecha       Autor       Caso        Descripcion
        ------------------------------------------------------------------------
        10/02/2025  jpinedc     OSF-3893    Se modifica fnuObtCuponPorDocumento
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuCUPONUME    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM cupon tb
        WHERE
        CUPONUME = inuCUPONUME;
     
    CURSOR cuRegistroRIdLock
    (
        inuCUPONUME    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM cupon tb
        WHERE
        CUPONUME = inuCUPONUME
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuCUPONUME    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuCUPONUME    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuCUPONUME    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cucupon%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCUPONUME    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna CUPOTIPO
    FUNCTION fsbObtCUPOTIPO(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOTIPO%TYPE;
 
    -- Obtiene el valor de la columna CUPODOCU
    FUNCTION fsbObtCUPODOCU(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPODOCU%TYPE;
 
    -- Obtiene el valor de la columna CUPOVALO
    FUNCTION fnuObtCUPOVALO(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOVALO%TYPE;
 
    -- Obtiene el valor de la columna CUPOFECH
    FUNCTION fdtObtCUPOFECH(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOFECH%TYPE;
 
    -- Obtiene el valor de la columna CUPOPROG
    FUNCTION fsbObtCUPOPROG(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOPROG%TYPE;
 
    -- Obtiene el valor de la columna CUPOCUPA
    FUNCTION fnuObtCUPOCUPA(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOCUPA%TYPE;
 
    -- Obtiene el valor de la columna CUPOSUSC
    FUNCTION fnuObtCUPOSUSC(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOSUSC%TYPE;
 
    -- Obtiene el valor de la columna CUPOFLPA
    FUNCTION fsbObtCUPOFLPA(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOFLPA%TYPE;
 
    -- Actualiza el valor de la columna CUPOTIPO
    PROCEDURE prAcCUPOTIPO(
        inuCUPONUME    NUMBER,
        isbCUPOTIPO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CUPODOCU
    PROCEDURE prAcCUPODOCU(
        inuCUPONUME    NUMBER,
        isbCUPODOCU    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CUPOVALO
    PROCEDURE prAcCUPOVALO(
        inuCUPONUME    NUMBER,
        inuCUPOVALO    NUMBER
    );
 
    -- Actualiza el valor de la columna CUPOFECH
    PROCEDURE prAcCUPOFECH(
        inuCUPONUME    NUMBER,
        idtCUPOFECH    DATE
    );
 
    -- Actualiza el valor de la columna CUPOPROG
    PROCEDURE prAcCUPOPROG(
        inuCUPONUME    NUMBER,
        isbCUPOPROG    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CUPOCUPA
    PROCEDURE prAcCUPOCUPA(
        inuCUPONUME    NUMBER,
        inuCUPOCUPA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUPOSUSC
    PROCEDURE prAcCUPOSUSC(
        inuCUPONUME    NUMBER,
        inuCUPOSUSC    NUMBER
    );
 
    -- Actualiza el valor de la columna CUPOFLPA
    PROCEDURE prAcCUPOFLPA(
        inuCUPONUME    NUMBER,
        isbCUPOFLPA    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cucupon%ROWTYPE);
    
    -- Obtiene el cupon asociado al documento 
    FUNCTION fnuObtCuponPorDocumento( inuDocumento cupon.cupodocu%TYPE,
									   isbTipoCupon CUPON.CUPOTIPO%TYPE DEFAULT NULL,
									   isbPagado	CUPON.CUPOFLPA%TYPE DEFAULT CONSTANTS_PER.CSBNO,
									   inuContrato  CUPON.CUPOSUSC%TYPE DEFAULT NULL)
    return NUMBER;
 
END pkg_cupon;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_cupon AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuCUPONUME    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCUPONUME);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCUPONUME);
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
        inuCUPONUME    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.CUPONUME IS NOT NULL;
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
        inuCUPONUME    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuCUPONUME) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuCUPONUME||'] en la tabla[cupon]');
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
    PROCEDURE prInsRegistro( ircRegistro cucupon%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO cupon(
            CUPONUME,CUPOTIPO,CUPODOCU,CUPOVALO,CUPOFECH,CUPOPROG,CUPOCUPA,CUPOSUSC,CUPOFLPA
        )
        VALUES (
            ircRegistro.CUPONUME,ircRegistro.CUPOTIPO,ircRegistro.CUPODOCU,ircRegistro.CUPOVALO,ircRegistro.CUPOFECH,ircRegistro.CUPOPROG,ircRegistro.CUPOCUPA,ircRegistro.CUPOSUSC,ircRegistro.CUPOFLPA
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
        inuCUPONUME    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE cupon
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
            DELETE cupon
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
 
    -- Obtiene el valor de la columna CUPOTIPO
    FUNCTION fsbObtCUPOTIPO(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOTIPO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCUPOTIPO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOTIPO;
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
    END fsbObtCUPOTIPO;
 
    -- Obtiene el valor de la columna CUPODOCU
    FUNCTION fsbObtCUPODOCU(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPODOCU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCUPODOCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPODOCU;
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
    END fsbObtCUPODOCU;
 
    -- Obtiene el valor de la columna CUPOVALO
    FUNCTION fnuObtCUPOVALO(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOVALO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUPOVALO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOVALO;
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
    END fnuObtCUPOVALO;
 
    -- Obtiene el valor de la columna CUPOFECH
    FUNCTION fdtObtCUPOFECH(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOFECH%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtCUPOFECH';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOFECH;
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
    END fdtObtCUPOFECH;
 
    -- Obtiene el valor de la columna CUPOPROG
    FUNCTION fsbObtCUPOPROG(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOPROG%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCUPOPROG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOPROG;
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
    END fsbObtCUPOPROG;
 
    -- Obtiene el valor de la columna CUPOCUPA
    FUNCTION fnuObtCUPOCUPA(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOCUPA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUPOCUPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOCUPA;
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
    END fnuObtCUPOCUPA;
 
    -- Obtiene el valor de la columna CUPOSUSC
    FUNCTION fnuObtCUPOSUSC(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOSUSC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUPOSUSC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOSUSC;
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
    END fnuObtCUPOSUSC;
 
    -- Obtiene el valor de la columna CUPOFLPA
    FUNCTION fsbObtCUPOFLPA(
        inuCUPONUME    NUMBER
        ) RETURN cupon.CUPOFLPA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCUPOFLPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CUPOFLPA;
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
    END fsbObtCUPOFLPA;
 
    -- Actualiza el valor de la columna CUPOTIPO
    PROCEDURE prAcCUPOTIPO(
        inuCUPONUME    NUMBER,
        isbCUPOTIPO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOTIPO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(isbCUPOTIPO,'-') <> NVL(rcRegistroAct.CUPOTIPO,'-') THEN
            UPDATE cupon
            SET CUPOTIPO=isbCUPOTIPO
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
    END prAcCUPOTIPO;
 
    -- Actualiza el valor de la columna CUPODOCU
    PROCEDURE prAcCUPODOCU(
        inuCUPONUME    NUMBER,
        isbCUPODOCU    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPODOCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(isbCUPODOCU,'-') <> NVL(rcRegistroAct.CUPODOCU,'-') THEN
            UPDATE cupon
            SET CUPODOCU=isbCUPODOCU
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
    END prAcCUPODOCU;
 
    -- Actualiza el valor de la columna CUPOVALO
    PROCEDURE prAcCUPOVALO(
        inuCUPONUME    NUMBER,
        inuCUPOVALO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOVALO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(inuCUPOVALO,-1) <> NVL(rcRegistroAct.CUPOVALO,-1) THEN
            UPDATE cupon
            SET CUPOVALO=inuCUPOVALO
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
    END prAcCUPOVALO;
 
    -- Actualiza el valor de la columna CUPOFECH
    PROCEDURE prAcCUPOFECH(
        inuCUPONUME    NUMBER,
        idtCUPOFECH    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOFECH';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(idtCUPOFECH,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.CUPOFECH,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cupon
            SET CUPOFECH=idtCUPOFECH
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
    END prAcCUPOFECH;
 
    -- Actualiza el valor de la columna CUPOPROG
    PROCEDURE prAcCUPOPROG(
        inuCUPONUME    NUMBER,
        isbCUPOPROG    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOPROG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(isbCUPOPROG,'-') <> NVL(rcRegistroAct.CUPOPROG,'-') THEN
            UPDATE cupon
            SET CUPOPROG=isbCUPOPROG
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
    END prAcCUPOPROG;
 
    -- Actualiza el valor de la columna CUPOCUPA
    PROCEDURE prAcCUPOCUPA(
        inuCUPONUME    NUMBER,
        inuCUPOCUPA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOCUPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(inuCUPOCUPA,-1) <> NVL(rcRegistroAct.CUPOCUPA,-1) THEN
            UPDATE cupon
            SET CUPOCUPA=inuCUPOCUPA
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
    END prAcCUPOCUPA;
 
    -- Actualiza el valor de la columna CUPOSUSC
    PROCEDURE prAcCUPOSUSC(
        inuCUPONUME    NUMBER,
        inuCUPOSUSC    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOSUSC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(inuCUPOSUSC,-1) <> NVL(rcRegistroAct.CUPOSUSC,-1) THEN
            UPDATE cupon
            SET CUPOSUSC=inuCUPOSUSC
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
    END prAcCUPOSUSC;
 
    -- Actualiza el valor de la columna CUPOFLPA
    PROCEDURE prAcCUPOFLPA(
        inuCUPONUME    NUMBER,
        isbCUPOFLPA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOFLPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCUPONUME,TRUE);
        IF NVL(isbCUPOFLPA,'-') <> NVL(rcRegistroAct.CUPOFLPA,'-') THEN
            UPDATE cupon
            SET CUPOFLPA=isbCUPOFLPA
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
    END prAcCUPOFLPA;
 
    -- Actualiza por RowId el valor de la columna CUPOTIPO
    PROCEDURE prAcCUPOTIPO_RId(
        iRowId ROWID,
        isbCUPOTIPO_O    VARCHAR2,
        isbCUPOTIPO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOTIPO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCUPOTIPO_O,'-') <> NVL(isbCUPOTIPO_N,'-') THEN
            UPDATE cupon
            SET CUPOTIPO=isbCUPOTIPO_N
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
    END prAcCUPOTIPO_RId;
 
    -- Actualiza por RowId el valor de la columna CUPODOCU
    PROCEDURE prAcCUPODOCU_RId(
        iRowId ROWID,
        isbCUPODOCU_O    VARCHAR2,
        isbCUPODOCU_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPODOCU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCUPODOCU_O,'-') <> NVL(isbCUPODOCU_N,'-') THEN
            UPDATE cupon
            SET CUPODOCU=isbCUPODOCU_N
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
    END prAcCUPODOCU_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOVALO
    PROCEDURE prAcCUPOVALO_RId(
        iRowId ROWID,
        inuCUPOVALO_O    NUMBER,
        inuCUPOVALO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOVALO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCUPOVALO_O,-1) <> NVL(inuCUPOVALO_N,-1) THEN
            UPDATE cupon
            SET CUPOVALO=inuCUPOVALO_N
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
    END prAcCUPOVALO_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOFECH
    PROCEDURE prAcCUPOFECH_RId(
        iRowId ROWID,
        idtCUPOFECH_O    DATE,
        idtCUPOFECH_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOFECH_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtCUPOFECH_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtCUPOFECH_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cupon
            SET CUPOFECH=idtCUPOFECH_N
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
    END prAcCUPOFECH_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOPROG
    PROCEDURE prAcCUPOPROG_RId(
        iRowId ROWID,
        isbCUPOPROG_O    VARCHAR2,
        isbCUPOPROG_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOPROG_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCUPOPROG_O,'-') <> NVL(isbCUPOPROG_N,'-') THEN
            UPDATE cupon
            SET CUPOPROG=isbCUPOPROG_N
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
    END prAcCUPOPROG_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOCUPA
    PROCEDURE prAcCUPOCUPA_RId(
        iRowId ROWID,
        inuCUPOCUPA_O    NUMBER,
        inuCUPOCUPA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOCUPA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCUPOCUPA_O,-1) <> NVL(inuCUPOCUPA_N,-1) THEN
            UPDATE cupon
            SET CUPOCUPA=inuCUPOCUPA_N
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
    END prAcCUPOCUPA_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOSUSC
    PROCEDURE prAcCUPOSUSC_RId(
        iRowId ROWID,
        inuCUPOSUSC_O    NUMBER,
        inuCUPOSUSC_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOSUSC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCUPOSUSC_O,-1) <> NVL(inuCUPOSUSC_N,-1) THEN
            UPDATE cupon
            SET CUPOSUSC=inuCUPOSUSC_N
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
    END prAcCUPOSUSC_RId;
 
    -- Actualiza por RowId el valor de la columna CUPOFLPA
    PROCEDURE prAcCUPOFLPA_RId(
        iRowId ROWID,
        isbCUPOFLPA_O    VARCHAR2,
        isbCUPOFLPA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUPOFLPA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCUPOFLPA_O,'-') <> NVL(isbCUPOFLPA_N,'-') THEN
            UPDATE cupon
            SET CUPOFLPA=isbCUPOFLPA_N
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
    END prAcCUPOFLPA_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cucupon%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.CUPONUME,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcCUPOTIPO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOTIPO,
                ircRegistro.CUPOTIPO
            );
 
            prAcCUPODOCU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPODOCU,
                ircRegistro.CUPODOCU
            );
 
            prAcCUPOVALO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOVALO,
                ircRegistro.CUPOVALO
            );
 
            prAcCUPOFECH_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOFECH,
                ircRegistro.CUPOFECH
            );
 
            prAcCUPOPROG_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOPROG,
                ircRegistro.CUPOPROG
            );
 
            prAcCUPOCUPA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOCUPA,
                ircRegistro.CUPOCUPA
            );
 
            prAcCUPOSUSC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOSUSC,
                ircRegistro.CUPOSUSC
            );
 
            prAcCUPOFLPA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUPOFLPA,
                ircRegistro.CUPOFLPA
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
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jsoto
        Descr : fnuObtCuponPorDocumento Obtiene ultimo cupon por documento soporte
        Tabla : cupon
		Parametros de Entrada
		
		inuDocumento Id de documento
		isbTipoCupon Tipo Cupon
		isbPagado	 Cupon Pagado
		
        Caso  : OSF-3740
        Fecha : 06/12/2024 14:05:32
        Modificaciones
        Fecha       Autor       Caso        Descripcion
        ------------------------------------------------------------------------
        10/02/2025  jpinedc     OSF-3893    Se agrea el argumento inuContrato
    ***************************************************************************/

    FUNCTION fnuObtCuponPorDocumento( inuDocumento cupon.cupodocu%TYPE,
									   isbTipoCupon CUPON.CUPOTIPO%TYPE DEFAULT NULL,
									   isbPagado	CUPON.CUPOFLPA%TYPE DEFAULT CONSTANTS_PER.CSBNO,
									   inuContrato  CUPON.CUPOSUSC%TYPE DEFAULT NULL)
									   return NUMBER
	IS
        
		csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCuponPorDocumento';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuCupoNume 		CUPON.CUPONUME%TYPE;
		
		CURSOR cuCuponPorDocumento IS
		SELECT  CUPONUME
        FROM    CUPON
        WHERE   CUPODOCU = inuDocumento
        AND     CUPOTIPO = NVL(isbTipoCupon,CUPOTIPO)
        AND     NVL(CUPOFLPA,CONSTANTS_PER.CSBNO) = isbPagado
        AND     CUPOSUSC = NVL(inuContrato,CUPOSUSC) 
        ORDER BY CUPOFECH DESC;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
 
		IF cuCuponPorDocumento%ISOPEN THEN  
			CLOSE cuCuponPorDocumento;
		END IF;     		

		OPEN cuCuponPorDocumento;
		FETCH cuCuponPorDocumento INTO nuCupoNume;
		CLOSE cuCuponPorDocumento;
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
		
		RETURN(nuCupoNume);
		
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN(nuCupoNume);
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN(nuCupoNume);
    END fnuObtCuponPorDocumento;
 
END pkg_cupon;
/
BEGIN
    -- OSF-3636
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_cupon'), UPPER('adm_person'));
END;
/
