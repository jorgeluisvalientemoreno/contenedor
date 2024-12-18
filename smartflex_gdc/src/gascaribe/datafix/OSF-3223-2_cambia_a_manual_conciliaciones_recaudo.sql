column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
declare

begin
  
  update open.concilia c
     set c.concciau = 'N',
         c.concfunc = 4833
   where c.conccons in (264772);
  --
  Commit;
  --
Exception
  when others then
      ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error Update : ' || SQLERRM);
End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/