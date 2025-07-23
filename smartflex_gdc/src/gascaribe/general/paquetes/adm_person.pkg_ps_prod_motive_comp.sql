CREATE OR REPLACE PACKAGE adm_person.pkg_ps_prod_motive_comp AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF ps_prod_motive_comp%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cups_prod_motive_comp IS SELECT * FROM ps_prod_motive_comp;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : pkg_ps_prod_motive_comp
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : ps_prod_motive_comp
        Caso  : felipe.valencia
        Fecha : 12/12/2024 16:55:24
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuPROD_MOTIVE_COMP_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ps_prod_motive_comp tb
        WHERE
        PROD_MOTIVE_COMP_ID = inuPROD_MOTIVE_COMP_ID;


    SUBTYPE styps_prod_motive_comp IS cuRegistroRId%ROWTYPE;

    TYPE tytbps_prod_motive_comp IS TABLE OF styps_prod_motive_comp INDEX BY BINARY_INTEGER;
    TYPE tyrfps_prod_motive_comp IS ref CURSOR;
     
    CURSOR cuRegistroRIdLock
    (
        inuPROD_MOTIVE_COMP_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ps_prod_motive_comp tb
        WHERE
        PROD_MOTIVE_COMP_ID = inuPROD_MOTIVE_COMP_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuPROD_MOTIVE_COMP_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuPROD_MOTIVE_COMP_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuPROD_MOTIVE_COMP_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cups_prod_motive_comp%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuPROD_MOTIVE_COMP_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PRODUCT_MOTIVE_ID
    FUNCTION fnuObtPRODUCT_MOTIVE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PRODUCT_MOTIVE_ID%TYPE;
 
    -- Obtiene el valor de la columna PARENT_COMP
    FUNCTION fnuObtPARENT_COMP(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PARENT_COMP%TYPE;
 
    -- Obtiene el valor de la columna COMPONENT_TYPE_ID
    FUNCTION fnuObtCOMPONENT_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.COMPONENT_TYPE_ID%TYPE;
 
    -- Obtiene el valor de la columna MOTIVE_TYPE_ID
    FUNCTION fnuObtMOTIVE_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MOTIVE_TYPE_ID%TYPE;
 
    -- Obtiene el valor de la columna TAG_NAME
    FUNCTION fsbObtTAG_NAME(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.TAG_NAME%TYPE;
 
    -- Obtiene el valor de la columna ASSIGN_ORDER
    FUNCTION fnuObtASSIGN_ORDER(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ASSIGN_ORDER%TYPE;
 
    -- Obtiene el valor de la columna MIN_COMPONENTS
    FUNCTION fnuObtMIN_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MIN_COMPONENTS%TYPE;
 
    -- Obtiene el valor de la columna MAX_COMPONENTS
    FUNCTION fnuObtMAX_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MAX_COMPONENTS%TYPE;
 
    -- Obtiene el valor de la columna IS_OPTIONAL
    FUNCTION fsbObtIS_OPTIONAL(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.IS_OPTIONAL%TYPE;
 
    -- Obtiene el valor de la columna DESCRIPTION
    FUNCTION fsbObtDESCRIPTION(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DESCRIPTION%TYPE;
 
    -- Obtiene el valor de la columna PROCESS_SEQUENCE
    FUNCTION fnuObtPROCESS_SEQUENCE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PROCESS_SEQUENCE%TYPE;
 
    -- Obtiene el valor de la columna CONTAIN_MAIN_NUMBER
    FUNCTION fsbObtCONTAIN_MAIN_NUMBER(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.CONTAIN_MAIN_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna LOAD_COMPONENT_INFO
    FUNCTION fsbObtLOAD_COMPONENT_INFO(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.LOAD_COMPONENT_INFO%TYPE;
 
    -- Obtiene el valor de la columna COPY_NETWORK_ASSO
    FUNCTION fsbObtCOPY_NETWORK_ASSO(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.COPY_NETWORK_ASSO%TYPE;
 
    -- Obtiene el valor de la columna ELEMENT_CATEGORY_ID
    FUNCTION fnuObtELEMENT_CATEGORY_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ELEMENT_CATEGORY_ID%TYPE;
 
    -- Obtiene el valor de la columna ATTEND_WITH_PARENT
    FUNCTION fsbObtATTEND_WITH_PARENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ATTEND_WITH_PARENT%TYPE;
 
    -- Obtiene el valor de la columna PROCESS_WITH_XML
    FUNCTION fsbObtPROCESS_WITH_XML(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PROCESS_WITH_XML%TYPE;
 
    -- Obtiene el valor de la columna ACTIVE
    FUNCTION fsbObtACTIVE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ACTIVE%TYPE;
 
    -- Obtiene el valor de la columna IS_NULLABLE
    FUNCTION fsbObtIS_NULLABLE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.IS_NULLABLE%TYPE;
 
    -- Obtiene el valor de la columna SERVICE_COMPONENT
    FUNCTION fnuObtSERVICE_COMPONENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.SERVICE_COMPONENT%TYPE;
 
    -- Obtiene el valor de la columna FACTI_TECNICA
    FUNCTION fsbObtFACTI_TECNICA(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.FACTI_TECNICA%TYPE;
 
    -- Obtiene el valor de la columna DISPLAY_CLASS_SERVICE
    FUNCTION fsbObtDISPLAY_CLASS_SERVICE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DISPLAY_CLASS_SERVICE%TYPE;
 
    -- Obtiene el valor de la columna DISPLAY_CONTROL
    FUNCTION fsbObtDISPLAY_CONTROL(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DISPLAY_CONTROL%TYPE;
 
    -- Obtiene el valor de la columna REQUIRES_CHILDREN
    FUNCTION fsbObtREQUIRES_CHILDREN(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.REQUIRES_CHILDREN%TYPE;
 
    -- Actualiza el valor de la columna PRODUCT_MOTIVE_ID
    PROCEDURE prAcPRODUCT_MOTIVE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPRODUCT_MOTIVE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PARENT_COMP
    PROCEDURE prAcPARENT_COMP(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPARENT_COMP    NUMBER
    );
 
    -- Actualiza el valor de la columna COMPONENT_TYPE_ID
    PROCEDURE prAcCOMPONENT_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuCOMPONENT_TYPE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna MOTIVE_TYPE_ID
    PROCEDURE prAcMOTIVE_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMOTIVE_TYPE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna TAG_NAME
    PROCEDURE prAcTAG_NAME(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbTAG_NAME    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ASSIGN_ORDER
    PROCEDURE prAcASSIGN_ORDER(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuASSIGN_ORDER    NUMBER
    );
 
    -- Actualiza el valor de la columna MIN_COMPONENTS
    PROCEDURE prAcMIN_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMIN_COMPONENTS    NUMBER
    );
 
    -- Actualiza el valor de la columna MAX_COMPONENTS
    PROCEDURE prAcMAX_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMAX_COMPONENTS    NUMBER
    );
 
    -- Actualiza el valor de la columna IS_OPTIONAL
    PROCEDURE prAcIS_OPTIONAL(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbIS_OPTIONAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna DESCRIPTION
    PROCEDURE prAcDESCRIPTION(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDESCRIPTION    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PROCESS_SEQUENCE
    PROCEDURE prAcPROCESS_SEQUENCE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPROCESS_SEQUENCE    NUMBER
    );
 
    -- Actualiza el valor de la columna CONTAIN_MAIN_NUMBER
    PROCEDURE prAcCONTAIN_MAIN_NUMBER(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbCONTAIN_MAIN_NUMBER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna LOAD_COMPONENT_INFO
    PROCEDURE prAcLOAD_COMPONENT_INFO(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbLOAD_COMPONENT_INFO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna COPY_NETWORK_ASSO
    PROCEDURE prAcCOPY_NETWORK_ASSO(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbCOPY_NETWORK_ASSO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ELEMENT_CATEGORY_ID
    PROCEDURE prAcELEMENT_CATEGORY_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuELEMENT_CATEGORY_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ATTEND_WITH_PARENT
    PROCEDURE prAcATTEND_WITH_PARENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbATTEND_WITH_PARENT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PROCESS_WITH_XML
    PROCEDURE prAcPROCESS_WITH_XML(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbPROCESS_WITH_XML    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ACTIVE
    PROCEDURE prAcACTIVE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbACTIVE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna IS_NULLABLE
    PROCEDURE prAcIS_NULLABLE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbIS_NULLABLE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SERVICE_COMPONENT
    PROCEDURE prAcSERVICE_COMPONENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuSERVICE_COMPONENT    NUMBER
    );
 
    -- Actualiza el valor de la columna FACTI_TECNICA
    PROCEDURE prAcFACTI_TECNICA(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbFACTI_TECNICA    VARCHAR2
    );
 
    -- Actualiza el valor de la columna DISPLAY_CLASS_SERVICE
    PROCEDURE prAcDISPLAY_CLASS_SERVICE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDISPLAY_CLASS_SERVICE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna DISPLAY_CONTROL
    PROCEDURE prAcDISPLAY_CONTROL(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDISPLAY_CONTROL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna REQUIRES_CHILDREN
    PROCEDURE prAcREQUIRES_CHILDREN(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbREQUIRES_CHILDREN    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cups_prod_motive_comp%ROWTYPE);

    -- Obtiene registros depende de la condición
	PROCEDURE prcObtieneRegistros 
	(
		isbquery IN VARCHAR2,
		otbresult OUT nocopy tytbps_prod_motive_comp
	);
 
END pkg_ps_prod_motive_comp;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ps_prod_motive_comp AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuPROD_MOTIVE_COMP_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuPROD_MOTIVE_COMP_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuPROD_MOTIVE_COMP_ID);
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
        inuPROD_MOTIVE_COMP_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.PROD_MOTIVE_COMP_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuPROD_MOTIVE_COMP_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuPROD_MOTIVE_COMP_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuPROD_MOTIVE_COMP_ID||'] en la tabla[ps_prod_motive_comp]');
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
    PROCEDURE prInsRegistro( ircRegistro cups_prod_motive_comp%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO ps_prod_motive_comp(
            PROD_MOTIVE_COMP_ID,PRODUCT_MOTIVE_ID,PARENT_COMP,COMPONENT_TYPE_ID,MOTIVE_TYPE_ID,TAG_NAME,ASSIGN_ORDER,MIN_COMPONENTS,MAX_COMPONENTS,IS_OPTIONAL,DESCRIPTION,PROCESS_SEQUENCE,CONTAIN_MAIN_NUMBER,LOAD_COMPONENT_INFO,COPY_NETWORK_ASSO,ELEMENT_CATEGORY_ID,ATTEND_WITH_PARENT,PROCESS_WITH_XML,ACTIVE,IS_NULLABLE,SERVICE_COMPONENT,FACTI_TECNICA,DISPLAY_CLASS_SERVICE,DISPLAY_CONTROL,REQUIRES_CHILDREN
        )
        VALUES (
            ircRegistro.PROD_MOTIVE_COMP_ID,ircRegistro.PRODUCT_MOTIVE_ID,ircRegistro.PARENT_COMP,ircRegistro.COMPONENT_TYPE_ID,ircRegistro.MOTIVE_TYPE_ID,ircRegistro.TAG_NAME,ircRegistro.ASSIGN_ORDER,ircRegistro.MIN_COMPONENTS,ircRegistro.MAX_COMPONENTS,ircRegistro.IS_OPTIONAL,ircRegistro.DESCRIPTION,ircRegistro.PROCESS_SEQUENCE,ircRegistro.CONTAIN_MAIN_NUMBER,ircRegistro.LOAD_COMPONENT_INFO,ircRegistro.COPY_NETWORK_ASSO,ircRegistro.ELEMENT_CATEGORY_ID,ircRegistro.ATTEND_WITH_PARENT,ircRegistro.PROCESS_WITH_XML,ircRegistro.ACTIVE,ircRegistro.IS_NULLABLE,ircRegistro.SERVICE_COMPONENT,ircRegistro.FACTI_TECNICA,ircRegistro.DISPLAY_CLASS_SERVICE,ircRegistro.DISPLAY_CONTROL,ircRegistro.REQUIRES_CHILDREN
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
        inuPROD_MOTIVE_COMP_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE ps_prod_motive_comp
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
            DELETE ps_prod_motive_comp
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
 
    -- Obtiene el valor de la columna PRODUCT_MOTIVE_ID
    FUNCTION fnuObtPRODUCT_MOTIVE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PRODUCT_MOTIVE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRODUCT_MOTIVE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRODUCT_MOTIVE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPRODUCT_MOTIVE_ID;
 
    -- Obtiene el valor de la columna PARENT_COMP
    FUNCTION fnuObtPARENT_COMP(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PARENT_COMP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPARENT_COMP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PARENT_COMP;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPARENT_COMP;
 
    -- Obtiene el valor de la columna COMPONENT_TYPE_ID
    FUNCTION fnuObtCOMPONENT_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.COMPONENT_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOMPONENT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMPONENT_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCOMPONENT_TYPE_ID;
 
    -- Obtiene el valor de la columna MOTIVE_TYPE_ID
    FUNCTION fnuObtMOTIVE_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MOTIVE_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtMOTIVE_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MOTIVE_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtMOTIVE_TYPE_ID;
 
    -- Obtiene el valor de la columna TAG_NAME
    FUNCTION fsbObtTAG_NAME(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.TAG_NAME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTAG_NAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TAG_NAME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtTAG_NAME;
 
    -- Obtiene el valor de la columna ASSIGN_ORDER
    FUNCTION fnuObtASSIGN_ORDER(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ASSIGN_ORDER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtASSIGN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSIGN_ORDER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtASSIGN_ORDER;
 
    -- Obtiene el valor de la columna MIN_COMPONENTS
    FUNCTION fnuObtMIN_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MIN_COMPONENTS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtMIN_COMPONENTS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MIN_COMPONENTS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtMIN_COMPONENTS;
 
    -- Obtiene el valor de la columna MAX_COMPONENTS
    FUNCTION fnuObtMAX_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.MAX_COMPONENTS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtMAX_COMPONENTS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MAX_COMPONENTS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtMAX_COMPONENTS;
 
    -- Obtiene el valor de la columna IS_OPTIONAL
    FUNCTION fsbObtIS_OPTIONAL(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.IS_OPTIONAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtIS_OPTIONAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_OPTIONAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtIS_OPTIONAL;
 
    -- Obtiene el valor de la columna DESCRIPTION
    FUNCTION fsbObtDESCRIPTION(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DESCRIPTION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDESCRIPTION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DESCRIPTION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtDESCRIPTION;
 
    -- Obtiene el valor de la columna PROCESS_SEQUENCE
    FUNCTION fnuObtPROCESS_SEQUENCE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PROCESS_SEQUENCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPROCESS_SEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PROCESS_SEQUENCE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPROCESS_SEQUENCE;
 
    -- Obtiene el valor de la columna CONTAIN_MAIN_NUMBER
    FUNCTION fsbObtCONTAIN_MAIN_NUMBER(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.CONTAIN_MAIN_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCONTAIN_MAIN_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONTAIN_MAIN_NUMBER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCONTAIN_MAIN_NUMBER;
 
    -- Obtiene el valor de la columna LOAD_COMPONENT_INFO
    FUNCTION fsbObtLOAD_COMPONENT_INFO(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.LOAD_COMPONENT_INFO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtLOAD_COMPONENT_INFO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LOAD_COMPONENT_INFO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtLOAD_COMPONENT_INFO;
 
    -- Obtiene el valor de la columna COPY_NETWORK_ASSO
    FUNCTION fsbObtCOPY_NETWORK_ASSO(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.COPY_NETWORK_ASSO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCOPY_NETWORK_ASSO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COPY_NETWORK_ASSO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCOPY_NETWORK_ASSO;
 
    -- Obtiene el valor de la columna ELEMENT_CATEGORY_ID
    FUNCTION fnuObtELEMENT_CATEGORY_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ELEMENT_CATEGORY_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtELEMENT_CATEGORY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ELEMENT_CATEGORY_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtELEMENT_CATEGORY_ID;
 
    -- Obtiene el valor de la columna ATTEND_WITH_PARENT
    FUNCTION fsbObtATTEND_WITH_PARENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ATTEND_WITH_PARENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtATTEND_WITH_PARENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ATTEND_WITH_PARENT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtATTEND_WITH_PARENT;
 
    -- Obtiene el valor de la columna PROCESS_WITH_XML
    FUNCTION fsbObtPROCESS_WITH_XML(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.PROCESS_WITH_XML%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPROCESS_WITH_XML';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PROCESS_WITH_XML;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtPROCESS_WITH_XML;
 
    -- Obtiene el valor de la columna ACTIVE
    FUNCTION fsbObtACTIVE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.ACTIVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtACTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ACTIVE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtACTIVE;
 
    -- Obtiene el valor de la columna IS_NULLABLE
    FUNCTION fsbObtIS_NULLABLE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.IS_NULLABLE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtIS_NULLABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_NULLABLE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtIS_NULLABLE;
 
    -- Obtiene el valor de la columna SERVICE_COMPONENT
    FUNCTION fnuObtSERVICE_COMPONENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.SERVICE_COMPONENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSERVICE_COMPONENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SERVICE_COMPONENT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSERVICE_COMPONENT;
 
    -- Obtiene el valor de la columna FACTI_TECNICA
    FUNCTION fsbObtFACTI_TECNICA(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.FACTI_TECNICA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFACTI_TECNICA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTI_TECNICA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtFACTI_TECNICA;
 
    -- Obtiene el valor de la columna DISPLAY_CLASS_SERVICE
    FUNCTION fsbObtDISPLAY_CLASS_SERVICE(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DISPLAY_CLASS_SERVICE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDISPLAY_CLASS_SERVICE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DISPLAY_CLASS_SERVICE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtDISPLAY_CLASS_SERVICE;
 
    -- Obtiene el valor de la columna DISPLAY_CONTROL
    FUNCTION fsbObtDISPLAY_CONTROL(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.DISPLAY_CONTROL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDISPLAY_CONTROL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DISPLAY_CONTROL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtDISPLAY_CONTROL;
 
    -- Obtiene el valor de la columna REQUIRES_CHILDREN
    FUNCTION fsbObtREQUIRES_CHILDREN(
        inuPROD_MOTIVE_COMP_ID    NUMBER
        ) RETURN ps_prod_motive_comp.REQUIRES_CHILDREN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtREQUIRES_CHILDREN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REQUIRES_CHILDREN;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtREQUIRES_CHILDREN;
 
    -- Actualiza el valor de la columna PRODUCT_MOTIVE_ID
    PROCEDURE prAcPRODUCT_MOTIVE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPRODUCT_MOTIVE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCT_MOTIVE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuPRODUCT_MOTIVE_ID,-1) <> NVL(rcRegistroAct.PRODUCT_MOTIVE_ID,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PRODUCT_MOTIVE_ID=inuPRODUCT_MOTIVE_ID
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
    END prAcPRODUCT_MOTIVE_ID;
 
    -- Actualiza el valor de la columna PARENT_COMP
    PROCEDURE prAcPARENT_COMP(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPARENT_COMP    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPARENT_COMP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuPARENT_COMP,-1) <> NVL(rcRegistroAct.PARENT_COMP,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PARENT_COMP=inuPARENT_COMP
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
    END prAcPARENT_COMP;
 
    -- Actualiza el valor de la columna COMPONENT_TYPE_ID
    PROCEDURE prAcCOMPONENT_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuCOMPONENT_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPONENT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuCOMPONENT_TYPE_ID,-1) <> NVL(rcRegistroAct.COMPONENT_TYPE_ID,-1) THEN
            UPDATE ps_prod_motive_comp
            SET COMPONENT_TYPE_ID=inuCOMPONENT_TYPE_ID
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
    END prAcCOMPONENT_TYPE_ID;
 
    -- Actualiza el valor de la columna MOTIVE_TYPE_ID
    PROCEDURE prAcMOTIVE_TYPE_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMOTIVE_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMOTIVE_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuMOTIVE_TYPE_ID,-1) <> NVL(rcRegistroAct.MOTIVE_TYPE_ID,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MOTIVE_TYPE_ID=inuMOTIVE_TYPE_ID
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
    END prAcMOTIVE_TYPE_ID;
 
    -- Actualiza el valor de la columna TAG_NAME
    PROCEDURE prAcTAG_NAME(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbTAG_NAME    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAG_NAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbTAG_NAME,'-') <> NVL(rcRegistroAct.TAG_NAME,'-') THEN
            UPDATE ps_prod_motive_comp
            SET TAG_NAME=isbTAG_NAME
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
    END prAcTAG_NAME;
 
    -- Actualiza el valor de la columna ASSIGN_ORDER
    PROCEDURE prAcASSIGN_ORDER(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuASSIGN_ORDER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuASSIGN_ORDER,-1) <> NVL(rcRegistroAct.ASSIGN_ORDER,-1) THEN
            UPDATE ps_prod_motive_comp
            SET ASSIGN_ORDER=inuASSIGN_ORDER
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
    END prAcASSIGN_ORDER;
 
    -- Actualiza el valor de la columna MIN_COMPONENTS
    PROCEDURE prAcMIN_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMIN_COMPONENTS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMIN_COMPONENTS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuMIN_COMPONENTS,-1) <> NVL(rcRegistroAct.MIN_COMPONENTS,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MIN_COMPONENTS=inuMIN_COMPONENTS
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
    END prAcMIN_COMPONENTS;
 
    -- Actualiza el valor de la columna MAX_COMPONENTS
    PROCEDURE prAcMAX_COMPONENTS(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuMAX_COMPONENTS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMAX_COMPONENTS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuMAX_COMPONENTS,-1) <> NVL(rcRegistroAct.MAX_COMPONENTS,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MAX_COMPONENTS=inuMAX_COMPONENTS
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
    END prAcMAX_COMPONENTS;
 
    -- Actualiza el valor de la columna IS_OPTIONAL
    PROCEDURE prAcIS_OPTIONAL(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbIS_OPTIONAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_OPTIONAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbIS_OPTIONAL,'-') <> NVL(rcRegistroAct.IS_OPTIONAL,'-') THEN
            UPDATE ps_prod_motive_comp
            SET IS_OPTIONAL=isbIS_OPTIONAL
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
    END prAcIS_OPTIONAL;
 
    -- Actualiza el valor de la columna DESCRIPTION
    PROCEDURE prAcDESCRIPTION(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDESCRIPTION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDESCRIPTION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbDESCRIPTION,'-') <> NVL(rcRegistroAct.DESCRIPTION,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DESCRIPTION=isbDESCRIPTION
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
    END prAcDESCRIPTION;
 
    -- Actualiza el valor de la columna PROCESS_SEQUENCE
    PROCEDURE prAcPROCESS_SEQUENCE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuPROCESS_SEQUENCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCESS_SEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuPROCESS_SEQUENCE,-1) <> NVL(rcRegistroAct.PROCESS_SEQUENCE,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PROCESS_SEQUENCE=inuPROCESS_SEQUENCE
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
    END prAcPROCESS_SEQUENCE;
 
    -- Actualiza el valor de la columna CONTAIN_MAIN_NUMBER
    PROCEDURE prAcCONTAIN_MAIN_NUMBER(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbCONTAIN_MAIN_NUMBER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTAIN_MAIN_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbCONTAIN_MAIN_NUMBER,'-') <> NVL(rcRegistroAct.CONTAIN_MAIN_NUMBER,'-') THEN
            UPDATE ps_prod_motive_comp
            SET CONTAIN_MAIN_NUMBER=isbCONTAIN_MAIN_NUMBER
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
    END prAcCONTAIN_MAIN_NUMBER;
 
    -- Actualiza el valor de la columna LOAD_COMPONENT_INFO
    PROCEDURE prAcLOAD_COMPONENT_INFO(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbLOAD_COMPONENT_INFO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLOAD_COMPONENT_INFO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbLOAD_COMPONENT_INFO,'-') <> NVL(rcRegistroAct.LOAD_COMPONENT_INFO,'-') THEN
            UPDATE ps_prod_motive_comp
            SET LOAD_COMPONENT_INFO=isbLOAD_COMPONENT_INFO
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
    END prAcLOAD_COMPONENT_INFO;
 
    -- Actualiza el valor de la columna COPY_NETWORK_ASSO
    PROCEDURE prAcCOPY_NETWORK_ASSO(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbCOPY_NETWORK_ASSO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOPY_NETWORK_ASSO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbCOPY_NETWORK_ASSO,'-') <> NVL(rcRegistroAct.COPY_NETWORK_ASSO,'-') THEN
            UPDATE ps_prod_motive_comp
            SET COPY_NETWORK_ASSO=isbCOPY_NETWORK_ASSO
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
    END prAcCOPY_NETWORK_ASSO;
 
    -- Actualiza el valor de la columna ELEMENT_CATEGORY_ID
    PROCEDURE prAcELEMENT_CATEGORY_ID(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuELEMENT_CATEGORY_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcELEMENT_CATEGORY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuELEMENT_CATEGORY_ID,-1) <> NVL(rcRegistroAct.ELEMENT_CATEGORY_ID,-1) THEN
            UPDATE ps_prod_motive_comp
            SET ELEMENT_CATEGORY_ID=inuELEMENT_CATEGORY_ID
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
    END prAcELEMENT_CATEGORY_ID;
 
    -- Actualiza el valor de la columna ATTEND_WITH_PARENT
    PROCEDURE prAcATTEND_WITH_PARENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbATTEND_WITH_PARENT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcATTEND_WITH_PARENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbATTEND_WITH_PARENT,'-') <> NVL(rcRegistroAct.ATTEND_WITH_PARENT,'-') THEN
            UPDATE ps_prod_motive_comp
            SET ATTEND_WITH_PARENT=isbATTEND_WITH_PARENT
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
    END prAcATTEND_WITH_PARENT;
 
    -- Actualiza el valor de la columna PROCESS_WITH_XML
    PROCEDURE prAcPROCESS_WITH_XML(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbPROCESS_WITH_XML    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCESS_WITH_XML';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbPROCESS_WITH_XML,'-') <> NVL(rcRegistroAct.PROCESS_WITH_XML,'-') THEN
            UPDATE ps_prod_motive_comp
            SET PROCESS_WITH_XML=isbPROCESS_WITH_XML
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
    END prAcPROCESS_WITH_XML;
 
    -- Actualiza el valor de la columna ACTIVE
    PROCEDURE prAcACTIVE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbACTIVE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbACTIVE,'-') <> NVL(rcRegistroAct.ACTIVE,'-') THEN
            UPDATE ps_prod_motive_comp
            SET ACTIVE=isbACTIVE
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
    END prAcACTIVE;
 
    -- Actualiza el valor de la columna IS_NULLABLE
    PROCEDURE prAcIS_NULLABLE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbIS_NULLABLE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_NULLABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbIS_NULLABLE,'-') <> NVL(rcRegistroAct.IS_NULLABLE,'-') THEN
            UPDATE ps_prod_motive_comp
            SET IS_NULLABLE=isbIS_NULLABLE
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
    END prAcIS_NULLABLE;
 
    -- Actualiza el valor de la columna SERVICE_COMPONENT
    PROCEDURE prAcSERVICE_COMPONENT(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        inuSERVICE_COMPONENT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSERVICE_COMPONENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(inuSERVICE_COMPONENT,-1) <> NVL(rcRegistroAct.SERVICE_COMPONENT,-1) THEN
            UPDATE ps_prod_motive_comp
            SET SERVICE_COMPONENT=inuSERVICE_COMPONENT
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
    END prAcSERVICE_COMPONENT;
 
    -- Actualiza el valor de la columna FACTI_TECNICA
    PROCEDURE prAcFACTI_TECNICA(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbFACTI_TECNICA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFACTI_TECNICA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbFACTI_TECNICA,'-') <> NVL(rcRegistroAct.FACTI_TECNICA,'-') THEN
            UPDATE ps_prod_motive_comp
            SET FACTI_TECNICA=isbFACTI_TECNICA
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
    END prAcFACTI_TECNICA;
 
    -- Actualiza el valor de la columna DISPLAY_CLASS_SERVICE
    PROCEDURE prAcDISPLAY_CLASS_SERVICE(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDISPLAY_CLASS_SERVICE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDISPLAY_CLASS_SERVICE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbDISPLAY_CLASS_SERVICE,'-') <> NVL(rcRegistroAct.DISPLAY_CLASS_SERVICE,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DISPLAY_CLASS_SERVICE=isbDISPLAY_CLASS_SERVICE
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
    END prAcDISPLAY_CLASS_SERVICE;
 
    -- Actualiza el valor de la columna DISPLAY_CONTROL
    PROCEDURE prAcDISPLAY_CONTROL(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbDISPLAY_CONTROL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDISPLAY_CONTROL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbDISPLAY_CONTROL,'-') <> NVL(rcRegistroAct.DISPLAY_CONTROL,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DISPLAY_CONTROL=isbDISPLAY_CONTROL
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
    END prAcDISPLAY_CONTROL;
 
    -- Actualiza el valor de la columna REQUIRES_CHILDREN
    PROCEDURE prAcREQUIRES_CHILDREN(
        inuPROD_MOTIVE_COMP_ID    NUMBER,
        isbREQUIRES_CHILDREN    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRES_CHILDREN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuPROD_MOTIVE_COMP_ID,TRUE);
        IF NVL(isbREQUIRES_CHILDREN,'-') <> NVL(rcRegistroAct.REQUIRES_CHILDREN,'-') THEN
            UPDATE ps_prod_motive_comp
            SET REQUIRES_CHILDREN=isbREQUIRES_CHILDREN
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
    END prAcREQUIRES_CHILDREN;
 
    -- Actualiza por RowId el valor de la columna PRODUCT_MOTIVE_ID
    PROCEDURE prAcPRODUCT_MOTIVE_ID_RId(
        iRowId ROWID,
        inuPRODUCT_MOTIVE_ID_O    NUMBER,
        inuPRODUCT_MOTIVE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCT_MOTIVE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRODUCT_MOTIVE_ID_O,-1) <> NVL(inuPRODUCT_MOTIVE_ID_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PRODUCT_MOTIVE_ID=inuPRODUCT_MOTIVE_ID_N
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
    END prAcPRODUCT_MOTIVE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PARENT_COMP
    PROCEDURE prAcPARENT_COMP_RId(
        iRowId ROWID,
        inuPARENT_COMP_O    NUMBER,
        inuPARENT_COMP_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPARENT_COMP_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPARENT_COMP_O,-1) <> NVL(inuPARENT_COMP_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PARENT_COMP=inuPARENT_COMP_N
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
    END prAcPARENT_COMP_RId;
 
    -- Actualiza por RowId el valor de la columna COMPONENT_TYPE_ID
    PROCEDURE prAcCOMPONENT_TYPE_ID_RId(
        iRowId ROWID,
        inuCOMPONENT_TYPE_ID_O    NUMBER,
        inuCOMPONENT_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPONENT_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOMPONENT_TYPE_ID_O,-1) <> NVL(inuCOMPONENT_TYPE_ID_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET COMPONENT_TYPE_ID=inuCOMPONENT_TYPE_ID_N
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
    END prAcCOMPONENT_TYPE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna MOTIVE_TYPE_ID
    PROCEDURE prAcMOTIVE_TYPE_ID_RId(
        iRowId ROWID,
        inuMOTIVE_TYPE_ID_O    NUMBER,
        inuMOTIVE_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMOTIVE_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuMOTIVE_TYPE_ID_O,-1) <> NVL(inuMOTIVE_TYPE_ID_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MOTIVE_TYPE_ID=inuMOTIVE_TYPE_ID_N
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
    END prAcMOTIVE_TYPE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna TAG_NAME
    PROCEDURE prAcTAG_NAME_RId(
        iRowId ROWID,
        isbTAG_NAME_O    VARCHAR2,
        isbTAG_NAME_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTAG_NAME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTAG_NAME_O,'-') <> NVL(isbTAG_NAME_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET TAG_NAME=isbTAG_NAME_N
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
    END prAcTAG_NAME_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIGN_ORDER
    PROCEDURE prAcASSIGN_ORDER_RId(
        iRowId ROWID,
        inuASSIGN_ORDER_O    NUMBER,
        inuASSIGN_ORDER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_ORDER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuASSIGN_ORDER_O,-1) <> NVL(inuASSIGN_ORDER_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET ASSIGN_ORDER=inuASSIGN_ORDER_N
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
    END prAcASSIGN_ORDER_RId;
 
    -- Actualiza por RowId el valor de la columna MIN_COMPONENTS
    PROCEDURE prAcMIN_COMPONENTS_RId(
        iRowId ROWID,
        inuMIN_COMPONENTS_O    NUMBER,
        inuMIN_COMPONENTS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMIN_COMPONENTS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuMIN_COMPONENTS_O,-1) <> NVL(inuMIN_COMPONENTS_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MIN_COMPONENTS=inuMIN_COMPONENTS_N
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
    END prAcMIN_COMPONENTS_RId;
 
    -- Actualiza por RowId el valor de la columna MAX_COMPONENTS
    PROCEDURE prAcMAX_COMPONENTS_RId(
        iRowId ROWID,
        inuMAX_COMPONENTS_O    NUMBER,
        inuMAX_COMPONENTS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMAX_COMPONENTS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuMAX_COMPONENTS_O,-1) <> NVL(inuMAX_COMPONENTS_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET MAX_COMPONENTS=inuMAX_COMPONENTS_N
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
    END prAcMAX_COMPONENTS_RId;
 
    -- Actualiza por RowId el valor de la columna IS_OPTIONAL
    PROCEDURE prAcIS_OPTIONAL_RId(
        iRowId ROWID,
        isbIS_OPTIONAL_O    VARCHAR2,
        isbIS_OPTIONAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_OPTIONAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_OPTIONAL_O,'-') <> NVL(isbIS_OPTIONAL_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET IS_OPTIONAL=isbIS_OPTIONAL_N
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
    END prAcIS_OPTIONAL_RId;
 
    -- Actualiza por RowId el valor de la columna DESCRIPTION
    PROCEDURE prAcDESCRIPTION_RId(
        iRowId ROWID,
        isbDESCRIPTION_O    VARCHAR2,
        isbDESCRIPTION_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDESCRIPTION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbDESCRIPTION_O,'-') <> NVL(isbDESCRIPTION_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DESCRIPTION=isbDESCRIPTION_N
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
    END prAcDESCRIPTION_RId;
 
    -- Actualiza por RowId el valor de la columna PROCESS_SEQUENCE
    PROCEDURE prAcPROCESS_SEQUENCE_RId(
        iRowId ROWID,
        inuPROCESS_SEQUENCE_O    NUMBER,
        inuPROCESS_SEQUENCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCESS_SEQUENCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPROCESS_SEQUENCE_O,-1) <> NVL(inuPROCESS_SEQUENCE_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET PROCESS_SEQUENCE=inuPROCESS_SEQUENCE_N
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
    END prAcPROCESS_SEQUENCE_RId;
 
    -- Actualiza por RowId el valor de la columna CONTAIN_MAIN_NUMBER
    PROCEDURE prAcCONTAIN_MAIN_NUMBER_RId(
        iRowId ROWID,
        isbCONTAIN_MAIN_NUMBER_O    VARCHAR2,
        isbCONTAIN_MAIN_NUMBER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTAIN_MAIN_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCONTAIN_MAIN_NUMBER_O,'-') <> NVL(isbCONTAIN_MAIN_NUMBER_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET CONTAIN_MAIN_NUMBER=isbCONTAIN_MAIN_NUMBER_N
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
    END prAcCONTAIN_MAIN_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna LOAD_COMPONENT_INFO
    PROCEDURE prAcLOAD_COMPONENT_INFO_RId(
        iRowId ROWID,
        isbLOAD_COMPONENT_INFO_O    VARCHAR2,
        isbLOAD_COMPONENT_INFO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLOAD_COMPONENT_INFO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbLOAD_COMPONENT_INFO_O,'-') <> NVL(isbLOAD_COMPONENT_INFO_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET LOAD_COMPONENT_INFO=isbLOAD_COMPONENT_INFO_N
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
    END prAcLOAD_COMPONENT_INFO_RId;
 
    -- Actualiza por RowId el valor de la columna COPY_NETWORK_ASSO
    PROCEDURE prAcCOPY_NETWORK_ASSO_RId(
        iRowId ROWID,
        isbCOPY_NETWORK_ASSO_O    VARCHAR2,
        isbCOPY_NETWORK_ASSO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOPY_NETWORK_ASSO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOPY_NETWORK_ASSO_O,'-') <> NVL(isbCOPY_NETWORK_ASSO_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET COPY_NETWORK_ASSO=isbCOPY_NETWORK_ASSO_N
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
    END prAcCOPY_NETWORK_ASSO_RId;
 
    -- Actualiza por RowId el valor de la columna ELEMENT_CATEGORY_ID
    PROCEDURE prAcELEMENT_CATEGORY_ID_RId(
        iRowId ROWID,
        inuELEMENT_CATEGORY_ID_O    NUMBER,
        inuELEMENT_CATEGORY_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcELEMENT_CATEGORY_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuELEMENT_CATEGORY_ID_O,-1) <> NVL(inuELEMENT_CATEGORY_ID_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET ELEMENT_CATEGORY_ID=inuELEMENT_CATEGORY_ID_N
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
    END prAcELEMENT_CATEGORY_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ATTEND_WITH_PARENT
    PROCEDURE prAcATTEND_WITH_PARENT_RId(
        iRowId ROWID,
        isbATTEND_WITH_PARENT_O    VARCHAR2,
        isbATTEND_WITH_PARENT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcATTEND_WITH_PARENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbATTEND_WITH_PARENT_O,'-') <> NVL(isbATTEND_WITH_PARENT_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET ATTEND_WITH_PARENT=isbATTEND_WITH_PARENT_N
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
    END prAcATTEND_WITH_PARENT_RId;
 
    -- Actualiza por RowId el valor de la columna PROCESS_WITH_XML
    PROCEDURE prAcPROCESS_WITH_XML_RId(
        iRowId ROWID,
        isbPROCESS_WITH_XML_O    VARCHAR2,
        isbPROCESS_WITH_XML_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROCESS_WITH_XML_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPROCESS_WITH_XML_O,'-') <> NVL(isbPROCESS_WITH_XML_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET PROCESS_WITH_XML=isbPROCESS_WITH_XML_N
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
    END prAcPROCESS_WITH_XML_RId;
 
    -- Actualiza por RowId el valor de la columna ACTIVE
    PROCEDURE prAcACTIVE_RId(
        iRowId ROWID,
        isbACTIVE_O    VARCHAR2,
        isbACTIVE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbACTIVE_O,'-') <> NVL(isbACTIVE_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET ACTIVE=isbACTIVE_N
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
    END prAcACTIVE_RId;
 
    -- Actualiza por RowId el valor de la columna IS_NULLABLE
    PROCEDURE prAcIS_NULLABLE_RId(
        iRowId ROWID,
        isbIS_NULLABLE_O    VARCHAR2,
        isbIS_NULLABLE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_NULLABLE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_NULLABLE_O,'-') <> NVL(isbIS_NULLABLE_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET IS_NULLABLE=isbIS_NULLABLE_N
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
    END prAcIS_NULLABLE_RId;
 
    -- Actualiza por RowId el valor de la columna SERVICE_COMPONENT
    PROCEDURE prAcSERVICE_COMPONENT_RId(
        iRowId ROWID,
        inuSERVICE_COMPONENT_O    NUMBER,
        inuSERVICE_COMPONENT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSERVICE_COMPONENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSERVICE_COMPONENT_O,-1) <> NVL(inuSERVICE_COMPONENT_N,-1) THEN
            UPDATE ps_prod_motive_comp
            SET SERVICE_COMPONENT=inuSERVICE_COMPONENT_N
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
    END prAcSERVICE_COMPONENT_RId;
 
    -- Actualiza por RowId el valor de la columna FACTI_TECNICA
    PROCEDURE prAcFACTI_TECNICA_RId(
        iRowId ROWID,
        isbFACTI_TECNICA_O    VARCHAR2,
        isbFACTI_TECNICA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFACTI_TECNICA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbFACTI_TECNICA_O,'-') <> NVL(isbFACTI_TECNICA_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET FACTI_TECNICA=isbFACTI_TECNICA_N
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
    END prAcFACTI_TECNICA_RId;
 
    -- Actualiza por RowId el valor de la columna DISPLAY_CLASS_SERVICE
    PROCEDURE prAcDISPLAY_CLASS_SERVICE_RId(
        iRowId ROWID,
        isbDISPLAY_CLASS_SERVICE_O    VARCHAR2,
        isbDISPLAY_CLASS_SERVICE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDISPLAY_CLASS_SERVICE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbDISPLAY_CLASS_SERVICE_O,'-') <> NVL(isbDISPLAY_CLASS_SERVICE_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DISPLAY_CLASS_SERVICE=isbDISPLAY_CLASS_SERVICE_N
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
    END prAcDISPLAY_CLASS_SERVICE_RId;
 
    -- Actualiza por RowId el valor de la columna DISPLAY_CONTROL
    PROCEDURE prAcDISPLAY_CONTROL_RId(
        iRowId ROWID,
        isbDISPLAY_CONTROL_O    VARCHAR2,
        isbDISPLAY_CONTROL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDISPLAY_CONTROL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbDISPLAY_CONTROL_O,'-') <> NVL(isbDISPLAY_CONTROL_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET DISPLAY_CONTROL=isbDISPLAY_CONTROL_N
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
    END prAcDISPLAY_CONTROL_RId;
 
    -- Actualiza por RowId el valor de la columna REQUIRES_CHILDREN
    PROCEDURE prAcREQUIRES_CHILDREN_RId(
        iRowId ROWID,
        isbREQUIRES_CHILDREN_O    VARCHAR2,
        isbREQUIRES_CHILDREN_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREQUIRES_CHILDREN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbREQUIRES_CHILDREN_O,'-') <> NVL(isbREQUIRES_CHILDREN_N,'-') THEN
            UPDATE ps_prod_motive_comp
            SET REQUIRES_CHILDREN=isbREQUIRES_CHILDREN_N
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
    END prAcREQUIRES_CHILDREN_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cups_prod_motive_comp%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.PROD_MOTIVE_COMP_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPRODUCT_MOTIVE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRODUCT_MOTIVE_ID,
                ircRegistro.PRODUCT_MOTIVE_ID
            );
 
            prAcPARENT_COMP_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PARENT_COMP,
                ircRegistro.PARENT_COMP
            );
 
            prAcCOMPONENT_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPONENT_TYPE_ID,
                ircRegistro.COMPONENT_TYPE_ID
            );
 
            prAcMOTIVE_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MOTIVE_TYPE_ID,
                ircRegistro.MOTIVE_TYPE_ID
            );
 
            prAcTAG_NAME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TAG_NAME,
                ircRegistro.TAG_NAME
            );
 
            prAcASSIGN_ORDER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIGN_ORDER,
                ircRegistro.ASSIGN_ORDER
            );
 
            prAcMIN_COMPONENTS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MIN_COMPONENTS,
                ircRegistro.MIN_COMPONENTS
            );
 
            prAcMAX_COMPONENTS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MAX_COMPONENTS,
                ircRegistro.MAX_COMPONENTS
            );
 
            prAcIS_OPTIONAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_OPTIONAL,
                ircRegistro.IS_OPTIONAL
            );
 
            prAcDESCRIPTION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DESCRIPTION,
                ircRegistro.DESCRIPTION
            );
 
            prAcPROCESS_SEQUENCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PROCESS_SEQUENCE,
                ircRegistro.PROCESS_SEQUENCE
            );
 
            prAcCONTAIN_MAIN_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONTAIN_MAIN_NUMBER,
                ircRegistro.CONTAIN_MAIN_NUMBER
            );
 
            prAcLOAD_COMPONENT_INFO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LOAD_COMPONENT_INFO,
                ircRegistro.LOAD_COMPONENT_INFO
            );
 
            prAcCOPY_NETWORK_ASSO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COPY_NETWORK_ASSO,
                ircRegistro.COPY_NETWORK_ASSO
            );
 
            prAcELEMENT_CATEGORY_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ELEMENT_CATEGORY_ID,
                ircRegistro.ELEMENT_CATEGORY_ID
            );
 
            prAcATTEND_WITH_PARENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ATTEND_WITH_PARENT,
                ircRegistro.ATTEND_WITH_PARENT
            );
 
            prAcPROCESS_WITH_XML_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PROCESS_WITH_XML,
                ircRegistro.PROCESS_WITH_XML
            );
 
            prAcACTIVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTIVE,
                ircRegistro.ACTIVE
            );
 
            prAcIS_NULLABLE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_NULLABLE,
                ircRegistro.IS_NULLABLE
            );
 
            prAcSERVICE_COMPONENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SERVICE_COMPONENT,
                ircRegistro.SERVICE_COMPONENT
            );
 
            prAcFACTI_TECNICA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FACTI_TECNICA,
                ircRegistro.FACTI_TECNICA
            );
 
            prAcDISPLAY_CLASS_SERVICE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DISPLAY_CLASS_SERVICE,
                ircRegistro.DISPLAY_CLASS_SERVICE
            );
 
            prAcDISPLAY_CONTROL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DISPLAY_CONTROL,
                ircRegistro.DISPLAY_CONTROL
            );
 
            prAcREQUIRES_CHILDREN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REQUIRES_CHILDREN,
                ircRegistro.REQUIRES_CHILDREN
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

	PROCEDURE prcObtieneRegistros 
	(
		isbquery IN VARCHAR2,
		otbresult OUT nocopy tytbps_prod_motive_comp
	)
	IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME||'prcObtieneRegistros';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

		rfps_prod_motive_comp tyrfps_prod_motive_comp;
		sbfullquery varchar2 (32000) := 'SELECT PS_prod_motive_comp.*, PS_prod_motive_comp.rowid FROM PS_prod_motive_comp';

	BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		otbresult.DELETE;

		IF isbquery is not null and length(isbquery) > 0 THEN
			sbfullquery := sbfullquery||' WHERE '||isbquery;
		END IF;

		OPEN rfps_prod_motive_comp for sbfullquery;
		FETCH rfps_prod_motive_comp bulk collect INTO otbresult;
		CLOSE rfps_prod_motive_comp;


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
	END prcObtieneRegistros;
END pkg_ps_prod_motive_comp;
/
BEGIN
    -- felipe.valencia
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ps_prod_motive_comp'), UPPER('adm_person'));
END;
/
