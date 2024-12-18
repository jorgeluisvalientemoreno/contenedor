column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	nucausal_id	GE_ITEMS_DOCUMENTO.causal_id%type;

begin
  dbms_output.put_line('Inicia OSF-1209');
  
  SELECT causal_id
  into nucausal_id
  from GE_ITEMS_DOCUMENTO
  where id_items_documento = 25584;
  
  update GE_ITEMS_DOCUMENTO
  set causal_id = 3369
  where id_items_documento = 25584;
  
  dbms_output.put_line('Actualizando la causal: ' || nucausal_id || ' por la causal 3369 del documento 25584');
  
  dbms_output.put_line('Termina OSF-1209');    
  
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/