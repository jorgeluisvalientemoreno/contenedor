set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX 2675');
    
PROMPT **** Inicia borrado en entidad GE_REPORT_STATEMENT, GE_STATEMENT_COLUMNS y GE_STATEMENT 
PROMPT Borrar Registros del STATEMENT_ID=120038236 
DECLARE

nuConta NUMBER;
 
BEGIN
    SELECT COUNT(*) INTO nuConta
      FROM GE_REPORT_STATEMENT
     WHERE STATEMENT_ID = 120038236;
    
    IF nuConta > 0 THEN
        EXECUTE IMMEDIATE 'DELETE FROM GE_REPORT_STATEMENT WHERE STATEMENT_ID=120038236'; 
        IF SQL%FOUND THEN
        dbms_output.put_line('#Registros borrados en GE_REPORT_STATEMENT: '||SQL%ROWCOUNT); 
        END IF;
    ELSE
        dbms_output.put_line('Registro en GE_REPORT_STATEMENT No existe o ya fue borrado'); 
    END IF;
--
    SELECT COUNT(*) INTO nuConta
      FROM GE_STATEMENT_COLUMNS
     WHERE STATEMENT_ID = 120038236;
    
    IF nuConta > 0 THEN
        EXECUTE IMMEDIATE 'DELETE FROM GE_STATEMENT_COLUMNS WHERE STATEMENT_ID=120038236'; 
        IF SQL%FOUND THEN
        dbms_output.put_line('#Registros borrados en GE_STATEMENT_COLUMNS: '||SQL%ROWCOUNT); 
        END IF;
    ELSE
        dbms_output.put_line('Registro en GE_STATEMENT_COLUMNS No existe o ya fue borrado'); 
    END IF;
--
  SELECT COUNT(*) INTO nuConta
    FROM GE_STATEMENT
   WHERE STATEMENT_ID = 120038236;
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DELETE FROM GE_STATEMENT WHERE STATEMENT_ID=120038236'; 
    IF SQL%FOUND THEN
    dbms_output.put_line('#Registros borrados en GE_STATEMENT: '||SQL%ROWCOUNT); 
    END IF;
  ELSE
    dbms_output.put_line('Registro en GE_STATEMENT No existe o ya fue borrado'); 
  END IF;

EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar registros del Reporte de subsidio y contribucion a cierre en entidad GE_STATEMENT, '||sqlerrm); 
END;   
 
/

PROMPT **** Termina borrado en entidad GE_REPORT_STATEMENT, GE_STATEMENT_COLUMNS y GE_STATEMENT **** 
PROMPT =========================================

set timing off
set serveroutput off
/