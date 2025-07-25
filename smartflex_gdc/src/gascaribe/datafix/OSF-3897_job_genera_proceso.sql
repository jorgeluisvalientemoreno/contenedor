column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuJob NUMBER;
BEGIN
 DBMS_JOB.SUBMIT(nuJob,
        'BEGIN prc_llenainformacion_produsubs; END;',
    SYSDATE);
 COMMIT;
 DBMS_OUTPUT.PUT_LINE(' nuJob '||nuJob);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/