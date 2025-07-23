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

prompt "Aplicando src/gascaribe/general/sinonimos/ct_boexclusionfunctions.sql"
@src/gascaribe/general/sinonimos/ct_boexclusionfunctions.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_or_related_order.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_or_related_order.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_titrdocu.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_titrdocu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_titrdocu.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_titrdocu.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bogestionexclusionordenes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestionexclusionordenes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bogestionexclusionordenes.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestionexclusionordenes.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/ct_boexclusionfunctions.excludeorderfordays.sql"
@src/gascaribe/general/homologacion_servicios/ct_boexclusionfunctions.excludeorderfordays.sql

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