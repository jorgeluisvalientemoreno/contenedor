column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
alter session set ddl_lock_timeout = 600;


prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/ventas/sinonimos/ge_subs_housing_data.sql"
@src/gascaribe/ventas/sinonimos/ge_subs_housing_data.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ge_subs_phone.sql"
@src/gascaribe/ventas/sinonimos/ge_subs_phone.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ge_subs_work_relat.sql"
@src/gascaribe/ventas/sinonimos/ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ldc_daadventa.sql"
@src/gascaribe/ventas/sinonimos/ldc_daadventa.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ldc_energetico_ant.sql"
@src/gascaribe/ventas/sinonimos/ldc_energetico_ant.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/mo_gas_sale_data.sql"
@src/gascaribe/ventas/sinonimos/mo_gas_sale_data.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/mo_mot_promotion.sql"
@src/gascaribe/ventas/sinonimos/mo_mot_promotion.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_271.sql"
@src/gascaribe/tramites/ps_package_type_271.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/personalizaciones.pkg_xml_soli_venta.sql"
@src/gascaribe/ventas/paquetes/personalizaciones.pkg_xml_soli_venta.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/