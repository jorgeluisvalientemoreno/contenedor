set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Julio 2024 
    JIRA:           OSF-2933    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad GE_RECORD_PROCESS y GE_CONTROL_PROCESS 
DECLARE

nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
    FROM GE_RECORD_PROCESS grp 
   WHERE grp.CONTROL_PROCESS_ID in (SELECT gcp.CONTROL_PROCESS_ID 
                                      FROM GE_CONTROL_PROCESS gcp  
                                     WHERE gcp.OBJECT_ID =121295);
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DELETE FROM GE_RECORD_PROCESS grp 
                             WHERE grp.CONTROL_PROCESS_ID in (SELECT gcp.CONTROL_PROCESS_ID 
                                                                FROM GE_CONTROL_PROCESS gcp  
                                                               WHERE gcp.OBJECT_ID =121295)'; 
    IF SQL%FOUND THEN
    dbms_output.put_line('Registros borrados en GE_RECORD_PROCESS: '||SQL%ROWCOUNT); 
    END IF;
  ELSE
    dbms_output.put_line('No existe o ya fue borrado'); 
  END IF;
--
  SELECT COUNT(*) INTO nuConta
    FROM GE_CONTROL_PROCESS 
   WHERE OBJECT_ID = 121295 ;
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DELETE FROM GE_CONTROL_PROCESS WHERE OBJECT_ID = 121295 '; 
    IF SQL%FOUND THEN
    dbms_output.put_line('Registros borrados en GE_CONTROL_PROCESS: '||SQL%ROWCOUNT); 
    END IF;
  ELSE
    dbms_output.put_line('No existe o ya fue borrado'); 
  END IF;
  COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar registros del procedure LDC_PROCCREASOLICITUDSUSPADMIN en entidad GE_RECORD_PROCESS/GE_CONTROL_PROCESS, '||sqlerrm); 
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN **** 
PROMPT =========================================

set timing off
set serveroutput off
/