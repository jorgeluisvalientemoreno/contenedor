set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    UPDATE cargos
       SET cargdoso = 'N_-'||cargdoso
     WHERE cargcuco IN (3033375541,3033375522);
    COMMIT;
 Exception
   When others then
     Rollback;
     dbms_output.put_line(sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/