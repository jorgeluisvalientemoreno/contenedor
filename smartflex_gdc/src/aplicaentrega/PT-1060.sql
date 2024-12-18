column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INN SN');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------"

prompt "Aplicando src/gascaribe/portal-clientes/procedimientos/trunc_ldc_stage_pw_fact_dig.sql"
@src/gascaribe/portal-clientes/procedimientos/trunc_ldc_stage_pw_fact_dig.sql

prompt "Aplicando src/gascaribe/portal-clientes/tablas/ldc_stage_portalweb_factura_digital.sql"
@src/gascaribe/portal-clientes/tablas/ldc_stage_portalweb_factura_digital.sql

prompt "Aplicando src/gascaribe/portal-clientes/permisos/factura_digital_sync.sql"
@src/gascaribe/portal-clientes/permisos/factura_digital_sync.sql

prompt "------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/