column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    nuError    NUMBER;
    sbError    VARCHAR2(4000);
    nuEstadoInventario  ge_items_seriado.id_items_estado_inv%TYPE := 17;


    CURSOR cuItemsSeriado
    IS
    SELECT  *
    FROM    ge_items_seriado
    WHERE   serie = 'K-3308274-16';

BEGIN
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Inicia Baja de item');

    
    FOR rcItems IN cuItemsSeriado LOOP 

        dbms_output.put_line('Inicia cambio de estado Items seriado ['||rcItems.id_items_seriado||']');
        UPDATE  ge_items_seriado
        SET     id_items_estado_inv = nuEstadoInventario
        WHERE  id_items_seriado = rcItems.id_items_seriado;
        dbms_output.put_line('Fin cambio de estado Items seriado ['||rcItems.id_items_seriado||']');
    END LOOP;

    COMMIT;
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Baja de item '||nuerror||'-'||sberror||']');

        rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/