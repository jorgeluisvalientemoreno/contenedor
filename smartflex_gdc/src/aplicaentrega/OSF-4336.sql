column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4336"
prompt "-----------------"

prompt "-----PAQUETES-----" 

prompt "Creacion paquete pkg_cc_grace_period"
@src/gascaribe/revision-periodica/paquetes/adm_person.pkg_cc_grace_period.sql
@src/gascaribe/revision-periodica/sinonimos/adm_person.pkg_cc_grace_period.sql

prompt "Creacion paquete pkg_ge_unit_cost_ite_lis"
@src/gascaribe/revision-periodica/paquetes/adm_person.pkg_ge_unit_cost_ite_lis.sql
@src/gascaribe/revision-periodica/sinonimos/adm_person.pkg_ge_unit_cost_ite_lis.sql

prompt "Creacion paquete pkg_ldc_finan_cond"
@src/gascaribe/revision-periodica/paquetes/adm_person.pkg_ldc_finan_cond.sql
@src/gascaribe/revision-periodica/sinonimos/adm_person.pkg_ldc_finan_cond.sql

prompt "Actualizacion paquete pkg_bcordenes"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql

prompt "Actualizacion paquete pkg_or_order_items"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql

prompt "Actualizacion paquete pkg_bofinanciacion"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql

prompt "Actualizacion paquete pkg_bogestion_financiacion"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Actualizacion paquete pkg_ldc_plazos_cert"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_plazos_cert.sql

prompt "Actualizacion paquete OSF-4336_ins_homologacion_servicios"
@src/gascaribe/datafix/OSF-4336_ins_homologacion_servicios.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4336-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on