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

prompt "Aplicando src/gascaribe/general/sinonimos/seq_ge_process_schedule.sql"
@src/gascaribe/general/sinonimos/seq_ge_process_schedule.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_sa_tab.sql"
@src/gascaribe/general/sinonimos/seq_sa_tab.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_gestionarchivos.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_gestionarchivos.sql

prompt "Aplicando src/gascaribe/Permisos/adm_person_permisos_java.sql"
@src/gascaribe/Permisos/adm_person_permisos_java.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_boutilidades.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_boutilidades.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_boutilidades.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_boutilidades.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_boutilidades.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_boutilidades.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_gestionsecuencias.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_gestionsecuencias.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_generapaqueten1.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_generapaqueten1.sql

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