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

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bctramiteanulacion.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bctramiteanulacion.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bctramiteanulacion.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bctramiteanulacion.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_data_change.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_data_change.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcgestion_solicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcgestion_solicitudes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bcgestion_solicitudes.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bcgestion_solicitudes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bccomponentes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bccomponentes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bccomponentes.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bccomponentes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcgestion_producto.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcgestion_producto.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bcgestion_producto.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bcgestion_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_botramiteanulacion.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_botramiteanulacion.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_botramiteanulacion.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_botramiteanulacion.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/procedimientos/prcreversaestadoproducto.sql"
@src/gascaribe/servicios-nuevos/procedimientos/prcreversaestadoproducto.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121760.sql"
@src/gascaribe/fwcob/ge_object_121760.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100248.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100248.sql

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