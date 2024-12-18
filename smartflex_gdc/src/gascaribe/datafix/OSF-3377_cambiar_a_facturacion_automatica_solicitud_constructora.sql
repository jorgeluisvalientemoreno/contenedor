column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare

  begin

  delete open.mo_comment m
  where m.package_id = 181882394
    and m.comment_ = 'IGNORAR CARGOS AVANCE OBRA';
    
  DBMS_OUTPUT.PUT_LINE('Se borro satisfactoriamente el comentario de la solicitud ' || SQLERRM);
    
  commit;

  exception
    when others then
      DBMS_OUTPUT.PUT_LINE('Error borrando el comentario de la solicitud ' || SQLERRM);
  end;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/