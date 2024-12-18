create or replace PROCEDURE      adm_person.LDC_PRGENESOLSACRP IS
  /**************************************************************************
  Autor       : OLSOFTWARE
  Fecha       : 2021-01-25
  Proceso     : PRELICARGCERT
  Ticket      : 547
  Descripcion : plugin que se encargue de generar solicitud SAC y solicitudes RP

  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  16/04/2021   MABG        Caso 736: Se hace la validaci?n del aplica entrega para la gasera del caso 736, si el caso aplica
                           no realice la validaci?n del tr?mite de reconexi?n y ordenes de persecuci?n del plugin.
  25/11/2021   DANVAL      CA 833_1 : Si el Tipo de Trabajo est? definido en TIPOTRABAJO_FALLORP y causal esta CAUSAL_FALLORP, se consultar? la orden en OR_REQU_DATA_VALUE con el dato adicional definido en DATOADICION_UNIDADOPER, se validara si la Unidad existe en OR_OPERATING_UNIT para crear las solicitudes con el servicio LDC_PRGENERECOCMRP o LDC_PRGENERECOACRP seg?n la marca del producto
  28/02/2022   DSALTARIN   GLPI 949: Se corrige validacion. Si el producto tiene solicitud de reconexion u ordenes de persecucion no se generfa solicitud de RP
  16/05/2022   DSALTARIN   OSF-268: Antes de generar solicitud SAC se debe validar que no exista otra en proceso. Se eliminan aplica entrega de casos anteriores.
                           Se elimina codigo en comentario, variables no usadas, etc. 
  28/05/2024   PAcosta     OSF-2760: Cambio de esquema ADM_PERSON    
                           Retiro marcacion esquema .open objetos de lógica                            
  ***************************************************************************/
  
                                                                                    
  nuOrderId         NUMBER; --se almacena orden de trabajo
  nuProducto        NUMBER;

  nuNumesRp         ldc_pararepe.parevanu%type := DALDC_PARAREPE.FNUGETPAREVANU('LDC_NUMESEDADRP',
                                                                                 null);
  nuSoliReinRp      ldc_pararepe.parevanu%type := DALDC_PARAREPE.FNUGETPAREVANU('LDC_SOLIREINRP',
                                                                                 null);
  numedRecRp        ldc_pararepe.parevanu%type := DALDC_PARAREPE.FNUGETPAREVANU('LDC_MEDIRECERP',
                                                                                 null);
  nuprocAutorec     ldc_pararepe.parevanu%type := dald_parameter.fnuGetNumeric_Value('LDC_PROCAUTORECO',
                                                                                      null);

  sbTipoTrabRp      ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('LDC_TIPOTRABRPVALI',
                                                                                    NULL);
  sbEstaorden       ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('LDC_ESTAORVALRP',
                                                                                    NULL);
  sbTiposuspRp      ld_parameter.value_chain%type := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPO_SUSPENSION_RP',
                                                                                          NULL);
  sbTiTrPortal      ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('LDC_TIPOTRABPORTAL',
                                                                                    NULL);
  sbdatos           VARCHAR2(100);
  nuestadoProducto  pr_product.product_status_id%type;
  nuEstacort        servsusc.sesuesco%type;
  sbEstadoFina      servsusc.sesuesfn%type;
  nuTitrOt          or_order.task_type_id%type;
  nuEdadRP          NUMBER;
  nuPackageId       NUMBER;
  nuMotiveId        NUMBER;
  ONUERRORCODE      NUMBER := null;
  OSBERRORMESSAGE   VARCHAR2(4000);
  nuGeneraTram      NUMBER:=1;

  --se consulta cargos de certificacion
  CURSOR cuGetProducto IS
    SELECT oa.product_id, p.product_status_id, sesuesfn, sesuesco
      FROM or_order_activity oa, pr_product p, servsusc
     WHERE oa.order_id = nuOrderId
       AND oa.product_id = p.product_id
       AND oa.product_id = sesunuse;

  --se valida tipo de suspension de rp
  CURSOR cuValIdaTipoSus IS
    SELECT 'X'
      FROM pr_prod_suspension
     WHERE product_id = nuproducto
       AND suspension_type_id NOT IN
           (SELECT to_number(regexp_substr(sbTiposuspRp, '[^,]+', 1, LEVEL)) AS tiposusp
              FROM dual
            CONNECT BY regexp_substr(sbTiposuspRp, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND active = 'Y';

  --se valida tramite de reinstalacion
  CURSOR cuValidaSolReins IS
    SELECT 'X'
      FROM mo_packages s, or_order_activity oa
     WHERE s.package_id = oa.package_id
       AND s.package_type_id = nuSoliReinRp
       AND s.motive_status_id = 13
       AND oa.product_id = nuproducto;

  --se valida ordenes de autoreconectado
  CURSOR cuValidaOrdenPers IS
    SELECT TO_CHAR(O.ORDER_ID)
      FROM or_order_activity oa, ldc_actividad_generada s, or_order o
     WHERE s.proceso_id = nuprocAutorec
       AND oa.product_id = nuproducto
       AND o.order_id = oa.order_id
       AND OA.ACTIVITY_ID = s.PROXIMA_ACTIVITY_ID
       AND O.ORDER_ID != nuOrderId
       AND o.order_status_id not in
           (SELECT os.order_status_id
              FROM or_order_status os
             WHERE IS_FINAL_STATUS = 'Y');

  --se valida ordenes de rp
  CURSOR cuValidaOrdenRP IS
    SELECT DISTINCT valor
      FROM (SELECT 'x' valor
              FROM or_order_activity oa, or_order o
             WHERE oa.product_id = nuproducto
               AND o.order_id = oa.order_id
               AND o.order_status_id = 7
               AND o.task_type_id in
                   (SELECT to_number(regexp_substr(sbTipoTrabRp,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS titr
                      FROM dual
                    CONNECT BY regexp_substr(sbTipoTrabRp, '[^,]+', 1, LEVEL) IS NOT NULL)
            UNION
            SELECT 'X' valor
              FROM mo_packages s, mo_motive m
             WHERE s.package_id = m.package_id
               AND s.package_type_id = 100306
               AND m.product_id = nuproducto
               AND s.motive_status_id = 13);

  --se valida ordenes de rp
  CURSOR cuValidaOrdenRPPend IS
    SELECT o.order_id,
           (SELECT so.comment_ || ', orden generada ' || o.order_id
              FROM mo_packages so
             WHERE so.package_id = oa.package_id) comentario,
           oa.ACTIVITY_ID,
           oa.PACKAGE_ID,
           oa.PRODUCT_ID,
           oa.SUBSCRIPTION_ID,
           oa.ADDRESS_ID
      FROM or_order_activity oa, or_order o
     WHERE oa.product_id = nuproducto
       AND o.order_id = oa.order_id
       AND o.order_status_id in
           (SELECT to_number(regexp_substr(sbEstaorden, '[^,]+', 1, LEVEL)) AS estado
              FROM dual
            CONNECT BY regexp_substr(sbEstaorden, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND o.task_type_id in
           (SELECT to_number(regexp_substr(sbTipoTrabRp, '[^,]+', 1, LEVEL)) AS titr
              FROM dual
            CONNECT BY regexp_substr(sbTipoTrabRp, '[^,]+', 1, LEVEL) IS NOT NULL);

  regOrdenPednRP cuValidaOrdenRPPend%ROWTYPE;

  CURSOR cuGetactividadGen(inuactividad number) IS
    SELECT s.ACTIVITY_ID
      FROM LDC_ACTIVI_BY_PACK_TYPE s
     WHERE s.PACKAGE_TYPE_ID = 100306
       AND s.ACTIVIDADES_REV_PER is not null
       AND inuactividad IN
           (SELECT to_number(column_value)
              FROM TABLE(ldc_boutilities.splitstrings(s.ACTIVIDADES_REV_PER,
                                                           ',')));

  nuactividadGene NUMBER;
  sbTipoSusp      VARCHAR2(10);

  -- datos para generar xml
  CURSOR cudatosXml IS
    SELECT di.ADDRESS_PARSED,
           di.ADDRESS_ID,
           di.GEOGRAP_LOCATION_ID,
           pr.CATEGORY_ID,
           pr.SUBCATEGORY_ID,
           pr.SUBSCRIPTION_ID,
           sc.SUSCCLIE SUBSCRIBER_ID,
           pr.product_id
      FROM pr_product pr, SUSCRIPC sc, ab_address di
     WHERE pr.ADDRESS_ID = di.ADDRESS_ID
       AND pr.SUBSCRIPTION_ID = sc.SUSCCODI
       AND pr.product_id = nuproducto;

  regProducto cudatosXml%rowtype;

  sbSolRecon    VARCHAR2(1) := 'N';
  sbOtPersec    VARCHAR2(1) := 'N';
  sbComment     VARCHAR2(4000);
  nuExisteSac   NUMBER;
  --
BEGIN

    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizANDo

    --CAMBIO 949
    --Obtener comentario de la solicitude asociada a la orden legalizada.
    BEGIN
      SELECT mp.comment_ 
        INTO sbComment
        FROM Or_Order_Activity ooa, mo_packages mp
       WHERE ooa.package_id = mp.package_id
         AND ooa.order_id = nuOrderId;

    EXCEPTION
      WHEN OTHERS THEN
        sbComment := null;
    END;
    ---------------------

    nuTitrOt := daor_order.fnugettask_type_id(nuOrderId, null);

    --se obtiene producto
    OPEN cuGetProducto;
    FETCH cuGetProducto
    INTO nuProducto, nuestadoProducto, sbEstadoFina, nuEstacort;
      IF cuGetProducto%NOTFOUND THEN
        CLOSE cuGetProducto;
        ERRORS.SETERROR(2741,
                        'Orden de trabajo [' || nuOrderId ||
                        '] no tiene informacion de producto.');
        RAISE ex.controlled_error;
      END IF;
    CLOSE cuGetProducto;

    OPEN cudatosXml;
    FETCH cudatosXml
    INTO regProducto;
    close cudatosXml;

    --se valida que el producto no este casticado
    IF sbEstadoFina = 'C' or nuEstacort = 5 THEN
      ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp('LDC_PRGENESOLSACRP',
                                                            SYSDATE,
                                                            nuOrderId,
                                                            null,
                                                            'Producto [' ||
                                                            nuProducto ||
                                                            '] se encuentra castigado',
                                                            USER);
      ERRORS.SETERROR(2741,
                      'Producto [' || nuProducto ||
                      '] se encuentra castigado');
      RAISE ex.controlled_error;
    END IF;

    --se valida tipo de suspension activa
    OPEN cuValIdaTipoSus;
    FETCH cuValIdaTipoSus
    INTO sbdatos;
      IF cuValIdaTipoSus%FOUND THEN
        ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp('LDC_PRGENESOLSACRP',
                                                              SYSDATE,
                                                              nuOrderId,
                                                              null,
                                                              'Producto [' ||
                                                              nuProducto ||
                                                              '] no se encuentra suspendido por RP',
                                                              USER);
        ERRORS.SETERROR(2741,
                        'Producto [' || nuProducto ||
                        '] no se encuentra suspendido por RP');
        RAISE ex.controlled_error;
      END IF;
    CLOSE cuValIdaTipoSus;

    --se valida edad rp
    nuEdadRP := LDC_GETEDADRP(nuProducto);

    IF instr(sbTiTrPortal, nuTitrOt || ',') > 0 THEN
      IF nuEdadRP <= nuNumesRp THEN
        ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp('LDC_PRGENESOLSACRP',
                                                              SYSDATE,
                                                              nuOrderId,
                                                              null,
                                                              'Producto [' ||
                                                              nuProducto ||
                                                              '] no tiene la edad de RP correspondiente para este proceso.',
                                                              USER);
        ERRORS.SETERROR(2741,
                        'Producto [' || nuProducto ||
                        '] no tiene la edad de RP correspondiente para este proceso.');
        RAISE ex.controlled_error;
      END IF;
    END IF;



    --se valida orden de rp ejecutadas
    IF instr(sbTiTrPortal, nuTitrOt || ',') > 0 THEN
      OPEN cuValidaOrdenRP;
      FETCH cuValidaOrdenRP
      INTO sbdatos;
        IF cuValidaOrdenRP%FOUND THEN
          RETURN;
        END IF;
      CLOSE cuValidaOrdenRP;
    END IF;

    --se valida orden de rp pendiente
    IF instr(sbTiTrPortal, nuTitrOt || ',') > 0 THEN
      FOR regOrdenPednRP in cuValidaOrdenRPPend LOOP
        --OSF-268
        BEGIN
          SELECT count(1)
            INTO nuExisteSac
            FROM ldc_asigna_unidad_rev_per sac
            INNER JOIN mo_packages p ON sac.solicitud_generada = p.package_id and package_type_id=100306 and p.motive_status_id = 13
            INNER JOIN or_order_activity a on a.package_id =  p.package_id
            INNER JOIN or_order o on o.order_id = a.order_id and o.order_status_id not in (8,12)
          WHERE sac.orden_trabajo = regOrdenPednRP.order_id;
        EXCEPTION
          WHEN OTHERS THEN
            nuExisteSac := 0;
        END;
        IF nuExisteSac = 0 THEN
          IF cuGetactividadGen%isopen THEN
            CLOSE cuGetactividadGen;
          END IF;

          OPEN cuGetactividadGen(regOrdenPednRP.ACTIVITY_ID);
          FETCH cuGetactividadGen
          INTO nuactividadGene;
          CLOSE cuGetactividadGen;

          IF nuactividadGene is not null THEN

            ldc_pkgeneraTramiteRp.prGenera100306(numedRecRp,
                                                SUBSTR('Solicitud generada por proceso LDC_PRGENESOLSACRP, legalizacion de la orden [' ||
                                                nuOrderId || '] '||sbComment,0,1999),
                                                regProducto.SUBSCRIBER_ID,
                                                regProducto.PRODUCT_ID,
                                                regProducto.SUBSCRIPTION_ID,
                                                regProducto.ADDRESS_ID,
                                                sysdate,
                                                ge_bopersonal.fnugetpersonid,
                                                nuactividadGene,
                                                regOrdenPednRP.ORDER_ID,
                                                ge_bopersonal.fnugetcurrentchannel(ge_bopersonal.fnugetpersonid,
                                                                                    null),
                                                nuPackageId,
                                                nuMotiveId,
                                                ONUERRORCODE,
                                                OSBERRORMESSAGE);
            IF ONUERRORCODE <> 0 THEN
              ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp('LDC_PRGENESOLSACRP',
                                                                    SYSDATE,
                                                                    nuOrderId,
                                                                    null,
                                                                    'Error al generar proceso de Rp [' ||
                                                                    OSBERRORMESSAGE || ']',
                                                                    USER);
              ERRORS.SETERROR(2741,
                              'Error al generar proceso de Rp [' ||
                              OSBERRORMESSAGE || ']' || '/' ||
                              regOrdenPednRP.ORDER_ID);
              RAISE ex.controlled_error;
            END IF;
            EXIT;
          END IF;
        ELSE
          nuGeneraTram := 0;
        END IF;
      END LOOP;
    END IF;
  

    OPEN cuValidaSolReins;
    FETCH cuValidaSolReins
    INTO sbdatos;
      IF cuValidaSolReins%found THEN
          sbSolRecon := 'S';
      ELSE
          sbSolRecon :='N';
      END IF;
    CLOSE cuValidaSolReins;


      --se valida orden de persecucion

    OPEN cuValidaOrdenPers;
    FETCH cuValidaOrdenPers
    INTO sbdatos;
      IF cuValidaOrdenPers%found THEN
         sbOtPersec :='S';
      ELSE
         sbOtPersec :='N';
      END IF;
    CLOSE cuValidaOrdenPers;

    
    IF nuactividadGene is null AND sbSolRecon = 'N' AND sbOtPersec = 'N' AND nuGeneraTram = 1 THEN

      -- Consultamos que marca tiene el producto
      sbTipoSusp := ldc_fsbvalidasuspcemoacomprod(nuProducto);
      --
      IF upper(sbTipoSusp) = 'CM' or sbTipoSusp is null THEN
        LDC_PRGENERECOCMRP;
      elsif (upper(sbTipoSusp) = 'AC') then
        --Se genera reconexion
        LDC_PRGENERECOACRP;
      end if;

    end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when OTHERS then
    errors.seterror;
    raise ex.CONTROLLED_ERROR;
END LDC_PRGENESOLSACRP;

/
PROMPT Otorgando permisos de ejecucion a LDC_PRGENESOLSACRP
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRGENESOLSACRP', 'ADM_PERSON');
END;
/