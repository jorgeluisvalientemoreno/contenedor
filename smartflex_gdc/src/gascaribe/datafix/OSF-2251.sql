column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update ge_contrato
     set fecha_inicial=to_Date('01/01/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
    where id_contrato=6901;
    commit;
    dbms_output.put_line('Contrato actualizado exitosamente');
exception
  when others then
     rollback;
     dbms_output.put_line('Error: '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/