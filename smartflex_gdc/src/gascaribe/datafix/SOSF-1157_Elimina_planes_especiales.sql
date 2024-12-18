column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuPlanes IS
    SELECT  *
      FROM LDC_SPECIALS_PLAN
     WHERE plan_id IN (98,99,102,104,105,107)
       AND end_date>= SYSDATE;
BEGIN

    FOR rcPlanes in cuPlanes  LOOP
        DELETE LDC_SPECIALS_PLAN WHERE specials_plan_id =  rcPlanes.specials_plan_id;
        COMMIT;
        dbms_output.put_line('Eliminando el ID ' || rcPlanes.specials_plan_id || ' del plan ' || rcPlanes.plan_id);
    
    END LOOP;


EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('ERROR Eliminando plan especial [' || sqlerrm || ']');
    ROLLBACK;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/