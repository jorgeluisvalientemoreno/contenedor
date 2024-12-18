CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOQUERYPOLICY
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BoQueryPolicy
    Descripcion    : Utilidades para la cosnulta de mercado potencial
    Autor          : John Alexander Carrillo Gómez
    Fecha          : 24-09-2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    24-09-2013      jcarrillo.SAO217375 1 - Creacion
    ******************************************************************/

    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------
    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuGetDepartamentId
    Descripcion :  Obtiene el Identificador del Departamento
    ***************************************************************/
    FUNCTION fnuGetDepartamentId
    (
        inuAddress  in  ab_address.address_id%type
    )
    return ge_geogra_location.geograp_location_id%type;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbGetDepartamentDesc
    Descripcion :  Obtiene las descripción del Departamento
    ***************************************************************/
    FUNCTION fsbGetDepartamentDesc
    (
        inuAddress  in  ab_address.address_id%type
    )
    return ge_geogra_location.description%type;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbHasCapacityToFinan
    Descripcion :  Obtiene Si tiene una que tengan una cuota de financiación de
                    brilla seguros menor a la indicada por el parámetro.
    ***************************************************************/
    FUNCTION fsbHasCapacityToFinan
    (
        inuSuscripc in suscripc.susccodi%type
    )
    return varchar2;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbHasPolicy
    Descripcion :  Obtiene Y si el contrato tiene una Poliza Exequial activa,
                   de lo contrario devuelve N.
    ***************************************************************/

    FUNCTION fsbHasPolicy
    (
        inuSesusc in servsusc.sesususc%type
    )
    return varchar2;

    FUNCTION FSBVERSION
    RETURN VARCHAR2;

END LD_BOQUERYPOLICY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOQUERYPOLICY
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Ld_BoQueryPolicy
    Descripcion    : Utilidades para la cosnulta de mercado potencial
    Autor          : John Alexander Carrillo Gómez
    Fecha          : 24-09-2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    24-09-2013      jcarrillo.SAO217375 1 - Creacion
    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION                  CONSTANT VARCHAR2(10) := 'SAO217375';

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    -- Datos de la Dirección y el Departamento
    gnuAddressId                ab_address.address_id%type;
    gnuDepartamentId            ge_geogra_location.geograp_location_id%type;
    gsbDepartamentDesc          ge_geogra_location.description%type;

    -- Datos de la cuota de financiación
    gnuCoutaFin                 number;

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------
    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  LoadParameters
    Descripcion :  Carga de Parametros

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    PROCEDURE LoadParameters
    IS
    BEGIN
        if (DALD_PARAMETER.fblexist(LD_BOConstans.csbCodShare))
        then
            gnuCoutaFin := DALD_PARAMETER.fnuGetNumeric_Value(LD_BOConstans.csbCodShare);
        else
            gnuCoutaFin := LD_BOConstans.cnuCero;
        end if;
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END LoadParameters;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  LoadDepartament
    Descripcion :  Carga la información del Departamento en Memoria

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    PROCEDURE LoadDepartament
    (
        inuAddress  in  ab_address.address_id%type
    )
    IS
    BEGIN

        if( inuAddress = gnuAddressId )
        then
            return;
        end if;

        if( inuAddress IS null )
        then
            gnuAddressId := null;
            gnuDepartamentId := null;
            gsbDepartamentDesc := null;
            return;
        end if;

        gnuDepartamentId    := ge_bogeogra_location.fnuGetGeo_LocaByAddress(inuAddress, 'DEP');
        gsbDepartamentDesc  := dage_geogra_location.fsbGetDescription(gnuDepartamentId);
        gnuAddressId        := inuAddress;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END LoadDepartament;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuGetDepartamentId
    Descripcion :  Obtiene el Identificador del Departamento

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    FUNCTION fnuGetDepartamentId
    (
        inuAddress  in  ab_address.address_id%type
    )
    return ge_geogra_location.geograp_location_id%type
    IS
    BEGIN
        LoadDepartament(inuAddress);
        return gnuDepartamentId;
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fnuGetDepartamentId;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbGetDepartamentDesc
    Descripcion :  Obtiene las descripción del Departamento

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    FUNCTION fsbGetDepartamentDesc
    (
        inuAddress  in  ab_address.address_id%type
    )
    return ge_geogra_location.description%type
    IS
    BEGIN
        LoadDepartament(inuAddress);
        return gsbDepartamentDesc;
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fsbGetDepartamentDesc;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbHasCapacityToFinan
    Descripcion :  Obtiene Si tiene una que tengan una cuota de financiación de
                    brilla seguros menor a la indicada por el parámetro.

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    FUNCTION fsbHasCapacityToFinan
    (
        inuSuscripc in suscripc.susccodi%type
    )
    return varchar2
    IS
        nuValueFin number;
    BEGIN

        ld_bcsecuremanagement.ProcValidateClifin(inuSuscripc, nuValueFin);

        if (nuValueFin < gnuCoutaFin)
        then
            return 'Y';
        else
            return 'N';
        end if;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fsbHasCapacityToFinan;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbHasPolicy
    Descripcion :  Obtiene Y si el contrato tiene una Poliza Exequial activa,
                   de lo contrario devuelve N.

    Autor       :  Jhonny Agudelo Oviedo
    Fecha       :  18-10-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    ***************************************************************/
    FUNCTION fsbHasPolicy
    (
        inuSesusc in servsusc.sesususc%type
    )
    return varchar2
    IS
        nuValueFin number;
    BEGIN

       SELECT /*+ index(ld_policy IDX_LD_POLICY_05) */
       count(1) INTO nuValueFin
       FROM ld_policy
       WHERE ld_policy.suscription_id = inuSesusc
       AND policy_exq = 'Y'
       AND ROWNUM = 1;

       if(nuValueFin >= 1)
         then return 'Y';
       else return 'N';
       END if;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fsbHasPolicy;



   /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FSBVERSION
    Descripcion :  Obtiene la versión del paquete

    Autor       :  John Alexande Carrillo
    Fecha       :  24-09-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-09-2013   jcarrillo.SAO217375 1 - Creacion
    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

BEGIN

    LoadParameters;

END LD_BOQUERYPOLICY;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOQUERYPOLICY', 'ADM_PERSON');
END;
/
