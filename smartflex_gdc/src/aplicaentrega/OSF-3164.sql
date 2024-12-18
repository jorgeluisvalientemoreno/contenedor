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

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ld_parameter.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ld_parameter.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ld_parameter.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ld_parameter.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_sa_tab.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_sa_tab.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_sa_tab.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_sa_tab.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_sa_tab_mirror.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_sa_tab_mirror.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_sa_tab_mirror.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_sa_tab_mirror.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.ldc_pksatabmirror.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pksatabmirror.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.ldc_pksatabmirror.sql"
@src/gascaribe/general/paquetes/personalizaciones.ldc_pksatabmirror.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.ldc_pksatabmirror.sql"
@src/gascaribe/general/sinonimos/personalizaciones.ldc_pksatabmirror.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgiudsa_tab.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgiudsa_tab.sql

prompt "Aplicando src/gascaribe/general/trigger/personalizaciones.ldc_trgiudsa_tab.sql"
@src/gascaribe/general/trigger/personalizaciones.ldc_trgiudsa_tab.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/dbms_jobs/558973.sql"
@src/gascaribe/papelera-reciclaje/dbms_jobs/558973.sql

prompt "Aplicando src/gascaribe/general/schedules/job_actualiza_sa_tab.sql"
@src/gascaribe/general/schedules/job_actualiza_sa_tab.sql

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