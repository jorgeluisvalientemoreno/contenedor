column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuEjecucionFlujo NUMBER := 0;
	nuErrorCode    NUMBER(18);
	sbErrorMessage VARCHAR2(2000);
	
  	CURSOR cuPackages IS
	SELECT 	   P.PACKAGE_ID,
			   WF.INSTANCE_ID
		  FROM OPEN.WF_INSTANCE      WF,
			   OPEN.WF_EXCEPTION_LOG EL,
			   OPEN.MO_PACKAGES      P,
			   OPEN.WF_DATA_EXTERNAL DE
		 WHERE WF.INSTANCE_ID = EL.INSTANCE_ID
		   AND DE.PLAN_ID = WF.PLAN_ID
		   AND DE.PACKAGE_ID = P.PACKAGE_ID
		   AND WF.STATUS_ID IN (9, 14)
		   AND EL.STATUS = 1
		   AND P.package_type_id = 100101
		   AND p.motive_status_id = 13
		   AND EL.MESSAGE_DESC like '%No se hallaron destinos válidos para la tarea%';

BEGIN

	dbms_output.put_line('Inicia OSF-3584');

	FOR reg IN cuPackages LOOP
		nuEjecucionFlujo := 0;

		update WF_INSTANCE set status_id =4 where  instance_id = reg.instance_id;

		BEGIN
			dbms_output.put_line('Empujando la solicitud: ' || reg.package_id);
		  
			WF_BOAnswer_Receptor.AnswerReceptor(reg.instance_id, -- Código de la instancia del flujo
												MO_BOCausal.fnuGetSuccess
												); 

			nuEjecucionFlujo := 0;
		
		EXCEPTION
			when ex.CONTROLLED_ERROR then
			nuEjecucionFlujo := 1;
			Errors.getError(nuErrorCode, sbErrorMessage);
			dbms_output.put_line('ERROR CONTROLLED ');
			dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
			dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
			when OTHERS then
			nuEjecucionFlujo := 1;
			Errors.setError;
			Errors.getError(nuErrorCode, sbErrorMessage);
			dbms_output.put_line('ERROR OTHERS ');
			dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
			dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
		END;
	  END LOOP;

	  COMMIT;
  
	dbms_output.put_line('Finaliza OSF-3584');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/