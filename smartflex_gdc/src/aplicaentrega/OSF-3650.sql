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
prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sinonimos/ldc_contabdi.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/ldc_contabdi.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/paquetes/personalizaciones.pkg_bcldcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/personalizaciones.pkg_bcldcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sinonimos/personalizaciones.pkg_bcldcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/personalizaciones.pkg_bcldcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/paquetes/personalizaciones.pkg_boldcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/personalizaciones.pkg_boldcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sinonimos/personalizaciones.pkg_boldcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/personalizaciones.pkg_boldcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/paquetes/pkg_uildcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/pkg_uildcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sinonimos/pkg_uildcgpad.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/pkg_uildcgpad.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/procedimientos/LDCGPAD.sql"
@src/gascaribe/facturacion/plan_piloto/procedimientos/LDCGPAD.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/framework/fwcpb/LDCGPAD.sql"
@src/gascaribe/facturacion/plan_piloto/framework/fwcpb/LDCGPAD.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/paquetes/adm_person.ldc_pkgestionabondecons.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/adm_person.ldc_pkgestionabondecons.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3650_Configuracion_Procesos.sql"
@src/gascaribe/datafix/OSF-3650_Configuracion_Procesos.sql

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