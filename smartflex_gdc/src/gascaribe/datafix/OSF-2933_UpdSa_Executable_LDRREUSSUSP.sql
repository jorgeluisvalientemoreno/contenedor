set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    dbms_output.put_line('Actualizar ejecutable LDRREUSSUSP - Reporte de usuarios a suspender prp');
    UPDATE sa_executable
       SET DESCRIPTION = 'NO USAR - Reporte de usuarios a suspender prp'
     WHERE NAME = 'LDRREUSSUSP'; 
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar ejecutable LDRREUSSUSP - Reporte de usuarios a suspender prp');
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
 
/