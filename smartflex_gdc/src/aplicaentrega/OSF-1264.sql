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

--borrar sinonimos de personalizaciones a open
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/personalizaciones.os_assign_order.sql"
@src/gascaribe/objetos-producto/sinonimos/personalizaciones.os_assign_order.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/personalizaciones.os_legalizeorders.sql"
@src/gascaribe/objetos-producto/sinonimos/personalizaciones.os_legalizeorders.sql

--revokar permisos
prompt "Aplicando src/gascaribe/gestion-ordenes/api/personalizaciones.api_assignorder.sql"
@src/gascaribe/gestion-ordenes/api/personalizaciones.api_assignorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/personalizaciones.api_legalizeorder.sql"
@src/gascaribe/gestion-ordenes/api/personalizaciones.api_legalizeorder.sql

--crear sinonimos a adm_person

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/adm_person.os_assign_order.sql"
@src/gascaribe/objetos-producto/sinonimos/adm_person.os_assign_order.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/adm_person.os_legalizeorders.sql"
@src/gascaribe/objetos-producto/sinonimos/adm_person.os_legalizeorders.sql

--crear paquete de errores
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/errors.sql"
@src/gascaribe/objetos-producto/sinonimos/errors.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ex.sql"
@src/gascaribe/objetos-producto/sinonimos/ex.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_boerrors.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_boerrors.sql




prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_error.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_error.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_error.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_error.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkg_error.sql"
@src/gascaribe/general/sinonimos/pkg_error.sql





--crear nuevo api
prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_assign_order.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_assign_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_legalizeorders.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_legalizeorders.sql


--crear sinonimos

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/api_assign_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/api_assign_order.sql


prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/api_legalizeorders.sql"
@src/gascaribe/gestion-ordenes/sinonimos/api_legalizeorders.sql


prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_pkgestionordenes.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkgestionordenes.sql







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