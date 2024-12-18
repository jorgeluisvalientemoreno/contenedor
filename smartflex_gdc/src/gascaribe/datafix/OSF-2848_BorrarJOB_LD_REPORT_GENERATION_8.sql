set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2848    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad DBA_JOBS
DECLARE

    nuErrorCode     NUMBER;
    sbErrorMessage  VARCHAR2(4000);
    nuCantidad      NUMBER;     
    nuCant          NUMBER;
    
 CURSOR cu_Jobs is
    SELECT JOB ID_JOB, WHAT
      FROM dba_jobs
     WHERE JOB in (794800 , 794717);
                                
BEGIN
    BEGIN
    SELECT COUNT(1) INTO nuCantidad
      FROM dba_jobs
     WHERE JOB in (794800 , 794717);

    EXCEPTION WHEN OTHERS THEN 
        nuCantidad:= 0;
    END;
      dbms_output.put_line('Encontró(>0): '||nuCantidad); 
      nuCant:= 0;
      IF nuCantidad > 0 THEN        
        dbms_output.put_line('RESULTADO:'); 
        nuCant:= 1;
        FOR reg IN cu_Jobs LOOP
            dbms_output.put_line('--> '||nuCant||'.-'||reg.ID_JOB||'|'||reg.WHAT);
            IF reg.ID_JOB > 0 THEN
                dbms_job.remove(reg.ID_JOB);
                dbms_output.put_Line('--> Job ID: '||reg.ID_JOB ||' llamado LD_REPORT_GENERATION_8 BORRADO con exito');
                dbms_output.put_Line('--------------------------------------------------');
            END IF;  
            COMMIT;
            nuCant:= nuCant+1;
        END LOOP;
      END IF;    


EXCEPTION
  WHEN OTHERS THEN
    Errors.setError;
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    ROLLBACK;
  
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
/