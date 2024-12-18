DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    errors.Initialize;
	ut_trace.Init;
	ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
	ut_trace.SetLevel(0);
	ut_trace.Trace('INICIO');
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM DBA_SCHEDULER_JOBS
    WHERE JOB_NAME = 'LDC_JOBRETIROTARTRANS';
	
	IF nuconta = 0 THEN 
	
		BEGIN
		  DBMS_SCHEDULER.CREATE_JOB (
		   job_name                 =>  'LDC_JOBRETIROTARTRANS', 
		   job_type                 =>  'PLSQL_BLOCK',
		   job_action               =>  'BEGIN LDC_PKGESTIONTARITRAN.PRGENERETIAUTO; END;',
		   start_date               =>   to_date(to_char(sysdate, 'dd/mm/yyyy')||' 01:00:00', 'dd/mm/yyyy hh24:mi:ss'),
		   repeat_interval          =>  'FREQ=DAILY', 
		   auto_drop          		  =>   FALSE,
		   enabled					        =>   TRUE,
		   comments                 =>  'Job que realiza el retiro de tarifa transitoria automaticamente');

		END;

		
        dbms_output.put_Line(' Job LDC_JOBPRGAPYCAR creado con exito');
		commit;
	 else
		dbms_output.put_Line('El job ya existe -----');
     END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
		rollback;
		
    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
        rollback;
	
END;
/