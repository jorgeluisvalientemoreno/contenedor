CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BOREGISTERNOVELTY AS

  /***************************************************************************
  Package: LDC_BOREGISTERNOVELTY

  Descripcion:    Metodos y funciones para el registro automatico de novedades
                  de contratistas.

  Autor: Alejandro Cardenas.
  Fecha: Octubre 07/2014

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  30/03/2015     Spacheco        CA:100-11693 : se omite commit para evitar inconsistencia,
                                 ya que est? haciendo que si ocurre alg?n error despu?s de
                                 al generaci?n de la ordenes de novedad, la orden que se esta
                                 legalizando queda en estado 5 con la actividad finalizada, con
                                 causal, etc
  28-10-2014     acardenas       NC3387. Se modifica para incluir el criterio de
                                 Departamento y Localidad.
  07-10-2014     acardenas       Creacion. NC2941
  13/07/2016     John Jairo Jimenez

  ***************************************************************************/

  ----------------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Cursores
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Funciones y Procedimientos
  ----------------------------------------------------------------------------

  FUNCTION fsbVersion return varchar2;

  /***************************************************************************
   Metodo :       GenerateNovelty
   Descripcion:   Genera la novedad segun los criterios parametrizados

   Autor       :  Alejandro Cardenas
   Fecha       :  07-10-2014

   Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  07-10-2014     acardenas       Creacion. NC2941
  ***************************************************************************/

  PROCEDURE GenerateNovelty;

END LDC_BOREGISTERNOVELTY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BOREGISTERNOVELTY AS

  /***************************************************************************
  Package: LDC_BOREGISTERNOVELTY

  Descripcion:    Metodos y funciones para el registro automatico de novedades
                  de contratistas.

  Autor: Alejandro Cardenas.
  Fecha: Octubre 07/2014

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  30/03/2015     Spacheco        CA:100-11693 : se omite commit para evitar inconsistencia,
                                 ya que est? haciendo que si ocurre alg?n error despu?s de
                                 al generaci?n de la ordenes de novedad, la orden que se esta
                                 legalizando queda en estado 5 con la actividad finalizada, con
                                 causal, etc
  28-10-2014     acardenas       NC3387. Se modifica para incluir el criterio de
                                 Departamento y Localidad.
  07-10-2014     acardenas       Creacion. NC2941
  ***************************************************************************/

  ----------------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------------
  -- Esta constante se debe modificar cada vez que se entregue el paquete
  csbVersion CONSTANT VARCHAR2(250) := 'NC3307';

  ----------------------------------------------------------------------------
  -- Cursores
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Funciones y Procedimientos
  ----------------------------------------------------------------------------

  FUNCTION fsbVersion return varchar2 IS
  BEGIN
    return csbVersion;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      ERRORS.seterror;
      raise ex.CONTROLLED_ERROR;
  END fsbVersion;

  /***************************************************************************
   Metodo :       GenerateNovelty
   Descripcion:   Genera la novedad segun los criterios parametrizados

   Autor       :  Alejandro Cardenas
   Fecha       :  07-10-2014

   Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  30/03/2015     Spacheco        CA:100-11693 : se omite commit para evitar inconsistencia,
                                 ya que est? haciendo que si ocurre alg?n error despu?s de
                                 al generaci?n de la ordenes de novedad, la orden que se esta
                                 legalizando queda en estado 5 con la actividad finalizada, con
                                 causal, etc
  01-10-2015     Spacheco        Ara:8789 si la unidad operativa es interna no registra novedad
  07-10-2014     acardenas       Creacion. NC2941

  28-10-2014     acardenas       NC3387. Se adiciona el criterio de parametrizacion
                                 Departamento y Localidad. Estos datos se extraen
                                 de la direccion asociada al producto de la orden.

  07/05/2015     SAGOMEZ         Aranda 7095 Gascaribe: si el tipo de trabajo es 1045
                                 con causal 3296 y unidad operativa 1886 no genere novedad
  ***************************************************************************/

  PROCEDURE GenerateNovelty IS
    nuOrderId     OR_order.order_id%type;
    nuCausalId    ge_causal.causal_id%type;
    nuTaskTypeId  OR_task_type.task_type_id%type;
    nuOperUnitId  OR_order.operating_unit_id%type;
    nuProductId   servsusc.sesunuse%type;
    nuAdressId    ab_address.address_id%type;
    nuDepartment  ge_geogra_location.geograp_location_id%type;
    nuLocality    ge_geogra_location.geograp_location_id%type;
    nuValidSald   number;
    sbObservation varchar2(100);
    sbEstaFinan   servsusc.sesuesfn%type;
    nuFlag        number;
    nuSuscription suscripc.susccodi%type;
    nuparavalejec ld_parameter.numeric_value%TYPE;
    nuconta       number(3);
    nucurciclo    ciclo.ciclcodi%TYPE;
    nucontatod    NUMBER(6);
    nucontadeloci NUMBER(6);
    nucontadelo   NUMBER(6);
    nucontadeci   NUMBER(6);
    nucontadeup   NUMBER(6);
    nucontade     NUMBER(6);
    nucontalociun NUMBER(6);
    nucontaloci   NUMBER(6);
    nucontalouo   NUMBER(6);
    nucontalo     NUMBER(6);
    nucontaciuo   NUMBER(6);
    nucontacicl   NUMBER(6);
    nucontaunoper NUMBER(6);
    nuofertcartra NUMBER(6);

    -- Tabla de parametrizacion

    type tytbNoveltyConds IS table of ldc_novelty_conditions%rowtype index BY binary_integer;
    tbNoveltyConds tytbNoveltyConds;

    CURSOR cuGetNoveltyCondcicltod(nuCausal number, nuTaskType number, nuDepartment number, nuLocality number,nupacuciclo NUMBER,nupaunidoper NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = nuLocality
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nupacuciclo
         AND nvl(unidad_operativa,-1) = nupaunidoper;

     CURSOR cuGetNoveltyCond2(nuCausal number, nuTaskType number, nuDepartment number, nuLocality number,nupacuciclo NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = nuLocality
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nupacuciclo
         AND nvl(unidad_operativa,-1) = -1;

     CURSOR cuGetNoveltyCond3(nuCausal number, nuTaskType number, nuDepartment number, nuLocality number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = nuLocality
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = -1;

     CURSOR cuGetNoveltyCond4(nuCausal number, nuTaskType number, nuDepartment number, nuciclo number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nuciclo
         AND nvl(unidad_operativa,-1) = -1;

     CURSOR cuGetNoveltyCond5(nuCausal number, nuTaskType number, nuDepartment number, nuunitoper number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = nuunitoper;

     CURSOR cuGetNoveltyCond6(nuCausal number, nuTaskType number, nuDepartment number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = nuDepartment
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = -1;


     CURSOR cuGetNoveltyCond7(nuCausal number, nuTaskType number, nulocali number, nuciclo NUMBER,nuunitoper number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = nulocali
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nuciclo
         AND nvl(unidad_operativa,-1) = nuunitoper;


     CURSOR cuGetNoveltyCond8(nuCausal number, nuTaskType number, nulocali number, nuciclo NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = nulocali
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nuciclo
         AND nvl(unidad_operativa,-1) = -1;


     CURSOR cuGetNoveltyCond9(nuCausal number, nuTaskType number, nulocali number, nuunioper NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = nulocali
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = nuunioper;

      CURSOR cuGetNoveltyCond10(nuCausal number, nuTaskType number, nulocali number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = nulocali
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = -1;

      CURSOR cuGetNoveltyCond11(nuCausal number, nuTaskType number, nuciclo number,nuunidad NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nuciclo
         AND nvl(unidad_operativa,-1) = nuunidad;

      CURSOR cuGetNoveltyCond12(nuCausal number, nuTaskType number, nuciclo number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = nuciclo
         AND nvl(unidad_operativa,-1) = -1;

     CURSOR cuGetNoveltyCond13(nuCausal number, nuTaskType number, nuunidad number) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE nvl(department_id,-1)    = -1
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = nuunidad;


    -- CURSOR para obtener parametrizacion sin ciclo.

    CURSOR cuGetNoveltyConds(nuCausal number, nuTaskType number, nuDepartment number, nuLocality number,nupacuciclo NUMBER) IS
      SELECT *
        FROM ldc_novelty_conditions
       WHERE --nuDepartment             = nvl(department_id, nuDepartment)
--         AND nuLocality               = nvl(locality_id, nuLocality)
          nvl(department_id,-1)       = -1
         AND nvl(locality_id,-1)      = -1
         AND task_type_id             = nuTaskType
         AND causal_id                = nuCausal
         AND nvl(ciclo,-1)            = -1
         AND nvl(unidad_operativa,-1) = -1;

    -- CURSOR para obtener los productos de un contrato

    CURSOR cuProducts(nuSusccodi number) IS
      SELECT sesunuse, sesuesfn FROM servsusc WHERE sesususc = nuSusccodi;

    -- ARA 200-98 NCZ. Se obtiene el c?digo del tipo de novedad
    nuNoveltyOrder  ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('COD_TIPO_RELA_NOVE');

    -- ARA 200-98 NCZ.
    -- Se adiciona el par?metro inuAdressId para actualizar la direcci?n de la OT de novedad con la direcci?n de la OT legalizada
    -- Se busca la ultima orden relacionada a la OT legalizada con tipo de novedad igual al par?metro COD_TIPO_RELA_NOVE
    PROCEDURE GenerateNoveltyValue(inuOperatingUnit in or_operating_unit.operating_unit_id%type,
                                     inuItemsId       in ge_items.items_id%type,
                                     inuOrderId       in OR_order.order_id%type,
                                     inuValue         in number,
                                     inuAdressId      in ab_address.address_id%type) IS
      nuError       number;
      sbError       varchar2(10000);
      sbObservation varchar2(10000);
      nuObservType  number;

      -- ARA 200-98 NCZ.
      nuOrderN       OR_order.order_id%type;
      CURSOR cuOrdenNovedad IS
        SELECT NVL(MAX(r.related_order_id),0) order_id
          FROM or_related_order r
         WHERE r.order_id = inuOrderId
           AND r.rela_order_type_id = nuNoveltyOrder;
      ------------------
    BEGIN
      -- Arma observacion de la novedad
      nuObservType  := 8901;
      sbObservation := 'Novedad de Pago Automatica Orden [' || inuOrderId || ']';

      -- Genera novedad con los datos ingresados
      OS_REGISTERNEWCHARGE(inuOperatingUnit, -- inuOperatingUnit,
                           inuItemsId, -- inuItemsId,
                           null, -- inuPersonId,
                           inuOrderId, -- inuOrderId,
                           inuValue, -- inuValueRef,
                           null, -- inuAmount,
                           nuObservType, --inuObservType,
                           sbObservation, --isbObservation,
                           nuError,
                           sbError);

      if nuError > 0 then
        errors.seterror(nuError, sbError);
        raise ex.CONTROLLED_ERROR;
      ELSE

        -- ARA 200-98 NCZ.
        -- Si se crea bien la orden de novedad, se modifica la direcci?n con la direcci?n de la OT que se legaliz?
        ut_trace.trace('Aplica OSS_CDI_NCZ_20098: '||fsbAplicaEntrega('OSS_CDI_NCZ_20098'), 10);
        if ( fsbAplicaEntrega('OSS_CDI_NCZ_20098') = 'S' ) then

          ut_trace.trace('Abre cursor cuOrdenNovedad', 10);
          OPEN cuOrdenNovedad;
          FETCH cuOrdenNovedad INTO nuOrderN;
          ut_trace.trace('Orden: '||nuOrderN, 10);

          IF ( nuOrderN <> 0 ) THEN
            daor_order.updexternal_address_id(nuOrderN, inuAdressId);
            update or_order_activity set address_id = inuAdressId
            where order_id = nuOrderN;
           /* commit;*/
            ut_trace.trace('Actualiza direcci?n: '||inuAdressId, 10);
          END IF;
          CLOSE cuOrdenNovedad;
          ut_trace.trace('Cierra cursor cuOrdenNovedad', 10);
        end if;

      END if;

    END GenerateNoveltyValue;


  BEGIN

    ut_trace.trace('INICIO [LDC_BOREGISTERNOVELTY.GenerateNovelty]', 8);

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('OrderId = ' || nuOrderId, 10);

    --Obtener causal de legalizacion
    nuCausalId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order',
                                                                  'order_id',
                                                                  'causal_id',
                                                                  nuOrderId));

    ut_trace.trace('CausalId = ' || nuCausalId, 10);

    --Obtener tipo de trabajo
    nuTaskTypeId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order',
                                                                    'order_id',
                                                                    'task_type_id',
                                                                    nuOrderId));
    ut_trace.trace('nuTaskTypeId = ' || nuTaskTypeId, 10);

    --Obtener producto asociado a la orden
    nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order_activity',
                                                                   'order_id',
                                                                   'product_id',
                                                                   nuOrderId));
    ut_trace.trace('ProductId = ' || nuProductId, 10);

    -- Obtener Direccion de la orden, localidad y departamento
    nuAdressId   := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order',
                                                                    'order_id',
                                                                    'external_address_id',
                                                                    nuOrderId));
    nuLocality   := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('ab_address',
                                                                    'address_id',
                                                                    'geograp_location_id',
                                                                    nuAdressId));
    nuDepartment := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('ge_geogra_location',
                                                                    'geograp_location_id',
                                                                    'geo_loca_father_id',
                                                                    nuLocality));
   nucurciclo := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('servsusc',
                                                                    'sesunuse',
                                                                    'sesucicl',
                                                                    nuProductId));

    ut_trace.trace('nuAdressId = ' || nuAdressId, 10);
    ut_trace.trace('nuLocality = ' || nuLocality, 10);
    ut_trace.trace('nuDepartment = ' || nuDepartment, 10);

    -- Obtiene unidad de trabajo asignada
    nuOperUnitId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order',
                                                                    'order_id',
                                                                    'operating_unit_id',
                                                                    nuOrderId));
    ut_trace.trace('nuUniTrabajo = ' || nuOperUnitId, 10);

    -- No genera novedad para las unidades de trabajo del nuevo esquema de liquidaci?n
    nuparavalejec := dald_parameter.fnuGetNumeric_Value('VARIABLE_EJECUTA_VAL_NOVE');
     IF nuparavalejec = 1 THEN
       EXECUTE IMMEDIATE 'SELECT COUNT(1) FROM ldc_const_unoprl ue WHERE ue.unidad_operativa = '||nuOperUnitId||' AND ue.tipo_ofertado = 2' INTO nuofertcartra;
       SELECT COUNT(1) INTO nuconta
         FROM ldc_const_unoprl ue
        WHERE ue.unidad_operativa = nuOperUnitId;
          IF nuconta >= 1 AND nuofertcartra = 0 THEN
            RETURN;
          END IF;
     END IF;

    --Aranda 7095 Gascaribe: si el tipo de trabajo es 1045 con causal 3296 y unidad operativa 1886
    --no genere novedad
    --valida que sea Gascaribe
    if (pktblsistema.fsbgetsistnitc(99) =
       Dald_parameter.fsbGetValue_Chain('NIT_GDC')) then
      --valida que el tipo de trabajo sea 10445 con causal 3296 y cuadrilla 1886
      if (nuTaskTypeId =
         (Dald_parameter.fnuGetNumeric_Value('COD_TAS_TYP_TRA_REPA', null)) and
         nuCausalId =
         (Dald_parameter.fnuGetNumeric_Value('COD_CAU_REPAPEN', null)) and
         nuOperUnitId =
         (Dald_parameter.fnuGetNumeric_Value('ID_OPER_UNIT_LEG_OT_RP',
                                              null))) or
         (daor_operating_unit.fnugetcontractor_id(nuOperUnitId) is null) then-- Spacheco Ara:8789 si la unidad operativa es interna no registra novedad

        --En caso de cumplir las copndiciones no se debe de generar ninguan
        --notificacion
        return;

      end if;

    end if;
----------------------- Todos-------------------------------

   -- Existen todas las condiciones para el ciclo
   nucontatod := 0;
   SELECT COUNT(1) INTO nucontatod
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = nucurciclo
      AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

----------------------- Departamento-------------------------------

   -- Existen la Departamento, localidad y ciclo
   nucontadeloci := 0;
   SELECT COUNT(1) INTO nucontadeloci
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = nucurciclo
      AND nvl(x.unidad_operativa,-1) = -1;

   -- Existen la Departamento y localidad
   nucontadelo := 0;
   SELECT COUNT(1) INTO nucontadelo
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = -1
      AND nvl(x.unidad_operativa,-1) = -1;

   -- Existen la Departamento y ciclo
   nucontadeci := 0;
   SELECT COUNT(1) INTO nucontadeci
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = -1
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = nucurciclo
      AND nvl(x.unidad_operativa,-1) = -1;

   -- Existen la Departamento y unidad operativa
   nucontadeup := 0;
   SELECT COUNT(1) INTO nucontadeup
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = -1
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = -1
      AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

   -- Existen la Departamento
   nucontade := 0;
   SELECT COUNT(1) INTO nucontade
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = nuDepartment
      AND nvl(x.locality_id,-1)      = -1
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = -1
      AND nvl(x.unidad_operativa,-1) = -1;

--------------------------Localidad-----------------------------------
   -- Existen la localidad, ciclo y unidad operativa
   nucontalociun := 0;
   SELECT COUNT(1) INTO nucontalociun
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = -1
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = nucurciclo
      AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

   -- Existen la localidad y ciclo
   nucontaloci := 0;
   SELECT COUNT(1) INTO nucontaloci
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = -1
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = nucurciclo
      AND nvl(x.unidad_operativa,-1) = -1;

   -- Existen la localidad y unidad operativa
   nucontalouo := 0;
   SELECT COUNT(1) INTO nucontalouo
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = -1
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = -1
      AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

   -- Existen la localidad
   nucontalo := 0;
   SELECT COUNT(1) INTO nucontalo
     FROM ldc_novelty_conditions x
    WHERE nvl(x.department_id,-1)    = -1
      AND nvl(x.locality_id,-1)      = nuLocality
      AND x.task_type_id             = nuTaskTypeId
      AND x.causal_id                = nuCausalId
      AND nvl(x.ciclo,-1)            = -1
      AND nvl(x.unidad_operativa,-1) = -1;

 ----------------------Ciclo---------------------------------------------------------------------------
  -- Existen Ciclo y la unidad operativa
    nucontaciuo := 0;
    SELECT COUNT(1) INTO nucontaciuo
      FROM ldc_novelty_conditions x
     WHERE nvl(x.department_id,-1)    = -1
       AND nvl(x.locality_id,-1)      = -1
       AND x.task_type_id             = nuTaskTypeId
       AND x.causal_id                = nuCausalId
       AND nvl(x.ciclo,-1)            = nucurciclo
       AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

 -- Existen ciclo
    nucontacicl := 0;
    SELECT COUNT(1) INTO nucontacicl
      FROM ldc_novelty_conditions x
     WHERE nvl(x.department_id,-1)    = -1
       AND nvl(x.locality_id,-1)      = -1
       AND x.task_type_id             = nuTaskTypeId
       AND x.causal_id                = nuCausalId
       AND nvl(x.ciclo,-1)            = nucurciclo
       AND nvl(x.unidad_operativa,-1) = -1;

-------------------Unidad operativa---------------------------------

  -- Existen unidad operativa
  nucontaunoper := 0;
    SELECT COUNT(1) INTO nucontaunoper
      FROM ldc_novelty_conditions x
     WHERE nvl(x.department_id,-1)    = -1
       AND nvl(x.locality_id,-1)      = -1
       AND x.task_type_id             = nuTaskTypeId
       AND x.causal_id                = nuCausalId
       AND nvl(x.ciclo,-1)            = -1
       AND nvl(x.unidad_operativa,-1) = nuOperUnitId;

------------------------------------------------------------------------
   IF nucontatod >= 1 THEN
      OPEN cuGetNoveltyCondcicltod(
                                   nuCausalId,
                                   nuTaskTypeId,
                                   nuDepartment,
                                   nuLocality,
                                   nucurciclo,
                                   nuOperUnitId
                                  );
     FETCH cuGetNoveltyCondcicltod BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCondcicltod;
   ELSIF nucontadeloci >= 1 THEN
      OPEN cuGetNoveltyCond2(
                              nuCausalId,
                              nuTaskTypeId,
                              nuDepartment,
                              nuLocality,
                              nucurciclo
                             );
     FETCH cuGetNoveltyCond2 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond2;
   ELSIF nucontadelo >=1 THEN
      OPEN cuGetNoveltyCond3(
                              nuCausalId,
                              nuTaskTypeId,
                              nuDepartment,
                              nuLocality
                             );
     FETCH cuGetNoveltyCond3 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond3;
   ELSIF nucontadeci >=1 THEN
      OPEN cuGetNoveltyCond4(
                              nuCausalId,
                              nuTaskTypeId,
                              nuDepartment,
                              nucurciclo
                             );
     FETCH cuGetNoveltyCond4 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond4;
   ELSIF nucontadeup >= 1 THEN
      OPEN cuGetNoveltyCond5(
                              nuCausalId,
                              nuTaskTypeId,
                              nuDepartment,
                              nuOperUnitId
                             );
     FETCH cuGetNoveltyCond5 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond5;
   ELSIF nucontade >= 1 THEN
      OPEN cuGetNoveltyCond6(
                              nuCausalId,
                              nuTaskTypeId,
                              nuDepartment
                             );
     FETCH cuGetNoveltyCond6 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond6;
   ELSIF nucontalociun >= 1 THEN
      OPEN cuGetNoveltyCond7(
                              nuCausalId,
                              nuTaskTypeId,
                              nuLocality,
                              nucurciclo,
                              nuOperUnitId
                             );
     FETCH cuGetNoveltyCond7 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond7;
   ELSIF nucontaloci >= 1 THEN
      OPEN cuGetNoveltyCond8(
                              nuCausalId,
                              nuTaskTypeId,
                              nuLocality,
                              nucurciclo
                             );
     FETCH cuGetNoveltyCond8 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond8;
   ELSIF nucontalouo >= 1 THEN
      OPEN cuGetNoveltyCond9(
                              nuCausalId,
                              nuTaskTypeId,
                              nuLocality,
                              nuOperUnitId
                             );
     FETCH cuGetNoveltyCond9 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond9;
   ELSIF nucontalo >= 1 THEN
      OPEN cuGetNoveltyCond10(
                              nuCausalId,
                              nuTaskTypeId,
                              nuLocality
                             );
     FETCH cuGetNoveltyCond10 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond10;
   ELSIF nucontaciuo >= 1 THEN
      OPEN cuGetNoveltyCond11(
                              nuCausalId,
                              nuTaskTypeId,
                              nucurciclo,
                              nuOperUnitId
                             );
     FETCH cuGetNoveltyCond11 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond11;
   ELSIF nucontacicl >= 1 THEN
      OPEN cuGetNoveltyCond12(
                              nuCausalId,
                              nuTaskTypeId,
                              nucurciclo
                             );
     FETCH cuGetNoveltyCond12 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond12;
   ELSIF nucontaunoper >= 1 THEN
      OPEN cuGetNoveltyCond13(
                              nuCausalId,
                              nuTaskTypeId,
                              nuOperUnitId
                             );
     FETCH cuGetNoveltyCond13 BULK COLLECT
      INTO tbNoveltyConds;
     CLOSE cuGetNoveltyCond13;
   ELSE
    OPEN cuGetNoveltyConds(
                           nuCausalId,
                           nuTaskTypeId,
                           nuDepartment,
                           nuLocality,
                           nucurciclo
                          );
   FETCH cuGetNoveltyConds BULK COLLECT
    INTO tbNoveltyConds;
   CLOSE cuGetNoveltyConds;
  END IF;

  if tbNoveltyConds.last > 0 then

      for pos in tbNoveltyConds.first .. tbNoveltyConds.last loop

        -- Determina si se valida el saldo de cartera del producto
        nuValidSald := tbNoveltyConds(pos).val_balance;

        --Si la cuadrilla es la 1886

        if nuValidSald IS null then
          -- Genera novedad sin validar cartera
          GenerateNoveltyValue(nuOperUnitId,
                               tbNoveltyConds(pos).item_id,
                               nuOrderId,
                               tbNoveltyConds(pos).value_reference,
                               nuAdressId);

        elsif nuValidSald = 1 then
          -- Valida que todos los productos del contrato esten AL DIA o EN DEUDA
          nuSuscription := pktblservsusc.fnugetsesususc(nuProductId);
          nuFlag        := 0;

          for reg in cuProducts(nuSuscription) loop
            if reg.sesuesfn = 'M' OR reg.sesuesfn = 'C' then
              nuFlag := 1;
            END if;
          END loop;

          if nuFlag = 0 then
            GenerateNoveltyValue(nuOperUnitId,
                                 tbNoveltyConds(pos).item_id,
                                 nuOrderId,
                                 tbNoveltyConds(pos).value_reference,
                                 nuAdressId);
          END if;

        elsif nuValidSald = 2 then
          -- Obtiene Estado Financiero del producto asociado a la orden
          sbEstaFinan := pktblservsusc.fsbgetsesuesfn(nuProductId);

          -- Solo genera novedad si el producto de GAS esta AL DIA o EN DEUDA
          if sbEstaFinan = 'A' OR sbEstaFinan = 'D' then

            GenerateNoveltyValue(nuOperUnitId,
                                 tbNoveltyConds(pos).item_id,
                                 nuOrderId,
                                 tbNoveltyConds(pos).value_reference,
                                 nuAdressId);
          END if;

        END if;

      END loop;

    END if;

    ut_trace.trace('FIN [LDC_BOREGISTERNOVELTY.GenerateNovelty]', 8);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END GenerateNovelty;

END LDC_BOREGISTERNOVELTY;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOREGISTERNOVELTY', 'ADM_PERSON');
END;
/