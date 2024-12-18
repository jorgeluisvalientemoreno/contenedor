column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE 
    CURSOR cuLofActividad
    IS
    SELECT  a.*
    FROM    Mo_Activity_Log a
    WHERE   a.activity_log_id in (170938,170937);
BEGIN
    dbms_output.put_line('Inicio datafix OSF-2361');

    FOR rcLogActividad in cuLofActividad LOOP
        dbms_output.put_line('Inicio Actualiza Administrativo proceso ['||rcLogActividad.Admin_Activity_Id||']');
        UPDATE  mo_Activity_Log
        SET     receiver_person_id = 13644,
                receiver_area_id =  2011
        WHERE   activity_log_id = rcLogActividad.activity_log_id;
        dbms_output.put_line('Fin Actualiza Administrativo proceso ['||rcLogActividad.Admin_Activity_Id||']');
    END LOOP;
    COMMIT;

    dbms_output.put_line('Fin datafix OSF-2361');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/