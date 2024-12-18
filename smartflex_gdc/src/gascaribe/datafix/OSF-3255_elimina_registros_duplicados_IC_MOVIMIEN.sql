column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare
  begin
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 20
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 147
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 200
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 204
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 288
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 716
    and rownum = 1;
  delete open.ic_movimien m
  where movifeco = '03-09-2024'
    and movitido = 71 
    and movitihe = 'CE' 
    and movisusc = 48206202
    and moviconc = 781
    and rownum = 1;
  --
  commit;

  exception
    when others then
      ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error borrando : ' || SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/