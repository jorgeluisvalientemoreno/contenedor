column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO PESP-2329 CORE');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/sinonimos/open.pr_bocreationproduct.sql"
@src/gascaribe/general/sinonimos/open.pr_bocreationproduct.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_boinstancia.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_boinstancia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_boinstancia.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_boinstancia.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/funciones/adm_person.fblpackpermiteingdireccion.sql"
@src/gascaribe/general/banco-direcciones/funciones/adm_person.fblpackpermiteingdireccion.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/sinonimos/adm_person.fblpackpermiteingdireccion.sql"
@src/gascaribe/general/banco-direcciones/sinonimos/adm_person.fblpackpermiteingdireccion.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/triggers/trgbidurab_address.sql"
@src/gascaribe/general/banco-direcciones/triggers/trgbidurab_address.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/triggers/trgbidurab_premise.sql"
@src/gascaribe/general/banco-direcciones/triggers/trgbidurab_premise.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/triggers/personalizaciones.trgbidurab_address.sql"
@src/gascaribe/general/banco-direcciones/triggers/personalizaciones.trgbidurab_address.sql

prompt "Aplicando src/gascaribe/general/banco-direcciones/triggers/personalizaciones.trgbidurab_premise.sql"
@src/gascaribe/general/banco-direcciones/triggers/personalizaciones.trgbidurab_premise.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_boinstance_db.fnugetpackidinstance.sql"
@src/gascaribe/general/homologacion_servicios/mo_boinstance_db.fnugetpackidinstance.sql

prompt "Aplicando src/gascaribe/datafix/PESP-2329.sql"
@src/gascaribe/datafix/PESP-2329.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/
