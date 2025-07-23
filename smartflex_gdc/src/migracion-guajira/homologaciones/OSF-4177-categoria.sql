column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  insert into homologacion.homocate
with base as
(select 1 gasplus, 1 osf from dual union all
 select 2 gasplus, 2 osf from dual union all
 select 4 gasplus, 3 osf from dual union all
 select 5 gasplus, 6 osf from dual union all
 select 6 gasplus, 14 osf from dual
)
select * from base where not exists(select null from homologacion.homocate h where h.catecodi=gasplus and h.catehomo=osf);
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/