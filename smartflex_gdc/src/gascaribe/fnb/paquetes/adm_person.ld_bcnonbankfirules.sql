CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCNONBANKFIRULES IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BCNonBankFiRules
  Descripcion    :  Paquete con las consultas necesarias
  Autor          :
  Fecha          : 24/07/2012

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ========= ====================

  ******************************************************************/

  -- Declaracion de Tipos de datos publicos
  /*Cursor Obtiene Fraude*/
  CURSOR cuFraud(inuSubscription NUMBER, inuUserId NUMBER) IS
    WITH data AS
     (SELECT
      /*+ index(FM_DISCOVERY_TYPE PK_FM_DISCOVERY_TYPE)*/
       fm_possible_ntl.POSSIBLE_NTL_ID,
       decode(fm_possible_ntl.STATUS, 'P', 'Pendiente', 'E', 'Ignorado', 'R',
              'Proyecto', 'F', 'Fraude Confirmado', 'N', 'Fraude No Detectado',
              'Estado No Soportado') STATUS_DESC,
       fm_possible_ntl.PRODUCT_ID,
       fm_possible_ntl.PRODUCT_TYPE_ID || ' - ' || servicio.SERVDESC PRODUCT_TYPE_DESC,
       fm_possible_ntl.GEOGRAP_LOCATION_ID || ' - ' ||
       ge_geogra_location.DESCRIPTION GEOGRAP_LOCATION_DESC,
       ab_address.ADDRESS_PARSED ADDRESS_DESC,
       fm_possible_ntl.REGISTER_DATE,
       fm_possible_ntl.COMMENT_,
       fm_possible_ntl.DISCOVERY_TYPE_ID || ' - ' || fm_discovery_type.NAME_ DISCOVERY_TYPE_DESC,
       ge_document_type.description || ' ' || ge_subscriber.identification ||
       ' - ' || ge_subscriber.subscriber_name informer,
       fm_possible_ntl.PROJECT_ID || ' - ' || pm_project.PROJECT_NAME PROJECT_DESC,
       fm_possible_ntl.ORDER_ID,
       fm_possible_ntl.REVIEW_DATE,
       fm_possible_ntl.PERSON_ID || ' - ' || ge_person.NAME_ PERSON_DESC,
       fm_possible_ntl.PACKAGE_ID,
       fm_possible_ntl.normalized_prod_id
      FROM   fm_possible_ntl,
             ge_subscriber,
             servicio,
             ge_geogra_location,
             ab_address,
             fm_discovery_type,
             pm_project,
             ge_person,
             ge_document_type
      WHERE  fm_possible_ntl.product_type_id = servicio.servcodi
      AND    fm_possible_ntl.informer_subs_id =
             ge_subscriber.subscriber_id(+)
      AND    fm_possible_ntl.geograp_location_id =
             ge_geogra_location.geograp_location_id(+)
      AND    fm_possible_ntl.address_id = ab_address.address_id(+)
      AND    fm_possible_ntl.discovery_type_id =
             fm_discovery_type.discovery_type_id
      AND    fm_possible_ntl.project_id = pm_project.project_id(+)
      AND    fm_possible_ntl.person_id = ge_person.person_id(+)
      AND    ge_subscriber.ident_type_id =
             ge_document_type.document_type_id(+))
    SELECT data.*,
           suscripc.SUSCCLIE SUBSCRIBER_ID,
           'Responsable' involv_comment,
           suscripc.SUSCCLIE PARENT_ID
    FROM   data, suscripc, pr_product
    WHERE  data.product_id = pr_product.product_id --5555630092
    AND    pr_product.subscription_id = suscripc.susccodi
    AND    pr_product.subscription_id = inuSubscription
    UNION
    SELECT data.*,
           fm_involved_subsc.SUBSCRIBER_ID,
           fm_involved_subsc.comment_      involv_comment,
           fm_involved_subsc.SUBSCRIBER_ID PARENT_ID
    FROM   data, fm_involved_subsc
    WHERE  data.possible_ntl_id = fm_involved_subsc.possible_ntl_id --269
    AND    fm_involved_subsc.subscriber_id = inuUserId;
  -- Declaracion de variables
  TYPE tytbFraud IS TABLE OF cuFraud%ROWTYPE;
  vtabFraud tytbFraud;
  -- Declaracion de variables publicas

  -- Declaracion de metodos publicos
    FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbFactuDue
  Descripcion    : Retorna una tabla con las cuentas de cobro
                   pendiente para el contrato (inuSubscriptionId)
                   y el producto de GAS(inuGasProductType)

  Autor          : avalencia
  Fecha          : 17/10/2012

    Parametros              Descripcion
  ============         ===================
  inuGasProductType:   Identificador del tipo de producto GAS.
  inuSubscriptionId:   Identificador del contrato.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  FUNCTION ftbFactuDue(inuProductType    IN pr_product.product_id%TYPE DEFAULT NULL,
                       inuSubscriptionId IN suscripc.susccodi%TYPE)
    RETURN pktblcuencobr.tytbcuencobr;

  FUNCTION ftbOutrightFraud(inuContract       IN VARCHAR2,
                            inuSubscriptionId IN suscripc.susccodi%TYPE)
    RETURN tytbFraud;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbRefinanDife
  Descripcion    : Obtiene una tabla con todos los diferidos activos
  cuyo campo DIFEPROF sea igual a isbProg(en caso de que sea nulo este
  filtro se ignora) para todos los productos asociados al contrato y
  cuya fecha este entre las dos fechas de entrada.

  Autor          : eramos
  Fecha          : 24/07/2012

    Parametros              Descripcion
  ============         ===================
  inuSubscriptionId:   Identificador del contrato.
  inuInitialDate:      fecha inicial de busqueda.(por defecto fecha minima de oracle)
  inuFinaldate:        fecha final de busqueda.(por defecto fecha maxima de oracle)
  isbProductType:      Tipos de producto a buscar separados por comas(,).(Por defecto en nulo)
  isbConcepts:         Conceptos a buscar separados por comas.(Por defecto nulo)
  isbProg:             Nombre del programa que genero los diferidos.(por defecto nulo)



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  FUNCTION ftbRefinanDife(inuSubscriptionId IN suscripc.susccodi%TYPE,
                          idtInitialDate    IN diferido.difefein%TYPE DEFAULT ut_date.fdtMinDate,
                          idtFinaldate      IN diferido.difefein%TYPE DEFAULT ut_date.fdtSysdate,
                          inuProductType    IN pr_product.product_id%TYPE DEFAULT NULL,
                          isbConcepts       IN VARCHAR2 DEFAULT NULL,
                          isbProg           IN diferido.difeprog%TYPE DEFAULT NULL)
    RETURN pktbldiferido.tytbDiferido;

   /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountOpenFraud
    Descripcion    : Obtiene la cantidad de fraudes abiertos de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountOpenFraud(inususcripc   in suscripc.susccodi%type,
                                 inuserv       in servsusc.sesuserv%type
                                ) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountFraud
    Descripcion    : Obtiene la cantidad de fraudes de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountFraud(inususcripc   in suscripc.susccodi%type,
                             inuserv       in servsusc.sesuserv%type
                            ) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountCloseFraud
    Descripcion    : Obtiene la cantidad de fraudes cerrados de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountCloseFraud(inususcripc   in suscripc.susccodi%type,
                                  inuserv       in servsusc.sesuserv%type
                                 ) return number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fdtgetFinalDateLastFraud
    Descripcion    : Obtiene la fecha de cierre del fraude mas
                     reciente de un producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fdtgetFinalDateLastFraud(inususcripc   in suscripc.susccodi%type,
                                    inuserv       in servsusc.sesuserv%type
                                   ) return Fm_possible_ntl.Fraud_End_Date%type;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetamountsesunuse
    Descripcion    : Obtiene la cantidad de servicios suscritos a
                     partir del servicio y el contrato

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inususcripc          Identificador del contrato
    inuserv              Identificador del servicio
    inuRaiseError        Controlador de error

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetamountsesunuse(inususcripc   in suscripc.susccodi%type,
                                inuserv       in servsusc.sesuserv%type,
                                inuRaiseError in number default 1
                               ) return number;

END LD_BCNONBANKFIRULES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCNONBANKFIRULES IS
  -- Declaracion de variables y tipos globales privados del paquete



    csbVersion CONSTANT VARCHAR2(20) := 'SAO215055';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
  	RETURN csbVersion;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbperPaidFinanInstallation
  Descripcion    : Retorna una tabla con los diferidos pendientes
  para el producto de GAS(inuGasProductType) del concepto financiacion
  de instalacion(inuConcept).

  Autor          : eramos
  Fecha          : 24/07/2012

    Parametros              Descripcion
  ============         ===================
  inuGasProductType:   Identificador del tipo de producto GAS.
  inuSubscriptionId:   Identificador del contrato.
  inuConcept:          Concepto de financiacion de instalacion de GAS.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/

  FUNCTION ftbperPaidFinanInstallation(isbProductType    IN VARCHAR2,
                                       inuSubscriptionId OUT suscripc.susccodi%TYPE)
    RETURN NUMBER IS
    -- Declaracion de variables
  BEGIN

    NULL;

    /*Retorna una tabla con los diferidos pendientes para el
    producto de GAS(inuGasProductType) del concepto financiacion de instalacion(inuConcept).*/

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ftbperPaidFinanInstallation;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbFactuDue
  Descripcion    : Retorna una tabla con las cuentas de cobro
                   pendiente para el contrato (inuSubscriptionId)
                   y el producto de GAS(inuGasProductType)

  Autor          : avalencia
  Fecha          : 17/10/2012

    Parametros              Descripcion
  ============         ===================
  inuProductType:      Identificador del tipo de producto GAS.
  inuSubscriptionId:   Identificador del contrato.


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  FUNCTION ftbFactuDue(inuProductType    IN pr_product.product_id%TYPE DEFAULT NULL,
                       inuSubscriptionId IN suscripc.susccodi%TYPE)
    RETURN pktblcuencobr.tytbcuencobr IS

    /* Declaracion de variables */
    tbCuencobr pktblcuencobr.tytbcuencobr;

    CURSOR cuCuencobr IS
      SELECT c.*
      FROM   cuencobr c,
             (SELECT factcodi
              FROM   factura
              WHERE  factsusc = inuSubscriptionId)
      WHERE  cucofact = factcodi
      AND    cuconuse = NVL(inuProductType, cuconuse)
      AND    (NVL(cucosacu, ld_boconstans.cnuCero_Value) +
            NVL(cucovare, ld_boconstans.cnuCero_Value) +
            NVL(cucovrap, ld_boconstans.cnuCero_Value)) >
             ld_boconstans.cnuCero_Value
      AND    TRUNC(cucofeve) < TRUNC(SYSDATE);
  BEGIN

    /*
    Obtiene una tabla con las cuentas de cobro cuya
    fecha de pago sea inferior a la fecha actual y no hayan sido pagadas.
    */

    OPEN cuCuencobr;
    FETCH cuCuencobr BULK COLLECT
      INTO tbCuencobr;
    CLOSE cuCuencobr;

    RETURN tbCuencobr;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ftbFactuDue;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbRefinanDife
  Descripcion    : Obtiene una tabla con todos los diferidos activos
  cuyo campo DIFEPROG sea igual a isbProg(en caso de que sea nulo este
  filtro se ignora) para todos los productos asociados al contrato y
  cuya fecha este entre las dos fechas de entrada.

  Autor          : eramos
  Fecha          : 24/07/2012

    Parametros              Descripcion
  ============         ===================
  inuSubscriptionId:   Identificador del contrato.
  inuInitialDate:      fecha inicial de busqueda.(por defecto fecha minima de oracle)
  inuFinaldate:        fecha final de busqueda.(por defecto fecha maxima de oracle)
  isbProductType:      Tipos de producto a buscar separados por comas(,).(Por defecto en nulo)
  isbConcepts:         Conceptos a buscar separados por comas.(Por defecto nulo)
  isbProg:             Nombre del programa que genero los diferidos.(por defecto nulo)



  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  FUNCTION ftbRefinanDife(inuSubscriptionId IN suscripc.susccodi%TYPE,
                          idtInitialDate    IN diferido.difefein%TYPE DEFAULT ut_date.fdtMinDate,
                          idtFinaldate      IN diferido.difefein%TYPE DEFAULT ut_date.fdtSysdate,
                          inuProductType    IN pr_product.product_id%TYPE DEFAULT NULL,
                          isbConcepts       IN VARCHAR2 DEFAULT NULL,
                          isbProg           IN diferido.difeprog%TYPE DEFAULT NULL)
    RETURN pktbldiferido.tytbDiferido IS
    /* Declaracion de variables */
    tbDiferido pktbldiferido.tytbDiferido;
    sbSql      VARCHAR2(4000);
    sbSelect   VARCHAR2(4000);
    sbFrom     VARCHAR2(4000);
    sbWhere    VARCHAR2(4000);
    cuCursor   constants.tyrefcursor;

  BEGIN

    sbSelect := 'select diferido.* ';
    sbFrom   := 'from diferido, pr_product ';


                 sbWhere := 'where difesusc=' || inuSubscriptionId ||
               ' and diferido.difefein >=  to_date(''' ||
               to_char(idtInitialDate, 'dd/mm/yyyy') ||''','''||'dd/mm/yyyy'||
               ''') and diferido.difefein < to_date(''' ||
               to_char(idtFinaldate + 1, 'dd/mm/yyyy') ||''','''||'dd/mm/yyyy'||
               ''') and diferido.difeprog = nvl( ''' || isbProg ||
               ''' , diferido.difeprog) ';

    /*Si la variable isbConcepts es nula busca todos los conceptos de refinanciancion,
    en caso contrario los que hayan sido ingresados en esta cadena.*/

    IF isbConcepts IS NOT NULL THEN
    sbWhere := sbWhere || ' and difeconc = any(' || isbConcepts || ') ';
    else
    sbWhere := sbWhere || ' and difeconc = any(SELECT DISTINCT conccore  FROM CONCEPTO WHERE conccore IS NOT NULL) ';

    END IF;

    /*Si la variable isbProductType es igual a nulo buscara todos los productos,
    en caso contrario los que se hayan ingresado en esta cadena.*/

    sbWhere := sbWhere || ' and diferido.difenuse = pr_product.product_id '||
                          ' and pr_product.PRODUCT_TYPE_ID = NVL('||NVL(inuProductType, dald_Parameter.fnuGetNumeric_Value('COD_TIPO_SERV'))||
                          ',pr_product.PRODUCT_TYPE_ID)';

    sbSql := sbSelect || sbFrom || sbWhere || 'order by difefein desc';

    /*Obtiene una tabla con todos los diferidos activos cuyo campo DIFEPROF
    sea igual a isbProg(en caso de que sea nulo este filtro se ignora) para
    todos los productos asociados al contrato y cuya fecha este entre las dos fechas de entrada.*/

    OPEN cuCursor FOR sbSql;
    FETCH cuCursor BULK COLLECT
      INTO tbDiferido;
    CLOSE cuCursor;

    RETURN tbDiferido;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ftbRefinanDife;

  PROCEDURE GetComponents(inuMotive IN NUMBER,
                          ocuCursor OUT constants.tyRefCursor) IS

    sbSql VARCHAR2(4000);

  BEGIN
    cc_boOssMotiveComponent.FillComponentAttributes;

    sbSql := ' SELECT ' || chr(10) ||
             '/*+ leading(a) index(a IDX_MO_COMPONENT_1)' || chr(10) ||
             cc_boossmotivecomponent.sbHints || chr(10) ||
             cc_boossmotivecomponent.sbAttributes || chr(10) ||
             '   FROM /*+cc_boOssMotive.GetComponents*/' || chr(10) ||
             cc_boossmotivecomponent.sbFrom || chr(10) || '  WHERE ' ||
             cc_boossmotivecomponent.sbWhere || chr(10) ||
             ' AND a.motive_id = :Motive';

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      errors.seterror;
      RAISE ex.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbOutrightFraud
  Descripcion    : Obtiene los fraudes de un usuario.

  Autor          : eramos
  Fecha          : 24/07/2012

    Parametros              Descripcion
  ============         ===================
  inuSubscriptionId: Identificacion del suscriptor.
  inuContract:       Identificador del contrato.




  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  27/09/2012        ajimenez          Se agrega cursor
  ******************************************************************/
  FUNCTION ftbOutrightFraud(inuContract       IN VARCHAR2,
                            inuSubscriptionId IN suscripc.susccodi%TYPE)
    RETURN tytbFraud

   IS
    -- Declaracion de variables
  BEGIN
    OPEN cuFraud(inuSubscriptionId, inuContract);
    FETCH cuFraud BULK COLLECT
      INTO vtabFraud;
    CLOSE cuFraud;
    RETURN vtabFraud;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ftbOutrightFraud;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ftbSuspensionNonpayment
  Descripcion    : Obtiene las suspenciones(SUSPCONE) activas asocidas al contrato,
  que esten en entre el rango de fechas ingresadas.

  Autor          : eramos
  Fecha          : 24/07/2012

    Parametros              Descripcion
  ============         ===================
  inuSubscription:     Numero de contrato.
  inuInitialDate:      Fecha Inicial Busqueda
  inuFinalDate:        Fecha Final Busqueda (default:SYSDATE)




  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  FUNCTION ftbSuspensionNonpayment(isbProductType    IN VARCHAR2,
                                   inuSubscriptionId OUT suscripc.susccodi%TYPE)
    RETURN NUMBER

   IS
    -- Declaracion de variables
  BEGIN

    NULL;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END ftbSuspensionNonpayment;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountOpenFraud
    Descripcion    : Obtiene la cantidad de fraudes abiertos de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountOpenFraud(inususcripc   in suscripc.susccodi%type,
                                 inuserv       in servsusc.sesuserv%type
                                ) return number is

    /*Declaracion de variables*/
    nuFraud number;

  Begin

    ut_trace.trace('Inicio LD_BCNonBankFiRules.fnugetAmountOpenFraud', 10);

    Select count(1)
    Into   nuFraud
    From   Fm_possible_ntl f
    Where  f.status in ('P', 'E', 'R')
    And    exists (SELECT 1
                   FROM   servsusc s
                   WHERE  s.sesususc = inususcripc
                   AND    s.sesuserv = inuserv
                   AND    s.sesunuse = f.product_id
                  );

    ut_trace.trace('Fin LD_BCNonBankFiRules.fnugetAmountOpenFraud', 10);

    Return nuFraud;

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End fnugetAmountOpenFraud;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountFraud
    Descripcion    : Obtiene la cantidad de fraudes de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountFraud(inususcripc   in suscripc.susccodi%type,
                             inuserv       in servsusc.sesuserv%type
                            ) return number is

    /*Declaracion de variables*/
    nuFraud number;

  Begin

    ut_trace.trace('Inicio LD_BCNonBankFiRules.fnugetAmountFraud', 10);

    Select count(1)
    Into   nuFraud
    From   Fm_possible_ntl f
    Where  exists (SELECT 1
                   FROM   servsusc s
                   WHERE  s.sesususc = inususcripc
                   AND    s.sesuserv = inuserv
                   AND    s.sesunuse = f.product_id
                  );

    ut_trace.trace('Fin LD_BCNonBankFiRules.fnugetAmountFraud', 10);

    Return nuFraud;

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End fnugetAmountFraud;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetAmountCloseFraud
    Descripcion    : Obtiene la cantidad de fraudes cerrados de un
                     producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetAmountCloseFraud(inususcripc   in suscripc.susccodi%type,
                                  inuserv       in servsusc.sesuserv%type
                                 ) return number is

    /*Declaracion de variables*/
    nuFraud number;

  Begin

    ut_trace.trace('Inicio LD_BCNonBankFiRules.fnugetAmountCloseFraud', 10);

    Select count(1)
    Into   nuFraud
    From   Fm_possible_ntl f
    Where  f.status in ('F')
    And    exists (SELECT 1
                   FROM   servsusc s
                   WHERE  s.sesususc = inususcripc
                   AND    s.sesuserv = inuserv
                   AND    s.sesunuse = f.product_id
                  );

    ut_trace.trace('Fin LD_BCNonBankFiRules.fnugetAmountCloseFraud', 10);

    Return nuFraud;

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End fnugetAmountCloseFraud;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fdtgetFinalDateLastFraud
    Descripcion    : Obtiene la fecha de cierre del fraude mas
                     reciente de un producto

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inuProduct           Identificador del producto

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fdtgetFinalDateLastFraud(inususcripc   in suscripc.susccodi%type,
                                    inuserv       in servsusc.sesuserv%type
                                   ) return Fm_possible_ntl.Fraud_End_Date%type is


    Cursor FinalDate is
      SELECT a.fraud_end_date
      FROM   ( SELECT  f.*
               FROM    FM_POSSIBLE_NTL f
               WHERE    f.status in ('F', 'N')
               AND     f.fraud_end_date IS NOT NULL
               AND     exists (SELECT 1
              	               FROM   servsusc s
                               WHERE  s.sesususc = inususcripc
                               AND    s.sesuserv = inuserv
                               AND    s.sesunuse = f.product_id
                              )
               ORDER BY f.fraud_end_date DESC
             ) a
      Where  rownum = 1;

    /*Declaracion de variables*/
    dtfinaldate Fm_possible_ntl.Fraud_End_Date%type;

  Begin

    ut_trace.trace('Inicio LD_BCNonBankFiRules.fdtgetFinalDateLastFraud', 10);

    For rgFinalDate in FinalDate loop
      dtfinaldate := rgFinalDate.fraud_end_date;
    End loop;

    ut_trace.trace('Fin LD_BCNonBankFiRules.fdtgetFinalDateLastFraud', 10);

    Return dtfinaldate;

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End fdtgetFinalDateLastFraud;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnugetamountsesunuse
    Descripcion    : Obtiene la cantidad de servicios suscritos a
                     partir del servicio y el contrato

    Autor          : Jonathan Alberto Consuegra
    Fecha          : 18/03/2013

    Parametros           Descripcion
    ============         ===================
    inususcripc          Identificador del contrato
    inuserv              Identificador del servicio
    inuRaiseError        Controlador de error

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    18/03/2013        jconsuegra.SAO204335  Creacion
  ******************************************************************/
  Function fnugetamountsesunuse(inususcripc   in suscripc.susccodi%type,
                                inuserv       in servsusc.sesuserv%type,
                                inuRaiseError in number default 1
                               ) return number is


    /*Declaracion de variables*/
    nurows number;

  Begin

    ut_trace.trace('Inicio LD_BCNonBankFiRules.fnugetamountsesunuse', 10);

    SELECT count(1)
    INTO   nurows
    FROM   servsusc s
    WHERE  s.sesususc = inususcripc
    AND    s.sesuserv = inuserv;

    ut_trace.trace('Fin LD_BCNonBankFiRules.fnugetamountsesunuse', 10);

    Return nurows;

  Exception
    When ex.CONTROLLED_ERROR then
       raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End fnugetamountsesunuse;

END LD_BCNONBANKFIRULES;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCNONBANKFIRULES', 'ADM_PERSON'); 
END;
/
GRANT EXECUTE on ADM_PERSON.LD_BCNONBANKFIRULES to REXEREPORTES;
/
