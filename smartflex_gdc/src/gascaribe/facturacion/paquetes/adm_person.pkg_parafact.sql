CREATE OR REPLACE PACKAGE adm_person.pkg_parafact AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF parafact%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuparafact IS SELECT * FROM parafact;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : felipe.valencia
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : parafact
        Caso  : OSF-3846
        Fecha : 11/03/2025 10:42:46
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuPAFACODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM parafact tb
        WHERE
        PAFACODI = inuPAFACODI;
     
    CURSOR cuRegistroRIdLock
    (
        inuPAFACODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM parafact tb
        WHERE
        PAFACODI = inuPAFACODI
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuPAFACODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuPAFACODI    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuPAFACODI    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuparafact%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuPAFACODI    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PAFANMFV
    FUNCTION fnuObtPAFANMFV(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANMFV%TYPE;
 
    -- Obtiene el valor de la columna PAFANFVI
    FUNCTION fnuObtPAFANFVI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANFVI%TYPE;
 
    -- Obtiene el valor de la columna PAFAMORA
    FUNCTION fnuObtPAFAMORA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAMORA%TYPE;
 
    -- Obtiene el valor de la columna PAFAPASA
    FUNCTION fnuObtPAFAPASA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPASA%TYPE;
 
    -- Obtiene el valor de la columna PAFAPOIV
    FUNCTION fnuObtPAFAPOIV(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPOIV%TYPE;
 
    -- Obtiene el valor de la columna PAFAREFU
    FUNCTION fnuObtPAFAREFU(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAREFU%TYPE;
 
    -- Obtiene el valor de la columna PAFAINMO
    FUNCTION fnuObtPAFAINMO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAINMO%TYPE;
 
    -- Obtiene el valor de la columna PAFANMMM
    FUNCTION fnuObtPAFANMMM(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANMMM%TYPE;
 
    -- Obtiene el valor de la columna PAFACAPM
    FUNCTION fnuObtPAFACAPM(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACAPM%TYPE;
 
    -- Obtiene el valor de la columna PAFAPAGO
    FUNCTION fnuObtPAFAPAGO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPAGO%TYPE;
 
    -- Obtiene el valor de la columna PAFAANTI
    FUNCTION fnuObtPAFAANTI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAANTI%TYPE;
 
    -- Obtiene el valor de la columna PAFASAFA
    FUNCTION fnuObtPAFASAFA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFASAFA%TYPE;
 
    -- Obtiene el valor de la columna PAFACOAJ
    FUNCTION fnuObtPAFACOAJ(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACOAJ%TYPE;
 
    -- Obtiene el valor de la columna PAFAASAF
    FUNCTION fnuObtPAFAASAF(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAASAF%TYPE;
 
    -- Obtiene el valor de la columna PAFADIFE
    FUNCTION fnuObtPAFADIFE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFADIFE%TYPE;
 
    -- Obtiene el valor de la columna PAFARECA
    FUNCTION fsbObtPAFARECA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFARECA%TYPE;
 
    -- Obtiene el valor de la columna PAFAFARE
    FUNCTION fnuObtPAFAFARE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAFARE%TYPE;
 
    -- Obtiene el valor de la columna PAFANUFA
    FUNCTION fnuObtPAFANUFA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUFA%TYPE;
 
    -- Obtiene el valor de la columna PAFANUCU
    FUNCTION fnuObtPAFANUCU(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUCU%TYPE;
 
    -- Obtiene el valor de la columna PAFANUDI
    FUNCTION fnuObtPAFANUDI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUDI%TYPE;
 
    -- Obtiene el valor de la columna PAFANUNC
    FUNCTION fnuObtPAFANUNC(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUNC%TYPE;
 
    -- Obtiene el valor de la columna PAFACDAR
    FUNCTION fnuObtPAFACDAR(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACDAR%TYPE;
 
    -- Obtiene el valor de la columna PAFACREF
    FUNCTION fnuObtPAFACREF(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACREF%TYPE;
 
    -- Obtiene el valor de la columna PAFANUCO
    FUNCTION fnuObtPAFANUCO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUCO%TYPE;
 
    -- Obtiene el valor de la columna PAFAFIDE
    FUNCTION fnuObtPAFAFIDE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAFIDE%TYPE;
 
    -- Obtiene el valor de la columna PAFAPTMP
    FUNCTION fsbObtPAFAPTMP(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPTMP%TYPE;
 
    -- Obtiene el valor de la columna PAFAAPLI
    FUNCTION fnuObtPAFAAPLI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAAPLI%TYPE;
 
    -- Obtiene el valor de la columna PAFAMCDI
    FUNCTION fnuObtPAFAMCDI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAMCDI%TYPE;
 
    -- Obtiene el valor de la columna PAFACRMR
    FUNCTION fnuObtPAFACRMR(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACRMR%TYPE;
 
    -- Obtiene el valor de la columna PAFACOCD
    FUNCTION fnuObtPAFACOCD(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACOCD%TYPE;
 
    -- Obtiene el valor de la columna PAFACRCD
    FUNCTION fnuObtPAFACRCD(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACRCD%TYPE;
 
    -- Obtiene el valor de la columna PAFAEMPS
    FUNCTION fnuObtPAFAEMPS(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAEMPS%TYPE;
 
    -- Actualiza el valor de la columna PAFANMFV
    PROCEDURE prAcPAFANMFV(
        inuPAFACODI    NUMBER,
        inuPAFANMFV    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANFVI
    PROCEDURE prAcPAFANFVI(
        inuPAFACODI    NUMBER,
        inuPAFANFVI    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAMORA
    PROCEDURE prAcPAFAMORA(
        inuPAFACODI    NUMBER,
        inuPAFAMORA    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAPASA
    PROCEDURE prAcPAFAPASA(
        inuPAFACODI    NUMBER,
        inuPAFAPASA    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAPOIV
    PROCEDURE prAcPAFAPOIV(
        inuPAFACODI    NUMBER,
        inuPAFAPOIV    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAREFU
    PROCEDURE prAcPAFAREFU(
        inuPAFACODI    NUMBER,
        inuPAFAREFU    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAINMO
    PROCEDURE prAcPAFAINMO(
        inuPAFACODI    NUMBER,
        inuPAFAINMO    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANMMM
    PROCEDURE prAcPAFANMMM(
        inuPAFACODI    NUMBER,
        inuPAFANMMM    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACAPM
    PROCEDURE prAcPAFACAPM(
        inuPAFACODI    NUMBER,
        inuPAFACAPM    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAPAGO
    PROCEDURE prAcPAFAPAGO(
        inuPAFACODI    NUMBER,
        inuPAFAPAGO    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAANTI
    PROCEDURE prAcPAFAANTI(
        inuPAFACODI    NUMBER,
        inuPAFAANTI    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFASAFA
    PROCEDURE prAcPAFASAFA(
        inuPAFACODI    NUMBER,
        inuPAFASAFA    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACOAJ
    PROCEDURE prAcPAFACOAJ(
        inuPAFACODI    NUMBER,
        inuPAFACOAJ    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAASAF
    PROCEDURE prAcPAFAASAF(
        inuPAFACODI    NUMBER,
        inuPAFAASAF    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFADIFE
    PROCEDURE prAcPAFADIFE(
        inuPAFACODI    NUMBER,
        inuPAFADIFE    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFARECA
    PROCEDURE prAcPAFARECA(
        inuPAFACODI    NUMBER,
        isbPAFARECA    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PAFAFARE
    PROCEDURE prAcPAFAFARE(
        inuPAFACODI    NUMBER,
        inuPAFAFARE    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANUFA
    PROCEDURE prAcPAFANUFA(
        inuPAFACODI    NUMBER,
        inuPAFANUFA    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANUCU
    PROCEDURE prAcPAFANUCU(
        inuPAFACODI    NUMBER,
        inuPAFANUCU    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANUDI
    PROCEDURE prAcPAFANUDI(
        inuPAFACODI    NUMBER,
        inuPAFANUDI    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANUNC
    PROCEDURE prAcPAFANUNC(
        inuPAFACODI    NUMBER,
        inuPAFANUNC    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACDAR
    PROCEDURE prAcPAFACDAR(
        inuPAFACODI    NUMBER,
        inuPAFACDAR    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACREF
    PROCEDURE prAcPAFACREF(
        inuPAFACODI    NUMBER,
        inuPAFACREF    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFANUCO
    PROCEDURE prAcPAFANUCO(
        inuPAFACODI    NUMBER,
        inuPAFANUCO    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAFIDE
    PROCEDURE prAcPAFAFIDE(
        inuPAFACODI    NUMBER,
        inuPAFAFIDE    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAPTMP
    PROCEDURE prAcPAFAPTMP(
        inuPAFACODI    NUMBER,
        isbPAFAPTMP    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PAFAAPLI
    PROCEDURE prAcPAFAAPLI(
        inuPAFACODI    NUMBER,
        inuPAFAAPLI    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAMCDI
    PROCEDURE prAcPAFAMCDI(
        inuPAFACODI    NUMBER,
        inuPAFAMCDI    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACRMR
    PROCEDURE prAcPAFACRMR(
        inuPAFACODI    NUMBER,
        inuPAFACRMR    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACOCD
    PROCEDURE prAcPAFACOCD(
        inuPAFACODI    NUMBER,
        inuPAFACOCD    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFACRCD
    PROCEDURE prAcPAFACRCD(
        inuPAFACODI    NUMBER,
        inuPAFACRCD    NUMBER
    );
 
    -- Actualiza el valor de la columna PAFAEMPS
    PROCEDURE prAcPAFAEMPS(
        inuPAFACODI    NUMBER,
        inuPAFAEMPS    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuparafact%ROWTYPE);
 
END pkg_parafact;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_parafact AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuPAFACODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuPAFACODI);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuPAFACODI);
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
        inuPAFACODI    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.PAFACODI IS NOT NULL;
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
        inuPAFACODI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuPAFACODI) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuPAFACODI||'] en la tabla[parafact]');
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
    PROCEDURE prInsRegistro( ircRegistro cuparafact%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO parafact(
            PAFACODI,PAFANMFV,PAFANFVI,PAFAMORA,PAFAPASA,PAFAPOIV,PAFAREFU,PAFAINMO,PAFANMMM,PAFACAPM,PAFAPAGO,PAFAANTI,PAFASAFA,PAFACOAJ,PAFAASAF,PAFADIFE,PAFARECA,PAFAFARE,PAFANUFA,PAFANUCU,PAFANUDI,PAFANUNC,PAFACDAR,PAFACREF,PAFANUCO,PAFAFIDE,PAFAPTMP,PAFAAPLI,PAFAMCDI,PAFACRMR,PAFACOCD,PAFACRCD,PAFAEMPS
        )
        VALUES (
            ircRegistro.PAFACODI,ircRegistro.PAFANMFV,ircRegistro.PAFANFVI,ircRegistro.PAFAMORA,ircRegistro.PAFAPASA,ircRegistro.PAFAPOIV,ircRegistro.PAFAREFU,ircRegistro.PAFAINMO,ircRegistro.PAFANMMM,ircRegistro.PAFACAPM,ircRegistro.PAFAPAGO,ircRegistro.PAFAANTI,ircRegistro.PAFASAFA,ircRegistro.PAFACOAJ,ircRegistro.PAFAASAF,ircRegistro.PAFADIFE,ircRegistro.PAFARECA,ircRegistro.PAFAFARE,ircRegistro.PAFANUFA,ircRegistro.PAFANUCU,ircRegistro.PAFANUDI,ircRegistro.PAFANUNC,ircRegistro.PAFACDAR,ircRegistro.PAFACREF,ircRegistro.PAFANUCO,ircRegistro.PAFAFIDE,ircRegistro.PAFAPTMP,ircRegistro.PAFAAPLI,ircRegistro.PAFAMCDI,ircRegistro.PAFACRMR,ircRegistro.PAFACOCD,ircRegistro.PAFACRCD,ircRegistro.PAFAEMPS
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
        inuPAFACODI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE parafact
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
            DELETE parafact
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
 
    -- Obtiene el valor de la columna PAFANMFV
    FUNCTION fnuObtPAFANMFV(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANMFV%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANMFV';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANMFV;
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
    END fnuObtPAFANMFV;
 
    -- Obtiene el valor de la columna PAFANFVI
    FUNCTION fnuObtPAFANFVI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANFVI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANFVI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANFVI;
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
    END fnuObtPAFANFVI;
 
    -- Obtiene el valor de la columna PAFAMORA
    FUNCTION fnuObtPAFAMORA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAMORA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAMORA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAMORA;
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
    END fnuObtPAFAMORA;
 
    -- Obtiene el valor de la columna PAFAPASA
    FUNCTION fnuObtPAFAPASA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPASA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAPASA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAPASA;
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
    END fnuObtPAFAPASA;
 
    -- Obtiene el valor de la columna PAFAPOIV
    FUNCTION fnuObtPAFAPOIV(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPOIV%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAPOIV';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAPOIV;
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
    END fnuObtPAFAPOIV;
 
    -- Obtiene el valor de la columna PAFAREFU
    FUNCTION fnuObtPAFAREFU(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAREFU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAREFU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAREFU;
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
    END fnuObtPAFAREFU;
 
    -- Obtiene el valor de la columna PAFAINMO
    FUNCTION fnuObtPAFAINMO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAINMO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAINMO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAINMO;
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
    END fnuObtPAFAINMO;
 
    -- Obtiene el valor de la columna PAFANMMM
    FUNCTION fnuObtPAFANMMM(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANMMM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANMMM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANMMM;
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
    END fnuObtPAFANMMM;
 
    -- Obtiene el valor de la columna PAFACAPM
    FUNCTION fnuObtPAFACAPM(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACAPM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACAPM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACAPM;
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
    END fnuObtPAFACAPM;
 
    -- Obtiene el valor de la columna PAFAPAGO
    FUNCTION fnuObtPAFAPAGO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPAGO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAPAGO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAPAGO;
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
    END fnuObtPAFAPAGO;
 
    -- Obtiene el valor de la columna PAFAANTI
    FUNCTION fnuObtPAFAANTI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAANTI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAANTI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAANTI;
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
    END fnuObtPAFAANTI;
 
    -- Obtiene el valor de la columna PAFASAFA
    FUNCTION fnuObtPAFASAFA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFASAFA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFASAFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFASAFA;
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
    END fnuObtPAFASAFA;
 
    -- Obtiene el valor de la columna PAFACOAJ
    FUNCTION fnuObtPAFACOAJ(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACOAJ%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACOAJ';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACOAJ;
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
    END fnuObtPAFACOAJ;
 
    -- Obtiene el valor de la columna PAFAASAF
    FUNCTION fnuObtPAFAASAF(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAASAF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAASAF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAASAF;
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
    END fnuObtPAFAASAF;
 
    -- Obtiene el valor de la columna PAFADIFE
    FUNCTION fnuObtPAFADIFE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFADIFE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFADIFE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFADIFE;
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
    END fnuObtPAFADIFE;
 
    -- Obtiene el valor de la columna PAFARECA
    FUNCTION fsbObtPAFARECA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFARECA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPAFARECA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFARECA;
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
    END fsbObtPAFARECA;
 
    -- Obtiene el valor de la columna PAFAFARE
    FUNCTION fnuObtPAFAFARE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAFARE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAFARE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAFARE;
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
    END fnuObtPAFAFARE;
 
    -- Obtiene el valor de la columna PAFANUFA
    FUNCTION fnuObtPAFANUFA(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUFA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANUFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANUFA;
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
    END fnuObtPAFANUFA;
 
    -- Obtiene el valor de la columna PAFANUCU
    FUNCTION fnuObtPAFANUCU(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUCU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANUCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANUCU;
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
    END fnuObtPAFANUCU;
 
    -- Obtiene el valor de la columna PAFANUDI
    FUNCTION fnuObtPAFANUDI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUDI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANUDI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANUDI;
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
    END fnuObtPAFANUDI;
 
    -- Obtiene el valor de la columna PAFANUNC
    FUNCTION fnuObtPAFANUNC(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUNC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANUNC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANUNC;
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
    END fnuObtPAFANUNC;
 
    -- Obtiene el valor de la columna PAFACDAR
    FUNCTION fnuObtPAFACDAR(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACDAR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACDAR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACDAR;
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
    END fnuObtPAFACDAR;
 
    -- Obtiene el valor de la columna PAFACREF
    FUNCTION fnuObtPAFACREF(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACREF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACREF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACREF;
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
    END fnuObtPAFACREF;
 
    -- Obtiene el valor de la columna PAFANUCO
    FUNCTION fnuObtPAFANUCO(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFANUCO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFANUCO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFANUCO;
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
    END fnuObtPAFANUCO;
 
    -- Obtiene el valor de la columna PAFAFIDE
    FUNCTION fnuObtPAFAFIDE(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAFIDE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAFIDE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAFIDE;
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
    END fnuObtPAFAFIDE;
 
    -- Obtiene el valor de la columna PAFAPTMP
    FUNCTION fsbObtPAFAPTMP(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAPTMP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPAFAPTMP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAPTMP;
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
    END fsbObtPAFAPTMP;
 
    -- Obtiene el valor de la columna PAFAAPLI
    FUNCTION fnuObtPAFAAPLI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAAPLI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAAPLI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAAPLI;
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
    END fnuObtPAFAAPLI;
 
    -- Obtiene el valor de la columna PAFAMCDI
    FUNCTION fnuObtPAFAMCDI(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAMCDI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAMCDI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAMCDI;
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
    END fnuObtPAFAMCDI;
 
    -- Obtiene el valor de la columna PAFACRMR
    FUNCTION fnuObtPAFACRMR(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACRMR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACRMR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACRMR;
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
    END fnuObtPAFACRMR;
 
    -- Obtiene el valor de la columna PAFACOCD
    FUNCTION fnuObtPAFACOCD(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACOCD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACOCD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACOCD;
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
    END fnuObtPAFACOCD;
 
    -- Obtiene el valor de la columna PAFACRCD
    FUNCTION fnuObtPAFACRCD(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFACRCD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFACRCD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFACRCD;
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
    END fnuObtPAFACRCD;
 
    -- Obtiene el valor de la columna PAFAEMPS
    FUNCTION fnuObtPAFAEMPS(
        inuPAFACODI    NUMBER
        ) RETURN parafact.PAFAEMPS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPAFAEMPS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PAFAEMPS;
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
    END fnuObtPAFAEMPS;
 
    -- Actualiza el valor de la columna PAFANMFV
    PROCEDURE prAcPAFANMFV(
        inuPAFACODI    NUMBER,
        inuPAFANMFV    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANMFV';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANMFV,-1) <> NVL(rcRegistroAct.PAFANMFV,-1) THEN
            UPDATE parafact
            SET PAFANMFV=inuPAFANMFV
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
    END prAcPAFANMFV;
 
    -- Actualiza el valor de la columna PAFANFVI
    PROCEDURE prAcPAFANFVI(
        inuPAFACODI    NUMBER,
        inuPAFANFVI    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANFVI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANFVI,-1) <> NVL(rcRegistroAct.PAFANFVI,-1) THEN
            UPDATE parafact
            SET PAFANFVI=inuPAFANFVI
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
    END prAcPAFANFVI;
 
    -- Actualiza el valor de la columna PAFAMORA
    PROCEDURE prAcPAFAMORA(
        inuPAFACODI    NUMBER,
        inuPAFAMORA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAMORA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAMORA,-1) <> NVL(rcRegistroAct.PAFAMORA,-1) THEN
            UPDATE parafact
            SET PAFAMORA=inuPAFAMORA
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
    END prAcPAFAMORA;
 
    -- Actualiza el valor de la columna PAFAPASA
    PROCEDURE prAcPAFAPASA(
        inuPAFACODI    NUMBER,
        inuPAFAPASA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPASA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAPASA,-1) <> NVL(rcRegistroAct.PAFAPASA,-1) THEN
            UPDATE parafact
            SET PAFAPASA=inuPAFAPASA
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
    END prAcPAFAPASA;
 
    -- Actualiza el valor de la columna PAFAPOIV
    PROCEDURE prAcPAFAPOIV(
        inuPAFACODI    NUMBER,
        inuPAFAPOIV    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPOIV';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAPOIV,-1) <> NVL(rcRegistroAct.PAFAPOIV,-1) THEN
            UPDATE parafact
            SET PAFAPOIV=inuPAFAPOIV
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
    END prAcPAFAPOIV;
 
    -- Actualiza el valor de la columna PAFAREFU
    PROCEDURE prAcPAFAREFU(
        inuPAFACODI    NUMBER,
        inuPAFAREFU    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAREFU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAREFU,-1) <> NVL(rcRegistroAct.PAFAREFU,-1) THEN
            UPDATE parafact
            SET PAFAREFU=inuPAFAREFU
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
    END prAcPAFAREFU;
 
    -- Actualiza el valor de la columna PAFAINMO
    PROCEDURE prAcPAFAINMO(
        inuPAFACODI    NUMBER,
        inuPAFAINMO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAINMO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAINMO,-1) <> NVL(rcRegistroAct.PAFAINMO,-1) THEN
            UPDATE parafact
            SET PAFAINMO=inuPAFAINMO
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
    END prAcPAFAINMO;
 
    -- Actualiza el valor de la columna PAFANMMM
    PROCEDURE prAcPAFANMMM(
        inuPAFACODI    NUMBER,
        inuPAFANMMM    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANMMM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANMMM,-1) <> NVL(rcRegistroAct.PAFANMMM,-1) THEN
            UPDATE parafact
            SET PAFANMMM=inuPAFANMMM
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
    END prAcPAFANMMM;
 
    -- Actualiza el valor de la columna PAFACAPM
    PROCEDURE prAcPAFACAPM(
        inuPAFACODI    NUMBER,
        inuPAFACAPM    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACAPM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACAPM,-1) <> NVL(rcRegistroAct.PAFACAPM,-1) THEN
            UPDATE parafact
            SET PAFACAPM=inuPAFACAPM
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
    END prAcPAFACAPM;
 
    -- Actualiza el valor de la columna PAFAPAGO
    PROCEDURE prAcPAFAPAGO(
        inuPAFACODI    NUMBER,
        inuPAFAPAGO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPAGO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAPAGO,-1) <> NVL(rcRegistroAct.PAFAPAGO,-1) THEN
            UPDATE parafact
            SET PAFAPAGO=inuPAFAPAGO
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
    END prAcPAFAPAGO;
 
    -- Actualiza el valor de la columna PAFAANTI
    PROCEDURE prAcPAFAANTI(
        inuPAFACODI    NUMBER,
        inuPAFAANTI    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAANTI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAANTI,-1) <> NVL(rcRegistroAct.PAFAANTI,-1) THEN
            UPDATE parafact
            SET PAFAANTI=inuPAFAANTI
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
    END prAcPAFAANTI;
 
    -- Actualiza el valor de la columna PAFASAFA
    PROCEDURE prAcPAFASAFA(
        inuPAFACODI    NUMBER,
        inuPAFASAFA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFASAFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFASAFA,-1) <> NVL(rcRegistroAct.PAFASAFA,-1) THEN
            UPDATE parafact
            SET PAFASAFA=inuPAFASAFA
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
    END prAcPAFASAFA;
 
    -- Actualiza el valor de la columna PAFACOAJ
    PROCEDURE prAcPAFACOAJ(
        inuPAFACODI    NUMBER,
        inuPAFACOAJ    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACOAJ';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACOAJ,-1) <> NVL(rcRegistroAct.PAFACOAJ,-1) THEN
            UPDATE parafact
            SET PAFACOAJ=inuPAFACOAJ
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
    END prAcPAFACOAJ;
 
    -- Actualiza el valor de la columna PAFAASAF
    PROCEDURE prAcPAFAASAF(
        inuPAFACODI    NUMBER,
        inuPAFAASAF    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAASAF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAASAF,-1) <> NVL(rcRegistroAct.PAFAASAF,-1) THEN
            UPDATE parafact
            SET PAFAASAF=inuPAFAASAF
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
    END prAcPAFAASAF;
 
    -- Actualiza el valor de la columna PAFADIFE
    PROCEDURE prAcPAFADIFE(
        inuPAFACODI    NUMBER,
        inuPAFADIFE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFADIFE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFADIFE,-1) <> NVL(rcRegistroAct.PAFADIFE,-1) THEN
            UPDATE parafact
            SET PAFADIFE=inuPAFADIFE
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
    END prAcPAFADIFE;
 
    -- Actualiza el valor de la columna PAFARECA
    PROCEDURE prAcPAFARECA(
        inuPAFACODI    NUMBER,
        isbPAFARECA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFARECA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(isbPAFARECA,'-') <> NVL(rcRegistroAct.PAFARECA,'-') THEN
            UPDATE parafact
            SET PAFARECA=isbPAFARECA
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
    END prAcPAFARECA;
 
    -- Actualiza el valor de la columna PAFAFARE
    PROCEDURE prAcPAFAFARE(
        inuPAFACODI    NUMBER,
        inuPAFAFARE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAFARE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAFARE,-1) <> NVL(rcRegistroAct.PAFAFARE,-1) THEN
            UPDATE parafact
            SET PAFAFARE=inuPAFAFARE
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
    END prAcPAFAFARE;
 
    -- Actualiza el valor de la columna PAFANUFA
    PROCEDURE prAcPAFANUFA(
        inuPAFACODI    NUMBER,
        inuPAFANUFA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANUFA,-1) <> NVL(rcRegistroAct.PAFANUFA,-1) THEN
            UPDATE parafact
            SET PAFANUFA=inuPAFANUFA
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
    END prAcPAFANUFA;
 
    -- Actualiza el valor de la columna PAFANUCU
    PROCEDURE prAcPAFANUCU(
        inuPAFACODI    NUMBER,
        inuPAFANUCU    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUCU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANUCU,-1) <> NVL(rcRegistroAct.PAFANUCU,-1) THEN
            UPDATE parafact
            SET PAFANUCU=inuPAFANUCU
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
    END prAcPAFANUCU;
 
    -- Actualiza el valor de la columna PAFANUDI
    PROCEDURE prAcPAFANUDI(
        inuPAFACODI    NUMBER,
        inuPAFANUDI    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUDI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANUDI,-1) <> NVL(rcRegistroAct.PAFANUDI,-1) THEN
            UPDATE parafact
            SET PAFANUDI=inuPAFANUDI
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
    END prAcPAFANUDI;
 
    -- Actualiza el valor de la columna PAFANUNC
    PROCEDURE prAcPAFANUNC(
        inuPAFACODI    NUMBER,
        inuPAFANUNC    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUNC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANUNC,-1) <> NVL(rcRegistroAct.PAFANUNC,-1) THEN
            UPDATE parafact
            SET PAFANUNC=inuPAFANUNC
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
    END prAcPAFANUNC;
 
    -- Actualiza el valor de la columna PAFACDAR
    PROCEDURE prAcPAFACDAR(
        inuPAFACODI    NUMBER,
        inuPAFACDAR    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACDAR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACDAR,-1) <> NVL(rcRegistroAct.PAFACDAR,-1) THEN
            UPDATE parafact
            SET PAFACDAR=inuPAFACDAR
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
    END prAcPAFACDAR;
 
    -- Actualiza el valor de la columna PAFACREF
    PROCEDURE prAcPAFACREF(
        inuPAFACODI    NUMBER,
        inuPAFACREF    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACREF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACREF,-1) <> NVL(rcRegistroAct.PAFACREF,-1) THEN
            UPDATE parafact
            SET PAFACREF=inuPAFACREF
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
    END prAcPAFACREF;
 
    -- Actualiza el valor de la columna PAFANUCO
    PROCEDURE prAcPAFANUCO(
        inuPAFACODI    NUMBER,
        inuPAFANUCO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUCO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFANUCO,-1) <> NVL(rcRegistroAct.PAFANUCO,-1) THEN
            UPDATE parafact
            SET PAFANUCO=inuPAFANUCO
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
    END prAcPAFANUCO;
 
    -- Actualiza el valor de la columna PAFAFIDE
    PROCEDURE prAcPAFAFIDE(
        inuPAFACODI    NUMBER,
        inuPAFAFIDE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAFIDE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAFIDE,-1) <> NVL(rcRegistroAct.PAFAFIDE,-1) THEN
            UPDATE parafact
            SET PAFAFIDE=inuPAFAFIDE
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
    END prAcPAFAFIDE;
 
    -- Actualiza el valor de la columna PAFAPTMP
    PROCEDURE prAcPAFAPTMP(
        inuPAFACODI    NUMBER,
        isbPAFAPTMP    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPTMP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(isbPAFAPTMP,'-') <> NVL(rcRegistroAct.PAFAPTMP,'-') THEN
            UPDATE parafact
            SET PAFAPTMP=isbPAFAPTMP
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
    END prAcPAFAPTMP;
 
    -- Actualiza el valor de la columna PAFAAPLI
    PROCEDURE prAcPAFAAPLI(
        inuPAFACODI    NUMBER,
        inuPAFAAPLI    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAAPLI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAAPLI,-1) <> NVL(rcRegistroAct.PAFAAPLI,-1) THEN
            UPDATE parafact
            SET PAFAAPLI=inuPAFAAPLI
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
    END prAcPAFAAPLI;
 
    -- Actualiza el valor de la columna PAFAMCDI
    PROCEDURE prAcPAFAMCDI(
        inuPAFACODI    NUMBER,
        inuPAFAMCDI    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAMCDI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAMCDI,-1) <> NVL(rcRegistroAct.PAFAMCDI,-1) THEN
            UPDATE parafact
            SET PAFAMCDI=inuPAFAMCDI
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
    END prAcPAFAMCDI;
 
    -- Actualiza el valor de la columna PAFACRMR
    PROCEDURE prAcPAFACRMR(
        inuPAFACODI    NUMBER,
        inuPAFACRMR    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACRMR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACRMR,-1) <> NVL(rcRegistroAct.PAFACRMR,-1) THEN
            UPDATE parafact
            SET PAFACRMR=inuPAFACRMR
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
    END prAcPAFACRMR;
 
    -- Actualiza el valor de la columna PAFACOCD
    PROCEDURE prAcPAFACOCD(
        inuPAFACODI    NUMBER,
        inuPAFACOCD    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACOCD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACOCD,-1) <> NVL(rcRegistroAct.PAFACOCD,-1) THEN
            UPDATE parafact
            SET PAFACOCD=inuPAFACOCD
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
    END prAcPAFACOCD;
 
    -- Actualiza el valor de la columna PAFACRCD
    PROCEDURE prAcPAFACRCD(
        inuPAFACODI    NUMBER,
        inuPAFACRCD    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACRCD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFACRCD,-1) <> NVL(rcRegistroAct.PAFACRCD,-1) THEN
            UPDATE parafact
            SET PAFACRCD=inuPAFACRCD
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
    END prAcPAFACRCD;
 
    -- Actualiza el valor de la columna PAFAEMPS
    PROCEDURE prAcPAFAEMPS(
        inuPAFACODI    NUMBER,
        inuPAFAEMPS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAEMPS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPAFACODI,TRUE);
        IF NVL(inuPAFAEMPS,-1) <> NVL(rcRegistroAct.PAFAEMPS,-1) THEN
            UPDATE parafact
            SET PAFAEMPS=inuPAFAEMPS
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
    END prAcPAFAEMPS;
 
    -- Actualiza por RowId el valor de la columna PAFANMFV
    PROCEDURE prAcPAFANMFV_RId(
        iRowId ROWID,
        inuPAFANMFV_O    NUMBER,
        inuPAFANMFV_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANMFV_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANMFV_O,-1) <> NVL(inuPAFANMFV_N,-1) THEN
            UPDATE parafact
            SET PAFANMFV=inuPAFANMFV_N
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
    END prAcPAFANMFV_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANFVI
    PROCEDURE prAcPAFANFVI_RId(
        iRowId ROWID,
        inuPAFANFVI_O    NUMBER,
        inuPAFANFVI_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANFVI_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANFVI_O,-1) <> NVL(inuPAFANFVI_N,-1) THEN
            UPDATE parafact
            SET PAFANFVI=inuPAFANFVI_N
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
    END prAcPAFANFVI_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAMORA
    PROCEDURE prAcPAFAMORA_RId(
        iRowId ROWID,
        inuPAFAMORA_O    NUMBER,
        inuPAFAMORA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAMORA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAMORA_O,-1) <> NVL(inuPAFAMORA_N,-1) THEN
            UPDATE parafact
            SET PAFAMORA=inuPAFAMORA_N
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
    END prAcPAFAMORA_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAPASA
    PROCEDURE prAcPAFAPASA_RId(
        iRowId ROWID,
        inuPAFAPASA_O    NUMBER,
        inuPAFAPASA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPASA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAPASA_O,-1) <> NVL(inuPAFAPASA_N,-1) THEN
            UPDATE parafact
            SET PAFAPASA=inuPAFAPASA_N
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
    END prAcPAFAPASA_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAPOIV
    PROCEDURE prAcPAFAPOIV_RId(
        iRowId ROWID,
        inuPAFAPOIV_O    NUMBER,
        inuPAFAPOIV_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPOIV_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAPOIV_O,-1) <> NVL(inuPAFAPOIV_N,-1) THEN
            UPDATE parafact
            SET PAFAPOIV=inuPAFAPOIV_N
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
    END prAcPAFAPOIV_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAREFU
    PROCEDURE prAcPAFAREFU_RId(
        iRowId ROWID,
        inuPAFAREFU_O    NUMBER,
        inuPAFAREFU_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAREFU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAREFU_O,-1) <> NVL(inuPAFAREFU_N,-1) THEN
            UPDATE parafact
            SET PAFAREFU=inuPAFAREFU_N
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
    END prAcPAFAREFU_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAINMO
    PROCEDURE prAcPAFAINMO_RId(
        iRowId ROWID,
        inuPAFAINMO_O    NUMBER,
        inuPAFAINMO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAINMO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAINMO_O,-1) <> NVL(inuPAFAINMO_N,-1) THEN
            UPDATE parafact
            SET PAFAINMO=inuPAFAINMO_N
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
    END prAcPAFAINMO_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANMMM
    PROCEDURE prAcPAFANMMM_RId(
        iRowId ROWID,
        inuPAFANMMM_O    NUMBER,
        inuPAFANMMM_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANMMM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANMMM_O,-1) <> NVL(inuPAFANMMM_N,-1) THEN
            UPDATE parafact
            SET PAFANMMM=inuPAFANMMM_N
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
    END prAcPAFANMMM_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACAPM
    PROCEDURE prAcPAFACAPM_RId(
        iRowId ROWID,
        inuPAFACAPM_O    NUMBER,
        inuPAFACAPM_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACAPM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACAPM_O,-1) <> NVL(inuPAFACAPM_N,-1) THEN
            UPDATE parafact
            SET PAFACAPM=inuPAFACAPM_N
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
    END prAcPAFACAPM_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAPAGO
    PROCEDURE prAcPAFAPAGO_RId(
        iRowId ROWID,
        inuPAFAPAGO_O    NUMBER,
        inuPAFAPAGO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPAGO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAPAGO_O,-1) <> NVL(inuPAFAPAGO_N,-1) THEN
            UPDATE parafact
            SET PAFAPAGO=inuPAFAPAGO_N
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
    END prAcPAFAPAGO_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAANTI
    PROCEDURE prAcPAFAANTI_RId(
        iRowId ROWID,
        inuPAFAANTI_O    NUMBER,
        inuPAFAANTI_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAANTI_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAANTI_O,-1) <> NVL(inuPAFAANTI_N,-1) THEN
            UPDATE parafact
            SET PAFAANTI=inuPAFAANTI_N
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
    END prAcPAFAANTI_RId;
 
    -- Actualiza por RowId el valor de la columna PAFASAFA
    PROCEDURE prAcPAFASAFA_RId(
        iRowId ROWID,
        inuPAFASAFA_O    NUMBER,
        inuPAFASAFA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFASAFA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFASAFA_O,-1) <> NVL(inuPAFASAFA_N,-1) THEN
            UPDATE parafact
            SET PAFASAFA=inuPAFASAFA_N
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
    END prAcPAFASAFA_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACOAJ
    PROCEDURE prAcPAFACOAJ_RId(
        iRowId ROWID,
        inuPAFACOAJ_O    NUMBER,
        inuPAFACOAJ_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACOAJ_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACOAJ_O,-1) <> NVL(inuPAFACOAJ_N,-1) THEN
            UPDATE parafact
            SET PAFACOAJ=inuPAFACOAJ_N
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
    END prAcPAFACOAJ_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAASAF
    PROCEDURE prAcPAFAASAF_RId(
        iRowId ROWID,
        inuPAFAASAF_O    NUMBER,
        inuPAFAASAF_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAASAF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAASAF_O,-1) <> NVL(inuPAFAASAF_N,-1) THEN
            UPDATE parafact
            SET PAFAASAF=inuPAFAASAF_N
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
    END prAcPAFAASAF_RId;
 
    -- Actualiza por RowId el valor de la columna PAFADIFE
    PROCEDURE prAcPAFADIFE_RId(
        iRowId ROWID,
        inuPAFADIFE_O    NUMBER,
        inuPAFADIFE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFADIFE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFADIFE_O,-1) <> NVL(inuPAFADIFE_N,-1) THEN
            UPDATE parafact
            SET PAFADIFE=inuPAFADIFE_N
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
    END prAcPAFADIFE_RId;
 
    -- Actualiza por RowId el valor de la columna PAFARECA
    PROCEDURE prAcPAFARECA_RId(
        iRowId ROWID,
        isbPAFARECA_O    VARCHAR2,
        isbPAFARECA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFARECA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPAFARECA_O,'-') <> NVL(isbPAFARECA_N,'-') THEN
            UPDATE parafact
            SET PAFARECA=isbPAFARECA_N
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
    END prAcPAFARECA_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAFARE
    PROCEDURE prAcPAFAFARE_RId(
        iRowId ROWID,
        inuPAFAFARE_O    NUMBER,
        inuPAFAFARE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAFARE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAFARE_O,-1) <> NVL(inuPAFAFARE_N,-1) THEN
            UPDATE parafact
            SET PAFAFARE=inuPAFAFARE_N
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
    END prAcPAFAFARE_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANUFA
    PROCEDURE prAcPAFANUFA_RId(
        iRowId ROWID,
        inuPAFANUFA_O    NUMBER,
        inuPAFANUFA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUFA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANUFA_O,-1) <> NVL(inuPAFANUFA_N,-1) THEN
            UPDATE parafact
            SET PAFANUFA=inuPAFANUFA_N
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
    END prAcPAFANUFA_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANUCU
    PROCEDURE prAcPAFANUCU_RId(
        iRowId ROWID,
        inuPAFANUCU_O    NUMBER,
        inuPAFANUCU_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUCU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANUCU_O,-1) <> NVL(inuPAFANUCU_N,-1) THEN
            UPDATE parafact
            SET PAFANUCU=inuPAFANUCU_N
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
    END prAcPAFANUCU_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANUDI
    PROCEDURE prAcPAFANUDI_RId(
        iRowId ROWID,
        inuPAFANUDI_O    NUMBER,
        inuPAFANUDI_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUDI_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANUDI_O,-1) <> NVL(inuPAFANUDI_N,-1) THEN
            UPDATE parafact
            SET PAFANUDI=inuPAFANUDI_N
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
    END prAcPAFANUDI_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANUNC
    PROCEDURE prAcPAFANUNC_RId(
        iRowId ROWID,
        inuPAFANUNC_O    NUMBER,
        inuPAFANUNC_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUNC_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANUNC_O,-1) <> NVL(inuPAFANUNC_N,-1) THEN
            UPDATE parafact
            SET PAFANUNC=inuPAFANUNC_N
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
    END prAcPAFANUNC_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACDAR
    PROCEDURE prAcPAFACDAR_RId(
        iRowId ROWID,
        inuPAFACDAR_O    NUMBER,
        inuPAFACDAR_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACDAR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACDAR_O,-1) <> NVL(inuPAFACDAR_N,-1) THEN
            UPDATE parafact
            SET PAFACDAR=inuPAFACDAR_N
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
    END prAcPAFACDAR_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACREF
    PROCEDURE prAcPAFACREF_RId(
        iRowId ROWID,
        inuPAFACREF_O    NUMBER,
        inuPAFACREF_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACREF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACREF_O,-1) <> NVL(inuPAFACREF_N,-1) THEN
            UPDATE parafact
            SET PAFACREF=inuPAFACREF_N
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
    END prAcPAFACREF_RId;
 
    -- Actualiza por RowId el valor de la columna PAFANUCO
    PROCEDURE prAcPAFANUCO_RId(
        iRowId ROWID,
        inuPAFANUCO_O    NUMBER,
        inuPAFANUCO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFANUCO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFANUCO_O,-1) <> NVL(inuPAFANUCO_N,-1) THEN
            UPDATE parafact
            SET PAFANUCO=inuPAFANUCO_N
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
    END prAcPAFANUCO_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAFIDE
    PROCEDURE prAcPAFAFIDE_RId(
        iRowId ROWID,
        inuPAFAFIDE_O    NUMBER,
        inuPAFAFIDE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAFIDE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAFIDE_O,-1) <> NVL(inuPAFAFIDE_N,-1) THEN
            UPDATE parafact
            SET PAFAFIDE=inuPAFAFIDE_N
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
    END prAcPAFAFIDE_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAPTMP
    PROCEDURE prAcPAFAPTMP_RId(
        iRowId ROWID,
        isbPAFAPTMP_O    VARCHAR2,
        isbPAFAPTMP_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAPTMP_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPAFAPTMP_O,'-') <> NVL(isbPAFAPTMP_N,'-') THEN
            UPDATE parafact
            SET PAFAPTMP=isbPAFAPTMP_N
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
    END prAcPAFAPTMP_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAAPLI
    PROCEDURE prAcPAFAAPLI_RId(
        iRowId ROWID,
        inuPAFAAPLI_O    NUMBER,
        inuPAFAAPLI_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAAPLI_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAAPLI_O,-1) <> NVL(inuPAFAAPLI_N,-1) THEN
            UPDATE parafact
            SET PAFAAPLI=inuPAFAAPLI_N
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
    END prAcPAFAAPLI_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAMCDI
    PROCEDURE prAcPAFAMCDI_RId(
        iRowId ROWID,
        inuPAFAMCDI_O    NUMBER,
        inuPAFAMCDI_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAMCDI_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAMCDI_O,-1) <> NVL(inuPAFAMCDI_N,-1) THEN
            UPDATE parafact
            SET PAFAMCDI=inuPAFAMCDI_N
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
    END prAcPAFAMCDI_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACRMR
    PROCEDURE prAcPAFACRMR_RId(
        iRowId ROWID,
        inuPAFACRMR_O    NUMBER,
        inuPAFACRMR_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACRMR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACRMR_O,-1) <> NVL(inuPAFACRMR_N,-1) THEN
            UPDATE parafact
            SET PAFACRMR=inuPAFACRMR_N
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
    END prAcPAFACRMR_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACOCD
    PROCEDURE prAcPAFACOCD_RId(
        iRowId ROWID,
        inuPAFACOCD_O    NUMBER,
        inuPAFACOCD_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACOCD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACOCD_O,-1) <> NVL(inuPAFACOCD_N,-1) THEN
            UPDATE parafact
            SET PAFACOCD=inuPAFACOCD_N
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
    END prAcPAFACOCD_RId;
 
    -- Actualiza por RowId el valor de la columna PAFACRCD
    PROCEDURE prAcPAFACRCD_RId(
        iRowId ROWID,
        inuPAFACRCD_O    NUMBER,
        inuPAFACRCD_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFACRCD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFACRCD_O,-1) <> NVL(inuPAFACRCD_N,-1) THEN
            UPDATE parafact
            SET PAFACRCD=inuPAFACRCD_N
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
    END prAcPAFACRCD_RId;
 
    -- Actualiza por RowId el valor de la columna PAFAEMPS
    PROCEDURE prAcPAFAEMPS_RId(
        iRowId ROWID,
        inuPAFAEMPS_O    NUMBER,
        inuPAFAEMPS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPAFAEMPS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPAFAEMPS_O,-1) <> NVL(inuPAFAEMPS_N,-1) THEN
            UPDATE parafact
            SET PAFAEMPS=inuPAFAEMPS_N
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
    END prAcPAFAEMPS_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuparafact%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.PAFACODI,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPAFANMFV_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANMFV,
                ircRegistro.PAFANMFV
            );
 
            prAcPAFANFVI_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANFVI,
                ircRegistro.PAFANFVI
            );
 
            prAcPAFAMORA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAMORA,
                ircRegistro.PAFAMORA
            );
 
            prAcPAFAPASA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAPASA,
                ircRegistro.PAFAPASA
            );
 
            prAcPAFAPOIV_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAPOIV,
                ircRegistro.PAFAPOIV
            );
 
            prAcPAFAREFU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAREFU,
                ircRegistro.PAFAREFU
            );
 
            prAcPAFAINMO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAINMO,
                ircRegistro.PAFAINMO
            );
 
            prAcPAFANMMM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANMMM,
                ircRegistro.PAFANMMM
            );
 
            prAcPAFACAPM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACAPM,
                ircRegistro.PAFACAPM
            );
 
            prAcPAFAPAGO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAPAGO,
                ircRegistro.PAFAPAGO
            );
 
            prAcPAFAANTI_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAANTI,
                ircRegistro.PAFAANTI
            );
 
            prAcPAFASAFA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFASAFA,
                ircRegistro.PAFASAFA
            );
 
            prAcPAFACOAJ_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACOAJ,
                ircRegistro.PAFACOAJ
            );
 
            prAcPAFAASAF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAASAF,
                ircRegistro.PAFAASAF
            );
 
            prAcPAFADIFE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFADIFE,
                ircRegistro.PAFADIFE
            );
 
            prAcPAFARECA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFARECA,
                ircRegistro.PAFARECA
            );
 
            prAcPAFAFARE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAFARE,
                ircRegistro.PAFAFARE
            );
 
            prAcPAFANUFA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANUFA,
                ircRegistro.PAFANUFA
            ); 
            prAcPAFANUCU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANUCU,
                ircRegistro.PAFANUCU
            );
 
            prAcPAFANUDI_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANUDI,
                ircRegistro.PAFANUDI
            );
 
            prAcPAFANUNC_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANUNC,
                ircRegistro.PAFANUNC
            );
 
            prAcPAFACDAR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACDAR,
                ircRegistro.PAFACDAR
            );
 
            prAcPAFACREF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACREF,
                ircRegistro.PAFACREF
            );
 
            prAcPAFANUCO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFANUCO,
                ircRegistro.PAFANUCO
            );
 
            prAcPAFAFIDE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAFIDE,
                ircRegistro.PAFAFIDE
            );
 
            prAcPAFAPTMP_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAPTMP,
                ircRegistro.PAFAPTMP
            );
 
            prAcPAFAAPLI_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAAPLI,
                ircRegistro.PAFAAPLI
            );
 
            prAcPAFAMCDI_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAMCDI,
                ircRegistro.PAFAMCDI
            );
 
            prAcPAFACRMR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACRMR,
                ircRegistro.PAFACRMR
            );
 
            prAcPAFACOCD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACOCD,
                ircRegistro.PAFACOCD
            );
 
            prAcPAFACRCD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFACRCD,
                ircRegistro.PAFACRCD
            );
 
            prAcPAFAEMPS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PAFAEMPS,
                ircRegistro.PAFAEMPS
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
 
END pkg_parafact;
/
BEGIN
    -- OSF-3846
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_parafact'), UPPER('adm_person'));
END;
/