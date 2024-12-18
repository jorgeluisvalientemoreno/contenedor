column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
    dbms_output.put_line('Inicia Actualización Datafix OSF-2807!');
    delete cargos where cargnuse = 52771040 and cargcuco = -1;
    commit;
    dbms_output.put_line('Fin Actualización Datafix OSF-2807!');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/