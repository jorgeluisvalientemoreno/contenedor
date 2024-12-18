CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_CLOSEORDER

/*****************************************************************
Propiedad intelectual de Gases de Occidente (c).

Unidad         : ldc_closeOrder
Descripcion    : API para la cerrar una orden de trabajo con el uso del Plugin
Autor          : GDO
Fecha          : 30-09-2013

Consideraciones de Uso
============================================================================

Este objeto puede ser usado en el plugin de legalizacion de ordenes y su Proposito
es que en la legalizacion de una orden de trabajo se pueda cerrar otra orden
diferente a la que se esta gestionando.


Premisas:

Los datos usados para legalizar esta orden tales como Unidad Operativa, tecnico que legaliza y causal
Deben ser las mismas seleccionadas por el usuario en la orden padre.

Alcance:

-   Valida que el estado de la orden sea (asignado o ejecutado)
-   Valida que la unidad de trabaja que va a legalizar la orden de trabajo sea la misma que tiene asignada la orden.
-   Asocia la persona ingresada como parametro del objeto a la legalizaci?n de la orden.
-   Actualiza los datos de la orden de trabajo (estado y fecha de legalizaci?n).
-   Tiene en cuenta la configuracion de regeneraci?n.

No esta en el alcance

-   Legalizar Datos adicionales --> el alcance de este objeto no permite el ingreso de
Datos adicionales o/y validaciones sobre estos.
-   Estas ordenes de trabajo no deben ser tenidas en cuenta en la liquidacion de contratistas.
-   Esta legalizacion de ordenes no tiene en cuenta configuracion de componentes o atributos para ingreso de
equipos seriados, lecturas o similares.


Historia de Modificaciones

Fecha             Autor             Modificaci?n
=========   ==================      ====================
30-09-2013  GDO                     Creacion.
03/09/2015  Jorge Valiente          CAMBIO 8566: Se realizaran cambios inicializando la variable
                                             NuInstanceId en NULL por cada ciclo en el FOR
                                             Basado en el analisis de N2 OPEN Gustavo Vargas Correa.
17/05/2016 Horbath Technologies     Modificacion caso ca 200-391 para que traiga el sector operativo
25/11/2018 HORBATH                  Modificacion caso 200-2179 para que tenga la siguiente l??A???A?gica: si la entrega
                                del desarrollo aplica para la gasera y el tipo de trabajo de la orden que se
                                est??A???A! cerrando se encuentra configurado en el par??A???A!metro COD_TT_CER_BLO llame al
                                nuevo procedimiento del punto LDC_PROVALIREGENSERVNUEVOS_PARAMS  pasando la orden y
                                la causal de legalizaci??A???A?n y si arroja error mostrar el error al usuario.
09/08/2019 dsaltarin		    Caso 200-2686 Se modifica para que si la entrega aplica para la gasera incremente el numero de intentos
								sin importar que el numero de intentos en la configuración este vacío.
26/04/2024 PACOSTA              OSF-2598: Se crea el objeto en el esquema adm_person                                 
******************************************************************/
(
    inuOrderId          in  OR_order.order_id%type,                     --> orden a legalizar
    inuCausalId         in  ge_causal.causal_id%type,                   --> Causal de la orden padre
    inuPerson           in  or_order_person.person_id%type,             --> tecnico de la orden padre
    nuOperUnitId        in  or_operating_unit.operating_unit_id%type    --> Unidad de trabajo de la orden padre
)
IS
    rcOrder                daor_order.styOr_order;
    rcNewOrder             daor_order.styOr_order;
    tbActividaRegen        or_bcregeneraactivid.tytbActividadRegen;
    cnuERR_8681            CONSTANT NUMBER := 8681;
    cnuERR_8571            CONSTANT NUMBER := 8571;
    nuCumplida             or_regenera_activida.cumplida%type;
    nuOrderActivityRegen   OR_order_activity.activity_id%type;
    nuOrderRegen           OR_order.order_id%type;
    nuRegenElementId       OR_order_activity.element_id%type;
    nuInstanceId           OR_order_activity.instance_id%type;
    nuOrderTemplateId      or_order_activity.order_template_id%type;
    inuCommentTypeId       Or_Order_Comment.Comment_Type_Id%type;
    isbComment             Or_Order_Comment.Order_Comment%type;
    nuIntentos             or_order_activity.legalize_try_times%type;
    osbTraslateActivity    varchar2(20);
    nuCantidadLegalizar    number;
    sbnit                  varchar2(20);
    nuOperatingsector      number;


-- DATA Actividades de la orden.
CURSOR cuDatos (orden in OR_order.order_id%type) IS
SELECT  a.order_activity_id,OR_boBasicDataServices.fsbGetActivityDesc(a.order_activity_id) description, a.order_item_id, a.package_id,
a.motive_id, a.component_id, a.instance_id, a.address_id, a.element_id, a.subscriber_id, a.subscription_id, a.product_id, a.process_id,
i.ITEMS_ID,i.LEGAL_ITEM_AMOUNT, a.activity_group_id, a.sequence_, a.origin_activity_id, a.operating_sector_id, a.comment_, a.exec_estimate_date,
a.value1,a.value2,a.value3, a.value4, a.task_type_id, a.compensated, a.status, a.legalize_try_times, a.wf_tag_name
FROM or_order_activity a, OR_order_items i
WHERE i.ORDER_id = orden
AND i.order_items_id = a.order_item_id
ORDER BY nvl(a.consecutive, 0);


-- Configuracion de Regeneracion
CURSOR  cuConfRegAct
    (
        nuIdActividad       IN  ge_items.items_id%type,
        nuIdCausal          IN  ge_causal.causal_id%type,
        nuCumplida          IN  or_regenera_activida.cumplida%type
    )
    IS
        SELECT  a.actividad_regenerar,
                a.actividad_wf,
                a.tiempo_espera,
                null tiempo_vida,
                NULL prioridad_despacho,
                a.action,
                a.try_legalize
          FROM  or_regenera_activida a
         WHERE  a.actividad   = nuIdActividad
           AND  nvl(a.id_causal, nuIdCausal) = nuIdCausal
           AND  a.try_legalize IS null
           AND  ( (nuCumplida = 0) AND (nuCumplida = a.cumplida)
            OR    (nuCumplida != 0) AND (a.cumplida > 0) );

-- Configuracion de Regeneracion
CURSOR  cuConfigRegeneraAct
    (
        nuIdActividad       IN  ge_items.items_id%type,
        nuIdCausal          IN  ge_causal.causal_id%type,
        nuCumplida          IN  or_regenera_activida.cumplida%type,
        nuIntentos          IN  or_regenera_activida.try_legalize%type
    )
    IS
        SELECT  a.actividad_regenerar,
                a.actividad_wf,
                a.tiempo_espera,
                null tiempo_vida,
                NULL prioridad_despacho,
                a.action,
                a.try_legalize
          FROM  or_regenera_activida a
         WHERE  a.actividad   = nuIdActividad
           AND  nvl(a.id_causal, nuIdCausal) = nuIdCausal
           AND  (   a.try_legalize IS null OR
                    a.try_legalize = nvl(nuIntentos, 0)
                )
           AND  ( (nuCumplida = 0) AND (nuCumplida = a.cumplida)
            OR    (nuCumplida != 0) AND (a.cumplida > 0) );
NNN NUMBER;
NUERROR NUMBER;
SBMESSAGE VARCHAR2(4000);
BEGIN

  ut_trace.trace('INICIO - ldc_closeOrder - Orden: '||inuOrderId||' Causal: '||inuCausalId,15);
  daor_order.getRecord(inuOrderId,rcOrder);
  SELECT COUNT(1) INTO NNN FROM OR_ORDER WHERE ORDER_ID=INUORDERID AND TASK_TYPE_ID IN
  (Select to_number(column_value)
            From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TT_CER_BLO',Null),',')));
  IF fblaplicaentrega('OSS_CON_VHMR_2002179_3') AND NOT (NNN = 0) THEN
     LDC_PROVALIREGENSERVNUEVOS_PR(INUORDERID,inuCausalId,nuerror,sbMessage);
     IF NUERROR <> 0 THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, SBMESSAGE);
        raise ex.CONTROLLED_ERROR;
     END IF;
  end if;
  --ELSE
  --  daor_order.getRecord(inuOrderId,rcOrder);
    rcOrder.Causal_id := inuCausalId;
    inuCommentTypeId    := 83;
    isbComment          := 'Orden legalizada por Objeto ldc_closeOrder' ;

    -- Valida estado de la orden
    if(rcOrder.order_status_id not in (or_boconstants.cnuORDER_STAT_ASSIGNED, or_boconstants.cnuORDER_STAT_EXECUTING))then
        ge_boerrors.seterrorcode(cnuERR_8681);
    END if;

    --Llenamos la fecha fin y la fecha de legalizaci?n.
    rcOrder.EXECUTION_FINAL_DATE    := sysdate;
    rcOrder.LEGALIZATION_DATE       := rcOrder.EXECUTION_FINAL_DATE;

    -- Valida que la unidad operativa sea la de la orden.
    if(nuOperUnitId != rcOrder.operating_unit_id)then
        ge_boerrors.seterrorcode(cnuERR_8571);
    END if;

    -- Cierra la orden de Trabajo
    ut_trace.trace('changeStatus', 15);
    changeStatus(rcOrder,or_boconstants.cnuORDER_STAT_CLOSED,inuCommentTypeId,isbComment);

    -- asocia la persona que cerro la orden
    ut_trace.trace('InsertPersonInCharge', 15);
    OR_BOLegalizeOrder.InsertPersonInCharge(rcOrder.order_id, inuPerson);

    -- Obtiene la clase de la causal
    nuCumplida := DAGE_causal.fnugetclass_causal_id(inuCausalId);
    ut_trace.trace('nuCumplida: '||nuCumplida, 15);
    if (nuCumplida=2) then
        nuCantidadLegalizar:=0;
    else
        nuCantidadLegalizar:=1;
    END if;
    ut_trace.trace('nuCantidadLegalizar: '||nuCantidadLegalizar, 15);

    -- Actualizacion de cantidad legalizada.
    ut_trace.trace('Actualizar Cantidad Legalizada', 15);
    UPDATE OR_order_items
    SET  legal_item_amount =  nuCantidadLegalizar
    WHERE order_items_id in (
                                SELECT i.order_items_id
                                FROM or_order_activity a, OR_order_items i
                                WHERE i.ORDER_id = rcOrder.order_id
                                AND i.order_items_id = a.order_item_id
                             );



    -- Recorre las actividades de la orden a legalizar
    ut_trace.trace('rcOrder.order_id: '||rcOrder.order_id, 15);
    for dat in cuDatos (rcOrder.order_id) loop
        ut_trace.trace('Actividades de la ?rden a legalizar', 15);
        -- Obtiene la configuracion de regeneracion de ordenes
        ut_trace.trace('legalize_try_times :'||dat.legalize_try_times||' dat.items_id: '||dat.items_id||' inuCausalId: '||inuCausalId||' nuCumplida:'||nuCumplida||' nuCantidadLegalizar:'||nuCantidadLegalizar, 15);
        if(dat.legalize_try_times IS not null)then
            OPEN  cuConfigRegeneraAct(dat.items_id, inuCausalId, nuCantidadLegalizar, dat.legalize_try_times);
            FETCH cuConfigRegeneraAct BULK COLLECT INTO tbActividaRegen;
            CLOSE cuConfigRegeneraAct;
        else
            OPEN  cuConfRegAct(dat.items_id, inuCausalId, nuCantidadLegalizar);
            FETCH cuConfRegAct BULK COLLECT INTO tbActividaRegen;
            CLOSE cuConfRegAct;
        END if;
        ut_trace.trace('tbActividaRegen.first :'||tbActividaRegen.first, 15);
        IF tbActividaRegen.first IS NOT NULL then
        FOR nuIndex IN tbActividaRegen.first..tbActividaRegen.last LOOP

        select s.sistnitc into sbnit
        from sistema s;
            --CAMBIO 8566 solo gascaribe
            --inicializacion de variable nuInstanceId en NULL
            if sbnit = '890101691-2' then
            nuInstanceId := null;
            end if;
            --FIN CAMBIO 8566

            ut_trace.trace('RegenerandoActividad =>'||tbActividaRegen(nuIndex).ActividadRegenerar, 9);
            osbTraslateActivity    := ge_boconstants.csbNO;
            nuOrderActivityRegen   := NULL;
            nuOrderRegen           := null;


            if (tbActividaRegen(nuIndex).ActividadRegenerar IS not null) then
                -- si existe una actividad para regenerar  y est? asociada a workflow
                IF (tbActividaRegen(nuIndex).actividad_wf = ge_boconstants.csbYES) THEN
                   nuInstanceId := dat.instance_id;
                   -- Se utiliza para indicar que el flujo debe esperar
                  -- oblActRegenerated := TRUE;
                END IF;

                nuRegenElementId        := daor_order_activity.fnuGetElement_id(dat.order_activity_id);
                nuOrderTemplateId       := daor_order_activity.fnuGetOrder_template_id(dat.order_activity_id);


                /* Aumenta el contador solamente si es diferente de NULO */
                if(tbActividaRegen(nuIndex).intentos IS not null OR fblAplicaEntregaxCaso('200-2686'))then
                    nuIntentos  := nvl(tbActividaRegen(nuIndex).intentos,0) + 1;
                    ut_trace.trace('nuIntentos ['||nuIntentos||']',15);
                END if;

                ut_trace.trace('tbActividaRegen(nuIndex).intentos ['||tbActividaRegen(nuIndex).intentos||']',15);

                nuOperatingsector := daor_order.fnugetoperating_sector_id (inuOrderId, null);
                if nuOperatingsector is null then
                  ut_trace.trace('la orden '||inuOrderId||' no tiene sector operativo',15);
                  Dbms_Output.Put_Line('la orden '||inuOrderId||' no tiene sector operativo');
                  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'La orden [' || inuOrderId ||
                                           '] no tiene sector operativo' /*||
                                           dage_items.fsbgetdescription(inuActivityId)*/);
                  raise ex.CONTROLLED_ERROR;
                end if;

                -- Creacion de la orden a regenerar
                or_boorderactivities.CreateActivity
                (
                    tbActividaRegen(nuIndex).ActividadRegenerar,
                    dat.package_id,
                    dat.motive_id,
                    dat.component_id,
                    nuInstanceId,
                    dat.address_id,
                    nuRegenElementId ,
                    dat.subscriber_id,
                    dat.subscription_id,
                    dat.product_id,
                    nuOperatingsector,
                    nuOperUnitId,
                    dat.exec_estimate_date,
                    dat.process_id,
                    dat.comment_,
                    FALSE,
                    NULL,       --sbGroupAssign
                    nuOrderRegen,
                    nuOrderActivityRegen,
                    nuOrderTemplateId,
                    GE_BOConstants.csbYES,
                    null,                                                   -- Consecutivo de la actividad
                    null,                                                   -- Ruta de la orden
                    null,                                                   -- Consecutivo de la ruta de la orden

                    nuIntentos,                                             -- intento de legalizaci?n +1
                    dat.wf_tag_name,
                    TRUE,
                    daor_order_activity.fnuGetValue_Reference(dat.order_activity_id)
                );

                IF nuOrderActivityRegen IS NOT NULL THEN
                    daor_order_activity.updOrigin_activity_id(nuOrderActivityRegen,dat.order_activity_id);
                END IF;

                --Se relaciona las 2 ?rdenes, por la relaci?n entre sus actividades, a causa de la
                --configuraci?n de las actividades que se regeneran.
                if nuOrderRegen IS not null then
                    --revisa si las 2 ordenes no estan ya relacionadas con ese tipo de relaci?n
                    if ( or_borelatedorder.fsbExistRelation(inuOrderId,
                                                            nuOrderRegen,
                                                            or_boconstants.cnuRELATEDORD_REGENER)
                                                != ge_boconstants.csbYES ) then
                        or_borelatedorder.relateOrders( inuOrderId,
                                                        nuOrderRegen,
                                                        or_boconstants.cnuRELATEDORD_REGENER
                                                      );
                    END if;
                END if;


                -- La orden se procesa despues de que se actualice la informacion de las actividades de origen
                IF nuOrderRegen IS NOT NULL THEN

                    if( nvl(tbActividaRegen(nuIndex).action, 0) > 0)then
                        LDC_ExecActionByTryLeg
                        (
                            nuOrderRegen,                                   -- orden creada
                            nuOperUnitId,                                  -- unidad de trabajo
                            tbActividaRegen(nuIndex).action,                -- acci?n a ejecutar
                            nvl(tbActividaRegen(nuIndex).tiempo_espera, 0)  -- Tiempo de espera
                        );
                    else
                        rcNewOrder := daor_order.frcGetRecord(nuOrderRegen);
                        -- Inicializacion del sector
                        or_boprocessorder.updBasicData(rcNewOrder, null, null);
                    END if;
                END IF;
            END if;
        END LOOP;
    END IF;

     END loop;

  --END IF;

  ut_trace.trace('FIN - ldc_closeOrder',15);


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END ldc_closeOrder;
/
PROMPT Otorgando permisos de ejecucion a LDC_CLOSEORDER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_CLOSEORDER', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_CLOSEORDER para reportes
GRANT EXECUTE ON adm_person.LDC_CLOSEORDER TO rexereportes;
/