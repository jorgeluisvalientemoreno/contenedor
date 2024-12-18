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

prompt "Aplicando src/gascaribe/Permisos/personalizaciones.tstringtable.sql"
@src/gascaribe/Permisos/personalizaciones.tstringtable.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.tstringtable.sql"
@src/gascaribe/general/sinonimos/adm_person.tstringtable.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bogestioncorreo.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bogestioncorreo.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_correo.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_correo.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bogestioncorreo.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestioncorreo.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_correo.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_correo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bogestioncorreo.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestioncorreo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_correo.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_correo.sql

prompt "Aplicando src/gascaribe/Permisos/adm_person.pkg_correo.sql"
@src/gascaribe/Permisos/adm_person.pkg_correo.sql

prompt "Aplicando src/gascaribe/Permisos/adm_person.pkg_bogestioncorreo.sql"
@src/gascaribe/Permisos/adm_person.pkg_bogestioncorreo.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/adm_person.pkg_correo.sql"
@src/gascaribe/general/homologacion_servicios/adm_person.pkg_correo.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

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