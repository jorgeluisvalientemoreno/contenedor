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

prompt "Aplicando src/gascaribe/facturacion/tablas/clientes_estacionales.sql"
@src/gascaribe/facturacion/tablas/clientes_estacionales.sql

prompt "Aplicando src/gascaribe/facturacion/fwcea/clientes_estacionales.sql"
@src/gascaribe/facturacion/fwcea/clientes_estacionales.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_clienteestacional.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_clienteestacional.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_clientes_estacionales.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_clientes_estacionales.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_clientes_estacionales.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_clientes_estacionales.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boclientesestacionales.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boclientesestacionales.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/pkg_clientesestacionales.sql"
@src/gascaribe/facturacion/paquetes/pkg_clientesestacionales.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121764.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121764.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121768.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121768.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121769.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121769.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121771.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121771.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121773.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121773.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121774.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121774.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121795.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121795.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121796.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121796.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121797.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121797.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121798.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121798.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121800.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121800.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121802.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121802.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100311.sql"
@src/gascaribe/tramites/ps_package_type_100311.sql

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