column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  begin
    update open.ge_Acta a 
      set a.extern_pay_date = '31/03/2024 15:15:13'
    where a.id_acta =  218496;
    --
    commit;
  end;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/