CREATE OR REPLACE PACKAGE adm_person.pkg_or_task_type AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_TASK_TYPE%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOR_TASK_TYPE IS SELECT * FROM OR_TASK_TYPE;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_TASK_TYPE
        Caso  : OSF-XXXX
        Fecha : 31/01/2025 10:40:30
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuTASK_TYPE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_TASK_TYPE tb
        WHERE
        TASK_TYPE_ID = inuTASK_TYPE_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuTASK_TYPE_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_TASK_TYPE tb
        WHERE
        TASK_TYPE_ID = inuTASK_TYPE_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuTASK_TYPE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuTASK_TYPE_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuTASK_TYPE_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_TASK_TYPE%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuTASK_TYPE_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna DESCRIPTION
    FUNCTION fsbObtDESCRIPTION(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.DESCRIPTION%TYPE;
 
    -- Obtiene el valor de la columna SHORT_NAME
    FUNCTION fsbObtSHORT_NAME(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.SHORT_NAME%TYPE;
 
    -- Obtiene el valor de la columna IS_ANULL
    FUNCTION fsbObtIS_ANULL(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.IS_ANULL%TYPE;
 
    -- Obtiene el valor de la columna TRY_AUTOM_ASSIGMENT
    FUNCTION fsbObtTRY_AUTOM_ASSIGMENT(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TRY_AUTOM_ASSIGMENT%TYPE;
 
    -- Obtiene el valor de la columna USES_OPER_SECTOR
    FUNCTION fsbObtUSES_OPER_SECTOR(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.USES_OPER_SECTOR%TYPE;
 
    -- Obtiene el valor de la columna TASK_TYPE_CLASSIF
    FUNCTION fnuObtTASK_TYPE_CLASSIF(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TASK_TYPE_CLASSIF%TYPE;
 
    -- Obtiene el valor de la columna ADD_ITEMS_ALLOWED
    FUNCTION fsbObtADD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ADD_ITEMS_ALLOWED%TYPE;
 
    -- Obtiene el valor de la columna ADD_NET_ALLOWED
    FUNCTION fsbObtADD_NET_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ADD_NET_ALLOWED%TYPE;
 
    -- Obtiene el valor de la columna COMMENT_REQUIRED
    FUNCTION fsbObtCOMMENT_REQUIRED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.COMMENT_REQUIRED%TYPE;
 
    -- Obtiene el valor de la columna WARRANTY_PERIOD
    FUNCTION fnuObtWARRANTY_PERIOD(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.WARRANTY_PERIOD%TYPE;
 
    -- Obtiene el valor de la columna CONCEPT
    FUNCTION fnuObtCONCEPT(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.CONCEPT%TYPE;
 
    -- Obtiene el valor de la columna SOLD_ENGINEERING_SER
    FUNCTION fsbObtSOLD_ENGINEERING_SER(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.SOLD_ENGINEERING_SER%TYPE;
 
    -- Obtiene el valor de la columna PRIORITY
    FUNCTION fnuObtPRIORITY(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.PRIORITY%TYPE;
 
    -- Obtiene el valor de la columna NODAL_CHANGE
    FUNCTION fsbObtNODAL_CHANGE(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.NODAL_CHANGE%TYPE;
 
    -- Obtiene el valor de la columna ARRANGED_HOUR_ALLOWED
    FUNCTION fsbObtARRANGED_HOUR_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ARRANGED_HOUR_ALLOWED%TYPE;
 
    -- Obtiene el valor de la columna OBJECT_ID
    FUNCTION fnuObtOBJECT_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.OBJECT_ID%TYPE;
 
    -- Obtiene el valor de la columna TASK_TYPE_GROUP_ID
    FUNCTION fnuObtTASK_TYPE_GROUP_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TASK_TYPE_GROUP_ID%TYPE;
 
    -- Obtiene el valor de la columna WORK_DAYS
    FUNCTION fsbObtWORK_DAYS(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.WORK_DAYS%TYPE;
 
    -- Obtiene el valor de la columna COMPROMISE_CRM
    FUNCTION fsbObtCOMPROMISE_CRM(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.COMPROMISE_CRM%TYPE;
 
    -- Obtiene el valor de la columna USE_
    FUNCTION fsbObtUSE_(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.USE_%TYPE;
 
    -- Obtiene el valor de la columna NOTIFICABLE
    FUNCTION fsbObtNOTIFICABLE(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.NOTIFICABLE%TYPE;
 
    -- Obtiene el valor de la columna GEN_ADMIN_ORDER
    FUNCTION fsbObtGEN_ADMIN_ORDER(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.GEN_ADMIN_ORDER%TYPE;
 
    -- Obtiene el valor de la columna UPD_ITEMS_ALLOWED
    FUNCTION fsbObtUPD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.UPD_ITEMS_ALLOWED%TYPE;
 
    -- Obtiene el valor de la columna PRINT_FORMAT_ID
    FUNCTION fnuObtPRINT_FORMAT_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.PRINT_FORMAT_ID%TYPE;
 
    -- Actualiza el valor de la columna DESCRIPTION
    PROCEDURE prAcDESCRIPTION(
        inuTASK_TYPE_ID    NUMBER,
        isbDESCRIPTION    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SHORT_NAME
    PROCEDURE prAcSHORT_NAME(
        inuTASK_TYPE_ID    NUMBER,
        isbSHORT_NAME    VARCHAR2
    );
 
    -- Actualiza el valor de la columna IS_ANULL
    PROCEDURE prAcIS_ANULL(
        inuTASK_TYPE_ID    NUMBER,
        isbIS_ANULL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna TRY_AUTOM_ASSIGMENT
    PROCEDURE prAcTRY_AUTOM_ASSIGMENT(
        inuTASK_TYPE_ID    NUMBER,
        isbTRY_AUTOM_ASSIGMENT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna USES_OPER_SECTOR
    PROCEDURE prAcUSES_OPER_SECTOR(
        inuTASK_TYPE_ID    NUMBER,
        isbUSES_OPER_SECTOR    VARCHAR2
    );
 
    -- Actualiza el valor de la columna TASK_TYPE_CLASSIF
    PROCEDURE prAcTASK_TYPE_CLASSIF(
        inuTASK_TYPE_ID    NUMBER,
        inuTASK_TYPE_CLASSIF    NUMBER
    );
 
    -- Actualiza el valor de la columna ADD_ITEMS_ALLOWED
    PROCEDURE prAcADD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbADD_ITEMS_ALLOWED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ADD_NET_ALLOWED
    PROCEDURE prAcADD_NET_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbADD_NET_ALLOWED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna COMMENT_REQUIRED
    PROCEDURE prAcCOMMENT_REQUIRED(
        inuTASK_TYPE_ID    NUMBER,
        isbCOMMENT_REQUIRED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna WARRANTY_PERIOD
    PROCEDURE prAcWARRANTY_PERIOD(
        inuTASK_TYPE_ID    NUMBER,
        inuWARRANTY_PERIOD    NUMBER
    );
 
    -- Actualiza el valor de la columna CONCEPT
    PROCEDURE prAcCONCEPT(
        inuTASK_TYPE_ID    NUMBER,
        inuCONCEPT    NUMBER
    );
 
    -- Actualiza el valor de la columna SOLD_ENGINEERING_SER
    PROCEDURE prAcSOLD_ENGINEERING_SER(
        inuTASK_TYPE_ID    NUMBER,
        isbSOLD_ENGINEERING_SER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY(
        inuTASK_TYPE_ID    NUMBER,
        inuPRIORITY    NUMBER
    );
 
    -- Actualiza el valor de la columna NODAL_CHANGE
    PROCEDURE prAcNODAL_CHANGE(
        inuTASK_TYPE_ID    NUMBER,
        isbNODAL_CHANGE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ARRANGED_HOUR_ALLOWED
    PROCEDURE prAcARRANGED_HOUR_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbARRANGED_HOUR_ALLOWED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna OBJECT_ID
    PROCEDURE prAcOBJECT_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuOBJECT_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna TASK_TYPE_GROUP_ID
    PROCEDURE prAcTASK_TYPE_GROUP_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuTASK_TYPE_GROUP_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS(
        inuTASK_TYPE_ID    NUMBER,
        isbWORK_DAYS    VARCHAR2
    );
 
    -- Actualiza el valor de la columna COMPROMISE_CRM
    PROCEDURE prAcCOMPROMISE_CRM(
        inuTASK_TYPE_ID    NUMBER,
        isbCOMPROMISE_CRM    VARCHAR2
    );
 
    -- Actualiza el valor de la columna USE_
    PROCEDURE prAcUSE_(
        inuTASK_TYPE_ID    NUMBER,
        isbUSE_    VARCHAR2
    );
 
    -- Actualiza el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE(
        inuTASK_TYPE_ID    NUMBER,
        isbNOTIFICABLE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER(
        inuTASK_TYPE_ID    NUMBER,
        isbGEN_ADMIN_ORDER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna UPD_ITEMS_ALLOWED
    PROCEDURE prAcUPD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbUPD_ITEMS_ALLOWED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PRINT_FORMAT_ID
    PROCEDURE prAcPRINT_FORMAT_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuPRINT_FORMAT_ID    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_TASK_TYPE%ROWTYPE);
 
END pkg_OR_TASK_TYPE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_task_type AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuTASK_TYPE_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuTASK_TYPE_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuTASK_TYPE_ID);
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
        inuTASK_TYPE_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.TASK_TYPE_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuTASK_TYPE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuTASK_TYPE_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuTASK_TYPE_ID||'] en la tabla[OR_TASK_TYPE]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
    PROCEDURE prInsRegistro( ircRegistro cuOR_TASK_TYPE%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_TASK_TYPE(
            TASK_TYPE_ID,DESCRIPTION,SHORT_NAME,IS_ANULL,TRY_AUTOM_ASSIGMENT,USES_OPER_SECTOR,TASK_TYPE_CLASSIF,ADD_ITEMS_ALLOWED,ADD_NET_ALLOWED,COMMENT_REQUIRED,WARRANTY_PERIOD,CONCEPT,SOLD_ENGINEERING_SER,PRIORITY,NODAL_CHANGE,ARRANGED_HOUR_ALLOWED,OBJECT_ID,TASK_TYPE_GROUP_ID,WORK_DAYS,COMPROMISE_CRM,USE_,NOTIFICABLE,GEN_ADMIN_ORDER,UPD_ITEMS_ALLOWED,PRINT_FORMAT_ID
        )
        VALUES (
            ircRegistro.TASK_TYPE_ID,ircRegistro.DESCRIPTION,ircRegistro.SHORT_NAME,ircRegistro.IS_ANULL,ircRegistro.TRY_AUTOM_ASSIGMENT,ircRegistro.USES_OPER_SECTOR,ircRegistro.TASK_TYPE_CLASSIF,ircRegistro.ADD_ITEMS_ALLOWED,ircRegistro.ADD_NET_ALLOWED,ircRegistro.COMMENT_REQUIRED,ircRegistro.WARRANTY_PERIOD,ircRegistro.CONCEPT,ircRegistro.SOLD_ENGINEERING_SER,ircRegistro.PRIORITY,ircRegistro.NODAL_CHANGE,ircRegistro.ARRANGED_HOUR_ALLOWED,ircRegistro.OBJECT_ID,ircRegistro.TASK_TYPE_GROUP_ID,ircRegistro.WORK_DAYS,ircRegistro.COMPROMISE_CRM,ircRegistro.USE_,ircRegistro.NOTIFICABLE,ircRegistro.GEN_ADMIN_ORDER,ircRegistro.UPD_ITEMS_ALLOWED,ircRegistro.PRINT_FORMAT_ID
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
        inuTASK_TYPE_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_TASK_TYPE
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
            DELETE OR_TASK_TYPE
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
 
    -- Obtiene el valor de la columna DESCRIPTION
    FUNCTION fsbObtDESCRIPTION(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.DESCRIPTION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtDESCRIPTION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
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
 
    -- Obtiene el valor de la columna SHORT_NAME
    FUNCTION fsbObtSHORT_NAME(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.SHORT_NAME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSHORT_NAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SHORT_NAME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSHORT_NAME;
 
    -- Obtiene el valor de la columna IS_ANULL
    FUNCTION fsbObtIS_ANULL(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.IS_ANULL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtIS_ANULL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_ANULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtIS_ANULL;
 
    -- Obtiene el valor de la columna TRY_AUTOM_ASSIGMENT
    FUNCTION fsbObtTRY_AUTOM_ASSIGMENT(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TRY_AUTOM_ASSIGMENT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtTRY_AUTOM_ASSIGMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TRY_AUTOM_ASSIGMENT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtTRY_AUTOM_ASSIGMENT;
 
    -- Obtiene el valor de la columna USES_OPER_SECTOR
    FUNCTION fsbObtUSES_OPER_SECTOR(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.USES_OPER_SECTOR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSES_OPER_SECTOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.USES_OPER_SECTOR;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtUSES_OPER_SECTOR;
 
    -- Obtiene el valor de la columna TASK_TYPE_CLASSIF
    FUNCTION fnuObtTASK_TYPE_CLASSIF(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TASK_TYPE_CLASSIF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTASK_TYPE_CLASSIF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TASK_TYPE_CLASSIF;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtTASK_TYPE_CLASSIF;
 
    -- Obtiene el valor de la columna ADD_ITEMS_ALLOWED
    FUNCTION fsbObtADD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ADD_ITEMS_ALLOWED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtADD_ITEMS_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADD_ITEMS_ALLOWED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtADD_ITEMS_ALLOWED;
 
    -- Obtiene el valor de la columna ADD_NET_ALLOWED
    FUNCTION fsbObtADD_NET_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ADD_NET_ALLOWED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtADD_NET_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADD_NET_ALLOWED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtADD_NET_ALLOWED;
 
    -- Obtiene el valor de la columna COMMENT_REQUIRED
    FUNCTION fsbObtCOMMENT_REQUIRED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.COMMENT_REQUIRED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCOMMENT_REQUIRED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMMENT_REQUIRED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCOMMENT_REQUIRED;
 
    -- Obtiene el valor de la columna WARRANTY_PERIOD
    FUNCTION fnuObtWARRANTY_PERIOD(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.WARRANTY_PERIOD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtWARRANTY_PERIOD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WARRANTY_PERIOD;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtWARRANTY_PERIOD;
 
    -- Obtiene el valor de la columna CONCEPT
    FUNCTION fnuObtCONCEPT(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.CONCEPT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONCEPT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONCEPT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCONCEPT;
 
    -- Obtiene el valor de la columna SOLD_ENGINEERING_SER
    FUNCTION fsbObtSOLD_ENGINEERING_SER(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.SOLD_ENGINEERING_SER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSOLD_ENGINEERING_SER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SOLD_ENGINEERING_SER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSOLD_ENGINEERING_SER;
 
    -- Obtiene el valor de la columna PRIORITY
    FUNCTION fnuObtPRIORITY(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.PRIORITY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRIORITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRIORITY;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPRIORITY;
 
    -- Obtiene el valor de la columna NODAL_CHANGE
    FUNCTION fsbObtNODAL_CHANGE(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.NODAL_CHANGE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNODAL_CHANGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NODAL_CHANGE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNODAL_CHANGE;
 
    -- Obtiene el valor de la columna ARRANGED_HOUR_ALLOWED
    FUNCTION fsbObtARRANGED_HOUR_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.ARRANGED_HOUR_ALLOWED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtARRANGED_HOUR_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ARRANGED_HOUR_ALLOWED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtARRANGED_HOUR_ALLOWED;
 
    -- Obtiene el valor de la columna OBJECT_ID
    FUNCTION fnuObtOBJECT_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.OBJECT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOBJECT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OBJECT_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOBJECT_ID;
 
    -- Obtiene el valor de la columna TASK_TYPE_GROUP_ID
    FUNCTION fnuObtTASK_TYPE_GROUP_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.TASK_TYPE_GROUP_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTASK_TYPE_GROUP_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TASK_TYPE_GROUP_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtTASK_TYPE_GROUP_ID;
 
    -- Obtiene el valor de la columna WORK_DAYS
    FUNCTION fsbObtWORK_DAYS(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.WORK_DAYS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtWORK_DAYS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WORK_DAYS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtWORK_DAYS;
 
    -- Obtiene el valor de la columna COMPROMISE_CRM
    FUNCTION fsbObtCOMPROMISE_CRM(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.COMPROMISE_CRM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCOMPROMISE_CRM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMPROMISE_CRM;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCOMPROMISE_CRM;
 
    -- Obtiene el valor de la columna USE_
    FUNCTION fsbObtUSE_(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.USE_%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUSE_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.USE_;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtUSE_;
 
    -- Obtiene el valor de la columna NOTIFICABLE
    FUNCTION fsbObtNOTIFICABLE(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.NOTIFICABLE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNOTIFICABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOTIFICABLE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNOTIFICABLE;
 
    -- Obtiene el valor de la columna GEN_ADMIN_ORDER
    FUNCTION fsbObtGEN_ADMIN_ORDER(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.GEN_ADMIN_ORDER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtGEN_ADMIN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.GEN_ADMIN_ORDER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtGEN_ADMIN_ORDER;
 
    -- Obtiene el valor de la columna UPD_ITEMS_ALLOWED
    FUNCTION fsbObtUPD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.UPD_ITEMS_ALLOWED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUPD_ITEMS_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UPD_ITEMS_ALLOWED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtUPD_ITEMS_ALLOWED;
 
    -- Obtiene el valor de la columna PRINT_FORMAT_ID
    FUNCTION fnuObtPRINT_FORMAT_ID(
        inuTASK_TYPE_ID    NUMBER
        ) RETURN OR_TASK_TYPE.PRINT_FORMAT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRINT_FORMAT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRINT_FORMAT_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPRINT_FORMAT_ID;
 
    -- Actualiza el valor de la columna DESCRIPTION
    PROCEDURE prAcDESCRIPTION(
        inuTASK_TYPE_ID    NUMBER,
        isbDESCRIPTION    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDESCRIPTION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbDESCRIPTION,'-') <> NVL(rcRegistroAct.DESCRIPTION,'-') THEN
            UPDATE OR_TASK_TYPE
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
 
    -- Actualiza el valor de la columna SHORT_NAME
    PROCEDURE prAcSHORT_NAME(
        inuTASK_TYPE_ID    NUMBER,
        isbSHORT_NAME    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSHORT_NAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbSHORT_NAME,'-') <> NVL(rcRegistroAct.SHORT_NAME,'-') THEN
            UPDATE OR_TASK_TYPE
            SET SHORT_NAME=isbSHORT_NAME
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
    END prAcSHORT_NAME;
 
    -- Actualiza el valor de la columna IS_ANULL
    PROCEDURE prAcIS_ANULL(
        inuTASK_TYPE_ID    NUMBER,
        isbIS_ANULL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_ANULL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbIS_ANULL,'-') <> NVL(rcRegistroAct.IS_ANULL,'-') THEN
            UPDATE OR_TASK_TYPE
            SET IS_ANULL=isbIS_ANULL
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
    END prAcIS_ANULL;
 
    -- Actualiza el valor de la columna TRY_AUTOM_ASSIGMENT
    PROCEDURE prAcTRY_AUTOM_ASSIGMENT(
        inuTASK_TYPE_ID    NUMBER,
        isbTRY_AUTOM_ASSIGMENT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTRY_AUTOM_ASSIGMENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbTRY_AUTOM_ASSIGMENT,'-') <> NVL(rcRegistroAct.TRY_AUTOM_ASSIGMENT,'-') THEN
            UPDATE OR_TASK_TYPE
            SET TRY_AUTOM_ASSIGMENT=isbTRY_AUTOM_ASSIGMENT
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
    END prAcTRY_AUTOM_ASSIGMENT;
 
    -- Actualiza el valor de la columna USES_OPER_SECTOR
    PROCEDURE prAcUSES_OPER_SECTOR(
        inuTASK_TYPE_ID    NUMBER,
        isbUSES_OPER_SECTOR    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSES_OPER_SECTOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbUSES_OPER_SECTOR,'-') <> NVL(rcRegistroAct.USES_OPER_SECTOR,'-') THEN
            UPDATE OR_TASK_TYPE
            SET USES_OPER_SECTOR=isbUSES_OPER_SECTOR
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
    END prAcUSES_OPER_SECTOR;
 
    -- Actualiza el valor de la columna TASK_TYPE_CLASSIF
    PROCEDURE prAcTASK_TYPE_CLASSIF(
        inuTASK_TYPE_ID    NUMBER,
        inuTASK_TYPE_CLASSIF    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_CLASSIF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuTASK_TYPE_CLASSIF,-1) <> NVL(rcRegistroAct.TASK_TYPE_CLASSIF,-1) THEN
            UPDATE OR_TASK_TYPE
            SET TASK_TYPE_CLASSIF=inuTASK_TYPE_CLASSIF
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
    END prAcTASK_TYPE_CLASSIF;
 
    -- Actualiza el valor de la columna ADD_ITEMS_ALLOWED
    PROCEDURE prAcADD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbADD_ITEMS_ALLOWED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_ITEMS_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbADD_ITEMS_ALLOWED,'-') <> NVL(rcRegistroAct.ADD_ITEMS_ALLOWED,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ADD_ITEMS_ALLOWED=isbADD_ITEMS_ALLOWED
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
    END prAcADD_ITEMS_ALLOWED;
 
    -- Actualiza el valor de la columna ADD_NET_ALLOWED
    PROCEDURE prAcADD_NET_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbADD_NET_ALLOWED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_NET_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbADD_NET_ALLOWED,'-') <> NVL(rcRegistroAct.ADD_NET_ALLOWED,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ADD_NET_ALLOWED=isbADD_NET_ALLOWED
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
    END prAcADD_NET_ALLOWED;
 
    -- Actualiza el valor de la columna COMMENT_REQUIRED
    PROCEDURE prAcCOMMENT_REQUIRED(
        inuTASK_TYPE_ID    NUMBER,
        isbCOMMENT_REQUIRED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT_REQUIRED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbCOMMENT_REQUIRED,'-') <> NVL(rcRegistroAct.COMMENT_REQUIRED,'-') THEN
            UPDATE OR_TASK_TYPE
            SET COMMENT_REQUIRED=isbCOMMENT_REQUIRED
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
    END prAcCOMMENT_REQUIRED;
 
    -- Actualiza el valor de la columna WARRANTY_PERIOD
    PROCEDURE prAcWARRANTY_PERIOD(
        inuTASK_TYPE_ID    NUMBER,
        inuWARRANTY_PERIOD    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWARRANTY_PERIOD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuWARRANTY_PERIOD,-1) <> NVL(rcRegistroAct.WARRANTY_PERIOD,-1) THEN
            UPDATE OR_TASK_TYPE
            SET WARRANTY_PERIOD=inuWARRANTY_PERIOD
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
    END prAcWARRANTY_PERIOD;
 
    -- Actualiza el valor de la columna CONCEPT
    PROCEDURE prAcCONCEPT(
        inuTASK_TYPE_ID    NUMBER,
        inuCONCEPT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONCEPT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuCONCEPT,-1) <> NVL(rcRegistroAct.CONCEPT,-1) THEN
            UPDATE OR_TASK_TYPE
            SET CONCEPT=inuCONCEPT
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
    END prAcCONCEPT;
 
    -- Actualiza el valor de la columna SOLD_ENGINEERING_SER
    PROCEDURE prAcSOLD_ENGINEERING_SER(
        inuTASK_TYPE_ID    NUMBER,
        isbSOLD_ENGINEERING_SER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSOLD_ENGINEERING_SER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbSOLD_ENGINEERING_SER,'-') <> NVL(rcRegistroAct.SOLD_ENGINEERING_SER,'-') THEN
            UPDATE OR_TASK_TYPE
            SET SOLD_ENGINEERING_SER=isbSOLD_ENGINEERING_SER
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
    END prAcSOLD_ENGINEERING_SER;
 
    -- Actualiza el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY(
        inuTASK_TYPE_ID    NUMBER,
        inuPRIORITY    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIORITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuPRIORITY,-1) <> NVL(rcRegistroAct.PRIORITY,-1) THEN
            UPDATE OR_TASK_TYPE
            SET PRIORITY=inuPRIORITY
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
    END prAcPRIORITY;
 
    -- Actualiza el valor de la columna NODAL_CHANGE
    PROCEDURE prAcNODAL_CHANGE(
        inuTASK_TYPE_ID    NUMBER,
        isbNODAL_CHANGE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNODAL_CHANGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbNODAL_CHANGE,'-') <> NVL(rcRegistroAct.NODAL_CHANGE,'-') THEN
            UPDATE OR_TASK_TYPE
            SET NODAL_CHANGE=isbNODAL_CHANGE
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
    END prAcNODAL_CHANGE;
 
    -- Actualiza el valor de la columna ARRANGED_HOUR_ALLOWED
    PROCEDURE prAcARRANGED_HOUR_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbARRANGED_HOUR_ALLOWED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARRANGED_HOUR_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbARRANGED_HOUR_ALLOWED,'-') <> NVL(rcRegistroAct.ARRANGED_HOUR_ALLOWED,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ARRANGED_HOUR_ALLOWED=isbARRANGED_HOUR_ALLOWED
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
    END prAcARRANGED_HOUR_ALLOWED;
 
    -- Actualiza el valor de la columna OBJECT_ID
    PROCEDURE prAcOBJECT_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuOBJECT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBJECT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuOBJECT_ID,-1) <> NVL(rcRegistroAct.OBJECT_ID,-1) THEN
            UPDATE OR_TASK_TYPE
            SET OBJECT_ID=inuOBJECT_ID
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
    END prAcOBJECT_ID;
 
    -- Actualiza el valor de la columna TASK_TYPE_GROUP_ID
    PROCEDURE prAcTASK_TYPE_GROUP_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuTASK_TYPE_GROUP_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_GROUP_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuTASK_TYPE_GROUP_ID,-1) <> NVL(rcRegistroAct.TASK_TYPE_GROUP_ID,-1) THEN
            UPDATE OR_TASK_TYPE
            SET TASK_TYPE_GROUP_ID=inuTASK_TYPE_GROUP_ID
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
    END prAcTASK_TYPE_GROUP_ID;
 
    -- Actualiza el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS(
        inuTASK_TYPE_ID    NUMBER,
        isbWORK_DAYS    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWORK_DAYS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbWORK_DAYS,'-') <> NVL(rcRegistroAct.WORK_DAYS,'-') THEN
            UPDATE OR_TASK_TYPE
            SET WORK_DAYS=isbWORK_DAYS
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
    END prAcWORK_DAYS;
 
    -- Actualiza el valor de la columna COMPROMISE_CRM
    PROCEDURE prAcCOMPROMISE_CRM(
        inuTASK_TYPE_ID    NUMBER,
        isbCOMPROMISE_CRM    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPROMISE_CRM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbCOMPROMISE_CRM,'-') <> NVL(rcRegistroAct.COMPROMISE_CRM,'-') THEN
            UPDATE OR_TASK_TYPE
            SET COMPROMISE_CRM=isbCOMPROMISE_CRM
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
    END prAcCOMPROMISE_CRM;
 
    -- Actualiza el valor de la columna USE_
    PROCEDURE prAcUSE_(
        inuTASK_TYPE_ID    NUMBER,
        isbUSE_    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSE_';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbUSE_,'-') <> NVL(rcRegistroAct.USE_,'-') THEN
            UPDATE OR_TASK_TYPE
            SET USE_=isbUSE_
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
    END prAcUSE_;
 
    -- Actualiza el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE(
        inuTASK_TYPE_ID    NUMBER,
        isbNOTIFICABLE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbNOTIFICABLE,'-') <> NVL(rcRegistroAct.NOTIFICABLE,'-') THEN
            UPDATE OR_TASK_TYPE
            SET NOTIFICABLE=isbNOTIFICABLE
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
    END prAcNOTIFICABLE;
 
    -- Actualiza el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER(
        inuTASK_TYPE_ID    NUMBER,
        isbGEN_ADMIN_ORDER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEN_ADMIN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbGEN_ADMIN_ORDER,'-') <> NVL(rcRegistroAct.GEN_ADMIN_ORDER,'-') THEN
            UPDATE OR_TASK_TYPE
            SET GEN_ADMIN_ORDER=isbGEN_ADMIN_ORDER
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
    END prAcGEN_ADMIN_ORDER;
 
    -- Actualiza el valor de la columna UPD_ITEMS_ALLOWED
    PROCEDURE prAcUPD_ITEMS_ALLOWED(
        inuTASK_TYPE_ID    NUMBER,
        isbUPD_ITEMS_ALLOWED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUPD_ITEMS_ALLOWED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(isbUPD_ITEMS_ALLOWED,'-') <> NVL(rcRegistroAct.UPD_ITEMS_ALLOWED,'-') THEN
            UPDATE OR_TASK_TYPE
            SET UPD_ITEMS_ALLOWED=isbUPD_ITEMS_ALLOWED
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
    END prAcUPD_ITEMS_ALLOWED;
 
    -- Actualiza el valor de la columna PRINT_FORMAT_ID
    PROCEDURE prAcPRINT_FORMAT_ID(
        inuTASK_TYPE_ID    NUMBER,
        inuPRINT_FORMAT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRINT_FORMAT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID,TRUE);
        IF NVL(inuPRINT_FORMAT_ID,-1) <> NVL(rcRegistroAct.PRINT_FORMAT_ID,-1) THEN
            UPDATE OR_TASK_TYPE
            SET PRINT_FORMAT_ID=inuPRINT_FORMAT_ID
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
    END prAcPRINT_FORMAT_ID;
 
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
            UPDATE OR_TASK_TYPE
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
 
    -- Actualiza por RowId el valor de la columna SHORT_NAME
    PROCEDURE prAcSHORT_NAME_RId(
        iRowId ROWID,
        isbSHORT_NAME_O    VARCHAR2,
        isbSHORT_NAME_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSHORT_NAME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSHORT_NAME_O,'-') <> NVL(isbSHORT_NAME_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET SHORT_NAME=isbSHORT_NAME_N
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
    END prAcSHORT_NAME_RId;
 
    -- Actualiza por RowId el valor de la columna IS_ANULL
    PROCEDURE prAcIS_ANULL_RId(
        iRowId ROWID,
        isbIS_ANULL_O    VARCHAR2,
        isbIS_ANULL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_ANULL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_ANULL_O,'-') <> NVL(isbIS_ANULL_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET IS_ANULL=isbIS_ANULL_N
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
    END prAcIS_ANULL_RId;
 
    -- Actualiza por RowId el valor de la columna TRY_AUTOM_ASSIGMENT
    PROCEDURE prAcTRY_AUTOM_ASSIGMENT_RId(
        iRowId ROWID,
        isbTRY_AUTOM_ASSIGMENT_O    VARCHAR2,
        isbTRY_AUTOM_ASSIGMENT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTRY_AUTOM_ASSIGMENT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbTRY_AUTOM_ASSIGMENT_O,'-') <> NVL(isbTRY_AUTOM_ASSIGMENT_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET TRY_AUTOM_ASSIGMENT=isbTRY_AUTOM_ASSIGMENT_N
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
    END prAcTRY_AUTOM_ASSIGMENT_RId;
 
    -- Actualiza por RowId el valor de la columna USES_OPER_SECTOR
    PROCEDURE prAcUSES_OPER_SECTOR_RId(
        iRowId ROWID,
        isbUSES_OPER_SECTOR_O    VARCHAR2,
        isbUSES_OPER_SECTOR_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSES_OPER_SECTOR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUSES_OPER_SECTOR_O,'-') <> NVL(isbUSES_OPER_SECTOR_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET USES_OPER_SECTOR=isbUSES_OPER_SECTOR_N
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
    END prAcUSES_OPER_SECTOR_RId;
 
    -- Actualiza por RowId el valor de la columna TASK_TYPE_CLASSIF
    PROCEDURE prAcTASK_TYPE_CLASSIF_RId(
        iRowId ROWID,
        inuTASK_TYPE_CLASSIF_O    NUMBER,
        inuTASK_TYPE_CLASSIF_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_CLASSIF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTASK_TYPE_CLASSIF_O,-1) <> NVL(inuTASK_TYPE_CLASSIF_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET TASK_TYPE_CLASSIF=inuTASK_TYPE_CLASSIF_N
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
    END prAcTASK_TYPE_CLASSIF_RId;
 
    -- Actualiza por RowId el valor de la columna ADD_ITEMS_ALLOWED
    PROCEDURE prAcADD_ITEMS_ALLOWED_RId(
        iRowId ROWID,
        isbADD_ITEMS_ALLOWED_O    VARCHAR2,
        isbADD_ITEMS_ALLOWED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_ITEMS_ALLOWED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbADD_ITEMS_ALLOWED_O,'-') <> NVL(isbADD_ITEMS_ALLOWED_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ADD_ITEMS_ALLOWED=isbADD_ITEMS_ALLOWED_N
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
    END prAcADD_ITEMS_ALLOWED_RId;
 
    -- Actualiza por RowId el valor de la columna ADD_NET_ALLOWED
    PROCEDURE prAcADD_NET_ALLOWED_RId(
        iRowId ROWID,
        isbADD_NET_ALLOWED_O    VARCHAR2,
        isbADD_NET_ALLOWED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_NET_ALLOWED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbADD_NET_ALLOWED_O,'-') <> NVL(isbADD_NET_ALLOWED_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ADD_NET_ALLOWED=isbADD_NET_ALLOWED_N
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
    END prAcADD_NET_ALLOWED_RId;
 
    -- Actualiza por RowId el valor de la columna COMMENT_REQUIRED
    PROCEDURE prAcCOMMENT_REQUIRED_RId(
        iRowId ROWID,
        isbCOMMENT_REQUIRED_O    VARCHAR2,
        isbCOMMENT_REQUIRED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMMENT_REQUIRED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOMMENT_REQUIRED_O,'-') <> NVL(isbCOMMENT_REQUIRED_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET COMMENT_REQUIRED=isbCOMMENT_REQUIRED_N
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
    END prAcCOMMENT_REQUIRED_RId;
 
    -- Actualiza por RowId el valor de la columna WARRANTY_PERIOD
    PROCEDURE prAcWARRANTY_PERIOD_RId(
        iRowId ROWID,
        inuWARRANTY_PERIOD_O    NUMBER,
        inuWARRANTY_PERIOD_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWARRANTY_PERIOD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuWARRANTY_PERIOD_O,-1) <> NVL(inuWARRANTY_PERIOD_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET WARRANTY_PERIOD=inuWARRANTY_PERIOD_N
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
    END prAcWARRANTY_PERIOD_RId;
 
    -- Actualiza por RowId el valor de la columna CONCEPT
    PROCEDURE prAcCONCEPT_RId(
        iRowId ROWID,
        inuCONCEPT_O    NUMBER,
        inuCONCEPT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONCEPT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONCEPT_O,-1) <> NVL(inuCONCEPT_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET CONCEPT=inuCONCEPT_N
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
    END prAcCONCEPT_RId;
 
    -- Actualiza por RowId el valor de la columna SOLD_ENGINEERING_SER
    PROCEDURE prAcSOLD_ENGINEERING_SER_RId(
        iRowId ROWID,
        isbSOLD_ENGINEERING_SER_O    VARCHAR2,
        isbSOLD_ENGINEERING_SER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSOLD_ENGINEERING_SER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSOLD_ENGINEERING_SER_O,'-') <> NVL(isbSOLD_ENGINEERING_SER_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET SOLD_ENGINEERING_SER=isbSOLD_ENGINEERING_SER_N
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
    END prAcSOLD_ENGINEERING_SER_RId;
 
    -- Actualiza por RowId el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY_RId(
        iRowId ROWID,
        inuPRIORITY_O    NUMBER,
        inuPRIORITY_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIORITY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRIORITY_O,-1) <> NVL(inuPRIORITY_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET PRIORITY=inuPRIORITY_N
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
    END prAcPRIORITY_RId;
 
    -- Actualiza por RowId el valor de la columna NODAL_CHANGE
    PROCEDURE prAcNODAL_CHANGE_RId(
        iRowId ROWID,
        isbNODAL_CHANGE_O    VARCHAR2,
        isbNODAL_CHANGE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNODAL_CHANGE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNODAL_CHANGE_O,'-') <> NVL(isbNODAL_CHANGE_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET NODAL_CHANGE=isbNODAL_CHANGE_N
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
    END prAcNODAL_CHANGE_RId;
 
    -- Actualiza por RowId el valor de la columna ARRANGED_HOUR_ALLOWED
    PROCEDURE prAcARRANGED_HOUR_ALLOWED_RId(
        iRowId ROWID,
        isbARRANGED_HOUR_ALLOWED_O    VARCHAR2,
        isbARRANGED_HOUR_ALLOWED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARRANGED_HOUR_ALLOWED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbARRANGED_HOUR_ALLOWED_O,'-') <> NVL(isbARRANGED_HOUR_ALLOWED_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET ARRANGED_HOUR_ALLOWED=isbARRANGED_HOUR_ALLOWED_N
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
    END prAcARRANGED_HOUR_ALLOWED_RId;
 
    -- Actualiza por RowId el valor de la columna OBJECT_ID
    PROCEDURE prAcOBJECT_ID_RId(
        iRowId ROWID,
        inuOBJECT_ID_O    NUMBER,
        inuOBJECT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBJECT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOBJECT_ID_O,-1) <> NVL(inuOBJECT_ID_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET OBJECT_ID=inuOBJECT_ID_N
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
    END prAcOBJECT_ID_RId;
 
    -- Actualiza por RowId el valor de la columna TASK_TYPE_GROUP_ID
    PROCEDURE prAcTASK_TYPE_GROUP_ID_RId(
        iRowId ROWID,
        inuTASK_TYPE_GROUP_ID_O    NUMBER,
        inuTASK_TYPE_GROUP_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_GROUP_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTASK_TYPE_GROUP_ID_O,-1) <> NVL(inuTASK_TYPE_GROUP_ID_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET TASK_TYPE_GROUP_ID=inuTASK_TYPE_GROUP_ID_N
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
    END prAcTASK_TYPE_GROUP_ID_RId;
 
    -- Actualiza por RowId el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS_RId(
        iRowId ROWID,
        isbWORK_DAYS_O    VARCHAR2,
        isbWORK_DAYS_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWORK_DAYS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbWORK_DAYS_O,'-') <> NVL(isbWORK_DAYS_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET WORK_DAYS=isbWORK_DAYS_N
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
    END prAcWORK_DAYS_RId;
 
    -- Actualiza por RowId el valor de la columna COMPROMISE_CRM
    PROCEDURE prAcCOMPROMISE_CRM_RId(
        iRowId ROWID,
        isbCOMPROMISE_CRM_O    VARCHAR2,
        isbCOMPROMISE_CRM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPROMISE_CRM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCOMPROMISE_CRM_O,'-') <> NVL(isbCOMPROMISE_CRM_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET COMPROMISE_CRM=isbCOMPROMISE_CRM_N
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
    END prAcCOMPROMISE_CRM_RId;
 
    -- Actualiza por RowId el valor de la columna USE_
    PROCEDURE prAcUSE__RId(
        iRowId ROWID,
        isbUSE__O    VARCHAR2,
        isbUSE__N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSE__RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUSE__O,'-') <> NVL(isbUSE__N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET USE_=isbUSE__N
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
    END prAcUSE__RId;
 
    -- Actualiza por RowId el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE_RId(
        iRowId ROWID,
        isbNOTIFICABLE_O    VARCHAR2,
        isbNOTIFICABLE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICABLE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNOTIFICABLE_O,'-') <> NVL(isbNOTIFICABLE_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET NOTIFICABLE=isbNOTIFICABLE_N
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
    END prAcNOTIFICABLE_RId;
 
    -- Actualiza por RowId el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER_RId(
        iRowId ROWID,
        isbGEN_ADMIN_ORDER_O    VARCHAR2,
        isbGEN_ADMIN_ORDER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEN_ADMIN_ORDER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbGEN_ADMIN_ORDER_O,'-') <> NVL(isbGEN_ADMIN_ORDER_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET GEN_ADMIN_ORDER=isbGEN_ADMIN_ORDER_N
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
    END prAcGEN_ADMIN_ORDER_RId;
 
    -- Actualiza por RowId el valor de la columna UPD_ITEMS_ALLOWED
    PROCEDURE prAcUPD_ITEMS_ALLOWED_RId(
        iRowId ROWID,
        isbUPD_ITEMS_ALLOWED_O    VARCHAR2,
        isbUPD_ITEMS_ALLOWED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUPD_ITEMS_ALLOWED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUPD_ITEMS_ALLOWED_O,'-') <> NVL(isbUPD_ITEMS_ALLOWED_N,'-') THEN
            UPDATE OR_TASK_TYPE
            SET UPD_ITEMS_ALLOWED=isbUPD_ITEMS_ALLOWED_N
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
    END prAcUPD_ITEMS_ALLOWED_RId;
 
    -- Actualiza por RowId el valor de la columna PRINT_FORMAT_ID
    PROCEDURE prAcPRINT_FORMAT_ID_RId(
        iRowId ROWID,
        inuPRINT_FORMAT_ID_O    NUMBER,
        inuPRINT_FORMAT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRINT_FORMAT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRINT_FORMAT_ID_O,-1) <> NVL(inuPRINT_FORMAT_ID_N,-1) THEN
            UPDATE OR_TASK_TYPE
            SET PRINT_FORMAT_ID=inuPRINT_FORMAT_ID_N
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
    END prAcPRINT_FORMAT_ID_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_TASK_TYPE%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.TASK_TYPE_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcDESCRIPTION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DESCRIPTION,
                ircRegistro.DESCRIPTION
            );
 
            prAcSHORT_NAME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SHORT_NAME,
                ircRegistro.SHORT_NAME
            );
 
            prAcIS_ANULL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_ANULL,
                ircRegistro.IS_ANULL
            );
 
            prAcTRY_AUTOM_ASSIGMENT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TRY_AUTOM_ASSIGMENT,
                ircRegistro.TRY_AUTOM_ASSIGMENT
            );
 
            prAcUSES_OPER_SECTOR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USES_OPER_SECTOR,
                ircRegistro.USES_OPER_SECTOR
            );
 
            prAcTASK_TYPE_CLASSIF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TASK_TYPE_CLASSIF,
                ircRegistro.TASK_TYPE_CLASSIF
            );
 
            prAcADD_ITEMS_ALLOWED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADD_ITEMS_ALLOWED,
                ircRegistro.ADD_ITEMS_ALLOWED
            );
 
            prAcADD_NET_ALLOWED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADD_NET_ALLOWED,
                ircRegistro.ADD_NET_ALLOWED
            );
 
            prAcCOMMENT_REQUIRED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMMENT_REQUIRED,
                ircRegistro.COMMENT_REQUIRED
            );
 
            prAcWARRANTY_PERIOD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WARRANTY_PERIOD,
                ircRegistro.WARRANTY_PERIOD
            );
 
            prAcCONCEPT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONCEPT,
                ircRegistro.CONCEPT
            );
 
            prAcSOLD_ENGINEERING_SER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SOLD_ENGINEERING_SER,
                ircRegistro.SOLD_ENGINEERING_SER
            );
 
            prAcPRIORITY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRIORITY,
                ircRegistro.PRIORITY
            );
 
            prAcNODAL_CHANGE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NODAL_CHANGE,
                ircRegistro.NODAL_CHANGE
            );
 
            prAcARRANGED_HOUR_ALLOWED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ARRANGED_HOUR_ALLOWED,
                ircRegistro.ARRANGED_HOUR_ALLOWED
            );
 
            prAcOBJECT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OBJECT_ID,
                ircRegistro.OBJECT_ID
            );
 
            prAcTASK_TYPE_GROUP_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TASK_TYPE_GROUP_ID,
                ircRegistro.TASK_TYPE_GROUP_ID
            );
 
            prAcWORK_DAYS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WORK_DAYS,
                ircRegistro.WORK_DAYS
            );
 
            prAcCOMPROMISE_CRM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPROMISE_CRM,
                ircRegistro.COMPROMISE_CRM
            );
 
            prAcUSE__RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USE_,
                ircRegistro.USE_
            );
 
            prAcNOTIFICABLE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOTIFICABLE,
                ircRegistro.NOTIFICABLE
            );
 
            prAcGEN_ADMIN_ORDER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.GEN_ADMIN_ORDER,
                ircRegistro.GEN_ADMIN_ORDER
            );
 
            prAcUPD_ITEMS_ALLOWED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UPD_ITEMS_ALLOWED,
                ircRegistro.UPD_ITEMS_ALLOWED
            );
 
            prAcPRINT_FORMAT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRINT_FORMAT_ID,
                ircRegistro.PRINT_FORMAT_ID
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
 
END pkg_or_task_type;
/
BEGIN
    
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_or_task_type'), UPPER('adm_person'));
END;
/
