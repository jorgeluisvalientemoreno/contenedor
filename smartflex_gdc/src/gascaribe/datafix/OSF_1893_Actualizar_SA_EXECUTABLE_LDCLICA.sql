column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    dbms_output.put_line('Actualizar ejecutable de funcionalidad LDCLICA - Liquidación de Contratos administrativos');
    UPDATE sa_executable
       SET DESCRIPTION = 'NO USAR - Liquidación de Contratos administrativos'
     WHERE NAME = 'LDCLICA'; 
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar ejecutable de funcionalidad LDCLICA - Liquidación de Contratos administrativos');
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
 
/
 