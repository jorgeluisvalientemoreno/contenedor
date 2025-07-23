CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_CERTIFICADOS_OIA AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_CERTIFICADOS_OIA%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_CERTIFICADOS_OIA IS SELECT * FROM LDC_CERTIFICADOS_OIA;
    CURSOR cuRegistro(inuCERTIFICADOS_OIA_ID    NUMBER)  IS SELECT * FROM LDC_CERTIFICADOS_OIA WHERE CERTIFICADOS_OIA_ID =  inuCERTIFICADOS_OIA_ID;    
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_CERTIFICADOS_OIA
        Caso  : OSF-3828
        Fecha : 08/01/2025 10:36:15
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuCERTIFICADOS_OIA_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_CERTIFICADOS_OIA tb
        WHERE
        CERTIFICADOS_OIA_ID = inuCERTIFICADOS_OIA_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuCERTIFICADOS_OIA_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_CERTIFICADOS_OIA tb
        WHERE
        CERTIFICADOS_OIA_ID = inuCERTIFICADOS_OIA_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuCERTIFICADOS_OIA_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuCERTIFICADOS_OIA_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_CERTIFICADOS_OIA%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCERTIFICADOS_OIA_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna ID_CONTRATO
    FUNCTION fnuObtID_CONTRATO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_CONTRATO%TYPE;
 
    -- Obtiene el valor de la columna ID_PRODUCTO
    FUNCTION fnuObtID_PRODUCTO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_PRODUCTO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_INSPECCION
    FUNCTION fdtObtFECHA_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_INSPECCION%TYPE;
 
    -- Obtiene el valor de la columna TIPO_INSPECCION
    FUNCTION fnuObtTIPO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%TYPE;
 
    -- Obtiene el valor de la columna CERTIFICADO
    FUNCTION fsbObtCERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE;
 
    -- Obtiene el valor de la columna ID_ORGANISMO_OIA
    FUNCTION fnuObtID_ORGANISMO_OIA(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE;
 
    -- Obtiene el valor de la columna ID_INSPECTOR
    FUNCTION fnuObtID_INSPECTOR(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_INSPECTOR%TYPE;
 
    -- Obtiene el valor de la columna RESULTADO_INSPECCION
    FUNCTION fnuObtRESULTADO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%TYPE;
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.PACKAGE_ID%TYPE;
 
    -- Obtiene el valor de la columna RED_INDIVIDUAL
    FUNCTION fsbObtRED_INDIVIDUAL(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.RED_INDIVIDUAL%TYPE;
 
    -- Obtiene el valor de la columna STATUS_CERTIFICADO
    FUNCTION fsbObtSTATUS_CERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_REGISTRO
    FUNCTION fdtObtFECHA_REGISTRO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_REGISTRO%TYPE;
 
    -- Obtiene el valor de la columna OBSER_RECHAZO
    FUNCTION fsbObtOBSER_RECHAZO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.OBSER_RECHAZO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_APROBACION
    FUNCTION fdtObtFECHA_APROBACION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_APROBACION%TYPE;
 
    -- Obtiene el valor de la columna FECHA_ARCHIVO
    FUNCTION fdtObtFECHA_ARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_ARCHIVO%TYPE;
 
    -- Obtiene el valor de la columna ARCHIVO
    FUNCTION fsbObtARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ARCHIVO%TYPE;
 
    -- Obtiene el valor de la columna URL
    FUNCTION fsbObtURL(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.URL%TYPE;
 
    -- Obtiene el valor de la columna ORDER_ID
    FUNCTION fnuObtORDER_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ORDER_ID%TYPE;
 
    -- Obtiene el valor de la columna ORGANISMO_ID
    FUNCTION fnuObtORGANISMO_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ORGANISMO_ID%TYPE;
 
    -- Obtiene el valor de la columna VACIOINTERNO
    FUNCTION fsbObtVACIOINTERNO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.VACIOINTERNO%TYPE;
 
    -- Obtiene el valor de la columna FECHA_REG_OSF
    FUNCTION fdtObtFECHA_REG_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_REG_OSF%TYPE;
 
    -- Obtiene el valor de la columna FECHA_APRO_OSF
    FUNCTION fdtObtFECHA_APRO_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_APRO_OSF%TYPE;
 
    -- Actualiza el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_CONTRATO    NUMBER
    );
 
    -- Actualiza el valor de la columna ID_PRODUCTO
    PROCEDURE prAcID_PRODUCTO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_PRODUCTO    NUMBER
    );
 
    -- Actualiza el valor de la columna FECHA_INSPECCION
    PROCEDURE prAcFECHA_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_INSPECCION    DATE
    );
 
    -- Actualiza el valor de la columna TIPO_INSPECCION
    PROCEDURE prAcTIPO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuTIPO_INSPECCION    NUMBER
    );
 
    -- Actualiza el valor de la columna CERTIFICADO
    PROCEDURE prAcCERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbCERTIFICADO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ID_ORGANISMO_OIA
    PROCEDURE prAcID_ORGANISMO_OIA(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_ORGANISMO_OIA    NUMBER
    );
 
    -- Actualiza el valor de la columna ID_INSPECTOR
    PROCEDURE prAcID_INSPECTOR(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_INSPECTOR    NUMBER
    );
 
    -- Actualiza el valor de la columna RESULTADO_INSPECCION
    PROCEDURE prAcRESULTADO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuRESULTADO_INSPECCION    NUMBER
    );
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna RED_INDIVIDUAL
    PROCEDURE prAcRED_INDIVIDUAL(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbRED_INDIVIDUAL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna STATUS_CERTIFICADO
    PROCEDURE prAcSTATUS_CERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbSTATUS_CERTIFICADO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_REGISTRO
    PROCEDURE prAcFECHA_REGISTRO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_REGISTRO    DATE
    );
 
    -- Actualiza el valor de la columna OBSER_RECHAZO
    PROCEDURE prAcOBSER_RECHAZO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbOBSER_RECHAZO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_APROBACION
    PROCEDURE prAcFECHA_APROBACION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_APROBACION    DATE
    );
 
    -- Actualiza el valor de la columna FECHA_ARCHIVO
    PROCEDURE prAcFECHA_ARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_ARCHIVO    DATE
    );
 
    -- Actualiza el valor de la columna ARCHIVO
    PROCEDURE prAcARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbARCHIVO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna URL
    PROCEDURE prAcURL(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbURL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuORDER_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ORGANISMO_ID
    PROCEDURE prAcORGANISMO_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuORGANISMO_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbVACIOINTERNO    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FECHA_REG_OSF
    PROCEDURE prAcFECHA_REG_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_REG_OSF    DATE
    );
 
    -- Actualiza el valor de la columna FECHA_APRO_OSF
    PROCEDURE prAcFECHA_APRO_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_APRO_OSF    DATE
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_CERTIFICADOS_OIA%ROWTYPE);

    -- Obtiene el registro
    FUNCTION frcObtRegistro(
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) RETURN cuRegistro%ROWTYPE;
 
    -- Obtiene el ultimo certificado aprobado
    FUNCTION fnuObtUltCertificado( inuCERTIFICADOS_OIA_ID NUMBER ) RETURN NUMBER;
    
END pkg_LDC_CERTIFICADOS_OIA;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_CERTIFICADOS_OIA AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuCERTIFICADOS_OIA_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCERTIFICADOS_OIA_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCERTIFICADOS_OIA_ID);
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
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.CERTIFICADOS_OIA_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuCERTIFICADOS_OIA_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuCERTIFICADOS_OIA_ID||'] en la tabla[LDC_CERTIFICADOS_OIA]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
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
    PROCEDURE prInsRegistro( ircRegistro cuLDC_CERTIFICADOS_OIA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_CERTIFICADOS_OIA(
            CERTIFICADOS_OIA_ID,ID_CONTRATO,ID_PRODUCTO,FECHA_INSPECCION,TIPO_INSPECCION,CERTIFICADO,ID_ORGANISMO_OIA,ID_INSPECTOR,RESULTADO_INSPECCION,PACKAGE_ID,RED_INDIVIDUAL,STATUS_CERTIFICADO,FECHA_REGISTRO,OBSER_RECHAZO,FECHA_APROBACION,FECHA_ARCHIVO,ARCHIVO,URL,ORDER_ID,ORGANISMO_ID,VACIOINTERNO,FECHA_REG_OSF,FECHA_APRO_OSF
        )
        VALUES (
            ircRegistro.CERTIFICADOS_OIA_ID,ircRegistro.ID_CONTRATO,ircRegistro.ID_PRODUCTO,ircRegistro.FECHA_INSPECCION,ircRegistro.TIPO_INSPECCION,ircRegistro.CERTIFICADO,ircRegistro.ID_ORGANISMO_OIA,ircRegistro.ID_INSPECTOR,ircRegistro.RESULTADO_INSPECCION,ircRegistro.PACKAGE_ID,ircRegistro.RED_INDIVIDUAL,ircRegistro.STATUS_CERTIFICADO,ircRegistro.FECHA_REGISTRO,ircRegistro.OBSER_RECHAZO,ircRegistro.FECHA_APROBACION,ircRegistro.FECHA_ARCHIVO,ircRegistro.ARCHIVO,ircRegistro.URL,ircRegistro.ORDER_ID,ircRegistro.ORGANISMO_ID,ircRegistro.VACIOINTERNO,ircRegistro.FECHA_REG_OSF,ircRegistro.FECHA_APRO_OSF
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
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_CERTIFICADOS_OIA
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
            DELETE LDC_CERTIFICADOS_OIA
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
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_CONTRATO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
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
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_PRODUCTO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_PRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
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
 
    -- Obtiene el valor de la columna FECHA_INSPECCION
    FUNCTION fdtObtFECHA_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_INSPECCION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_INSPECCION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_INSPECCION;
 
    -- Obtiene el valor de la columna TIPO_INSPECCION
    FUNCTION fnuObtTIPO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtTIPO_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.TIPO_INSPECCION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtTIPO_INSPECCION;
 
    -- Obtiene el valor de la columna CERTIFICADO
    FUNCTION fsbObtCERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCERTIFICADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CERTIFICADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtCERTIFICADO;
 
    -- Obtiene el valor de la columna ID_ORGANISMO_OIA
    FUNCTION fnuObtID_ORGANISMO_OIA(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_ORGANISMO_OIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_ORGANISMO_OIA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_ORGANISMO_OIA;
 
    -- Obtiene el valor de la columna ID_INSPECTOR
    FUNCTION fnuObtID_INSPECTOR(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ID_INSPECTOR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtID_INSPECTOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ID_INSPECTOR;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtID_INSPECTOR;
 
    -- Obtiene el valor de la columna RESULTADO_INSPECCION
    FUNCTION fnuObtRESULTADO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtRESULTADO_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RESULTADO_INSPECCION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtRESULTADO_INSPECCION;
 
    -- Obtiene el valor de la columna PACKAGE_ID
    FUNCTION fnuObtPACKAGE_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.PACKAGE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PACKAGE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPACKAGE_ID;
 
    -- Obtiene el valor de la columna RED_INDIVIDUAL
    FUNCTION fsbObtRED_INDIVIDUAL(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.RED_INDIVIDUAL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtRED_INDIVIDUAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RED_INDIVIDUAL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtRED_INDIVIDUAL;
 
    -- Obtiene el valor de la columna STATUS_CERTIFICADO
    FUNCTION fsbObtSTATUS_CERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSTATUS_CERTIFICADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.STATUS_CERTIFICADO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtSTATUS_CERTIFICADO;
 
    -- Obtiene el valor de la columna FECHA_REGISTRO
    FUNCTION fdtObtFECHA_REGISTRO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_REGISTRO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_REGISTRO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_REGISTRO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_REGISTRO;
 
    -- Obtiene el valor de la columna OBSER_RECHAZO
    FUNCTION fsbObtOBSER_RECHAZO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.OBSER_RECHAZO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOBSER_RECHAZO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OBSER_RECHAZO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtOBSER_RECHAZO;
 
    -- Obtiene el valor de la columna FECHA_APROBACION
    FUNCTION fdtObtFECHA_APROBACION(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_APROBACION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_APROBACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_APROBACION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_APROBACION;
 
    -- Obtiene el valor de la columna FECHA_ARCHIVO
    FUNCTION fdtObtFECHA_ARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_ARCHIVO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_ARCHIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_ARCHIVO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_ARCHIVO;
 
    -- Obtiene el valor de la columna ARCHIVO
    FUNCTION fsbObtARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ARCHIVO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtARCHIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ARCHIVO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtARCHIVO;
 
    -- Obtiene el valor de la columna URL
    FUNCTION fsbObtURL(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.URL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtURL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.URL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtURL;
 
    -- Obtiene el valor de la columna ORDER_ID
    FUNCTION fnuObtORDER_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ORDER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtORDER_ID;
 
    -- Obtiene el valor de la columna ORGANISMO_ID
    FUNCTION fnuObtORGANISMO_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.ORGANISMO_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORGANISMO_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORGANISMO_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtORGANISMO_ID;
 
    -- Obtiene el valor de la columna VACIOINTERNO
    FUNCTION fsbObtVACIOINTERNO(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.VACIOINTERNO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtVACIOINTERNO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
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
 
    -- Obtiene el valor de la columna FECHA_REG_OSF
    FUNCTION fdtObtFECHA_REG_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_REG_OSF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_REG_OSF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_REG_OSF;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_REG_OSF;
 
    -- Obtiene el valor de la columna FECHA_APRO_OSF
    FUNCTION fdtObtFECHA_APRO_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER
        ) RETURN LDC_CERTIFICADOS_OIA.FECHA_APRO_OSF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_APRO_OSF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_APRO_OSF;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_APRO_OSF;
 
    -- Actualiza el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_CONTRATO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONTRATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuID_CONTRATO,-1) <> NVL(rcRegistroAct.ID_CONTRATO,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_PRODUCTO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_PRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuID_PRODUCTO,-1) <> NVL(rcRegistroAct.ID_PRODUCTO,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
 
    -- Actualiza el valor de la columna FECHA_INSPECCION
    PROCEDURE prAcFECHA_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_INSPECCION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_INSPECCION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_INSPECCION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_INSPECCION=idtFECHA_INSPECCION
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
    END prAcFECHA_INSPECCION;
 
    -- Actualiza el valor de la columna TIPO_INSPECCION
    PROCEDURE prAcTIPO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuTIPO_INSPECCION    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTIPO_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuTIPO_INSPECCION,-1) <> NVL(rcRegistroAct.TIPO_INSPECCION,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET TIPO_INSPECCION=inuTIPO_INSPECCION
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
    END prAcTIPO_INSPECCION;
 
    -- Actualiza el valor de la columna CERTIFICADO
    PROCEDURE prAcCERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbCERTIFICADO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCERTIFICADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbCERTIFICADO,'-') <> NVL(rcRegistroAct.CERTIFICADO,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET CERTIFICADO=isbCERTIFICADO
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
    END prAcCERTIFICADO;
 
    -- Actualiza el valor de la columna ID_ORGANISMO_OIA
    PROCEDURE prAcID_ORGANISMO_OIA(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_ORGANISMO_OIA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_ORGANISMO_OIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuID_ORGANISMO_OIA,-1) <> NVL(rcRegistroAct.ID_ORGANISMO_OIA,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ID_ORGANISMO_OIA=inuID_ORGANISMO_OIA
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
    END prAcID_ORGANISMO_OIA;
 
    -- Actualiza el valor de la columna ID_INSPECTOR
    PROCEDURE prAcID_INSPECTOR(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuID_INSPECTOR    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_INSPECTOR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuID_INSPECTOR,-1) <> NVL(rcRegistroAct.ID_INSPECTOR,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ID_INSPECTOR=inuID_INSPECTOR
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
    END prAcID_INSPECTOR;
 
    -- Actualiza el valor de la columna RESULTADO_INSPECCION
    PROCEDURE prAcRESULTADO_INSPECCION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuRESULTADO_INSPECCION    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRESULTADO_INSPECCION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuRESULTADO_INSPECCION,-1) <> NVL(rcRegistroAct.RESULTADO_INSPECCION,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET RESULTADO_INSPECCION=inuRESULTADO_INSPECCION
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
    END prAcRESULTADO_INSPECCION;
 
    -- Actualiza el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuPACKAGE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuPACKAGE_ID,-1) <> NVL(rcRegistroAct.PACKAGE_ID,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET PACKAGE_ID=inuPACKAGE_ID
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
    END prAcPACKAGE_ID;
 
    -- Actualiza el valor de la columna RED_INDIVIDUAL
    PROCEDURE prAcRED_INDIVIDUAL(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbRED_INDIVIDUAL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRED_INDIVIDUAL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbRED_INDIVIDUAL,'-') <> NVL(rcRegistroAct.RED_INDIVIDUAL,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET RED_INDIVIDUAL=isbRED_INDIVIDUAL
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
    END prAcRED_INDIVIDUAL;
 
    -- Actualiza el valor de la columna STATUS_CERTIFICADO
    PROCEDURE prAcSTATUS_CERTIFICADO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbSTATUS_CERTIFICADO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTATUS_CERTIFICADO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbSTATUS_CERTIFICADO,'-') <> NVL(rcRegistroAct.STATUS_CERTIFICADO,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET STATUS_CERTIFICADO=isbSTATUS_CERTIFICADO
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
    END prAcSTATUS_CERTIFICADO;
 
    -- Actualiza el valor de la columna FECHA_REGISTRO
    PROCEDURE prAcFECHA_REGISTRO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_REGISTRO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REGISTRO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_REGISTRO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_REGISTRO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_REGISTRO=idtFECHA_REGISTRO
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
    END prAcFECHA_REGISTRO;
 
    -- Actualiza el valor de la columna OBSER_RECHAZO
    PROCEDURE prAcOBSER_RECHAZO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbOBSER_RECHAZO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBSER_RECHAZO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbOBSER_RECHAZO,'-') <> NVL(rcRegistroAct.OBSER_RECHAZO,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET OBSER_RECHAZO=isbOBSER_RECHAZO
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
    END prAcOBSER_RECHAZO;
 
    -- Actualiza el valor de la columna FECHA_APROBACION
    PROCEDURE prAcFECHA_APROBACION(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_APROBACION    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_APROBACION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_APROBACION,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_APROBACION,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_APROBACION=idtFECHA_APROBACION
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
    END prAcFECHA_APROBACION;
 
    -- Actualiza el valor de la columna FECHA_ARCHIVO
    PROCEDURE prAcFECHA_ARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_ARCHIVO    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_ARCHIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_ARCHIVO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_ARCHIVO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_ARCHIVO=idtFECHA_ARCHIVO
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
    END prAcFECHA_ARCHIVO;
 
    -- Actualiza el valor de la columna ARCHIVO
    PROCEDURE prAcARCHIVO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbARCHIVO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARCHIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbARCHIVO,'-') <> NVL(rcRegistroAct.ARCHIVO,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ARCHIVO=isbARCHIVO
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
    END prAcARCHIVO;
 
    -- Actualiza el valor de la columna URL
    PROCEDURE prAcURL(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbURL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcURL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbURL,'-') <> NVL(rcRegistroAct.URL,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET URL=isbURL
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
    END prAcURL;
 
    -- Actualiza el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuORDER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuORDER_ID,-1) <> NVL(rcRegistroAct.ORDER_ID,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ORDER_ID=inuORDER_ID
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
    END prAcORDER_ID;
 
    -- Actualiza el valor de la columna ORGANISMO_ID
    PROCEDURE prAcORGANISMO_ID(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        inuORGANISMO_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORGANISMO_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(inuORGANISMO_ID,-1) <> NVL(rcRegistroAct.ORGANISMO_ID,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ORGANISMO_ID=inuORGANISMO_ID
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
    END prAcORGANISMO_ID;
 
    -- Actualiza el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        isbVACIOINTERNO    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVACIOINTERNO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(isbVACIOINTERNO,'-') <> NVL(rcRegistroAct.VACIOINTERNO,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
 
    -- Actualiza el valor de la columna FECHA_REG_OSF
    PROCEDURE prAcFECHA_REG_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_REG_OSF    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REG_OSF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_REG_OSF,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_REG_OSF,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_REG_OSF=idtFECHA_REG_OSF
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
    END prAcFECHA_REG_OSF;
 
    -- Actualiza el valor de la columna FECHA_APRO_OSF
    PROCEDURE prAcFECHA_APRO_OSF(
        inuCERTIFICADOS_OIA_ID    NUMBER,
        idtFECHA_APRO_OSF    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_APRO_OSF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCERTIFICADOS_OIA_ID,TRUE);
        IF NVL(idtFECHA_APRO_OSF,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_APRO_OSF,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_APRO_OSF=idtFECHA_APRO_OSF
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
    END prAcFECHA_APRO_OSF;
 
    -- Actualiza por RowId el valor de la columna ID_CONTRATO
    PROCEDURE prAcID_CONTRATO_RId(
        iRowId ROWID,
        inuID_CONTRATO_O    NUMBER,
        inuID_CONTRATO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_CONTRATO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_CONTRATO_O,-1) <> NVL(inuID_CONTRATO_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_PRODUCTO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_PRODUCTO_O,-1) <> NVL(inuID_PRODUCTO_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
 
    -- Actualiza por RowId el valor de la columna FECHA_INSPECCION
    PROCEDURE prAcFECHA_INSPECCION_RId(
        iRowId ROWID,
        idtFECHA_INSPECCION_O    DATE,
        idtFECHA_INSPECCION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INSPECCION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_INSPECCION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_INSPECCION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_INSPECCION=idtFECHA_INSPECCION_N
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
    END prAcFECHA_INSPECCION_RId;
 
    -- Actualiza por RowId el valor de la columna TIPO_INSPECCION
    PROCEDURE prAcTIPO_INSPECCION_RId(
        iRowId ROWID,
        inuTIPO_INSPECCION_O    NUMBER,
        inuTIPO_INSPECCION_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTIPO_INSPECCION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTIPO_INSPECCION_O,-1) <> NVL(inuTIPO_INSPECCION_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET TIPO_INSPECCION=inuTIPO_INSPECCION_N
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
    END prAcTIPO_INSPECCION_RId;
 
    -- Actualiza por RowId el valor de la columna CERTIFICADO
    PROCEDURE prAcCERTIFICADO_RId(
        iRowId ROWID,
        isbCERTIFICADO_O    VARCHAR2,
        isbCERTIFICADO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCERTIFICADO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCERTIFICADO_O,'-') <> NVL(isbCERTIFICADO_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET CERTIFICADO=isbCERTIFICADO_N
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
    END prAcCERTIFICADO_RId;
 
    -- Actualiza por RowId el valor de la columna ID_ORGANISMO_OIA
    PROCEDURE prAcID_ORGANISMO_OIA_RId(
        iRowId ROWID,
        inuID_ORGANISMO_OIA_O    NUMBER,
        inuID_ORGANISMO_OIA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_ORGANISMO_OIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_ORGANISMO_OIA_O,-1) <> NVL(inuID_ORGANISMO_OIA_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ID_ORGANISMO_OIA=inuID_ORGANISMO_OIA_N
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
    END prAcID_ORGANISMO_OIA_RId;
 
    -- Actualiza por RowId el valor de la columna ID_INSPECTOR
    PROCEDURE prAcID_INSPECTOR_RId(
        iRowId ROWID,
        inuID_INSPECTOR_O    NUMBER,
        inuID_INSPECTOR_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcID_INSPECTOR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuID_INSPECTOR_O,-1) <> NVL(inuID_INSPECTOR_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ID_INSPECTOR=inuID_INSPECTOR_N
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
    END prAcID_INSPECTOR_RId;
 
    -- Actualiza por RowId el valor de la columna RESULTADO_INSPECCION
    PROCEDURE prAcRESULTADO_INSPECCION_RId(
        iRowId ROWID,
        inuRESULTADO_INSPECCION_O    NUMBER,
        inuRESULTADO_INSPECCION_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRESULTADO_INSPECCION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuRESULTADO_INSPECCION_O,-1) <> NVL(inuRESULTADO_INSPECCION_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET RESULTADO_INSPECCION=inuRESULTADO_INSPECCION_N
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
    END prAcRESULTADO_INSPECCION_RId;
 
    -- Actualiza por RowId el valor de la columna PACKAGE_ID
    PROCEDURE prAcPACKAGE_ID_RId(
        iRowId ROWID,
        inuPACKAGE_ID_O    NUMBER,
        inuPACKAGE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPACKAGE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPACKAGE_ID_O,-1) <> NVL(inuPACKAGE_ID_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET PACKAGE_ID=inuPACKAGE_ID_N
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
    END prAcPACKAGE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna RED_INDIVIDUAL
    PROCEDURE prAcRED_INDIVIDUAL_RId(
        iRowId ROWID,
        isbRED_INDIVIDUAL_O    VARCHAR2,
        isbRED_INDIVIDUAL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRED_INDIVIDUAL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbRED_INDIVIDUAL_O,'-') <> NVL(isbRED_INDIVIDUAL_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET RED_INDIVIDUAL=isbRED_INDIVIDUAL_N
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
    END prAcRED_INDIVIDUAL_RId;
 
    -- Actualiza por RowId el valor de la columna STATUS_CERTIFICADO
    PROCEDURE prAcSTATUS_CERTIFICADO_RId(
        iRowId ROWID,
        isbSTATUS_CERTIFICADO_O    VARCHAR2,
        isbSTATUS_CERTIFICADO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTATUS_CERTIFICADO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSTATUS_CERTIFICADO_O,'-') <> NVL(isbSTATUS_CERTIFICADO_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET STATUS_CERTIFICADO=isbSTATUS_CERTIFICADO_N
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
    END prAcSTATUS_CERTIFICADO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_REGISTRO
    PROCEDURE prAcFECHA_REGISTRO_RId(
        iRowId ROWID,
        idtFECHA_REGISTRO_O    DATE,
        idtFECHA_REGISTRO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REGISTRO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_REGISTRO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_REGISTRO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_REGISTRO=idtFECHA_REGISTRO_N
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
    END prAcFECHA_REGISTRO_RId;
 
    -- Actualiza por RowId el valor de la columna OBSER_RECHAZO
    PROCEDURE prAcOBSER_RECHAZO_RId(
        iRowId ROWID,
        isbOBSER_RECHAZO_O    VARCHAR2,
        isbOBSER_RECHAZO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOBSER_RECHAZO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOBSER_RECHAZO_O,'-') <> NVL(isbOBSER_RECHAZO_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET OBSER_RECHAZO=isbOBSER_RECHAZO_N
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
    END prAcOBSER_RECHAZO_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_APROBACION
    PROCEDURE prAcFECHA_APROBACION_RId(
        iRowId ROWID,
        idtFECHA_APROBACION_O    DATE,
        idtFECHA_APROBACION_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_APROBACION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_APROBACION_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_APROBACION_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_APROBACION=idtFECHA_APROBACION_N
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
    END prAcFECHA_APROBACION_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_ARCHIVO
    PROCEDURE prAcFECHA_ARCHIVO_RId(
        iRowId ROWID,
        idtFECHA_ARCHIVO_O    DATE,
        idtFECHA_ARCHIVO_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_ARCHIVO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_ARCHIVO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_ARCHIVO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_ARCHIVO=idtFECHA_ARCHIVO_N
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
    END prAcFECHA_ARCHIVO_RId;
 
    -- Actualiza por RowId el valor de la columna ARCHIVO
    PROCEDURE prAcARCHIVO_RId(
        iRowId ROWID,
        isbARCHIVO_O    VARCHAR2,
        isbARCHIVO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARCHIVO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbARCHIVO_O,'-') <> NVL(isbARCHIVO_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ARCHIVO=isbARCHIVO_N
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
    END prAcARCHIVO_RId;
 
    -- Actualiza por RowId el valor de la columna URL
    PROCEDURE prAcURL_RId(
        iRowId ROWID,
        isbURL_O    VARCHAR2,
        isbURL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcURL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbURL_O,'-') <> NVL(isbURL_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET URL=isbURL_N
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
    END prAcURL_RId;
 
    -- Actualiza por RowId el valor de la columna ORDER_ID
    PROCEDURE prAcORDER_ID_RId(
        iRowId ROWID,
        inuORDER_ID_O    NUMBER,
        inuORDER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_ID_O,-1) <> NVL(inuORDER_ID_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ORDER_ID=inuORDER_ID_N
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
    END prAcORDER_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ORGANISMO_ID
    PROCEDURE prAcORGANISMO_ID_RId(
        iRowId ROWID,
        inuORGANISMO_ID_O    NUMBER,
        inuORGANISMO_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORGANISMO_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORGANISMO_ID_O,-1) <> NVL(inuORGANISMO_ID_N,-1) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET ORGANISMO_ID=inuORGANISMO_ID_N
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
    END prAcORGANISMO_ID_RId;
 
    -- Actualiza por RowId el valor de la columna VACIOINTERNO
    PROCEDURE prAcVACIOINTERNO_RId(
        iRowId ROWID,
        isbVACIOINTERNO_O    VARCHAR2,
        isbVACIOINTERNO_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVACIOINTERNO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVACIOINTERNO_O,'-') <> NVL(isbVACIOINTERNO_N,'-') THEN
            UPDATE LDC_CERTIFICADOS_OIA
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
 
    -- Actualiza por RowId el valor de la columna FECHA_REG_OSF
    PROCEDURE prAcFECHA_REG_OSF_RId(
        iRowId ROWID,
        idtFECHA_REG_OSF_O    DATE,
        idtFECHA_REG_OSF_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REG_OSF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_REG_OSF_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_REG_OSF_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_REG_OSF=idtFECHA_REG_OSF_N
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
    END prAcFECHA_REG_OSF_RId;
 
    -- Actualiza por RowId el valor de la columna FECHA_APRO_OSF
    PROCEDURE prAcFECHA_APRO_OSF_RId(
        iRowId ROWID,
        idtFECHA_APRO_OSF_O    DATE,
        idtFECHA_APRO_OSF_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_APRO_OSF_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_APRO_OSF_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_APRO_OSF_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE LDC_CERTIFICADOS_OIA
            SET FECHA_APRO_OSF=idtFECHA_APRO_OSF_N
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
    END prAcFECHA_APRO_OSF_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_CERTIFICADOS_OIA%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.CERTIFICADOS_OIA_ID,TRUE);
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
 
            prAcFECHA_INSPECCION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_INSPECCION,
                ircRegistro.FECHA_INSPECCION
            );
 
            prAcTIPO_INSPECCION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TIPO_INSPECCION,
                ircRegistro.TIPO_INSPECCION
            );
 
            prAcCERTIFICADO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CERTIFICADO,
                ircRegistro.CERTIFICADO
            );
 
            prAcID_ORGANISMO_OIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_ORGANISMO_OIA,
                ircRegistro.ID_ORGANISMO_OIA
            );
 
            prAcID_INSPECTOR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ID_INSPECTOR,
                ircRegistro.ID_INSPECTOR
            );
 
            prAcRESULTADO_INSPECCION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RESULTADO_INSPECCION,
                ircRegistro.RESULTADO_INSPECCION
            );
 
            prAcPACKAGE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PACKAGE_ID,
                ircRegistro.PACKAGE_ID
            );
 
            prAcRED_INDIVIDUAL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RED_INDIVIDUAL,
                ircRegistro.RED_INDIVIDUAL
            );
 
            prAcSTATUS_CERTIFICADO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.STATUS_CERTIFICADO,
                ircRegistro.STATUS_CERTIFICADO
            );
 
            prAcFECHA_REGISTRO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_REGISTRO,
                ircRegistro.FECHA_REGISTRO
            );
 
            prAcOBSER_RECHAZO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OBSER_RECHAZO,
                ircRegistro.OBSER_RECHAZO
            );
 
            prAcFECHA_APROBACION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_APROBACION,
                ircRegistro.FECHA_APROBACION
            );
 
            prAcFECHA_ARCHIVO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_ARCHIVO,
                ircRegistro.FECHA_ARCHIVO
            );
 
            prAcARCHIVO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ARCHIVO,
                ircRegistro.ARCHIVO
            );
 
            prAcURL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.URL,
                ircRegistro.URL
            );
 
            prAcORDER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_ID,
                ircRegistro.ORDER_ID
            );
 
            prAcORGANISMO_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORGANISMO_ID,
                ircRegistro.ORGANISMO_ID
            );
 
            prAcVACIOINTERNO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VACIOINTERNO,
                ircRegistro.VACIOINTERNO
            );
 
            prAcFECHA_REG_OSF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_REG_OSF,
                ircRegistro.FECHA_REG_OSF
            );
 
            prAcFECHA_APRO_OSF_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_APRO_OSF,
                ircRegistro.FECHA_APRO_OSF
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

    -- Obtiene el registro
    FUNCTION frcObtRegistro(
        inuCERTIFICADOS_OIA_ID    NUMBER
    ) RETURN cuRegistro%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistro   cuRegistro%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        OPEN cuRegistro(inuCERTIFICADOS_OIA_ID);
        FETCH cuRegistro INTO rcRegistro;
        CLOSE cuRegistro;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistro;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistro;

    -- Obtiene el ultimo certificado aprobado
    FUNCTION fnuObtUltCertificado( inuCERTIFICADOS_OIA_ID NUMBER ) RETURN NUMBER IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUltCertificado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        nuUltCertificadO    NUMBER;    
        
        CURSOR cuObtUltCertificado
        IS
        SELECT  certificados_oia_id
        FROM    ldc_certificados_oia c
        WHERE   c.certificados_oia_id = inuCERTIFICADOS_OIA_ID
        AND   status_certificado = 'A'
        ORDER BY FECHA_REGISTRO desc;
        
        rcRegistro   cuRegistro%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        OPEN cuObtUltCertificado;
        FETCH cuObtUltCertificado INTO nuUltCertificadO;
        CLOSE cuObtUltCertificado;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuUltCertificadO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuUltCertificadO;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuUltCertificadO;
    END fnuObtUltCertificado;    
          
END pkg_LDC_CERTIFICADOS_OIA;
/

BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_CERTIFICADOS_OIA'), UPPER('adm_person'));
END;
/

