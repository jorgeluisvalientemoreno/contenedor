column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuPackages IS
    select wi.instance_id, 
		   wde.package_id
	from wf_data_external wde, wf_instance wi
	where package_id in (56520658, 58533984, 62045594, 62265311, 62800611, 63124086, 63162405, 118885583, 123743486, 139969179, 
						 141005123, 144115202, 145730361, 147629800, 163180093, 173733160, 180578738, 190094908, 198628085, 198643013,
						 199706517, 199922373, 201127235, 203449001, 203449180)
	and wi.plan_id      = wde.plan_id
	and wi.unit_type_id = 162
	and status_id       = 4;

BEGIN

	dbms_output.put_line('Inicia OSF-2142');

	FOR reg IN cuPackages LOOP
		BEGIN
			dbms_output.put_line('Empujando la solicitud: ' || reg.package_id);
		  
			WF_BOAnswer_Receptor.AnswerReceptor(reg.instance_id, -- Código de la instancia del flujo
												2				 -- Causal de fallo
												); 
		
		EXCEPTION
			WHEN OTHERS THEN
			dbms_output.put_line('Error OTHERS error con la solicitud: ' || reg.package_id || ' : ' || sqlerrm);
			ROLLBACK;
		END;
	  END LOOP;
  
	dbms_output.put_line('Finaliza OSF-2142');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/