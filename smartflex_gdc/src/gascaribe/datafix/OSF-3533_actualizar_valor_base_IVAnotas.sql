set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
BEGIN
 UPDATE cargos 
    SET cargvabl = 14600 
 WHERE cargcodo = 157248038 AND cargconc = 1021 AND cargcaca = 1;
 COMMIT;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/