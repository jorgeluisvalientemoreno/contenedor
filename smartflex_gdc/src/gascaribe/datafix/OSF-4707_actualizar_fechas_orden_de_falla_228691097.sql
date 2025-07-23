column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  Orden NUMBER := 368499665;
  Falla NUMBER := 228691097;

begin

  update open.or_order oo
     set oo.created_date         = to_date('26/06/2025 10:16:01',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.assigned_date        = to_date('26/06/2025 10:18:01',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.exec_estimate_date   = to_date('26/06/2025 10:18:01',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.arranged_hour        = to_date('26/06/2025 10:17:55',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.exec_initial_date    = to_date('26/06/2025 10:23:01',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.execution_final_date = to_date('26/06/2025 16:16:01',
                                           'DD/MM/YYYY HH24:MI:SS'),
         oo.max_date_to_legalize = to_date('26/06/2025 22:16:01',
                                           'DD/MM/YYYY HH24:MI:SS')
   where oo.order_id = Orden;

  update open.Or_Order_Activity ooa
     set ooa.register_date      = to_date('26/06/2025 10:16:01',
                                          'DD/MM/YYYY HH24:MI:SS'),
         ooa.exec_estimate_date = to_date('26/06/2025 10:18:01',
                                          'DD/MM/YYYY HH24:MI:SS')
   where ooa.order_id = Orden;

  update OPEN.PR_TIMEOUT_COMPONENT a
     set a.final_date   = TO_DATE('26/06/2025 19:31:00',
                                  'DD/MM/YYYY HH24:MI:SS'),
         a.initial_date = TO_DATE('26/06/2025 10:30:00',
                                  'DD/MM/YYYY HH24:MI:SS')
   where a.package_id = Falla;

  commit;
  dbms_output.put_line('Se acutalizaron las fechas de componente y orden de fallo 343592561');
exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/