column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

  Begin

      update open.ge_Acta a 
        set  a.extern_pay_date = sysdate - 3
      where a.id_acta in (239426,235851);
      --
      commit;
      --
      dbms_output.put_line('Actas actualizadas corectamente');

  Exception when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/