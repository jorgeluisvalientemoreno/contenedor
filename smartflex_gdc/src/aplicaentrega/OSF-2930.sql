column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/mo_package_payment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/mo_package_payment.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/mo_motive_payment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/mo_motive_payment.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/ldc_tipvaldup.sql"
@src/gascaribe/atencion-usuarios/sinonimos/ldc_tipvaldup.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/cc_borequestrating.sql"
@src/gascaribe/atencion-usuarios/sinonimos/cc_borequestrating.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/tablas/duplicado_factura.sql"
@src/gascaribe/atencion-usuarios/tablas/duplicado_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_duplicado_factura.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_duplicado_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_duplicado_factura.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_duplicado_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/ldci_pkfactkiosco_gdc.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldci_pkfactkiosco_gdc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaild_cupon_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaild_cupon_causal.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/adm_person.prc_financia_duplicado.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.prc_financia_duplicado.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.prc_financia_duplicado.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.prc_financia_duplicado.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/dbms_jobs/521517.sql"
@src/gascaribe/papelera-reciclaje/dbms_jobs/521517.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/job/job_financia_duplicado.sql"
@src/gascaribe/atencion-usuarios/job/job_financia_duplicado.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/