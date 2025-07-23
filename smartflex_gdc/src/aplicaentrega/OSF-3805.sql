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

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_related_order.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_related_order.sql

prompt "Aplicando src/gascaribe/Permisos/adm_person.or_bcorderactivities.sql"
@src/gascaribe/Permisos/adm_person.or_bcorderactivities.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcgestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcgestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3805_insertar_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3805_insertar_homologacion_servicios.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql


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

