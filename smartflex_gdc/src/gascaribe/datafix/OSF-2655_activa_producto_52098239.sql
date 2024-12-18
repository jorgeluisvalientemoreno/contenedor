column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuMovimiento number;

begin

  UPDATE SERVSUSC SET SESUESCO = 96 WHERE SESUNUSE in (52098239);
  update pr_product p
     set p.product_status_id = 15
   where p.product_id in (52098239);

  update pr_component cp
     set cp.component_status_id = 17
   where cp.product_id in (52098239);

  update compsesu cp set cp.cmssescm = 17 where cp.cmsssesu in (52098239);

  update mo_packages
     set attention_date = null, motive_status_id = 13
   where package_id in (158758150);

  update mo_component
     set attention_date = null, motive_status_id = 15
   where package_id in (158758150);

  update MO_MOTIVE
     set attention_date     = null,
         status_change_date = null,
         motive_status_id   = 1
   where package_id in (158758150);

  commit;
  dbms_output.put_line('Se actualiza estado producto 52098239 a estado 15 - Pendiente instalacion.');

exception
  when others then
    dbms_output.put_line('Error: ' || sqlerrm);
    rollback;
  
end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/