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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_boinstancecontrol.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_boinstancecontrol.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ed_confexme.sql"
@src/gascaribe/objetos-producto/sinonimos/ed_confexme.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ed_formato.sql"
@src/gascaribe/objetos-producto/sinonimos/ed_formato.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/id_bogeneralprinting.sql"
@src/gascaribe/objetos-producto/sinonimos/id_bogeneralprinting.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkbced_confexme.sql"
@src/gascaribe/objetos-producto/sinonimos/pkbced_confexme.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkbodataextractor.sql"
@src/gascaribe/objetos-producto/sinonimos/pkbodataextractor.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkboinsertmgr.sql"
@src/gascaribe/objetos-producto/sinonimos/pkboinsertmgr.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pktbled_confexme.sql"
@src/gascaribe/objetos-producto/sinonimos/pktbled_confexme.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_boimpresion_facturas.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_boimpresion_facturas.sql

prompt "Aplicando src/gascaribe/facturacion/permisos/adm_person.pkg_boimpresion_facturas.sql"
@src/gascaribe/facturacion/permisos/adm_person.pkg_boimpresion_facturas.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_boimpresion_facturas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_boimpresion_facturas.sql

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