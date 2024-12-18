column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    UPDATE PR_PROMOTION 
    SET INITIAL_DATE =  TO_DATE('12/04/2024', 'DD/MM/YYYY'),
        FINAL_DATE =  TO_DATE('06/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE PROMOTION_ID = 423399;

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/