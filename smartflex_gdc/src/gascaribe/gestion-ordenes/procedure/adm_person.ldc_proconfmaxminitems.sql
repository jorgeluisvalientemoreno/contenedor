CREATE OR REPLACE PROCEDURE adm_person.ldc_proconfmaxminitems(inuOrderId in or_order.order_id%type)
/*****************************************************************
  Propiedad intelectual de Gas Caribe.

  Unidad         : LDC_PROCONFMAXMINITEMS
  Descripcion    : Valida que los items de los tipos de trabajo esten configurados
                   en la nueva tabla de m?ximos y minimos.
  Autor          : Karem Baquero / JM Gestion informatica
  Fecha          : 21/11/2017

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08/05/2024        Adrianavg         OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/
 IS

  CURSOR cuOrderActivity /*(inuOrderId OR_order.order_id%type)*/
  IS
    select o.order_id, o.items_id, o.legal_item_amount
      from or_order_items o, ge_items it, ge_item_classif ge
     where it.items_id = o.items_id
       AND it.item_classif_id = ge.item_classif_id
       AND o.order_id = inuOrderId
       AND o.legal_item_amount > 0
       AND ge.used_in_legalize = 'Y';

  /*cursor para validar si existe la configuraci?n sin actividad*/
  cursor cuLDC_CMMITEMSXTT(inutiptrab LDC_CMMITEMSXTT.TASK_TYPE_ID%type,
                           inuitems   LDC_CMMITEMSXTT.ITEMS_ID%type) is
    select l.items_id, l.activity_id, l.item_amount_min, l.item_amount_max
      from LDC_CMMITEMSXTT l
     where l.task_type_id = inutiptrab
       and l.items_id = inuitems
    /* and l.item_amount_min>=0*/
    ;

  /*cursor para validar si existe la configuraci?n con actividad*/
  cursor cuLDC_CMMITEMSXTTACT(inutiptrab LDC_CMMITEMSXTT.TASK_TYPE_ID%type,
                              inuitems   LDC_CMMITEMSXTT.ITEMS_ID%type /*,
                                                                                                                        inuacti    LDC_CMMITEMSXTT.ACTIVITY_ID%type*/) is

    select l.items_id, l.activity_id, l.item_amount_min, l.item_amount_max
      from LDC_CMMITEMSXTT l
     where l.task_type_id = inutiptrab --12149
       and l.activity_id in (select nvl(oa.activity_id, null)
                               from or_order_activity oa
                              where oa.order_id = inuOrderId /*104329554*/
                             )
       and l.items_id = inuitems --100005931
    /* select l.items_id, l.activity_id, l.item_amount_min, l.item_amount_max
     from LDC_CMMITEMSXTT l
    where l.task_type_id = inutiptrab
      and l.activity_id = inuacti
      and l.items_id = inuitems*/
    /* and l.item_amount_min>=0*/
    ;

  /*cursor para validar el tipo de trabajo legalizado se encuentra configurado*/
  cursor cuLDC_CMMXTT(inutiptrab LDC_CMMITEMSXTT.TASK_TYPE_ID%type) is
    select nvl(count(*), 0)
      from LDC_CMMITEMSXTT l
     where l.task_type_id = inutiptrab;

  /*Validar configuraci?n de tipos de trabajo por items*/
  cursor cuOrtasktypes(inutiptrab LDC_CMMITEMSXTT.TASK_TYPE_ID%type,
                       inuitems   LDC_CMMITEMSXTT.ITEMS_ID%type) is
    select ot.items_id
      from or_task_types_items ot
     where ot.task_type_id = inutiptrab
       and ot.items_id = inuitems /*103135*/
    ;

  nutitrab or_order.task_type_id%type;
  --nuOrderId  or_order.order_id%type;
  nuactivity    or_order_activity.activity_id%type;
  numaxitem     number;
  numinitem     number;
  nuitems       number;
  nuactivityact or_order_activity.activity_id%type;
  numaxitemact  number;
  numinitemact  number;
  nuitemsact    number;
  sbmensa       varchar(2000);
  nucausalorder number;
  nuCausalClas  number;
  sbparam       varchar(1) := dald_parameter.fsbGetValue_Chain('LDC_VALTT_MAX_MIN',
                                                               null);
  nuttp         number;
  nuitemsot       number;


BEGIN

  ut_trace.trace('Inicia LDC_PROCONFMAXMINITEMS', 10);
  -- nuOrderId := 30235455;--or_bolegalizeorder.fnugetcurrentorder;
  ut_trace.trace('nuOrderId ' || inuOrderId, 10);

  nutitrab      := daor_order.FNUGETTASK_TYPE_ID(inuOrderId);
  nucausalorder := daor_order.fnugetcausal_id(inuOrderId);
  nuCausalClas  := dage_causal.fnugetclass_causal_id(nucausalorder);


  ut_trace.trace('Tipo de trabajo ' || nutitrab, 10);

  OPEN cuLDC_CMMXTT(nutitrab);
  FETCH cuLDC_CMMXTT
    INTO nuttp;
  IF cuLDC_CMMXTT%NOTFOUND THEN
    nuttp := 0;
  end if;
  CLOSE cuLDC_CMMXTT;

  if sbparam = 'S' or nuttp >= 1 then

    --cursor para obtener las actividades de la orden
    for rcOrderAct in cuOrderActivity loop

      OPEN cuLDC_CMMITEMSXTT(nutitrab, rcOrderAct.Items_Id);
      FETCH cuLDC_CMMITEMSXTT
        INTO nuitems, nuactivity, numinitem, numaxitem;
      IF cuLDC_CMMITEMSXTT%NOTFOUND THEN

        OPEN cuOrtasktypes(nutitrab, rcOrderAct.Items_Id);
        FETCH cuOrtasktypes
          INTO nuitemsot;
        IF cuOrtasktypes%FOUND THEN
         -- nuitems := 0;

        sbmensa := 'No Existe configuracion de maximos y minimos para el item: ' ||
                   to_char(rcOrderAct.Items_Id) || ' - ' ||
                   ' Que pertenece al tipo de trabajo ' || nutitrab;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                         sbmensa);
        RAISE ex.controlled_error;
         end if;
        CLOSE cuOrtasktypes;

      else

        if nuCausalClas =
           dald_parameter.fnuGetNumeric_Value('LDC_CAUSAL_EXITO', null) then

          OPEN cuLDC_CMMITEMSXTTACT(nutitrab,
                                    rcOrderAct.Items_Id /*,
                                                                                                                                              nuactivity*/);
          FETCH cuLDC_CMMITEMSXTTACT
            INTO nuitemsact, nuactivityact, numinitemact, numaxitemact;
          IF cuLDC_CMMITEMSXTTACT%FOUND THEN
            if rcOrderAct.Legal_Item_Amount > numaxitemact or
               rcOrderAct.Legal_Item_Amount < numinitemact then
              sbmensa := 'La cantidad legalizada no est? entre la cantidad minima : ' ||
                         numinitemact || ' y maxima : ' || numaxitemact ||
                         ' configuradas para el item : ' ||
                         to_char(rcOrderAct.Items_Id) ||
                         ' y la actividad : ' || nuactivity;
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                               sbmensa);
              RAISE ex.controlled_error;
            end if;
          else
            --sbmensa := null;
            if rcOrderAct.Legal_Item_Amount > numaxitem or
               rcOrderAct.Legal_Item_Amount < numinitem then
              sbmensa := 'La cantidad legalizada no est? entre la cantidad minima : ' ||
                         numinitem || ' y maxima : ' || numaxitem ||
                         ' configuradas para el item : ' ||
                         to_char(rcOrderAct.Items_Id);
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                               sbmensa);
              RAISE ex.controlled_error;
            end if;

          END IF;
          CLOSE cuLDC_CMMITEMSXTTACT;
        else
          sbmensa := ' Para legalizar con causal de fallo todos los items debe tener valor 0 ';
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                           sbmensa);
          RAISE ex.controlled_error;

        end if;

      END IF;
      CLOSE cuLDC_CMMITEMSXTT;

      ut_trace.trace('cantidad legalizada ' ||
                     rcOrderAct.Legal_Item_Amount,
                     10);
      ut_trace.trace('cantidad maxima ' || numaxitem, 10);
      ut_trace.trace('cantidad minima ' || numinitem, 10);

    end loop;

  end if;

  ut_trace.trace('Fin LDC_PROCONFMAXMINITEMS', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_PROCONFMAXMINITEMS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROCONFMAXMINITEMS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCONFMAXMINITEMS', 'ADM_PERSON'); 
END;
/