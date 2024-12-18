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

prompt "Aplicando src/gascaribe/gestion-ordenes/tablas/personalizaciones.log_direcciones_orden.sql"
@src/gascaribe/gestion-ordenes/tablas/personalizaciones.log_direcciones_orden.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.log_direcciones_orden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.log_direcciones_orden.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bccambio_direccion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bccambio_direccion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bccambio_direccion_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bccambio_direccion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_log_direcciones_orden.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_log_direcciones_orden.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_log_direcciones_orden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_log_direcciones_orden.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bocambio_direccion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bocambio_direccion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bocambio_direccion_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bocambio_direccion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/ldc_prvaldatcamborder.sql"
@src/gascaribe/gestion-ordenes/procedure/ldc_prvaldatcamborder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/tablas/ldc_logcamdirorder606.sql"
@src/gascaribe/gestion-ordenes/tablas/ldc_logcamdirorder606.sql

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