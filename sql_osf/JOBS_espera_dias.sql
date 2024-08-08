DECLARE

  nuconta        NUMBER;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN

  dbms_output.put_Line('INICIO');
  dbms_output.put_Line('-------------------------------------');

  SELECT COUNT(*)
    INTO nuconta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'LDC_WAIT_DIAS_LEG_INTERAC_RRSA';

  IF nuconta = 0 THEN
  
    Begin
      Dbms_Scheduler.Create_Job(Job_Name        => 'LDC_WAIT_DIAS_LEG_INTERAC_RRSA',
                                Job_Type        => 'PLSQL_BLOCK',
                                Job_Action      => 'Begin LDC_PKRECURSOSREPOSUBSAPE.PROCEsperanudiasRERE; End;',
                                Start_Date      => Systimestamp,
                                Repeat_Interval => 'freq=daily; byhour=23; byminute=55; bysecond=0;',
                                End_Date        => Null,
                                Comments        => 'Espera el numero de días en que se debe realizar el descargue de valor en reclamos SUBSIDIO DE APELACION',
                                Enabled         => True,
                                Auto_Drop       => False);
    End;
  
    dbms_output.put_Line(' Job LDC_WAIT_DIAS_LEG_INTERAC_RRSA creado con exito');
    commit;
  else
  
    dbms_output.put_Line('Creacion del JOB LDC_WAIT_DIAS_LEG_INTERAC_RRSA');
    BEGIN
      DBMS_SCHEDULER.DROP_JOB(job_name => 'LDC_WAIT_DIAS_LEG_INTERAC_RRSA');
    END;
  
    Begin
      Dbms_Scheduler.Create_Job(Job_Name        => 'LDC_WAIT_DIAS_LEG_INTERAC_RRSA',
                                Job_Type        => 'PLSQL_BLOCK',
                                Job_Action      => 'Begin LDC_PKRECURSOSREPOSUBSAPE.PROCEsperanudiasRERE; End;',
                                Start_Date      => Systimestamp,
                                Repeat_Interval => 'freq=daily; byhour=23; byminute=55; bysecond=0;',
                                End_Date        => Null,
                                Comments        => 'Espera el numero de días en que se debe realizar el descargue de valor en reclamos SUBSIDIO DE APELACION',
                                Enabled         => True,
                                Auto_Drop       => False);
    End;
  
    dbms_output.put_Line(' Job LDC_WAIT_DIAS_LEG_INTERAC_RRSA creado con exito');
    commit;
  
  END IF;
  dbms_output.put_Line('-------------------------------------');
  dbms_output.put_Line('FIN');

EXCEPTION
  when ex.CONTROLLED_ERROR then
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR CONTROLLED ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    rollback;
  
  when OTHERS then
    Errors.setError;
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    rollback;
  
END;
/
