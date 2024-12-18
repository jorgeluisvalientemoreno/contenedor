column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    sberror     varchar2(2000);
    nuerror     number;
BEGIN
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Inicia Actualizacion de inventario');
    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA disable';

    UPDATE  or_uni_item_Bala_mov 
    SET     total_value = 461
    WHERE   uni_item_bala_mov_id = 6275617;
    
    COMMIT;
    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
    dbms_output.put_line('Fin Actualizacion de inventario ');
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Actualizacion de inventario '||nuerror||'-'||sberror||']');
        EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
        rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/