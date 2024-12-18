column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	cursor cuPoblacion
    is
    select  *
    from    open.ldc_procedimiento_obj
    where   task_type_id = 10944
    and     causal_id = 3755;

BEGIN
    dbms_output.put_line('Inicia Actualizacion de datos OSF-950');

    DELETE OPEN.LDC_PROCEDIMIENTO_OBJ O 
    WHERE UPPER(O.PROCEDIMIENTO ) LIKE '%LDCPLAUPTCOMENORDE%'
      AND ACTIVO='S';
        

    COMMIT;
    dbms_output.put_line('Finaliza Actualizacion de datos OSF-950');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('OSF-950 ERROR General: |'|| sqlerrm);
        ROLLBACK; 
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/