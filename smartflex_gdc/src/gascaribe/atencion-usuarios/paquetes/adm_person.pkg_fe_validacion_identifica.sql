CREATE OR REPLACE PACKAGE adm_person.pkg_fe_validacion_identifica AS
    /*****************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    
    Unidad         : PKG_FE_VALIDACION_IDENTIFICA
    Descripcion    : Paquete primer nivel tabla PKG_FE_VALIDACION_IDENTIFICA
    Autor          : Paola Acosta
    Fecha          : 12-08-2024
    Caso           : OSF-3105
    
    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-08-2024    Paola Acosta                  OSF-3105: Creacion   
    18-09-2024    Paola Acosta                  OSF-3293: Creación métodos: prUpdRegistro, frcObtRegistroRId y fblExiste
    ******************************************************************/
    
    --Cursores
    CURSOR cuRegistroRId
    (
        inuId_cliente IN fe_validacion_identificacion.id_cliente%TYPE
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM FE_VALIDACION_IDENTIFICACION tb
        WHERE
        ID_CLIENTE = inuID_CLIENTE;
        
    CURSOR cuRegistroRIdLock
    (
        inuId_cliente IN fe_validacion_identificacion.id_cliente%TYPE
    )
    IS
        SELECT tb.*, tb.ROWID
        FROM   fe_validacion_identificacion tb
        WHERE  id_cliente = inuid_cliente 
        FOR UPDATE NOWAIT;  
    
    --Metodos    
    
    /**************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas

    Unidad      :  prinsregistro
    Descripcion :  Inserta registro en la tabla fe_validacion_identificacion
    ***************************************************************/
    PROCEDURE prinsregistro (
        ircregistro IN  fe_validacion_identificacion%rowtype,
        orowid      OUT ROWID
    );
    
    /**************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas

    Unidad      :  prUpdRegistro
    Descripcion :  Actualiza registro en la tabla fe_validacion_identificacion
    ***************************************************************/
    PROCEDURE prUpdRegistro (
        ircregistro IN fe_validacion_identificacion%ROWTYPE
    );
    
    /**************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas

    Unidad      :  frcObtRegistroRId
    Descripcion :  Obtiene registro junto con el rowid de la tabla 
                   fe_validacion_identificacion
    ***************************************************************/
    FUNCTION frcObtRegistroRId(
        inuId_cliente IN fe_validacion_identificacion.id_cliente%TYPE,
        iblBloquea    IN BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
    
    /**************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas

    Unidad      :  fblExiste
    Descripcion :  Indica si un cliente tiene registro en la tabla 
                   fe_validacion_identificacion
    ***************************************************************/
    FUNCTION fblExiste(
        inuId_cliente IN fe_validacion_identificacion.id_cliente%TYPE
    ) RETURN BOOLEAN;
    
    

END pkg_fe_validacion_identifica;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_fe_validacion_identifica AS

    csbsp_name    CONSTANT VARCHAR2(35) := $$plsql_unit || '.';
    csbniveltraza CONSTANT NUMBER(2) := pkg_traza.fnuniveltrzdef;
    
    /***************************************************************************
    Método :       prinsregistro
    Descripción:   Inserta registro en la tabla fe_validacion_identificacion
    
    Autor       :  Paola Acosta
    Fecha       :  12-08-2024
    
    Historia de Modificaciones
    
    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    12-08-2024     PAcosta         OSF-3105 Creación
    ***************************************************************************/
    PROCEDURE prinsregistro (
        ircregistro IN fe_validacion_identificacion%rowtype,
        orowid      OUT ROWID
    ) IS

        csbmetodo CONSTANT VARCHAR2(70) := csbsp_name || 'prInsRegistro';
        nuerror   NUMBER;
        sberror   VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbinicio);
        INSERT INTO fe_validacion_identificacion (
            id_cliente,
            ident_anterior,
            ident_nueva,
            valido,
            observacion
        ) VALUES (
            ircregistro.id_cliente,
            ircregistro.ident_anterior,
            ircregistro.ident_nueva,
            ircregistro.valido,
            ircregistro.observacion
        ) RETURNING ROWID INTO orowid;

        pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            pkg_error.geterror(nuerror, sberror);
            pkg_traza.trace('sbError => ' || sberror, csbniveltraza);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_err);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);
            pkg_traza.trace('sbError => ' || sberror, csbniveltraza);
            RAISE pkg_error.controlled_error;
    END prinsregistro;
    
    /***************************************************************************
    Método :       frcObtRegistroRId
    Descripción:   Obtiene registro junto con el rowid de la tabla 
                   fe_validacion_identificacion
    
    Autor       :  Paola Acosta
    Fecha       :  18-09-2024 
    
    Historia de Modificaciones
    
    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    18-09-2024     PAcosta         OSF-3293 Creación
    ***************************************************************************/
    FUNCTION frcObtRegistroRId(
        inuid_cliente IN fe_validacion_identificacion.id_cliente%TYPE,
        iblBloquea    IN BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuId_cliente);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuId_cliente);
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
    
    /***************************************************************************
    Método :       fblexiste
    Descripción:   Indica si un cliente tiene registro en la tabla 
                   fe_validacion_identificacion
    
    Autor       :  Paola Acosta
    Fecha       :  18-09-2024 
    
    Historia de Modificaciones
    
    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    18-09-2024     PAcosta         OSF-3293 Creación
    ***************************************************************************/
    FUNCTION fblexiste(inuid_cliente IN fe_validacion_identificacion.id_cliente%TYPE
    ) RETURN BOOLEAN IS
        csbmetodo        CONSTANT VARCHAR2(70) := csbsp_name||'fblExiste';
        nuerror         NUMBER;
        sberror         VARCHAR2(4000);
        rcregistrorid  curegistrorid%rowtype;
    BEGIN
        pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbinicio);
        
        rcregistrorid := frcobtregistrorid(inuid_cliente);
        
        pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin);
        
        RETURN rcregistrorid.id_cliente IS NOT NULL;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            pkg_error.geterror(nuerror,sberror);
            pkg_traza.TRACE('sbError => '||sberror, csbniveltraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin_err);
            pkg_error.seterror;
            pkg_error.geterror(nuerror,sberror);
            pkg_traza.TRACE('sbError => '||sberror, csbniveltraza );
            RAISE pkg_error.controlled_error;
    END fblexiste;
        
    /***************************************************************************
    Método :       prUpdRegistro
    Descripción:   Actualiza registro en la tabla fe_validacion_identificacion
    
    Autor       :  Paola Acosta
    Fecha       :  18-09-2024 
    
    Historia de Modificaciones
    
    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    18-09-2024     PAcosta         OSF-3293 Creación
    ***************************************************************************/
    PROCEDURE prUpdRegistro (
        ircregistro IN fe_validacion_identificacion%ROWTYPE
    )IS

        csbmetodo CONSTANT VARCHAR2(70) := csbsp_name || 'prUpdRegistro';
        nuerror   NUMBER;
        sberror   VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbinicio);
        
        UPDATE fe_validacion_identificacion 
        SET ident_anterior =  ircregistro.ident_anterior,            
            ident_nueva    =  ircregistro.ident_nueva          
        WHERE id_cliente   =  ircregistro.id_cliente;

        pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            pkg_error.geterror(nuerror, sberror);
            pkg_traza.trace('sbError => ' || sberror, csbniveltraza);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbmetodo, csbniveltraza, pkg_traza.csbfin_err);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror);
            pkg_traza.trace('sbError => ' || sberror, csbniveltraza);
            RAISE pkg_error.controlled_error;
    END prUpdRegistro;

END pkg_fe_validacion_identifica;
/

--Permisos para todos los objetos

PROMPT Otorgando permisos de ejecucion a PKG_FE_VALIDACION_IDENTIFICA
BEGIN
    pkg_utilidades.praplicarpermisos('PKG_FE_VALIDACION_IDENTIFICA', 'ADM_PERSON');
END;
/