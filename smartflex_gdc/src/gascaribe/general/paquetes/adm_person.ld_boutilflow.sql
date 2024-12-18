CREATE OR REPLACE PACKAGE adm_person.LD_BOUtilFlow IS

  /*****************************************************************
   Declaracion de variables
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOFlowOpen
  Descripcion    : Paquete con los servicios del flujo de venta.
  Autor          :
  Fecha          : 28/06/13

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  FUNCTION fnuGenerateInternalBill
  (
    inuPackageId    in mo_packages.package_id%type,
    inuProductId    in pr_product.product_id%type
  )
  return factura.factcodi%type;


  function fnuGetPersonToLegal(inuOperatingUnit in OR_order.operating_unit_id%type)
  return number;

  PROCEDURE getAVailableUnit
  (
   onuzoneid        out OR_operating_zone.operating_zone_id%type,
   onuOperatingUnit out OR_operating_unit.operating_unit_id%type
  );

  PROCEDURE ProcValidateProduct(inuSubscriptionId in suscripc.susccodi%type);

  PROCEDURE GetSubscriberBySusc(inuSuscripc in suscripc.susccodi%type,
                                onuValue    out ge_subscriber.subscriber_id%type);


    FUNCTION fnuGetSupplierConect return number;

END LD_BOUtilFlow;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOUtilFlow IS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOUtilFlow
  Descripcion    : Paquete con los servicios del flujo de venta.
  Autor          : Eduar Ramos Barragan
  Fecha          : 09/01/13 09:55:27 a.m.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/

  /* Declaracion de Tipos de datos privados */

  /* Declaracion de constantes privados */

  /* Declaracion de variables privados */

  /* Declaracion de funciones y procedimientos */

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuGenerateInternalBill
  Descripcion    : Crea una factura interna con saldo cero, cuenta de cobro sin cargos.

  Autor          :
  Fecha          : 28/06/2013

  Parametros              Descripcion
  ============         ===================
  inuSubscriptionId    Código del contrato

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGenerateInternalBill
  (
    inuPackageId    in mo_packages.package_id%type,
    inuProductId    in pr_product.product_id%type
  )
  return factura.factcodi%type
  IS
    nuFacturaId         FACTURA.FACTCODI%TYPE;
    nuSubscriptionId    suscripc.susccodi%type;
  BEGIN

    ut_trace.trace('Inicio LD_BOUtilFlow.fnuGenerateInternalBill  inuPackageId '|| inuPackageId,5);

    nuSubscriptionId := damo_packages.fnugetsubscription_pend_id(inuPackageId);
    ut_trace.trace('nuSubscriptionId '|| nuSubscriptionId,5);

    errors.setapplication('FGCC');

    nuFacturaId := pkGenerateIndBill.fnuGenerateInternalBill(nuSubscriptionId, inuProductId);

    ut_trace.trace('Fin LD_BOUtilFlow.fnuGenerateInternalBill nuFacturaId '|| nuFacturaId,5);

    return nuFacturaId;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuGenerateInternalBill;


  function fnuGetPersonToLegal(inuOperatingUnit in OR_order.operating_unit_id%type)
  return number
  IS

    inuValid number := null;
    nuPersonId ge_person.person_id%type;
    CURSOR CuIsValidPerson(inuUnit in OR_order.operating_unit_id%type, inuPerson ge_person.person_id%type)
       IS
       SELECT 1 FROM or_oper_unit_persons
        WHERE operating_unit_id = inuUnit
            AND person_id = inuPerson;

    CURSOR cuGetFirstPerson(inuUnit in OR_order.operating_unit_id%type)
     IS
     SELECT person_id FROM or_oper_unit_persons
        WHERE operating_unit_id = inuUnit
        AND rownum = 1;

  BEGIN

   nuPersonId := ge_bopersonal.fnugetpersonid;

    open CuIsValidPerson( inuOperatingUnit, nuPersonId);
    fetch CuIsValidPerson INTO inuValid;
    close  CuIsValidPerson;

    if (inuValid = 1) then
        return nuPersonId;
    else
        open cuGetFirstPerson( inuOperatingUnit);
        fetch cuGetFirstPerson INTO inuValid;
        close  cuGetFirstPerson;
        nuPersonId := inuValid;
        return nuPersonId;
    END if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuGetPersonToLegal;



  PROCEDURE getAVailableUnit
  (
   onuzoneid        out OR_operating_zone.operating_zone_id%type,
   onuOperatingUnit out OR_operating_unit.operating_unit_id%type
  )
  is
        cnuERR_AVAILABLE    CONSTANT ge_message.message_id%type := 18243;
        tbOperUnit          daor_operating_unit.tytbOperating_unit_id;
        rcAvailable         daor_sched_available.styOR_sched_available;
        sbRol_exception     or_sched_available.rol_exception_flag%type;
        nuAvailableId       or_sched_available.sched_available_id%type;
        sbPriority          or_actividad.prioridad_despacho%type;
        nuIndex             number;

        FUNCTION ftbGetOpeUniByPerson
        (
            inuPersonId       in OR_operating_unit.person_in_charge%type
        )
        return daor_operating_unit.tytbOperating_unit_id
        IS

            nuPersonId          ge_person.person_id%type;
            tbOperatingUnit     daor_operating_unit.tytbOperating_unit_id;
            nuClass             or_oper_unit_classif.oper_unit_classif_id%type;

            CURSOR cuOpeUniByPerson(inuPerson in number)
            IS SELECT or_operating_unit.operating_unit_id
              FROM or_operating_unit,
                   or_oper_unit_persons
             WHERE or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id
                AND or_oper_unit_persons.person_id = inuPerson;
        BEGIN

            -- Obtiene la unida operativa que le corresponde
            IF cuOpeUniByPerson%isopen THEN
                close cuOpeUniByPerson;
            END IF;

            OPEN cuOpeUniByPerson(inuPersonId);
            FETCH cuOpeUniByPerson BULK COLLECT INTO tbOperatingUnit;
            CLOSE cuOpeUniByPerson;

            RETURN tbOperatingUnit;

        EXCEPTION
            WHEN ex.CONTROLLED_ERROR THEN
                RAISE ex.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                Errors.setError;
                RAISE ex.CONTROLLED_ERROR;
        END ftbGetOpeUniByPerson;

    BEGIN

        tbOperUnit := ftbGetOpeUniByPerson( GE_BOPersonal.fnuGetPersonId );

        IF (tbOperUnit.count = 0) THEN
            Errors.SetError(cnuERR_AVAILABLE );
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuIndex := tbOperUnit.first;
        LOOP

            BEGIN
                or_boadminorder.getAvailableDispach
                (
                    tbOperUnit(nuIndex),
                    sysdate,
                    sbRol_exception,
                    nuAvailableId,
                    sbPriority
                );
            EXCEPTION
                WHEN others THEN
                    sbRol_exception := null;
                    nuAvailableId := null;
                    sbPriority := null;
                    IF (nuIndex = tbOperUnit.last) THEN
                        Errors.setError;
                        RAISE ex.CONTROLLED_ERROR;
                    END If;
            END;

            IF ( nuIndex = tbOperUnit.last) OR
               ( nuAvailableId IS NOT NULL) THEN
               exit when TRUE;
            END IF;

            nuIndex := tbOperUnit.Next(nuIndex);

        END LOOP;

        daor_sched_available.getRecord(nuAvailableId, rcAvailable);
        onuzoneid :=  rcAvailable.operating_zone_id;
        onuOperatingUnit := tbOperUnit(nuIndex);

    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END getAVailableUnit;



  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : GetSubscriberBySusc
  Descripcion    : Obtiene el subscriber a partir del contrato
  Autor          : AAcuna
  Fecha          : 03/10/2012 SAO 147879

  Parametros         Descripción
  ============   ===================
  inuSuscripc:     Número de suscripción
  onuValue:        Valor de retorno

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE GetSubscriberBySusc(inuSuscripc in suscripc.susccodi%type,
                                onuValue    out ge_subscriber.subscriber_id%type)

   IS

  BEGIN
    ut_trace.Trace('INICIO LD_BOUtilFlow.GetSubscriberBySusc', 10);

    SELECT /*+ index(pk_suscripc) use_nl(suscripc ges)*/
     suscclie
      INTO onuValue
      FROM suscripc, ge_subscriber ge
     WHERE ge.subscriber_id = suscclie
       AND susccodi = inuSuscripc;

    ut_trace.Trace('FIN LD_BOUtilFlow.GetSubscriberBySusc', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuValue := null;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubscriberBySusc;


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ProcValidateProduct
   Descripcion    : Valida que el contrato tenga gas activo
   Autor          : Aacuna
   Fecha          : 28/09/2012 SAO 147879

   Parametros               Descripción
   ============         ===================
  inuSubscriptionId:     Identificador del contrato

   Historia de Modificaciones
   Fecha         Autor      Modificación
   =========   ========= ====================
   28/09/2012  AAcuna    Creación
   ******************************************************************/

  PROCEDURE ProcValidateProduct(inuSubscriptionId in suscripc.susccodi%type)
   IS

    nuSubscriber ge_subscriber.subscriber_id%type;
    nuValue      number;
    nuGas_Service ld_parameter.numeric_value%type; -- Parametro del servicio de gas
  BEGIN

    ut_trace.Trace('INICIO LD_BOUtilFlow.ProcValidateProduct', 10);

    nuGas_Service := LD_BOConstans.cnuGasService;

    if ((nvl(nuGas_Service, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then

      GetSubscriberBySusc(inuSubscriptionId,nuSubscriber);

      nuValue := CC_BCReglasClasifica.fnuGetProductsPerType(nuSubscriber,
                                                            nuGas_Service);

      if (nuValue = 0) then

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'Este contrato no tiene producto de GAS en los estado permitidos');

      end if;

    end if;

    ut_trace.Trace('FIN LD_BOUtilFlow.ProcValidateProduct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValidateProduct;



    FUNCTION fnuGetSupplierConect
    return number
    IS
    BEGIN
        return nvl(daor_operating_unit.fnugetcontractor_id(ld_bcnonbankfinancing.fnuGetUnitBySeller, 0), 0);
    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
    END fnuGetSupplierConect;


END LD_BOUtilFlow;
/
PROMPT Otorgando permisos de ejecucion a LD_BOUTILFLOW
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOUTILFLOW', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOUTILFLOW para reportes
GRANT EXECUTE ON adm_person.LD_BOUTILFLOW TO rexereportes;
/
