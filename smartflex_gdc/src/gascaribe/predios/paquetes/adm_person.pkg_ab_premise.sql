CREATE OR REPLACE PACKAGE adm_person.pkg_ab_premise AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF ab_premise%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuab_premise IS SELECT * FROM ab_premise;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : felipe.valencia
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : ab_premise
        Caso  : OSF-3984
        Fecha : 11/02/2025 17:52:46
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuPREMISE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ab_premise tb
        WHERE
        PREMISE_ID = inuPREMISE_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuPREMISE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ab_premise tb
        WHERE
        PREMISE_ID = inuPREMISE_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuPREMISE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuPREMISE_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuPREMISE_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuab_premise%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuPREMISE_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna BLOCK_ID
    FUNCTION fnuObtBLOCK_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCK_ID%TYPE;
 
    -- Obtiene el valor de la columna BLOCK_SIDE
    FUNCTION fsbObtBLOCK_SIDE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCK_SIDE%TYPE;
 
    -- Obtiene el valor de la columna PREMISE
    FUNCTION fnuObtPREMISE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE%TYPE;
 
    -- Obtiene el valor de la columna NUMBER_DIVISION
    FUNCTION fnuObtNUMBER_DIVISION(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.NUMBER_DIVISION%TYPE;
 
    -- Obtiene el valor de la columna PREMISE_TYPE_ID
    FUNCTION fnuObtPREMISE_TYPE_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE_TYPE_ID%TYPE;
 
    -- Obtiene el valor de la columna SEGMENTS_ID
    FUNCTION fnuObtSEGMENTS_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SEGMENTS_ID%TYPE;
 
    -- Obtiene el valor de la columna ZIP_CODE_ID
    FUNCTION fnuObtZIP_CODE_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.ZIP_CODE_ID%TYPE;
 
    -- Obtiene el valor de la columna OWNER
    FUNCTION fsbObtOWNER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.OWNER%TYPE;
 
    -- Obtiene el valor de la columna HOUSE_AMOUNT
    FUNCTION fnuObtHOUSE_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.HOUSE_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna ROOMS_AMOUNT
    FUNCTION fnuObtROOMS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.ROOMS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna FLOORS_AMOUNT
    FUNCTION fnuObtFLOORS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.FLOORS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna OFICCES_AMOUNT
    FUNCTION fnuObtOFICCES_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.OFICCES_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna BLOCKS_AMOUNT
    FUNCTION fnuObtBLOCKS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCKS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna APARTAMENTS_AMOUNT
    FUNCTION fnuObtAPARTAMENTS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.APARTAMENTS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna LOCALS_AMOUNT
    FUNCTION fnuObtLOCALS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.LOCALS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna FLOOR_NUMBER
    FUNCTION fnuObtFLOOR_NUMBER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.FLOOR_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna APARTAMENT_NUMBER
    FUNCTION fsbObtAPARTAMENT_NUMBER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.APARTAMENT_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna SERVANTS_PASSAGE
    FUNCTION fsbObtSERVANTS_PASSAGE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SERVANTS_PASSAGE%TYPE;
 
    -- Obtiene el valor de la columna SETBACK_BUILDING
    FUNCTION fsbObtSETBACK_BUILDING(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SETBACK_BUILDING%TYPE;
 
    -- Obtiene el valor de la columna PREMISE_STATUS_ID
    FUNCTION fnuObtPREMISE_STATUS_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE_STATUS_ID%TYPE;
 
    -- Obtiene el valor de la columna CATEGORY_
    FUNCTION fnuObtCATEGORY_(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.CATEGORY_%TYPE;
 
    -- Obtiene el valor de la columna SUBCATEGORY_
    FUNCTION fnuObtSUBCATEGORY_(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SUBCATEGORY_%TYPE;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.CONSECUTIVE%TYPE;
 
    -- Obtiene el valor de la columna SALEDATE
    FUNCTION fdtObtSALEDATE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SALEDATE%TYPE;
 
    -- Obtiene el valor de la columna COOWNERSHIP_RATIO
    FUNCTION fnuObtCOOWNERSHIP_RATIO(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.COOWNERSHIP_RATIO%TYPE;
 
    -- Actualiza el valor de la columna BLOCK_ID
    PROCEDURE prAcBLOCK_ID(
        inuPREMISE_ID    NUMBER,
        inuBLOCK_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna BLOCK_SIDE
    PROCEDURE prAcBLOCK_SIDE(
        inuPREMISE_ID    NUMBER,
        isbBLOCK_SIDE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PREMISE
    PROCEDURE prAcPREMISE(
        inuPREMISE_ID    NUMBER,
        inuPREMISE    NUMBER
    );
 
    -- Actualiza el valor de la columna NUMBER_DIVISION
    PROCEDURE prAcNUMBER_DIVISION(
        inuPREMISE_ID    NUMBER,
        inuNUMBER_DIVISION    NUMBER
    );
 
    -- Actualiza el valor de la columna PREMISE_TYPE_ID
    PROCEDURE prAcPREMISE_TYPE_ID(
        inuPREMISE_ID    NUMBER,
        inuPREMISE_TYPE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SEGMENTS_ID
    PROCEDURE prAcSEGMENTS_ID(
        inuPREMISE_ID    NUMBER,
        inuSEGMENTS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ZIP_CODE_ID
    PROCEDURE prAcZIP_CODE_ID(
        inuPREMISE_ID    NUMBER,
        inuZIP_CODE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna OWNER
    PROCEDURE prAcOWNER(
        inuPREMISE_ID    NUMBER,
        isbOWNER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna HOUSE_AMOUNT
    PROCEDURE prAcHOUSE_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuHOUSE_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna ROOMS_AMOUNT
    PROCEDURE prAcROOMS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuROOMS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna FLOORS_AMOUNT
    PROCEDURE prAcFLOORS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuFLOORS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna OFICCES_AMOUNT
    PROCEDURE prAcOFICCES_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuOFICCES_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna BLOCKS_AMOUNT
    PROCEDURE prAcBLOCKS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuBLOCKS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna APARTAMENTS_AMOUNT
    PROCEDURE prAcAPARTAMENTS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuAPARTAMENTS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna LOCALS_AMOUNT
    PROCEDURE prAcLOCALS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuLOCALS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna FLOOR_NUMBER
    PROCEDURE prAcFLOOR_NUMBER(
        inuPREMISE_ID    NUMBER,
        inuFLOOR_NUMBER    NUMBER
    );
 
    -- Actualiza el valor de la columna APARTAMENT_NUMBER
    PROCEDURE prAcAPARTAMENT_NUMBER(
        inuPREMISE_ID    NUMBER,
        isbAPARTAMENT_NUMBER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SERVANTS_PASSAGE
    PROCEDURE prAcSERVANTS_PASSAGE(
        inuPREMISE_ID    NUMBER,
        isbSERVANTS_PASSAGE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SETBACK_BUILDING
    PROCEDURE prAcSETBACK_BUILDING(
        inuPREMISE_ID    NUMBER,
        isbSETBACK_BUILDING    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PREMISE_STATUS_ID
    PROCEDURE prAcPREMISE_STATUS_ID(
        inuPREMISE_ID    NUMBER,
        inuPREMISE_STATUS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna CATEGORY_
    PROCEDURE prAcCATEGORY_(
        inuPREMISE_ID    NUMBER,
        inuCATEGORY_    NUMBER
    );
 
    -- Actualiza el valor de la columna SUBCATEGORY_
    PROCEDURE prAcSUBCATEGORY_(
        inuPREMISE_ID    NUMBER,
        inuSUBCATEGORY_    NUMBER
    );
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuPREMISE_ID    NUMBER,
        inuCONSECUTIVE    NUMBER
    );
 
    -- Actualiza el valor de la columna SALEDATE
    PROCEDURE prAcSALEDATE(
        inuPREMISE_ID    NUMBER,
        idtSALEDATE    DATE
    );
 
    -- Actualiza el valor de la columna COOWNERSHIP_RATIO
    PROCEDURE prAcCOOWNERSHIP_RATIO(
        inuPREMISE_ID    NUMBER,
        inuCOOWNERSHIP_RATIO    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuab_premise%ROWTYPE);
 
END pkg_ab_premise;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ab_premise AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuPREMISE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuPREMISE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuPREMISE_ID);
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
        inuPREMISE_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.PREMISE_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuPREMISE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuPREMISE_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuPREMISE_ID||'] en la tabla[ab_premise]');
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
    PROCEDURE prInsRegistro( ircRegistro cuab_premise%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO ab_premise(
            PREMISE_ID,BLOCK_ID,BLOCK_SIDE,PREMISE,NUMBER_DIVISION,PREMISE_TYPE_ID,SEGMENTS_ID,ZIP_CODE_ID,OWNER,HOUSE_AMOUNT,ROOMS_AMOUNT,FLOORS_AMOUNT,OFICCES_AMOUNT,BLOCKS_AMOUNT,APARTAMENTS_AMOUNT,LOCALS_AMOUNT,FLOOR_NUMBER,APARTAMENT_NUMBER,SERVANTS_PASSAGE,SETBACK_BUILDING,PREMISE_STATUS_ID,CATEGORY_,SUBCATEGORY_,CONSECUTIVE,SALEDATE,COOWNERSHIP_RATIO
        )
        VALUES (
            ircRegistro.PREMISE_ID,ircRegistro.BLOCK_ID,ircRegistro.BLOCK_SIDE,ircRegistro.PREMISE,ircRegistro.NUMBER_DIVISION,ircRegistro.PREMISE_TYPE_ID,ircRegistro.SEGMENTS_ID,ircRegistro.ZIP_CODE_ID,ircRegistro.OWNER,ircRegistro.HOUSE_AMOUNT,ircRegistro.ROOMS_AMOUNT,ircRegistro.FLOORS_AMOUNT,ircRegistro.OFICCES_AMOUNT,ircRegistro.BLOCKS_AMOUNT,ircRegistro.APARTAMENTS_AMOUNT,ircRegistro.LOCALS_AMOUNT,ircRegistro.FLOOR_NUMBER,ircRegistro.APARTAMENT_NUMBER,ircRegistro.SERVANTS_PASSAGE,ircRegistro.SETBACK_BUILDING,ircRegistro.PREMISE_STATUS_ID,ircRegistro.CATEGORY_,ircRegistro.SUBCATEGORY_,ircRegistro.CONSECUTIVE,ircRegistro.SALEDATE,ircRegistro.COOWNERSHIP_RATIO
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
        inuPREMISE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE ab_premise
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
            DELETE ab_premise
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
 
    -- Obtiene el valor de la columna BLOCK_ID
    FUNCTION fnuObtBLOCK_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCK_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtBLOCK_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.BLOCK_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtBLOCK_ID;
 
    -- Obtiene el valor de la columna BLOCK_SIDE
    FUNCTION fsbObtBLOCK_SIDE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCK_SIDE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtBLOCK_SIDE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.BLOCK_SIDE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtBLOCK_SIDE;
 
    -- Obtiene el valor de la columna PREMISE
    FUNCTION fnuObtPREMISE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPREMISE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PREMISE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPREMISE;
 
    -- Obtiene el valor de la columna NUMBER_DIVISION
    FUNCTION fnuObtNUMBER_DIVISION(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.NUMBER_DIVISION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNUMBER_DIVISION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NUMBER_DIVISION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtNUMBER_DIVISION;
 
    -- Obtiene el valor de la columna PREMISE_TYPE_ID
    FUNCTION fnuObtPREMISE_TYPE_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPREMISE_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PREMISE_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPREMISE_TYPE_ID;
 
    -- Obtiene el valor de la columna SEGMENTS_ID
    FUNCTION fnuObtSEGMENTS_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SEGMENTS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSEGMENTS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SEGMENTS_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSEGMENTS_ID;
 
    -- Obtiene el valor de la columna ZIP_CODE_ID
    FUNCTION fnuObtZIP_CODE_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.ZIP_CODE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtZIP_CODE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ZIP_CODE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtZIP_CODE_ID;
 
    -- Obtiene el valor de la columna OWNER
    FUNCTION fsbObtOWNER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.OWNER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOWNER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OWNER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtOWNER;
 
    -- Obtiene el valor de la columna HOUSE_AMOUNT
    FUNCTION fnuObtHOUSE_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.HOUSE_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtHOUSE_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.HOUSE_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtHOUSE_AMOUNT;
 
    -- Obtiene el valor de la columna ROOMS_AMOUNT
    FUNCTION fnuObtROOMS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.ROOMS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtROOMS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ROOMS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtROOMS_AMOUNT;
 
    -- Obtiene el valor de la columna FLOORS_AMOUNT
    FUNCTION fnuObtFLOORS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.FLOORS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFLOORS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FLOORS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtFLOORS_AMOUNT;
 
    -- Obtiene el valor de la columna OFICCES_AMOUNT
    FUNCTION fnuObtOFICCES_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.OFICCES_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOFICCES_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OFICCES_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOFICCES_AMOUNT;
 
    -- Obtiene el valor de la columna BLOCKS_AMOUNT
    FUNCTION fnuObtBLOCKS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.BLOCKS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtBLOCKS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.BLOCKS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtBLOCKS_AMOUNT;
 
    -- Obtiene el valor de la columna APARTAMENTS_AMOUNT
    FUNCTION fnuObtAPARTAMENTS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.APARTAMENTS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtAPARTAMENTS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.APARTAMENTS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtAPARTAMENTS_AMOUNT;
 
    -- Obtiene el valor de la columna LOCALS_AMOUNT
    FUNCTION fnuObtLOCALS_AMOUNT(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.LOCALS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtLOCALS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LOCALS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtLOCALS_AMOUNT;
 
    -- Obtiene el valor de la columna FLOOR_NUMBER
    FUNCTION fnuObtFLOOR_NUMBER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.FLOOR_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFLOOR_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FLOOR_NUMBER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtFLOOR_NUMBER;
 
    -- Obtiene el valor de la columna APARTAMENT_NUMBER
    FUNCTION fsbObtAPARTAMENT_NUMBER(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.APARTAMENT_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtAPARTAMENT_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.APARTAMENT_NUMBER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtAPARTAMENT_NUMBER;
 
    -- Obtiene el valor de la columna SERVANTS_PASSAGE
    FUNCTION fsbObtSERVANTS_PASSAGE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SERVANTS_PASSAGE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSERVANTS_PASSAGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SERVANTS_PASSAGE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSERVANTS_PASSAGE;
 
    -- Obtiene el valor de la columna SETBACK_BUILDING
    FUNCTION fsbObtSETBACK_BUILDING(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SETBACK_BUILDING%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSETBACK_BUILDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SETBACK_BUILDING;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSETBACK_BUILDING;
 
    -- Obtiene el valor de la columna PREMISE_STATUS_ID
    FUNCTION fnuObtPREMISE_STATUS_ID(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.PREMISE_STATUS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPREMISE_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PREMISE_STATUS_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPREMISE_STATUS_ID;
 
    -- Obtiene el valor de la columna CATEGORY_
    FUNCTION fnuObtCATEGORY_(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.CATEGORY_%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCATEGORY_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CATEGORY_;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCATEGORY_;
 
    -- Obtiene el valor de la columna SUBCATEGORY_
    FUNCTION fnuObtSUBCATEGORY_(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SUBCATEGORY_%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSUBCATEGORY_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SUBCATEGORY_;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSUBCATEGORY_;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.CONSECUTIVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONSECUTIVE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCONSECUTIVE;
 
    -- Obtiene el valor de la columna SALEDATE
    FUNCTION fdtObtSALEDATE(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.SALEDATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtSALEDATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SALEDATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtSALEDATE;
 
    -- Obtiene el valor de la columna COOWNERSHIP_RATIO
    FUNCTION fnuObtCOOWNERSHIP_RATIO(
        inuPREMISE_ID    NUMBER
        ) RETURN ab_premise.COOWNERSHIP_RATIO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOOWNERSHIP_RATIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COOWNERSHIP_RATIO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCOOWNERSHIP_RATIO;
 
    -- Actualiza el valor de la columna BLOCK_ID
    PROCEDURE prAcBLOCK_ID(
        inuPREMISE_ID    NUMBER,
        inuBLOCK_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCK_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuBLOCK_ID,-1) <> NVL(rcRegistroAct.BLOCK_ID,-1) THEN
            UPDATE ab_premise
            SET BLOCK_ID=inuBLOCK_ID
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
    END prAcBLOCK_ID;
 
    -- Actualiza el valor de la columna BLOCK_SIDE
    PROCEDURE prAcBLOCK_SIDE(
        inuPREMISE_ID    NUMBER,
        isbBLOCK_SIDE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCK_SIDE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(isbBLOCK_SIDE,'-') <> NVL(rcRegistroAct.BLOCK_SIDE,'-') THEN
            UPDATE ab_premise
            SET BLOCK_SIDE=isbBLOCK_SIDE
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
    END prAcBLOCK_SIDE;
 
    -- Actualiza el valor de la columna PREMISE
    PROCEDURE prAcPREMISE(
        inuPREMISE_ID    NUMBER,
        inuPREMISE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuPREMISE,-1) <> NVL(rcRegistroAct.PREMISE,-1) THEN
            UPDATE ab_premise
            SET PREMISE=inuPREMISE
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
    END prAcPREMISE;
 
    -- Actualiza el valor de la columna NUMBER_DIVISION
    PROCEDURE prAcNUMBER_DIVISION(
        inuPREMISE_ID    NUMBER,
        inuNUMBER_DIVISION    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMBER_DIVISION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuNUMBER_DIVISION,-1) <> NVL(rcRegistroAct.NUMBER_DIVISION,-1) THEN
            UPDATE ab_premise
            SET NUMBER_DIVISION=inuNUMBER_DIVISION
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
    END prAcNUMBER_DIVISION;
 
    -- Actualiza el valor de la columna PREMISE_TYPE_ID
    PROCEDURE prAcPREMISE_TYPE_ID(
        inuPREMISE_ID    NUMBER,
        inuPREMISE_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuPREMISE_TYPE_ID,-1) <> NVL(rcRegistroAct.PREMISE_TYPE_ID,-1) THEN
            UPDATE ab_premise
            SET PREMISE_TYPE_ID=inuPREMISE_TYPE_ID
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
    END prAcPREMISE_TYPE_ID;
 
    -- Actualiza el valor de la columna SEGMENTS_ID
    PROCEDURE prAcSEGMENTS_ID(
        inuPREMISE_ID    NUMBER,
        inuSEGMENTS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEGMENTS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuSEGMENTS_ID,-1) <> NVL(rcRegistroAct.SEGMENTS_ID,-1) THEN
            UPDATE ab_premise
            SET SEGMENTS_ID=inuSEGMENTS_ID
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
    END prAcSEGMENTS_ID;
 
    -- Actualiza el valor de la columna ZIP_CODE_ID
    PROCEDURE prAcZIP_CODE_ID(
        inuPREMISE_ID    NUMBER,
        inuZIP_CODE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcZIP_CODE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuZIP_CODE_ID,-1) <> NVL(rcRegistroAct.ZIP_CODE_ID,-1) THEN
            UPDATE ab_premise
            SET ZIP_CODE_ID=inuZIP_CODE_ID
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
    END prAcZIP_CODE_ID;
 
    -- Actualiza el valor de la columna OWNER
    PROCEDURE prAcOWNER(
        inuPREMISE_ID    NUMBER,
        isbOWNER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOWNER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(isbOWNER,'-') <> NVL(rcRegistroAct.OWNER,'-') THEN
            UPDATE ab_premise
            SET OWNER=isbOWNER
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
    END prAcOWNER;
 
    -- Actualiza el valor de la columna HOUSE_AMOUNT
    PROCEDURE prAcHOUSE_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuHOUSE_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcHOUSE_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuHOUSE_AMOUNT,-1) <> NVL(rcRegistroAct.HOUSE_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET HOUSE_AMOUNT=inuHOUSE_AMOUNT
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
    END prAcHOUSE_AMOUNT;
 
    -- Actualiza el valor de la columna ROOMS_AMOUNT
    PROCEDURE prAcROOMS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuROOMS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcROOMS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuROOMS_AMOUNT,-1) <> NVL(rcRegistroAct.ROOMS_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET ROOMS_AMOUNT=inuROOMS_AMOUNT
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
    END prAcROOMS_AMOUNT;
 
    -- Actualiza el valor de la columna FLOORS_AMOUNT
    PROCEDURE prAcFLOORS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuFLOORS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFLOORS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuFLOORS_AMOUNT,-1) <> NVL(rcRegistroAct.FLOORS_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET FLOORS_AMOUNT=inuFLOORS_AMOUNT
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
    END prAcFLOORS_AMOUNT;
 
    -- Actualiza el valor de la columna OFICCES_AMOUNT
    PROCEDURE prAcOFICCES_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuOFICCES_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOFICCES_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuOFICCES_AMOUNT,-1) <> NVL(rcRegistroAct.OFICCES_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET OFICCES_AMOUNT=inuOFICCES_AMOUNT
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
    END prAcOFICCES_AMOUNT;
 
    -- Actualiza el valor de la columna BLOCKS_AMOUNT
    PROCEDURE prAcBLOCKS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuBLOCKS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCKS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuBLOCKS_AMOUNT,-1) <> NVL(rcRegistroAct.BLOCKS_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET BLOCKS_AMOUNT=inuBLOCKS_AMOUNT
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
    END prAcBLOCKS_AMOUNT;
 
    -- Actualiza el valor de la columna APARTAMENTS_AMOUNT
    PROCEDURE prAcAPARTAMENTS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuAPARTAMENTS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPARTAMENTS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuAPARTAMENTS_AMOUNT,-1) <> NVL(rcRegistroAct.APARTAMENTS_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET APARTAMENTS_AMOUNT=inuAPARTAMENTS_AMOUNT
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
    END prAcAPARTAMENTS_AMOUNT;
 
    -- Actualiza el valor de la columna LOCALS_AMOUNT
    PROCEDURE prAcLOCALS_AMOUNT(
        inuPREMISE_ID    NUMBER,
        inuLOCALS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLOCALS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuLOCALS_AMOUNT,-1) <> NVL(rcRegistroAct.LOCALS_AMOUNT,-1) THEN
            UPDATE ab_premise
            SET LOCALS_AMOUNT=inuLOCALS_AMOUNT
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
    END prAcLOCALS_AMOUNT;
 
    -- Actualiza el valor de la columna FLOOR_NUMBER
    PROCEDURE prAcFLOOR_NUMBER(
        inuPREMISE_ID    NUMBER,
        inuFLOOR_NUMBER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFLOOR_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuFLOOR_NUMBER,-1) <> NVL(rcRegistroAct.FLOOR_NUMBER,-1) THEN
            UPDATE ab_premise
            SET FLOOR_NUMBER=inuFLOOR_NUMBER
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
    END prAcFLOOR_NUMBER;
 
    -- Actualiza el valor de la columna APARTAMENT_NUMBER
    PROCEDURE prAcAPARTAMENT_NUMBER(
        inuPREMISE_ID    NUMBER,
        isbAPARTAMENT_NUMBER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPARTAMENT_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(isbAPARTAMENT_NUMBER,'-') <> NVL(rcRegistroAct.APARTAMENT_NUMBER,'-') THEN
            UPDATE ab_premise
            SET APARTAMENT_NUMBER=isbAPARTAMENT_NUMBER
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
    END prAcAPARTAMENT_NUMBER;
 
    -- Actualiza el valor de la columna SERVANTS_PASSAGE
    PROCEDURE prAcSERVANTS_PASSAGE(
        inuPREMISE_ID    NUMBER,
        isbSERVANTS_PASSAGE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSERVANTS_PASSAGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(isbSERVANTS_PASSAGE,'-') <> NVL(rcRegistroAct.SERVANTS_PASSAGE,'-') THEN
            UPDATE ab_premise
            SET SERVANTS_PASSAGE=isbSERVANTS_PASSAGE
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
    END prAcSERVANTS_PASSAGE;
 
    -- Actualiza el valor de la columna SETBACK_BUILDING
    PROCEDURE prAcSETBACK_BUILDING(
        inuPREMISE_ID    NUMBER,
        isbSETBACK_BUILDING    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSETBACK_BUILDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(isbSETBACK_BUILDING,'-') <> NVL(rcRegistroAct.SETBACK_BUILDING,'-') THEN
            UPDATE ab_premise
            SET SETBACK_BUILDING=isbSETBACK_BUILDING
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
    END prAcSETBACK_BUILDING;
 
    -- Actualiza el valor de la columna PREMISE_STATUS_ID
    PROCEDURE prAcPREMISE_STATUS_ID(
        inuPREMISE_ID    NUMBER,
        inuPREMISE_STATUS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuPREMISE_STATUS_ID,-1) <> NVL(rcRegistroAct.PREMISE_STATUS_ID,-1) THEN
            UPDATE ab_premise
            SET PREMISE_STATUS_ID=inuPREMISE_STATUS_ID
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
    END prAcPREMISE_STATUS_ID;
 
    -- Actualiza el valor de la columna CATEGORY_
    PROCEDURE prAcCATEGORY_(
        inuPREMISE_ID    NUMBER,
        inuCATEGORY_    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCATEGORY_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuCATEGORY_,-1) <> NVL(rcRegistroAct.CATEGORY_,-1) THEN
            UPDATE ab_premise
            SET CATEGORY_=inuCATEGORY_
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
    END prAcCATEGORY_;
 
    -- Actualiza el valor de la columna SUBCATEGORY_
    PROCEDURE prAcSUBCATEGORY_(
        inuPREMISE_ID    NUMBER,
        inuSUBCATEGORY_    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBCATEGORY_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuSUBCATEGORY_,-1) <> NVL(rcRegistroAct.SUBCATEGORY_,-1) THEN
            UPDATE ab_premise
            SET SUBCATEGORY_=inuSUBCATEGORY_
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
    END prAcSUBCATEGORY_;
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuPREMISE_ID    NUMBER,
        inuCONSECUTIVE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuCONSECUTIVE,-1) <> NVL(rcRegistroAct.CONSECUTIVE,-1) THEN
            UPDATE ab_premise
            SET CONSECUTIVE=inuCONSECUTIVE
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
    END prAcCONSECUTIVE;
 
    -- Actualiza el valor de la columna SALEDATE
    PROCEDURE prAcSALEDATE(
        inuPREMISE_ID    NUMBER,
        idtSALEDATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSALEDATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(idtSALEDATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.SALEDATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE ab_premise
            SET SALEDATE=idtSALEDATE
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
    END prAcSALEDATE;
 
    -- Actualiza el valor de la columna COOWNERSHIP_RATIO
    PROCEDURE prAcCOOWNERSHIP_RATIO(
        inuPREMISE_ID    NUMBER,
        inuCOOWNERSHIP_RATIO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOOWNERSHIP_RATIO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPREMISE_ID,TRUE);
        IF NVL(inuCOOWNERSHIP_RATIO,-1) <> NVL(rcRegistroAct.COOWNERSHIP_RATIO,-1) THEN
            UPDATE ab_premise
            SET COOWNERSHIP_RATIO=inuCOOWNERSHIP_RATIO
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
    END prAcCOOWNERSHIP_RATIO;
 
    -- Actualiza por RowId el valor de la columna BLOCK_ID
    PROCEDURE prAcBLOCK_ID_RId(
        iRowId ROWID,
        inuBLOCK_ID_O    NUMBER,
        inuBLOCK_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCK_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuBLOCK_ID_O,-1) <> NVL(inuBLOCK_ID_N,-1) THEN
            UPDATE ab_premise
            SET BLOCK_ID=inuBLOCK_ID_N
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
    END prAcBLOCK_ID_RId;
 
    -- Actualiza por RowId el valor de la columna BLOCK_SIDE
    PROCEDURE prAcBLOCK_SIDE_RId(
        iRowId ROWID,
        isbBLOCK_SIDE_O    VARCHAR2,
        isbBLOCK_SIDE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCK_SIDE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbBLOCK_SIDE_O,'-') <> NVL(isbBLOCK_SIDE_N,'-') THEN
            UPDATE ab_premise
            SET BLOCK_SIDE=isbBLOCK_SIDE_N
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
    END prAcBLOCK_SIDE_RId;
 
    -- Actualiza por RowId el valor de la columna PREMISE
    PROCEDURE prAcPREMISE_RId(
        iRowId ROWID,
        inuPREMISE_O    NUMBER,
        inuPREMISE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPREMISE_O,-1) <> NVL(inuPREMISE_N,-1) THEN
            UPDATE ab_premise
            SET PREMISE=inuPREMISE_N
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
    END prAcPREMISE_RId;
 
    -- Actualiza por RowId el valor de la columna NUMBER_DIVISION
    PROCEDURE prAcNUMBER_DIVISION_RId(
        iRowId ROWID,
        inuNUMBER_DIVISION_O    NUMBER,
        inuNUMBER_DIVISION_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMBER_DIVISION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNUMBER_DIVISION_O,-1) <> NVL(inuNUMBER_DIVISION_N,-1) THEN
            UPDATE ab_premise
            SET NUMBER_DIVISION=inuNUMBER_DIVISION_N
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
    END prAcNUMBER_DIVISION_RId;
 
    -- Actualiza por RowId el valor de la columna PREMISE_TYPE_ID
    PROCEDURE prAcPREMISE_TYPE_ID_RId(
        iRowId ROWID,
        inuPREMISE_TYPE_ID_O    NUMBER,
        inuPREMISE_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPREMISE_TYPE_ID_O,-1) <> NVL(inuPREMISE_TYPE_ID_N,-1) THEN
            UPDATE ab_premise
            SET PREMISE_TYPE_ID=inuPREMISE_TYPE_ID_N
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
    END prAcPREMISE_TYPE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna SEGMENTS_ID
    PROCEDURE prAcSEGMENTS_ID_RId(
        iRowId ROWID,
        inuSEGMENTS_ID_O    NUMBER,
        inuSEGMENTS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEGMENTS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSEGMENTS_ID_O,-1) <> NVL(inuSEGMENTS_ID_N,-1) THEN
            UPDATE ab_premise
            SET SEGMENTS_ID=inuSEGMENTS_ID_N
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
    END prAcSEGMENTS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ZIP_CODE_ID
    PROCEDURE prAcZIP_CODE_ID_RId(
        iRowId ROWID,
        inuZIP_CODE_ID_O    NUMBER,
        inuZIP_CODE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcZIP_CODE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuZIP_CODE_ID_O,-1) <> NVL(inuZIP_CODE_ID_N,-1) THEN
            UPDATE ab_premise
            SET ZIP_CODE_ID=inuZIP_CODE_ID_N
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
    END prAcZIP_CODE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna OWNER
    PROCEDURE prAcOWNER_RId(
        iRowId ROWID,
        isbOWNER_O    VARCHAR2,
        isbOWNER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOWNER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOWNER_O,'-') <> NVL(isbOWNER_N,'-') THEN
            UPDATE ab_premise
            SET OWNER=isbOWNER_N
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
    END prAcOWNER_RId;
 
    -- Actualiza por RowId el valor de la columna HOUSE_AMOUNT
    PROCEDURE prAcHOUSE_AMOUNT_RId(
        iRowId ROWID,
        inuHOUSE_AMOUNT_O    NUMBER,
        inuHOUSE_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcHOUSE_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuHOUSE_AMOUNT_O,-1) <> NVL(inuHOUSE_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET HOUSE_AMOUNT=inuHOUSE_AMOUNT_N
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
    END prAcHOUSE_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna ROOMS_AMOUNT
    PROCEDURE prAcROOMS_AMOUNT_RId(
        iRowId ROWID,
        inuROOMS_AMOUNT_O    NUMBER,
        inuROOMS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcROOMS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuROOMS_AMOUNT_O,-1) <> NVL(inuROOMS_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET ROOMS_AMOUNT=inuROOMS_AMOUNT_N
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
    END prAcROOMS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna FLOORS_AMOUNT
    PROCEDURE prAcFLOORS_AMOUNT_RId(
        iRowId ROWID,
        inuFLOORS_AMOUNT_O    NUMBER,
        inuFLOORS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFLOORS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuFLOORS_AMOUNT_O,-1) <> NVL(inuFLOORS_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET FLOORS_AMOUNT=inuFLOORS_AMOUNT_N
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
    END prAcFLOORS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna OFICCES_AMOUNT
    PROCEDURE prAcOFICCES_AMOUNT_RId(
        iRowId ROWID,
        inuOFICCES_AMOUNT_O    NUMBER,
        inuOFICCES_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOFICCES_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOFICCES_AMOUNT_O,-1) <> NVL(inuOFICCES_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET OFICCES_AMOUNT=inuOFICCES_AMOUNT_N
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
    END prAcOFICCES_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna BLOCKS_AMOUNT
    PROCEDURE prAcBLOCKS_AMOUNT_RId(
        iRowId ROWID,
        inuBLOCKS_AMOUNT_O    NUMBER,
        inuBLOCKS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBLOCKS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuBLOCKS_AMOUNT_O,-1) <> NVL(inuBLOCKS_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET BLOCKS_AMOUNT=inuBLOCKS_AMOUNT_N
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
    END prAcBLOCKS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna APARTAMENTS_AMOUNT
    PROCEDURE prAcAPARTAMENTS_AMOUNT_RId(
        iRowId ROWID,
        inuAPARTAMENTS_AMOUNT_O    NUMBER,
        inuAPARTAMENTS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPARTAMENTS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuAPARTAMENTS_AMOUNT_O,-1) <> NVL(inuAPARTAMENTS_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET APARTAMENTS_AMOUNT=inuAPARTAMENTS_AMOUNT_N
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
    END prAcAPARTAMENTS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna LOCALS_AMOUNT
    PROCEDURE prAcLOCALS_AMOUNT_RId(
        iRowId ROWID,
        inuLOCALS_AMOUNT_O    NUMBER,
        inuLOCALS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLOCALS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuLOCALS_AMOUNT_O,-1) <> NVL(inuLOCALS_AMOUNT_N,-1) THEN
            UPDATE ab_premise
            SET LOCALS_AMOUNT=inuLOCALS_AMOUNT_N
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
    END prAcLOCALS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna FLOOR_NUMBER
    PROCEDURE prAcFLOOR_NUMBER_RId(
        iRowId ROWID,
        inuFLOOR_NUMBER_O    NUMBER,
        inuFLOOR_NUMBER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFLOOR_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuFLOOR_NUMBER_O,-1) <> NVL(inuFLOOR_NUMBER_N,-1) THEN
            UPDATE ab_premise
            SET FLOOR_NUMBER=inuFLOOR_NUMBER_N
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
    END prAcFLOOR_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna APARTAMENT_NUMBER
    PROCEDURE prAcAPARTAMENT_NUMBER_RId(
        iRowId ROWID,
        isbAPARTAMENT_NUMBER_O    VARCHAR2,
        isbAPARTAMENT_NUMBER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPARTAMENT_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbAPARTAMENT_NUMBER_O,'-') <> NVL(isbAPARTAMENT_NUMBER_N,'-') THEN
            UPDATE ab_premise
            SET APARTAMENT_NUMBER=isbAPARTAMENT_NUMBER_N
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
    END prAcAPARTAMENT_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna SERVANTS_PASSAGE
    PROCEDURE prAcSERVANTS_PASSAGE_RId(
        iRowId ROWID,
        isbSERVANTS_PASSAGE_O    VARCHAR2,
        isbSERVANTS_PASSAGE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSERVANTS_PASSAGE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSERVANTS_PASSAGE_O,'-') <> NVL(isbSERVANTS_PASSAGE_N,'-') THEN
            UPDATE ab_premise
            SET SERVANTS_PASSAGE=isbSERVANTS_PASSAGE_N
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
    END prAcSERVANTS_PASSAGE_RId;
 
    -- Actualiza por RowId el valor de la columna SETBACK_BUILDING
    PROCEDURE prAcSETBACK_BUILDING_RId(
        iRowId ROWID,
        isbSETBACK_BUILDING_O    VARCHAR2,
        isbSETBACK_BUILDING_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSETBACK_BUILDING_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSETBACK_BUILDING_O,'-') <> NVL(isbSETBACK_BUILDING_N,'-') THEN
            UPDATE ab_premise
            SET SETBACK_BUILDING=isbSETBACK_BUILDING_N
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
    END prAcSETBACK_BUILDING_RId;
 
    -- Actualiza por RowId el valor de la columna PREMISE_STATUS_ID
    PROCEDURE prAcPREMISE_STATUS_ID_RId(
        iRowId ROWID,
        inuPREMISE_STATUS_ID_O    NUMBER,
        inuPREMISE_STATUS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREMISE_STATUS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPREMISE_STATUS_ID_O,-1) <> NVL(inuPREMISE_STATUS_ID_N,-1) THEN
            UPDATE ab_premise
            SET PREMISE_STATUS_ID=inuPREMISE_STATUS_ID_N
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
    END prAcPREMISE_STATUS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna CATEGORY_
    PROCEDURE prAcCATEGORY__RId(
        iRowId ROWID,
        inuCATEGORY__O    NUMBER,
        inuCATEGORY__N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCATEGORY__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCATEGORY__O,-1) <> NVL(inuCATEGORY__N,-1) THEN
            UPDATE ab_premise
            SET CATEGORY_=inuCATEGORY__N
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
    END prAcCATEGORY__RId;
 
    -- Actualiza por RowId el valor de la columna SUBCATEGORY_
    PROCEDURE prAcSUBCATEGORY__RId(
        iRowId ROWID,
        inuSUBCATEGORY__O    NUMBER,
        inuSUBCATEGORY__N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBCATEGORY__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSUBCATEGORY__O,-1) <> NVL(inuSUBCATEGORY__N,-1) THEN
            UPDATE ab_premise
            SET SUBCATEGORY_=inuSUBCATEGORY__N
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
    END prAcSUBCATEGORY__RId;
 
    -- Actualiza por RowId el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE_RId(
        iRowId ROWID,
        inuCONSECUTIVE_O    NUMBER,
        inuCONSECUTIVE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONSECUTIVE_O,-1) <> NVL(inuCONSECUTIVE_N,-1) THEN
            UPDATE ab_premise
            SET CONSECUTIVE=inuCONSECUTIVE_N
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
    END prAcCONSECUTIVE_RId;
 
    -- Actualiza por RowId el valor de la columna SALEDATE
    PROCEDURE prAcSALEDATE_RId(
        iRowId ROWID,
        idtSALEDATE_O    DATE,
        idtSALEDATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSALEDATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtSALEDATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtSALEDATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE ab_premise
            SET SALEDATE=idtSALEDATE_N
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
    END prAcSALEDATE_RId;
 
    -- Actualiza por RowId el valor de la columna COOWNERSHIP_RATIO
    PROCEDURE prAcCOOWNERSHIP_RATIO_RId(
        iRowId ROWID,
        inuCOOWNERSHIP_RATIO_O    NUMBER,
        inuCOOWNERSHIP_RATIO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOOWNERSHIP_RATIO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOOWNERSHIP_RATIO_O,-1) <> NVL(inuCOOWNERSHIP_RATIO_N,-1) THEN
            UPDATE ab_premise
            SET COOWNERSHIP_RATIO=inuCOOWNERSHIP_RATIO_N
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
    END prAcCOOWNERSHIP_RATIO_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuab_premise%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.PREMISE_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcBLOCK_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.BLOCK_ID,
                ircRegistro.BLOCK_ID
            );
 
            prAcBLOCK_SIDE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.BLOCK_SIDE,
                ircRegistro.BLOCK_SIDE
            );
 
            prAcPREMISE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PREMISE,
                ircRegistro.PREMISE
            );
 
            prAcNUMBER_DIVISION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NUMBER_DIVISION,
                ircRegistro.NUMBER_DIVISION
            );
 
            prAcPREMISE_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PREMISE_TYPE_ID,
                ircRegistro.PREMISE_TYPE_ID
            );
 
            prAcSEGMENTS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SEGMENTS_ID,
                ircRegistro.SEGMENTS_ID
            );
 
            prAcZIP_CODE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ZIP_CODE_ID,
                ircRegistro.ZIP_CODE_ID
            );
 
            prAcOWNER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OWNER,
                ircRegistro.OWNER
            );
 
            prAcHOUSE_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.HOUSE_AMOUNT,
                ircRegistro.HOUSE_AMOUNT
            );
 
            prAcROOMS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ROOMS_AMOUNT,
                ircRegistro.ROOMS_AMOUNT
            );
 
            prAcFLOORS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FLOORS_AMOUNT,
                ircRegistro.FLOORS_AMOUNT
            );
 
            prAcOFICCES_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OFICCES_AMOUNT,
                ircRegistro.OFICCES_AMOUNT
            );
 
            prAcBLOCKS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.BLOCKS_AMOUNT,
                ircRegistro.BLOCKS_AMOUNT
            );
 
            prAcAPARTAMENTS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.APARTAMENTS_AMOUNT,
                ircRegistro.APARTAMENTS_AMOUNT
            );
 
            prAcLOCALS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LOCALS_AMOUNT,
                ircRegistro.LOCALS_AMOUNT
            );
 
            prAcFLOOR_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FLOOR_NUMBER,
                ircRegistro.FLOOR_NUMBER
            );
 
            prAcAPARTAMENT_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.APARTAMENT_NUMBER,
                ircRegistro.APARTAMENT_NUMBER
            );
 
            prAcSERVANTS_PASSAGE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SERVANTS_PASSAGE,
                ircRegistro.SERVANTS_PASSAGE
            );
 
            prAcSETBACK_BUILDING_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SETBACK_BUILDING,
                ircRegistro.SETBACK_BUILDING
            );
 
            prAcPREMISE_STATUS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PREMISE_STATUS_ID,
                ircRegistro.PREMISE_STATUS_ID
            );
 
            prAcCATEGORY__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CATEGORY_,
                ircRegistro.CATEGORY_
            );
 
            prAcSUBCATEGORY__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBCATEGORY_,
                ircRegistro.SUBCATEGORY_
            );
 
            prAcCONSECUTIVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONSECUTIVE,
                ircRegistro.CONSECUTIVE
            );
 
            prAcSALEDATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SALEDATE,
                ircRegistro.SALEDATE
            );
 
            prAcCOOWNERSHIP_RATIO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COOWNERSHIP_RATIO,
                ircRegistro.COOWNERSHIP_RATIO
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
 
END pkg_ab_premise;
/
BEGIN
    -- OSF-3984
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ab_premise'), UPPER('adm_person'));
END;
/
