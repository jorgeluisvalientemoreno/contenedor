set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Mayo 2024 
    JIRA:           OSF-2668    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad LDC_PROCEDIMIENTO_OBJ 
DECLARE

nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
    FROM LDC_PROCEDIMIENTO_OBJ
   WHERE PROCEDIMIENTO = 'LDC_PRREVCONSCRIT';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DELETE FROM LDC_PROCEDIMIENTO_OBJ WHERE PROCEDIMIENTO=''LDC_PRREVCONSCRIT'''; 
    IF SQL%FOUND THEN
    dbms_output.put_line('Registros borrados del procedure LDC_PRREVCONSCRIT: '||SQL%ROWCOUNT); 
    END IF;
  ELSE
    dbms_output.put_line('No existe o ya fue borrado'); 
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar registros del procedure LDC_PRREVCONSCRIT en entidad ldc_procedimiento_obj, '||sqlerrm); 
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN **** 
PROMPT =========================================

set timing off
set serveroutput off
/