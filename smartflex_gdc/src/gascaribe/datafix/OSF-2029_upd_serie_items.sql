column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2029');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia OSF-2029');
  
  UPDATE ge_items_seriado
  SET serie = 'BQ-15C-'
  WHERE id_items_seriado = 2087380;
  
  UPDATE ge_items_seriado
  SET serie = 'BQ-15C'
  WHERE id_items_seriado = 1496;
  
  dbms_output.put_line('Finaliza OSF-2029');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/