column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Begin
      update open.cargos
        set cargdoso = 'PP-216519590'
      where cargcuco in (3074422416, 3075753502) 
        and cargdoso in ('PP-24006874', 'PP-25000110');
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