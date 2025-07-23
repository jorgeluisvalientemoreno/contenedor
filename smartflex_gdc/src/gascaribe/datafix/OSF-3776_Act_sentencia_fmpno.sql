column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
	dbms_output.put_line('Inicia update ge_statement OSF-3776');
	
	UPDATE ge_statement 
	SET statement = 'SELECT ge_items.items_id ID, ge_items.description DESCRIPTION
FROM ge_items,  or_task_types_items, or_task_type
WHERE ge_items.item_classif_id = 2
AND ge_items.items_id = or_task_types_items.items_id
AND or_task_type.task_type_id= or_task_types_items.task_type_id
AND or_task_type.task_type_classif = 100
AND NOT EXISTS (SELECT items_id FROM ct_item_novelty WHERE items_id = ge_items.items_id)'
	WHERE description = 'LDC - Obtiene las actividades de PNO';
	
	commit;
  
	dbms_output.put_line('Finaliza update ge_statement OSF-3776');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/