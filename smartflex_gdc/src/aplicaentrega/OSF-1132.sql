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

prompt "Aplicando src/gascaribe/general/tablas/personalizaciones.estaproc.sql"
@src/gascaribe/general/tablas/personalizaciones.estaproc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.estaproc.sql"
@src/gascaribe/general/sinonimos/personalizaciones.estaproc.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_estaproc.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_estaproc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_estaproc.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_estaproc.sql

prompt "Aplicando src/gascaribe/general/sql/personalizaciones.idx_con01estaproc.sql"
@src/gascaribe/general/sql/personalizaciones.idx_con01estaproc.sql

prompt "Aplicando src/gascaribe/general/sql/personalizaciones.idx_con02estaproc.sql"
@src/gascaribe/general/sql/personalizaciones.idx_con02estaproc.sql

prompt "Aplicando src/gascaribe/general/sql/personalizaciones.idx_con03estaproc.sql"
@src/gascaribe/general/sql/personalizaciones.idx_con03estaproc.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_addordercomment.sql"
@src/gascaribe/objetos-producto/sinonimos/os_addordercomment.sql

prompt "Aplicando src/gascaribe/objetos-producto/procedimientos/os_addordercomment.sql"
@src/gascaribe/objetos-producto/procedimientos/os_addordercomment.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_addordercomment.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_addordercomment.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_addordercomment.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_addordercomment.sql

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