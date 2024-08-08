CREATE OR REPLACE PACKAGE BODY Or_boplanningActivit
IS

/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : Or_boplanningActivit
Descripcion    : Paquete para la gestión de actividades planeadas
Autor          :
Fecha          : 8/6/2008

Metodos

Nombre         :
Parametros         Descripcion
============	===================


Historia de Modificaciones
Fecha             Autor             Modificacion
=========   ==================  ====================
27-10-2014  eurbano.SAO276659   Se modifica <copyPlannedItems>
24-09-2013  llopezSao217140     Se modifica activateActivity
05-06-2013  llopezSao208905     Se modifica createPlannedActivity
14-05-2013  amendezSAO206849    Se modifica <InsertOrUpdatePlannetItems>
29-04-2013  Arojas.SAO206619    Se modifica «ValidDataXML».
                                Se modifica «ProcessXML».
19-04-2013  Arojas.SAO206433    Se adiciona «ValidDataXML».
                                Se modifica «ProcessXML»
15-04-2013  Arojas.SAO205273    Se adiciona «ProcessXML»,GetResultXML.
                                Se adiciona tyrcActivity.
29-08-2012  cburbano.SAO187664  Se modifica «GetPlanActConfByAct»
18-04-2012  AEcheverrySA165500  Se modifica el metodo
                                        <<InsertOrUpdatePlannetItems>>
                                        <<InsertPlanneDItems>>
                                se modifica el nombre <<InsertPlannetItems>>
                                    a <<InsertPlannedItems>>
05-12-2011  yclavijo.SAO166076  Se modifican los métodos createPlannedActivity y activateActivity
12-08-2011  llopezSAO147946	Estabilización 21-Jun-2011 jfortizSAO152188
                                <InsertOrUpdatePlannetItems> - modificacion
                                Se valida si el item que se esta planeando
                                existen en la base de datos.
05-04-2011  AEcheverrySAO145159 Se modifica el método <<InsertOrUpdatePlannetItems>>
01-04-2011  MArteaga.SAO145030  Se modifica el metodo «InsertOrUpdatePlannetItems».
15-03-2011  MArteaga.SAO143365  Se modifican los metodos:
                                            «InsertOrUpdatePlannetItems»
                                            «InsertItems».
05-Sep.2010 AEcheverrySAO125896 se modifidca <<InsertItems>>
19-Mar-2009 AEcheverrySAO93547   se modifica <<GetInitPlannedActivity>>
18-nov-2008 AEcheverrySAO85733   se modifica metodo <<createPlannedActivity>>
01-Nov-2008 cburbanoSAO84993        Se modifica el método activateActivity
15-oct-2008 AEcheverrySAO82325  se crea la funcion <<fblExistOrderForAct>>
                                Se crea el procedimiento <<createPlannedActivity>> con
                                todos los parametros necesarios para poblar la
                                tabla OR_order_activity tal y como se requiere en
                                el proceso de creacion de actividades
                                <<or_boorderactivities.CreateActivity>> y se
                                modifican los otros metodos de creacion de
                                actividades planeadas para que internamente llamen
                                al nuevo metodo
06-10-2008  jhramirezSAO82325   Se Crea el Procedimiento UpdItemAmountAndValue que actualiza
                                la cantidad, de un item, y  su valor.

12-sep-2008 AEcheverrySAO81938  Se modifica <<activateActivity>>
10-Sep-2008 AEcheverrySAO81313  Se modifica <<copyPlannedItems>>
08-Sep-2008 AVillegasSAO81604   Se modifica el método < GetInitPlannedActivity >

05-Sep-2008 AEcheverrySAO81305  se adicionan metodos <<InsertOrUpdatePlannetItems>>
                                <<InsertOrUpdatePlannedActivity>> y  <<deletePlannedActivity>>

******************************************************************/
	-- Declaracion de variables y tipos globales privados del paquete
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO276659';

    -- La cantidad debe ser mayor o igual a %s1
    cnuAmmountGreatherThan    constant number(6) := 902183;

    -- la cantidad ingresada debe ser mayor a cero
    cnuAmmountGratherThanZero constant number(6) :=   3305;

    -- Declaracion de variables y tipos globales privados del paquete

	-- Definicion de metodos publicos y privados del paquete
    --  retorna  la versión del SAO
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    -- Bloquea los registros de or_order_activity que pertenezcan al grupo
    -- <inuActivityGroupId>
    FUNCTION fnuGetNextExecGrpId return number
    IS
    BEGIN
        return ge_bosequence.NextGroupSequence;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    PROCEDURE lockByActiGroup
    (
        inuActivityGroupId   in  or_order_activity.activity_group_id%type
    )
    IS
        rcOR_order_activity daor_order_activity.styOR_order_activity;

        CURSOR cuLockByActiGroup
        (
            inuActivityGroupId   in  or_order_activity.activity_group_id%type
        )
        IS
            SELECT OR_order_activity.*,OR_order_activity.rowid
            FROM OR_order_activity
            WHERE activity_group_id = inuActivityGroupId
            FOR UPDATE NOWAIT;

    BEGIN
        if inuActivityGroupId IS null then
            return ;
        END if;

        Open cuLockByActiGroup
        (
            inuActivityGroupId
        );

        fetch cuLockByActiGroup into rcOR_order_activity;
        if cuLockByActiGroup%notfound  then
        	close cuLockByActiGroup;
        	raise no_data_found;
        end if;
        close cuLockByActiGroup ;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
    END;


	/*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: createPlannedActivity
    Descripcion	: Realiza la creación de una actividad planeada


    Parametros	:        Descripcion
    inuOriginActivityId: Id de la actividad de origen
    inuActivityId:       Id del tipo de actividad a crear
    inuActivityGroupId:  Id del grupo correspondiente a la actividad
    inuSequence:         Secuencia de ejecución para la actividad
    isbComment:          Comentario

    Salida:
    onuOrderActivityId:  Id de la actividad creada.

    Autor	: AVillegasSAO80006
    Fecha	: 8-08-2005

    Historia de Modificaciones
    Fecha	   IDEntrega
    05-12-2011  yclavijo.SAO166076  Se elimina los parámetros rcOriginOrderActiv.reading_route_id y
                                    rcOriginOrderActiv.reading_seq en el llamado a createPlannedActivity
    18-nov-2008 AEcheverrySAO85733  se modifica metodo para guardar correctamente el plan_id y
                                    la actividad origen
    15-oct-2008 AEcheverrySAO831591 se modifica para que llame al nuevo metodo
                                    de creacion de actividades planeadas
                                    con todos los datos de la actividad
    08-08-2008 AVillegasSAO80006      Creación.
    ******************************************************************/

	PROCEDURE createPlannedActivity
    (
        inuOriginActivityId in  or_order_activity.activity_id%type,
        inuActivityId       in  ge_items.items_id%type,
        inuActivityGroupId  in  or_order_activity.activity_group_id%type, -- debe referenciar al grupo de órdenes al que pertence la actividad
        inuSequence         in  or_order_activity.sequence_%type,
        isbComment          in  or_order_activity.comment_%type,
        onuOrderActivityId  out or_order_activity.activity_id%type -- Id de la actividad creada
    )
    IS
        rcOriginOrderActiv  daor_order_activity.styOR_order_activity;
        nuInstanceId        OR_order_activity.instance_id%type;
    BEGIN

        ut_trace.trace('1 Inicia or_boplanningactivit.createPlannedActivity - inuOriginActivityId ['||inuOriginActivityId||'] - onuOrderActivityId['||onuOrderActivityId||'] -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);

        rcOriginOrderActiv := daor_order_activity.frcGetRecord(inuOriginActivityId);

        if rcOriginOrderActiv.instance_id IS not null then
            -- si la actividad de planeación viene desde WF entonces en el
            -- instance id guardamos el plan_id de la instancia de planeación
            nuInstanceId     := dawf_instance.fnuGetPlan_Id(rcOriginOrderActiv.instance_id);
        END if;

        createPlannedActivity
        (
            inuActivityId,
            inuActivityGroupId,
            inuSequence,
            rcOriginOrderActiv.package_id,
            rcOriginOrderActiv.motive_id,
            rcOriginOrderActiv.component_id,
            nuInstanceId,
            rcOriginOrderActiv.address_id,
            rcOriginOrderActiv.element_id,
            rcOriginOrderActiv.subscriber_id,
            rcOriginOrderActiv.subscription_id,
            rcOriginOrderActiv.product_id,
            rcOriginOrderActiv.operating_sector_id,
            rcOriginOrderActiv.operating_unit_id,
            rcOriginOrderActiv.exec_estimate_date,
            rcOriginOrderActiv.process_id,
            nvl(isbComment,rcOriginOrderActiv.comment_),
            onuOrderActivityId
        );

        IF onuOrderActivityId IS NOT NULL THEN
            daor_order_activity.updOrigin_activity_id(onuOrderActivityId,inuOriginActivityId);
        END IF;

        ut_trace.trace('2 FIN or_boplanningactivit.createPlannedActivity - onuOrderActivityId['||onuOrderActivityId||'] - inuOriginActivityId['||inuOriginActivityId||'] -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END createPlannedActivity;

    /*****************************************************************
    Propiedad intelectual de Open Systems (c).
    Unidad      : createPlannedActivity
    Descripcion	: Crea una actividad planeada


    Parametros          Descripcion
    ============        ===================
    Entraqda:



    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    05-12-2011      yclavijo.SAO166076  Se eliminan los parámetros inuReadingRouteId y inuReadingSeq
                                        Se quitan estos parámetros en el llamado a createPlannedActivity
    15-Oct-2008     AEcheverrySAO83521 creación
    ******************************************************************/
    PROCEDURE createPlannedActivity
    (
        inuActivityId       in  ge_items.items_id%type,
        inuActivityGroupId  in  or_order_activity.activity_group_id%type, -- debe referenciar al grupo de órdenes al que pertence la actividad
        inuSequence         in  or_order_activity.sequence_%type,
        isbComment          in  or_order_activity.comment_%type,
        inuAddressId        in  or_order_activity.address_id%type,
        inuOperSectorId     in  or_order_activity.operating_sector_id%type,
        inuSubscriptionId   in  or_order_activity.subscription_id%type,
        inuSubscriberId     in  or_order_activity.subscriber_id%type,
        inuProductId        in  or_order_activity.product_id%type,
        inuElementId        in  or_order_activity.element_id%type,
        inuProcessId        in  or_order_activity.process_id%type,
        onuOrderActivityId  out or_order_activity.activity_id%type -- Id de la actividad creada
    )
    IS

    BEGIN

        createPlannedActivity
        (
            inuActivityId,
            inuActivityGroupId,
            inuSequence,
            NULL, -- package
            NULL, -- motive
            NULL, -- component
            NULL, -- instance
            inuAddressId,
            inuElementId,
            inuSubscriberId,
            inuSubscriptionId,
            inuProductId,
            inuOperSectorId,
            NULL, -- operating_unit_id
            NULL, -- exec_estimate_date
            inuProcessId,
            isbComment,
            onuOrderActivityId
        );


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: copyPlannedItems
    Descripcion	: copia los items planeados para la actividad <inuOrderActivityId>
                  de or_planned_items a or_order_items


    Parametros	:        Descripcion
    inuOrderActivityId:  Id del tipo de actividad
    inuOrderId:          Id de la orden


    Autor	: AVillegasSAO80006
    Fecha	: 8-08-2005

    Historia de Modificaciones
    Fecha	   IDEntrega
    27-10-2014 eurbano.SAO276659    Se modifica para excluir del CURSOR de los
                                    items planeados a copiar los que son de tipo
                                    actividad.
    18-04-2012  AEcheverrySAO165500  Se elimina manejo de elementos de red
    10-09-2008 AEcheverrySAO81313   se modifica para insertar los items planeados
    08-08-2008 AVillegasSAO80006      Creación.
    ******************************************************************/
    PROCEDURE copyPlannedItems
    (
        inuOrderActivityId      OR_Order_Activity.order_activity_id%type,
        inuOrderId              or_order_activity.order_id%type
    )
    IS

        rcOrderItems        daor_order_items.styOR_order_items;

        CURSOR cuPlanItByOrdAct
        (
            inuOrderActivityId      OR_Order_Activity.order_activity_id%type
        )
        IS
        SELECT a.planned_items_id,
               a.planned_order_id,
               a.items_id,
               a.item_amount,
               a.value,
               a.element_id,
               a.element_code,
               a.order_activity_id
        FROM  or_planned_items a, ge_items b
        WHERE order_activity_id = inuOrderActivityId
        AND   a.items_id = b.items_id
        AND   b.item_classif_id <> or_boorderactivities.cnuActivityType;

    BEGIN
         ut_trace.trace('INICIA Or_boplanningActivit.copyPlannedItems',5);

        for rcPlanItems in cuPlanItByOrdAct(inuOrderActivityId) loop
            rcOrderItems.order_items_id         := or_bosequences.fnuNextOR_Order_Items;

            rcOrderItems.order_id               := inuOrderId;
            rcOrderItems.order_activity_id      := inuOrderActivityId;
            rcOrderItems.assigned_item_amount   := rcPlanItems.item_amount;
            rcOrderItems.items_id               := rcPlanItems.items_id;
            rcOrderItems.value                  := rcPlanItems.value;
            rcOrderItems.total_price            := 0;

            daor_order_items.insRecord(rcOrderItems);
        END loop;

        ut_trace.trace('FIN Or_boplanningActivit.copyPlannedItems',5);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	:  activateActivity
    Descripcion	:

    Parametros	:        Descripcion
    inuOrderActivityId:  Id del tipo de actividad
    inuOrderId:          Id de la orden


    Historia de Modificaciones
    ==========================
    Fecha	   IDEntrega
    24-09-2013  llopezSao217140     Se modifica para que no asigne las órdenes
    05-12-2012  yclavijo.SAO166076  Se quitan los parámetros de Reading_Route_Id y Reading_Seq del llamado a
                                    or_boorderactivities.CreateActivity
    01-Nov-2008 cburbanoSAO84993    Se adiciona el parámetro sbGroupAssign en el
                                    llamado al método or_boorderactivities.CreateActivity
    ******************************************************************/
    PROCEDURE activateActivity
    (
        inuActivityId   in  or_order_activity.order_activity_id%type
    )
    IS

        rcOrderActivity         daor_order_activity.styOR_order_activity;
        onuOrderId              or_order_activity.order_id%type;
        nuOrderActivityId       or_order_activity.order_activity_id%type;


    BEGIN
        ut_trace.trace('INICIA Or_boplanningActivit.activateActivity',5);

        rcOrderActivity := daor_order_activity.frcGetRecord(inuActivityId);
        onuOrderId := null;
        nuOrderActivityId := rcOrderActivity.order_activity_id;

        or_boorderactivities.CreateActivity(
            rcOrderActivity.Activity_Id,
            rcOrderActivity.Package_Id,
            rcOrderActivity.Motive_Id,
            rcOrderActivity.Component_Id,
            rcOrderActivity.Instance_Id,
            rcOrderActivity.Address_Id,
            rcOrderActivity.Element_Id,
            rcOrderActivity.Subscriber_Id,
            rcOrderActivity.Subscription_Id,
            rcOrderActivity.Product_Id,
            rcOrderActivity.operating_sector_id,
            rcOrderActivity.operating_unit_id,
            rcOrderActivity.exec_estimate_date,
            rcOrderActivity.Process_Id,
            rcOrderActivity.Comment_,
            false,      --iblProcessOrder: Asignar Órdenes
            null,       --sbGroupAssign
            onuOrderId,
            nuOrderActivityId
        );

        -- Se insertan los items de la actividad
        copyPlannedItems(nuOrderActivityId, onuOrderId);

        ut_trace.trace('INICIA Or_boplanningActivit.activateActivity',5);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    -- Inicia la ejecución de un grupo de órdenes planeadas
    PROCEDURE activateActExec
    (
        inuActivityGroupId   in  or_order_activity.activity_group_id%type
    )
    IS
        tbActivitiesByGroup     daor_order_activity.tytbActivity_id;
        nuMinSequence           or_order_activity.sequence_%type;
        nuIndex                 number := 1;
    BEGIN

        if inuActivityGroupId IS null then
            return;
        END if;
        -- Se bloquean los registros del grupo
        lockByActiGroup(inuActivityGroupId);

        nuMinSequence := or_bcorderactivities.fnuGetMinSeqByGroup(inuActivityGroupId,or_boorderactivities.csbPlannedStatus);

        or_bcorderactivities.getActivityByGroup(inuActivityGroupId,
                                                or_boorderactivities.csbPlannedStatus,
                                                nuMinSequence,
                                                tbActivitiesByGroup);

        -- Cada una de las actividades de la tabla debe pasara a estado
        -- or_boorderactivities.csbRegisterStatus 'R'
        if tbActivitiesByGroup.count = 0 then
            ut_trace.Trace('No hay actividades planeaadas ',10);
            return;
        END if;
        nuIndex := tbActivitiesByGroup.first;

        while nuIndex IS not null loop

            activateActivity(tbActivitiesByGroup(nuIndex));

            nuIndex := tbActivitiesByGroup.next(nuIndex);

        END loop;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    PROCEDURE genNextExecution
    (
        inuActivityGroupId   in  or_order_activity.activity_group_id%type,
        inuCurrentSequence   in  or_order_activity.sequence_%type,
        osbFinish            out varchar2
    )
    IS
        --*/
        tbPendActByGroup        daor_order_activity.tytbActivity_id;
        nuMinSequence           or_order_activity.sequence_%type;
        nuIndex                 number := 1;
        rcOrderActivity         daor_order_activity.styOR_order_activity;
        onuOrderId              or_order_activity.order_id%type;
        nuOrderActivityId       or_order_activity.order_activity_id%type;

    BEGIN

        -- Se bloquean los registros del grupo
        lockByActiGroup(inuActivityGroupId);

        osbFinish := ge_boconstants.csbNO;
        -- Obtiene las actividades pendientes para el grupo y secuencia dados
        or_bcorderactivities.getPendActByGroup(inuActivityGroupId,
                                                inuCurrentSequence,
                                                tbPendActByGroup);

        ut_trace.Trace('Actividades pendientes para el grupo ['||inuActivityGroupId||']'||
                        'secuencia ['||inuCurrentSequence||'] = '||tbPendActByGroup.count,10);

        if tbPendActByGroup.count > 0 then
            -- No se hace nada, aún faltan trabajos por finalizar
            return;
        END if;

        nuMinSequence := or_bcorderactivities.fnuGetMinSeqByGroup(inuActivityGroupId,or_boorderactivities.csbPlannedStatus);
        ut_trace.trace('Siguiente secuencia '||nuMinSequence,10);
        -- Obtiene todas las actividades en estado Planeada
        or_bcorderactivities.getActivityByGroup(inuActivityGroupId,
                                                or_boorderactivities.csbPlannedStatus,
                                                nuMinSequence,
                                                tbPendActByGroup);

        ut_trace.trace('Actividades pendientes  ['||tbPendActByGroup.count||']');
        if tbPendActByGroup.count = 0 then
            ut_trace.trace('Ya se acabaron las actividades planeadas para el grupo ',10);
            osbFinish := ge_boconstants.csbYES;
            return;
        END if;

        nuIndex := tbPendActByGroup.first;

        while nuIndex IS not null loop

            activateActivity(tbPendActByGroup(nuIndex));
            nuIndex := tbPendActByGroup.next(nuIndex);

        END loop;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
        Unidad      :   GetPlanActConfByAct
        Descripcion	:   Obtiene la configuración de actividades a planear para
                        el tipo de actividad <inuActivityId>
    ******************************************************************/
    PROCEDURE GetPlanActConfByAct
    (
        inuActivityId   in  or_planned_activit.activity_id%type,
        inuOrderId      in  OR_order.order_id%type,
        inuOperUnitId   in  OR_operating_unit.operating_unit_id%type,
        idtAssignedDate in  OR_order.assigned_date%type,
        ocurfOrder      out Constants.tyRefCursor
    )
    IS
        nuAmount           or_order_items.legal_item_amount%type := 1;
        sbOUT_             or_order_items.out_%type;
        nuBalance          or_ope_uni_item_bala.balance%type;
        nuBalancePrice     or_ope_uni_item_bala.total_costs%type;
        sbCostMethod       ge_item_classif.cost_method%type;
        sbQuantityControl  ge_item_classif.quantity_control%type;
        nuContractorId     ge_contrato.id_contratista%type;
        nuContractId       ge_contrato.id_contrato%type;
        rcOrder            daor_order.styOR_order;

    BEGIN

        /*OR_BOItemValue.GetItemValuePlannedOrder*/

        ocurfOrder := or_bcplannedactivit.frfGetPlanActConfByAct
        (
            inuActivityId,
            inuOrderId,
            inuOperUnitId,
            idtAssignedDate
        );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            GE_BOGeneralUtil.Close_RefCursor(ocurfOrder);
            raise ex.CONTROLLED_ERROR;
        when others then
            GE_BOGeneralUtil.Close_RefCursor(ocurfOrder);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetPlanActConfByAct;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: InsertItems
                inserta items planeados

    Parametros	:        Descripcion

    Retorno:
        Siguiente id para grupos de ejecución de órdenes

    Autor	: AVillegasSAO80006
    Fecha	: 11-08-2005

    Historia de Modificaciones
    Fecha	   IDEntrega
    03-05-2010 MArteaga.SAO143365  Se modifica para que obtenga los items visibles
    05-09-2010 AEcheverrySAO125896 se eliminan variables no usadas
    ******************************************************************/
    PROCEDURE InsertItems
    (
        inuPlannedOrderAct  in  OR_planned_items.order_activity_id%type,
        inuPlannedActivity  in  or_planned_items.items_id%type,
        inuOrderId          in  OR_order_activity.order_id%type
    )
    IS
        rcPlannedItem       daor_planned_items.styOR_planned_items;
        nuItemValue         or_planned_items.value%type;

        crfItems            constants.tyRefCursor;
        nuItemsId           GE_ITEMS.ITEMS_ID%type;
        sbItemDescription   varchar2(300);
        nuMeasureUnit       GE_ITEMS.MEASURE_UNIT_ID%type;
        nuElementType       GE_ITEMS.ELEMENT_TYPE_ID%type;
        nuItemAmount        OR_task_types_items.ITEM_AMOUNT%type;

    BEGIN

        ut_trace.trace('INICIA Or_boplanningActivit.InsertItems ['||inuPlannedOrderAct||'] - inuPlannedActivity['||inuPlannedActivity||'] - ['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',15);

        -- Si tiene Items la orden los carga a la tabla Or_Order_Items
        rcPlannedItem.order_activity_id := inuPlannedOrderAct;

        crfItems := or_bclegalizeitems.frcVisibleItemsByActivity(inuPlannedActivity);

        LOOP
            fetch crfItems into nuItemsId, sbItemDescription, nuMeasureUnit,nuElementType,nuItemAmount;
                EXIT WHEN crfItems%NOTFOUND;

            rcPlannedItem.planned_items_id := or_bosequences.fnuNextOR_planned_items;
            rcPlannedItem.Items_Id := nuItemsId;
            rcPlannedItem.Item_Amount := nvl(nuItemAmount,0);

            OR_BOItemValue.GetItemValuePlannedOrder(inuOrderId,
                                                    nuItemsId,
                                                    nvl(nuItemAmount,0),
                                                    nuItemValue
                                                   );

            rcPlannedItem.value := nvl(nuItemValue,0);

            -- Inserta en la tabla Or_Planned_Items
            DAOr_Planned_Items.insRecord(rcPlannedItem);

        END loop;

        ut_trace.trace('FIN Or_boplanningActivit.InsertItems ['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if (crfItems%ISOPEN) then
                close crfItems;
            end if;
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            if (crfItems%ISOPEN) then
                close crfItems;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InsertItems;

    /*****************************************************************
        Unidad      :   GetInitPlannedActivity
        Descripcion	:   Obtiene las actividades requeridas y/o planeadas
                        inicialmente
    ******************************************************************/
    PROCEDURE GetInitPlannedActivity
    (
        inuOriginOrderActId in  Or_Order_activity.order_activity_id%type,
        inuOriginActivityId in  Or_Order_activity.activity_id%type,
        inuActivityGroupId  in  OR_order_activity.activity_group_id%type,
        inuOrderId          in  OR_order.order_id%type,
        ocurfOrder          out Constants.tyRefCursor
    ) IS
        tbPlanActConf       or_bcplannedactivit.tytbPlanActConf;
        nuIndex             number := null;
        nuOrderActivityId   OR_order_activity.order_activity_id%type ;
        tbActivitiesConf    or_bcorderactivities.tytbActivitiesConf;
        nuPackageId         or_order_activity.package_id%type;
        nuMotiveId          or_order_activity.motive_id%type;
        nuComponentId       or_order_activity.component_id%type;

        tbMoOrderData       dage_items.tytbItems_id;

    BEGIN
        -- Obtenemos la configuracio para la actividad actual
        or_bcplannedactivit.getPlanActConfByAct(inuOriginActivityId,tbPlanActConf );

        nuPackageId     := daor_order_activity.fnuGetPackage_id(inuOriginOrderActId);
        nuMotiveId      := daor_order_activity.fnuGetMotive_id(inuOriginOrderActId);
        nuComponentId   := daor_order_activity.fnuGetComponent_id(inuOriginOrderActId);

        --modificar para obtener la informacion de las tablas programadas por paquete, motivo y componente
        mo_bodata_for_order.GetSuggestActivities(nuPackageId,nuMotiveId, nuComponentId,tbMoOrderData);

        ut_trace.trace('tbPlanActConf '||tbPlanActConf.count, 15);
        -- insertamos las actividades requeridas
        nuIndex := tbPlanActConf.first;
        while nuIndex IS not null loop
            -- Si es obligatoria ó la solicitu el cliente
            if (tbPlanActConf(nuIndex).sbRequired = ge_boconstants.csbYES OR
                tbMoOrderData.exists(tbPlanActConf(nuIndex).nuPlannedActivityId)) then
                nuOrderActivityId := null;
                if  or_bcplanningactivit.fnuExistPlannedActivity
                    (
                    tbPlanActConf(nuIndex).nuPlannedActivityId,
                    inuOriginOrderActId
                    ) = 0
                then
                    or_boplanningactivit.createPlannedActivity
                    (
                        inuOriginOrderActId,
                        tbPlanActConf(nuIndex).nuPlannedActivityId,
                        inuActivityGroupId,
                        tbPlanActConf(nuIndex).nuSequence,
                        null,
                       nuOrderActivityId
                    );
                    ut_trace.trace('CreateActivity['||nuOrderActivityId||']Order: '||inuOrderId,10);

                    or_bcorderactivities.GetConfig(tbActivitiesConf);

                    --insertamos items para la actividad planeada
                    InsertItems
                    (
                        nuOrderActivityId,
                        tbPlanActConf(nuIndex).nuPlannedActivityId,
                        inuOrderId
                    );

                    ut_trace.trace('createItems',10);
                END if;
            END if;
            nuIndex := tbPlanActConf.next(nuIndex);
        END loop;

        ocurfOrder := or_bcplanningactivit.frfGetPlannedActivity
        (
            inuActivityGroupId
        );


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            GE_BOGeneralUtil.Close_RefCursor(ocurfOrder);
            raise ex.CONTROLLED_ERROR;
        when others then
            GE_BOGeneralUtil.Close_RefCursor(ocurfOrder);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetInitPlannedActivity;



    /*****************************************************************
    Unidad      : insertPlannedItems
    Descripcion	: Inserta o actualiza los items planeados a una actividad planeada

    Autor       :
    Fecha       :


    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    18-04-2012  AEcheverrySA165500  Se insertPlannedItemselimina manejo de elementos de red,
                                    se modifica el nombre <<InsertPlannetItems>>
                                    a <<InsertPlannedItems>>
    *****************************************************************/
    PROCEDURE insertPlannedItems
    (
        inuItemsId          in or_planned_items.items_id%type,
        inuItemAmount       in or_planned_items.item_amount%type,
        inuOrderActivityId  in or_planned_items.order_activity_id%type,
        inuValue            in or_planned_items.value%type,
        ionuPlannedItemsId  in out or_planned_items.planned_items_id%type
    )
	IS
        rcPlannedItems daor_planned_items.styor_planned_items;
    BEGIN
            if ionuPlannedItemsId IS null then
                ionuPlannedItemsId := Or_BOSequences.fnuNextOR_planned_items;
            END if;

            rcPlannedItems.items_id := inuItemsId;
            rcPlannedItems.item_amount := inuItemAmount;
            rcPlannedItems.value := inuValue;
            rcPlannedItems.order_activity_id := inuOrderActivityId;
            rcPlannedItems.planned_items_id := ionuPlannedItemsId;

            daor_planned_items.insRecord(rcPlannedItems);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END insertPlannedItems;

    /*****************************************************************
    Unidad      : InsertOrUpdatePlannetItems
    Descripcion	: Inserta o actualiza los items planeados a una actividad planeada

    Autor       : Albeyro Echeverry
    Fecha       : Septiembre-05-2008


    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    14-05-2013  amendezSAO206849    Valida que se registre cantidad mínima
    18-04-2012  AEcheverrySA165500  Se elimina manejo de elementos de red
    05-04-2011  AEcheverrySAO145159  Se modifica para que NO actualice el valor del
                                    item (se corrigue a nivel de .Net).
    01-04-2011  MArteaga.SAO145030  Se modifica para que actualice el valor del
                                    item.
    15-03-2011  MArteaga.SAO143365  En caso de que se hayan ingresado 2 o mas
                                    veces un item planeado no se adiciona uno
                                    nuevo sino que se actualiza el existente.
    05-Sep-2008 AEcheverrySAO81305  Creación.
    *****************************************************************/
    PROCEDURE InsertOrUpdatePlannetItems
    (
        inuItemsId          in or_planned_items.items_id%type,
        inuItemAmount       in or_planned_items.item_amount%type,
        inuOrderActivityId  in or_planned_items.order_activity_id%type,
        inuValue            in or_planned_items.value%type,
        ionuPlannedItemsId  in out or_planned_items.planned_items_id%type
    )
	IS
        rcPlannedItems        daor_planned_items.styor_planned_items;
        nuExistedPlannedItems or_planned_items.planned_items_id%type := NULL;
        nuClassifId           ge_items.Item_Classif_Id%type;

        CURSOR cuPlannedItems
        IS
            SELECT  planned_items_id
            FROM    or_planned_items
            WHERE   or_planned_items.order_activity_id = inuOrderActivityId
                AND or_planned_items.items_id = inuItemsId;

    BEGIN
        ut_trace.trace('1 Inicia or_boplanningactivit.InsertOrUpdatePlannetItems -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);
        ut_trace.trace('2 ionuPlannedItemsId:' ||ionuPlannedItemsId||' inuItemsId:'||inuItemsId||' inuOrderActivityId:'||inuOrderActivityId,1);

        -- si el elemento es nulo retorna
        if inuItemsId  IS null then
            return;
        END if;

        -- Valida que se registre cantidad mínima  (Realiza dage_items.AccKey implicito)
        nuClassifId := dage_items.fnuGetItem_Classif_Id(inuItemsId);
        IF nuClassifId <> OR_boConstants.cnuITEMS_CLASS_TO_ACTIVITY
           and dage_item_classif.fsbGetUsed_In_Legalize(nuClassifId) = or_boconstants.csbSI
        THEN
            IF inuItemAmount <= 0.0 THEN
                -- la cantidad ingresada debe ser mayor a cero
                Errors.SetError(cnuAmmountGratherThanZero);
                raise ex.controlled_Error;
            END IF;
         ELSE
            IF inuItemAmount < 1 THEN
                -- La cantidad debe ser mayor o igual a %s1
                Errors.SetError(cnuAmmountGreatherThan,'1');
                raise ex.controlled_Error;
            END IF;
        END if;

        -- Se intenta obtener un Planned_items_id que ya exista a partir del ORDER_activity_id y el items_id de entrada, si es null es un nuevo item.

        open cuPlannedItems;
            fetch cuPlannedItems INTO nuExistedPlannedItems;
        close cuPlannedItems;

        ut_trace.trace('3 nuExistedPlannedItems ['||nuExistedPlannedItems||']',1);

        if ((ionuPlannedItemsId IS null OR not daor_planned_items.fblExist(ionuPlannedItemsId))
            AND  nuExistedPlannedItems IS null ) then

            ut_trace.trace('4 -- Insercion Registro de Planeación ',1);
            -- Insercion Registro de Planeación
            insertPlannedItems
            (
                inuItemsId,
                inuItemAmount,
                inuOrderActivityId,
                inuValue,
                ionuPlannedItemsId
            );

        else
            ut_trace.trace('5 Actualiza el Item '||nuExistedPlannedItems,1);

            rcPlannedItems := daor_planned_items.frcGetRecord(nuExistedPlannedItems);

            rcPlannedItems.items_id := inuItemsId;
            rcPlannedItems.item_amount := inuItemAmount;
            rcPlannedItems.value := inuValue;
            rcPlannedItems.order_activity_id := inuOrderActivityId;

            daor_planned_items.updRecord(rcPlannedItems);

        END IF;

        ut_trace.trace('6 Finaliza or_boplanningactivit.InsertOrUpdatePlannetItems -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('raise ex.CONTROLLED_ERROR - or_boplanningactivit.InsertOrUpdatePlannetItems -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InsertOrUpdatePlannetItems;


    PROCEDURE InsertOrUpdatePlannedActivity
    (
        inuOriginOrderAct   in OR_order_activity.origin_activity_id%type,
        inuActivityId       in OR_order_activity.activity_id%type,
        inuActivityGroup    in OR_order_activity.activity_group_id%type,
        inuSequence         in OR_order_activity.sequence_%type,
        isbComment          in OR_order_activity.comment_%type,
        ionuOrderActivity   in out OR_order_activity.order_activity_id%type
    )
    IS
        rcNewOrderActivity  daor_order_activity.styOR_order_activity;
        rcOriginOrderActiv  daor_order_activity.styOR_order_activity;
    BEGIN

        ut_trace.trace('1 or_boplanningactivit.InsertOrUpdatePlannedActivity OrdAct:['||ionuOrderActivity||'] - inuOriginOrderAct['||inuOriginOrderAct||'] -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']', 1);
        if ionuOrderActivity IS null OR not daor_order_activity.fblExist(ionuOrderActivity) then
            ut_trace.trace('2 or_boplanningactivit.createPlannedActivity:' ||ionuOrderActivity, 1);
            createPlannedActivity
            (
                inuOriginOrderAct,
                inuActivityId,
                inuActivityGroup,
                inuSequence,
                isbComment,
                ionuOrderActivity
            );
        ELSE
            ut_trace.trace('3 or_boplanningactivit updateActivity:' ||ionuOrderActivity, 1);
            rcOriginOrderActiv  := daor_order_activity.frcGetRecord(inuOriginOrderAct);
            rcNewOrderActivity  := daor_order_activity.frcGetRecord(ionuOrderActivity);

            rcNewOrderActivity.subscriber_id       := rcOriginOrderActiv.subscriber_id;
            rcNewOrderActivity.subscription_id     := rcOriginOrderActiv.subscription_id;
            rcNewOrderActivity.product_id          := rcOriginOrderActiv.product_id;
            rcNewOrderActivity.package_id          := rcOriginOrderActiv.package_id;
            rcNewOrderActivity.motive_id           := rcOriginOrderActiv.motive_id;
            rcNewOrderActivity.component_id        := rcOriginOrderActiv.component_id;

            if rcOriginOrderActiv.instance_id IS not null then
                -- si la actividad de planeación viene desde WF entonces en el
                -- instance id guardamos el plan_id de la instancia de planeación
                rcNewOrderActivity.instance_id     := dawf_instance.fnuGetPlan_Id(rcOriginOrderActiv.instance_id);
            END if;

            rcNewOrderActivity.address_id          := rcOriginOrderActiv.address_id;
            rcNewOrderActivity.process_id          := rcOriginOrderActiv.process_id;
            rcNewOrderActivity.activity_id         := inuActivityId;
            rcNewOrderActivity.comment_            := nvl(isbComment,rcNewOrderActivity.comment_);
            rcNewOrderActivity.status              := or_boconstants.csbPlannedStatus;
            rcNewOrderActivity.origin_activity_id  := inuOriginOrderAct ;
            rcNewOrderActivity.sequence_           := nvl(inuSequence,1);
            rcNewOrderActivity.activity_group_id   := inuActivityGroup;
            ut_trace.trace('4 or_boplanningactivit WfInstanceUpd:' ||rcNewOrderActivity.instance_id, 1);
            daor_order_activity.updRecord(rcNewOrderActivity);
        END if;

         ut_trace.trace('5 END or_boplanningactivit.InsertOrUpdatePlannedActivity -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']', 1);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('raise ex.CONTROLLED_ERROR - or_boplanningactivit.InsertOrUpdatePlannedActivity -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InsertOrUpdatePlannedActivity;



    -------------------------
    -- deletePlannedActivity
    -------------------------
    PROCEDURE deletePlannedActivity
    (
        inuOriginOrderAct   in OR_order_activity.origin_activity_id%type
    )
    IS
        tbPlannedActivities    daor_order_activity.tytbOrder_activity_id;
        nuIndex number ;


    BEGIN
        or_bcplanningactivit.getPlanActivByActOri(inuOriginOrderAct,null,tbPlannedActivities);
        nuIndex := tbPlannedActivities.first;

        while nuIndex IS not null loop
            -- borramos los items planeados para la actividad
            or_bcplanningactivit.deletePlannedItems(tbPlannedActivities(nuIndex));
            --borramos la actividad planeada
            daor_order_activity.delRecord(tbPlannedActivities(nuIndex));
            nuIndex := tbPlannedActivities.next(nuindex);
        END loop;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END deletePlannedActivity;


    -- OR_BOPLANNING.CHECKANDINSERTPLANNEDTASKTYPE
    PROCEDURE chkAndInsPlanActivit
    (
        inuOrderActivityId            in OR_order_activity.order_id%type,
        inuPlannedActivityId          in ge_items.items_id%type,
        iblInsertInLasPos             in boolean := TRUE
    )
    IS
        nuActivityId        ge_items.items_id%type;

        nuActivityGroupId   or_order_activity.activity_group_id%type;
        nuSequence          or_order_activity.sequence_%type;
        nuNewOrderActId     or_order_activity.order_activity_id%type;
        tbActivitiesConf    or_bcorderactivities.tytbActivitiesConf;
        nuOrderId           or_order_activity.order_id%type;
        cnuNoValidConfigforTaskType constant number := 3603;


        cursor cuMinMaxPlannedSequence
        (
            inuOrderActivityId    in or_order_activity.order_activity_id%type
        )
    	IS
            SELECT
                NVL(Min(sequence_),2) - 1 Min, NVL(Max(sequence_), 0) + 1 Max
            FROM
                or_order_activity
            WHERE
                origin_activity_id = inuOrderActivityId;

        FUNCTION fnuGetGroupForPlanAct
        (
            inuOriginActivityId     or_order_activity.origin_activity_id%type
        ) return or_order_activity.activity_group_id%type
        IS
            CURSOR cuGroupByPlanAct
            IS
            SELECT activity_group_id
            FROM or_order_activity
            WHERE origin_activity_id = inuOriginActivityId
            AND rownum = 1;
        BEGIN

            for rc in cuGroupByPlanAct loop
                return rc.activity_group_id;
            END loop;

            return fnuGetNextExecGrpId;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END;

    BEGIN
        --En ocasiones para algunos tramites el tipo de trabajo puede venir
        --vacio, esto significa que no existe planeación para ellos y
        --simplemente se omiten
        if inuPlannedActivityId IS null then
            return;
        END if;

        --Para la actividad por orden en particular se programó la actividad <inuPlannedActivityId>
        if or_bcplanningactivit.fnuGetPlannedActivityCount(inuOrderActivityId,inuPlannedActivityId) = 0 then
            nuActivityId := daor_order_activity.fnuGetActivity_id(inuOrderActivityId) ;

            if not daor_planned_activit.fblExist(nuActivityId, inuPlannedActivityId ) then
                --En caso de que el tipo de trabajo a planear no sea valido para
                --esta orden se comunica que
                --"Tipo de trabajo planeado [%s1] no es válido para el tipo de trabajo [%s2]"
                Errors.SetError(cnuNoValidConfigforTaskType,inuPlannedActivityId||'|'||nuActivityId);
                raise ex.CONTROLLED_ERROR;
            END if;

            --Ahora se calcula el valor de la secuencia dependiendo si es el
            --primer registro o se desea insertar de último
            for reg in cuMinMaxPlannedSequence(inuOrderActivityId) loop

                if iblInsertInLasPos then
                    nuSequence := reg.Max;
                else
                    nuSequence := reg.Min;
                end if;

                nuActivityGroupId := fnuGetGroupForPlanAct(inuOrderActivityId);

                ut_trace.Trace(' Se crea la actividad planeada para el grupo ['||nuActivityGroupId||']',10);

                createPlannedActivity(
                    inuOrderActivityId,
                    inuPlannedActivityId,
                    nuActivityGroupId,
                    nuSequence,
                    null,
                    nuNewOrderActId
                );

                or_bcorderactivities.GetConfig(tbActivitiesConf);
                nuOrderId := daor_order_activity.fnuGetOrder_id(inuOrderActivityId);
                --Para finalmente insertar el registro
                InsertItems
                (
                    inuOrderActivityId,
                    inuPlannedActivityId,
                    nuOrderId
                );
            end loop;
        END if;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
    END;

    /***************************************************************************
    Author:     Jhonathan RAmirez,
    Entrega:    SAO82325
    Descripcion	: Actualiza la cantidad, de un item, y  su valor.
    ***************************************************************************/
	PROCEDURE UpdItemAmountAndValue
    (
        inuPlannedItemId   Or_planned_items.planned_items_id%type,
        inuNewItemAmount   OR_planned_items.item_amount%type
    )
    IS

    rcORPlannedItems    DAOR_planned_items.styOR_planned_items;
    nuValue             OR_planned_items.value%type;
    nuOrderId           OR_order.order_id%type;
    nuOrderActiviId     OR_order_activity.order_activity_id%type;
    BEGIN
        -- Obtiene registro de Items planeados
        DAOR_planned_items.getRecord(inuPlannedItemId,rcORPlannedItems);
        -- Obtiene el numero de la orden, asociado a la orden planeada.

        nuOrderActiviId :=  daor_order_activity.fnuGetOrigin_activity_id(rcORPlannedItems.order_activity_id);
        nuOrderId       :=  daor_order_activity.fnuGetOrder_id(nuOrderActiviId);

        -- actualiza cantidad de items.
        rcORPlannedItems.item_amount := inuNewItemAmount;
        -- Obtiene el nuevo valor del Item.
        OR_BOItemValue.GetItemValuePlannedOrder (nuOrderId,
                                                 rcORPlannedItems.items_id,
                                                 inuNewItemAmount,
                                                 nuValue
                                             );
        -- se actualiza el valor.
        rcORPlannedItems.value := nuValue;
         -- se actualiza el registro.
        DAOR_planned_items.updRecord(rcORPlannedItems);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: createPlannedActivity
    Descripcion	: Realiza la creación de una actividad planeada


    Parametros	:        Descripcion
    inuActivityId      : Id del tipo de actividad a crear
    inuActivityGroupId : Id del grupo correspondiente a la actividad
    inuSequence        : Secuencia de ejecución para la actividad
    isbComment         : Comentario
    inuAddressId       : Identificador de la dirección
    inuOperSectorId    : Identificador del sector operativo
    inuSubscriptionId  : Identificador del contrato
    inuSubscriberId    : Identificador del cliente
    inuProductId       : Identificador del producto
    inuElementId       : Identificador del elemento de red

    Salida:
    onuOrderActivityId:  Id de la actividad creada.

    Autor	: AVillegasSAO80006
    Fecha	: 8-08-2005

    Historia de Modificaciones
    Fecha       IDEntrega           Descripción
    =========   =========           ====================
    05-06-2013  llopezSao208905     Se modifica para recibir el id de la acción
    05-12-2011  yclavijo.SAO166076  Se eliminan los parámetros inuReadSeq y inuReadingRoute y su referencia en el método
    15-oct-2008 AEcheverrySAO831591 se modifica para que llame al nuevo metodo
                                    de creacion de actividades planeadas
                                    con todos los datos de la actividad
    08-08-2008 AVillegasSAO80006      Creación.
    ******************************************************************/
    PROCEDURE createPlannedActivity
    (
        inuActivityId       in ge_items.items_id%type,
        inuActivityGroupId  in or_order_activity.activity_group_id%type, -- debe referenciar al grupo de órdenes al que pertence la actividad
        inuSequence         IN or_order_activity.sequence_%type,
        inuPackageId        in OR_order_Activity.package_id%type,
        inuMotiveId         in OR_order_Activity.motive_id%type,
        inuComponentId      in OR_order_Activity.component_id%type,
        inuInstanceId       in OR_order_Activity.instance_id%type,
        inuAddressId        in OR_order_Activity.address_id%type,
        inuElementId        in OR_order_Activity.element_id%type,
        inuSubscriberId     in OR_order_Activity.subscriber_id%type,
        inuSubscriptionId   in OR_order_Activity.subscription_id%type,
        inuProductId        in OR_order_Activity.product_id%type,
        inuOperSectorId     in OR_order_Activity.operating_sector_id%type,
        inuOperUnitId       in OR_order_Activity.operating_unit_id%type,
        idtExecEstimDate    in OR_order_activity.exec_estimate_date%type,
        inuProcessId        in OR_order_Activity.process_id%type,
        isbComment          in OR_order_activity.comment_%type,
        onuOrderActivityId  out or_order_activity.order_activity_id%type, -- Id de la actividad creada
        inuActionId         in or_order_activity.action_id%type default null
    )
    IS
        rcNewOrderActivity  daor_order_activity.styOR_order_activity;
    BEGIN

        ut_trace.trace('1 INICIA Or_boplanningActivit.createPlannedActivity(18 atrib) - inuActivityId ['||inuActivityId||'] - onuOrderActivityId['||onuOrderActivityId||'] -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);

        rcNewOrderActivity.activity_id         := inuActivityId;
        rcNewOrderActivity.activity_group_id   := inuActivityGroupId;
        rcNewOrderActivity.sequence_           := nvl(inuSequence,1);
        rcNewOrderActivity.package_id          := inuPackageId;
        rcNewOrderActivity.motive_id           := inuMotiveId;
        rcNewOrderActivity.component_id        := inuComponentId;
        rcNewOrderActivity.instance_id         := inuInstanceId;
        rcNewOrderActivity.address_id          := inuAddressId;
        rcNewOrderActivity.element_id          := inuElementId;
        rcNewOrderActivity.subscriber_id       := inuSubscriberId;
        rcNewOrderActivity.subscription_id     := inuSubscriptionId;
        rcNewOrderActivity.product_id          := inuProductId;
        rcNewOrderActivity.operating_sector_id := inuOperSectorId;
        rcNewOrderActivity.operating_unit_id   := inuOperUnitId;
        rcNewOrderActivity.exec_estimate_date  := idtExecEstimDate;
        rcNewOrderActivity.process_id          := inuProcessId;
        rcNewOrderActivity.comment_            := isbComment;
        rcNewOrderActivity.status              := or_boconstants.csbPlannedStatus;
        rcNewOrderActivity.action_id           := inuActionId;
        rcNewOrderActivity.register_date       := sysdate;

        onuOrderActivityId := or_bosequences.fnuNextor_order_activity;

        rcNewOrderActivity.order_activity_id := onuOrderActivityId;

        ut_trace.trace('2 FIN Or_boplanningActivit.createPlannedActivity(18 atrib) - onuOrderActivityId ['||onuOrderActivityId||'] -['||to_char(sysdate, 'dd-mm-yyyy hh:mi:ss')||']',1);

        daor_order_activity.insRecord(rcNewOrderActivity);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END createPlannedActivity;


    ----------------------
    -- fblExistOrderForAct
    -----------------------
    FUNCTION fblExistOrderForAct
    (
        inuPlannedActivityId   in OR_order_activity.order_activity_id%type
    )
    RETURN boolean
    IS
        nuOrderId OR_order.order_id%type;
    BEGIN
        nuOrderId := daor_order_activity.fnuGetOrder_id(inuPlannedActivityId);
        if nuOrderId IS null then
            return FALSE;
       ELSE
            return TRUE;
        END if;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblExistOrderForAct;

    -------------------------
    -- fblValidItemClassif
    -------------------------
	FUNCTION fblValidItemClassif
    (
    inuItemId    in or_planned_items.items_id%type
    )RETURN boolean
    IS
    sbItemClassNotMod   ge_parameter.value%type;
    nuItemClassifId     ge_items.item_classif_id%type;
    BEGIN

        -- Obtiene la lista de los tipos clasificaciones de items, a los cuales sus items no se les puede modificar el valor
        sbItemClassNotMod := GE_boparameter.fsbGet('ITEMS_CLASS_NOT_MOD');
        -- obtiene el la clasificación del item que se va a modificar.
        nuItemClassifId := dage_items.fnuGetItem_classif_id(inuItemId);

        -- Valida si el tipo de clasificación de item esta en el parametro.
        if ( Instr(',' || sbItemClassNotMod || ',' , ',' || nuItemClassifId || ',') > 0 ) then
            return TRUE;
        else
            return FALSE;
        END if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /***************************************************************************
    Propiedad intelectual de Open Systems
    Unidad      : ValidDataXML
    Descripcion : Valida los datos básicos ingresados en el XML

    Autor       :  Andres Mauricio Rojas Libreros
    Fecha       :  19-04-2013
    Parámetros  :

        inuSubcriberId      Identificador del suscriptor
        inuSubcriptionId    Identificador del contrato
        inuProductId        Identificador del producto
        inuaddress_id       Identificador de la dirección
        inuActivityId       Identificador de la actividad
        inuOperSectorId     Identificador del Sector Operativo.


    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    29-04-2013  Arojas.SAO206619    Se adicionan validaciones.
                                    Se adicionan datos de entrada. ( inuActivityId, inuActivityId)
    19-04-2013  Arojas.SAO206433    Creación
    ***************************************************************************/

    PROCEDURE ValidDataXML
    (
        inuSubcriberId      in ge_subscriber.subscriber_id%type,
        inuSubcriptionId    in suscripc.susccodi%type,
        inuProductId        in pr_product.product_id%type,
        inuaddress_id       in ab_address.address_id%type,
        inuActivityId       in ge_items.items_id%type,
        inuOperSectorId     in or_operating_sector.operating_sector_id%type
    )
    IS
        blExists boolean;  -- Booleano que recibe la existencia de los datos.
        -- Tipo de trabajo de la actividad.
        nuTaskTypeId OR_Task_Types_Items.task_type_id%type;
        -- clasificación de los tipos de trabajo para órdenes autónomas
        cnuAutClassTasktype constant or_task_type.Task_Type_Classif%type := 0;

    BEGIN

       if ( inuSubcriberId IS not null) then
            --Valida si existe el cliente
            blExists := dage_subscriber.fblExist(inuSubcriberId);
            if (not blExists) then
                ge_boerrors.SetErrorCodeArgument(1,'Cliente [' || inuSubcriberId || ']' );
            end if;
       end if;

       if ( inuSubcriptionId IS not null) then
            --Valida si existe el contrato
            blExists := pktblsuscripc.fblExist(inuSubcriptionId);
            if (not blExists) then
                ge_boerrors.SetErrorCodeArgument(1,'Contrato [' || inuSubcriptionId || ']' );
            end if;
            --Se valida consistencia de datos con el cliente, si el cliente es diferente de nulo
            if (pkbcsuscripc.fnuGetSubscriberId(inuSubcriptionId) != inuSubcriberId AND inuSubcriberId IS not null) then
                --El contrato no esta asociado al cliente dado
                ge_boerrors.SetErrorCode(902156);
            end if;
       end if;

       if ( inuProductId IS not null) then
            --Valida si existe el cliente
            blExists := dapr_product.fblExist(inuProductId);
            if (not blExists) then
                ge_boerrors.SetErrorCodeArgument(1,'Producto [' || inuProductId || ']' );
            end if;

            --Se valida consistencia de datos con el cliente, si el cliente es diferente de nulo
            if (pr_bcproduct.fnuGetSubscriberId(inuProductId) != inuSubcriberId AND inuSubcriberId IS not null) then
                --El producto no esta a ningún contrato del cliente dado
                ge_boerrors.SetErrorCode(902155);
            end if;

            --Se valida consistencia de datos con el contrato, si el contrato es diferente de nulo
            if (dapr_product.fnuGetSubscription_Id(inuProductId) != inuSubcriptionId AND inuSubcriptionId IS not null) then
                --El producto no esta asociado al contrato dado
                ge_boerrors.SetErrorCode(902154);
            end if;
       end if;

       if ( inuaddress_id IS not null) then
            --Valida si existe la dirección
            blExists := daab_address.fblExist(inuaddress_id);
            if (not blExists) then
                ge_boerrors.SetErrorCodeArgument(1,'Dirección [' || inuaddress_id || ']' );
            end if;
       end if;

       if ( inuActivityId IS not null) then
            --Valida si existe la Actividad
            blExists := dage_items.fblExist(inuActivityId);
            if (not blExists) then
                ge_boerrors.SetErrorCode(119343);
            end if;

            If (dage_items.fnuGetItem_Classif_Id(inuActivityId,0) not in (or_boconstants.cnuITEMS_CLASS_TO_ACTIVITY,or_boconstants.cnuADMIN_ACTIV_CLASSIF)) then
                ge_boerrors.SetErrorCodeArgument(901275,inuActivityId);
            end if;

            if (dage_items.fnuGetItem_Classif_Id(inuActivityId,0) <> or_boconstants.cnuITEMS_CLASS_TO_ACTIVITY) then
                ge_boerrors.seterrorcode(902165);
            end if;

            -- Obtiene el Tipo de Trabajo de la actividad
            if (or_bctask_types_items.cuTastTypeByActivity%isopen) then
                close or_bctask_types_items.cuTastTypeByActivity;
            end if;

            open or_bctask_types_items.cuTastTypeByActivity(inuActivityId);
            fetch or_bctask_types_items.cuTastTypeByActivity into nuTaskTypeId;
            close or_bctask_types_items.cuTastTypeByActivity;

            -- Valida que la actividad pertenezca a un tipo de trabajo y que éste sea de clasificación 0
            if ((nuTaskTypeId is null) or ((daor_task_type.fnuGetTask_Type_Classif(nuTaskTypeId,0)  <> cnuAutClassTasktype))) then
                -- La actividad no pertenece a un tipo de trabajo válido para la creación de órdenes autónomas
                ge_boerrors.seterrorcode(902164);
            end if;
       end if;

       if ( inuOperSectorId IS not null) then
            --Valida si existe la dirección
            blExists := daor_operating_sector.fblExist(inuOperSectorId);
            if (not blExists) then
                ge_boerrors.SetErrorCodeArgument(12381 ,inuOperSectorId );
            end if;
       end if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if (or_bctask_types_items.cuTastTypeByActivity%isopen) then
                close or_bctask_types_items.cuTastTypeByActivity;
            end if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if (or_bctask_types_items.cuTastTypeByActivity%isopen) then
                close or_bctask_types_items.cuTastTypeByActivity;
            end if;
            raise ex.CONTROLLED_ERROR;
    END ValidDataXML;

    /***************************************************************************
    Propiedad intelectual de Open Systems
    Unidad      : ProcessXML
    Descripcion : Proceso que extrae datos del xml del API para crear órdenes autónomas.

    Autor       :  Andres Mauricio Rojas Libreros
    Fecha       :  4-15-2013
    Parametros  :

        isbOrderInfo        Identificador de la orden
        otbOrderActivities  Tablas de actividades
        onuSubcriberId      Identificador del suscriptor
        onuSubcriptionId    Identificador del contrato
        onuProductId        Identificador del producto
        onuaddress_id       Identificador de la dirección


    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    19-04-2013  Arojas.SAO206433      Se agrega validación para consistencia de datos.
    4-15-2013  Arojas.SAO205273       Creación
    ***************************************************************/

    PROCEDURE ProcessXML
    (
        isbOrderInfo        in clob,
        otbOrderActivities  out tytbActivities,
        onuSubcriberId      out ge_subscriber.subscriber_id%type,
        onuSubcriptionId    out suscripc.susccodi%type,
        onuProductId        out pr_product.product_id%type,
        onuaddress_id       out ab_address.address_id%type
    )
    IS
        clOrderInfo         clob;                   --CLOB con la información XML de la orden
        dmDocument          xmldom.domdocument;     --Documento formateado XML
        ndNode              xmldom.DomNode;         --Nodo para recorrer la infromación
        ndPrev              xmldom.DomNode;         --Nodo para almacenar en que nodo se encuentra
        ndDataNode          xmldom.DomNode;         --Nodo donde se almacena los datos basicos de la orden
        ndActivitiesNode    xmldom.DomNode;         --Nodo donde se almacena las actividades que se van a generar
        sbNodeName          varchar2(100);          --Nombre del nodo en el que se encuentra
        nuCount             Number;                 --Contador de actividades.
    BEGIN

        ut_trace.trace('Inicia Or_boplanningActivit.ProcessXML',15);
        clOrderInfo := isbOrderInfo;
        --Se valida la estructura y se formatea la entrada:
        ge_boitemscargue.decupXML(clOrderInfo);

        -- Se parsea el código XML
        dmDocument :=  ut_xmlparse.parse(clOrderInfo);
        ndNode.id := dmDocument.id;

        ndNode := xmldom.getFirstChild(ndNode);--ORDER
        ndNode := xmldom.getFirstChild(ndNode);--EITHER ORDER DATA OR ACTIVITIES

        while (ndNode.id != -1) loop
            --Guardamos el nodo que estamos cargando
            ndPrev := ndNode;

            -- Obtenemos el nombre de la etiqueta xml
            sbNodeName := upper(xmldom.getNodeName(ndNode));

            if sbNodeName = 'DATA' then
                --Guardamos el nodo con los datos del documento
                ndDataNode := ndNode;

            elsif sbNodeName = 'ACTIVITIES' then
                --Guardamos el nodo con los datos del documento
                ndActivitiesNode := ndNode;
            else
                null;
            end if;

            ndNode := xmldom.getNextSibling (ndPrev);
        end loop;

        -- Se obtiene los datos del nodo de DATA y Valida que la dirección no sea nula y exista:
       onuSubcriberId  := mo_boDom.fsbGetValTag(ndDataNode,'SUBSCRIBER_ID');
       onuSubcriptionId := mo_boDom.fsbGetValTag(ndDataNode,'SUBSCRIPTION_ID');
       onuProductId := mo_boDom.fsbGetValTag(ndDataNode,'PRODUCT_ID');



       -- Si el producto es ingresado, se obtiene la dirección del producto

       if (onuProductId IS not null) then
            onuaddress_id := dapr_product.fnuGetAddress_Id(onuProductId);
       else
            onuaddress_id := mo_boDom.fsbGetValTag(ndDataNode,'ADDRESS_ID');
       end if;

       if (onuaddress_id IS null AND onuProductId IS null) then
           ge_boerrors.SetErrorCode(111108);
       end if;

       ValidDataXML(onuSubcriberId,onuSubcriptionId,onuProductId,onuaddress_id,null,null);

       --Luego iterativamente se obtiene los datos de las actividades a crear en cada orden y se almacena en la tabla pl-sql
       ndActivitiesNode := xmldom.getFirstChild(ndActivitiesNode); --ACTIVITIES
       nuCount := 0;
       while (ndActivitiesNode.id != -1) loop

            nuCount := nuCount + 1;

            otbOrderActivities(nuCount).activity_id     := mo_boDom.fsbGetValTag(ndActivitiesNode,'ACTIVITY_ID');

            if (otbOrderActivities(nuCount).activity_id IS null) then
                ge_boerrors.SetErrorCode(119343);
            end if;

            otbOrderActivities(nuCount).oper_Sector_id  := mo_boDom.fsbGetValTag(ndActivitiesNode,'OPER_SECTOR_ID');

            if (onuaddress_id IS null AND otbOrderActivities(nuCount).oper_Sector_id IS null AND onuProductId IS not null) then
                ge_boerrors.SetErrorCode(118901);
            end if;

            if (onuaddress_id IS not null) then
                otbOrderActivities(nuCount).oper_Sector_id := null;
            end if;

            ValidDataXML(null,null,null,null,otbOrderActivities(nuCount).activity_id,otbOrderActivities(nuCount).oper_Sector_id);

            otbOrderActivities(nuCount).comment_        := mo_boDom.fsbGetValTag(ndActivitiesNode,'COMMENT');
            otbOrderActivities(nuCount).sequence_       := mo_boDom.fsbGetValTag(ndActivitiesNode,'SEQUENCE');

            if (otbOrderActivities(nuCount).sequence_ IS null) then
                otbOrderActivities(nuCount).sequence_ := 1;
            end if;

            ndActivitiesNode := xmldom.getNextSibling (ndActivitiesNode);

       end loop;
       ut_xmlparse.freeDocument (dmDocument);
       ut_trace.trace('onuSubcriberId [' || onuSubcriberId || ']',15);
       ut_trace.trace('onuSubcriptionId [' || onuSubcriptionId || ']',15);
       ut_trace.trace('onuProductId [' || onuProductId || ']',15);
       ut_trace.trace('onuaddress_id [' || onuaddress_id || ']',15);
       ut_trace.trace('Finaliza Or_boplanningActivit.ProcessXML',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessXML;

    /***************************************************************************
    Propiedad intelectual de Open Systems
    Unidad      : GetResultXML
    Descripcion : Proceso que retorna XML formateado con las órdenes generadas.

    Autor       :  Andres Mauricio Rojas Libreros
    Fecha       :  4-15-2013
    Parametros  :

        rfResult        CURSOR referenciado con las órdenes generadas
        osbOrderResult  clob con xml resultado


    Historia de Modificaciones
    Fecha       Autor               Modificación
    =========   =========           ====================
    4-15-2013  Arojas.SAO205273       Creación
    ***************************************************************************/

    PROCEDURE GetResultXML
    (
        rfResult        in  constants.tyRefCursor,
        osbOrderResult  out clob
    )
    IS
        nuOrderId               or_order_activity.order_id%type;   --Identificador de la orden
        tbOrderActivities   or_bcorderactivities.tbDataActivities; --Tabla de actividades generadas en la orden.
    BEGIN

        Loop

            fetch rfResult INTO nuOrderId;
            exit when  rfResult%NOTFOUND;
            --Se obtienen actividades de la orden
            or_bcorderactivities.getActBasicDataByOrder(nuOrderId,tbOrderActivities);

            osbOrderResult := concat(osbOrderResult,concat('  <ORDER>' , chr(10)));
            osbOrderResult := concat(osbOrderResult,concat('   <ORDER_ID>' ,concat( nuOrderId , concat('</ORDER_ID>' , chr(10)))));
            osbOrderResult := concat(osbOrderResult,concat('   <ACTIVITIES>' , chr(10)));

            if (tbOrderActivities.count != 0) then

                -- Se recorre las actividades.
                for i in tbOrderActivities.first..tbOrderActivities.last loop
                    if (tbOrderActivities.EXISTS(i)) then
                        osbOrderResult := concat(osbOrderResult,concat('    <ACTIVITY>' , chr(10)));
                        osbOrderResult := concat(osbOrderResult,concat('     <ACTIVITY_ID>' , concat(tbOrderActivities(i).activity_id ,concat( '</ACTIVITY_ID>' , chr(10)))));
                        osbOrderResult := concat(osbOrderResult,concat('    </ACTIVITY>' , chr(10)));
                    end if;
                end loop;

            end if;
            osbOrderResult := concat(osbOrderResult,concat('   </ACTIVITIES>' , chr(10)));
            osbOrderResult := concat(osbOrderResult,concat('  </ORDER>' , chr(10)));

        end loop;

        ge_bogeneralutil.Close_RefCursor(rfResult);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(rfResult);
            raise ex.CONTROLLED_ERROR;
        when others then
            ge_bogeneralutil.Close_RefCursor(rfResult);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetResultXML;



END Or_boplanningActivit;
