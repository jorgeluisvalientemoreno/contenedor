set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    dbms_output.put_line('Actualizar ejecutable OBJECT_PROCESS_500000000012281 - Ejecutable del objeto de proceso de reporte LDC_PROCCREASOLICITUDNOTIFI');
    UPDATE sa_executable
       SET DESCRIPTION = 'NO USAR - Ejecutable del objeto de proceso de reporte LDC_PROCCREASOLICITUDNOTIFI'
     WHERE NAME = 'OBJECT_PROCESS_500000000012281'; 
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar ejecutable OBJECT_PROCESS_500000000012281 - Ejecutable del objeto de proceso de reporte LDC_PROCCREASOLICITUDNOTIFI');
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
 
/