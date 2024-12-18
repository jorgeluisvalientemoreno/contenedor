column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	nucausal_id	or_order.order_id%type;

begin
  dbms_output.put_line('Inicia OSF-1207');
  
  SELECT causal_id
  into nucausal_id
  from or_order
  where order_id = 284145064;
  
  update or_order
  set causal_id = 9595
  where order_id = 284145064;
  
  dbms_output.put_line('Actualizando la causal: ' || nucausal_id || ' por la causal 9595 de la orden 284145064');
  
  dbms_output.put_line('Termina OSF-1207');    
  
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/