column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuTipoContrato		NUMBER := 2470;
	sbTipoTrabajoExiste	VARCHAR2(1);

	CURSOR cuData 
	IS
		SELECT * 
		FROM ct_tasktype_contype 
		WHERE contract_type_id IN (932, 910, 1190, 1193)
		ORDER BY contract_type_id;
		
	CURSOR cuValidaTipoTrabajo(inuTipoTrabajo NUMBER)
	IS
		SELECT /*+ index (CT_TASKTYPE_CONTYPE IDX_CT_TASKTYPE_CONTYPE01) */
				'X'
        FROM CT_TASKTYPE_CONTYPE
        WHERE contract_type_id = nuTipoContrato
        AND task_type_id = inuTipoTrabajo;
	

BEGIN

	dbms_output.put_line('Inicia OSF-4722');
	
	FOR reg IN cuData LOOP
	
		IF(cuValidaTipoTrabajo%ISOPEN) THEN 
			CLOSE cuValidaTipoTrabajo;
		END IF;
		
		sbTipoTrabajoExiste := NULL;
		
		OPEN cuValidaTipoTrabajo(reg.task_type_id);
		FETCH cuValidaTipoTrabajo INTO sbTipoTrabajoExiste;
		CLOSE cuValidaTipoTrabajo;
		
		IF (sbTipoTrabajoExiste IS NULL) THEN
	
			dbms_output.put_line('Inicia asociación del tipo de trabajo ' || reg.task_type_id || ' en el tipo de contrato ' || nuTipoContrato);
		
			INSERT INTO ct_tasktype_contype(tasktype_contype_id, 
											contract_type_id, 
											task_type_id, 
											contract_id, 
											flag_type
											)
			VALUES (SEQ_CT_TASKTYPE_CON_143315.NEXTVAL,
					nuTipoContrato,
					reg.task_type_id,
					NULL,
					'T');	
			
			COMMIT;
			
			dbms_output.put_line('Finaliza asociación del tipo de trabajo ' || reg.task_type_id || ' en el tipo de contrato ' || nuTipoContrato);
		ELSE
			dbms_output.put_line('El tipo de trabajo ' || reg.task_type_id || ' ya esta configurado en el tipo de contrato ' || nuTipoContrato);
			
		END IF;
		
	END LOOP;
	
	dbms_output.put_line('Finaliza OSF-4722');
	
EXCEPTION
	when others THEN
		dbms_output.put_line('Error no controlado ' ||sqlerrm);
		rollback;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/