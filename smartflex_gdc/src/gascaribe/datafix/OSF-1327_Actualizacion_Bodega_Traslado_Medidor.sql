column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    INSERT INTO ldc_inv_ouib VALUES (10002106,3551, 0, 0,  0,  0, 0,  0 );
    INSERT INTO ldc_inv_ouib VALUES (10004070,3551, 0, 0,  0,  0, 0,  0 );
    INSERT INTO ldc_inv_ouib VALUES (10004070,3557, 0, 0,  0,  0, 0,  0 );
    INSERT INTO ldc_inv_ouib VALUES (10004070,3592, 0, 0,  0,  0, 0,  0 );

    commit; 
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/