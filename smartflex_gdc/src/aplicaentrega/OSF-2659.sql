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

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boreservarordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boreservarordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boreservarordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boreservarordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/pkg_uildroe.sql"
@src/gascaribe/gestion-ordenes/paquetes/pkg_uildroe.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcpb/LDROE.sql"
@src/gascaribe/gestion-ordenes/fwcpb/LDROE.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.fnugetorderfinished.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.fnugetorderfinished.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/reverseexecuteorder.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/reverseexecuteorder.sql

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