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

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bocalendario.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bocalendario.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bocalendario.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bocalendario.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3801_Ins_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3801_Ins_homologacion_servicios.sql

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