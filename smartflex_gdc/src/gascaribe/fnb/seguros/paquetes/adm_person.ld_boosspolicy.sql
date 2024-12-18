CREATE OR REPLACE PACKAGE      adm_person.LD_BOOSSPOLICY

IS

    /*****************************************************************

    Propiedad intelectual de Open International Systems (c).



    Unidad         : LD_BOOssPolicy

    Descripcion    : Consulta de Polizas para el CNCRM

    Autor          : John Alexander Carrillo Gomez

    Fecha          : 31-08-2013





    Historia de Modificaciones

    Fecha             Autor             Modificacion

    ==========  =================== =============================
    23/07/2024  PAcosta             OSF-2952: Cambio de esquema ADM_PERSON
    31-08-2013  jcarrillo.SAO212812 1 - Creacion

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

    FUNCTION FSBVERSION

    RETURN VARCHAR2;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbDepartment

    Descripcion :  Retorna el departamento del contrato en memoria

                    para polizas

    ***************************************************************/

    FUNCTION fsbDepartment

    RETURN VARCHAR2;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbLocality

    Descripcion :  Retorna la localidad del contrato en memoria

                    para polizas

    ***************************************************************/

    FUNCTION fsbLocality

    RETURN VARCHAR2;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbLocality

    Descripcion :  Retorna el barrio del contrato en memoria

                    para polizas

    ***************************************************************/

    FUNCTION fsbNeighborhood

    RETURN VARCHAR2;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetPolicyById

    Descripcion :  Cosulta los datos de una poliza

    ***************************************************************/

    PROCEDURE GetPolicyById

    (

        inuPolicyId in  ld_policy.policy_id%type,

        ocuCursor   out constants.tyRefCursor

    );



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetPolicyBySusc

    Descripcion :  Cosulta los datos de las polizas de un contrato

    ***************************************************************/

    PROCEDURE GetPolicyBySusc

    (

        inuSuscrip  in  ld_policy.suscription_id%type,

        ocuCursor   out constants.tyRefCursor

    );



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetSuscByPolicy

    Descripcion :  Obtiene el Contrato de una poliza

    ***************************************************************/

    PROCEDURE GetSuscByPolicy

    (

        inuPolicyId in  ld_policy.policy_id%type,

        onuSuscrip  out ld_policy.suscription_id%type

    );



END LD_BOOssPolicy;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.LD_BOOSSPOLICY

IS

    --------------------------------------------

    -- Constantes VERSION DEL PAQUETE

    --------------------------------------------

    csbVERSION                  CONSTANT VARCHAR2(10) := 'RQ1146';



    --------------------------------------------

    -- Constantes PRIVADAS DEL PAQUETE

    --------------------------------------------



    --------------------------------------------

    -- Variables PRIVADAS DEL PAQUETE

    --------------------------------------------

    type tyrcLocation IS record

    (

        -- Contrato

        nuSubscription  suscripc.susccodi%type,

        -- Barrio

        nuNBHoodId      ab_address.neighborthood_id%type,

        sbNBHoodDesc    ge_geogra_location.display_description%type,

        -- Localidad

        nuGeoLocId      ab_address.geograp_location_id%type,

        sbGeoLocDesc    ge_geogra_location.display_description%type,

        -- Departamento

        nuGeoDepartId   ge_geogra_location.geograp_location_id%type,

        sbGeoDepartDesc ge_geogra_location.display_description%type

    );



    gsbAttributes   VARCHAR2(32000);

    gsbEntities     VARCHAR2(32000);

    gsbWhere        VARCHAR2(32000);



    grcLocations    tyrcLocation;



    --------------------------------------------

    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE

    --------------------------------------------

    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  FSBVERSION

    Descripcion :  Retorna la ultima version del paquete



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    FUNCTION FSBVERSION

    RETURN VARCHAR2 IS

    BEGIN

        return CSBVERSION;

    END FSBVERSION;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  LoadAddressData

    Descripcion :  Carga el Barrio, la localidad y el departamento del

                   contrato



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :

        inuSuscrip      Contrato



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    PROCEDURE LoadAddressData

    (

        inuSuscrip  in  ld_policy.suscription_id%type

    )

    IS

        -- Datos de la direccion que se obtiene del contrato

        nuAddressId     ab_address.address_id%type;

        sbAddress       ab_address.address_parsed%type;

        nuGeoLocation   ge_geogra_location.geograp_location_id%type;

        -- Barrio

        nuNBHoodId      ab_address.neighborthood_id%type;

        sbNBHoodDesc    ge_geogra_location.display_description%type;

        -- Localidad

        nuGeoLocId      ab_address.geograp_location_id%type;

        sbGeoLocDesc    ge_geogra_location.display_description%type;

        -- Departamento

        nuGeoDepartId   ge_geogra_location.geograp_location_id%type;

    BEGIN



        if( (grcLocations.nuSubscription IS null) OR ( grcLocations.nuSubscription != inuSuscrip ) )

        then

            -- Carga la direccion

            ld_bcsecuremanagement.GetAddressBySusc(inuSuscrip,nuAddressId,nuGeoLocation);



            if(nuAddressId IS null)

            then

                grcLocations := null;

                grcLocations.nuSubscription := inuSuscrip;

                return;

            end if;



            -- Obtiene Barrio y localidad

            Ab_Boaddress.Getaddressdata

            (

                nuAddressId,

                sbAddress,

                nuNBHoodId, -- id de Barrio

                sbNBHoodDesc, -- Descripcion de Barrio

                nuGeoLocId, -- localidad

                sbGeoLocDesc -- Descripcion de localidad

            );



            -- obtiene el departamento de la direccion.

            nuGeoDepartId := Ge_Bogeogra_Location.Fnugetge_Geogra_Location

                            (

                                nuGeoLocId,

                                Ab_Boconstants.Csbtoken_Departamento

                            );





            -- Se almacenan

            grcLocations.nuSubscription := inuSuscrip;

            grcLocations.nuNBHoodId     := nuNBHoodId;

            grcLocations.sbNBHoodDesc   := sbNBHoodDesc;

            grcLocations.nuGeoLocId     := nuGeoLocId;

            grcLocations.sbGeoLocDesc   := sbGeoLocDesc;

            grcLocations.nuGeoDepartId  := nuGeoDepartId;

            if (nuGeoDepartId is not null)

            then

                grcLocations.sbGeoDepartDesc:= dage_geogra_location.fsbgetdisplay_description(nuGeoDepartId);

            else

                grcLocations.sbGeoDepartDesc:= null;

            end if;





        end if;

    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END LoadAddressData;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbDepartment

    Descripcion :  Retorna el departamento del contrato en memoria

                    para polizas



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    FUNCTION fsbDepartment

    RETURN VARCHAR2

    IS

    BEGIN

        Return  grcLocations.nuGeoDepartId||' - '||grcLocations.sbGeoDepartDesc ;

    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END fsbDepartment;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbLocality

    Descripcion :  Retorna la localidad del contrato en memoria

                    para polizas



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    FUNCTION fsbLocality

    RETURN VARCHAR2

    IS

    BEGIN

        Return  grcLocations.nuGeoLocId||' - '||grcLocations.sbGeoLocDesc ;

    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END fsbLocality;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbLocality

    Descripcion :  Retorna el barrio del contrato en memoria

                    para polizas



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    FUNCTION fsbNeighborhood

    RETURN VARCHAR2

    IS

    BEGIN

        Return  grcLocations.nuNBHoodId||' - '||grcLocations.sbNBHoodDesc ;

    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END fsbNeighborhood;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  FillPolicy

    Descripcion :  Arma la cadena para la consulta de polizas



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================
    13-07-2017  FCaastro. 200-1058  Se modifica el nombre de la funcion llamada para hallar las cuotas pagadas
    18-09-2013  llarrarte.RQ1146    Se adiciona el producto, el numero de la poliza

                                    y el identificador del colectivo.

                                    Se hace Join con la entidad ld_polcy_state para

                                    obtener las descripciones de esta.

    19-12-2013  jrobayo.SAO228348   1 - Se remueven los datos periodo, mes y a?o.

                                    2 - Se agrega llamado a funcion para obtener

                                        la cantidad de cuotas pagadas del diferido

                                        asociado a la poliza.

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    PROCEDURE FillPolicy

    IS



        sbState                 varchar2(2000);

        sbSupplier              varchar2(2000);

        sbProductLine           varchar2(2000);

        sbPolicyType            varchar2(2000);

        sbGeograpLocation       varchar2(2000);

        sbFeedPaid              varchar2(2000);



    BEGIN

        if gsbAttributes is not null then

            return;

        end if;



        sbState             := 'a.state_policy'|| cc_boBossUtil.csbSEPARATOR ||'h.description';

        sbSupplier          := 'a.contratist_code'      || cc_boBossUtil.csbSEPARATOR || 'b.nombre_contratista';

        sbProductLine       := 'a.product_line_id'      || cc_boBossUtil.csbSEPARATOR || 'c.description';

        sbPolicyType        := 'a.policy_type_id'       || cc_boBossUtil.csbSEPARATOR || 'd.description';

        sbGeograpLocation   := 'a.geograp_location_id'  || cc_boBossUtil.csbSEPARATOR || 'e.description';

        sbFeedPaid          := 'ld_bcsecuremanagement.FnuGetAllFeesPaid(a.policy_id)';



        -- Estado de Poliza: 1- Activo y sus demas estados.

        CC_BOBossUtil.AddAttribute (sbFeedPaid,                   'feed_paid',                gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.policy_id',                'policy_id',                gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.policy_number',            'policy_number',            gsbAttributes);

        CC_BOBossUtil.AddAttribute (sbState,                      'state_policy',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.product_id',                 'product',                 gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.collective_number',           'collective_number',       gsbAttributes);

        CC_BOBossUtil.AddAttribute (sbSupplier,                   'contratist',               gsbAttributes);

        CC_BOBossUtil.AddAttribute (sbProductLine,                'product_line',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dt_in_policy',             'initial_date',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dt_en_policy',             'final_date',               gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.value_policy',             'value_policy',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.prem_policy',              'prem_policy',              gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.name_insured',             'name_insured',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.suscription_id',           'suscription_id',           gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.identification_id',        'identification_insured',   gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.deferred_policy_id',       'deferred_policy_id',       gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dtcreate_policy',          'dtcreate_policy',          gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.share_policy',             'share_policy',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dtret_policy',             'dtret_policy',             gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.valueacr_policy',          'valueacr_policy',          gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dt_report_policy',         'dt_report_policy',         gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.dt_insured_policy',        'dt_insured_policy',        gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.per_report_policy',        'per_report_policy',        gsbAttributes);

        CC_BOBossUtil.AddAttribute (sbPolicyType,                 'policy_type',              gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.id_report_policy',         'id_report_policy',         gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.cancel_causal_id',         'cancel_causal_id',         gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.fees_to_return',           'fees_to_return',           gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.comments',                 'comments',                 gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.policy_exq',               'policy_exq',               gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.number_acta',              'number_acta',              gsbAttributes);

        CC_BOBossUtil.AddAttribute (sbGeograpLocation,            'geograp_location',         gsbAttributes);

        CC_BOBossUtil.AddAttribute('LD_BOOssPolicy.fsbNeighborhood',    'neighborhood', gsbAttributes);

        CC_BOBossUtil.AddAttribute('LD_BOOssPolicy.fsbLocality',        'locality ',    gsbAttributes);

        CC_BOBossUtil.AddAttribute('LD_BOOssPolicy.fsbDepartment',      'department',   gsbAttributes);

        CC_BOBossUtil.AddAttribute ('a.launch_policy',            'launch_policy',            gsbAttributes);

        CC_BOBossUtil.AddAttribute(':parent_id',                        'parent_id',    gsbAttributes);



        gsbEntities   := 'ld_policy a, ge_contratista b, ld_product_line c, ld_policy_type d, ge_geogra_location e, ld_policy_state h';



        gsbWhere := 'AND   a.contratist_code = b.id_contratista'               || chr(10) ||

                    'AND   a.product_line_id = c.product_line_id '             || chr(10) ||

                    'AND   a.policy_type_id = d.policy_type_id '               ||chr(10)||

                    'AND   h.policy_state_id = a.state_policy '               ||chr(10)||

                    'AND   a.geograp_location_id = e.geograp_location_id (+)';



    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END FillPolicy;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetPolicyById

    Descripcion :  Cosulta los datos de una poliza



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :

        inuPolicyId     Poliza

        ocuCursor       Datos de la consulta



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    PROCEDURE GetPolicyById

    (

        inuPolicyId in  ld_policy.policy_id%type,

        ocuCursor   out constants.tyRefCursor

    )

    IS

        sbSql           varchar2(32767);

        nuSuscriptionId ld_policy.suscription_id%type;

    BEGIN



        FillPolicy;



        if(inuPolicyId IS null)

        then

            grcLocations := null;

        else

            LoadAddressData(dald_policy.fnuGetSUSCRIPTION_ID(inuPolicyId));

        end if;



        sbSql := 'SELECT '|| gsbAttributes                                  || chr(10) ||

                 'FROM  /*+ LD_BOOssPolicy.GetPolicyById */'                || chr(10) ||

                        gsbEntities                                         || chr(10) ||

                 'WHERE a.policy_id = :Policy'                              || chr(10) ||

                 gsbWhere;



        open ocuCursor for sbSql using cc_boBossUtil.cnuNULL, inuPolicyId;



    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END GetPolicyById;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetPolicyBySusc

    Descripcion :  Cosulta los datos de las polizas de un contrato



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :

        inuSuscrip      Contrato

        ocuCursor       Datos de la consulta



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    PROCEDURE GetPolicyBySusc

    (

        inuSuscrip  in  ld_policy.suscription_id%type,

        ocuCursor   out constants.tyRefCursor

    )

    IS

        sbSql             varchar2(32767);

    BEGIN



        FillPolicy;



        LoadAddressData(inuSuscrip);



        sbSql := 'SELECT '|| gsbAttributes                          || chr(10) ||

                 'FROM '  || '/*+ LD_BOOssPolicy.GetPolicyBySusc */'  || chr(10) ||

                              gsbEntities                           || chr(10) ||

                 'WHERE ' || 'a.suscription_id = :suscriptionId'    || chr(10) ||

                 gsbWhere;



        open ocuCursor for sbSql using inuSuscrip, inuSuscrip;



    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END GetPolicyBySusc;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  GetSuscByPolicy

    Descripcion :  Obtiene el Contrato de una poliza



    Autor       :  John Alexander Carrilo

    Fecha       :  31-08-2013

    Parametros  :

        inuPolicyId     Poliza

        onuSuscrip      Contrato



    Historia de Modificaciones

    Fecha        Autor              Modificacion

    =========   =================== ============================

    31-08-2013  jcarrillo.SAO212812 1 - Creacion

    ***************************************************************/

    PROCEDURE GetSuscByPolicy

    (

        inuPolicyId in  ld_policy.policy_id%type,

        onuSuscrip  out ld_policy.suscription_id%type

    )

    IS

    BEGIN



        if(inuPolicyId IS null)

        then

            onuSuscrip:= null;

        end if;



        onuSuscrip := dald_policy.fnuGetSUSCRIPTION_ID(inuPolicyId);



    EXCEPTION

        WHEN ex.CONTROLLED_ERROR THEN

            RAISE ex.CONTROLLED_ERROR;

        WHEN others THEN

            errors.seterror;

            RAISE ex.CONTROLLED_ERROR;

    END GetSuscByPolicy;



BEGIN



    gsbAttributes := null;

    gsbEntities := null;



END LD_BOOssPolicy;
/
PROMPT Otorgando permisos de ejecucion a LD_BOOSSPOLICY
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOOSSPOLICY', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOOSSPOLICY para reportes
GRANT EXECUTE ON adm_person.LD_BOOSSPOLICY TO rexereportes;
/
