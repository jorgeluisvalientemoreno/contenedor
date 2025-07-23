column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare
  vsberror VARCHAR2(30);
Begin
  
    update cargos
       set cargunid = 8
     where cargcuco = 3080114079
       and cargconc = 19
       and cargvalo = 5625224
       and cargunid = 0;
    --
    update cargos
       set cargunid = 150
     where cargcuco = 3080114079
       and cargconc = 30
       and cargvalo = 54000000
       and cargunid = 0;
    --
    update cargos
       set cargunid = 111
     where cargcuco = 3080114079
       and cargconc = 674
       and cargvalo = 10906971
       and cargunid = 0;
    --
    commit;
    --
Exception
  When others then
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error : '  || SQLERRM);
End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/