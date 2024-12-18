column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
    dbms_output.put_line('Inicia OSF-3513 !');

    UPDATE servsusc
    SET    sesuesco = 95,
           sesufere = sysdate
    WHERE  sesunuse = 52910875;

    UPDATE pr_product
    SET    product_status_id = 3,
            retire_date = sysdate
    WHERE  product_id = 52910875;

    commit;
    dbms_output.put_line('Fin OSF-3513 !');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/