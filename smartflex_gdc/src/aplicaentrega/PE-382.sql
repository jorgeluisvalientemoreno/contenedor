column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INN SN');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega PE-382"
prompt "------------------------------------------------------"

prompt "Aplicando Grant or_bolegalizeorder"
GRANT EXECUTE ON or_bolegalizeorder TO personalizaciones;
/
prompt "Aplicando Sinonimos para open.ge_boerrors"
create or replace synonym personalizaciones.ge_boerrors for open.ge_boerrors;
/

prompt "Aplicando src/gascaribe/servicios-asociados/plugin/ldc_pluglegalizarreforma.sql"
@src/gascaribe/servicios-asociados/plugin/ldc_pluglegalizarreforma.sql

prompt "Aplicando src/gascaribe/servicios-asociados/plugin/insert_conf_plugin_legreforma.sql"
@src/gascaribe/servicios-asociados/plugin/insert_conf_plugin_legreforma.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega PE-382"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/