column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Actualizar balance de item 10009036 en bodega 799');
  -- Actualizo balance de item 10009036 en bodega 799
  Update OPEN.OR_OPE_UNI_ITEM_BALA a
     set a.balance = 1
   where a.items_id = 10009036
     and a.operating_unit_id = 799;

  commit;
exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo Actualizar balance de item 10009036 en bodega 799');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/