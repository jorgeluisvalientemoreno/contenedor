column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuTransito
    IS
    SELECT * 
    FROM OR_OPE_UNI_ITEM_BALA 
    WHERE operating_unit_id in (3551, 3557) 
    AND items_id = 10002011;
BEGIN
    FOR rcTransito in cuTransito LOOP
        dbms_output.put_line ('Actualizando Bodega ['|| rcTransito.operating_unit_id ||']');
        dbms_output.put_line ('Catidad de Items ['|| rcTransito.transit_in ||']');
        
        INSERT INTO ldc_inv_ouib
        VALUES (
            rcTransito.items_id,
            rcTransito.operating_unit_id,
            0,
            0,
            0, 
            0,
            0,
            0
          );
          dbms_output.put_line ('Termina Actualizando Bodega ['|| rcTransito.operating_unit_id ||']');
    END  LOOP;
    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/