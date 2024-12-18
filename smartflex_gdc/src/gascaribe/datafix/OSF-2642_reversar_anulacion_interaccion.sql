column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  i number;

begin

  update OPEN.mo_motive
     set attention_date     = null,
         annul_date         = null,
         status_change_date = null,
         annul_causal_id    = null,
         motive_status_id   = 1,
         causal_id          = null
   WHERE package_id = 212333378;

  update OPEN.mo_packages mp
     set mp.motive_status_id = 13, mp.attention_date = null
   WHERE mp.package_id = 212333378;

  update OPEN.WF_INSTANCE a
     set a.status_id = 1, a.previous_status_id = null, final_date = null
   where a.instance_id = -1743595023
     and a.plan_id = -1743595023
     and a.status_id = 14;

  update OPEN.WF_INSTANCE a
     set a.status_id = 5, a.previous_status_id = 1, final_date = null
   where a.instance_id = -1743595020
     and a.plan_id = -1743595023
     and a.status_id = 14;

  commit;
  dbms_output.put_line('Reversion anluacion de interaccion.');

exception
  when others then
    dbms_output.put_line('Error: ' || sqlerrm);
    rollback;
  
end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/