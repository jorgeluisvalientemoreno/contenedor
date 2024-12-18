column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuCommentType   number;
  isbOrderComme   varchar2(4000);
  nuErrorCode     number;
  sbErrorMesse    varchar2(4000);


begin
  dbms_output.put_line('---- Inicio OSF-835 ----');

  delete  OPEN.CT_ORDER_CERTIFICA a
  where   a.CERTIFICATE_ID = 163592
  and     a.order_id = 227533173;
  
  COMMIT;

  dbms_output.put_line('---- Fin OSF-835 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-835 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/