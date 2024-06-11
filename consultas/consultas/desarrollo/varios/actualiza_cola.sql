DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
	
 CURSOR CUSOLICITUDES IS
 select *
from open.wf_instance
where status_id=9
  and unit_id in (252,102584)
  and initial_date>=TO_DATE('01/01/2080','DD/MM/YYYY');
BEGIN   
    FOR REG IN CUSOLICITUDES LOOP                     -- ge_module
		BEGIN
		errors.Initialize;
		--ut_trace.Init;
		--ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
		--ut_trace.SetLevel(90);
		--ut_trace.Trace('INICIO');
		UPDATE wf_instance SET INITIAL_DATE=SYSDATE+360 WHERE INSTANCE_ID=REG.INSTANCE_ID;
		UPDATE WF_INSTANCE_ATTRIB SET VALUE=ut_date.fsbSTR_DATE(sysdate+360) WHERE INSTANCE_ID=REG.INSTANCE_ID AND ATTRIBUTE_ID=406;
		UPDATE WF_INSTANCE_ATTRIB SET VALUE='1' WHERE INSTANCE_ID=REG.INSTANCE_ID AND ATTRIBUTE_ID=442;
		commit;
		WF_BOEIFINSTANCE.RecoverInstance(REG.INSTANCE_ID);
		
		GE_BOINT_WORKFLOW.UPDATEEXECUTIONDATE(REG.INSTANCE_ID, sysdate, nuErrorCode, sbErrorMessage);

		dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
		dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);

		commit;
		EXCEPTION
			when ex.CONTROLLED_ERROR  then
				rollback;
				Errors.getError(nuErrorCode, sbErrorMessage);
				dbms_output.put_line('ERROR CONTROLLED ');
				dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
				dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

			when OTHERS then
				Errors.setError;
				Errors.getError(nuErrorCode, sbErrorMessage);
				dbms_output.put_line('ERROR OTHERS ');
				dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
				dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
				rollback;
		END;
	END LOOP;
END;
/
