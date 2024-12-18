column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  isbOrderComme varchar2(4000) := 'Se actualiza DATA de orden 335220868 para retornar al estado 0 - Registrado - caso OSF-3287';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

  CURSOR cuOrdenes is
    select o.*
      from open.or_order o
     where o.order_id = 335220868
       and o.order_status_id = 5;

  rcOperUnitRecord    open.daor_operating_unit.styOR_operating_unit;
  nuTotalUsedCapacity number;
  cnuTOT_SEG_MINU constant number := 60;
  nuOrderDuration number := 0;

BEGIN
  for reg in cuOrdenes loop
  
    begin
    
      --Actualizar Orden 
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
    
      --Agregar comentario del cambio de estado de la orden 
      insert into OPEN.or_order_stat_change
        (ORDER_STAT_CHANGE_ID,
         ACTION_ID,
         INITIAL_STATUS_ID,
         FINAL_STATUS_ID,
         ORDER_ID,
         STAT_CHG_DATE,
         USER_ID,
         TERMINAL,
         execution_date,
         range_description,
         programing_class_id,
         initial_oper_unit_id,
         final_oper_unit_id,
         COMMENT_TYPE_ID,
         CAUSAL_ID)
      values
        (or_bosequences.fnuNextOr_Order_Stat_Change,
         100,
         reg.order_status_id,
         0,
         reg.order_id,
         sysdate,
         user,
         ut_session.getTERMINAL,
         null,
         null,
         null,
         null,
         null,
         null,
         null);
    
      --Agregar comentario a la orden
      OS_ADDORDERCOMMENT(reg.order_id,
                         nuCommentType,
                         isbOrderComme,
                         nuErrorCode,
                         sbErrorMesse);
    
      if nuErrorCode = 0 then
        COMMIT;
        dbms_output.put_line('Orden [' || reg.order_id ||
                             '] actualizada de forma exitosa para ser desbloqueada por le funcional.');
      
      else
        rollback;
        dbms_output.put_line('Error - Orden [' || reg.order_id ||
                             '] No permitio ser bloqueada y dejada en estado registrada. [' ||
                             sbErrorMesse || ']');
      
      end if;
    
    exception
      when others then
        Rollback;
        dbms_output.put_line('Error: ' || sqlerrm);
    end;
  
  end loop;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/