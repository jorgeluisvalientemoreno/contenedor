DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);


    -- Causales que provocan anulacion de la orden
    cnuANNUL_CAUSAL_TYPE    CONSTANT NUMBER         := 18;

    -- Para validar la causal de legalización de la orden
    rcOrderActivity    daor_order_activity.styOR_order_activity;
    rcOrder            daor_order.styOR_order;
    rcCausal           dage_causal.styGE_Causal;
    -- Flag que indica si se reconecta o no el producto
    blFlagReconect     boolean := TRUE;
    dtInactiveDate     pr_prod_suspension.inactive_date%type;
    
    -- se obtienen los registros de suspensiones que fueron aplicadas y posteriormente inactivadas
    -- pero que no se les asignó fecha de inactivación (pr_prod_suspension.inactive_date)
    CURSOR cuProdSuspen
    IS
    SELECT
        *
    FROM
    (
        SELECT
            a.product_id,
            a.prod_suspension_id,
            a.register_date register_date_pr,
            a.aplication_date aplication_date_pr,
            a.inactive_date inactive_date_pr,
            a.active active_pr,
            c.package_id,
            b.motive_id motive_id_m,
            b.register_date register_date_m,
            b.aplication_date aplication_date_m,
            b.ending_date ending_date_m
        FROM pr_prod_suspension a, mo_suspension b, mo_motive c, mo_packages d
        WHERE 1=1
        --AND   a.product_id = 532
        AND   a.aplication_date IS not null
        AND   a.active = 'N'
        AND   a.inactive_date IS null
        AND   a.suspension_type_id = 5
        AND   a.register_date = b.register_date
        AND   b.suspension_type_id = 5
        AND   b.motive_id = c.motive_id
        AND   a.product_id = c.product_id
        AND   c.package_id = d.package_id
        AND   d.package_type_id = 100209
        ORDER BY a.product_id, a.register_date
    )
    WHERE rownum <= 5;

    -- se obtiene las solicitudes de reconexión generadas posteriormente a la fecha de aplicación de la suspensión en proceso a corregir
    CURSOR cuSolisRecon
    (
        inuProduct      in mo_motive.product_id%type,
        idtAplication   in mo_suspension.aplication_date%type
    )
    IS
    SELECT
        c.motive_id,
        --c.register_date,
        --c.aplication_date,
        b.package_id
    FROM mo_motive a, mo_packages b, mo_suspension c
    WHERE 1=1
    AND   a.product_id = inuProduct
    AND   a.package_id = b.package_id
    AND   b.package_type_id = 100210 -- reconexión voluntaría
    AND   a.motive_id = c.motive_id
    AND   c.register_date >= idtAplication -- reconexión registrada después o en la misma fecha de la atención de la suspensión
    ORDER BY c.register_date;

    CURSOR cuDateAttentionInstanceRecon
    (
        inuPackageId    in mo_wf_pack_interfac.package_id%type
    )
    IS
    SELECT
        attendance_date
    FROM mo_wf_pack_interfac
    WHERE PACKAGE_id = inuPackageId  -- Acción Reconexión en Sistema - Reconexión Voluntaria
    AND   action_id = 8117;
    /*
    -- si la solicitud de reconexion asociada al motivo ingresado cumple alguna de las siguientes condiciones,
    --  quiere decir que se llevó a cabo la reconexión, si no, se valida la siguiente solicitud de reconexión:
    
    -- si no existe la orden, se reconectó
    -- si existe la orden y no tiene causal, se reconectó
    -- si existe la orden y tiene causal de éxito se reconecta
    CURSOR cuReconIsSucces
    (
        inuMotive       mo_suspension.motive_id%type,
        inuProductId    mo_motive.product_id%type
    )
    IS
    SELECT
        nvl((SELECT
                (CASE when a.causal_id IS null then
                          'Y' -- si la última orden atendida no tiene causal se reconecta
                      else nvl((SELECT 'Y' FROM ge_causal gc WHERE gc.causal_id = a.causal_id AND gc.class_causal_id = 1),'N') -- si la última orden atendida tiene causal y es de éxito se reconecta
                 END)reconectar
            FROM (
                    SELECT
                        oo.ORDER_id,
                        oo.causal_id
                    FROM OR_order_activity ooa,
                       OR_order oo
                    WHERE 1=1
                    AND   ooa.motive_id = inuMotive
                    AND   ooa.product_id = inuProductId
                    AND   ooa.status = 'F'
                    AND   nvl(ooa.instance_id,0)<>0
                    AND   ooa.order_id = oo.order_id
                    ORDER BY ooa.order_activity_id desc
                )a
            WHERE rownum = 1
        ),'Y')reconectar
    FROM dual;*/

    -- se obtienen los componentes que se suspendieron
    CURSOR cuCompSuspen
    (
        inuMotiveId         in      mo_suspension.motive_id%type,
        inuRegisterDate     in      pr_prod_suspension.register_date%type
    )
    IS
    SELECT
        b.comp_suspension_id,
        b.component_id,
        b.register_date register_date_c,
        b.aplication_date aplication_date_c,
        b.inactive_date inactive_date_c
    FROM mo_component a, pr_comp_suspension b
    WHERE 1=1
    AND   a.motive_id = inuMotiveId
    AND   a.component_id_prod = b.component_id
    AND   b.register_date = inuRegisterDate
    AND   b.suspension_type_id = 5;

BEGIN                         -- ge_module
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');

    for x in cuProdSuspen loop

        dbms_output.put_line('---------------------------------------------------------------------------------------------------');
        dbms_output.put_line('se obtuvo el producto: '||x.product_id);
        dbms_output.put_line('se debe actualizar la fecha de inactivación para la solicitud de suspensión: '||x.package_id);
        dbms_output.put_line('datos obtenidos: ');
        dbms_output.put_line('id registro pr_prod_suspension: '||x.prod_suspension_id);
        dbms_output.put_line('fecha registro pr_prod_suspension: '||x.register_date_pr);
        dbms_output.put_line('fecha aplicacion pr_prod_suspension: '||x.aplication_date_pr);
        dbms_output.put_line('fecha inactivación pr_prod_suspension: '||x.inactive_date_pr);
        dbms_output.put_line('activa en pr_prod_suspension: '||x.active_pr);
        dbms_output.put_line('motivo mo_suspension: '||x.motive_id_m);
        dbms_output.put_line('fecha registro mo_suspension: '||x.register_date_m);
        dbms_output.put_line('fecha aplicacion mo_suspension: '||x.aplication_date_m);
        dbms_output.put_line('fecha inactivación mo_suspension: '||x.ending_date_m);


        for y in cuSolisRecon(x.product_id, x.aplication_date_pr) loop


            blFlagReconect := TRUE;
            
            dbms_output.put_line('');
            dbms_output.put_line('buscando actividad de reconexión...');
            -- Obtiene la actividad de la orden, asociada al producto y al motivo
            rcOrderActivity  := OR_BCActivitiesByTaskType.frcGetRecbyMotAndPro(y.motive_id, x.product_id);

            if cuDateAttentionInstanceRecon%isopen then
                close cuDateAttentionInstanceRecon;
            END if;

            open cuDateAttentionInstanceRecon(y.package_id);
            fetch cuDateAttentionInstanceRecon into dtInactiveDate;
            close cuDateAttentionInstanceRecon;


            -- lógica copiada del servicio MO_BOSuspension.SuspVolProdAttention
            
            
            -- Valida si existe una actividad asociada al motivo
            if  (rcOrderActivity.order_activity_id is not null) then

                -- Obtiene la orden del motivo
                rcOrder := daor_order.frcgetrecord(rcOrderActivity.order_id);
                dtInactiveDate := rcOrder.execution_final_date;

                if (rcOrder.causal_id IS not null) then
                    -- Obtiene la causal de legalización de la orden
                    rcCausal := dage_causal.frcGetRecord(rcOrder.causal_id);

                    if (rcCausal.class_causal_id <> mo_bocausal.fnugetsuccess) then
                        -- No se realiza la reconexión del producto
                        blFlagReconect := FALSE;
                        --dbms_output.put_line('No se realizara la reconexión voluntaria del producto');

                    -- Valida si la causal es de éxito y de tipo diferente de anulación
                    elsif ((rcCausal.class_causal_id = MO_BOCausal.fnuGetSuccess) AND
                           (rcCausal.causal_type_id <> cnuANNUL_CAUSAL_TYPE)) then

                        -- Se realiza la reconexión del producto
                        blFlagReconect := TRUE;
                        --dbms_output.put_line('Se realizara la reconexión voluntaria del producto');

                    -- Se anulo la orden
                    elsif (rcCausal.causal_type_id = cnuANNUL_CAUSAL_TYPE) then
                        -- No se realiza la reconexión del producto
                        blFlagReconect := FALSE;
                        --dbms_output.put_line('No se realizara la reconexión voluntaria del producto');
                    END if;
                -- Si no existe causal de legalización de la orden se reconecta el producto
                else
                    -- Se realiza la reconexión del producto
                    blFlagReconect := TRUE;
                    --dbms_output.put_line('Se realizara la reconexión voluntaria del producto');
                END if;
            -- Si no existe orden se reconecta el producto
            else
                -- Se realiza la reconexión del producto
                blFlagReconect := TRUE;
                --dbms_output.put_line('Se realizara la reconexión voluntaria del producto');

            END if;
            
            if blFlagReconect then
            
                dbms_output.put_line('Actividad de reconexión encontrada ['||rcOrderActivity.order_activity_id||']');
                dbms_output.put_line('Causal ['||rcCausal.causal_id||']');
                dbms_output.put_line('Clase de causal ['||rcCausal.class_causal_id||']');
                dbms_output.put_line('Tipo de causal ['||rcCausal.causal_type_id||']');
                
                dbms_output.put_line('motivo de reconexión obtenido: '||y.motive_id);
                dbms_output.put_line('se actualiza la fecha de inactivación de la suspensión con la fecha de reconexión: '||dtInactiveDate||' de la solicitud: '||y.package_id);

                dapr_prod_suspension.updinactive_date(x.prod_suspension_id, dtInactiveDate);

                if x.ending_date_m IS null then
                    dbms_output.put_line('se actualiza la fecha de inactivación de la suspensión del motivo: '||x.motive_id_m);
                    damo_suspension.updending_date(x.motive_id_m, dtInactiveDate);
                END if;

                for z in cuCompSuspen(x.motive_id_m, x.register_date_pr) loop
                    if z.inactive_date_c IS null then
                        dbms_output.put_line('se actualiza la fecha de inactivación de la suspensión del componente: '||z.component_id);
                        dapr_comp_suspension.updinactive_date(z.comp_suspension_id, dtInactiveDate);
                    END if;
                END loop;
                
                -- finalizar loop de reconexiones si la solicitud en proceso llevó a cabo la reconexión, es decir, levantó la suspensión a corregir
                exit;
                
            END if;

        END loop;

    
    END loop;

    ut_trace.Trace('FIN');
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        if cuDateAttentionInstanceRecon%isopen then
            close cuDateAttentionInstanceRecon;
        END if;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        if cuDateAttentionInstanceRecon%isopen then
            close cuDateAttentionInstanceRecon;
        END if;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;