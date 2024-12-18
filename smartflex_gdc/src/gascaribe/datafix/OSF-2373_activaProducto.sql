column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2373');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

  dbms_output.put_line('Inicia OSF-2373');
  
  UPDATE pr_product
  SET product_status_id = 1
  WHERE product_id = 1055479;
  
  dbms_output.put_line('Se actualiza el estado de pr_product 1055479 de 20 a 1');
  
  UPDATE pr_component
  SET component_status_id = 5
  WHERE product_id = 1055479;
  
  dbms_output.put_line('Se actualiza el estado de pr_component del producto 1055479 de 21 a 20');
  
  UPDATE WF_INSTANCE i
  SET i.status_id = 8 -- Cancelada
  WHERE i.INSTANCE_ID = -1758209593;  
  
  dbms_output.put_line('Finaliza OSF-2373');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/