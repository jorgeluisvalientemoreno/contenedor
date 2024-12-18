column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2351');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia OSF-2351');
  
  UPDATE ge_items_seriado
  SET id_items_estado_inv 	= 5,
	  fecha_salida 			= to_date('23/09/2016 14:54:45'),
	  operating_unit_id 	= NULL
  WHERE serie 			= 'K-3331123-16'
  AND id_items_seriado  = 2083998;
  
  UPDATE ge_items_seriado
  SET operating_unit_id = NULL,
	  subscriber_id 	= 1556924
  WHERE serie = 'K-3331140-16'
  AND id_items_seriado  = 2084000;
  
  
  dbms_output.put_line('Finaliza OSF-2351');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/