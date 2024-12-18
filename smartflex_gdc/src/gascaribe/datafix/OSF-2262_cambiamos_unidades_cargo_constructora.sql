column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Begin
    --
    update cargos
      set cargunid = 1
    where cargcuco = 3054444289
      and cargconc = 674
      and cargunid = 2
      and cargvalo = 92699;
    --
    commit;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termino Ok');
    --
  Exception
    when others then
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error Actualizando el cargo ' || SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/