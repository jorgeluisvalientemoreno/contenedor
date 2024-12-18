column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  
  isbOrderComme varchar2(4000) := 'Se desvincula de la orden 249216019 la solicitud 187451542 por caso OSF-702';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
begin

  OS_ADDORDERCOMMENT(249216019,
                      nuCommentType,
                      isbOrderComme,
                      nuErrorCode,
                      sbErrorMesse);
  if nuErrorCode = 0 then
    commit;
    dbms_output.put_line('Se agrego comentario OK orden: 249216019');
  else
    rollback;
    dbms_output.put_line('Error agrego comentario OK orden: 249216019' ||
                          ' : ' || sbErrorMesse);
  end IF;

exception
  when no_data_found then
    dbms_output.put_line('Error agrego comentario OK orden: 249216019');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/