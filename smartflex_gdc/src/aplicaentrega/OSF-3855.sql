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

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_movidife.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_movidife.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_movidife.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_movidife.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_diferido.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_diferido.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_diferido.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_diferido.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcproducto.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcproducto.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_sistema.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_sistema.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_sistema.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_sistema.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_perifact.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_perifact.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_perifact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_perifact.sql

prompt "Aplicando src/gascaribe/datafix/OSF_3855_InsertHomologacionServicios.sql"
@src/gascaribe/datafix/OSF_3855_InsertHomologacionServicios.sql

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