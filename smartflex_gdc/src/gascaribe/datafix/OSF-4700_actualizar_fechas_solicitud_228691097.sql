column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuError number;
BEGIN
  BEGIN
    update open.mo_packages d
       set d.request_date         = TO_DATE('26/06/2025 10:30:00',
                                            'DD/MM/YYYY HH24:MI:SS'),
           d.messag_delivery_date = TO_DATE('26/06/2025 10:30:00',
                                            'DD/MM/YYYY HH24:MI:SS'),
           d.expect_atten_date    = TO_DATE('26/06/2025 10:30:00',
                                            'DD/MM/YYYY HH24:MI:SS'),
           d.attention_date       = TO_DATE('26/06/2025 19:31:00',
                                            'DD/MM/YYYY HH24:MI:SS')
     where d.package_id = 228691097;
  
    commit;
    dbms_output.put_line('Se actualizan la fecha de inicio y final de la solicitud 228691097');
  EXCEPTION
  
    when OTHERS then
      Rollback;
      dbms_output.put_line('No se actualizan la fecha de inicio y final de la solicitud 228691097 - ' ||
                           sqlerrm);
  END;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/