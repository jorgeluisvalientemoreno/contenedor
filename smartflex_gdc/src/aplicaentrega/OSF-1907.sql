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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/damo_packages_asso.sql"
@src/gascaribe/objetos-producto/sinonimos/damo_packages_asso.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/dawf_instance.sql"
@src/gascaribe/objetos-producto/sinonimos/dawf_instance.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_bcpackages_asso.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_bcpackages_asso.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_bopackages.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_bopackages.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/wf_boinstance.sql"
@src/gascaribe/objetos-producto/sinonimos/wf_boinstance.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bcgestion_flujos.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bcgestion_flujos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_bcgestion_flujos.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bcgestion_flujos.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bogestion_flujos.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bogestion_flujos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_bogestion_flujos.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bogestion_flujos.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/prc_anulaflujo.sql"
@src/gascaribe/facturacion/procedimientos/prc_anulaflujo.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/prc_anulaflujo.sql"
@src/gascaribe/facturacion/sinonimos/prc_anulaflujo.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121753.sql"
@src/gascaribe/fwcob/ge_object_121753.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_342.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_342.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_352.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_352.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_398.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_398.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql

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