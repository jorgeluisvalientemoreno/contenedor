CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_bcDiferidos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bcDiferidos
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   26/05/2025
    Descripcion :   Paquete con programas para consultas sobre diferidos
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/05/2025  OSF-4315 Creacion
*******************************************************************************/

    CURSOR cuDifeSaPeConcLocaActiUso
    (
        inuLocalidad        ge_geogra_location.geograp_location_id%TYPE,
        isbListaConceptos   VARCHAR2,
        isbListaActividades VARCHAR2,
        inuUso              pr_product.category_id%TYPE,
        inuProductoDestino  diferido.difenuse%TYPE
    )
    IS
    WITH ConcRP AS
    (
        SELECT to_number(regexp_substr(isbListaConceptos,'[^,]+', 1,LEVEL)) conccodi
        FROM dual
        CONNECT BY regexp_substr(isbListaConceptos, '[^,]+', 1, LEVEL) IS NOT NULL
    ),
    ActiRP AS
    (
        SELECT to_number(regexp_substr(isbListaActividades,'[^,]+', 1,LEVEL)) actividad
        FROM dual
        CONNECT BY regexp_substr(isbListaActividades, '[^,]+', 1, LEVEL) IS NOT NULL
    )
    SELECT df.difecodi,df.difenuse,df.difevatd,df.difesape,df.difenucu,df.difecupa,df.difevacu
    FROM    ab_address ad,
            pr_product pr,
            diferido df,
            ConcRP,
            ActiRP,
            or_order_activity oa
    WHERE
        ad.geograp_location_id = inuLocalidad
    AND pr.address_id = ad.address_id
    AND pr.category_id = inuUso
    AND df.difenuse = pr.product_id
    AND df.difeconc = ConcRP.conccodi
    AND NVL(df.difesape,0 ) > 0
    AND df.difenudo like 'OR-%'
    AND oa.order_id = SUBSTR(df.difenudo,4)
    AND oa.activity_id = ActiRP.actividad
    AND df.difenuse <> inuProductoDestino;

    TYPE tytbDifeSaPeConcLocaActiUso IS TABLE OF cuDifeSaPeConcLocaActiUso%ROWTYPE
    INDEX BY BINARY_INTEGER;

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna una tabla pl con los diferidos de RP, con saldo pendiente del Cerrejon
    FUNCTION ftbDifeSaPeConcLocaActiUso
    (
        inuLocalidad        ge_geogra_location.geograp_location_id%TYPE,
        isbListaConceptos   VARCHAR2,
        isbListaActividades VARCHAR2,
        inuUso              pr_product.category_id%TYPE,
        inuProductoDestino  diferido.difenuse%TYPE
    )
    RETURN tytbDifeSaPeConcLocaActiUso;

END pkg_bcDiferidos;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_bcDiferidos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4315';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 26/05/2025
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/05/2025  OSF-4315 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : ftbDifeSaldoPendConcRPCerrejon
    Descripcion     : Retorna una tabla pl con los diferidos de Revision Periodica
                      con saldo de la localidad 9134 - Cerrejon
    Autor           : Lubin Pineda - GlobalMVM
    Fecha           : 26/05/2025
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     26/05/2025  OSF-4315 Creacion
    ***************************************************************************/
    FUNCTION ftbDifeSaPeConcLocaActiUso
    (
        inuLocalidad        ge_geogra_location.geograp_location_id%TYPE,
        isbListaConceptos   VARCHAR2,
        isbListaActividades VARCHAR2,
        inuUso              pr_product.category_id%TYPE,
        inuProductoDestino  diferido.difenuse%TYPE
    )
    RETURN tytbDifeSaPeConcLocaActiUso
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ftbDifeSaPeConcLocaActiUso';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        tbDifeSaPeConcLocaActiUso   tytbDifeSaPeConcLocaActiUso;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF  cuDifeSaPeConcLocaActiUso%IsOpen THEN
            CLOSE cuDifeSaPeConcLocaActiUso;
        END IF;

        OPEN cuDifeSaPeConcLocaActiUso(inuLocalidad,isbListaConceptos,isbListaActividades,inuUso,inuProductoDestino);
        FETCH cuDifeSaPeConcLocaActiUso BULK COLLECT INTO tbDifeSaPeConcLocaActiUso;
        CLOSE cuDifeSaPeConcLocaActiUso;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN tbDifeSaPeConcLocaActiUso;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END ftbDifeSaPeConcLocaActiUso;

END pkg_bcDiferidos;
/
