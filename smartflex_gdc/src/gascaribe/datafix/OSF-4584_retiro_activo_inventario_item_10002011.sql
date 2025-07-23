column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  csbCaso constant varchar2(20) := 'OSF-4584';

BEGIN

  delete open.ldc_inv_ouib
   where ldc_inv_ouib.items_id = 10002011
     and ldc_inv_ouib.operating_unit_id IN (4559, 4560);
  delete open.LDC_ACT_OUIB
   where ldc_act_ouib.items_id = 10002011
     and ldc_act_ouib.operating_unit_id IN (4559, 4560);

  commit;
  dbms_output.put_line('Se elimina registro de Activo e Inventario del item 10002011 para unidad 4559 y 4560');

exception
  when others then
    rollback;
    dbms_output.put_line('No se elimina registro de Activo e Inventario del item 10002011 para unidad 4559 y 4560 - Error: ' ||
                         sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/