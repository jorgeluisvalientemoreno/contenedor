column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
    dbms_output.put_line('Inicia Ejecución caso OSF-2949');
    UPDATE open.ld_parameter SET value_chain = 'I' WHERE parameter_id = 'ACT_O_INS_CARTERA_LINEA'; 
    COMMIT;
    dbms_output.put_line('Fin Ejecución caso OSF-2949');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/