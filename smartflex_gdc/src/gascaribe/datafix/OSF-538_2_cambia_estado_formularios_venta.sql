column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
declare
begin
  -- Formulario solicitud 27291492
  update open.FA_HISTCODI l 
     set l.hicdesta = 'P'
   where l.hicdnume = 02438
     and l.hicdcons = 170507505;
  -- Formulario solicitud 27291280
  update open.FA_HISTCODI
     set HICDESTA = 'P'
   where HICDNUME = 2437
     and hicdcons = 170504265;
  --
  commit;
  --
Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error : ' || SQLERRM);
  End;  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/