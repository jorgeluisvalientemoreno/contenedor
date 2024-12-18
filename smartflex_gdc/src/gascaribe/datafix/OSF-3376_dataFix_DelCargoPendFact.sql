column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    orId    ROWID;
begin
    
    delete cargos 
    where cargnuse = 52875728 and 
    cargcuco = -1 and 
    cargconc = 19 and 
    cargdoso = 'PP-MEMO24-005370'
    RETURNING ROWID into orId;

    IF orId IS NOT NULL THEN
        COMMIT;        
        dbms_output.put_line('Ok Borrado cargo[' || 'cargnuse = 52875728, cargcuco = -1,cargconc = 19 and  cargdoso = PP-MEMO24-005370' || ']');
    ELSE
        dbms_output.put_line('No existe el cargo[' || 'cargnuse = 52875728, cargcuco = -1,cargconc = 19 and  cargdoso = PP-MEMO24-005370' || ']');
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error[' || sqlerrm || ']');
            ROLLBACK;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/