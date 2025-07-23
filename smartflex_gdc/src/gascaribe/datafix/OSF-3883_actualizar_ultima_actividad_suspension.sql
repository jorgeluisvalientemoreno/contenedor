column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

    csbCaso         constant varchar2(20)   := 'OSF-3883';

BEGIN

    update pr_product
    set suspen_ord_act_id = 294612093
    where product_id = 51688245; 

    commit;
    dbms_output.put_line('Se actualiza en el producto 51688245 la ultima actividad de suspension con el codigo 294612093');
    
exception 
    when others then
        rollback; 
        dbms_output.put_line('No se pudo actualizar en el producto 51688245 la ultima actividad de suspension con el codigo 294612093 - Error: ' || sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/