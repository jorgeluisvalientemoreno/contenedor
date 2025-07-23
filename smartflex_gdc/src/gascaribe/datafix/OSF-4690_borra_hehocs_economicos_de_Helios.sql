column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare

  begin

  delete open.ic_movimien where movifeco = '04-07-2025' and movitido = 71 and movitihe = 'CE';
  Commit;
  --
  delete open.ic_docugene where dogetido = 71 and dogefege >= '04-07-2025';
  commit;

  Exception
      when others then
          ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/