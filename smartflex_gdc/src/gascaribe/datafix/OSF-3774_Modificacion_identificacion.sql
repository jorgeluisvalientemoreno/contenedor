column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia OSF-3774 !');
  execute immediate 'ALTER TRIGGER PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE DISABLE';
  
  UPDATE ge_subscriber SET identification = '150315448844'  WHERE subscriber_id = 2140455;
  UPDATE mo_data_change SET entity_attr_old_val = '150315448844' WHERE data_change_id = 1292075; 

  dbms_output.put_line('Fin OSF-3774 !');
  commit;
  execute immediate 'ALTER TRIGGER PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE ENABLE';
 
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/