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
         set order_status_id = 0
       where order_id = reg.order_id;

    COMMIT;
    dbms_output.put_line('Orden [' || reg.order_id || '] actualizada estado a 0.');

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