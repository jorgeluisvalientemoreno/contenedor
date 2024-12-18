set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Abril 2024 
    JIRA:           OSF-2597    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad LDC_PROCEDIMIENTO_OBJ 
DECLARE

nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
    FROM LDC_PROCEDIMIENTO_OBJ
   WHERE PROCEDIMIENTO = 'LDC_PROGORDTOUNLOCKTRABVAR';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DELETE FROM LDC_PROCEDIMIENTO_OBJ WHERE PROCEDIMIENTO=''LDC_PROGORDTOUNLOCKTRABVAR'''; 
    IF SQL%FOUND THEN
    dbms_output.put_line('Registros borrados del procedure LDC_PROGORDTOUNLOCKTRABVAR: '||SQL%ROWCOUNT); 
    END IF;
    
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar registros del procedure LDC_PROGORDTOUNLOCKTRABVAR en entidad ldc_procedimiento_obj, '||sqlerrm); 
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
/