column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
   update master_personalizaciones
      set comentario='BORRADO'
  where not exists (select 'x' from all_objects where nombre = object_name);


  COMMIT;
end;
/

begin
   update open.master_personalizaciones
     set comentario='POLITICA SAASE'
   where tipo_objeto = 'FUNCTION'
     and nombre like 'FSBPL%';

  COMMIT;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/