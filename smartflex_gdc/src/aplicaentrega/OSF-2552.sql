column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/or_boservices.sql"
@src/gascaribe/gestion-ordenes/paquetes/or_boservices.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcor_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcor_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcor_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcor_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/personalizaciones.oal_validatransitoentrantebod.sql"
@src/gascaribe/gestion-ordenes/procedure/personalizaciones.oal_validatransitoentrantebod.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.oal_validatransitoentrantebod.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.oal_validatransitoentrantebod.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/personalizaciones.prcvalidatransitoentantebod.sql"
@src/gascaribe/gestion-ordenes/procedure/personalizaciones.prcvalidatransitoentantebod.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.prcvalidatransitoentantebod.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.prcvalidatransitoentantebod.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2552_objeto_accion_oal_ValidaTransitoEntranteBod.sql"
@src/gascaribe/datafix/OSF-2552_objeto_accion_oal_ValidaTransitoEntranteBod.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2552_plugin_prcValidaTransitoEntanteBod.sql"
@src/gascaribe/datafix/OSF-2552_plugin_prcValidaTransitoEntanteBod.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daor_ope_uni_item_bala.fnugettransit_in_total.sql"
@src/gascaribe/general/homologacion_servicios/daor_ope_uni_item_bala.fnugettransit_in_total.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daor_ope_uni_item_bala.fnugettransit_out_total.sql"
@src/gascaribe/general/homologacion_servicios/daor_ope_uni_item_bala.fnugettransit_out_total.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/