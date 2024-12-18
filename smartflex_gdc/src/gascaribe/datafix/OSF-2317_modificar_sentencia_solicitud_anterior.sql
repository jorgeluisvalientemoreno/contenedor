column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2317_modificar_sentencia_solicitud_anterior.sql
            Se procede a devolver el caso como cambio de alcance, debido a que se debe 
            entregar un datafix que permita aplicar el cambio solicitado ( la validación 
            por tipo de causal y no por clase de causal en la sentencia del flujo) para 
            las solicitudes de terminación de contrato que se encuentran abiertas

    Se crea datafix complementario a la modificación del flujo, el cual se debe ejecutar
    despues de modificar el flujo.
*/
    -- Cursor para traer la ultima sentencia de la causal asociada al nuevo flujo
    CURSOR cuNewSentencia is
        select statement_id
        from open.wf_unit_attribute a, 
             open.wf_unit u
        where attribute_id = 458
          and u.unit_id    = a.unit_id
          and u.unit_id    = 150009;    

    -- Cursor de las ordenes 
    CURSOR cuOrdenes IS
        select o.order_activity_id, o.order_id, o.package_id, o.status, b.instance_attrib_id, b.statement_id
        from open.or_order_activity o
           inner join open.wf_instance_attrib b
               on b.instance_id  = o.instance_id
              and b.attribute_id = 458
              and b.statement_id = 120149917 -- Instancia anterior donde se usaba SELECT g.class_causal_id FLAG_NOTIFY
        where o.status      <> 'F'           -- No finalizadas
          and o.task_type_id = 12562;

    nuContOrd           number;
    nuTotOrd            number;
    nuNewSentencia      number;
    nuIdSent            number;
    exError             EXCEPTION;

BEGIN

    nuContOrd  := 0;
    nuTotOrd   := 0;

    -- Carga de Person ID para el comentario
    open cuNewSentencia;
    fetch cuNewSentencia into nuNewSentencia;
    close cuNewSentencia;

    -- sino existe la persona pone la default de OPEN
    IF nuNewSentencia is null THEN
        RAISE exError;
    END IF;

    dbms_output.put_line('Codigo Nueva Sentencia [' || nuNewSentencia || ']');
    dbms_output.put_line('Fecha sistema          [' || open.pkgeneralservices.fdtgetsystemdate || ']');
    dbms_output.put_line('order_activity_id|order_id|package_id|status|instance_attrib_id|old_statement_id|new_statement_id');

    -- Recorrer todas las ordenes pendientes
    FOR rcOrd in cuOrdenes LOOP
        nuTotOrd := nuTotOrd + 1;
        BEGIN
            -- Cambia la instancia anterior por la nueva instancia de la orden relacionada
            nuIdSent := null;
            update open.wf_instance_attrib
              set statement_id = nuNewSentencia
            where instance_attrib_id = rcOrd.instance_attrib_id
              returning statement_id into nuIdSent;

            if (nuIdSent is not null) then
                dbms_output.put_line(rcOrd.order_activity_id||'|'||rcOrd.order_id          ||'|'||rcOrd.package_id  ||'|'||
                                     rcOrd.status           ||'|'||rcOrd.instance_attrib_id||'|'||rcOrd.statement_id||'|'||nuIdSent);
                nuContOrd := nuContOrd + 1;
            end if;

            -- Asienta la transaccion
            commit;

        EXCEPTION
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('Error modificando Orden: '|| rcOrd.order_activity_id ||', SQLERRM: '|| SQLERRM );
        END;

    END LOOP;

    dbms_output.put_line('Ordenes Seleccionadas:   '||nuTotOrd ||', Ordenes modificadas:    '||nuContOrd);
    dbms_output.put_line('Fin del Proceso.');

EXCEPTION
    WHEN exError THEN
        dbms_output.put_line('Error: aun no esta cargada la nueva sentencia del flujo modificado "LDC-clase de causal fallo it visitec"');
    WHEN OTHERS THEN
        dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotOrd||', Ordenes Anuladas: '||nuContOrd ||', '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/