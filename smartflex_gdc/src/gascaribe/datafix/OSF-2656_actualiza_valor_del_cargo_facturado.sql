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
      set cargvalo = 4449552
    where cargcuco = 3060352794
      and cargdoso = 'PP-194066594'
      and cargnuse = 52538094
      and cargconc = 674 
      and cargvalo = 8899104
      and trunc(cargfecr) = '29-04-2024';
    --
    commit;
    --

  Exception
    when others then
          ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error actualizando el cargo : ' || SQLERRM);    
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/