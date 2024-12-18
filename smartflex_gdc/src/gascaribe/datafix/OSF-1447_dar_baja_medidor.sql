column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1445');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuMovimiento number;
  sbSerial     varchar2(100) := 'I-13270248W';
  nuItemSeri   number := 1967841;
  nuItemId     number := 10002017;
  nuUnidad     number := 3007;
begin

  update open.ge_items_seriado
     set id_items_estado_inv = 8,
         operating_unit_id   = null,
         items_id            = nuItemId
   where serie = sbSerial
     and id_items_seriado = nuItemSeri;

  commit;
  dbms_output.put_line('Actualizacion DATA del medidor ' || sbSerial ||
                       ' asociada al nuevo item ' || nuItemId ||
                       ' y dado de baja.');

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/