column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-1813');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-1813"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/fa_boaccountstatustodate.sql"
@src/gascaribe/objetos-producto/sinonimos/fa_boaccountstatustodate.sql

prompt "Aplicando src/gascaribe/facturacion/api/adm_person.api_generaestadocuentaxfecha.sql"
@src/gascaribe/facturacion/api/adm_person.api_generaestadocuentaxfecha.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.api_generaestadocuentaxfecha.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.api_generaestadocuentaxfecha.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/obtenervalorinstancia.sql"
@src/gascaribe/objetos-producto/sinonimos/obtenervalorinstancia.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_entity_attributes.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_entity_attributes.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_obtenervalorinstancia.sql"
@src/gascaribe/general/api/adm_person.api_obtenervalorinstancia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_obtenervalorinstancia.sql"
@src/gascaribe/general/sinonimos/adm_person.api_obtenervalorinstancia.sql

prompt "Aplicando src/gascaribe/datafix/OSF-1813_Insert_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-1813_Insert_homologacion_servicios.sql

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