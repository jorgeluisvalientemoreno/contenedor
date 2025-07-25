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

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.pkg_bcgestion_ventasfnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.pkg_bcgestion_ventasfnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.pkg_bcgestion_ventasfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.pkg_bcgestion_ventasfnb.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/personalizaciones.pkg_bocptcb.sql"
@src/gascaribe/fnb/paquetes/personalizaciones.pkg_bocptcb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/personalizaciones.pkg_bocptcb.sql"
@src/gascaribe/fnb/sinonimos/personalizaciones.pkg_bocptcb.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/pkg_uicptcb.sql"
@src/gascaribe/fnb/paquetes/pkg_uicptcb.sql

prompt "Aplicando src/gascaribe/fnb/fwcob/ge_object_121801.sql"
@src/gascaribe/fnb/fwcob/ge_object_121801.sql

prompt "Aplicando src/gascaribe/fnb/fwcpb/cptcb.sql"
@src/gascaribe/fnb/fwcpb/cptcb.sql

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