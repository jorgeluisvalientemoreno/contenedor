set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
    UPDATE servsusc SET sesuesco = 1 WHERE sesunuse = 52357485;
    UPDATE pr_product SET product_status_id = 1 WHERE product_id = 52357485;
    COMMIT;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/