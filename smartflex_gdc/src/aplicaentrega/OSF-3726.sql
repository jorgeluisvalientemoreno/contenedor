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


--- Inicio paquetes utilidades
prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3726_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3726_homologacion_servicios.sql
--- Fin paquetes utilidades

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldejo.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldejo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldejo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldejo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/pkg_uildejo.sql"
@src/gascaribe/gestion-ordenes/paquetes/pkg_uildejo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcob/ge_object_121793.sql"
@src/gascaribe/gestion-ordenes/fwcob/ge_object_121793.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcob/ge_object_121794.sql"
@src/gascaribe/gestion-ordenes/fwcob/ge_object_121794.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcpb/ldejo.sql"
@src/gascaribe/gestion-ordenes/fwcpb/ldejo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_uiejecutarorden.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uiejecutarorden.sql

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