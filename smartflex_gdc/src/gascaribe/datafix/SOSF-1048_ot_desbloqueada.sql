column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  isbOrderComme varchar2(4000) := 'Se desbloquea y se retira unidad operativa por CA SOSF-1048';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

  CURSOR cuOrdenes is
    select o.order_id,
           o.order_status_id,
           o.created_date,
           o.assigned_date,
           o.operating_unit_id,
           open.daor_operating_unit.fsbgetname(o.operating_unit_id),
           u.contractor_id,
           o.task_type_id,
           open.daor_task_type.fsbgetdescription(o.task_type_id)
      from open.or_order o, open.or_operating_unit u
     where o.order_status_id = 11
       and o.operating_unit_id = u.operating_unit_id
          --and O.TASK_TYPE_ID IN (12162 ,  10500 ) 
          --and o.operating_unit_id in (2396, 2404, 2405,2406, 2407,2408)
       and u.contractor_id is not null
       and o.order_id = 204866846
    /*and not exists(
     select null
      from open.ct_tasktype_contype tc, open.ge_contrato co
    where o.task_type_id= tc.task_type_id
      and tc.contract_type_id=co.id_tipo_contrato
      and co.id_contratista=u.contractor_id
      and co.status='AB'
      and co.fecha_final>=trunc(sysdate))*/
    ;

  rcOperUnitRecord    open.daor_operating_unit.styOR_operating_unit;
  nuTotalUsedCapacity number;
  cnuTOT_SEG_MINU constant number := 60;
  nuOrderDuration number := 0;
BEGIN
  for reg in cuOrdenes loop
    "OPEN".daor_operating_unit.GetRecord(reg.operating_unit_id,
                                         rcOperUnitRecord);
    nuTotalUsedCapacity := nvl(rcOperUnitRecord.Used_Assign_Cap, 0);
    --dbms_output.put_line('nuTotalUsedCapacity : '||nuTotalUsedCapacity);
    nuOrderDuration := open.OR_BCOptimunRoute.fnuCalcularDuracion(reg.order_id);
    --dbms_output.put_line('nuOrderDuration : '||nuOrderDuration);
    nuOrderDuration := nvl(nuOrderDuration / cnuTOT_SEG_MINU, 0);
    --dbms_output.put_line('nuOrderDuration : '||nuOrderDuration);
    if nvl(nuOrderDuration, 0) > 0 and
       nuTotalUsedCapacity - nuOrderDuration > 0 then
      nuTotalUsedCapacity := nuTotalUsedCapacity - nuOrderDuration;
      "OPEN".daor_operating_unit.updUsed_Assign_Cap(reg.operating_unit_id,
                                                    nuTotalUsedCapacity);
    end if;
    --dbms_output.put_line('nuTotalUsedCapacity : '||nuTotalUsedCapacity);
  
    --/*--Actualizar Orden 
    update or_order
       set assigned_date        = null,
           exec_estimate_date   = null,
           assigned_with        = null,
           max_date_to_legalize = null,
           operating_unit_id    = null,
           prev_order_status_id = 0
     where order_id = reg.order_id;
  
    --Actualizar Actividad de la Orden
    update or_order_activity
       set operating_unit_id = null
     where order_id = reg.order_id;
    OS_ADDORDERCOMMENT(reg.order_id,
                       nuCommentType,
                       isbOrderComme,
                       nuErrorCode,
                       sbErrorMesse);
  
    if nuErrorCode = 0 then
      dbms_output.put_line('Orden [' || reg.order_id ||
                           '] bloqueada dejada en estado registrada de forma exitosa.');
      COMMIT;
    else
      dbms_output.put_line('Error - Orden [' || reg.order_id ||
                           '] No permitio ser bloqueada y dejada en estado registrada. [' ||
                           sbErrorMesse || ']');
      rollback;
    end if;
    --*/
  end loop;
  --commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/